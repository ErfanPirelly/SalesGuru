//
//  FirebaseReferencePaths.swift
//  Pirelly
//
//  Created by shndrs on 8/1/23.
//

import Foundation

// MARK: - Firebase Reference Paths

struct FRP {
    
    /// - Note: pCar Node
    static func getMyProjects() -> String {
        return "pCars/\(UserManager.shared.uid ?? "UID is Empty")"
    }
    static func profile() -> String {
        return "pRequests/users/\(UserManager.shared.uid ?? "")/signupInfo"
    }
    /// - Note: pModel Node
    static func getMyProjectDetails(modelId: String) -> String {
        return "pModels/\(UserManager.shared.uid ?? "UID is Empty")/\(modelId)/"
    }
//    static let getMyProjectDetails = "pModel/\(UserManager.shared.uid ?? "UID is Empty")"
    static let tutorial = "pTutorials/application"
    static let deleteProject = "pRequests/model/delete/"
}

// MARK: - Rest APIs Routes

struct RestRoutes {
    static let base = "https://us-central1-pirelly360.cloudfunctions.net/"
    static let onlineMessage = base + "user-message-handler"
    static let reportABugForm = base + "user-bug-report"
    static let reportABugUpload = base + "user-bug-report/"
    static let salesSupport = base + "pContacInfo/salesSupport"
    static let technichalSupport = base + "pContactInfo/technichalSupport"
    static let deleteGallery = base + "gallery-manager/delete/"
    static let addPhoto = base + "gallery-manager/create/"
    static let checkDuplicateVin = base + "car-validate"
    static let updateVinAndStock = base + "vin_stock_updater"
    static let createHotspot = base + "hss/v1/" + "bulk-operation/"
    static let projectFrames = base + "MMS-model-CRUD-API/" + "frames/"
    static let hotspots = base + "hss/v1/main/list/"
    static let setCreditToken = base + "pirelly_credit_token_manager"
    static let activeFreeTrial = base + "pirelly_credit_reserve_token"
    static let videoTour = base + "drivee_voice_agent_suggestion"
    static let paginateModel = base + "pModel_paginator"
}

// MARK: - functions
extension RestRoutes {
    static func galleryList() -> String {
        return base + "gallery-manager/list/\(UserManager.shared.uid ?? "UID is Empty")/"
    }
}
