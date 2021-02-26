class tooltip{
  float x,y,w,h;
//int 
  String label;
  boolean toggle;
  tooltip(){
        
  };

  tooltip(float x,float y,float w,float h,String label){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;

  };

  tooltip(float x,float y,float w,float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

  };

  void draw(){

    if(pos()){
        fill(219, 212, 11,100);
        rect(x,y,w,h);
        fill(0);
        text(label,x+10,y+10);

    }
  };

  boolean pos(){
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;

  };

};
