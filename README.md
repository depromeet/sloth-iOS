# sloth-iOS 컨벤션


* View는 코드로만 작성한다.(Interface Builder 사용 금지)
* 변수 선언 순서
    * static 프로퍼티
    * view 프로퍼티
        * public
        * internal
        * private
    * 그냥 프로퍼티
        * public
        * internal
        * private

* 메소드 선언 순서
    * internal
    * private

* extension
    * DataSource, Delegate 등은 MARK 주석으로 표시한다.
    * Style
```swift
final class ViewController: UIViewController {
    
    private let slothView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.SlothView.backgroundColor
        
        return view 
    }()
    
    override func viewDidload() {
        super.viewDidload()
        
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        view.addSubview(slothView)
        
        NSLayoutConstraint.activce([
            slothView.leadingAnchor(equalTo: view.leadingAnchor, constant: Style.SlothView.margin.left),
            // ....
        ])
    }
}

// MARK: - Style
private extension ViewController {

    enum Style {
    
        enum SlothView {
        
            static let backgroundColor: UIColor = .red
            static let margin: UIEdgeInsets = .init(top: 6, left: 5, bottom: 6, right: 7)
        }
    }
}

```

* 미니멈 타겟: iOS 14
* 아키텍쳐: MVVM 그런데 DI Container를 곁들인
