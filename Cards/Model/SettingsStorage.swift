//
//  SettingStorage.swift
//  Cards
//
//  Created by Apple M1 on 05.06.2023.
//

import UIKit

enum typeSettings: String {
    case pairs = "Кол-во пар одинаковых карт"
    case colors = "Доступные цвета карт"
    case figures = "Типы карт"
    case design = "Узоры обратной стороны карт"
}

protocol SettingsProtocol {
    var typeValue: typeSettings { get set }
    var currentValue: Int { get set }
}

protocol SettingsStorageProtocol {
    func loadSettings() -> [SettingsProtocol]
    func saveSettings(_ settings: [SettingsProtocol])
}

struct Settings: SettingsProtocol {
    var typeValue: typeSettings
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
