//
//  OptionsScene.swift
//  AngleGators
//
//  Created by Alexandria Mack on 2/28/16.
//  Copyright © 2016 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

class ModeSelectScreen: SKScene {
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "mainbackground")
        //alligatorLocation = CGPoint(x: frame.size.width * 0.1, y: frame.size.height * 0.5)
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        addChild(background)
        let titleLabel = SKLabelNode(fontNamed: "Courier")
        titleLabel.text = "Choose a Mode"
        titleLabel.fontSize = 50
        titleLabel.fontColor = SKColor.blackColor()
        titleLabel.position = CGPoint(x: size.width/2, y: size.height/5 * 4)
        addChild(titleLabel)
        backgroundColor = SKColor.blackColor()
        let classicButton = SKSpriteNode(imageNamed: "buttons/classic")
        classicButton.position = CGPointMake(size.width/4 * 3, size.height/5 * 3)
        classicButton.name = "classic"
        addChild(classicButton)
        let fifteensButton = SKSpriteNode(imageNamed: "buttons/fifteens")
        fifteensButton.position = CGPointMake(size.width/4 * 3, size.height/5 * 2)
        fifteensButton.name = "fifteens"
        addChild(fifteensButton)
        let thirtiesButton = SKSpriteNode(imageNamed: "buttons/thirties")
        thirtiesButton.position = CGPointMake(size.width/4 * 3, size.height/5)
        thirtiesButton.name = "thirties"
        addChild(thirtiesButton)
        let mainMenuButton = SKSpriteNode(imageNamed: "buttons/mainmenu")
        mainMenuButton.position = CGPointMake(size.width/4, size.height/5)
        mainMenuButton.name = "mainmenu"
        addChild(mainMenuButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let touchLocation = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        if(touchedNode.name == "classic") {
            gameMode = GameMode.Classic
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            view?.presentScene(gameOverScene, transition: transitionType)
        }
        if(touchedNode.name == "fifteens") {
            gameMode = GameMode.Fifteens
            let gameOverScene = GameScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            view?.presentScene(gameOverScene, transition: transitionType)
        }
        if(touchedNode.name == "thirties") {
            gameMode = GameMode.Thirties
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