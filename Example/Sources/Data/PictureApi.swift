//
//  PictureApi.swift
//  iOS Example
//
//  Created by sheng on 2023/9/15.
//

import Foundation
import MGNetworking

enum PictureApi{
    
    static let provider = MGProvider<Self>()
    case getPicture(pictureId: Int)
    case uploadPicture(multipartFormData: MultipartFormData, uploadProgress: UploadProgressCallback?)
}

extension PictureApi: MGTargetType {
    
    var url: String{
        "http://someHost.com/api/v1"
    }
    
    var path: String{
        switch self{
        case .getPicture:
            return "/getPicture"
        case .uploadPicture:
            return "uploadPicture"
        }
    }
    
    var method: MGNetworking.Method {
        .post
    }
    
    var headers: MGNetworking.Headers {
        return ["timestamp": "\(Int(Date().timeIntervalSince1970 * 1000))"]
    }
    
    var task: MGNetworking.MGTask {
        switch self {
        case .getPicture(let pictureId):
            return .request(parameters: ["pictureId": pictureId])
        case .uploadPicture(let multipartFormData, let uploadProgress):
            return .uploadMultipartFormData(multipartFormData: multipartFormData, uploadProgress: uploadProgress)
        }
    }
    
    
}
