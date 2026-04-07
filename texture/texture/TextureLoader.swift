//
//  TextureLoader.swift
//  texture
//
//  Created by pino on 07.04.26.
//

import MetalKit

struct TextureLoader {
    
    let device: MTLDevice
    
    func loadTexture() throws -> MTLTexture {
        let loader = MTKTextureLoader(device: device)
        let name = "tiger"
        guard let url = Bundle.main.url(forResource: "tiger", withExtension: "png") else {
            throw MetalSetupError.textureUnavailable(name)
        }
        do {
            let texture = try loader.newTexture(URL: url)
            return texture
        } catch {
            throw MetalSetupError.textureUnavailable(name)
        }
    }
}
