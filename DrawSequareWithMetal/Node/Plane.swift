//
//  Plane.swift
//  DrawSequareWithMetal
//
//  Created by 刘李斌 on 2017/11/22.
//  Copyright © 2017年 Brilliance. All rights reserved.
//

import Foundation
import MetalKit

class Plane: Node {
    //优化 - 用两个数组相结合  vertices数组存放正方形的顶点坐标, indces数组存放每次使用vertices数组中的哪三组数据作为三角形的顶点就行绘制
//    var vertices: [Float] = [
//        -1,1,0,
//        -1,-1,0,
//        1,-1,0,
//        1,1,0
//    ]

    //告诉GPU把纹理的(0,1)位置对应到GPU的(-1,1)位置
    var vertices: [Vertex] = [
        Vertex(position: float3(-1,1,0), color: float4(1,0,0,1), texture: float2(0,1)),
        Vertex(position: float3(-1,-1,0), color: float4(0,1,0,1), texture: float2(0,0)),
        Vertex(position: float3(1,-1,0), color: float4(0,0,1,1), texture: float2(1,0)),
        Vertex(position: float3(1,1,0), color: float4(1,0,1,1), texture: float2(1,1)),
    ]
    
    var indces: [UInt16] = [
        0,1,2,
        2,3,0
    ]
    
    var vertexBuffer: MTLBuffer?
    
    //索引缓冲区
    var indexBuffer: MTLBuffer?
    
    //动画的一些参数
    //创建移动量
    struct Constants {
        var animateBy: Float = 0.0
    }
    
    var constant = Constants()
    
    var time: Float = 0
    
    //Renderable
    var pipelineState: MTLRenderPipelineState!
    var vertexFunctionName: String = "vertex_shader"
    var fragmentFunctionName: String = "fragment_shader"
    var vertexDescriptor: MTLVertexDescriptor = {
        //创建顶点蓝图
        //顶点的描述符  attributes最多有32个(0-31)
        let vertexDescriptor = MTLVertexDescriptor()
        
        /**
         关于偏移量的计算:
         第一个属性的偏移量为0, 第二个属性的偏移量就是第一个属性的长度(MemoryLayout<float3>.stride), 第三个属性的偏移量就是前两个属性的长度相加(MemoryLayout<float3>.stride + MemoryLayout<float4>.stride), 后面如果再有属性就依次类推
         */
        //位置
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        //颜色
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.stride
        vertexDescriptor.attributes[1].bufferIndex = 0
        //纹理
        vertexDescriptor.attributes[2].format = .float2
        vertexDescriptor.attributes[2].offset = MemoryLayout<float3>.stride + MemoryLayout<float4>.stride
        vertexDescriptor.attributes[2].bufferIndex = 0
        
        //整合前面的命令
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        //把顶点描述符传入
//        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        return vertexDescriptor
    }()
    
    //Textureable
    var texture: MTLTexture?
    
    
    //处理顶点
    func buildBuffer(device: MTLDevice){
        //创建顶点缓冲区,保存了顶点数组中的顶点位置
        //每一个条目都是一个float, 所以缓冲区的长度也就是顶点的数量
        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride, options: [])
        
        indexBuffer = device.makeBuffer(bytes: indces, length: indces.count * MemoryLayout<Float>.size, options: [])
    }
    
    init(device: MTLDevice) {
        super.init()
        buildBuffer(device: device)
        pipelineState = buildPipelineState(device: device)
    }
    
    //用来渲染顶点图片的初始化方法
    init(device: MTLDevice, imageName: String) {
        super.init()
        
//        self.texture = setTexture(device: device, imageName: imageName)
        
        if let texture = setTexture(device: device, imageName: imageName) {
            self.texture = texture
            fragmentFunctionName = "texture_shader"
        }
        
        buildBuffer(device: device)
        pipelineState = buildPipelineState(device: device)
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder, detailTime: Float) {
        super.render(commandEncoder: commandEncoder, detailTime: detailTime)
        
        //确认indexBuffer不为空
        guard let indexBuffer = indexBuffer else { return  }
        time += detailTime
        let animateBy = abs(sin(time) / 2 + 0.5)
        constant.animateBy = animateBy
        
        //设置管道状态
        commandEncoder.setRenderPipelineState(pipelineState)
        
        commandEncoder.setFragmentTexture(texture, index: 0)
        
        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder.setVertexBytes(&constant, length: MemoryLayout<Constants>.stride, index: 1)
        commandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indces.count, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
    }
}

extension Plane: Renderable,Texturable  {
    
}




















