//
//  Renderer.swift
//  simple triangle
//
//  Created by pino on 05.02.26.
//

import Foundation
import MetalKit

final class Renderer: NSObject {
    
    private var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    
    private var verticies: [Float] = [
        -1, -1, 0,
         0, 0, 0,
         1, -1, 0,
    ]
    
    private var vertexBuffer: MTLBuffer!
    private var pipelineState: MTLRenderPipelineState!
    
    override init() {
        super.init()
        setup()
    }
    
    func setupView(_ mtkView: MTKView) {
        mtkView.device = device
        mtkView.delegate = self
        mtkView.clearColor = MTLClearColor(red: 0.5, green: 0.3, blue: 0.3, alpha: 1.0)
    }
    
    private func setup() {
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device.makeCommandQueue()
    }
    
    private func drawCommands(in view: MTKView) {
        
        guard
            let renderPassDescriptor = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable else {
            return
        }
        
        let commandBuffer = commandQueue.makeCommandBuffer()

        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: verticies.count)
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineState = MTLRenderPipelineState(descriptor: renderPipelineDescriptor)
        
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

