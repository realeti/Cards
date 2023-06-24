//
//  Card.swift
//  Cards
//
//  Created by Apple M1 on 29.04.2023.
//

import UIKit

// возможное кол-во парных карт
enum CardPairs: String, CaseIterable {
    case four = "4 пары"
    case five = "5 пар"
    case six = "6 пар"
    case seven = "7 пар"
    case eight = "8 пар"
    case nine = "9 пар"
    case ten = "10 пар"
    
    var number: Int {
        switch self {
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        case .ten: return 10
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
enum CardColor: String, CaseIterable {
    case red = "Красный"
    case green = "Зеленый"
    case gray = "Серый"
    case black = "Черный"
    case brown = "Коричневый"
    case yellow = "Желтый"
    case purple = "Пурпурный"
    case orange = "Оранжевый"
    
    var viewColor: UIColor {
        switch self {
        case .red: return .red
        case .green: return .systemGreen
        case .gray: return .gray
        case .black: return .black
        case .brown: return .brown
        case .yellow: return .systemYellow
        case .purple: return .purple
        case .orange: return .orange
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
