//
//  BoardGameController.swift
//  Cards
//
//  Created by Apple M1 on 29.04.2023.
//

import UIKit

class BoardGameController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        // добавляем кнопку на сцену
        view.addSubview(startButtonView)
    }
    
    // количество пар уникальных карточек
    var cardsPairsCount = 8
    // сущность "Игра"
    lazy var game: Game = getNewGame()
    
    // кнопка для запуска/перезапуска игры
    lazy var startButtonView = getStartButtonView()
    
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = cardsPairsCount
        game.generateCards()
        return game
    }
    
    private func getStartButtonView() -> UIButton {
        // создаем кнопку
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        // изменяем положение кнопки - перемещается в центр горизонтально оси родительского представления
        button.center.x = view.center.x
        
        // получаем доступ к текущему окну
        //let window = UIApplication.shared.windows[0]
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        // определяем отступ сверху от границ окна до Safe Area
        let topPadding = window!.safeAreaInsets.top
        // устанавливаем координату Y кнопки в соответствии с отступом
        button.frame.origin.y = topPadding
        
        // настраиваем внешний вид кнопки
        button.setTitle("Начать игру", for: .normal)
        
        // устанавливаем цвет текста для обычного (не нажатого) состояния
        button.setTitleColor(.gray, for: .highlighted)
        // устанавливаем фоновый цвет
        button.backgroundColor = .systemGray4
        // скругляем углы
        button.layer.cornerRadius = 10
        
        // подключаем обработчик нажатия на кнопку
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        
        // только для iOS >= 14 можно использовать такой метод
        /*button.addAction(UIAction(title: "", handler: { action in
            print("button was pressed")
        }), for: .touchUpInside)*/
        
        return button
    }
    
    @objc func startGame(_ sender: UIButton) {
        print("button was pressed")
    }
}
