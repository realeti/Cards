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
        // добавляем игровое поле на сцену
        view.addSubview(boardGameView)
    }
    
    // количество пар уникальных карточек
    var cardsPairsCount = 8
    // сущность "Игра"
    lazy var game: Game = getNewGame()
    // игровое поле
    lazy var boardGameView = getBoardGameView()
    
    // кнопка для запуска/перезапуска игры
    lazy var startButtonView = getStartButtonView()
    
    // размеры карточек
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    
    // переданные координаты размещения карточки
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.width)
    }
    
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
    }
    
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
    
    private func getBoardGameView() -> UIView {
        let boardView = UIView()
        
        // отступ ближайших элементов
        let margin: CGFloat = 10
        
        // указываем координаты x
        boardView.frame.origin.x = margin
        // указываем координаты y
        let scene = UIApplication.shared.connectedScenes
        let windowScene = scene.first as? UIWindowScene
        let window = windowScene?.windows.first
        let topPadding = window!.safeAreaInsets.top
        boardView.frame.origin.y = topPadding + startButtonView.frame.height + margin
        
        // рассчитываем ширину
        boardView.frame.size.width = UIScreen.main.bounds.width - margin * 2
        // рассчитываем высоту с учетом нижнего отступа
        let bottomPadding = window!.safeAreaInsets.bottom
        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding
        
        // изменяем стиль игрового поля
        boardView.layer.cornerRadius = 5
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
        
        return boardView
    }
    
    // генерация массива карточек на основе данных Модели
    private func getCardsBy(modelData: [Card]) -> [UIView] {
        // хранилище для представлений карточек
        var cardViews = [UIView]()
        
        // фабрика карточек
        let cardViewFactory = CardViewFactory()
        
        // перебираем массив карточек в модели
        for (index, modelCard) in modelData.enumerated() {
            // добавляем первый экземпляр карты
            let cardOne = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            
            // добавляем второй экземпляр карты
            let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        
        // добавляем всем картам обработчик переворота
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = { flippedCard in
                // переносим карточку вверх иерархии
                flippedCard.superview?.bringSubviewToFront(flippedCard)
            }
        }
        return cardViews
    }
}
