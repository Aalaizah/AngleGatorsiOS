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
    var images = [10: "gator0", 15: "gator20", 30: "gator20", 45: "gator45", 50: "gator45", 60: "gator70", 70: "gator70", 75: "gator70", 90: "gator90" ]
    
    init() {
        let texture = SKTexture(imageNamed: images[10]!)
        let textureSize = texture.size()
        let boxSize = CGSize(width: (textureSize.width / 3) * 2, height: textureSize.height)
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.physicsBody = SKPhysicsBody(rectangleOfSize: boxSize)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Alligator
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Fruit
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func changeImage(location: Int) {
        self.texture = SKTexture(imageNamed: images[location]!)
    }
}