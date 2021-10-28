//
//  SlothPickerViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/29.
//

import Combine
import Foundation

final class SlothPickerViewModel {
    
    private let networkManager: NetworkManager
    var currentIndex: Int? = nil
    @Published var list: [IdNamePairType] = .init()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func retrieveList() {
        list = (0..<10).map { return LessonCateogry(id: $0, name: "레슨 \($0)") }
    }
    
    @objc
    func confirmButtonTapped() {
        guard let currentIndex = currentIndex else {
            return
        }

        print(list[currentIndex])
    }
}
