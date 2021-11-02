//
//  LessonInformation.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/30.
//

import Foundation

struct LessonInformation {
    
    static let empty: Self = .init(lessonName: "", totalNumber: 0, categoryId: 0, siteId: 0, alertDays: nil, startDate: Date(), endDate: Date(), message: nil, price: 0)
    
    var lessonName: String
    var totalNumber: Int
    var categoryId: Int
    var categoryName: String?
    var siteId: Int
    var siteName: String?
    var alertDays: String?
    var startDate: Date
    var endDate: Date
    var message: String?
    var price: Int
}
