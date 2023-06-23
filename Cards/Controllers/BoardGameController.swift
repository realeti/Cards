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
        // добавляем кнопку переворота всех карточек
        view.addSubview(flipCardsButton)
        // добавляем кнопку возврата к главному меню
        view.addSubview(backToMainScene)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    var settingsStorage: SettingsStorage = SettingsStorage()
    
    // сущность "Игра"
    lazy var game: Game = getNewGame()
    // игровое поле
    lazy var boardGameView = getBoardGameView()
    // кнопка для запуска/перезапуска игры
    lazy var startButtonView = getStartButtonView()
    // кнопка переворота всех карточек
    lazy var flipCardsButton = getFlipCardsButton()
    // кнопка возврата в главное меню
    lazy var backToMainScene = getMainSceneButton()
    
    var isFlippedAll = false
    
    // размеры карточек
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    
    // переданные координаты размещения карточки
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.width - cardSize.width)
    }
    
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
    }
    
    // игральные карточки
    var cardViews: [UIView] = []
    
    private func getNewGame() -> Game {
        let game = Game()
        
        settingsStorage.loadSettings().forEach { setting in
            switch setting.typeSetting {
            case .pairs: game.cardsCount = CardPairs.allCases[setting.currentValue.first ?? 0].rawValue.number
            case .colors: game.cardsColors = setting.currentValue
            case .figures: game.cardsFigures = setting.currentValue
            case .backside: game.cardsBacksides = setting.currentValue
            }
        }
        
        // TODO: add setting colors, figures, backside
        
        game.generateCards()
        return game
    }
    
    private var flippedCards: [UIView] = []
    
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
        boardView.backgroundColor = .systemBlue
        
        return boardView
    }
    
    private func getStartButtonView() -> UIButton {
        // создаем кнопку
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
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
        button.setTitle("Start game", for: .normal)
        
        // устанавливаем цвет текста для обычного (не нажатого) состояния
        button.setTitleColor(.gray, for: .highlighted)
        // устанавливаем фоновый цвет
        button.backgroundColor = .systemRed
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
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        placeCardsOnBoard(cards)
    }
    
    private func getFlipCardsButton() -> UIButton {
        let margin: CGFloat = 10
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.frame.origin.x = view.frame.maxX - button.frame.width - margin
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let topPadding = window!.safeAreaInsets.top
        button.frame.origin.y = topPadding
        
        button.setTitle("Flip!", for: .normal)
        button.setTitleColor(.systemRed, for: .highlighted)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 10
        
        button.addTarget(nil, action: #selector(flipAllCards(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func flipAllCards(_ sender: UIButton) {
        isFlippedAll.toggle()
        
        for card in cardViews {
            let flippedCard = card as! FlippableView
            if isFlippedAll && flippedCard.isFlipped || !isFlippedAll && !flippedCard.isFlipped {
                flippedCards = []
                continue
            }
            
            flippedCard.globalFlip()
        }
    }
    
    private func getMainSceneButton() -> UIButton {
        let margin: CGFloat = 10
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.frame.origin.x = margin
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let topPadding = window!.safeAreaInsets.top
        button.frame.origin.y = topPadding
        
        button.setTitle("Main Menu", for: .normal)
        button.setTitleColor(.systemBlue, for: .highlighted)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        
        button.addTarget(nil, action: #selector(showMainScene(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func showMainScene(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // генерация массива карточек на основе данных Модели
    private func getCardsBy(modelData: [Card]) -> [UIView] {
        // хранилище для представлений карточек
        var cardViews: [UIView] = []
        
        // фабрика карточек
        let cardViewFactory = CardViewFactory()
        
        // перебираем массив карточек в модели
        for (index, modelCard) in modelData.enumerated() {
            // добавляем первый экземпляр карты
            let cardOne = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color, andBackSide: CardBackSide.allCases[game.cardsBacksides.randomElement()!])
            cardOne.tag = index
            cardViews.append(cardOne)
            
            // добавляем второй экземпляр карты
            let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color, andBackSide: CardBackSide.allCases[game.cardsBacksides.randomElement()!])
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        
        // добавляем всем картам обработчик переворота
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = { [self] flippedCard in
                // переносим карточку вверх иерархии
                flippedCard.superview?.bringSubviewToFront(flippedCard)

                // добавляем или удаляем карточку
                if flippedCard.isFlipped {
                    self.flippedCards.append(flippedCard)
                } else {
                    if let cardIndex = self.flippedCards.firstIndex(of: flippedCard) {
                        self.flippedCards.remove(at: cardIndex)
                    }
                }

                // если перевернуто 2 карточки
                if self.flippedCards.count == 2 {
                    // получаем карточки из данных модели
                    let firstCard = game.cards[self.flippedCards.first!.tag]
                    let secondCard = game.cards[self.flippedCards.last!.tag]

                    // если карточки одинаковые
                    if game.checkCards(firstCard, secondCard) {
                        // сперва анимировано скрываем их
                        UIView.animate(withDuration: 0.3, animations: {
                            self.flippedCards.first!.layer.opacity = 0
                            self.flippedCards.last!.layer.opacity = 0
                        }, completion: { _ in
                            self.flippedCards.first!.removeFromSuperview()
                            self.flippedCards.last!.removeFromSuperview()
                            self.flippedCards = []
                        })
                    }
                    else {
                        // переворачиваем карточки рубашкой вверх
                        for card in self.flippedCards {
                            (card as! FlippableView).flip()
                        }
                    }
                }
            }
        }
        return cardViews
    }
    
    private func placeCardsOnBoard(_ cards: [UIView]) {
        // удаляем все имеющиеся на игровом поле карточки
        for card in cardViews {
            card.removeFromSuperview()
        }
        
        cardViews = cards
        //перебираем карточки
        for card in cardViews {
            // для каждой карточки генерируем случайные координаты
            let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
            card.frame.origin = CGPoint(x: randomXCoordinate, y: randomYCoordinate)
            
            // размещаем карточку на игровом поле
            boardGameView.addSubview(card)
        }
    }
}
