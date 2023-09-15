//
//  MGTargetType.swift
//  
//
//  Created by sheng on 2023/9/15.
//

import Foundation

public protocol MGTargetType{
    var url: String { get }

    var path: String { get }

    var method: Method { get }

    var headers: Headers { get }
    
    var task: MGTask { get }
}
