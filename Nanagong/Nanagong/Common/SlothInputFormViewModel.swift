//
//  SlothInputFormViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/24.
//

import Foundation

final class SlothInputFormViewModel {
 
    private let viewMeta: SlothInputFormViewMeta

    var inputType: InputType {
        return viewMeta.inputType
    }
    
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
