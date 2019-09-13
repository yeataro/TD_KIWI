// https://github.com/BrutPitt/glslSmartDeNoise

uniform float uSigma;
uniform float uKSigma;
uniform float uThreshold;

#define INV_SQRT_OF_2PI 0.39894228040143267793994605993439  // 1.0/SQRT_OF_2PI
#define INV_PI 0.31830988618379067153776752674503

//  smartDeNoise - parameters
///////////////////////////////////////////////////////////////////////////////
//
//  sampler2D tex     - sampler image / texture
//  vec2 uv           - actual fragment coord
//  float sigma  >  0 - sigma Standard Deviation
//  float kSigma >= 0 - sigma coefficient 
//      kSigma * sigma  -->  radius of the circular kernel
//  float threshold   - edge sharpening threshold 

vec4 smartDeNoise(sampler2D tex, vec2 uv, float sigma, float kSigma, float threshold)
{
    float radius = round(kSigma*sigma);  // devStd = 2 -> 95% or 3 -> 99.7%
    float radQ = radius * radius;
    
    float invSigma = 1.f/sigma;
    float invSigmaQx2 = .5 * invSigma * invSigma;  // 1.0 / (sigma^2 * 2.0)
    float invSigmaQx2PI = INV_PI * invSigmaQx2;    // 1.0 / (sqrt(PI) * sigma)
    
    float invThreshold = 1.f/threshold;
    float invThresholdSqx2 = .5 * invThreshold * invThreshold;     // 1.0 / (sigma^2 * 2.0)
    float invThresholdSqrt2PI = INV_SQRT_OF_2PI * invThreshold;    // 1.0 / (sqrt(2*PI) * sigma)
    
    vec4 centrPx = texture(tex,uv); 
    
    float Zbuff = 0.0;
    vec4 accumBuff = vec4(0.0);
    vec2 size = vec2(textureSize(tex, 0));
    
    for(float x=-radius; x <= radius; x++) {
        float pt = sqrt(radQ-x*x);  // pt = yRadius: have circular trend
        for(float y=-pt; y <= pt; y++) {
            vec2 d = vec2(x,y)/size;

            float blurFactor = exp( -dot(d , d) * invSigmaQx2 ) * invSigmaQx2;
            
            vec4 walkPx =  texture(tex,uv+d); //getColorPix(tex, uv+d);

            vec4 dC = walkPx-centrPx;
            float deltaFactor = exp( -dot(dC, dC) * invThresholdSqx2) * invThresholdSqrt2PI * blurFactor;
                                 
            Zbuff     += deltaFactor;
            accumBuff += deltaFactor*walkPx;
        }
    }
    return accumBuff/Zbuff;
}

out vec4 fragColor;
void main()
{
	float Sigma = clamp(abs(uSigma) , 0.001 ,24. );
	float KSigma =  clamp(abs(uKSigma) , 0 ,3. );
    vec4 color = smartDeNoise(sTD2DInputs[0] , vUV.st , Sigma , KSigma , uThreshold);
    fragColor = TDOutputSwizzle(color);
}
