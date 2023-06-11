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
    case backside = "Узоры обратной стороны карт"
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
            Setting(typeSetting: .pairs, currentValue: [4]),
            Setting(typeSetting: .colors, currentValue: [2, 4]),
            Setting(typeSetting: .figures, currentValue: [3, 2]),
            Setting(typeSetting: .backside, currentValue: [0, 1])
        ]
        return testSettings
    }
    
    func saveSettings(_ settings: [SettingProtocol]) {}
}
