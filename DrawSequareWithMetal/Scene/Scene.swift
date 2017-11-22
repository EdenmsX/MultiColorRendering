//
//  Scene.swift
//  DrawSequareWithMetal
//
//  Created by 刘李斌 on 2017/11/22.
//  Copyright © 2017年 Brilliance. All rights reserved.
//

import Foundation
import MetalKit

//场景
//在一个引擎中需要重复使用, 为了控制其大小
// 镜头,照明等操作都在这里处理
class Scene: Node {
    var device: MTLDevice
    var size: CGSize
    
    init(device: MTLDevice, size: CGSize) {
        self.device = device
        self.size = size
        super.init()
    }
}
