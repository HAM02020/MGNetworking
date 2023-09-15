//
//  AFManager.swift
//  
//
//  Created by sheng on 2023/9/15.
//

import Foundation
import Alamofire

protocol AFManagerProtrol: AnyObject{
    func request(url: String, path: String, parameters: Parameters, method: Method, headers: Headers) async -> Result<MGResponse, MGError>
    func uploadMultipartFormData(url: String, path: String, multipartFormData: MultipartFormData, method: Method, headers: Headers, uploadProgress: UploadProgressCallback?) async -> Result<MGResponse, MGError>
}

class AFManager: AFManagerProtrol{
    
    static let shared = AFManager()
    
    static let timeoutDuration: Double = 30.0
    
    func request(url: String, path: String, parameters: Parameters, method: Method,headers: Headers) async -> Result<MGResponse, MGError> {
        let result: Result<MGResponse,MGError> = await withCheckedContinuation({ continuation in
            Alamofire.AF
                .request(url + path,
                         method: method,
                         parameters: parameters,
                         headers: headers,
                         requestModifier: {$0.timeoutInterval = AFManager.timeoutDuration})
                .response {response in
                    let response = convertResponseToResult(response.response, data: response.data, error: response.error)
                    continuation.resume(returning: response)
                }
        })
        return result
    }
    
    func uploadMultipartFormData(url: String, path: String, multipartFormData: MultipartFormData, method: Method, headers: Headers, uploadProgress: UploadProgressCallback?) async -> Result<MGResponse, MGError> {
        let result: Result<MGResponse,MGError> = await withCheckedContinuation({ continuation in
            Alamofire.AF
                .upload(multipartFormData: multipartFormData,
                        to: url + path,
                        method: method,
                        headers: headers,
                        requestModifier: {$0.timeoutInterval = AFManager.timeoutDuration})
                .response {response in
                    let response = convertResponseToResult(response.response, data: response.data, error: response.error)
                    continuation.resume(returning: response)
                }
                .uploadProgress{ progress in
                    uploadProgress?(progress.fractionCompleted)
                }
            
        })
        return result
    }
    
    
    
}


fileprivate func convertResponseToResult(_ response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<MGResponse,MGError> {
    switch (response, data, error) {
    case let (.some(response), data, .none):
        let response = MGResponse(statusCode: response.statusCode, data: data ?? Data())
        return .success(response)
    case let (_, _, .some(error)):
        let error = MGError.system(error:error)
        return .failure(error)
    default:
        let error = MGError.unknown(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))
        return .failure(error)
    }
}

