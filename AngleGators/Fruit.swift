//
//  Fruit.swift
//  AngleGators
//
//  Created by Alexandria Mack on 9/30/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import SpriteKit

let fruitsClassic = [["acorn", "10"], ["appleslice", "30"], ["lemon", "50"], ["apple", "70"], ["watermelon", "90"], ["strawberry", "10"],   ["orangeslice", "30"], ["orange", "70"], ["yam", "50"], ["zucchini", "50"], ["peach", "70"] ]
var fruitTutorials = [true, true, true, true, true, true, true, true, true, true, true]
var fruitCounts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

class Fruit: SKSpriteNode {
    var fruitAngle = 0
    var fruitHeight: CGFloat = 10
    var fruitWidth: CGFloat = 15
    let labelName = "fruit"
    var label:SKLabelNode = SKLabelNode()
    var numEaten:Int = 0
    
    init(fruitType: Int, labelText: Int?) {
        let texture = SKTexture(imageNamed: fruitsClassic[fruitType][0])
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.name = "fruit"
        fruitHeight = texture.size().height
        self.fruitAngle = Int(fruitsClassic[fruitType][1])!
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture.size())
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Fruit
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Alligator
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        if(fruitTutorials[fruitType]) {
            let label = SKLabelNode(fontNamed: "Courier")
            label.name = labelName
            label.text = String(fruitsClassic[fruitType][1])
            label.horizontalAlignmentMode = .Left
            label.fontSize = FontSize
            label.fontColor = SKColor.blackColor()
            label.position = CGPoint(x: frame.size.width - self.size.width - 20, y: frame.size.height * 0.7)
            addChild(label)
            fruitCounts[fruitType] += 1
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
            label.fontColor = SKColor.whiteColor()
            label.position = CGPoint(x: frame.size.width - self.size.width - 20, y: frame.size.height * 0.7)
            //addChild(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}