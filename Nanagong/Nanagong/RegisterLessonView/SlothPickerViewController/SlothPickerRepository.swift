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

protocol SelectCategoryDataSourceType {
    
    func retrieveList() -> AnyPublisher<[LessonCateogry], NetworkError>
}

final class SelectCateogryRepository: SlothPickerRepository {

    private let dataSource: SelectCategoryDataSourceType
    
    init(dataSource: SelectCategoryDataSourceType) {
        self.dataSource = dataSource
    }
    
    func retrieveList() -> AnyPublisher<[IdNamePairType], NetworkError> {
        return dataSource.retrieveList()
            .tryMap { $0 }
            .mapError {
                if let error = $0 as? NetworkError {
                    return error
                } else {
                    return NetworkError.unknownError(error: $0)
                }
            }.eraseToAnyPublisher()
    }
}

final class SelectCategoryDataSource: SelectCategoryDataSourceType {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func retrieveList() -> AnyPublisher<[LessonCateogry], NetworkError> {
        return networkManager.dataTaskPublisher(for: EndPoint.init(urlInformation: .categoryList).url,
                                                   httpMethod: .get,
                                                   httpHeaders: [:])
            .decode(type: [LessonCateogry].self, decoder: JSONDecoder())
            .mapError({ error -> NetworkError in
                if let error = error as? NetworkError {
                    return error
                } else {
                    return .unknownError(error: error)
                }
            })
            .eraseToAnyPublisher()
    }
}

final class SelectCateogryLocalDataSource: SelectCategoryDataSourceType {

    func retrieveList() -> AnyPublisher<[LessonCateogry], NetworkError> {
        let publisher = PassthroughSubject<[LessonCateogry], NetworkError>()

        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            publisher.send(
                [
                    LessonCateogry(id: 7, name: "??????"),
                    LessonCateogry(id: 8, name: "?????????"),
                    LessonCateogry(id: 9, name: "?????????"),
                    LessonCateogry(id: 10, name: "?????????"),
                    LessonCateogry(id: 11, name: "?????? ?????????"),
                    LessonCateogry(id: 12, name: "????????????"),
                    LessonCateogry(id: 13, name: "?????????"),
                    LessonCateogry(id: 14, name: "??????"),
                    LessonCateogry(id: 15, name: "??????"),
                    LessonCateogry(id: 16, name: "?????????"),
                    LessonCateogry(id: 17, name: "???????????? ?????????"),
                    LessonCateogry(id: 18, name: "?????? ??????")
                ]
            )
        }

        return publisher.eraseToAnyPublisher()
    }
}
