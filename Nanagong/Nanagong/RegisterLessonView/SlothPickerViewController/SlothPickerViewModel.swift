//
//  SlothPickerViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/29.
//

import Combine
import Foundation

final class SlothPickerViewModel {
    
    var currentIndex: Int = 0
    @Published var list: [IdNamePairType] = .init()
    let selectedItem: PassthroughSubject<IdNamePairType, Never> = .init()
    private let slothPickerRepository: SlothPickerRepository
    private var prevSelected: IdNamePairType?
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    init(slothPickerRepository: SlothPickerRepository, prevSelected: IdNamePairType?) {
        self.slothPickerRepository = slothPickerRepository
        self.prevSelected = prevSelected
    }
    
    func retrieveList() {
        slothPickerRepository.retrieveList()
            .sink { _ in
                
            } receiveValue: { [weak self] in
                self?.list = $0
                
                if let prevSelected = self?.prevSelected,
                   let prevIndex = self?.list.firstIndex(where: { $0.id == prevSelected.id }) {
                    self?.currentIndex = prevIndex
                }
            }.store(in: &anyCancellable)
    }
    
    @objc
    func confirmButtonTapped() {
        selectedItem.send(list[currentIndex])
    }
}
