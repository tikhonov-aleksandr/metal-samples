//
//  Extensions.swift
//  train
//
//  Created by pino on 17.02.26.
//

import Foundation
import MetalKit

extension MTLVertexDescriptor {
    
    static func defaultVertexDescription() -> MTLVertexDescriptor {
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = MemoryLayout<Vertex>.offset(of: \.position)!
        vertexDescriptor.attributes[0].bufferIndex = 0
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<SIMD3<Float>>.stride
        return vertexDescriptor
    }
}

extension MDLVertexDescriptor {
    static func defaultVertexDescription() -> MDLVertexDescriptor {
        let vertexDescriptor = MTKModelIOVertexDescriptorFromMetal(.defaultVertexDescription())
        let attributePosition = vertexDescriptor.attributes[0] as! MDLVertexAttribute
        attributePosition.name = MDLVertexAttributePosition
        return vertexDescriptor
    }
}
