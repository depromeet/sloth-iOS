//
//  SlothPickerViewController.swift
//  Nanagong
//
//  Created by Olaf on 2021/10/29.
//

import SlothDesignSystemModule
import UIKit

final class SlothPickerViewController: UIViewController {
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    private let confirmButton: SlothButton = {
        let button = SlothButton(buttonStyle: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let viewModel: SlothPickerViewModel
    private let layoutContainer: SlothPickerViewLayoutContainer
    
    init(viewModel: SlothPickerViewModel,
         layoutContainer: SlothPickerViewLayoutContainer) {
        self.viewModel = viewModel
        self.layoutContainer = layoutContainer
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
