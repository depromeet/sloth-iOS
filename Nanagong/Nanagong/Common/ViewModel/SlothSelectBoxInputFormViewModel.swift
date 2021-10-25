//
//  SlothSelectBoxInputFormViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/26.
//

import Foundation

class SlothSelectBoxInputFormViewModel {
 
    private let viewMeta: SlothInputFormViewMeta
    
    var title: String {
        return viewMeta.title
    }
    
    var placeholder: String? {
        return viewMeta.placeholder
    }
    
    @Published var isValid: Bool = false
    
    init(viewMeta: SlothInputFormViewMeta) {
        self.viewMeta = viewMeta
    }
    
    func validate(_ input: LessonCateogry) {
        
    }
}

class SlothCheckCategoryViewModel: SlothSelectBoxInputFormViewModel {
    
    override func validate(_ input: LessonCateogry) {
        super.validate(input)
        
        isValid = true
    }
}

class SlothCheckSiteViewModel: SlothSelectBoxInputFormViewModel {
    
    override func validate(_ input: LessonCateogry) {
        super.validate(input)
        
        isValid = true
    }
}
