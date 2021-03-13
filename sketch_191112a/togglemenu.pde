class toggleMenu{
  
  float x,w,h,y,bx,by,bw,bh;
  Menu menu;
  tab parentTab;
  
  toggleMenu(float x,float y,float w,String []s){
    this.x = x;
    this.y = y;
    this.w = w;
    bx = x;
    by = y;
    bw = w;
    menu = new Menu(x,y,w,s,false);
    //menu.w = 
  };
  
  toggleMenu(float x,float y,float w,float H,String []s){
    this.x = x;
    this.y = y;
    this.w = w;
    bx = x;
    by = y;
    bw = w;
    menu = new Menu(x,y,w,H,s,false);
    //menu.w = 
  };
  
  toggleMenu(float x,float y,float w,float H,float S,String []s){
    this.x = x;
    this.y = y;
    this.w = w;
    bx = x;
    by = y;
    bw = w;
    menu = new Menu(x,y,w,S,s,false);
    //menu.w = 
  };
  
  void draw(){
    menu.x = x;
    menu.y = y;
    menu.draw();
    for(int i=0;i<menu.items.size();i++){
      Button b = menu.items.get(i);
      b.self_toggle();
    };
    
  };
  
  void draw(PGraphics canvas){
    menu.x = x;
    menu.y = y;
    menu.draw(canvas);
    for(int i=0;i<menu.items.size();i++){
      Button b = menu.items.get(i);
      b.mouse = menu.mouse;
      b.self_toggle(menu.mouse);
    };
  };
};
