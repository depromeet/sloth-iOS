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
    
    private func makeSelectCategoryViewModel() -> SlothPickerViewModel {
        return SlothPickerViewModel()
    }
    
    private func makeSelectCategoryViewLayoutContainer() -> SlothPickerViewLayoutContainer {
        return SlothPickerViewLayoutContainer()
    }
}
