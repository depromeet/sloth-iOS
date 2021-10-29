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
    let inputSelected: AnyPublisher<IdNamePairType, Never>
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    var title: String {
        return viewMeta.title
    }
    
    var placeholder: String? {
        return viewMeta.placeholder
    }
    
    init(viewMeta: SlothInputFormViewMeta, inputSelected: AnyPublisher<IdNamePairType, Never>) {
        self.viewMeta = viewMeta
        self.inputSelected = inputSelected
    }
}

class SlothCategoryInputFormViewModel: SlothSelectBoxInputFormViewModel {
    
}

class SlothSiteInputFormViewModel: SlothSelectBoxInputFormViewModel {
    
}
