//
//  FileManagerService.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/7/23.
//

import UIKit

class FileManagerService {
    // MARK: - shared singleton
    static let shared = FileManagerService()
    let manager = FileManager.default
    
    // MARK: - properties
    var directoryURL: URL?
    var uploadDirectoryURL: URL? {
        appDirecrory
    }
    private var documentDirectory: URL? {
        manager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    var appDirecrory: URL? {
        documentDirectory?.appendingPathComponent("salesGuru")
    }
    // MARK: - init
    private init() {
        initialize()
    }
    
    func initialize() {
        guard let documentURL = documentDirectory else {
            //TODO: - handle error
            return }
        directoryURL = documentURL.appendingPathComponent("AddProject")
        
//         Create the subdirectory if it does not exist
        try? manager.createDirectory(at: directoryURL!, withIntermediateDirectories: true, attributes: nil)
        try? manager.createDirectory(at: appDirecrory!, withIntermediateDirectories: true, attributes: nil)
        try? manager.createDirectory(at: uploadDirectoryURL!, withIntermediateDirectories: true, attributes: nil)
        deleteAllFiles()
    }
    
    /// delete all files
    /// 1. delete project
    /// 2. on finished project
    func deleteAllFiles() {
        guard let directoryURL = directoryURL else {
            //TODO: - handle error
            return
        }
        let urls = try? manager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
        try? manager.removeItem(at: manager.temporaryDirectory)
        
        for url in urls ?? []{
            // Remove all files from the subdirectory
            try? manager.removeItem(at: url)
        }
    }
    
    func deleteAppFiles() {
        guard let directoryURL = appDirecrory else {
            //TODO: - handle error
            return
        }
        let urls = try? manager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
        
        for url in urls ?? []{
            // Remove all files from the subdirectory
            try? manager.removeItem(at: url)
        }
    }

    func generateTempraryDirectory() -> URL?{
        let directoryURL = manager.temporaryDirectory
        let projectId = "drivee"
        let uniqueDirectoryName = UUID().uuidString
        let url = directoryURL.appendingPathComponent(projectId).appendingPathComponent(uniqueDirectoryName)
        do {
            try manager.createDirectory(at: url, withIntermediateDirectories: true)
        } catch {
            //TODO: - handle error
            print(error)
            return nil
        }
        
        return url
    }
    
    func clearTempDirectory() {
        let directoryURL = manager.temporaryDirectory
        let fileURLs = try? manager.contentsOfDirectory(at: directoryURL,
                                                       includingPropertiesForKeys: nil)
        // process files
        fileURLs?.forEach { url in
            try? self.manager.removeItem(at: url)
        }
    }
    
    // get data size
    func contentSize(for url: URL) -> String {
        do {
            let data = try Data(contentsOf: url)
            return Utils.byteSizeString(from: data)

        } catch {
            print("Error getting file attributes: \(error)")
        }
        
        return "Unknown Size"
    }
    
    // upload dire
    func generateUploadDirectory() -> URL?{
        guard let directoryURL = uploadDirectoryURL else {
            //TODO: - handle error
            return nil }
        let uniqueDirectoryName = UUID().uuidString
        let url = directoryURL.appendingPathComponent(uniqueDirectoryName)
        do {
            try manager.createDirectory(at: url, withIntermediateDirectories: true)
        } catch {
            //TODO: - handle error
            print(error)
            return nil
        }
        return url
    }
}

// MARK: - save images
extension FileManagerService {
    /// save image by:
    ///  1. in temporary directory
    ///  2. image name
    ///  3. actual image
    func saveTempImage(imageName: String, image: UIImage) -> URL? {
        guard let directoryURL = generateTempraryDirectory() else {
            //TODO: - handle error
            return nil
        }
        
        let fileName = imageName
        let fileURL = directoryURL.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.99) else {
            return nil
        }
        
        do {
            try data.write(to: fileURL, options: .atomic)
            print("saved a new pic \(fileURL.absoluteString)")
            
        } catch let error {
            print("error saving file with error", error)
            return nil
        }
        
        
        return fileURL
    }
}
