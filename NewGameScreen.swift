//
//  NewGameScreen.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/6/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

class NewGameScreen: SKScene {
        
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "mainbackground")
        //alligatorLocation = CGPoint(x: frame.size.width * 0.1, y: frame.size.height * 0.5)
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        addChild(background)
        let titleLabel = SKLabelNode(fontNamed: "Courier")
        titleLabel.text = "AngleGators"
        titleLabel.fontSize = 50
        titleLabel.fontColor = SKColor.blackColor()
        titleLabel.position = CGPoint(x: size.width/2, y: size.height/4 * 3)
        addChild(titleLabel)
        backgroundColor = SKColor.blackColor()
        let startGameButton = SKSpriteNode(imageNamed: "buttons/newgame.png")
        startGameButton.position = CGPointMake(frame.size.width/2, frame.size.height/5 * 3)
        startGameButton.name = "startgame"
        startGameButton.color = SKColor.clearColor()
        addChild(startGameButton)
        let creditsButton = SKSpriteNode(imageNamed: "buttons/credits")
        creditsButton.position = CGPointMake(size.width/4, size.height/5)
        creditsButton.name = "credits"
        creditsButton.color = SKColor.clearColor()
        addChild(creditsButton)
        let instructionsButton = SKSpriteNode(imageNamed: "buttons/instructions")
        instructionsButton.position = CGPointMake(size.width/4 * 3, size.height/5 * 2)
        instructionsButton.name = "instructions"
        instructionsButton.color = SKColor.clearColor()
        addChild(instructionsButton)
        let leaderboardButton = SKSpriteNode(imageNamed: "buttons/leaderboard")
        leaderboardButton.position = CGPointMake(size.width/4 * 3, size.height/5)
        leaderboardButton.name = "leaderboard"
        leaderboardButton.color = SKColor.clearColor()
        addChild(leaderboardButton)
        let optionsButton = SKSpriteNode(imageNamed: "buttons/modeselect")
        optionsButton.position = CGPointMake(size.width/4, size.height/5 * 2)
        optionsButton.name = "options"
        addChild(optionsButton)
        }
        
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            let touch = touches.first as UITouch!
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            if(touchedNode.name == "startgame") {
                gameMode = GameMode.Classic
                let gameOverScene = GameScene(size: size)
                gameOverScene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
                view?.presentScene(gameOverScene, transition: transitionType)
            }
            if(touchedNode.name == "credits") {
                let gameOverScene = CreditsScreen(size: size)
                gameOverScene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
                view?.presentScene(gameOverScene, transition: transitionType)
            }
            if(touchedNode.name == "instructions") {
                let gameOverScene = InstructionsScreen(size: size)
                gameOverScene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
                view?.presentScene(gameOverScene, transition: transitionType)
            }
            if(touchedNode.name == "leaderboard") {
                let gameOverScene = LeaderBoardScreen(size: size)
                gameOverScene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
                view?.presentScene(gameOverScene, transition: transitionType)
            }
            if(touchedNode.name == "options") {
                //let gameOverScene = ModeSelectScreen(size: size)
                // Temporarily set to newgame so people don't get upset when the other modes don't work
                let gameOverScene = GameScene(size: size)
                gameOverScene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
                view?.presentScene(gameOverScene, transition: transitionType)
            }
        }
}
