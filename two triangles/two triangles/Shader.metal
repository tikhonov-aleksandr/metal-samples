//
//  Shader.metal
//  two triangles
//
//  Created by pino on 07.02.26.
//

#include <metal_stdlib>
using namespace metal;


vertex float4 vertex_main(const device float3 *vertices [[buffer(0)]], uint vid [[vertex_id]]) {
    float4 value = float4(vertices[vid], 1.0);
    return value;
}

fragment half4 fragment_main() {
    half4 value = half4(0.2, 0.5, 0.7, 1.0);
    return value;
}
