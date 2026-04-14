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
    float2 textureCoordinate [[attribute(2)]];
};

struct VertexOut {
    float4 position [[position]];
    float4 color;
    float2 textureCoordinate;
};

vertex VertexOut vertex_main(const VertexIn vertexIn [[stage_in]]) {
    VertexOut out;
    out.position = float4(vertexIn.position, 1);
    out.color = vertexIn.color;
    out.textureCoordinate = vertexIn.textureCoordinate;
    return out;
}


fragment half4 fragment_main(VertexOut vertexIn [[stage_in]]) {
    return half4(vertexIn.color);
}

fragment half4 textured_fragment(
                                 VertexOut vertexIn [[stage_in]],
                                 texture2d<float> texture [[texture(0)]]
                                 ) {
    constexpr sampler texSampler(
            coord::normalized,
            address::repeat,
            filter::linear,
            mip_filter::linear
        );
    float4 color = texture.sample(texSampler, vertexIn.textureCoordinate);
    return half4(color.r, color.g, color.b, 1);
}
