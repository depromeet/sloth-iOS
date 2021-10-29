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
            publisher.send((0..<10).map { return LessonCateogry(id: $0, name: "레슨 \($0)") })
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
