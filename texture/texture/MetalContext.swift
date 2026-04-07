//
//  MetalContext.swift
//  texture
//
//  Created by pino on 07.04.26.
//

import Metal

struct MetalContext {
    let device: MTLDevice
    let commandQueue: MTLCommandQueue

    init() throws {
        guard let device = MTLCreateSystemDefaultDevice() else {
            throw MetalSetupError.deviceUnavailable
        }

        guard let commandQueue = device.makeCommandQueue() else {
            throw MetalSetupError.commandQueueUnavailable
        }

        self.device = device
        self.commandQueue = commandQueue
    }
}

