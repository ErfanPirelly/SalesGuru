//
//  NewNetworkCore.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/21/23.
//

import FirebaseDatabase
import FirebaseStorage

enum FirebaseDatabase: String {
    case client = "https://pirelly-client-request.firebaseio.com"
    case user = "https://pirelly-users.firebaseio.com"
    case support = "https://pirelly-support.firebaseio.com"
    case aiModels = "https://pirelly-ai-models.firebaseio.com"
    case db = "https://pirelly360-default-rtdb.firebaseio.com"
    case centerAuth = "https://drivee-central-auth.firebaseio.com/"

    var databaseReference: DatabaseReference {
        return Database.database(url: self.rawValue).reference()
    }
}


enum FirebaseStorage: String {
    case model = "gs://model-processing"
    case videoTour = "gs://video-tour-input"
    case iframe = "gs://public-iframe"
    case test = "gs://pirelly360.appspot.com"
    case modelTest = "gs://test-model-preccessing"
    
    var storageReference: StorageReference {
        return Storage.storage(url: self.rawValue).reference()
    }
}

final class NetworkCore: NSObject {
    // MARK: - properties
    let database: FirebaseDatabase
    var databaseRef: DatabaseReference {
        return database.databaseReference
    }
    
    // MARK: - init
    init(database: FirebaseDatabase) {
        self.database = database
    }
}


// MARK: - Methods
extension NetworkCore {
    // MARK: - set Observer
    /// - Note: - Use this when you want to Read or observe a child
    func observe<T: FirebaseParser>(_ dump: T, childPath: String, callback: @escaping ((Result<T.T, Error>) -> Void)) {
        //        let referenceDate = Date()
        Logger.log(.info, "start observing \(childPath)")
        databaseRef.child(childPath).observe(.value) { data in
            dump.parseData(data: data.value) { result in
                self.stopObserving(childPath: childPath)
                switch result {
                case .success(let data):
                    callback(.success(data))
                case .failure(let error):
                    Logger.log(.error, "data error", childPath, error)
                    callback(.failure(error))
                }
            }
        }
    }
    
    /// - Note: - Use this when you want to Read or observe a child
    func addObserver<T: FirebaseParser>(_ dump: T, childPath: String, callback: @escaping ((Result<T.T, Error>) -> Void)) {
        var currentRetryCount = 3
        func observeData() {
               databaseRef.child(childPath).observe(.value) { [weak self] data in
                   dump.parseData(data: data.value) { result in
                       switch result {
                       case .success(let data):
                           callback(.success(data))
                       case .failure(let error):
                           Logger.log(.error, "data error", childPath, error)
                           
                           // Retry logic
                           if currentRetryCount > 0 {
                               Logger.log(.info, "Retrying \(currentRetryCount) more times...")
                               currentRetryCount -= 1
                               // Recursive call
                               observeData()
                           } else {
                               // No more retries, propagate the error
                               callback(.failure(error))
                           }
                       }
                   }
               }
           }
        
        observeData()
    }
    // MARK: - set value
    /// - Note data must be
    /// NSString
    /// NSNumber
    /// NSDictionary
    /// NSArray
    /// prequest/model/init/uid
    /// + /pushID
    func setValueAndObserve<T: FirebaseParser>(_ dump: T, for path: String, data: Any, callback: @escaping ((Result<T.T, Error>) -> Void)) {
        Logger.log(.info, "clicked for \(path)")
        guard let pushID = databaseRef.child(path).childByAutoId().key else { return }
        Logger.log(.info, "recieved key for \(path)")
        
        let childPath = path+"/\(pushID)"
        databaseRef.child(childPath).setValue(data) { error, _ in
            Logger.log(.info, "value did set for \(path)")
            if error == nil {
                self.observe(dump, childPath: childPath, callback: callback)
            } else {
                Logger.log(.error, "data error", childPath, error)
                callback(.failure(CustomError(description: error!.localizedDescription + childPath)))
            }
        }
    }
    
    func setValue(for path: String, data: Any, callback: @escaping ((Result<Bool, Error>) -> Void)) {
        databaseRef.child(path).setValue(data) { error, _ in
            if error == nil {
                callback(.success(true))
            } else {
                Logger.log(.error, "data error", path, error)
                callback(.failure(CustomError(description: error!.localizedDescription + "  " + path)))
            }
        }
    }
    // MARK: - Remove all Observers
    func stopObserving(childPath: String) {
        databaseRef.child(childPath).removeAllObservers()
    }
}

// MARK: - query
extension NetworkCore {
    /// - Note: - Use this when you want to Read or observe a child
    func query<T: FirebaseParser>(_ dump: T, refrence: DatabaseQuery, callback: @escaping ((Result<T.T, Error>) -> Void)) {
        //        let referenceDate = Date()
        refrence.observeSingleEvent(of: .value) { snapshot in
            guard let dataSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                callback(.failure(CustomError(description: "no data sbapshot")))
                snapshot.ref.removeAllObservers()
                return
            }
            dump.parseData(data: snapshot.value, callback: callback)
        }
    }
}
