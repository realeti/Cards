//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        // создаем кривые на сцене
        createBezier(on: view)
    }
    
    private func createBezier(on view: UIView) {
        // создаем графический контекст (слой), на нем в дальнейшем будут рисоваться кривые
        let shapeLayer = CAShapeLayer()
        
        // добавляем слой в качестве дочернего к корневому слою корневого представления
        view.layer.addSublayer(shapeLayer)
        
        // изменение цвета линий
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        // изменение толщины линий
        shapeLayer.lineWidth = 5
        
        // определение фонового цвета
        shapeLayer.fillColor = UIColor.systemGreen.cgColor
        //shapeLayer.fillColor = nil
        //shapeLayer.fillColor = UIColor.clear.cgColor
        
        // lineCap - оформление для крайних точек линий
        shapeLayer.lineCap = .round
        
        // lineJoin - стиль оформления соединительных точек
        shapeLayer.lineJoin = .round
        
        // прерывистые линии
        //shapeLayer.lineDashPattern = [5, 8, 12]
        //shapeLayer.lineDashPhase = 2
        
        // strokeStart и strokeEnd, по умолчанию значения длины строки от 0 (старт) до 1 (конец)
        //shapeLayer.strokeStart = 0.1
        //shapeLayer.strokeEnd = 0.8
        
        // создание фигуры
        //shapeLayer.path = getPath().cgPath.union(getPathRectAngle().cgPath).union(getPathArc().cgPath).union(getPathCircle().cgPath).union(getPathCurve().cgPath)
        //shapeLayer.path = getPathCurve().cgPath
        shapeLayer.path = getPathCookHat().cgPath
    }
    
    private func getPath() -> UIBezierPath {
        // создаем значение типа UIBezierPath, которое будет описывать фигуру, а точнее ее путь
        let path = UIBezierPath()
        
        // указатель перемещается в точку с координатами (250, 50) - создание первого треугольника
        path.move(to: CGPoint(x: 250, y: 50))
        
        // рисуется линия, которая начинается в точке (250, 50) и заканчивается в точке (350, 50)
        path.addLine(to: CGPoint(x: 350, y: 50))
        
        // создание второй линии
        path.addLine(to: CGPoint(x: 350, y: 150))
        
        // создание третьей линии - некорректно для завершения фигуры, треугольник будет иметь деффекты
        //path.addLine(to: CGPoint(x: 200, y: 50))
        path.close()
        
        // создание второго треугольника
        path.move(to: CGPoint(x: 250, y: 70))
        path.addLine(to: CGPoint(x: 350, y: 170))
        path.addLine(to: CGPoint(x: 250, y: 170))
        path.close()
        
        return path
    }
    
    private func getPathRectAngle() -> UIBezierPath {
        // создание сущности "Прямоугольник"
        let rect = CGRect(x: 10, y: 10, width: 200, height: 100)
        // создание прямоугольника
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomRight, .topLeft], cornerRadii: CGSize(width: 60, height: 0))
        
        return path
    }
    
    private func getPathArc() -> UIBezierPath {
        let centerPoint = CGPoint(x: 200, y: 140)
        let path = UIBezierPath(arcCenter: centerPoint, radius: 100, startAngle: .pi/5, endAngle: .pi, clockwise: true)
        
        // if need circle or UIBezierPath(ovalIn:)
        //let path = UIBezierPath(arcCenter: centerPoint, radius: 150, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        return path
    }
    
    private func getPathCircle() -> UIBezierPath {
        let rect = CGRect(x: 50, y: 250, width: 200, height: 100)
        let path = UIBezierPath(ovalIn: rect)
        
        return path
    }
    
    private func getPathCurve() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 200, y: 260))
        path.addCurve(to: CGPoint(x: 350, y: 260), controlPoint1: CGPoint(x: 275, y: 180), controlPoint2: CGPoint(x: 275, y: 340))
        
        return path
    }
    
    private func getPathCookHat() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 100, y: 100))
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 50, startAngle: .pi, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: 220, y: 100))
        path.addArc(withCenter: CGPoint(x: 220, y: 150), radius: 50, startAngle: .pi*3/2, endAngle: .pi/2, clockwise: true)
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 200, y: 260))
        path.addLine(to: CGPoint(x: 100, y: 260))
        path.addLine(to: CGPoint(x: 100, y: 200))
        path.addLine(to: CGPoint(x: 80, y: 200))
        path.addArc(withCenter: CGPoint(x: 80, y: 150), radius: 50, startAngle: .pi/2, endAngle: .pi*3/2, clockwise: true)
        path.close()
        
        return path
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
