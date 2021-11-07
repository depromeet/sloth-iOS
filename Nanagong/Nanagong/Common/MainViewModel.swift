//
//  MainViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/07.
//

import Combine
import Foundation

final class MainViewModel {
    
    enum State {
        
        case signedOut
        
        case signedIn
    }
    
    @Published var state: State = .signedOut
    
    private let dependency: SlothAppDependencyContainer
    
    init(dependecy: SlothAppDependencyContainer) {
        self.dependency = dependecy
    }
}
