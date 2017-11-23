//
//  Types.swift
//  DrawSequareWithMetal
//
//  Created by 刘李斌 on 2017/11/22.
//  Copyright © 2017年 Brilliance. All rights reserved.
//

import Foundation
import simd


//描述要提交什么给GPU
struct Vertex {
    //位置
    var position: float3
    //颜色
    var color: float4
    //texture
    var texture: float2
}
