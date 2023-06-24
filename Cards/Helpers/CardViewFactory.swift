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
        
        // генерируем и возвращаем карточку
        switch shape {
        case .circle:
            return CardView<CircleShape>(frame: frame, color: color.viewColor, backside: backside)
        case .circleNoColor:
            return CardView<CircleNoColorShape>(frame: frame, color: color.viewColor, backside: backside)
        case .cross:
            return CardView<CrossShape>(frame: frame, color: color.viewColor, backside: backside)
        case .square:
            return CardView<SquareShape>(frame: frame, color: color.viewColor, backside: backside)
        case .fill:
            return CardView<FillShape>(frame: frame, color: color.viewColor, backside: backside)
        }
    }
}
