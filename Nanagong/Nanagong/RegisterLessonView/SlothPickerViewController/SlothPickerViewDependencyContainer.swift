//
//  SlothPickerViewDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/29.
//

import Foundation

final class SlothPickerViewDependencyContainer {
    
    private let appDependencyContainer: SlothAppDependencyContainer
    private let parentViewModel: RegisterLessionViewModel
    
    init(appDependencyContainer: SlothAppDependencyContainer, parentViewModel: RegisterLessionViewModel) {
        self.appDependencyContainer = appDependencyContainer
        self.parentViewModel = parentViewModel
    }
    
    func makeSelectCategoryViewController() -> SlothPickerViewController {
        let viewModel = makeSelectCategoryViewModel()
        
        parentViewModel.categoryDidSelected(viewModel.selectedItem.eraseToAnyPublisher())
        
        return SlothPickerViewController(viewModel: viewModel,
                                         layoutContainer: makeSelectCategoryViewLayoutContainer())
    }
    
    private func makeSelectCategoryViewModel() -> SlothPickerViewModel {
        return SlothPickerViewModel(networkManager: appDependencyContainer.networkManager)
    }
    
    private func makeSelectCategoryViewLayoutContainer() -> SlothPickerViewLayoutContainer {
        return SlothPickerViewLayoutContainer()
    }
}
