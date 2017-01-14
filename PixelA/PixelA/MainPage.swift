//
//  MainPage.swift
//  PixelA
//
//  Created by Ha Ram Lee on 2016-11-14.
//  Copyright © 2016 Ha Ram Lee. All rights reserved.
//

import SpriteKit
import GameplayKit


class MainPage: SKScene {
        
    
    override func didMove(to view: SKView) {

  
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            
            if let location = touches.first?.location(in: self) {
                let touchedNode = atPoint(location)
                
                if touchedNode.name == "start_button" {
                    
                    let transition = SKTransition.reveal(with: .down, duration: 1.0)
                    
                    let nextScene = GameScene(fileNamed: "GameScene")
                    nextScene?.scaleMode = SKSceneScaleMode.aspectFit
                    
                    scene?.view?.presentScene(nextScene!, transition: transition)
                }
            }
    }
        
}
  
    


