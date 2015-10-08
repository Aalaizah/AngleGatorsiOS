//
//  GameOverScene.swift
//  SpriteKitSimpleGame
//
//  Created by Alexandria Mack on 9/20/15.
//  Copyright (c) 2015 Alexandria Mack. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = SKColor.blackColor()
        
        let message = "Game Over. Final Score: \(score)"
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.text = message
        label.fontSize = 30
        label.fontColor = SKColor.whiteColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2 + 50)
        addChild(label)
        
        let startGameButton = SKSpriteNode(imageNamed: "newgamebtn")
        startGameButton.position = CGPointMake(size.width/2, size.height/2)
        startGameButton.name = "startgame"
        addChild(startGameButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let touchLocation = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        if(touchedNode.name == "startgame") {
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            view?.presentScene(gameOverScene, transition: transitionType)
        }
    }
    
}