//
//  Result+MGResponse.swift
//  
//
//  Created by sheng on 2023/9/15.
//

import Foundation


extension Result where Success == MGResponse {
    
    private func tryParseResultToModel<T: Decodable>() throws -> T {
        switch self{
        case .success(let response):
            return try response.parseDataToModel()
        case .failure(let error):
            throw error
        }
    }
    
}
