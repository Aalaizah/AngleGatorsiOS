//
//  CreditsScreen.swift
//  AngleGators
//
//  Created by Alexandria Mack on 11/5/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

class CreditsScreen: SKScene {
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "mainbackground")
        //alligatorLocation = CGPoint(x: frame.size.width * 0.1, y: frame.size.height * 0.5)
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        addChild(background)
        //backgroundColor = SKColor.blackColor()
        
        let message = "Credits"
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.text = message
        label.fontSize = 50
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2 + 80)
        addChild(label)
        
        let alexName = SKLabelNode(fontNamed: "Courier")
        alexName.text = "Programming and Design: Alexandria Mack"
        alexName.fontSize = 20
        alexName.fontColor = SKColor.blackColor()
        alexName.position = CGPoint(x: size.width/2, y: size.height/2 + 50)
        addChild(alexName)
        
        let jackieName = SKLabelNode(fontNamed: "Courier")
        jackieName.text = "Art: Jackie Wiley"
        jackieName.fontSize = 20
        jackieName.fontColor = SKColor.blackColor()
        jackieName.position = CGPoint(x: size.width/2, y: size.height/2 + 20)
        addChild(jackieName)
        
        let specialThanks = SKLabelNode(fontNamed: "Courier")
        specialThanks.text = "Special thanks:"
        specialThanks.fontSize = 20
        specialThanks.fontColor = SKColor.blackColor()
        specialThanks.position = CGPoint(x: size.width/2, y: size.height/2 - 10)
        addChild(specialThanks)
        
        let specialThanks2 = SKLabelNode(fontNamed: "Courier")
        specialThanks2.text = "Melody Kelly and William Russell"
        specialThanks2.fontSize = 20
        specialThanks2.fontColor = SKColor.blackColor()
        specialThanks2.position = CGPoint(x: size.width/2, y: size.height/2 - 30)
        addChild(specialThanks2)
        
        
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
