//
//  Renderer.swift
//  MetalTestDemo1121
//
//  Created by 刘李斌 on 2017/11/21.
//  Copyright © 2017年 Brilliance. All rights reserved.
//

import Foundation
import MetalKit

class Renderer: NSObject {
    //创建设备以及命令的队列
    let device: MTLDevice!
    let commandQueue: MTLCommandQueue!
    
    //如果要绘制矩形,只需要改变数组中的顶点即可
    //修改渲染的颜色只需要修改metal文件中的fragment_shader方法的返回值
    //但是直接这样写会有很多重复的点,浪费内存
//    var vertices_sequare:[Float] = [
//        -1,1,0,
//        -1,-1,0,
//        1,-1,0,
//        1,-1,0,
//        1,1,0,
//        -1,1,0
//    ]
    
//    //优化 - 用两个数组相结合  vertices数组存放正方形的顶点坐标, indces数组存放每次使用vertices数组中的哪三组数据作为三角形的顶点就行绘制
//    var vertices: [Float] = [
//        -1,1,0,
//        -1,-1,0,
//        1,-1,0,
//        1,1,0
//    ]
//    
//    var indces: [UInt16] = [
//        0,1,2,
//        2,3,0
//    ]
    
    //创建管道状态及缓冲区(用来存放顶点)
    var pipelineState: MTLRenderPipelineState?
//    var vertexBuffer: MTLBuffer?
//
//    //索引缓冲区
//    var indexBuffer: MTLBuffer?
//
//    //动画的一些参数
//    //创建移动量
//    struct Constants {
//        var animateBy: Float = 0.0
//    }
//
//    var constant = Constants()
//
//    var time: Float = 0
    
    var scene: Scene?
    
    init(device: MTLDevice) {
        self.device = device
        commandQueue = device.makeCommandQueue()!
        super.init()
        
//        buildModel()
//        buildPipelineState()
    }
    
//    //处理顶点
//    private func buildModel(){
//        //创建顶点缓冲区,保存了顶点数组中的顶点位置
//        //每一个条目都是一个float, 所以缓冲区的长度也就是顶点的数量
//        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Float>.size, options: [])
//        
//        indexBuffer = device.makeBuffer(bytes: indces, length: indces.count * MemoryLayout<Float>.size, options: [])
//    }
    /*
    //处理管道状态
    private func buildPipelineState(){
        //储存GPU中的事项
        let libary = device.makeDefaultLibrary()
        
        //调用metal中的方法
        //顶点操作
        let vertextFunction = libary?.makeFunction(name: "vertex_shader")
        //上色操作
        let fragmentFunction = libary?.makeFunction(name: "fragment_shader")
        
        //创建蓝图
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertextFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        //创建顶点蓝图
        //顶点的描述符  attributes最多有32个(0-31)
        let vertexDescriptor = MTLVertexDescriptor()
        //位置
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        //颜色
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.stride
        vertexDescriptor.attributes[1].bufferIndex = 0
        
        //整合前面的命令
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        //把顶点描述符传入
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
            //画出三个顶点
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
 */
}

extension Renderer: MTKViewDelegate{
    //每次视图大小改变时被调用
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    //绘制图形(调用次数和帧数有关, 例如: 有60帧,那么没秒钟调用这个方法60次)
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
//        let indexBuffer = indexBuffer,
//            let pipelineState = pipelineState
        let descriptor = view.currentRenderPassDescriptor else { return  }
        
        //创建缓冲区 commandbuffer
        let commandbuffer = commandQueue.makeCommandBuffer()
        
        //设置时间变量  preferredFramesPerSecond当前view每秒钟调用次数
//        time += 1 / Float(view.preferredFramesPerSecond)
//
//        let animateBy = abs(sin(time)) / 2 + 0.5
//        constant.animateBy = animateBy
        
        
        //把命令进行编码
        let commandEncode = commandbuffer?.makeRenderCommandEncoder(descriptor: descriptor)
//        //设置管道状态
//        commandEncode?.setRenderPipelineState(pipelineState)
        /**
         offset偏移量: 读取数组的起始位置,0就是从第一组数据(0,1,0)开始拿, 1就是从第二组数据开始(-1,-1,0)
         index: 顶点缓冲区的编号
         */
        //锁所有对顶点的处理要处理完成之后才能进行绘制,否则会崩溃
        //处理顶点缓冲区
//        commandEncode?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
//        //处理顶点的移动
//        //stride 对象占用的内存及后面的内存碎片之和
//        commandEncode?.setVertexBytes(&constant, length: MemoryLayout<Constants>.stride, index: 1)
//
//        //===================上面的顶点操作处理完成之后再绘制===================
//        //绘制数组中的顶点
//        commandEncode?.drawIndexedPrimitives(type: .triangle, indexCount: indces.count, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
        
        
        //===============封装后调整的代码=============
        //调用动画的时间
        let detailTime = 1 / Float(view.preferredFramesPerSecond)
        scene?.render(commandEncoder: commandEncode!, detailTime: detailTime)
        //===============结束=======================
        
        //结束编码
        commandEncode?.endEncoding()
        //绘制
        commandbuffer?.present(drawable)
        //命令结束
        commandbuffer?.commit()
    }
    
    
}
