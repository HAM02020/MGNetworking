//
//  Result+MGResponse.swift
//  
//
//  Created by sheng on 2023/9/15.
//

import Foundation


public extension Result where Success == MGResponse {
    
    func tryParseResultToModel<T: Decodable>(model: T.Type? = nil) throws -> T {
        switch self{
        case .success(let response):
            return try response.parseDataToModel()
        case .failure(let error):
            throw error
        }
    }
    
}
