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
    
    private var verticies: [SIMD3<Float>] = [
        SIMD3<Float>(-1, 1, 0),  // 0
        SIMD3<Float>(-1, -1, 0), // 1
        SIMD3<Float>(1, -1, 0),  // 2
        SIMD3<Float>(1, 1, 0),   // 3
    ]
    
    private var vertexIndices: [UInt16] = [
        0, 1, 2,
        0, 2, 3
    ]
    
    private var vertexBuffer: MTLBuffer!
    private var indexBuffer: MTLBuffer!
    private var pipelineState: MTLRenderPipelineState!
    private var time: Float = 0
    
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
        
        vertexBuffer = device.makeBuffer(bytes: verticies, length: MemoryLayout<SIMD3<Float>>.stride * verticies.count)
        indexBuffer = device.makeBuffer(bytes: vertexIndices, length: MemoryLayout<UInt16>.stride * vertexIndices.count)
        
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
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        time += 1.0/Float(view.preferredFramesPerSecond)
        let movedBy = sin(time) / 2.0 + 0.5
        
        var params = Params(movedBy: movedBy)
        renderCommandEncoder?.setVertexBytes(&params, length: MemoryLayout<Params>.stride, index: 1)
        
        renderCommandEncoder?.drawIndexedPrimitives(type: .triangle, indexCount: vertexIndices.count, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
        
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

struct Params {
    var movedBy: Float
}


