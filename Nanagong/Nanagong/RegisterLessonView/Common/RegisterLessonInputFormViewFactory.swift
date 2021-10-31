//
//  RegisterLessonInputFormViewFactory.swift
//  Nanagong
//
//  Created by Olaf on 2021/11/01.
//

import UIKit

protocol RegisterLessonInputFormViewFactory {
    
    func makeInputFormView(with viewMeta: SlothInputFormViewMeta) -> UIView
}
