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
            var sample = (0..<10).map { return LessonCateogry(id: $0, name: "사이트 \($0)") }
            sample.append(.init(id: 10, name: "직접 입력"))
            publisher.send(sample)
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
