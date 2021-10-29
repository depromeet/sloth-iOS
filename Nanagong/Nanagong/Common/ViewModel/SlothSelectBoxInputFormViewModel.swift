//
//  SlothSelectBoxInputFormViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/26.
//

import Combine
import Foundation

class SlothSelectBoxInputFormViewModel {
 
    let tapped = PassthroughSubject<Void, Never>()
    let textFieldInput = PassthroughSubject<String?, Never>()
    @Published var isvalidate: Bool = false
    @Published var needsShowTextField: Bool = false
    
    private let viewMeta: SlothInputFormViewMeta
    let inputSelected: AnyPublisher<IdNamePairType?, Never>
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    var title: String {
        return viewMeta.title
    }
    
    var placeholder: String? {
        return viewMeta.placeholder
    }
    
    init(viewMeta: SlothInputFormViewMeta, inputSelected: AnyPublisher<IdNamePairType?, Never>) {
        self.viewMeta = viewMeta
        self.inputSelected = inputSelected
        
        bind()
    }
    
    func bind() {
        inputSelected
            .sink { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.needsShowTextField = self.isDirectInput($0?.name)
                
                if let name = $0?.name {
                    self.isvalidate = !self.isDirectInput(name)
                } else {
                    self.isvalidate = false
                }
            }.store(in: &anyCancellables)
        
        textFieldInput
            .sink { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.isvalidate = self.isTextFieldInputValid($0)
            }.store(in: &anyCancellables)
    }
    
    private func isDirectInput(_ input: String?) -> Bool {
        return input == "직접 입력"
    }
    
    private func isTextFieldInputValid(_ input: String?) -> Bool {
        return input?.isEmpty == false
    }
}

class SlothCategoryInputFormViewModel: SlothSelectBoxInputFormViewModel {
    
}

class SlothSiteInputFormViewModel: SlothSelectBoxInputFormViewModel {
    
}
