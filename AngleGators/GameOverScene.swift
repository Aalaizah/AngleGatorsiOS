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
        
        let background = SKSpriteNode(imageNamed: "mainbackground")
        //alligatorLocation = CGPoint(x: frame.size.width * 0.1, y: frame.size.height * 0.5)
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        addChild(background)
        backgroundColor = SKColor.blackColor()
        
        let message = "Game Over. Final Score: \(score)"
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.text = message
        label.fontSize = 30
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/4 * 3)
        addChild(label)
        
        let startGameButton = SKSpriteNode(imageNamed: "buttons/replay")
        startGameButton.position = CGPointMake(size.width/4, size.height/2)
        startGameButton.name = "retry"
        addChild(startGameButton)
        
        let newModeButton = SKSpriteNode(imageNamed: "buttons/modeselect")
        newModeButton.position = CGPointMake(size.width/4 * 3, size.height/2)
        newModeButton.name = "newMode"
        addChild(newModeButton)
        
        let mainMenuButton = SKSpriteNode(imageNamed: "buttons/mainmenu")
        mainMenuButton.position = CGPointMake(size.width/4, size.height/6)
        mainMenuButton.name = "mainmenu"
        addChild(mainMenuButton)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let touchLocation = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        if(touchedNode.name == "retry") {
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            view?.presentScene(gameOverScene, transition: transitionType)
        }
        if(touchedNode.name == "newMode") {
            //let gameOverScene = ModeSelectScreen(size: size)
            // goes to classic til I add in other game modes
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            view?.presentScene(gameOverScene, transition: transitionType)
        }
        if(touchedNode.name == "mainmenu") {
            let gameOverScene = NewGameScreen(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            view?.presentScene(gameOverScene, transition: transitionType)
        }
    }
    
}