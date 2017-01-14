//
//  Princess.swift
//  PixelA
//
//  Created by Ha Ram Lee on 2016-11-06.
//  Copyright © 2016 Ha Ram Lee. All rights reserved.
//

import Foundation

import SpriteKit

class Princess: SKSpriteNode {
    
    var right: Bool = true
    
    
    let princessTexture2: SKTexture = SKTexture(imageNamed: "princess_2")
    let princessTexture3: SKTexture = SKTexture(imageNamed: "princess_3")
    let princessTexture4: SKTexture = SKTexture(imageNamed: "princess_4")

    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let princessTexture = SKTexture(imageNamed: "princess_1")
        
        super.init(texture: princessTexture, color: UIColor.white, size: princessTexture.size())
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
            
            let rightAnimation = SKAction.animate(with: [princessTexture2, princessTexture3, princessTexture4], timePerFrame: 0.08)
            let rightAnimationContinuous = SKAction.repeatForever(rightAnimation)
            
            self.removeAllActions()
            let moveRight = SKAction.moveBy(x: 4, y: 0, duration: 0.1)
            let moveForEverToRight = SKAction.repeatForever(moveRight)
            self.xScale = -1
            self.run(SKAction.group([rightAnimationContinuous, moveForEverToRight]))
            
        } else {
            
            let rightAnimation = SKAction.animate(with: [princessTexture2, princessTexture3, princessTexture4], timePerFrame: 0.08)
            let rightAnimationContinuous = SKAction.repeatForever(rightAnimation)
            
            self.removeAllActions()
            
            self.xScale = 1
            let moveLeft = SKAction.moveBy(x: -4, y: 0, duration: 0.1)
            let moveForEverToLeft = SKAction.repeatForever(moveLeft)
            self.run(SKAction.group([rightAnimationContinuous, moveForEverToLeft]))
            
            
        }
        
        right = !right
        
    }
    
}
