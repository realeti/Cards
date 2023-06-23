//
//  Card.swift
//  Cards
//
//  Created by Apple M1 on 29.04.2023.
//

import UIKit

// возможное кол-во парных карт
enum CardPairs: CaseIterable {
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    
    var rawValue: (number: Int, name: String) {
        switch self {
        case .four: return (4, "4 пары")
        case .five: return (5, "5 пар")
        case .six: return (6, "6 пар")
        case .seven: return (7, "7 пар")
        case .eight: return (8, "8 пар")
        case .nine: return (9, "9 пар")
        case .ten: return (10, "10 пар")
        }
    }
}

// типы фигур карт
enum CardFigure: String, CaseIterable {
    case circle = "Круг"
    case circleNoColor = "Прозрачный круг"
    case cross = "Крест"
    case square = "Квадрат"
    case fill = "Прямоугольник"
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
    
    var rawValue: (color: UIColor, name: String) {
        switch self {
        case .red: return (.red, "Красный")
        case .green: return (.green, "Зеленый")
        case .gray: return (.gray, "Cерый")
        case .black: return (.black, "Черный")
        case .brown: return (.brown, "Коричневый")
        case .yellow: return (.systemYellow, "Желтый")
        case .purple: return (.purple, "Пурпурный")
        case .orange: return (.systemOrange, "Оранжевый")
        }
    }
}

// обратная сторона карточек
enum CardBackSide: String, CaseIterable {
    case circles = "Круги"
    case lines = "Линии"
}

// игральная карточка
typealias Card = (type: CardFigure, color: CardColor)
