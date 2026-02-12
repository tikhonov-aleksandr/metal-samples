//
//  Renderer.swift
//  rectangle
//
//  Created by pino on 10.02.26.
//

import Foundation
import MetalKit

final class Renderer: NSObject {
    
    private var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    private var renderPipelineState: MTLRenderPipelineState!
    private var vertexBuffer: MTLBuffer!
    private var indexBuffer: MTLBuffer!
    
    private var verticies: [SIMD3<Float>] = [
        SIMD3<Float>(-1, 1, 0), // (0)
        SIMD3<Float>(-1, -1, 0),// (1)
        SIMD3<Float>(1, -1, 0), // (2)
        SIMD3<Float>(1, 1, 0),  // (3)
    ]
    
    private var indices: [UInt16] = [
        0, 1, 2,
        0, 2, 3
    ]
    
    
    override init() {
        super.init()
        setup()
    }
    
    func setupView(_ mtkView: MTKView) {
        mtkView.clearColor = MTLClearColor(red: 0.8, green: 0.6, blue: 0.75, alpha: 1.0)
        mtkView.delegate = self
        mtkView.device = device
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
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineState = try! device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        
        vertexBuffer = device.makeBuffer(bytes: verticies, length: MemoryLayout<SIMD3<Float>>.stride * verticies.count)
        indexBuffer = device.makeBuffer(bytes: indices, length: MemoryLayout<UInt16>.stride * indices.count)
    }
    
    private func drawCommands(in view: MTKView) {
        
        guard
            let renderPassDescriptor = view.currentRenderPassDescriptor,
            let currentDrawable = view.currentDrawable
        else {
            return
        }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        renderCommandEncoder?.drawIndexedPrimitives(
            type: .triangle,
            indexCount: indices.count,
            indexType: .uint16,
            indexBuffer: indexBuffer,
            indexBufferOffset: 0
        )
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(currentDrawable)
        commandBuffer?.commit()
    }
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        drawCommands(in: view)
    }
}
