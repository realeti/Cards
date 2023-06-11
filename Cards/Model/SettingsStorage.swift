//
//  SettingStorage.swift
//  Cards
//
//  Created by Apple M1 on 05.06.2023.
//

import UIKit

enum SettingType: String {
    case pairs = "Кол-во пар одинаковых карт"
    case colors = "Доступные цвета карт"
    case figures = "Типы карт"
    case design = "Узоры обратной стороны карт"
}

protocol SettingProtocol {
    var typeSetting: SettingType { get set }
    var currentValue: [Int] { get set }
}

protocol SettingStorageProtocol {
    func loadSettings() -> [SettingProtocol]
    func saveSettings(_ settings: [SettingProtocol])
}

struct Setting: SettingProtocol {
    var typeSetting: SettingType
    var currentValue: [Int]
}

class SettingsStorage: SettingStorageProtocol {
    func loadSettings() -> [SettingProtocol] {
        let testSettings: [SettingProtocol] = [
            Setting(typeSetting: .pairs, currentValue: [1]),
            Setting(typeSetting: .colors, currentValue: [2, 4]),
            Setting(typeSetting: .figures, currentValue: [3, 2]),
            Setting(typeSetting: .design, currentValue: [4, 1])
        ]
        return testSettings
    }
    
    func saveSettings(_ settings: [SettingProtocol]) {}
}

enum SettingValue {
    case pairs
    case colors
    case figures
    case design
    
    var name: String {
        switch self {
        case .pairs: return "Кол-во пар одинаковых карт"
        case .colors: return "Доступные цвета карт"
        case .figures: return "Типы карт"
        case .design: return "Узоры обратной стороны карт"
        }
    }
}

enum PairsType: CaseIterable {
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
