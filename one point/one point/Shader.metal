//
//  Shader.metal
//  two triangles
//
//  Created by pino on 07.02.26.
//

#include <metal_stdlib>
using namespace metal;

constant float4 position[3] = {
    float4(-0.5, -0.2, 0, 1),
    float4(0.5, -0.2, 0, 1),
    float4(0, 0.5, 0, 1),
};

constant float3 color[3] = {
    float3(1, 0, 0),
    float3(0, 1, 0),
    float3(0, 0, 1),
};

struct VertexOut {
    float4 position [[position]];
    float point_size [[point_size]];
    float3 color;
};

vertex VertexOut vertex_main(uint vertexId [[vertex_id]]) {
    VertexOut out {
        .position = position[vertexId],
        .point_size = 60,
        .color = color[vertexId]
    };
    return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]]) {
    float4 value = float4(in.color, 1.0);
    return value;
}
