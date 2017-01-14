//
//  ViewController.swift
//  PixelA
//
//  Created by Ha Ram Lee on 2016-11-14.
//  Copyright © 2016 Ha Ram Lee. All rights reserved.
//

import Foundation

import UIKit
import SpriteKit
import GameplayKit

class ViewController: UIViewController {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MainPage") {
                // Set the scale mode to scale to fit the window
                //scene.scaleMode = .aspectFill
                
                //scene.scaleMode = SKSceneScaleMode.aspectFill
                scene.scaleMode = SKSceneScaleMode.aspectFit
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
