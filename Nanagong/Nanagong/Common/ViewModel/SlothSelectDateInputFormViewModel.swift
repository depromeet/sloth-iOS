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
        
        static let empty: Self = .init(tapped: UUID(), dateDelivered: false)
        
        var tapped: UUID
        var dateDelivered: Bool
    }
    
    @Published var state: State = .empty
    
    let viewMeta: SlothInputFormViewMeta
    let dateSelected: AnyPublisher<Date, Never>
    var title: String {
        return viewMeta.title
    }
    var placeholder: String? {
        return dateFormatter.string(from: Date())
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter
    }()
    
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    init(viewMeta: SlothInputFormViewMeta, dateSelected: AnyPublisher<Date, Never>) {
        self.viewMeta = viewMeta
        self.dateSelected = dateSelected
        
        bind()
    }
    
    func selectBoxTapped() {
        self.state.tapped = .init()
    }
    
    private func bind() {
        dateSelected
            .sink { [weak self] _ in
                self?.state.dateDelivered = true
            }.store(in: &anyCancellables)
    }
}
