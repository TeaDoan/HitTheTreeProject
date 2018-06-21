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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }
    
    func setupScene() {
        
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
