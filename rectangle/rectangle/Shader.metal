//
//  Shader.metal
//  rectangle
//
//  Created by pino on 10.02.26.
//

#include <metal_stdlib>
using namespace metal;


vertex float4 vertex_main(const device float3 *verticies [[buffer(0)]], uint vid [[vertex_id]]) {
    float3 position = verticies[vid];
    float4 value = float4(position, 1);
    return value;
}

fragment half4 fragment_main() {
    half4 value = half4(0.2, 0.5, 0.7, 1.0);
    return value;
}
