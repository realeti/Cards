//
//  SettingsPairsController.swift
//  Cards
//
//  Created by Apple M1 on 06.06.2023.
//

import UIKit

class SettingsTypesController: UITableViewController {
    enum PairsCount: String, CaseIterable {
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
    
    private var settingsPairs: [PairsCount] = []
    
    var selectedSetting: SettingsProtocol?
    private var selectedTypePairs: PairsCount = .eight
    
    var doAfterEdit: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Кол-во пар карточек"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveData(_:)))
        
        for value in PairsCount.allCases {
            settingsPairs.append(value)
        }
    }
    
    @objc func saveData(_ sender: UIButton) {
        let currentValue = selectedTypePairs.rawValue.number
        doAfterEdit?(currentValue)
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsPairs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTypesCell", for: indexPath)
        
        let title = cell.viewWithTag(3) as? UILabel
        
        title?.text = settingsPairs[indexPath.row].rawValue.name
        cell.accessoryType = settingsPairs[indexPath.row] == selectedTypePairs ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedType = settingsPairs[indexPath.row]
        selectedTypePairs = selectedType
        
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
