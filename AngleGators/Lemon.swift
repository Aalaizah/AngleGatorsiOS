//
//  Lemon.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//
import UIKit
import SpriteKit

var lemonTutorial:Bool = true
var lemonsEaten:Int = 0 {
didSet {
    if(lemonsEaten >= 5) {
        lemonTutorial = false
    }
}
}

class Lemon: Fruit {
    private var angle:Int = 50
    
    init(fruitType: Int) {
        if(lemonTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            lemonsEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
