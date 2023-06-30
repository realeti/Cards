//
//  MainController.swift
//  Cards
//
//  Created by Apple M1 on 10.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        
        view.addSubview(backgroundImage)
        view.addSubview(labelAppName)
        view.addSubview(wandImage)
        view.addSubview(buttonNewGame)
        view.addSubview(buttonSettings)
    }
    
    lazy var backgroundImage = getBackgroundImage()
    lazy var labelAppName = getAppLabel()
    lazy var wandImage = getWandImage()
    lazy var buttonNewGame = getNewGameButton()
    lazy var buttonSettings = getSettingsButton()
    
    private func getBackgroundImage() -> UIImageView {
        let image = UIImage(named: "backgroundMainMenu")
        let background = UIImageView(frame: view.frame)
        
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true
        background.image = image
        background.center = view.center
        
        return background
    }
    
    private func getAppLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.center.x = view.center.x
        
        let padding: CGFloat = 50
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let topPadding = window!.safeAreaInsets.top
        label.frame.origin.y = topPadding + padding
        
        label.text = "Cards"
        label.textColor = UIColor(named: "CustomColor") ?? .systemBlue
        label.font = UIFont(name: "CCRickVeitchW05", size: 85) ?? .systemFont(ofSize: 85)
        label.transform = CGAffineTransform(rotationAngle: (-6 * CGFloat.pi / 180))
        
        return label
    }
    
    private func getWandImage() -> UIImageView {
        let image = UIImage(named: "wand")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView()
        
        let margin: CGFloat = 35
        let padding: CGFloat = 35
        
        imageView.frame.origin.x = labelAppName.frame.minX + margin
        imageView.frame.origin.y = labelAppName.frame.maxY - padding
        imageView.frame.size = CGSize(width: 265, height: 55)
        
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.tintColor = UIColor(named: "CustomColor") ?? .systemBlue
        
        return imageView
    }
    
    private func getNewGameButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center.x = view.center.x
        
        let padding: CGFloat = 250
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let topPadding = window!.safeAreaInsets.top
        button.frame.origin.y = topPadding + padding
        
        button.setTitle("New Game", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        button.setTitleColor(UIColor(red: 15/255, green: 43/255, blue: 89/255, alpha: 1.0), for: .normal)
        button.setTitleColor(.systemRed, for: .highlighted)
        button.backgroundColor = .clear
        button.layer.borderWidth = 3
        button.layer.borderColor = CGColor(red: 15/255, green: 43/255, blue: 89/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        
        button.addTarget(nil, action: #selector(newGame(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func newGame(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let boardGameController = storyboard.instantiateViewController(identifier: "BoardGameController")
        self.navigationController?.pushViewController(boardGameController, animated: true)
    }
    
    private func getSettingsButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center.x = view.center.x
        
        let padding: CGFloat = 10
        button.frame.origin.y = buttonNewGame.frame.maxY + padding
        
        button.setTitle("Settings", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        button.setTitleColor(UIColor(red: 15/255, green: 43/255, blue: 89/255, alpha: 1.0), for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        button.backgroundColor = .systemBlue
        button.backgroundColor = .clear
        button.layer.borderWidth = 3
        button.layer.borderColor = CGColor(red: 15/255, green: 43/255, blue: 89/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        
        button.addTarget(nil, action: #selector(gameSettings(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func gameSettings(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameSettingsController = storyboard.instantiateViewController(withIdentifier: "GameSettingsController")
        self.navigationController?.pushViewController(gameSettingsController, animated: true)
    }
}

extension UIImage {
    func withBackground(color: UIColor, opaque: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)

        guard let context = UIGraphicsGetCurrentContext(),
              let image = cgImage else { return self }

        let rect = CGRect(origin: .zero, size: size)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        context.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
        context.draw(image, in: rect)

        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
