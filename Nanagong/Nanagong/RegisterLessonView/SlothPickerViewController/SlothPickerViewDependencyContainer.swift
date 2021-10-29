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
    
    func makeSelectCategoryViewController(prevSelected: IdNamePairType?) -> SlothPickerViewController {
        let viewModel = makeSelectCategoryViewModel(prevSelected: prevSelected)
        
        parentViewModel.categoryDidSelected(viewModel.selectedItem.eraseToAnyPublisher())
        
        return SlothPickerViewController(viewModel: viewModel,
                                         layoutContainer: makeSelectCategoryViewLayoutContainer())
    }
    
    private func makeSelectCategoryViewModel(prevSelected: IdNamePairType?) -> SlothPickerViewModel {
        return SlothPickerViewModel(networkManager: appDependencyContainer.networkManager, prevSelected: prevSelected)
    }
    
    private func makeSelectCategoryViewLayoutContainer() -> SlothPickerViewLayoutContainer {
        return SlothPickerViewLayoutContainer()
    }
}
