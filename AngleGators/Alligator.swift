//
//  Alligator.swift
//  AngleGators
//
//  Created by Alexandria Mack on 10/6/15.
//  Copyright © 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

class Alligator: SKSpriteNode {
    var images = ["gator0", "gator20", "gator45", "gator70", "gator90" ]
    
    init() {
        let texture = SKTexture(imageNamed: images[0])
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.physicsBody = SKPhysicsBody(rectangleOfSize: texture.size())
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Alligator
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Fruit
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func changeImage(location: Int) {
        self.texture = SKTexture(imageNamed: images[location])
    }
}