//
//  QuadMesh.swift
//  texture
//
//  Created by pino on 07.04.26.
//

import Metal

struct QuadMesh {
    let vertexBuffer: MTLBuffer
    let indexBuffer: MTLBuffer
    let indexCount: Int

    init(device: MTLDevice) throws {
        let vertices = Self.vertices
        let indices = Self.indices

        guard let vertexBuffer = device.makeBuffer(
            bytes: vertices,
            length: MemoryLayout<Vertex>.stride * vertices.count
        ) else {
            throw MetalSetupError.vertexBufferUnavailable
        }

        guard let indexBuffer = device.makeBuffer(
            bytes: indices,
            length: MemoryLayout<UInt16>.stride * indices.count
        ) else {
            throw MetalSetupError.indexBufferUnavailable
        }

        self.vertexBuffer = vertexBuffer
        self.indexBuffer = indexBuffer
        indexCount = indices.count
    }

    private static let vertices: [Vertex] = [
        Vertex(
            position: SIMD3<Float>(-1, 1, 0),
            color: SIMD4<Float>(1, 0, 0, 1),
            textureCoordinate: SIMD2<Float>(0, 1)
        ),
        Vertex(
            position: SIMD3<Float>(-1, -1, 0),
            color: SIMD4<Float>(0, 1, 0, 1),
            textureCoordinate: SIMD2<Float>(0, 0)
        ),
        Vertex(
            position: SIMD3<Float>(1, -1, 0),
            color: SIMD4<Float>(0, 0, 1, 1),
            textureCoordinate: SIMD2<Float>(1, 0)
        ),
        Vertex(
            position: SIMD3<Float>(1, 1, 0),
            color: SIMD4<Float>(1, 0, 0, 1),
            textureCoordinate: SIMD2<Float>(1, 1)
        )
    ]

    private static let indices: [UInt16] = [
        0, 1, 2,
        0, 2, 3
    ]
}

