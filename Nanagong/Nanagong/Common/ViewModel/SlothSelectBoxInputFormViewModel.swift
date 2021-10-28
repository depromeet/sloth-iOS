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
    @Published var isvalidate: Bool = false
    
    private let viewMeta: SlothInputFormViewMeta
    private let inputSelected: AnyPublisher<String?, Never>
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    var title: String {
        return viewMeta.title
    }
    
    var placeholder: String? {
        return viewMeta.placeholder
    }
    
    init(viewMeta: SlothInputFormViewMeta, inputSelected: AnyPublisher<String?, Never>) {
        self.viewMeta = viewMeta
        self.inputSelected = inputSelected
        
        bind()
    }
    
    func bind() {
        inputSelected.sink { input in
            print(input)
        }.store(in: &anyCancellables)
    }
}

class SlothCategoryInputFormViewModel: SlothSelectBoxInputFormViewModel {
    
}

class SlothSiteInputFormViewModel: SlothSelectBoxInputFormViewModel {
    
}
