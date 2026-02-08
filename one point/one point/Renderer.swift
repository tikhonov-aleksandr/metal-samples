//
//  Renderer.swift
//  two triangles
//
//  Created by pino on 07.02.26.
//

import Foundation
import MetalKit

final class Renderer: NSObject {
    
    private var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    
    private var pipelineState: MTLRenderPipelineState!
    
    override init() {
        super.init()
        setup()
    }
    
    func setupView(_ mtkView: MTKView) {
        mtkView.device = device
        mtkView.delegate = self
        mtkView.clearColor = MTLClearColor(red: 0.8, green: 0.6, blue: 0.75, alpha: 1.0)
    }
    
    private func setup() {
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device.makeCommandQueue()
        
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "vertex_main")
        let fragmentFunction = library?.makeFunction(name: "fragment_main")
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        pipelineState = try? device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
    }
    
    private func drawCommands(in view: MTKView) {
        
        guard
            let renderPassDescriptor = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable else {
            return
        }
        
        let commandBuffer = commandQueue.makeCommandBuffer()

        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(pipelineState)
        
        renderCommandEncoder?.drawPrimitives(type: .point, vertexStart: 0, vertexCount: 3)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        drawCommands(in: view)
    }
}

