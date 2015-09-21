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

func playBackgroundMusic(filename: String){
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
}

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Fruit        : UInt32 = 0b1      // 1
    static let Alligator    : UInt32 = 0b10     // 2
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

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalize() -> CGPoint {
        return self / length()
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // 1
    let player = SKSpriteNode(imageNamed: "gator0")
    
    var fruitEaten = 0
    let alligatorAngles = [0, 10, 20, 30, 40, 50 , 70, 90]
    var alligatorAngle = 0
    var current = 0
    let angleLabel = SKLabelNode(fontNamed: "Chalkduster")
    let texture1 = SKTexture(imageNamed: "gator0")
    let texture2 = SKTexture(imageNamed: "gator20")
    var alligatorImages = [SKTexture]()
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            println("------------------------------")
            println("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName as! String)
            println("Font Names = [\(names)]")
        }
    }

    
    override func didMoveToView(view: SKView) {
        let alligatorAngle = alligatorAngles[0]
        var alligatorImages = [texture1, texture2, texture1, texture2, texture1, texture2, texture1, texture2]
        
        //playBackgroundMusic("background-music-aac.caf")
        
        // 2
        backgroundColor = SKColor.whiteColor()
        // 3
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        // 4
        addChild(player)
        
        
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        /*runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addFruit),
                SKAction.waitForDuration(1.0)
                ])
            ))*/
        
        addAngleLabel()
        //printFonts()
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addFruit() {
        
        // Create sprite
        let fruit = SKSpriteNode(imageNamed: "monster")
        
        fruit.physicsBody = SKPhysicsBody(rectangleOfSize: fruit.size) // 1
        fruit.physicsBody?.dynamic = true // 2
        fruit.physicsBody?.categoryBitMask = PhysicsCategory.Fruit // 3
        fruit.physicsBody?.contactTestBitMask = PhysicsCategory.Alligator // 4
        fruit.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        fruit.position = CGPoint(x: size.width + fruit.size.width/2, y: size.height * 0.5)
        
        // Add the monster to the scene
        addChild(fruit)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: -fruit.size.width/2, y: size.height * 0.5),
            duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        let loseAction = SKAction.runBlock(){
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition:reveal)
        }
        fruit.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func addAngleLabel() {
        angleLabel.text = String(alligatorAngle)
        angleLabel.fontSize = 40
        angleLabel.fontColor = SKColor.blackColor()
        angleLabel.position = CGPoint(x: player.position.x, y: player.position.y + 30)
        addChild(angleLabel)
    }
    
    func addScoreLabel() {
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    
        let array = Array(touches)
        let touch = array[0] as! UITouch
        let touchLocation = touch.locationInNode(self)
        if touchLocation.x < size.width/2 && alligatorAngle < 90 {
            current += 1
            alligatorAngle = alligatorAngles[current]
            player.texture = alligatorImages[current]
        }
        else if touchLocation.x > size.width/2 && alligatorAngle > 0 {
            current -= 1
            alligatorAngle  = alligatorAngles[current]
        }
        println(alligatorAngle)
        angleLabel.text = String(alligatorAngle)
    }
    
    func projectileDidCollideWithMonster(projectile:SKSpriteNode, fruit:SKSpriteNode) {
        println("Hit")
        projectile.removeFromParent()
        fruit.removeFromParent()
        fruitEaten++
        /*if (fruitEaten > 30) {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }*/
    }
    
    func fruitDidCollideWithAlligator(alligator:SKSpriteNode, fruit:SKSpriteNode) {
        fruit.removeFromParent()
        fruitEaten++
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.Fruit != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Alligator != 0)) {
                projectileDidCollideWithMonster(firstBody.node as! SKSpriteNode, fruit: secondBody.node as! SKSpriteNode)
        }
    }
}