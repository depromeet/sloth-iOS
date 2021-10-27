//
//  SlothTextFieldInputFormViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/24.
//

import Combine
import Foundation

class SlothTextFieldInputFormViewModel {
 
    private let viewMeta: SlothInputFormViewMeta
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    @Published var isValidate: Bool = false
    let input: PassthroughSubject<String?, Never> = .init()
    var title: String {
        return viewMeta.title
    }
    var placeholder: String? {
        return viewMeta.placeholder
    }
    
    init(viewMeta: SlothInputFormViewMeta) {
        self.viewMeta = viewMeta
        
        bind()
    }
    
    func bind() {
        input
            .sink { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.isValidate = self.validate($0)
            }
            .store(in: &anyCancellables)
    }
    
    func validate(_ input: String?) -> Bool { return true }
}
class SlothNameInputFormViewModel: SlothTextFieldInputFormViewModel {
    
}

class SlothNumberOfLessonsInputFormViewModel: SlothTextFieldInputFormViewModel {
    

}
