//
//  SlothTextFieldInputFormViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/24.
//

import Combine
import Foundation

class SlothTextFieldInputFormViewModel {
    
    struct State {
        
        static let empty: Self = .init()
        
        var input: String?
        var isValid: Bool = false
    }
    
    @Published var state: State = .empty
 
    private let viewMeta: SlothInputFormViewMeta
    private var anyCancellables: Set<AnyCancellable> = .init()
    
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
                
                self.state = .init(input: $0, isValid: self.validate($0))
            }
            .store(in: &anyCancellables)
    }
    
    func validate(_ input: String?) -> Bool { return true }
}
class SlothNameInputFormViewModel: SlothTextFieldInputFormViewModel {
    
    override func validate(_ input: String?) -> Bool {
        guard let input = input else {
            return false
        }
        
        return input.count > 6 && input.count < 12
    }
}

class SlothNumberOfLessonsInputFormViewModel: SlothTextFieldInputFormViewModel {
    
    override func validate(_ input: String?) -> Bool {
        guard let input = input else {
            return false
        }

        return Int(input) != nil
    }
}

class SlothPriceInputFormViewModel: SlothTextFieldInputFormViewModel {
    
    override func validate(_ input: String?) -> Bool {
        guard let input = input else {
            return false
        }

        return Int(input) != nil
    }
}

class SlothDeterminationInputFormViewModel: SlothTextFieldInputFormViewModel {
    
    override init(viewMeta: SlothInputFormViewMeta) {
        super.init(viewMeta: viewMeta)
        
        state.isValid = true
    }
    
    override func validate(_ input: String?) -> Bool {
        return true
    }
}
