//
//  SettingsGameController.swift
//  Cards
//
//  Created by Apple M1 on 23.05.2023.
//

import UIKit

class SettingsGameController: UITableViewController {
    enum Section: Int {
        case one
        case two
    }
    
    var settingsStorage: SettingStorageProtocol = SettingsStorage()
    var settingsSection: [Int: [SettingType]] = [:]
    var selectedSetting: SettingProtocol?
    
    var settings: [Int: [SettingProtocol]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Настройки"
        loadSettings()
    }
    
    private func loadSettings() {
        let sectionOne = Section.one.rawValue
        let sectionTwo = Section.two.rawValue
        
        settingsSection[sectionOne] = [.pairs, .colors]
        settingsSection[sectionTwo] = [.figures, .backside]
        
        for i in 0..<settingsSection.count {
            settings[i] = []
        }
        
        settingsStorage.loadSettings().forEach { setting in
            settingsSection.forEach { section in
                if settingsSection[section.key]!.contains(setting.typeSetting) {
                    settings[section.key]?.append(setting)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingsSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countRows = settings[section]?.count else {
            return 0
        }
        
        return countRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        guard let currentSetting = settings[indexPath.section]?[indexPath.row] else {
            return cell
        }
        
        let title = cell.viewWithTag(1) as? UILabel
        let type = cell.viewWithTag(2) as? UILabel
        
        title?.text = currentSetting.typeSetting.rawValue
        
        switch currentSetting.typeSetting {
        case .pairs: type?.text = String(CardPairs.allCases[currentSetting.currentValue.first ?? 0].number)
        default: type?.text = String(currentSetting.currentValue.count)
        }
        
        type?.textColor = .systemGray
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSetting = settings[indexPath.section]?[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let selectedSetting = selectedSetting else {
            return
        }
        
        showEditSettingsController(selectedSetting)
    }
    
    private func showEditSettingsController(_ currentSetting: SettingProtocol) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editSettingController = storyboard.instantiateViewController(withIdentifier: "SettingsTypesController") as! SettingsTypesController
        editSettingController.selectedSetting = currentSetting
        editSettingController.selectedTypes = currentSetting.currentValue
        
        editSettingController.doAfterEdit = { [unowned self] currentValue in
            settings.forEach { section in
                for (i, setting) in section.value.enumerated() {
                    if setting.currentValue == currentSetting.currentValue {
                        settings[section.key]?[i].currentValue = currentValue
                        tableView.reloadData()
                    }
                }
            }
            var savingArray: [SettingProtocol] = []
            settings.forEach { _, value in
                savingArray += value
            }
            settingsStorage.saveSettings(savingArray)
        }
        self.navigationController?.pushViewController(editSettingController, animated: true)
    }
}
