//
//  Shader.metal
//  rectangle
//
//  Created by pino on 10.02.26.
//

#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float3 position;
    float3 color;
};

struct VertexOut {
    float4 position [[position]];
    float3 color;
};

vertex VertexOut vertex_main(const device Vertex *vertices [[buffer(0)]], uint vid [[vertex_id]]) {
    Vertex ver = vertices[vid];
    VertexOut out {
        .position = float4(ver.position, 1),
        .color = ver.color
    };
    return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]]) {
    float4 value = float4(in.color, 1);
    return value;
}
