//
//  MGProvicer.swift
//  
//
//  Created by sheng on 2023/9/15.
//

import Foundation

public protocol MGProviderProtocol {
    associatedtype Target
    
    func request(_ target: Target) async -> Result<MGResponse,MGError>
    
    init()
}

public class MGProvider<Target: MGTargetType>: MGProviderProtocol {
    
    public required init(){
        
    }
    
    @discardableResult
    public func request(_ target: Target) async -> Result<MGResponse, MGError> {
        let url = target.url
        let path = target.path
        let method = target.method
        let headers = target.headers
        let result: Result<MGResponse, MGError>
        
        switch target.task {
        case .request(let parameters):
            result = await AFManager.shared.request(url: url, path: path, parameters: parameters, method: method, headers: headers)
        case .uploadMultipartFormData(let multipartFormData, let uploadProgress):
            result = await AFManager.shared.uploadMultipartFormData(url: url, path: path, multipartFormData: multipartFormData, method: method, headers: headers, uploadProgress: uploadProgress)
        }
        return result
        
    }
    
}
