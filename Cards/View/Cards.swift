//
//  Cards.swift
//  Cards
//
//  Created by Apple M1 on 29.04.2023.
//

import UIKit

protocol FlippableView: UIView {
    var isFlipped: Bool { get set }
    var flipCompletionHandler: ((FlippableView) -> Void)? { get set }
    func flip()
}

class CardView<ShapeType: ShapeLayerProtocol>: UIView, FlippableView {
    var isFlipped: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    var flipCompletionHandler: ((FlippableView) -> Void)?
    
    func flip() {
        // определяем, между какими представлениями осуществить переход
        let fromView = isFlipped ? frontSideView : backSideView
        let toView = isFlipped ? backSideView : frontSideView
        
        // запускаем анимированный переход
        UIView.transition(from: fromView, to: toView, duration: 0.75, options: [.transitionFlipFromTop], completion: { _ in
            // обработчик переворота
            self.flipCompletionHandler?(self)
        })
        
        isFlipped.toggle()
    }
    
    // цвет фигуры
    var color: UIColor!
    // границы карточки (радиус закругления)
    var cornerRadius = 20
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.color = color
        
        setupBorders()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // внутренний отступ представления
    private let margin: Int = 10
    
    // представление с лицевой стороны карты
    lazy var frontSideView: UIView = self.getFrontSideView()
    // представление с обратной стороной карты
    lazy var backSideView: UIView = self.getBackSideView()
    
    // возвращает представление для лицевой стороны карточки
    private func getFrontSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        let shapeView = UIView(frame: CGRect(x: margin, y: margin, width: Int(self.bounds.width)-margin*2, height: Int(self.bounds.height)-margin*2))
        view.addSubview(shapeView)
        
        // создание слоя с фигурой
        let shapeLayer = ShapeType(size: shapeView.frame.size, fillColor: color.cgColor)
        shapeView.layer.addSublayer(shapeLayer)
        
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    // возвращает вью для обратной стороны
    private func getBackSideView() -> UIView {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .white
        
        // выбор случайного узора для рубашки
        switch ["circle", "line"].randomElement()! {
        case "circle":
            let layer = BackSideCircle(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        case "line":
            let layer = BackSideLine(size: self.bounds.size, fillColor: UIColor.black.cgColor)
            view.layer.addSublayer(layer)
        default:
            break
        }
        
        // скругляем углы корневого слоя
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CGFloat(cornerRadius)
        
        return view
    }
    
    override func draw(_ rect: CGRect) {
        // удаляем добавленные ранее дочерние представления
        backSideView.removeFromSuperview()
        frontSideView.removeFromSuperview()
        
        // добавляем новые представления
        if isFlipped {
            self.addSubview(backSideView)
            self.addSubview(frontSideView)
        } else {
            self.addSubview(frontSideView)
            self.addSubview(backSideView)
        }
    }
    
    // настойка границ
    private func setupBorders() {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    // точка привязки
    private var myAnchorPoint: CGPoint = CGPoint(x: 50, y: 50)
    private var startTouchPoint: CGPoint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myAnchorPoint.x = touches.first!.location(in: window).x - frame.minX
        myAnchorPoint.y = touches.first!.location(in: window).y - frame.minY
        
        // сохраняем исходные координаты
        startTouchPoint = frame.origin
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchesLocationX = touches.first!.location(in: window).x - myAnchorPoint.x
        let touchesLocationY = touches.first!.location(in: window).y - myAnchorPoint.y
        
        let minX = self.bounds.minX
        let minY = self.bounds.minY
        let maxX = self.superview!.bounds.maxX - self.bounds.maxX
        let maxY = self.superview!.bounds.maxY - self.bounds.maxY
        
        if touchesLocationX > minX && touchesLocationY > minY && touchesLocationX < maxX && touchesLocationY < maxY {
            self.frame.origin.x = touchesLocationX
            self.frame.origin.y = touchesLocationY
        }
    } 
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.frame.origin == startTouchPoint {
            flip()
        }
    }
}
