//
//  GameViewController.swift
//  HitTheTree
//
//  Created by Thao Doan on 6/21/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    // Properties
    var sceneView: SCNView!
    var scene: SCNScene!
    
    var ballNode: SCNNode! // Used to connect the ball to the code
    var selfieStickNode: SCNNode! // Control the camera
    
    // MotionControl properties
    var motion = MotionHelper()
    var motionForce = SCNVector3(0, 0, 0)
    
    var sounds : [String:SCNAudioSource] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupNodes()
        setupSounds()
    }
    
    // assign the scenview in the function
    func setupScene() {
        sceneView = self.view as! SCNView // The setting up the sceneview to the storyboard view
        sceneView.allowsCameraControl = true
        scene = SCNScene(named: "art.scnassets/MainScene.scn") // Loading the scene from the MainScene file
        sceneView.scene = scene // assigning the scene to sceneView
    }
    
    // Connect the ball and selfieStick with the properties in gameviewcontroller
    func setupNodes() {
        ballNode = scene.rootNode.childNode(withName: "ball", recursively: true)!
        selfieStickNode = scene.rootNode.childNode(withName: "selfieStick", recursively: true)!
    }
    
     // Settingup the sounds
    func setupSounds() {
        let sawSound = SCNAudioSource(fileNamed: "chainsaw.wav")!
        let jumpSound = SCNAudioSource(named: "jump.wav")!
         sawSound.load()
        jumpSound.load()
        sawSound.volume = 0.3
        jumpSound.volume = 0.4
        
        sounds["saw"] = sawSound
        sounds["jump"] = jumpSound
        
        let backgroundMusic = SCNAudioSource(fileNamed:"background.mp3")!
        backgroundMusic.volume = 0.1
        backgroundMusic.loops = true
        backgroundMusic.load()
        
        let musicPlayer = SCNAudioPlayer(source: backgroundMusic)
        ballNode.addAudioPlayer(musicPlayer)
    }
    
    // Make the ball jump
    func sceneViewTapped(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        
        let hitResults = sceneView.hitTest( location, options:nil)
        if hitResults.count > 0 {
            let result = hitResults.first
            if let node = result?.node{
                if node.name == "ball" {
                    let jumpSound = sounds["jump"]!
                    ballNode.runAction(SCNAction.playAudio(jumpSound, waitForCompletion: false))
                    ballNode.physicsBody?.applyForce(SCNVector3(x:0, y: 4,z: -2), asImpulse: true)
                    
                }
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
