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
            backgroundColor = SKColor.blackColor()
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
