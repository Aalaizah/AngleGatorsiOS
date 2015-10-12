//
//  Zucchini.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

var zucchiniTutorial:Bool = true
var zucchinisEaten:Int = 0 {
didSet {
    if(zucchinisEaten >= 5) {
        zucchiniTutorial = false
    }
}
}

class Zucchini: Fruit {
    private var angle:Int = 50
    
    init(fruitType: Int) {
        if(zucchiniTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            zucchinisEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}