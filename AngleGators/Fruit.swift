//
//  Fruit.swift
//  AngleGators
//
//  Created by Alexandria Mack on 9/30/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import SpriteKit

let fruits = [["apple", "70"], ["orange", "70"], ["peach", "70"], ["watermelon", "90"], ["yam", "50"], ["zucchini", "50"], ["strawberry", "10"], ["acorn", "10"], ["appleslice", "30"], ["lemon", "50"], ["orangeslice", "30"]]

class Fruit: SKSpriteNode {
    var fruitAngle = 0
    let fruitAngles = [10, 30, 40, 50 , 70, 90]
    var fruitHeight: Int = 10
    var fruitWidth: Int = 15
    let labelName = "fruit"
    var label:SKLabelNode = SKLabelNode()
    
    init(fruitType: Int, label: Bool) {
        let texture = SKTexture(imageNamed: fruits[fruitType][0])
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.name = "fruit"
        self.fruitAngle = Int(fruits[fruitType][1])!
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture.size()) // 1
        self.physicsBody?.dynamic = true // 2
        self.physicsBody?.categoryBitMask = PhysicsCategory.Fruit // 3
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Alligator // 4
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        if(label) {
            let label = SKLabelNode(fontNamed: "Courier")
            label.name = labelName
            label.text = String(fruits[fruitType][1])
            label.horizontalAlignmentMode = .Left
            label.fontSize = FontSize
            label.fontColor = SKColor.blackColor()
            label.position = CGPoint(x: frame.size.width - self.size.width - 20, y: frame.size.height * 0.7)
            addChild(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //func addFruitOfType()
    /*func addFruit(xPos: Int, yPos: Int) {
        
        // Create sprite
        let fruit = SKSpriteNode(color: SKColor.purpleColor(), size: fruitSize)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        fruit.position = CGPoint(x: xPos, y: yPos)//(x: size.width + fruit.size.width/2, y: size.height * 0.4)
        
        // Add the monster to the scene
        addChild(fruit)
        
        let movementSpeed = 5.0
        
        // Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: (fruitWidth/2), y: yPos),//(x: -fruit.size.width/2, y: size.height * 0.4),
            duration: NSTimeInterval(movementSpeed))
        let actionMoveDone = SKAction.removeFromParent()
        /*let loseAction = SKAction.runBlock(){
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition:reveal)
        }*/
        fruit.runAction(SKAction.sequence([actionMove, actionMoveDone]))//loseAction, actionMoveDone]))
    }*/
}