//
//  SelectSiteRepository.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/30.
//

import Combine
import Foundation
import SlothNetworkModule

protocol SelectSiteDataSourceType {
    
    func retrieveList() -> AnyPublisher<[LessonSite], NetworkError>
}

final class SelectSiteRepository: SlothPickerRepository {
    
    private let dataSource: SelectSiteDataSourceType
    
    init(dataSource: SelectSiteDataSourceType) {
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

final class SelectSiteRemoteDataSource: SelectSiteDataSourceType {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func retrieveList() -> AnyPublisher<[LessonSite], NetworkError> {
        networkManager.dataTaskPublisher(for: EndPoint.init(urlInformation: .siteList).url,
                                            httpMethod: .get,
                                            httpHeaders: [:])
            .decode(type: [LessonSite].self, decoder: JSONDecoder())
            .mapError {
                if let error = $0 as? NetworkError {
                    return error
                } else {
                    return NetworkError.unknownError(error: $0)
                }
            }.eraseToAnyPublisher()
    }
}

final class SelectSiteLocalDataSource: SelectSiteDataSourceType {
    
    func retrieveList() -> AnyPublisher<[LessonSite], NetworkError> {
        let publisher = PassthroughSubject<[LessonSite], NetworkError>()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            publisher.send([
                LessonSite(id: 1, name: "??????????????????"),
                LessonSite(id: 2, name: "?????????"),
                LessonSite(id: 3, name: "?????????101"),
                LessonSite(id: 4, name: "??????"),
                LessonSite(id: 5, name: "?????????"),
                LessonSite(id: 6, name: "?????????"),
                LessonSite(id: 7, name: "?????? ??????")
            ])
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
