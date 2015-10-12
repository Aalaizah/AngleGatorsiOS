//
//  Acorn.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

var acornTutorial:Bool = true
var acornsEaten:Int = 0 {
didSet {
    if(acornsEaten >= 5) {
        acornTutorial = false
    }
}
}

class Acorn: Fruit {
    private var angle:Int = 10
    
    init(fruitType: Int) {
        if(acornTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            acornsEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}