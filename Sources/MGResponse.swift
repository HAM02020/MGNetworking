//
//  MGResponse.swift
//  
//
//  Created by sheng on 2023/9/15.
//

import Foundation

protocol MGResponseType {
    var statusCode: Int { get }
    var data: Data { get }
}

struct MGResponse: MGResponseType, CustomStringConvertible, Equatable{
    
    let statusCode: Int
    
    let data: Data
    
    public init(statusCode: Int, data: Data) {
        self.statusCode = statusCode
        self.data = data
    }
    
    public var description: String{
        "Status Code: \(statusCode), Data Length: \(data.count)"
    }
    
    public static func == (lhs: MGResponse, rhs: MGResponse) -> Bool {
        lhs.statusCode == rhs.statusCode
        && lhs.data == rhs.data
    }
    
}

extension MGResponse {
    
    func parseDataToModel<T: Decodable>() throws -> T {
        
        guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
            throw MGError.json
        }
        return decodeData
    }
}
