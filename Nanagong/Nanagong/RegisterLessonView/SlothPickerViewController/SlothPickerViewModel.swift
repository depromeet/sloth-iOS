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
    private var prevSelected: IdNamePairType?
    var currentIndex: Int = 0
    @Published var list: [IdNamePairType] = .init()
    let selectedItem: PassthroughSubject<IdNamePairType, Never> = .init()
    
    init(networkManager: NetworkManager, prevSelected: IdNamePairType?) {
        self.networkManager = networkManager
        self.prevSelected = prevSelected
    }
    
    func retrieveList() {
        list = (0..<10).map { return LessonCateogry(id: $0, name: "레슨 \($0)") }
        
        if let prevSelected = prevSelected,
           let prevIndex = list.firstIndex(where: { $0.id == prevSelected.id }) {
            currentIndex = prevIndex
        }
    }
    
    @objc
    func confirmButtonTapped() {
        selectedItem.send(list[currentIndex])
    }
}
