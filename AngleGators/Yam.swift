//
//  Yam.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/11/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

var yamTutorial:Bool = true
var yamsEaten:Int = 0 {
didSet {
    if(yamsEaten >= 5) {
        yamTutorial = false
    }
}
}

class Yam: Fruit {
    private var angle:Int = 50
    
    init(fruitType: Int) {
        if(yamTutorial) {
            super.init(fruitType: fruitType, labelText: angle)
            yamsEaten++
        }
        else {
            super.init(fruitType: fruitType, labelText: nil)
        }
    }
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}