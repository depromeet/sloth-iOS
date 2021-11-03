//
//  LessonCategory.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/26.
//

import Foundation

struct LessonCateogry: Decodable, IdNamePairType {
    
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        
        case id = "categoryId"
        case name = "categoryName"
    }
}
