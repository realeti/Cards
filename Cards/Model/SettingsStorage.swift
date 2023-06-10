//
//  SettingStorage.swift
//  Cards
//
//  Created by Apple M1 on 05.06.2023.
//

import UIKit

enum TypeSettings: String {
    case pairs = "Кол-во пар одинаковых карт"
    case colors = "Доступные цвета карт"
    case figures = "Типы карт"
    case design = "Узоры обратной стороны карт"
}

protocol SettingsProtocol {
    var typeValue: TypeSettings { get set }
    var currentValue: Int { get set }
}

protocol SettingsStorageProtocol {
    func loadSettings() -> [SettingsProtocol]
    func saveSettings(_ settings: [SettingsProtocol])
}

struct Settings: SettingsProtocol {
    var typeValue: TypeSettings
    var currentValue: Int
}

class SettingsStorage: SettingsStorageProtocol {
    func loadSettings() -> [SettingsProtocol] {
        let testSettings: [SettingsProtocol] = [
            Settings(typeValue: .pairs, currentValue: 1),
            Settings(typeValue: .colors, currentValue: 2),
            Settings(typeValue: .figures, currentValue: 3),
            Settings(typeValue: .design, currentValue: 4)
        ]
        return testSettings
    }
    
    func saveSettings(_ settings: [SettingsProtocol]) {}
}

enum PairsCount: CaseIterable {
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

enum ColorsType: CaseIterable {
    case black
    case red
    case green
    case gray
    case brown
    case yellow
    case purple
    case orange
    
    var rawValue: (color: UIColor, name: String) {
        switch self {
        case .black: return (.black, "Черный")
        case .red: return (.red, "Красный")
        case .green: return (.green, "Зеленый")
        case .gray: return (.gray, "Cерый")
        case .brown: return (.brown, "Коричневый")
        case .yellow: return (.systemYellow, "Желтый")
        case .purple: return (.purple, "Пурпурный")
        case .orange: return (.systemOrange, "Оранжевый")
        }
    }
}
