//
//  TextureLoader.swift
//  texture
//
//  Created by pino on 07.04.26.
//

import Foundation
import MetalKit

struct TextureLoader {

    private let loader: MTKTextureLoader

    init(device: MTLDevice) {
        loader = MTKTextureLoader(device: device)
    }

    func loadTexture(named name: String, fileExtension: String = "png") throws -> MTLTexture {
        guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            throw MetalSetupError.textureUnavailable(name: name, underlyingError: nil)
        }

        do {
            return try loader.newTexture(URL: url)
        } catch {
            throw MetalSetupError.textureUnavailable(name: name, underlyingError: error)
        }
    }
}
