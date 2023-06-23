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
    private var storage = UserDefaults.standard
    var storageKey = "cardSettings"
    
    private enum SettingKey: String {
        case pairs, colors, figures, backside
    }
    
    func loadSettings() -> [SettingProtocol] {
        lazy var defaultValues: [SettingProtocol] = [
            Setting(typeSetting: .pairs, currentValue: [4]),
            Setting(typeSetting: .colors, currentValue: [0, 1, 2, 3, 4, 5, 6, 7]),
            Setting(typeSetting: .figures, currentValue: [0, 1, 2, 3, 4]),
            Setting(typeSetting: .backside, currentValue: [0, 1])
        ]
        
        var resultSettings: [SettingProtocol] = []
        let settingsFromStorage = storage.object(forKey: storageKey) as? [String: [Int]] ?? [:]
        
        guard let pairsValue = settingsFromStorage[SettingKey.pairs.rawValue],
           let colorsValue = settingsFromStorage[SettingKey.colors.rawValue],
           let figuresValue = settingsFromStorage[SettingKey.figures.rawValue],
           let backsideValue = settingsFromStorage[SettingKey.backside.rawValue] else {
               return defaultValues
        }

        resultSettings.append(Setting(typeSetting: .pairs, currentValue: pairsValue))
        resultSettings.append(Setting(typeSetting: .colors, currentValue: colorsValue))
        resultSettings.append(Setting(typeSetting: .figures, currentValue: figuresValue))
        resultSettings.append(Setting(typeSetting: .backside, currentValue: backsideValue))
        
        return resultSettings
    }
    
    func saveSettings(_ settings: [SettingProtocol]) {
        var newElementForStorage: Dictionary<String, [Int]> = [:]
        settings.forEach { setting in
            switch setting.typeSetting {
            case .pairs: newElementForStorage[SettingKey.pairs.rawValue] = setting.currentValue
            case .colors: newElementForStorage[SettingKey.colors.rawValue] = setting.currentValue
            case .figures: newElementForStorage[SettingKey.figures.rawValue] = setting.currentValue
            case .backside: newElementForStorage[SettingKey.backside.rawValue] = setting.currentValue
            }
        }
        storage.set(newElementForStorage, forKey: storageKey)
    }
}
