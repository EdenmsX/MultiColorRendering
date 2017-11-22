//
//  Node.swift
//  DrawSequareWithMetal
//
//  Created by 刘李斌 on 2017/11/22.
//  Copyright © 2017年 Brilliance. All rights reserved.
//

import Foundation
import MetalKit

class Node {
    //创建一个默认的名字
    var name = "Unitiled"
    //一个空数组,用来存放子节点
    var children: [Node] = []
    
    //增加节点的方法
    func add(childNode: Node) {
        children.append(childNode)
    }
    
    
    /// 处理每一个子节点
    ///
    /// - Parameters:
    ///   - commandEncoder: 编码器
    ///   - detailTime: 上一帧的时间
    func render(commandEncoder: MTLRenderCommandEncoder, detailTime: Float) {
        for child in children {
            child.render(commandEncoder: commandEncoder, detailTime: detailTime)
        }
    }
}
