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
    
    var settingsStorage: SettingsStorageProtocol = SettingsStorage()
    var settingsSection: [Int: [typeSettings]] = [:]
    var settings: [Int: [SettingsProtocol]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Настройки"
        loadSettings()
    }
    
    private func loadSettings() {
        let sectionOne = Section.one.rawValue
        let sectionTwo = Section.two.rawValue
        
        settingsSection[sectionOne] = [.pairs, .colors]
        settingsSection[sectionTwo] = [.figures, .design]
        
        for i in 0..<settingsSection.count {
            settings[i] = []
        }
        
        settingsStorage.loadSettings().forEach { setting in
            settingsSection.forEach { section in
                if settingsSection[section.key]!.contains(setting.typeValue) {
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
        
        title?.text = currentSetting.typeValue.rawValue
        type?.text = String(currentSetting.currentValue)
        type?.textColor = .systemGray4
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
