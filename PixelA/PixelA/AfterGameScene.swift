//
//  AfterGameScene.swift
//  PixelA
//
//  Created by Ha Ram Lee on 2016-11-05.
//  Copyright © 2016 Ha Ram Lee. All rights reserved.
//

import Foundation
import SpriteKit

class AfterGameScene: SKScene {
    
    
    
    init(size: CGSize, playerWon:Bool, killAllEnemy: Bool, diedByLava: Bool, killPrincess : Bool) {
        super.init(size: size)
        
        
        let gameOverLabel = SKLabelNode(fontNamed: "Optima-BoldItalic")
        gameOverLabel.fontSize = 50
        gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + self.frame.midY / 3 )
        
      
        
        let gameOverLabel2 = SKLabelNode(fontNamed: "AvenirNext-MediumItalic")
        gameOverLabel2.fontSize = 35
        gameOverLabel2.position = CGPoint(x: self.frame.midX, y: self.frame.midY / 2 )
        
        
        let gameOverLabel3 = SKLabelNode(fontNamed: "Baskerville-SemiBoldItalic")
        gameOverLabel3.fontSize = 27
        gameOverLabel3.position = CGPoint(x: self.frame.midX, y: self.frame.midY / 3 )
        
        
        let backButton = SKLabelNode(fontNamed: "Optima-BoldItalic")
        backButton.fontSize = 20
   
        backButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY + self.frame.midY / 1.25 )
        backButton.text = "BACK BUTTON"
        
        backButton.zPosition = 2
        backButton.name = "back_button"
        self.addChild(backButton)
        
        
        if playerWon {
            let background = SKSpriteNode(imageNamed: "win_background")
            background.position = CGPoint(x: self.frame.midX, y: self.frame.midY )
            background.zPosition = 0
            self.addChild(background)
            
            gameOverLabel.text = "YOU WIN!"
            gameOverLabel.fontColor = SKColor.black
            
            gameOverLabel2.text = "You got home, SAFE!"
            gameOverLabel2.fontColor = SKColor.black
            
            if(killAllEnemy == true) {
                gameOverLabel2.text = "You have killed all the dummy monsters!"
            }
            
            if killPrincess == true {
                gameOverLabel3.text = "But, YOU MURDERER! You have killed the princess!!!"
                gameOverLabel3.fontColor = SKColor.black
            }
            
            backButton.fontColor = SKColor.black
            
        }else{
            
            let background = SKSpriteNode(imageNamed: "darksoul_bg")
            background.position = CGPoint(x: self.frame.midX, y: self.frame.midY )
            background.zPosition = 0
            self.addChild(background)
            
            gameOverLabel.text = "You Have DIED!"
            
            
            gameOverLabel2.text = "You have died to those dummy monsters!"
            
            if diedByLava == true {
                gameOverLabel2.text = "You fell into the pit of lava..."
            }
            
            if killPrincess == true {
                gameOverLabel3.text = "But, At least you have killed the princess! NICE!"
            }
            
            backButton.fontColor = SKColor.white
        }
   
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        gameOverLabel2.zPosition = 1
        gameOverLabel2.name = "main"
        self.addChild(gameOverLabel2)
        gameOverLabel3.zPosition = 1
        self.addChild(gameOverLabel3)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        
        let node = self.atPoint(touchLocation)
        
        if node.name == "back_button" { // Right button
            let transition = SKTransition.reveal(with: .down, duration: 1.0)
            
            let nextScene = GameScene(fileNamed: "MainPage")
            nextScene?.scaleMode = SKSceneScaleMode.aspectFit
            
            scene?.view?.presentScene(nextScene!, transition: transition)
           
            
        } else {
        
            let scene = GameScene(fileNamed: "GameScene")
            
            let skView = self.view!
            
            scene?.scaleMode = SKSceneScaleMode.aspectFit
            skView.presentScene(scene)
        }
        
        
        

        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
