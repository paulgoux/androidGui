// Adapted from:
// <a href="http://callumhay.blogspot.com/2010/09/gaussian-blur-shader-glsl.html" target="_blank" rel="nofollow">http://callumhay.blogspot.com/2010/09/gaussian-blur-shader-glsl.html</a>
 
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
 
#define PROCESSING_TEXTURE_SHADER
 
uniform sampler2D texture;
uniform float mult;
uniform float type;
 
varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;

void main(void) {
  float x = 1.0 / resolution.x;
  float y = 1.0 / resolution.y;
  
  
  vec4 horizEdge = vec4( 0.0 );
  horizEdge -= texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y - y ) ) * 1.0;
  horizEdge -= texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y     ) ) * 2.0;
  horizEdge -= texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y + y ) ) * 1.0;
  horizEdge += texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y - y ) ) * 1.0;
  horizEdge += texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y     ) ) * 2.0;
  horizEdge += texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y + y ) ) * 1.0;
  
  vec4 vertEdge = vec4( 0.0 );
  vertEdge -= texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y - y ) ) * 1.0;
  vertEdge -= texture2D( texture, vec2( vertTexCoord.x    , vertTexCoord.y - y ) ) * 2.0;
  vertEdge -= texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y - y ) ) * 1.0;
  vertEdge += texture2D( texture, vec2( vertTexCoord.x - x, vertTexCoord.y + y ) ) * 1.0;
  vertEdge += texture2D( texture, vec2( vertTexCoord.x    , vertTexCoord.y + y ) ) * 2.0;
  vertEdge += texture2D( texture, vec2( vertTexCoord.x + x, vertTexCoord.y + y ) ) * 1.0;
  
  vec3 edge = sqrt((horizEdge.rgb * horizEdge.rgb) + (vertEdge.rgb * vertEdge.rgb));
  
  float col = (edge.x+edge.y+edge.z)/3.0;
  vec4 mCol = texture2D( texture, vec2( vertTexCoord.x, vertTexCoord.y ) );
  float myCol = (mCol.r + mCol.r + mCol.r)/3.0;
  if(type==0.0){
	gl_FragColor = vec4(1.0 - (col*mult-myCol),1.0 - (col*mult-myCol),1.0 - (col*mult-myCol),1.0);
  }
  if(type==1.0){
	gl_FragColor = vec4(1.0 - (col*mult),1.0 - (col*mult),1.0 - (col*mult),1.0);
  }
  if(type==2.0){
	gl_FragColor = vec4(myCol - (col*mult),myCol - (col*mult),myCol - (col*mult),1.0);
  }
  if(type==3.0){
	gl_FragColor = vec4((col*mult),(col*mult),(col*mult),1.0);
  }
  if(type==4.0){
	gl_FragColor = vec4(mCol.r - (col*mult),mCol.g - (col*mult),mCol.b - (col*mult),mCol.a);
  }
  if(type==5.0){
	gl_FragColor = vec4(mCol.r - (col*mult),mCol.g - (col*mult),mCol.b - (col*mult),mCol.a - col*mult);
  }
  if(type==6.0){
	gl_FragColor = vec4(1.0 - ((col*mult)-mCol.r),1.0 - ((col*mult)-mCol.g),1.0 - ((col*mult)-mCol.b),1.0);
  }
  if(type==7.0){
	gl_FragColor = vec4(1.0 - (col*mult),1.0 - (col*mult),1.0 - (col*mult),1.0);
  }
  if(type==8.0){
	gl_FragColor = vec4(1.0 - (col*mult),1.0 - (col*mult),1.0 - (col*mult),1.0);
  }
  if(type==9.0){
	gl_FragColor = vec4(1.0 - (col*mult),1.0 - (col*mult),1.0 - (col*mult),1.0);
  }
  
  
}