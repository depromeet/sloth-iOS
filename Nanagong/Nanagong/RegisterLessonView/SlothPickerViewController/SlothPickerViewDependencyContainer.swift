//
//  SlothPickerViewDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/29.
//

import Foundation

final class SlothPickerViewDependencyContainer {
    
    private let appDependencyContainer: SlothAppDependencyContainer
    
    init(appDependencyContainer: SlothAppDependencyContainer) {
        self.appDependencyContainer = appDependencyContainer
    }
    
    func makeSelectCategoryViewController() -> SlothPickerViewController {
        return SlothPickerViewController(viewModel: makeSelectCategoryViewModel(),
                                         layoutContainer: makeSelectCategoryViewLayoutContainer())
    }
    
    private func makeSelectCategoryViewModel() -> SlothPickerViewModel {
        return SlothPickerViewModel(networkManager: appDependencyContainer.networkManager)
    }
    
    private func makeSelectCategoryViewLayoutContainer() -> SlothPickerViewLayoutContainer {
        return SlothPickerViewLayoutContainer()
    }
}
