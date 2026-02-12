//
//  Shader.metal
//  rectangle
//
//  Created by pino on 10.02.26.
//

#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
    float3 color;
};

struct Constants {
    float3 color;
};

vertex VertexOut vertex_main(const device float3 *verticies [[buffer(0)]], uint vid [[vertex_id]], constant Constants &constants [[buffer(1)]]) {
    float3 position = verticies[vid];
    float3 color = constants.color;
    VertexOut out = {
        .position = float4(position, 1),
        .color = color
    };
    return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]]) {
    float4 value = float4(in.color, 1);
    return value;
}
