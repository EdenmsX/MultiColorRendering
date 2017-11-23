//
//  Texturable.swift
//  DrawSequareWithMetal
//
//  Created by 刘李斌 on 2017/11/23.
//  Copyright © 2017年 Brilliance. All rights reserved.
//

import Foundation
import MetalKit


protocol Texturable {
    var texture: MTLTexture? {get set}
}

extension Texturable {
    
    func setTexture(device: MTLDevice, imageName: String) -> MTLTexture? {
        let textureloader = MTKTextureLoader(device: device)
        var texture: MTLTexture? = nil
        
        let textLoaderOpitons: [MTKTextureLoader.Option: Any]
        
        //进行版本判断
        if #available(iOS 10.0, *) {
            let origin = NSString(string: MTKTextureLoader.Origin.bottomLeft.rawValue)
            textLoaderOpitons = [MTKTextureLoader.Option.origin: origin]
        } else {
            textLoaderOpitons = [:]
        }
        
        if let textureURL = Bundle.main.url(forResource: imageName, withExtension: nil) {
            do {
                texture = try textureloader.newTexture(URL: textureURL, options: textLoaderOpitons)
            } catch {
                print("纹理未被创建")
            }
        }
        
        return texture
    }
    
}
