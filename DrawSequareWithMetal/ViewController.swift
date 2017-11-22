//
//  ViewController.swift
//  DrawSequareWithMetal
//
//  Created by 刘李斌 on 2017/11/21.
//  Copyright © 2017年 Brilliance. All rights reserved.
//

import UIKit
import MetalKit

class ViewController: UIViewController {

    //创建mtkview
    var metalView: MTKView {
        return view as! MTKView
    }
    
    var render: Renderer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        metalView.device = MTLCreateSystemDefaultDevice()
        guard let device = metalView.device else { return  }
        
        metalView.clearColor = MTLClearColorMake(0, 0.4, 0, 1)
        
        render = Renderer(device: device)
        
        metalView.delegate = render
        
        render?.scene = GameScene(device: device, size: view.bounds.size)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

