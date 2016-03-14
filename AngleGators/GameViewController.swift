//
//  GameViewController.swift
//  AngleGators
//
//  Created by Alexandria Mack on 9/20/15.
//  Copyright (c) 2015 Alexandria Mack. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = NewGameScreen(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
    
    func preferStatusBarHidden() -> Bool {
        return true
    }
}
