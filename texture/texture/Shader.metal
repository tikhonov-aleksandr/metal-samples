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
    constexpr sampler defaultSampler;
    float4 color = texture.sample(defaultSampler, vertexIn.textureCoordinate);
    return half4(color.r, color.g, color.b, 1);
}

//fragment half4 fragment_main(VertexOut vertexIn [[stage_in]]) {
//    float сolor = dot(vertexIn.color.rgb, float3(0.299, 0.587, 0.114));
//    return half4(сolor, сolor, сolor, 1);
//}
