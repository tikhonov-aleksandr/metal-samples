//
//  MetalSetupError.swift
//  texture
//
//  Created by pino on 07.04.26.
//

import Foundation

enum MetalSetupError: LocalizedError {
    case commandQueueUnavailable
    case defaultLibraryUnavailable
    case deviceUnavailable
    case fragmentFunctionUnavailable(String)
    case indexBufferUnavailable
    case vertexBufferUnavailable
    case vertexDescriptorOffsetUnavailable(String)
    case vertexFunctionUnavailable(String)
    case textureUnavailable(name: String, underlyingError: Error?)
    case samplerStateUnavailable
    
    var errorDescription: String? {
        switch self {
        case .commandQueueUnavailable:
            "Unable to create Metal command queue."
        case .defaultLibraryUnavailable:
            "Unable to load default Metal shader library."
        case .deviceUnavailable:
            "Metal is not available on this device."
        case .fragmentFunctionUnavailable(let name):
            "Unable to load fragment function: \(name)."
        case .indexBufferUnavailable:
            "Unable to create index buffer."
        case .vertexBufferUnavailable:
            "Unable to create vertex buffer."
        case .vertexDescriptorOffsetUnavailable(let propertyName):
            "Unable to resolve vertex descriptor offset for \(propertyName)."
        case .vertexFunctionUnavailable(let name):
            "Unable to load vertex function: \(name)."
        case .textureUnavailable(let name, let underlyingError):
            if let underlyingError {
                "Unable to load texture: \(name). \(underlyingError.localizedDescription)"
            } else {
                "Unable to find texture: \(name)."
            }
        case .samplerStateUnavailable:
            "Unable to create texture sampler state."
        }
    }
}
