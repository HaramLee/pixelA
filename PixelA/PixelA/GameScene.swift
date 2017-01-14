//
//  GameScene.swift
//  PixelA
//
//  Created by Ha Ram Lee on 2016-11-04.
//  Copyright © 2016 Ha Ram Lee. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
 
    
   //variable
    var mainPlayer = SKSpriteNode()
    var princessNPC = SKSpriteNode()
    var endPoint = SKSpriteNode()
    var playerHP: Int = 1;
    
    //Gameplay, slash and score point
    var gamePlay: Bool = true
    //var slashing: Bool = false
    var score: Int = 0
    var scoreNode = SKLabelNode()
    var hpNode = SKLabelNode()
    var enemyNumber: Int = 0;
    
    //Camera
    var cameraNode = SKCameraNode()
    var cameraXDifference = CGFloat()
    
    //Player States
    enum heroStates: Int {
        //side side
        case runningRight = 1
        case jumpWhileRunningRight = 2
        case standFacingRight = 3
        case jumpWhileStandingAndFacingRight = 4
        //left side
        case runningLeft = 5
        case jumpWhileRunningLeft = 6
        case standFacingLeft = 7
        case jumpWhileStandingAndFacingLeft = 8
    }
    
    //Category Bit Masks
    let playerGroup: UInt32 = 0x1 << 0
    let groundGroup: UInt32 = 0x1 << 1
    let obstacleGroup: UInt32 = 0x1 << 2
    let enemyGroup: UInt32 = 0x1 << 3
    let endPointGroup: UInt32 = 0x1 << 4
    let slashGroup: UInt32 = 0x1 << 5
    let groundGapGroup: UInt32 = 0x1 << 6
    let verticalObstacleGroup: UInt32 = 0x1 << 7
    let boundaryGroup: UInt32 = 0x1 << 8
    let princessGroup: UInt32 = 0x1 << 9
    
    //Object Z Position
    enum objectZPositions: CGFloat {
        
        case background = 0
        case obstacles = 1
        case ground = 3
        case groundGap = 2
        case verticalObstables = 4
        case enemy = 5
        case controls = 6
        case slash = 7
        case player = 8
        case endPoint = 9
        case labelNodes = 10
        case boundary = 11
        case camera = 12
        case princess = 13
        
    }
    
    //Win-condition
    var gotHome : Bool = false
    var killAllEnemy : Bool = false
    var killPrincess : Bool = false
    var diedByLava : Bool = false
    
    //Sounds
    var gameBackground = SKAction.playSoundFileNamed("bgSound.mp3", waitForCompletion: true)
    var gameMusic: SKAudioNode!
    //var backgroundMusic = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: Bundle.mainBundle.pathForResource("bgSound", ofType:"mp3")!), error:nil)
    var backgroundMusic: AVAudioPlayer!
    
    //Player definition START
    var playerStatus = Int()
    
    //Right direction texture
    let rightTexture1: SKTexture = SKTexture(imageNamed: "running_1")
    let rightTexture2: SKTexture = SKTexture(imageNamed: "running_2")
    let rightTexture3: SKTexture = SKTexture(imageNamed: "running_3")
    let rightTexture4: SKTexture = SKTexture(imageNamed: "running_4")
    let rightTexture5: SKTexture = SKTexture(imageNamed: "running_5")
    let rightTextureStill: SKTexture = SKTexture(imageNamed: "running_0")
    
    //Right slashing texture
    let rightSlashTexture1: SKTexture = SKTexture(imageNamed: "attack_0")
    let rightSlashTexture2: SKTexture = SKTexture(imageNamed: "attack_1")
    let rightSlashTexture3: SKTexture = SKTexture(imageNamed: "attack_2")
    let rightSlashTexture4: SKTexture = SKTexture(imageNamed: "attack_3")
    let rightSlashTexture5: SKTexture = SKTexture(imageNamed: "attack_4")
    
    var isJumping: Bool = false
    
    
    //Slash ball texture
    let fireballTexture1: SKTexture = SKTexture(imageNamed: "shot_1")
    let fireballTexture2: SKTexture = SKTexture(imageNamed: "shot_2")
    let fireballTexture3: SKTexture = SKTexture(imageNamed: "shot_3")
    let fireballTexture4: SKTexture = SKTexture(imageNamed: "shot_4")
    let fireballTexture5: SKTexture = SKTexture(imageNamed: "shot_5")
    let fireballTexture6: SKTexture = SKTexture(imageNamed: "shot_6")
    let fireballTexture7: SKTexture = SKTexture(imageNamed: "shot_7")
    let fireballTexture8: SKTexture = SKTexture(imageNamed: "shot_8")
    let fireballTexture9: SKTexture = SKTexture(imageNamed: "shot_9")
    let fireballTexture10: SKTexture = SKTexture(imageNamed: "shot_10")
    let fireballTexture11: SKTexture = SKTexture(imageNamed: "shot_11")

    

    
    func attack(_ direction: String){
        if direction == "right" {
    
            let rightAnimation = SKAction.animate(with: [rightSlashTexture2, rightSlashTexture3, rightSlashTexture4,rightSlashTexture5,rightTextureStill], timePerFrame: 0.06)
            
            mainPlayer.xScale = 1

            mainPlayer.run(rightAnimation)
            
    
        } else if direction == "left" {
    
            let rightAnimation = SKAction.animate(with: [rightSlashTexture2, rightSlashTexture3, rightSlashTexture4,rightSlashTexture5,rightTextureStill], timePerFrame: 0.06)
            
            mainPlayer.xScale = -1
    
            mainPlayer.run(rightAnimation)
    
        }
    }
    
    
    func run(_ direction: String) {
        
        if direction == "right" {
            
            let rightAnimation = SKAction.animate(with: [rightTexture1, rightTexture2, rightTexture3, rightTexture4, rightTexture5], timePerFrame: 0.08)
            let rightAnimationContinuous = SKAction.repeatForever(rightAnimation)
            
            let moveRight = SKAction.moveBy(x: 15, y: 0, duration: 0.1)
            let moveRightForEver = SKAction.repeatForever(moveRight)
            mainPlayer.xScale = 1
            mainPlayer.run(SKAction.group([rightAnimationContinuous, moveRightForEver]), withKey: "runningRight")
            
            
        } else if direction == "left" {
            
            let rightAnimation = SKAction.animate(with: [rightTexture1, rightTexture2, rightTexture3, rightTexture4, rightTexture5], timePerFrame: 0.08)
            let rightAnimationContinuous = SKAction.repeatForever(rightAnimation)
            
            let moveRight = SKAction.moveBy(x: -15, y: 0, duration: 0.1)
            let moveRightForEver = SKAction.repeatForever(moveRight)
            
            mainPlayer.xScale = -1
            mainPlayer.run(SKAction.group([rightAnimationContinuous, moveRightForEver]), withKey: "runningLeft")
            
            
        }

        
    }

    func stop(_ direction: String) {
        
        if direction == "right" {
            
            mainPlayer.removeAllActions()
            mainPlayer.texture = rightTextureStill
            mainPlayer.xScale = 1
            
        } else if direction == "left" {
            
            mainPlayer.removeAllActions()
            
            mainPlayer.texture = rightTextureStill
            mainPlayer.xScale = -1
        }

        
    }
    
    func jump(_ direction: String) {
        
        if isJumping == false {
            
            if direction == "right" {
                mainPlayer.removeAllActions()
                mainPlayer.xScale = 1
                self.mainPlayer.texture = self.rightTexture4
                self.mainPlayer.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 65))
                
            } else if direction == "left" {
                mainPlayer.removeAllActions()
                mainPlayer.xScale = -1
                self.mainPlayer.texture = self.rightTexture4
                self.mainPlayer.physicsBody?.applyImpulse(CGVector(dx: -15, dy: 65))
                
            } else if direction == "standingRight" {
                self.mainPlayer.texture = self.rightTexture4
                mainPlayer.xScale = 1
                self.mainPlayer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
                
            } else if direction == "standingLeft" {
                
                self.mainPlayer.texture = self.rightTexture4
                mainPlayer.xScale = -1
                self.mainPlayer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
                
            }
            
            isJumping = true
            
            
        }

        
    }
    
    func stopJump(_ direction: String) {
        
        if direction == "right" {
            self.mainPlayer.removeAllActions()
            self.mainPlayer.texture = self.rightTextureStill
            mainPlayer.xScale = 1
            
        } else if direction == "left" {
            self.mainPlayer.removeAllActions()
            self.mainPlayer.texture = self.rightTextureStill
            mainPlayer.xScale = -1

        }
        
        isJumping = false
        
    }
    

    
    override func didMove(to view: SKView) {
        enemyNumber = 0
        // Adding Music
        //self.run(SKAction.repeatForever(gameBackground), withKey: "runsound")
        //gameMusic = SKAudioNode(fileNamed: "bgSound.mp3")
        //self.addChild(gameMusic)
        let path = Bundle.main.path(forResource: "bgSound.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            backgroundMusic = sound
            sound.play()
        } catch {
            
        }
        
        
        // Physics World
        self.physicsWorld.contactDelegate = self
        
    
        // Player Object
        let playerSpawnPoint = childNode(withName: "playerStartPoint")
        mainPlayer = SKSpriteNode(texture: rightTextureStill)
        mainPlayer.name = "player"
        
        mainPlayer.position = playerSpawnPoint!.position
        playerSpawnPoint?.removeFromParent()
        
        mainPlayer.zPosition = objectZPositions.player.rawValue
        mainPlayer.physicsBody = SKPhysicsBody(rectangleOf: mainPlayer.size)
        mainPlayer.physicsBody?.allowsRotation = false
        
        mainPlayer.physicsBody?.categoryBitMask = playerGroup
        mainPlayer.physicsBody?.collisionBitMask = groundGroup | obstacleGroup | enemyGroup | endPointGroup | boundaryGroup
        mainPlayer.physicsBody?.contactTestBitMask = enemyGroup | endPointGroup  | groundGapGroup
        self.addChild(mainPlayer)
        
        playerStatus = heroStates.standFacingRight.rawValue
        
        // Setup Camera
        cameraNode = childNode(withName: "cameraNode") as! SKCameraNode
        cameraNode.zPosition = objectZPositions.camera.rawValue
        view.scene!.camera = cameraNode
        
        // Setup Control
        cameraNode.enumerateChildNodes(withName: "//control_[0-9]*") { (node, stop) -> Void in
            node.zPosition = objectZPositions.controls.rawValue
        }
        
        // Score Node
        scoreNode = cameraNode.childNode(withName: "scoreNode") as! SKLabelNode
        //scoreNode.zPosition = objectZPositions.score.rawValue
        
        // HP Node
        hpNode = cameraNode.childNode(withName: "hpNode") as! SKLabelNode
        hpNode.text = "HP: \(playerHP)"
        
        
        // Setup Ground
        self.enumerateChildNodes(withName: "//ground_[0-9]*") { (node, stop) -> Void in
            
            node.zPosition = objectZPositions.ground.rawValue
            node.physicsBody?.categoryBitMask = self.groundGroup
            node.physicsBody?.collisionBitMask = self.playerGroup | self.enemyGroup | self.obstacleGroup | self.slashGroup
            node.physicsBody?.contactTestBitMask = self.playerGroup | self.slashGroup
            
            
        }
        
        // Vertical Obstacles
        
        self.enumerateChildNodes(withName: "//verticalObstacle_[0-9]*") { (node, stop) -> Void in
            
            node.physicsBody?.categoryBitMask = self.verticalObstacleGroup
            node.physicsBody?.collisionBitMask = self.enemyGroup
            node.physicsBody?.contactTestBitMask = self.enemyGroup
            node.zPosition = objectZPositions.verticalObstables.rawValue
            node.alpha = 0
            
            
        }
        
        
        // Enemies
        self.enumerateChildNodes(withName: "//enemyStart_[0-9]*") { (node, stop) -> Void in
            
            let enemy = Enemy(initialPosition: node.position)
            node.removeFromParent()
            
            enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, alphaThreshold: 0, size: (enemy.texture?.size())!)
            
            enemy.physicsBody?.categoryBitMask = self.enemyGroup
            enemy.physicsBody?.collisionBitMask = self.playerGroup | self.groundGroup | self.obstacleGroup |  self.verticalObstacleGroup | self.slashGroup
            enemy.physicsBody?.contactTestBitMask = self.playerGroup | self.obstacleGroup  | self.verticalObstacleGroup | self.slashGroup
            enemy.physicsBody?.allowsRotation = false
            enemy.zPosition = objectZPositions.enemy.rawValue
            self.addChild(enemy)
            self.enemyNumber += 1
            
        }
        
        
        
        // Princess Object
        let princessSpawnPoint = childNode(withName: "princessStart_1")
        let princess = Princess(initialPosition: princessSpawnPoint!.position)
       
        princessSpawnPoint?.removeFromParent()
        princess.physicsBody = SKPhysicsBody(texture: princess.texture!, alphaThreshold: 0, size: (princess.texture?.size())!)
        
        princess.physicsBody?.categoryBitMask = self.princessGroup
        princess.physicsBody?.collisionBitMask = self.groundGroup | self.playerGroup |  self.verticalObstacleGroup | self.slashGroup
        princess.physicsBody?.contactTestBitMask = self.playerGroup | self.obstacleGroup  | self.verticalObstacleGroup | self.slashGroup
        princess.physicsBody?.allowsRotation = false
        princess.zPosition = objectZPositions.princess.rawValue
        self.addChild(princess)
        
        
        // Ground Gaps
        self.enumerateChildNodes(withName: "//groundGap_[0-9]*") { (node, stop) -> Void in
            
            node.physicsBody?.categoryBitMask = self.groundGapGroup
            node.physicsBody?.collisionBitMask = self.playerGroup
            node.physicsBody?.contactTestBitMask = self.playerGroup
            node.zPosition = objectZPositions.groundGap.rawValue
            
            
        }
        
        // Player Boundaries
        
        self.enumerateChildNodes(withName: "//boundary_[0-9]*") { (node, stop) -> Void in
            
            node.physicsBody?.categoryBitMask = self.boundaryGroup
            node.physicsBody?.collisionBitMask = self.playerGroup
            node.alpha = 0
        }
        

        
        // Setup end point
        endPoint = childNode(withName: "endPlatform") as! SKSpriteNode
        endPoint.physicsBody?.categoryBitMask = endPointGroup
        endPoint.physicsBody?.contactTestBitMask = playerGroup
        
        
        
        // For Camera Movement
        cameraXDifference = cameraNode.position.x - mainPlayer.position.x
        
    }
    var manLeft = false
    var manRight = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        
        let node = self.atPoint(touchLocation)
        
        
        if node.name == "home_button" { // Home button
            let transition = SKTransition.reveal(with: .down, duration: 1.0)
            
            let nextScene = GameScene(fileNamed: "MainPage")
            nextScene?.scaleMode = SKSceneScaleMode.aspectFit
            
            scene?.view?.presentScene(nextScene!, transition: transition)
            
            
        }
        
        if node.name == "control_2" { // Right button
            manLeft = false
            manRight = true
            
            if playerStatus == heroStates.standFacingRight.rawValue || playerStatus == heroStates.standFacingLeft.rawValue {
                
                run("right")
                playerStatus = heroStates.runningRight.rawValue
                
            }
            
        }
        if node.name == "control_1" { // Left Button
            manLeft = true
            manRight = false
            
            if playerStatus == heroStates.standFacingLeft.rawValue || playerStatus == heroStates.standFacingRight.rawValue {
                
                run("left")
                playerStatus = heroStates.runningLeft.rawValue
                
            }
            
        }
        
        if node.name == "control_3" { // Jump Button
            
            if playerStatus == heroStates.standFacingRight.rawValue {
                
                jump("standingRight")
                playerStatus = heroStates.jumpWhileStandingAndFacingRight.rawValue
                
            } else if playerStatus == heroStates.standFacingLeft.rawValue {
                
                jump("standingLeft")
                playerStatus = heroStates.jumpWhileStandingAndFacingLeft.rawValue
                
            } else if playerStatus == heroStates.runningLeft.rawValue {
                
                jump("left")
                playerStatus = heroStates.jumpWhileRunningLeft.rawValue
                
            } else if playerStatus == heroStates.runningRight.rawValue {
                
                jump("right")
                playerStatus = heroStates.jumpWhileRunningRight.rawValue
            }
            isJumping = true
            
        }
        
        if node.name == "control_4" { // slash blast
            
                
                //self.run(firesound)
             let fireAnimation = SKAction.animate(with: [fireballTexture1, fireballTexture2, fireballTexture3,fireballTexture4,fireballTexture5, fireballTexture6, fireballTexture7, fireballTexture8,fireballTexture9,fireballTexture10, fireballTexture11], timePerFrame: 0.06)
            var fireDirection : Bool = true
            let fire = SKSpriteNode(imageNamed: "shot_1")
            fire.size = CGSize(width: 35  , height: 35)
            fire.zPosition = objectZPositions.slash.rawValue
            fire.position = mainPlayer.position
            
            
                if playerStatus == heroStates.standFacingRight.rawValue || playerStatus == heroStates.jumpWhileStandingAndFacingRight.rawValue || playerStatus == heroStates.jumpWhileRunningRight.rawValue || playerStatus == heroStates.runningRight.rawValue {
                    
                    fireDirection = true
                    fire.position.x += 30
                    
                } else if playerStatus == heroStates.standFacingLeft.rawValue || playerStatus == heroStates.jumpWhileStandingAndFacingLeft.rawValue || playerStatus == heroStates.jumpWhileRunningLeft.rawValue || playerStatus == heroStates.runningLeft.rawValue {
                    
                    fireDirection = false
                    fire.position.x -= 30
                }
                
            
                fire.physicsBody = SKPhysicsBody(circleOfRadius: 6)
          
                fire.physicsBody?.affectedByGravity = false
                fire.physicsBody?.categoryBitMask = slashGroup
                fire.physicsBody?.contactTestBitMask = groundGroup | enemyGroup | obstacleGroup
                fire.physicsBody?.collisionBitMask = enemyGroup | groundGroup | obstacleGroup
                self.addChild(fire)
                //slashing = true
                let animationDuration: TimeInterval = 0.7
            
            var actionArray = [SKAction]()
            
            if fireDirection == true {
                actionArray.append(SKAction.move(to: CGPoint(x: mainPlayer.position.x + self.frame.size.width / 2.5 , y: mainPlayer.position.y), duration: animationDuration))
                actionArray.append(SKAction.removeFromParent())
                attack("right")
                fire.xScale = 1
            } else {
                actionArray.append(SKAction.move(to: CGPoint(x: mainPlayer.position.x - self.frame.size.width / 2.5 , y: mainPlayer.position.y), duration: animationDuration))
                actionArray.append(SKAction.removeFromParent())
                attack("left")
                fire.xScale = -1
            }
            fire.run(SKAction.sequence(actionArray))
            fire.run(fireAnimation)
        }
  
        
    }
    
    func checkJumpContacts() {
        
        if playerStatus == heroStates.jumpWhileRunningRight.rawValue || playerStatus == heroStates.runningRight.rawValue {
            
            run("right")
            playerStatus = heroStates.runningRight.rawValue
            isJumping = false
            
        } else if playerStatus == heroStates.jumpWhileRunningLeft.rawValue || playerStatus == heroStates.runningLeft.rawValue {
            
            run("left")
            playerStatus = heroStates.runningLeft.rawValue
            isJumping = false
            
        }else if playerStatus == heroStates.jumpWhileStandingAndFacingRight.rawValue || playerStatus == heroStates.standFacingRight.rawValue {
            
            stop("right")
            playerStatus = heroStates.standFacingRight.rawValue
            isJumping = false
            
        }else if playerStatus == heroStates.jumpWhileStandingAndFacingLeft.rawValue || playerStatus == heroStates.standFacingLeft.rawValue {
            
            
            stop("left")
            playerStatus = heroStates.standFacingLeft.rawValue
            isJumping = false
            
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        
        // Jump
        if (contact.bodyA.categoryBitMask == playerGroup && contact.bodyB.categoryBitMask == groundGroup) || (contact.bodyB.categoryBitMask == playerGroup && contact.bodyA.categoryBitMask == groundGroup) {
            
            checkJumpContacts()

        }
        
        // EnemyMovement
        if ((contact.bodyA.categoryBitMask == verticalObstacleGroup || contact.bodyA.categoryBitMask == obstacleGroup) && contact.bodyB.categoryBitMask == enemyGroup) || ((contact.bodyB.categoryBitMask == verticalObstacleGroup || contact.bodyB.categoryBitMask == obstacleGroup) && contact.bodyA.categoryBitMask == enemyGroup) {
            
            if contact.bodyA.categoryBitMask == enemyGroup {
                let enemyNode = contact.bodyA.node! as! Enemy
                enemyNode.move()
            }else {
                let enemyNode = contact.bodyB.node! as! Enemy
                enemyNode.move()
            }

            
        }
        
        if ((contact.bodyA.categoryBitMask == verticalObstacleGroup || contact.bodyA.categoryBitMask == obstacleGroup) && contact.bodyB.categoryBitMask == princessGroup) || ((contact.bodyB.categoryBitMask == verticalObstacleGroup || contact.bodyB.categoryBitMask == obstacleGroup) && contact.bodyA.categoryBitMask == princessGroup) {
            
    
            if contact.bodyA.categoryBitMask == princessGroup {
                let princessNode = contact.bodyA.node! as! Princess
                princessNode.move()
            } else {
                let princessNode = contact.bodyB.node! as! Princess
                princessNode.move()
            }
            
        }
        
        
        
        // Enemy contact
        if (contact.bodyA.categoryBitMask == playerGroup && contact.bodyB.categoryBitMask == enemyGroup) || (contact.bodyB.categoryBitMask == playerGroup && contact.bodyA.categoryBitMask == enemyGroup) {
            
            if contact.bodyA.categoryBitMask == enemyGroup {
                contact.bodyA.node?.removeFromParent()
                updateHP()
                enemyNumber -= 1
            }else if contact.bodyB.categoryBitMask == enemyGroup{
                contact.bodyB.node?.removeFromParent()
                updateHP()
                enemyNumber -= 1
            }
            
            if playerHP == 0 {
                mainPlayer.removeFromParent()
                removeSong()
                let gameOverScene = AfterGameScene(size: self.frame.size, playerWon:false , killAllEnemy: false, diedByLava: false, killPrincess : killPrincess)
                self.view?.presentScene(gameOverScene)
            }
        }
        
        // Ground Gap
        if (contact.bodyA.categoryBitMask == playerGroup && contact.bodyB.categoryBitMask == groundGapGroup) || (contact.bodyB.categoryBitMask == playerGroup && contact.bodyA.categoryBitMask == groundGapGroup) {
            mainPlayer.removeFromParent()
            removeSong()
            let gameOverScene = AfterGameScene(size: self.frame.size, playerWon:false , killAllEnemy: false , diedByLava: true, killPrincess : killPrincess)
            self.view?.presentScene(gameOverScene)
        }
        
        // End point
        if (contact.bodyA.categoryBitMask == playerGroup && (contact.bodyB.categoryBitMask == endPointGroup )) || (contact.bodyB.categoryBitMask == playerGroup && (contact.bodyA.categoryBitMask == endPointGroup )) {
            mainPlayer.removeFromParent()
            removeSong()
            let youWinScene = AfterGameScene(size: self.frame.size, playerWon: true, killAllEnemy: false, diedByLava: false, killPrincess : killPrincess)
            self.view?.presentScene(youWinScene)
        }
        
        
        // Fire Contact
        if contact.bodyA.categoryBitMask == slashGroup || contact.bodyB.categoryBitMask == slashGroup {
            
            if contact.bodyA.categoryBitMask == slashGroup {
                contact.bodyA.node?.removeFromParent()
                
                if contact.bodyB.categoryBitMask == enemyGroup {
                    
             
                    //let postionNode = contact.bodyB.node?.position
                    contact.bodyB.node?.removeFromParent()
                    
                    //explode(enemyPosition: postionNode!)
                    
                    
      
                    updateScore()
                    enemyNumber -= 1
                    
                }
                
                if contact.bodyB.categoryBitMask == princessGroup {
                    
                    
                    
                    //let postionNode = contact.bodyB.node?.position
                    contact.bodyB.node?.removeFromParent()
                    killPrincess = true
                    //explode(enemyPosition: postionNode!)
                    
                    
                }
                
            } else if contact.bodyB.categoryBitMask == slashGroup {
                
                contact.bodyB.node?.removeFromParent()
                
                if contact.bodyA.categoryBitMask == enemyGroup {
                    
                    
                    //let postionNode = contact.bodyA.node?.position
                    contact.bodyA.node?.removeFromParent()
                    //explode(enemyPosition: postionNode!)
                    
                    
            
                    updateScore()
                    enemyNumber -= 1
                }
                
                if contact.bodyA.categoryBitMask == princessGroup {
                    
                    
                    //let postionNode = contact.bodyA.node?.position
                    contact.bodyA.node?.removeFromParent()
                    killPrincess = true
                    //explode(enemyPosition: postionNode!)
                    
                }
                
            }

            
        }
        
        if (enemyNumber == 0){
            removeSong()
            mainPlayer.removeFromParent()
            let youWinScene = AfterGameScene(size: self.frame.size, playerWon: true, killAllEnemy: true, diedByLava: false, killPrincess : killPrincess)
            self.view?.presentScene(youWinScene)
            
        }
        
    }
    
    
    
    func explode(enemyPosition: CGPoint) {
        
        
        //Exploding texture
        
        let explodingTexture2: SKTexture = SKTexture(imageNamed: "explode_2")
        let explodingTexture3: SKTexture = SKTexture(imageNamed: "explode_3")
        let explodingTexture4: SKTexture = SKTexture(imageNamed: "explode_4")
        let explodingTexture5: SKTexture = SKTexture(imageNamed: "explode_5")
        let explodingTexture6: SKTexture = SKTexture(imageNamed: "explode_6")
        let explodingTexture7: SKTexture = SKTexture(imageNamed: "explode_7")
        let explodingTexture8: SKTexture = SKTexture(imageNamed: "explode_8")
        let explodingTexture9: SKTexture = SKTexture(imageNamed: "explode_9")
        let explodingTexture10: SKTexture = SKTexture(imageNamed: "explode_10")
        
        
        let explodeAnimation = SKAction.animate(with: [explodingTexture2, explodingTexture3,explodingTexture4,explodingTexture5, explodingTexture6, explodingTexture7, explodingTexture8,explodingTexture9,explodingTexture10 ], timePerFrame: 0.09)
        
        let explosion = SKSpriteNode(imageNamed: "explode_1")
        explosion.position = enemyPosition
        self.addChild(explosion)
        explosion.run(explodeAnimation)
        self.run(SKAction.wait(forDuration: 1.25)) {
            
            explosion.removeFromParent()
        }
        
        //self.removeFromParent()
    }
    
    func removeSong(){

        if backgroundMusic != nil {
            backgroundMusic.stop()
            backgroundMusic = nil
        }
    }
    
    func updateHP() {
        
        playerHP -= 1
        hpNode.text = "HP: \(playerHP)"
        
    }
    
    func updateScore() {
        
        score += 50
        scoreNode.text = "Score: \(score)"

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let touchLocation = touch.location(in: self)
        
        let node = self.atPoint(touchLocation)
        
        if node.name == "control_1"  {
            stop("left")
            playerStatus = heroStates.standFacingLeft.rawValue
        } else if node.name == "control_2" {
            stop("right")
            playerStatus = heroStates.standFacingRight.rawValue
        }
    }
    
    
//    override func update(_ currentTime: TimeInterval) {
//        //cameraNode.position.x += 10
//    }
    
    override func didFinishUpdate() {
        cameraNode.position.x = mainPlayer.position.x + cameraXDifference
        //cameraNode.position.y = mainPlayer.position.y + cameraXDifference
    }
    
/*
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
*/
    
}
