//
//  SettingsPairsController.swift
//  Cards
//
//  Created by Apple M1 on 06.06.2023.
//

import UIKit

class SettingsTypesController: UITableViewController {
    private var settingsPairs: [PairsType] = []
    private var settingsColors: [ColorsType] = []
    
    var selectedSetting: SettingProtocol?
    var selectedTypes: [Int] = []
    var doAfterEdit: (([Int]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentSettingType = selectedSetting?.typeSetting else {
            return
        }
        
        switch currentSettingType {
        case .pairs:
            self.navigationItem.title = "Кол-во пар карточек"
            for value in PairsType.allCases {
                settingsPairs.append(value)
            }
        case .colors:
            self.navigationItem.title = "Доступные цвета"
            for value in ColorsType.allCases {
                settingsColors.append(value)
            }
        case .figures:
            for value in PairsType.allCases {
                settingsPairs.append(value)
            }
        case .design:
            for value in PairsType.allCases {
                settingsPairs.append(value)
            }
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveData(_:)))
    }
    
    @objc func saveData(_ sender: UIButton) {
        doAfterEdit?(selectedTypes)
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentSettingType = selectedSetting?.typeSetting else {
            return 0
        }
        
        switch currentSettingType {
        case .pairs:
            return settingsPairs.count
        case .colors:
            return settingsColors.count
        case .figures:
            return 0
        case .design:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTypesCell", for: indexPath)
        
        guard let currentSettingType = selectedSetting?.typeSetting else {
            return cell
        }
        
        switch currentSettingType {
        case .pairs:
            return cellForPairsSettings(cell, indexPath)
        case .colors:
            return cellForColorsTypeSetting(cell, indexPath)
        case .figures:
            return cellForPairsSettings(cell, indexPath)
        case .design:
            return cellForPairsSettings(cell, indexPath)
        }
    }
    
    private func cellForPairsSettings(_ cell: UITableViewCell, _ indexPath: IndexPath) -> UITableViewCell {
        let title = cell.viewWithTag(3) as? UILabel
        
        title?.text = settingsPairs[indexPath.row].rawValue.name
        //cell.accessoryType = settingsPairs[indexPath.row] == selectedTypePairs ? .checkmark : .none
        cell.accessoryType = selectedTypes.contains(indexPath.row) ? .checkmark : .none
        
        return cell
    }
    
    private func cellForColorsTypeSetting(_ cell: UITableViewCell, _ indexPath: IndexPath) -> UITableViewCell {
        let title = cell.viewWithTag(3) as? UILabel
        
        title?.text = settingsColors[indexPath.row].rawValue.name
        //cell.accessoryType = selectedColorsType.contains(settingsColors[indexPath.row]) ? .checkmark : .none
        cell.accessoryType = selectedTypes.contains(indexPath.row) ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentSettingType = selectedSetting?.typeSetting else {
            return
        }
        
        switch currentSettingType {
        case .pairs: didSelectForPairs(indexPath)
        case .colors: didSelectForColors(indexPath)
        case .figures: didSelectForPairs(indexPath)
        case .design: didSelectForPairs(indexPath)
        }
        
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func didSelectForPairs(_ indexPath: IndexPath) {
        if selectedTypes.count > 0 {
            selectedTypes = []
        }
        selectedTypes.append(indexPath.row)
    }
    
    private func didSelectForColors(_ indexPath: IndexPath) {
        let selectRow = indexPath.row
        
        if selectedTypes.contains(selectRow) {
            if selectedTypes.count > 1 {
                guard let selectedIndex = selectedTypes.firstIndex(of: selectRow) else {
                    return
                }
                selectedTypes.remove(at: selectedIndex)
            }
        } else {
            selectedTypes.append(selectRow)
        }
    }
}
