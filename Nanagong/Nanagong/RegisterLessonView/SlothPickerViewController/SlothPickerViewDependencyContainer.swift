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
                                         layoutContainer: makeSlothPickerViewLayoutContainer())
    }
    
    func makeSelectSiteViewController(prevSelected: IdNamePairType?) -> SlothPickerViewController {
        let viewModel = makeSelectSiteViewModel(prevSelected: prevSelected)
        
//        parentViewModel.categoryDidSelected(viewModel.selectedItem.eraseToAnyPublisher())
        
        return SlothPickerViewController(viewModel: viewModel,
                                         layoutContainer: makeSlothPickerViewLayoutContainer())
    }
    
    private func makeSelectCategoryViewModel(prevSelected: IdNamePairType?) -> SlothPickerViewModel {
        return SlothPickerViewModel(slothPickerRepository: SelectCateogryLocalRepository(), prevSelected: prevSelected)
    }
    
    private func makeSelectSiteViewModel(prevSelected: IdNamePairType?) -> SlothPickerViewModel {
        return SlothPickerViewModel(slothPickerRepository: SelectSiteRepository(), prevSelected: prevSelected)
    }
    
    private func makeSlothPickerViewLayoutContainer() -> SlothPickerViewLayoutContainer {
        return SlothPickerViewLayoutContainer()
    }
}
