//
//  Peach.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

var peachTutorial:Bool = true
var peachesEaten:Int = 0 {
    didSet {
        if(peachesEaten >= 5) {
            peachTutorial = false
        }
    }
}

class Peach: Fruit {
    private var angle:Int = 70
    
    init(fruitType: Int) {
        if(peachTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            peachesEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
