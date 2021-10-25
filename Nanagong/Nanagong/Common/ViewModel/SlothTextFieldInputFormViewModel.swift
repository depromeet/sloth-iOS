//
//  SlothTextFieldInputFormViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/24.
//

import Foundation

class SlothTextFieldInputFormViewModel {
 
    private let textInputType: InputType.Text
    
    private var viewMeta: SlothInputFormViewMeta {
        return textInputType.viewMeta
    }
    
    var title: String {
        return viewMeta.title
    }
    
    var placeholder: String? {
        return viewMeta.placeholder
    }
    
    @Published var isValid: Bool = false
    
    init(textInputType: InputType.Text) {
        self.textInputType = textInputType
    }
    
    func validate(_ input: String?) {
        
    }
}

class SlothCheckLessonNameViewModel: SlothTextFieldInputFormViewModel {
    
    override func validate(_ input: String?) {
        super.validate(input)
        
        isValid = true
    }
}

class SlothCheckNumberOfLessonsViewModel: SlothTextFieldInputFormViewModel {
    
    override func validate(_ input: String?) {
        super.validate(input)
        
        isValid = true
    }
}
