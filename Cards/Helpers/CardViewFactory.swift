//
//  CardViewFactory.swift
//  Cards
//
//  Created by Apple M1 on 02.05.2023.
//

import UIKit

class CardViewFactory {
    func get(_ shape: CardFigure, withSize size: CGSize, andColor color: CardColor, andBackSide backside: CardBackSide) -> UIView {
        // на основе размеров определяем фрейм
        let frame = CGRect(origin: .zero, size: size)
        // определяем UI-цвет на основе цвета модели
        let viewColor = getViewColorBy(modelColor: color)
        
        // генерируем и возвращаем карточку
        switch shape {
        case .circle:
            return CardView<CircleShape>(frame: frame, color: viewColor, backside: backside)
        case .circleNoColor:
            return CardView<CircleNoColorShape>(frame: frame, color: viewColor, backside: backside)
        case .cross:
            return CardView<CrossShape>(frame: frame, color: viewColor, backside: backside)
        case .square:
            return CardView<SquareShape>(frame: frame, color: viewColor, backside: backside)
        case .fill:
            return CardView<FillShape>(frame: frame, color: viewColor, backside: backside)
        }
    }
    
    // преобразуем цвет модели в цвет представления
    private func getViewColorBy(modelColor: CardColor) -> UIColor {
        switch modelColor {
        case .black:
            return .black
        case .red:
            return .red
        case .green:
            return .green
        case .gray:
            return .gray
        case .brown:
            return .brown
        case .yellow:
            return .yellow
        case .purple:
            return .purple
        case .orange:
            return .orange
        }
    }
}
