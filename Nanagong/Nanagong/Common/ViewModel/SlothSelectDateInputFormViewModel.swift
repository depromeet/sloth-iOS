//
//  SlothSelectDateInputFormViewModel.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/06.
//

import Combine
import Foundation

final class SlothSelectDateInputFormViewModel {
    
    struct State {
        
        static let empty: Self = .init(tapped: UUID())
        
        var tapped: UUID
    }
    
    @Published var state: State = .empty
    
    let viewMeta: SlothInputFormViewMeta
    let dateSelected: AnyPublisher<Date, Never>
    var title: String {
        return viewMeta.title
    }
    var placeholder: String? {
        return viewMeta.placeholder
    }
    
    init(viewMeta: SlothInputFormViewMeta, dateSelected: AnyPublisher<Date, Never>) {
        self.viewMeta = viewMeta
        self.dateSelected = dateSelected
    }
    
    func selectBoxTapped() {
        self.state.tapped = .init()
    }
}
