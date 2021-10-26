//
//  SlothSelectBoxInputFormViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/26.
//

import Foundation

class SlothSelectBoxInputFormViewModel {
 
    private let selectBoxInputType: InputType.SelectBox
    
    private var viewMeta: SlothInputFormViewMeta {
        return selectBoxInputType.viewMeta
    }
    
    var title: String {
        return viewMeta.title
    }
    
    var placeholder: String? {
        return viewMeta.placeholder
    }
    
    @Published var isValid: Bool = false
    
    init(selectBoxInputType: InputType.SelectBox) {
        self.selectBoxInputType = selectBoxInputType
    }
    
    func validate(_ input: IdNamePairType) {
        
    }
}

class SlothCheckCategoryViewModel: SlothSelectBoxInputFormViewModel {
    
    override func validate(_ input: IdNamePairType) {
        super.validate(input)
        
        isValid = true
    }
}

class SlothCheckSiteViewModel: SlothSelectBoxInputFormViewModel {
    
    override func validate(_ input: IdNamePairType) {
        super.validate(input)
        
        isValid = true
    }
}
