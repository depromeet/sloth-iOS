//
//  SelectSiteRepository.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/30.
//

import Combine
import Foundation
import SlothNetworkModule

final class SelectSiteRepository: SlothPickerRepository {
    
    func retrieveList() -> AnyPublisher<[IdNamePairType], NetworkError> {
        let publisher = PassthroughSubject<[IdNamePairType], NetworkError>()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            publisher.send([
                LessonCateogry(id: 1, name: "패스트캠퍼스"),
                LessonCateogry(id: 2, name: "인프런"),
                LessonCateogry(id: 3, name: "클래스101"),
                LessonCateogry(id: 4, name: "탈잉"),
                LessonCateogry(id: 5, name: "해커스"),
                LessonCateogry(id: 6, name: "파고다"),
                LessonCateogry(id: 7, name: "직접 입력")
            ])
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
