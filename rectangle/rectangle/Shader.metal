//
//  Shader.metal
//  rectangle
//
//  Created by pino on 10.02.26.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float4 position [[attribute(0)]];
    float4 color [[attribute(1)]];
};

struct VertexOut {
    float4 position [[position]];
    float4 color;
};

vertex VertexOut vertex_main(const VertexIn vertexIn [[stage_in]]) {
    VertexOut out;
    out.position = vertexIn.position;
    out.color = vertexIn.color;
    return out;
}

fragment half4 fragment_main(VertexOut in [[stage_in]]) {
    half4 value = half4(in.color);
    return value;
}
