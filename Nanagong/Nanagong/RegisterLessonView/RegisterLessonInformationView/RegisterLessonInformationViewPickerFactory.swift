//
//  RegisterLessonInformationViewPickerFactory.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/01.
//

import UIKit

final class RegisterLessonInformationViewPickerFactory {
    
    private unowned var parentViewModel: RegisterLessionInformationViewModel
    private let appDependancyContainer: SlothAppDependencyContainer
    
    init(appDependancyContainer: SlothAppDependencyContainer, parentViewModel: RegisterLessionInformationViewModel) {
        self.appDependancyContainer = appDependancyContainer
        self.parentViewModel = parentViewModel
    }
    
    func makeSelectCategoryViewController(prevSelected: IdNamePairType?) -> SlothPickerViewController {
        let pickerViewController = makeSlothPickerViewDependencyContainer().makeSelectCategoryViewController(prevSelected: prevSelected)
        pickerViewController.modalPresentationStyle = .custom
        pickerViewController.transitioningDelegate = pickerViewController
        
        return pickerViewController
    }
    
    func makeSelectSiteyViewController(prevSelected: IdNamePairType?) -> SlothPickerViewController {
        let pickerViewController = makeSlothPickerViewDependencyContainer().makeSelectSiteViewController(prevSelected: prevSelected)
        pickerViewController.modalPresentationStyle = .custom
        pickerViewController.transitioningDelegate = pickerViewController
        
        return pickerViewController
    }
    
    private func makeSlothPickerViewDependencyContainer() -> SlothPickerViewDependencyContainer {
        return SlothPickerViewDependencyContainer(appDependencyContainer: appDependancyContainer, parentViewModel: parentViewModel)
    }
}
