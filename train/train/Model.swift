//
//  Model.swift
//  train
//
//  Created by pino on 17.02.26.
//

import Foundation
import MetalKit

final class Model {
    
    var mdlMeshes: [MDLMesh]
    var mtkMeshes: [MTKMesh]
    
    init(name: String, device: MTLDevice) {
        let assetURL = Bundle.main.url(forResource: name, withExtension: "obj")!
        let allocator = MTKMeshBufferAllocator(device: device)
        
        let vertexDescriptor = MDLVertexDescriptor.defaultVertexDescription()
        let asset = MDLAsset(url: assetURL, vertexDescriptor: vertexDescriptor, bufferAllocator: allocator)
        
        let (mdlMeshes, mtkMeshes) = try! MTKMesh.newMeshes(asset: asset, device: device)
        self.mdlMeshes = mdlMeshes
        self.mtkMeshes = mtkMeshes
    }
}
