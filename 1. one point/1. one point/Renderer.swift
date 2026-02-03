//
//  Renderer.swift
//  1. one point
//
//  Created by pino on 29.01.26.
//

import Foundation
import MetalKit

final class Renderer: NSObject {
    
    private var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    
    private var vertexBuffer: MTLBuffer!
    
    private var pipelineState: MTLRenderPipelineState!
    
    override init() {
        super.init()
        setup()
    }
    
    private func setup() {
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device.makeCommandQueue()
        
        
    }
    
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        
    }
}
