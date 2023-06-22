//
//  Game.swift
//  Cards
//
//  Created by Apple M1 on 29.04.2023.
//

import UIKit

class Game {
    // количество пар уникальных карточек
    var cardsCount = 0
    // массив сгенерированных карточек
    var cards = [Card]()
    
    // генерация массива случайных карточек
    func generateCards() {
        // генерирум новый массив карточек
        var cards = [Card]()
        for _ in 0..<cardsCount {
            let randomElement = (type: CardFigure.allCases.randomElement()!, color: CardColor.allCases.randomElement()!)
            cards.append(randomElement)
        }
        self.cards = cards
    }
    
    // проверка эквивалентности карточек
    func checkCards(_ firstCard: Card, _ secondCard: Card) -> Bool {
        return firstCard == secondCard
    }
}
