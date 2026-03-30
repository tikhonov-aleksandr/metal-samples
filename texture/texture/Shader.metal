//
//  Shader.metal
//  texture
//
//  Created by pino on 30.03.26.
//

#include <metal_stdlib>
using namespace metal;


struct VertexIn {
    float3 position [[attribute(0)]];
    float4 color [[attribute(1)]];
};

struct VertexOut {
    float4 position [[position]];
    float4 color;
};

vertex VertexOut vertex_main(const VertexIn vertexIn [[stage_in]]) {
    VertexOut out;
    out.position = float4(vertexIn.position, 1);
    out.color = vertexIn.color;
    return out;
}

fragment half4 fragment_main(VertexOut vertexIn [[stage_in]]) {
    return half4(vertexIn.color);
}
