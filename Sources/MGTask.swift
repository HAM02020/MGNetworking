//
//  MGTask.swift
//  
//
//  Created by sheng on 2023/9/15.
//

import Foundation

public typealias UploadProgressCallback = (Double)->Void

public enum MGTask {
    case request(parameters:Parameters)
    case uploadMultipartFormData(multipartFormData: MultipartFormData, uploadProgress: UploadProgressCallback?)
}
