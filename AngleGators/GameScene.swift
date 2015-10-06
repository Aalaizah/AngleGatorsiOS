//
//  GameScene.swift
//  SpriteKitSimpleGame
//
//  Created by Alexandria Mack on 9/19/15.
//  Copyright (c) 2015 Alexandria Mack. All rights reserved.
//

import SpriteKit
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

/*func playBackgroundMusic(filename: String){
    let url = NSBundle.mainBundle().URLForResource(
        filename, withExtension: nil)
    if(url == nil) {
        println("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    backgroundMusicPlayer =
        AVAudioPlayer(contentsOfURL: url, error: &error)
    if backgroundMusicPlayer == nil {
        println("Could not create audio player: \(error!)")
        return
    }
    
    backgroundMusicPlayer.numberOfLoops = -1
    backgroundMusicPlayer.prepareToPlay()
    backgroundMusicPlayer.play()
}*/

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Fruit        : UInt32 = 0b1      // 1
    static let Alligator    : UInt32 = 0b10     // 2
}

let fruitSize = CGSize(width: 24, height: 24)

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalize() -> CGPoint {
        return self / length()
    }
}

func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

var score: Int = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed: "gator0")
    let fruitSpeed = 3
    
    var fruitEaten = 0
    let angles = [0, 10, 20, 30, 40, 50 , 70, 90]
    var alligatorAngle = 0
    var current = 0
    //let angleLabel = SKLabelNode(fontNamed: "Chalkduster")
    let texture1 = SKTexture(imageNamed: "gator0")
    let texture2 = SKTexture(imageNamed: "gator20")
    var alligatorImages = [SKTexture]()
    var lives = 3
    let scoreLabelName = "scoreLabel"
    let angleLabelName = "angelLabel"
    let livesLabelName = "livesLabel"
    let fruitLabelName = "fruitLabel"
    
    /*func printFonts() {
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName as! String)
            print("Font Names = [\(names)]")
        }
    }*/

    
    override func didMoveToView(view: SKView) {
        
        //playBackgroundMusic("background-music-aac.caf")
        let background = SKSpriteNode(imageNamed: "mainbackground")
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        //addChild(background)
        backgroundColor = SKColor.whiteColor()
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock{self.setupFruit()},
                SKAction.waitForDuration(1.0)
                ])
            ))
        
        addLivesLabel()
        addScoreLabel()
        addAlligator()
        addAngleLabel()
        //printFonts()
    }
    
    override func update(currentTime: NSTimeInterval) {
        moveFruit()
    }
    
    func addAlligator() {
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.frame.size)
        player.physicsBody?.dynamic = false
        player.physicsBody?.categoryBitMask = PhysicsCategory.Alligator
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Fruit
        player.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        addChild(player)
    }
    
    func addAngleLabel() {
        let angleLabel = SKLabelNode(fontNamed: "Courier")
        angleLabel.name = angleLabelName
        angleLabel.text = String(alligatorAngle)
        angleLabel.fontSize = 40
        angleLabel.fontColor = SKColor.blackColor()
        angleLabel.position = CGPoint(x: player.position.x, y: player.position.y + 30)
        addChild(angleLabel)
    }
    
    func addScoreLabel() {
        let scoreLabel = SKLabelNode(fontNamed: "Courier")
        scoreLabel.name = scoreLabelName
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.text = String(format: "Score: %03u", score)
        
        scoreLabel.position = CGPoint(x: frame.size.width / 4, y: (frame.size.height / 5) * 4)
        addChild(scoreLabel)
    }
    
    func addLivesLabel() {
        let livesLabel = SKLabelNode(fontNamed: "Courier")
        livesLabel.name = livesLabelName
        livesLabel.text = String(format: "Lives: %01u", lives)
        livesLabel.fontSize = 40
        livesLabel.fontColor = SKColor.blackColor()
        livesLabel.position = CGPoint(x: frame.size.width / 4, y: ((frame.size.height / 5) * 4) - 50)
        addChild(livesLabel)
    }
    
    func addFruitLabel() {
        let fruitLabel = SKLabelNode(fontNamed: "Courier")
        fruitLabel.name = fruitLabelName
    }
    
    func moveFruit() {
        enumerateChildNodesWithName("fruit") { node, stop in
            let fruit = node as! Fruit
            fruit.position.x -= CGFloat(self.fruitSpeed)
            fruit.label.position.x -= CGFloat(self.fruitSpeed)
            NSLog(String(fruit.label))
        }
    }
    
    func setupFruit() {
        let fruit:Fruit = Fruit(imageName: "peach", label: true)
        fruit.position = CGPoint(x: frame.size.width + fruit.size.width, y: size.height * 0.43)
        addChild(fruit)
        addChild(fruit.label)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        let array = Array(touches)
        let touch = array[0]
        let touchLocation = touch.locationInNode(self)
        if touchLocation.x < size.width/2 && alligatorAngle < 90 {
            current += 1
            alligatorAngle = angles[current]
        }
        else if touchLocation.x > size.width/2 && alligatorAngle > 0 {
            current -= 1
            alligatorAngle  = angles[current]
        }
        let angleLabel = childNodeWithName(angleLabelName) as! SKLabelNode
        angleLabel.text = String(alligatorAngle)
    }
    
    func fruitDidCollideWithAlligator(fruit:Fruit, alligator:SKSpriteNode) {
        fruit.removeFromParent()
        if (alligatorAngle < fruit.fruitAngle) {
            lives -= 1
        } else {
            fruitEaten++
            score++
        }
        if (lives <= 0) {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        let scoreLabel = self.childNodeWithName(scoreLabelName) as! SKLabelNode
        scoreLabel.text = String(format: "Score: %03u", score)
        let livesLabel = self.childNodeWithName(livesLabelName) as! SKLabelNode
        livesLabel.text = String(format: "Lives: %01u", lives)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Fruit != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Alligator != 0)) {
                fruitDidCollideWithAlligator(firstBody.node as! Fruit, alligator: secondBody.node as! SKSpriteNode)
        }
    }
}