//
//  SlothPickerRepository.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/30.
//

import Combine
import Foundation
import SlothNetworkModule

protocol SlothPickerRepository {
    
    func retrieveList() -> AnyPublisher<[IdNamePairType], NetworkError>
}

final class SelectCateogryLocalRepository: SlothPickerRepository {
    
    func retrieveList() -> AnyPublisher<[IdNamePairType], NetworkError> {
        let publisher = PassthroughSubject<[IdNamePairType], NetworkError>()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            publisher.send(
                [
                    LessonCateogry(id: 7, name: "개발"),
                    LessonCateogry(id: 8, name: "디자인"),
                    LessonCateogry(id: 9, name: "데이터"),
                    LessonCateogry(id: 10, name: "외국어"),
                    LessonCateogry(id: 11, name: "금융 재태크"),
                    LessonCateogry(id: 12, name: "직무교육"),
                    LessonCateogry(id: 13, name: "드로잉"),
                    LessonCateogry(id: 14, name: "공예"),
                    LessonCateogry(id: 15, name: "음악"),
                    LessonCateogry(id: 16, name: "글쓰기"),
                    LessonCateogry(id: 17, name: "컨퍼런스 세미나"),
                    LessonCateogry(id: 18, name: "직접 입력")
                ]
            )
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
