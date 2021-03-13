class radioMenu{
  
  float x,w,h,y;
  Menu menu;
  
  radioMenu(float x,float y,float w,String []s){
    
    menu = new Menu(x,y,w,s,true);
    for(int i=0;i<menu.items.size();i++){
      Button b = menu.items.get(i);
      b.radio = true;
    };
  };
  
  void draw(){
    menu.draw();
    for(int i=0;i<menu.items.size();i++){
      Button b = menu.items.get(i);
      b.self_toggle();
    };
  };
};
