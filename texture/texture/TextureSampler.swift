//
//  TextureSampler.swift
//  texture
//
//  Created by pino on 15.04.26.
//

import MetalKit

class TextureSampler {
    
    private let device: MTLDevice
    
    init(device: MTLDevice) {
        self.device = device
    }
    
    func makeSamplerState() throws -> MTLSamplerState {
        
        let descriptor = MTLSamplerDescriptor()
        descriptor.minFilter = .linear
        descriptor.mipFilter = .linear
        descriptor.mipFilter = .linear
        guard let state = device.makeSamplerState(descriptor: descriptor) else {
            throw MetalSetupError.sampler
        }
        return state
    }
    
}
