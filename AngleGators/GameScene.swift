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
    static let Fruit        : UInt32 = 0b1
    static let Alligator    : UInt32 = 0b10
}

struct GameMode {
    static let Classic      : Int = 0
    static let Fifteens     : Int = 1
    static let Thirties     : Int = 2
}

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


func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

var score: Int = 0
var FontSize: CGFloat = 20
var highScores = [Int](count: 3, repeatedValue: 0)
var gameMode = GameMode.Classic

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player:Alligator = Alligator()
    var alligatorLocation:CGPoint = CGPoint(x:0, y:0)
    var alligatorY:CGFloat = 0
    var fruitSpeed:CGFloat = 2
    let fruitCreationSpeed:NSTimeInterval = 2
    var tutorial = true
    var fruitNum:CGFloat = 5
    var angles = [10, 30, 50, 70, 90]
    var alligatorAngle = 10
    var current = 0
    var lives:Int = 3 {
        didSet {
            if(lives <= 0) {
                updateHightScores()
                kill()
            }
        }
    }
    let updateTime: NSTimeInterval = 30
    let scoreLabelName = "scoreLabel"
    let angleLabelName = "angelLabel"
    let livesLabelName = "livesLabel"
    let fruitLabelName = "fruitLabel"

    
    override func didMoveToView(view: SKView) {
        switch(gameMode){
        case 0:
            alligatorAngle = 10
            angles = [10, 30, 50, 70, 90]
            break
        case 1:
            alligatorAngle = 15
            angles = [15, 45, 75, 90]
            player.changeImage(alligatorAngle)
            break
        case 2:
            alligatorAngle = 30
            angles = [30, 60, 90]
            player.changeImage(alligatorAngle)
            break
        default:
            alligatorAngle = 10
            angles = [10, 30, 50, 70, 90]
            break
        }
        
        //playBackgroundMusic("background-music-aac.caf")
        score = 0
        let background = SKSpriteNode(imageNamed: "mainbackground")
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        alligatorLocation = CGPoint(x: frame.size.width * 0.1, y: frame.size.height * 0.5)
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        //addChild(background)
        
        let upArrow = SKSpriteNode(imageNamed: "upArrow")
        upArrow.position = CGPoint(x: upArrow.size.width/2, y: frame.size.height / 4 * 3)
        addChild(upArrow)
        let downArrow = SKSpriteNode(imageNamed: "downArrow")
        downArrow.position = CGPoint(x: frame.size.width - downArrow.size.width/2, y: frame.size.height / 4 * 3)
        addChild(downArrow)
        
        backgroundColor = SKColor.whiteColor()
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock{self.setupFruit()},
                SKAction.waitForDuration(fruitCreationSpeed)//1.75)
                ])
            ))
        
        addLivesLabel()
        addScoreLabel()
        addAlligator()
        addAngleLabel()
        runAction(SKAction.sequence([
            SKAction.waitForDuration(NSTimeInterval(30)),
            SKAction.runBlock{self.fruitNum = 8; self.fruitSpeed += 0.2},
            SKAction.waitForDuration(NSTimeInterval(30)),
            SKAction.runBlock{self.removeAngleLabel();self.fruitNum = 11; self.fruitSpeed += 0.2}
            ]))
    }
    
    override func update(currentTime: NSTimeInterval) {
        moveFruit()
    }
    
    func addAlligator() {
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        alligatorY = player.texture!.size().height
        player.name = "player"
        addChild(player)
    }
    
    func addAngleLabel() {
        let angleLabel = SKLabelNode(fontNamed: "Courier")
        angleLabel.name = angleLabelName
        angleLabel.text = String(alligatorAngle)
        angleLabel.fontSize = FontSize
        angleLabel.fontColor = SKColor.blackColor()
        angleLabel.position = CGPoint(x: player.position.x, y: player.position.y + 30)
        addChild(angleLabel)
    }
    
    func removeAngleLabel() {
        let angleLabel = self.childNodeWithName(angleLabelName) as! SKLabelNode
        angleLabel.removeFromParent()
        tutorial = false
    }
    
    func addScoreLabel() {
        let scoreLabel = SKLabelNode(fontNamed: "Courier")
        scoreLabel.name = scoreLabelName
        scoreLabel.fontSize = FontSize
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.text = String(format: "Score: %03u", score)
        
        scoreLabel.position = CGPoint(x: (frame.size.width / 2), y: (frame.size.height / 6) * 5)
        addChild(scoreLabel)
    }
    
    func addLivesLabel() {
        let livesLabel = SKLabelNode(fontNamed: "Courier")
        livesLabel.name = livesLabelName
        livesLabel.text = String(format: "Lives: %01u", lives)
        livesLabel.fontSize = FontSize
        livesLabel.fontColor = SKColor.blackColor()
        livesLabel.position = CGPoint(x: (frame.size.width / 2), y: ((frame.size.height / 6) * 5) - 30)
        addChild(livesLabel)
    }
    
    func moveFruit() {
        enumerateChildNodesWithName("fruit") { node, stop in
            let fruit = node as! Fruit
            fruit.position.x -= CGFloat(self.fruitSpeed)
        }
    }
    
    func setupFruit() {
        let number = Int(random(CGFloat(0), max: fruitNum))
        let fruit = Fruit(fruitType: number, labelText: nil)
        fruit.position  = CGPoint(x: frame.size.width + fruit.size.width, y: frame.size.height * 0.33)//alligatorLocation.y - (alligatorY / 3))
        fruit.zPosition = -1
        addChild(fruit)
        addChild(fruit.label)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        let array = Array(touches)
        let touch = array[0]
        let touchLocation = touch.locationInNode(self)
        let gator = self.childNodeWithName("player") as! Alligator
        if touchLocation.x < CGRectGetMidX(self.frame) && alligatorAngle < 90 {
            current += 1
            alligatorAngle = angles[current]
            gator.changeImage(alligatorAngle)
        }
        else if touchLocation.x > CGRectGetMidX(self.frame) && alligatorAngle > angles[0] {
            current -= 1
            alligatorAngle  = angles[current]
            gator.changeImage(alligatorAngle)
        }
        if(tutorial) {
            let angleLabel = childNodeWithName(angleLabelName) as! SKLabelNode
            angleLabel.text = String(alligatorAngle)
        }
    }
    
    func fruitDidCollideWithAlligator(fruit:Fruit, alligator:SKSpriteNode) {
        fruit.removeFromParent()
        if(alligatorAngle == fruit.fruitAngle) {
            score += 5
        }
        else {
            lives -= 1
        }
        let scoreLabel = self.childNodeWithName(scoreLabelName) as! SKLabelNode
        scoreLabel.text = String(format: "Score: %03u", score)
        let livesLabel = self.childNodeWithName(livesLabelName) as! SKLabelNode
        livesLabel.text = String(format: "Lives: %01u", lives)
    }
    
    func updateHightScores() {
        var index: Int
        for index = 0; index < highScores.count; index++
        {
            if(score > highScores[index])
            {
                highScores.removeLast()
                highScores.insert(score, atIndex: index)
                break
            }
        }
    }
    
    func kill() {
        fruitTutorials = [true, true, true, true, true, true, true, true, true, true, true]
        fruitCounts = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        let gameOverScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: reveal)
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