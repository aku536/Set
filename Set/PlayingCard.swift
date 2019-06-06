//
//  Card.swift
//  Set
//
//  Created by Кирилл Афонин on 22/01/2019.
//  Copyright © 2019 krrl. All rights reserved.
//

import Foundation

struct PlayingCard: Equatable {
    static func == (lhs: PlayingCard, rhs: PlayingCard) -> Bool { return ((lhs.symbols == rhs.symbols) && (lhs.quantity == rhs.quantity) && (lhs.colors == rhs.colors) && (lhs.strokes == rhs.strokes)) }
    
    // card's attributes
    var symbols: Symbol
    var quantity: Quantity
    var colors: Color
    var strokes: Stroke
    
    // card's attributes are abstract in model
    enum Symbol: Int {
        case figureOne = 0
        case figureTwo
        case figureThree
        
        static var all = [Symbol.figureOne, .figureTwo, .figureThree]
    }
    
    enum Quantity: Int {
        case one = 0
        case two
        case three
        
        static var all = [Quantity.one, .two, .three]
    }
    
    enum Color: Int {
        case colorOne = 0
        case colorTwo
        case colorThree
        
        static var all = [Color.colorOne, .colorTwo, .colorThree]
    }
    
    enum Stroke: Int {
        case strokeOne = 0
        case strokeTwo
        case strokeThree
        
        static var all = [Stroke.strokeOne, .strokeTwo, .strokeThree]
    }
}
