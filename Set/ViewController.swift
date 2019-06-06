//
//  ViewController.swift
//  Set
//
//  Created by Кирилл Афонин on 22/01/2019.
//  Copyright © 2019 krrl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // card's attributes
    let symbols = ["▲", "●", "■"]
    let colors = [UIColor.red, UIColor.purple, UIColor.green]
    let strokes = [3.0, -1.0, -2.0]
    var attributes: [NSAttributedString.Key:Any] = [
        .strokeWidth : 0.0,
        .strokeColor : UIColor.white,
        .foregroundColor : UIColor.white
    ]
    
    @IBOutlet var cardButtonCollection: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.text = "Score: \(game.score)"
        }
    }
    @IBOutlet weak var dealButton: UIButton!
    
    private var buttonDictionary = [Int:PlayingCard]()
    
    // creates a game
    private lazy var game = Set()
    
    // checks if there is a button and selects it
    @IBAction func onCardTouch(_ sender: UIButton) {
        if let cardIndex = cardButtonCollection.firstIndex(of: sender) {
            game.selectCard(at: cardIndex)
            updateViewFromModel()
        } else {
            print("There is no such button in collection!")
        }
        
    }
    
    // adds 3 new cards to the deck
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        game.deal3Cards()
        updateViewFromModel()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Set()
        updateViewFromModel()
    }
    
    // updates button's views depending on its state
    private func updateViewFromModel () {
        for index in cardButtonCollection.indices {
            let button = cardButtonCollection[index]
            
            if let card = (game.dealtCards.count > index ? game.dealtCards[index] : nil) {
                button.isEnabled = true
                button.backgroundColor = UIColor.white
                button.layer.borderWidth = 3.0
                button.setAttributedTitle(setSuit(index: index), for: .normal)
                
                if game.selectedCards.contains(card) {
                    button.layer.borderColor = UIColor.blue.cgColor
                    if game.selectedCards.count > 2 && !game.matchedCards.contains(card) {
                        button.layer.borderColor = UIColor.red.cgColor
                    }
                } else {
                    button.layer.borderColor = UIColor.white.cgColor
                }
            } else {
                button.isEnabled = false
                button.backgroundColor = #colorLiteral(red: 1, green: 0.6507438837, blue: 0.8702398539, alpha: 1)
                button.layer.borderWidth = 0.0
                button.setAttributedTitle( nil, for: .normal)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        dealButton.isEnabled = game.dealtCards.count < 24 && game.allCards.count > 0
    }
    
    // sets suit to a button by card model
    private func setSuit(index: Int) -> NSAttributedString {
        let card = game.dealtCards[index]
        let symbol = symbols[(card.symbols.rawValue)]
        let symbolString = symbol.repeatString(times: (card.quantity.rawValue))
        let stroke = strokes[(card.strokes.rawValue)]
        let color = colors[(card.colors.rawValue)]
        
        attributes[.strokeColor] = color
        attributes[.foregroundColor] = color
        if stroke == -2.0 {
            attributes[.foregroundColor] = color.withAlphaComponent(0.15)
        }
        attributes[.strokeWidth] = stroke
        let attributedString = NSAttributedString(string: symbolString, attributes: attributes)
        return attributedString
    }
}

// repeats string N times
extension String {
    func repeatString(times: Int) -> String {
        var newString = self
        for _ in 0..<times {
            newString += "\n" + self
        }
        return newString
    }
}
