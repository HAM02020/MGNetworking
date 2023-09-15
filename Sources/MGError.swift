//
//  MGError.swift
//  
//
//  Created by sheng on 2023/9/15.
//

import Foundation

public enum MGError{
    case json
    case system(error: Error)
    case unknown(error: Error)
}

extension MGError: LocalizedError {
    public var errorDescription: String?{
        switch self{
        case .json:
            return "JSON Parse Faild"
        case .system(error: let error):
            return error.asAFError?.errorDescription ?? error.localizedDescription
        case .unknown(error: let error):
            return error.localizedDescription
        }
    }
}
