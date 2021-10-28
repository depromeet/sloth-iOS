//
//  SlothPickerViewDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/29.
//

import Foundation

final class SlothPickerViewDependencyContainer {
    
    func makeSelectCategoryViewController() -> SlothPickerViewController {
        return SlothPickerViewController(viewModel: makeSelectCategoryViewModel(),
                                         layoutContainer: makeSelectCategoryViewLayoutContainer())
    }
    
    func makeSelectCategoryViewModel() -> SlothPickerViewModel {
        return SlothPickerViewModel()
    }
    
    func makeSelectCategoryViewLayoutContainer() -> SlothPickerViewLayoutContainer {
        return SlothPickerViewLayoutContainer()
    }
}
