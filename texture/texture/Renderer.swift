//
//  Renderer.swift
//  texture
//
//  Created by pino on 29.03.26.
//

import Foundation
import MetalKit

final class Renderer: NSObject {
    
    private let context: MetalContext
    private let renderPipelineState: MTLRenderPipelineState
    private let mesh: QuadMesh
    private let texture: MTLTexture
    
    init(context: MetalContext) throws {
        self.context = context
        renderPipelineState = try RenderPipeline.makeState(device: context.device)
        mesh = try QuadMesh(device: context.device)
        let textureLoader = TextureLoader(device: context.device)
        texture = try textureLoader.loadTexture(named: "tiger2", fileExtension: "jpg")
        super.init()
    }
    
    func setupView(_ view: MTKView) {
        view.clearColor = MTLClearColor(red: 0.6, green: 0.3, blue: 0.4, alpha: 1.0)
        view.delegate = self
        view.device = context.device
    }
    
    private func drawCommands(in view: MTKView) {
        guard
            let currentDrawable = view.currentDrawable,
            let currentRenderPassDescriptor = view.currentRenderPassDescriptor
        else { return }
        
        guard
            let commandBuffer = context.commandQueue.makeCommandBuffer(),
            let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: currentRenderPassDescriptor)
        else { return }

        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setFragmentTexture(texture, index: 0)
        renderCommandEncoder.drawIndexedPrimitives(
            type: .triangle,
            indexCount: mesh.indexCount,
            indexType: .uint16,
            indexBuffer: mesh.indexBuffer,
            indexBufferOffset: 0
        )
        renderCommandEncoder.endEncoding()
        commandBuffer.present(currentDrawable)
        commandBuffer.commit()
    }
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        drawCommands(in: view)
    }
}
