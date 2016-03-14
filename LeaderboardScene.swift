//
//  LeaderboardScene.swift
//  AngleGators
//
//  Created by Alexandria Mack on 2/28/16.
//  Copyright © 2016 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

class LeaderBoardScreen: SKScene {
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "mainbackground")
        //alligatorLocation = CGPoint(x: frame.size.width * 0.1, y: frame.size.height * 0.5)
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        addChild(background)
        //backgroundColor = SKColor.blackColor()
        
        let message = "Local Leader Board"
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.text = message
        label.fontSize = 50
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2 + 80)
        addChild(label)
        
        let score1 = SKLabelNode(fontNamed: "Courier")
        score1.text = "1: \(highScores[0])"
        score1.fontSize = 30
        score1.fontColor = SKColor.blackColor()
        score1.position = CGPoint(x: size.width/4, y: size.height/2 + 40)
        addChild(score1)
        
        let score2 = SKLabelNode(fontNamed: "Courier")
        score2.text = "2: \(highScores[1])"
        score2.fontSize = 30
        score2.fontColor = SKColor.blackColor()
        score2.position = CGPoint(x: size.width/4, y: size.height/2 + 10)
        addChild(score2)
        
        let score3 = SKLabelNode(fontNamed: "Courier")
        score3.text = "3: \(highScores[2])"
        score3.fontSize = 30
        score3.fontColor = SKColor.blackColor()
        score3.position = CGPoint(x: size.width/4, y: size.height/2 - 20)
        addChild(score3)
        
        
        let startGameButton = SKSpriteNode(imageNamed: "buttons/back")
        startGameButton.position = CGPointMake(size.width/4, size.height/6)
        startGameButton.name = "back"
        addChild(startGameButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        let touchLocation = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        if(touchedNode.name == "back") {
            let gameOverScene = NewGameScreen(size: size)
            gameOverScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
            view?.presentScene(gameOverScene, transition: transitionType)
        }
    }
}
