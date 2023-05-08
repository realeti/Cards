//
//  Card.swift
//  Cards
//
//  Created by Apple M1 on 29.04.2023.
//

import UIKit

// типы фигуры карт
enum CardType: CaseIterable {
    case circle
    case circleNoColor
    case cross
    case square
    case fill
}

// цвета карт
enum CardColor: CaseIterable {
    case red
    case green
    case gray
    case black
    case brown
    case yellow
    case purple
    case orange
}

// игральная карточка
typealias Card = (type: CardType, color: CardColor)
