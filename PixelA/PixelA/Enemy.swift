//
//  Enemy.swift
//  PixelA
//
//  Created by Ha Ram Lee on 2016-11-05.
//  Copyright © 2016 Ha Ram Lee. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    
    var right: Bool = true
    
  
    let enemyTexture2: SKTexture = SKTexture(imageNamed: "enemy_1-2")
    let enemyTexture3: SKTexture = SKTexture(imageNamed: "enemy_1-3")
    let enemyTexture4: SKTexture = SKTexture(imageNamed: "enemy_1-4")
    let enemyTexture5: SKTexture = SKTexture(imageNamed: "enemy_1-5")
    let enemyTexture6: SKTexture = SKTexture(imageNamed: "enemy_1-6")
    let enemyTexture7: SKTexture = SKTexture(imageNamed: "enemy_1-7")
    let enemyTexture8: SKTexture = SKTexture(imageNamed: "enemy_1-8")
    
 
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let enemyTexture = SKTexture(imageNamed: "enemy_1-1")
        super.init(texture: enemyTexture, color: UIColor.white, size: enemyTexture.size())
    }
    
    convenience init(initialPosition: CGPoint) {
        self.init()
        self.position = initialPosition
        
        move()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func move() {
        
        if right == true {
            
            let rightAnimation = SKAction.animate(with: [enemyTexture2, enemyTexture3, enemyTexture4, enemyTexture5, enemyTexture6,enemyTexture7,enemyTexture8], timePerFrame: 0.08)
            let rightAnimationContinuous = SKAction.repeatForever(rightAnimation)
            
            self.removeAllActions()
            let moveRight = SKAction.moveBy(x: 4, y: 0, duration: 0.1)
            let moveForEverToRight = SKAction.repeatForever(moveRight)
            self.run(SKAction.group([rightAnimationContinuous, moveForEverToRight]))
            
        } else {
            
            let rightAnimation = SKAction.animate(with: [enemyTexture2, enemyTexture3, enemyTexture4, enemyTexture5, enemyTexture6,enemyTexture7,enemyTexture8], timePerFrame: 0.08)
            let rightAnimationContinuous = SKAction.repeatForever(rightAnimation)
            
            self.removeAllActions()
            let moveLeft = SKAction.moveBy(x: -4, y: 0, duration: 0.1)
            let moveForEverToLeft = SKAction.repeatForever(moveLeft)
            self.run(SKAction.group([rightAnimationContinuous, moveForEverToLeft]))
            
            
        }
        
        right = !right
        
    }
 
}
