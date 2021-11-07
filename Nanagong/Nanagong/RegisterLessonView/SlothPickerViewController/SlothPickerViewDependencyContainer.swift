//
//  SlothPickerViewDependencyContainer.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/29.
//

import Foundation

final class SlothPickerViewDependencyContainer {
    
    private let appDependencyContainer: SlothAppDependencyContainer
    private let parentViewModel: RegisterLessionInformationViewModel
    
    init(appDependencyContainer: SlothAppDependencyContainer, parentViewModel: RegisterLessionInformationViewModel) {
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
        
        parentViewModel.siteDidSelected(viewModel.selectedItem.eraseToAnyPublisher())
        
        return SlothPickerViewController(viewModel: viewModel,
                                         layoutContainer: makeSlothPickerViewLayoutContainer())
    }
    
    private func makeSelectCategoryViewModel(prevSelected: IdNamePairType?) -> SlothPickerViewModel {
        return SlothPickerViewModel(slothPickerRepository: makeSelectCategoryRepository(), prevSelected: prevSelected)
    }
    
    private func makeSelectSiteViewModel(prevSelected: IdNamePairType?) -> SlothPickerViewModel {
        return SlothPickerViewModel(slothPickerRepository: makeSelectSiteRepository(), prevSelected: prevSelected)
    }
    
    private func makeSelectCategoryRepository() -> SelectCateogryRepository {
        return .init(dataSource: makeSelectCategoryDataSource())
    }
    
    private func makeSelectCategoryDataSource() -> SelectCategoryDataSourceType {
        return SelectCategoryDataSource(networkManager: appDependencyContainer.networkManager)
    }
    
    private func makeSelectSiteRepository() -> SelectSiteRepository {
        return .init(dataSource: makeSelectDataSource())
    }
    
    private func makeSelectDataSource() -> SelectSiteDataSourceType {
        return SelectSiteRemoteDataSource(networkManager: appDependencyContainer.networkManager)
    }
    
    private func makeSlothPickerViewLayoutContainer() -> SlothPickerViewLayoutContainer {
        return SlothPickerViewLayoutContainer()
    }
}
