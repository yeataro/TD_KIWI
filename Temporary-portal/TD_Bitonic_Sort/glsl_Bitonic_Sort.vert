//https://t-pot.com/program/90_BitonicSort/index.html

out vec4 fragColor;

vec2 BufInfo = uTD2DInfos[0].res.zw;
vec2 In = vUV.st;
 

vec2 convert1dto2d(float index)
{
	vec2 dst;
	
	dst.x = mod (index,  BufInfo.x) / BufInfo.x;
	dst.y = floor(index / BufInfo.x) / BufInfo.y;
	
	return dst;
}


vec4 BitonicSortPS()
{
	
	
	int step = uTDPass;
	int rank;
	for(rank = 0; rank<step ; rank++){
		step -= rank+1;
	}

	float stepno = (float)(1<<(rank+1));
	float offset = (float)(1<<(rank-step));
	float stage  = 2*offset;

	vec4 dst;
	
	// 次のインデックス化のために小数部を切り取る
	vec2 elem2d = BufInfo * In;
	elem2d = floor(elem2d);
	
	// 1次元のIndexを求める
	float  elem1d = elem2d.y * BufInfo.x + elem2d.x;
	
	// 上と下のどちらのテクセルと比較するのか？
	float csign = (mod(elem1d, stage)< offset) ? 1 : -1;
	// ソートの向き
	float cdir  = (mod(floor(elem1d/stepno),2)<=0.5) ? 1 : -1;
	
	// レンダリング位置のテクセルを読み込む
	vec4 val0 = texture(sTD2DInputs[0], In);
	
	// ソート対象のテクセルを読む込む
	float adr1d = csign*offset + elem1d;// 比較対照のテクセル
	vec2 adr2d = convert1dto2d( adr1d );// インデックスからテクスチャ座標に変換
	vec4 val1 = texture( sTD2DInputs[0], adr2d );
	
	// y 成分をソートのキーとして使用
	vec4 cmin = (val0.z<val1.z) ? val0: val1;// 小さいほう
	vec4 cmax = (val0.z<val1.z) ? val1: val0;// 大きいほう
	
	// ソートの向きとデータサンプルの向きを比較して、どちらの値を採用するか決める
	dst = (csign==cdir) ? cmin : cmax;
	
	return dst;
}


void main()
{
    // vec4 color = texture(sTD2DInputs[0], vUV.st);
    vec4 color = BitonicSortPS();
    fragColor = TDOutputSwizzle(color);
}
