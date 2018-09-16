//
//  Concentration.swift
//  Concentration
//
//  Created by Yacov Uziel on 13/09/2018.
//  Copyright © 2018 Yacov Uziel. All rights reserved.
//

import Foundation

class Concentration{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var numberOfFlips = 0
    
    var score = 0
    
    var historyOfChoices = [Int]()
    
    func chooseCard(atIndex index: Int){
        print (index)
//        historyOfChoices.append(index)

        numberOfFlips += 1
        
//        cards[index].isFaceUp = !cards[index].isFaceUp
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index { // 2 different cards were selected
                if cards[matchIndex].identifier == cards[index].identifier { // we've got a match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else {
                    if historyOfChoices.contains(index) {
                         score -= 1
                    }
                    else {
                        historyOfChoices.append(index)
                    }
                }
                
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            }
            else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
                    print (historyOfChoices)
        }
    }
    
    init (numberOfPairs: Int){
        for _ in 1...numberOfPairs {
            let card = Card()
            cards.append(card)
            cards.append(card) //for matching card
        }
        
        //shuffle the cards        
        for _ in cards.indices {
            let firstRandomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let secondRandomIndex = Int(arc4random_uniform(UInt32(cards.count)))
//            swap(&cards[firstRandomIndex], &cards[secondRandomIndex])
            cards.swapAt(firstRandomIndex, secondRandomIndex)
            
            
        }
    }
    
    func getFlipCounter() -> Int {
        return numberOfFlips
    }
    
    func getScore() -> Int {
        return score
    }
    
    func startNewGame() {
        historyOfChoices.removeAll()
        score = 0
        numberOfFlips = 0
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
    }
}
