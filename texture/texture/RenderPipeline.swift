//
//  RenderPipeline.swift
//  texture
//
//  Created by pino on 07.04.26.
//

import Metal

enum RenderPipeline {
    static func makeState(
        device: MTLDevice,
        pixelFormat: MTLPixelFormat = .bgra8Unorm
    ) throws -> MTLRenderPipelineState {
        guard let library = device.makeDefaultLibrary() else {
            throw MetalSetupError.defaultLibraryUnavailable
        }

        guard let vertexFunction = library.makeFunction(name: "vertex_main") else {
            throw MetalSetupError.vertexFunctionUnavailable("vertex_main")
        }

        guard let fragmentFunction = library.makeFunction(name: "textured_fragment3") else {
            throw MetalSetupError.fragmentFunctionUnavailable("textured_fragment3")
        }

        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = pixelFormat
        renderPipelineDescriptor.vertexDescriptor = try makeVertexDescriptor()

        return try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
    }

    private static func makeVertexDescriptor() throws -> MTLVertexDescriptor {
        guard let positionOffset = MemoryLayout<Vertex>.offset(of: \.position) else {
            throw MetalSetupError.vertexDescriptorOffsetUnavailable("position")
        }

        guard let colorOffset = MemoryLayout<Vertex>.offset(of: \.color) else {
            throw MetalSetupError.vertexDescriptorOffsetUnavailable("color")
        }
        
        guard let textureCoordinateOffset = MemoryLayout<Vertex>.offset(of: \.textureCoordinate) else {
            throw MetalSetupError.vertexDescriptorOffsetUnavailable("textureCoordinate")
        }
        

        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = positionOffset
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = colorOffset
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[2].format = .float2
        vertexDescriptor.attributes[2].offset = textureCoordinateOffset
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        return vertexDescriptor
    }
}
