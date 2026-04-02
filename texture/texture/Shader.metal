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
    float сolor = dot(vertexIn.color.rgb, float3(0.299, 0.587, 0.114));
    return half4(сolor, сolor, сolor, 1);
}
