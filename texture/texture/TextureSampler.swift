//
//  TextureSampler.swift
//  texture
//
//  Created by pino on 15.04.26.
//

import Metal

enum TextureSampler {
    static func makeState(device: MTLDevice) throws -> MTLSamplerState {
        let descriptor = MTLSamplerDescriptor()
        descriptor.minFilter = .linear
        descriptor.magFilter = .linear
        descriptor.mipFilter = .linear
        descriptor.sAddressMode = .clampToEdge
        descriptor.tAddressMode = .clampToEdge

        guard let samplerState = device.makeSamplerState(descriptor: descriptor) else {
            throw MetalSetupError.samplerStateUnavailable
        }

        return samplerState
    }
}
