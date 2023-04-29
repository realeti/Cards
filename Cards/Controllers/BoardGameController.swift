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

        // Do any additional setup after loading the view.
    }
    
    // количество пар уникальных карточек
    var cardsPairsCount = 8
    // сущность "Игра"
    lazy var game: Game = getNewGame()
    
    private func getNewGame() -> Game {
        var game = Game()
        game.cardsCount = cardsPairsCount
        game.generateCards()
        return game
    }
}
