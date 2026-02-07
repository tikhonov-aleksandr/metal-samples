//
//  Shader.metal
//  two triangles
//
//  Created by pino on 07.02.26.
//

#include <metal_stdlib>
using namespace metal;

struct Params {
    float movedBy;
};

vertex float4 vertex_main(const device float3 *vertices [[buffer(0)]], constant Params &params [[buffer(1)]], uint vid [[vertex_id]]) {
    float3 position = vertices[vid];
    position.x += params.movedBy;
    float4 value = float4(position, 1.0);
    return value;
}

fragment half4 fragment_main() {
    half4 value = half4(0.2, 0.5, 0.7, 1.0);
    return value;
}
