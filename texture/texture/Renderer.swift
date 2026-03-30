//
//  Renderer.swift
//  texture
//
//  Created by pino on 29.03.26.
//

import Foundation
import MetalKit

final class Renderer: NSObject {
    
    private var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    private var renderPipelineState: MTLRenderPipelineState!
    
    override init() {
        super.init()
        setup()
    }
    
    func setupView(_ view: MTKView) {
        view.clearColor = MTLClearColor(red: 0.6, green: 0.3, blue: 0.4, alpha: 1.0)
        view.delegate = self
        view.device = device
    }
    
    private func setup() {
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device.makeCommandQueue()
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "vertex_main")
        let fragmentFunction = library?.makeFunction(name: "fragment_main")
        
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        renderPipelineState = try! device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
    }
    
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        
    }
    
    
}
