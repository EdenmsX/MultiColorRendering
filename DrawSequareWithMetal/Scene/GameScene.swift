//
//  GameScene.swift
//  DrawSequareWithMetal
//
//  Created by 刘李斌 on 2017/11/22.
//  Copyright © 2017年 Brilliance. All rights reserved.
//

import Foundation
import MetalKit

//主场景
class GameScene: Scene {
    //四边形
    var quad: Plane
    
    override init(device: MTLDevice, size: CGSize) {
        quad = Plane(device: device)
        super.init(device: device, size: size)
        
        add(childNode: quad)
    }
}
