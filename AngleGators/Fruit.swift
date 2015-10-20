//
//  Fruit.swift
//  AngleGators
//
//  Created by Alexandria Mack on 9/30/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import SpriteKit

let fruits = [["apple", "70"], ["orange", "70"], ["peach", "70"], ["watermelon", "90"], ["yam", "50"], ["zucchini", "50"], ["strawberry", "10"], ["acorn", "10"], ["appleslice", "30"], ["lemon", "50"], ["orangeslice", "30"]]
var fruitTutorials = [true, true, true, true, true, true, true, true, true, true, true]
var fruitCounts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

class Fruit: SKSpriteNode {
    var fruitAngle = 0
    let fruitAngles = [10, 30, 40, 50 , 70, 90]
    var fruitHeight: Int = 10
    var fruitWidth: Int = 15
    let labelName = "fruit"
    var label:SKLabelNode = SKLabelNode()
    var numEaten:Int = 0
    
    init(fruitType: Int, labelText: Int?) {
        let texture = SKTexture(imageNamed: fruits[fruitType][0])
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.name = "fruit"
        self.fruitAngle = Int(fruits[fruitType][1])!
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture.size()) // 1
        self.physicsBody?.dynamic = true // 2
        self.physicsBody?.categoryBitMask = PhysicsCategory.Fruit // 3
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Alligator // 4
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        if(fruitTutorials[fruitType]) {
            let label = SKLabelNode(fontNamed: "Courier")
            label.name = labelName
            label.text = String(fruits[fruitType][1])
            label.horizontalAlignmentMode = .Left
            label.fontSize = FontSize
            label.fontColor = SKColor.blackColor()
            label.position = CGPoint(x: frame.size.width - self.size.width - 20, y: frame.size.height * 0.7)
            addChild(label)
            fruitCounts[fruitType] += 1
            //NSLog(fruits[fruitType][0] + ":" + String(fruitCounts[fruitType]))
            if(fruitCounts[fruitType] >= 5)
            {
                fruitTutorials[fruitType] = false
            }
        }
        else {
            let label = SKLabelNode(fontNamed: "Courier")
            label.name = labelName
            label.text = ""
            label.horizontalAlignmentMode = .Left
            label.fontSize = FontSize
            label.fontColor = SKColor.blackColor()
            label.position = CGPoint(x: frame.size.width - self.size.width - 20, y: frame.size.height * 0.7)
            //addChild(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}