//
//  Renderable.swift
//  DrawSequareWithMetal
//
//  Created by 刘李斌 on 2017/11/22.
//  Copyright © 2017年 Brilliance. All rights reserved.
//

import Foundation
import MetalKit


protocol Renderable {
    var pipelineState: MTLRenderPipelineState! {get set}
    var vertexFunctionName: String {get}
    var fragmentFunctionName: String {get}
    var vertexDescriptor: MTLVertexDescriptor {get}
}

extension Renderable {
    //处理管道状态
    func buildPipelineState(device: MTLDevice) -> MTLRenderPipelineState {
        //储存GPU中的事项
        let libary = device.makeDefaultLibrary()
        
        //调用metal中的方法
        //顶点操作
        let vertextFunction = libary?.makeFunction(name: vertexFunctionName)
        //上色操作
        let fragmentFunction = libary?.makeFunction(name: fragmentFunctionName)
        
        //创建蓝图
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertextFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        let pipelineState: MTLRenderPipelineState
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
            //画出三个顶点
        } catch let error as NSError {
            fatalError("error: \(error.localizedDescription)")
        }
        return pipelineState
    }
    
}
