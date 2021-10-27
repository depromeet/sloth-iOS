//
//  SlothSelectBoxInputFormViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/26.
//

import Combine
import Foundation

class SlothSelectBoxInputFormViewModel {
 
    private let viewMeta: SlothInputFormViewMeta
    let tapped = PassthroughSubject<Void, Never>()
    
    var title: String {
        return viewMeta.title
    }
    
    var placeholder: String? {
        return viewMeta.placeholder
    }
    
    init(viewMeta: SlothInputFormViewMeta) {
        self.viewMeta = viewMeta
    }
}

class SlothCategoryInputFormViewModel: SlothSelectBoxInputFormViewModel {
    
}

class SlothSiteInputFormViewModel: SlothSelectBoxInputFormViewModel {
    
}
