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
    
    private var vertexBuffer: MTLBuffer!
    private var indexBuffer: MTLBuffer!
    
    private var vertices: [Vertex] = [
        Vertex(position: SIMD3<Float>(-1, 1, 0), color: SIMD4<Float>(1, 0, 0, 1)), // (0)
        Vertex(position: SIMD3<Float>(-1, -1, 0), color: SIMD4<Float>(0, 1, 0, 1)), // (1)
        Vertex(position: SIMD3<Float>(1, -1, 0), color: SIMD4<Float>(0, 0, 1, 1)), // (2)
        Vertex(position: SIMD3<Float>(1, 1, 0), color: SIMD4<Float>(0, 0, 0, 1)) // (3)
    ]
    
    private var indices: [UInt16] = [
        0, 1, 2,
        0, 2, 3
    ]
    
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
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = MemoryLayout<Vertex>.offset(of: \.position)!
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<Vertex>.offset(of: \.color)!
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        renderPipelineState = try! device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        vertexBuffer = device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count)
        indexBuffer = device.makeBuffer(bytes: indices, length: MemoryLayout<UInt16>.stride * indices.count)
    }
    
    private func drawCommands(in view: MTKView) {
        guard
            let currentDrawable = view.currentDrawable,
            let currentRenderPassDescriptor = view.currentRenderPassDescriptor
        else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: currentRenderPassDescriptor)
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
