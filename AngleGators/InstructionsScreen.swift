//
//  InstructionsScreen.swift
//  AngleGators
//
//  Created by Alexandria Mack on 11/5/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

class InstructionsScreen: SKScene {
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "mainbackground")
        //alligatorLocation = CGPoint(x: frame.size.width * 0.1, y: frame.size.height * 0.5)
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        addChild(background)
        backgroundColor = SKColor.blackColor()
        
        let message = "How To Play"
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.text = message
        label.fontSize = 50
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2 + 80)
        addChild(label)
        
        let pointOfGame = SKLabelNode(fontNamed: "Courier")
        pointOfGame.text = "Open the mouth large enough to eat the fruit."
        pointOfGame.fontSize = 20
        pointOfGame.fontColor = SKColor.blackColor()
        pointOfGame.position = CGPoint(x: size.width/2, y: size.height/2 + 50)
        addChild(pointOfGame)
        
        let open = SKLabelNode(fontNamed: "Courier")
        open.text = "Tap the left side of the screen to open more."
        open.fontSize = 20
        open.fontColor = SKColor.blackColor()
        open.position = CGPoint(x: size.width/2, y: size.height/2 + 20)
        addChild(open)
        
        let close = SKLabelNode(fontNamed: "Courier")
        close.text = "Tap the right side of the screen to close more."
        close.fontSize = 20
        close.fontColor = SKColor.blackColor()
        close.position = CGPoint(x: size.width/2, y: size.height/2 - 10)
        addChild(close)
        
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
