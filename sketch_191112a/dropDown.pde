class Dropdown extends Menu {

  Slider slider;
  float windowx,bwindowx,hiddenw;
  int dcount,windowSize = 5;
  boolean dclick,visible = true,dclose,draggable,mcoord;
  Button title;
  Boundary boundary;
  PVector mouse;
  tab parentTab;
  Menu subMenu;
  Dropdown dMenu;

  Dropdown() {
    
  };

  Dropdown(float xx, float yy, float ww, float h, String[] Labels) {
    dmenu = true;
    
    x = xx;
    y = yy;
    bx = x;
    by = y;
    
    w = ww;
    
    setLabels(Labels);
    h = 20;
    
    windowx = windowSize * 20;
    bwindowx = windowx;
    boundary = new Boundary(x,y,w,h,4);
  };


  Dropdown(float xx, float yy, float ww, String[] Labels) {

    dmenu = true;
    x = xx;
    y = yy;
    bx = x;
    by = y;
    
    w = ww;

    setLabels(Labels);
    if(Labels.length>5)setSlider();
    h = 20;
    
    windowx = windowSize * 20;
    bwindowx = windowx;
    boundary = new Boundary(x,y,w,h,4);
  };
  
  Dropdown(float xx, float yy, float ww, String l, String[] Labels) {

    dmenu = true;
    x = xx;
    y = yy;
    bx = x;
    by = y;
    
    w = ww;
    
    label = l;
    blabel = l;
    
    setLabels(Labels);
    h = 20;
    windowx = windowSize * 20;
    if(Labels.length>5)setSlider();
    bwindowx = windowx;
    boundary = new Boundary(x,y,w,h,4);
  };
  


  Dropdown(float xx, float yy, float ww, String l, String[] Labels, int k) {

    dmenu = true;
    x = xx;
    y = yy;
    bx = x;
    by = y;
    
    w = ww;
    
    label = l;
    blabel = l;
    
    windowx = windowSize * 20;
    bwindowx = windowx;
    setLabels_(Labels);
    if(Labels.length>5)setSlider_();
    h = 20;
    boundary = new Boundary(x,y,w,h,4);
  };

  Dropdown(float xx, float yy, float ww, String[] Labels, int k) {

    dmenu = true;
    x = xx;
    y = yy;
    w = ww;
    h = 20 * (k + 1);
    bx = x;
    by = y;
    
    windowx = windowSize * 20;
    bwindowx = windowx;
    setLabels(Labels);
    if(Labels.length>5)setSlider();
    boundary = new Boundary(x,y,w,h,4);
  };
  
  void labelsToArray(String []a){
    for (int i=0; i<a.length; i++) {
      String s = a[i];
      
      labels.add(s);
      
    }
  };

  void setLabels(String[] a) {
    
    if (label==null) label = a[0];
    float mwidth = w;
    title = new Button(x,y,w,20,label);
    title.parent = this;
    
    for (int i=0; i<a.length; i++) {

      Button b =null;
      if(textWidth(a[i])>mwidth) mwidth = textWidth(a[i]+20);
    }
    for (int i=0; i<a.length; i++) {

      Button b =null;
      if(textWidth(a[i])>mwidth) mwidth = textWidth(a[i]);
      if(a.length<5) b = new Button(x, (y + 20) + 20 * i, mwidth, 20,a[i]);
      else b = new Button(x, (y + 20) + 20 * i, mwidth - 10, 20,a[i]);

      b.border = false;
      b.togglebox = true;
      //b.parent = this;
      b.visible = true;
      items.add(b);
    }
    
    w = mwidth;
    
  };
  
  void setLabels_(String[] a) {
    
    if (label==null) label = a[0];
    float mwidth = w;
    title = new Button(x,y,w,20,label);
    title.parent = this;
    
    for (int i=0; i<a.length; i++) {

      Button b =null;
      if(textWidth(a[i])>mwidth) mwidth = textWidth(a[i]+20);
    }
    for (int i=0; i<a.length; i++) {

      Button b =null;
      if(textWidth(a[i])>mwidth) mwidth = textWidth(a[i]);
      if(a.length<5) b = new Button(x, (y + 20) + 20 * i, mwidth, 20,a[i]);
      else b = new Button(x, (y + 20) + 20 * i, mwidth - 10, 20,a[i]);

      b.border = false;
      b.togglebox = true;
      //b.parent = this;
      b.visible = true;
      items.add(b);
    }
    
    hiddenw = mwidth;
    
  };

  void setSlider() {
    slider = new Slider(x + w - 10, y + 20, 10, 20*5);
    slider.vertical = true;
    slider.bar = true;
    slider.classic = true;
    slider.visible = true;
    slider.valuex = 0;
    slider.vertical = true;
    slider.tvisible = false;
  };
  
  void setSlider_() {
    slider = new Slider(x + hiddenw - 10, y + 20, 10, 20*5);
    slider.vertical = true;
    slider.bar = true;
    slider.classic = true;
    slider.visible = true;
    slider.valuex = 0;
    slider.vertical = true;
    slider.tvisible = false;
  };
  
  void displayDropdown(){
    fill(255);
    
    if(items.size()>0){
      drawLabel();
      selfClick();
      drawButtons();
      drawSlider();
      drawDragbox();
      drag();
      
      if (pos()||(dclick&&subPos()))menu = true;
      if(dMenu!=null){
        dMenu.x = x + w;
        dMenu.y = y;
      }
      if(subMenu!=null){
        subMenu.x = x + w;
        subMenu.y = y;
      }
      drawSubMenu();
    }
  };

  void drawSubMenu(){
    if(subMenu!=null){
      if(subMenuPos())subMenu.show = true;
      if(pos()&&!subMenuPos())subMenu.show = false;
    }
    if(subMenu!=null&&subMenu.show)subMenu.trace();
    if(dMenu!=null&&subMenuPos())dMenu.displayDropdown();
  };

  void drawSubMenu(PVector mouse){
    if(subMenu!=null&&subMenuPos(mouse))subMenu.show = true;
    //else if(subMenu!=null)subMenu.show = false;
    if(subMenu!=null)subMenu.trace();
    if(dMenu!=null&&subMenuPos(mouse))dMenu.displayDropdown();
  };
  
  void displayDropdown(PGraphics canvas){
    fill(255);
    
    if(items.size()>0){
      drawLabel(canvas);
      selfClick(mouse);
      drawButtons(canvas);
      drawSlider(canvas);
      drawDragbox(canvas);
      drag(mouse);
      drawSubMenu(mouse);
      if (pos(mouse)||(dclick&&subPos(mouse))||(dMenu!=null&&dMenu.menu)||(subMenu!=null&&subMenu.menu))menu = true;
      else menu = false;
      if(dMenu!=null){
        dMenu.x = x + w;
        dMenu.y = y;
      }
      if(subMenu!=null){
        subMenu.x = x + w;
        subMenu.y = y;
      }
    }
  };
  
  void drawButtons(){
    
    dcount = 0;

      if(dclick&&slider!=null){
        
        fill(255);
        rect(x,y+h,w,slider.h);
        fill(0,150);
        rect(x,y+h,w,slider.h);
      }



    for(int i=0;i<items.size();i++){
      Button b = items.get(i);
      
      if(drag){
        b.x = x;
        b.y = y + 20 + 20 * i;
        b.by= y + 20 + 20 * i; 
      }
      
      if(slider!=null&&slider.mdown)b.y = b.by - slider.value*20;
      
      if(slider!=null){
        
      if(!slider.mdown){
      if(!dclick)b.visible = false;
      else if(b.y + b.h < y + h + windowx+1) b.visible = true;
        
      }
      else {
        if(b.y + b.h > y + h + windowx+1||b.y<y+h-1)b.visible = false;
        else b.visible = true;
      }}
      else{
        if(!dclick)b.visible = false;
        else b.visible = true;
        
        b.x = x;
        b.y = y + 20 + 20 * i;
      }
      if(b.y<y+h-1)b.visible = false;
      if(b.visible){
        
        b.draw();
        b.highlight();
        if(b.pos(mousePos))dcount++;
      }

      if(slider!=null){
    
      if(mousePressed&&b.pos(mousePos)&&b.visible&&!slider.mdown){
          label = b.label;
          index = i;
          dclick = false;
      }
    }
      else{
        if(mousePressed&&b.pos(mousePos)&&b.visible){
          label = b.label;
          index = i;
          dclick = false;
      }}}
      if(slider!=null){if(dcount==0&&mousePressed&&!pos(mousePos)&&!slider.pos(mousePos)&&!slider.mdown)dclick = false;}
      else if(dcount==0&&mousePressed&&!pos(mousePos))dclick = false;
      //if(mdown2)dclick
  };
  
  void drawButtons(PGraphics canvas){
    
    dcount = 0;
      if(dclick&&slider!=null){
        canvas.fill(255);
        canvas.rect(x,y+h,w,slider.h);
        canvas.fill(0,150);
        canvas.rect(x,y+h,w,slider.h);
      }

    for(int i=0;i<items.size();i++){
      
      Button b = items.get(i);
      
      if(drag){
        b.x = x;
        b.y = y + 20 + 20 * i;
        b.by= y + 20 + 20 * i; 
      }
      
      if(slider!=null&&slider.mdown)b.y = b.by - (slider.value);
      
      if(slider!=null){
      if(!slider.mdown){
        //println(items.size());
      if(!dclick)b.visible = false;
      else if(b.y + b.h < y + h + windowx+1) b.visible = true;
        
      }else {
        if(b.y + b.h > y + h + windowx+1||b.y<y+h-1)b.visible = false;
        else b.visible = true;
        
      }}else{
        if(!dclick)b.visible = false;
        else b.visible = true;
      }
      if(b.y<y+h-1)b.visible = false;
      if(b.visible){
        b.mouse = mouse;
        //b.parentCanvas = true;
        b.draw(canvas);
        
        b.highlight(mouse);
        if(b.pos(mouse))dcount++;
      }
      
      if(slider!=null){
    
      if(mousePressed&&b.pos(mouse)&&b.visible&&!slider.mdown){
          label = b.label;
          index = i;
          dclick = false;
      }} else{
        if(mousePressed&&b.pos(mouse)&&b.visible){
          label = b.label;
          index = i;
          dclick = false;
      }}}
      if(slider!=null){if(dcount==0&&mousePressed&&!pos(mouse)&&!slider.pos(mouse)&&!slider.mdown)dclick = false;}
      else if(dcount==0&&mousePressed&&!pos(mouse))dclick = false;
  };
  
  void drawBoundary(){
    
    if(draggable){
      if(border)boundary.draw2();
      drag();
    }
    
  };
  
  void drawDragbox(){
    
    if(draggable){
      fill(255);
      rect(x,y - 10,w,10);
      fill(0,50);
      rect(x,y - 10,w,10);
    }
    
  };
  
  void drawDragbox(PGraphics canvas){
    
    if(draggable){
      canvas.fill(255);
      canvas.rect(x,y - 10,w,10);
      canvas.fill(0,50);
      canvas.rect(x,y - 10,w,10);
    }
    
  };
  
  
  void drawSlider(){
    if(drag&&slider!=null){
      slider.x = x + w - 10;
      slider.y = y + 20;
    }
    if(slider!=null&&dclick){
    slider.draw();
    slider.mouseFunctions();
    slider.set(0,(items.size()-5)*20);
    }
  };
  
  void drawSlider(PGraphics canvas){
    if(drag&&slider!=null){
      slider.x = x + w - 10;
      slider.y = y + 20;
    }
    if(slider!=null&&dclick){
        slider.mouse = mouse;
        slider.draw(canvas);
        slider.mouseFunctions(mouse);
        //slider.set(0,500);
        slider.set(0,(items.size()-5)*20);
    }
  };
  
  void drawLabel(){
    
    fill(255);
    rect(x,y,w,h);
    if(pos())fill(0,100);
    fill(0,150);
    rect(x,y,w,h);
    fill(255);
    text(label,x+2,y+tsize+2);
    
  };
  
  void drawLabel(PGraphics canvas){
    
    canvas.fill(255);
    canvas.rect(x,y,w,h);
    canvas.fill(0,150);
    if(pos())fill(0,100);
    canvas.rect(x,y,w,h);
    canvas.fill(255);
    canvas.text(label,x+2,y+tsize+2);
    
  };
  
  void drag(){
    if(slider!=null){
    if(dpos()&&mousePressed&&!drag&&!slider.mdown){
      if(draggable){
        drag = true;
        dx = x - mouseX;
        dy = y - mouseY;
        mdown = true;
      }}}
      else{
        if(dpos()&&mousePressed&&!drag){
          if(draggable){
        drag = true;
        dx = x - mouseX;
        dy = y - mouseY;
        mdown = true;
      }}}
    
    if(drag){
      x = mouseX + dx;
      y = mouseY + dy;
    }
    
    if(!mousePressed){
      dx = 0;
      dy = 0;
      drag = false;
    }
  };
  
  void drag(PVector m){
    if(slider!=null){
    if(dpos(mouse)&&mousePressed&&!drag&&!slider.mdown){
      if(draggable){
        drag = true;
        dx = x - m.x;
        dy = y - m.y;
        mdown = true;
      }}}else{
        if(dpos(mouse)&&mousePressed&&!drag){
          if(draggable){
        drag = true;
        dx = x - m.x;
        dy = y - m.y;
        mdown = true;
      }}}
    
    if(drag){
      x = m.x + dx;
      y = m.y + dy;
    }
    
    if(!mousePressed){
      dx = 0;
      dy = 0;
      drag = false;
    }
  };
  
  void selfClick(){
    mousePos = new PVector(mouseX,mouseY);
    if(slider!=null){
    if(BMS.dropDownObject==null&&pos(mousePos)&&mousePressed&&!mdown&&!dclick&&!slider.mdown&&!drag){
      
        BMS.dropDownObject = this;
        println("Slider",BMS.dropDownObject);
        dclick = true;
        mdown = true;
    }
    if(pos(mousePos)&&mousePressed&&!mdown&&dclick&&!slider.mdown&&!drag){
        dclick = false;
        mdown = true;
    }}
    else{
      
      if(BMS.dropDownObject==null&&pos(mousePos)&&mousePressed&&!mdown&&!dclick&&!drag){
        
        println("null slider", BMS.dropDownObject);
        dclick = true;
        mdown = true;
    }
    if(pos(mousePos)&&mousePressed&&!mdown&&dclick&&!drag){
        dclick = false;
        mdown = true;
    }}
    if(!mousePressed)mdown = false;
  };
  
  void selfClick(PVector mouse){
    if(slider!=null){
    if(BMS.dropDownObject==null&&pos(mouse)&&mousePressed&&!mdown&&!dclick&&!slider.mdown&&!drag){
        BMS.dropDownObject = this;
        println("c Slider",BMS.dropDownObject);
        dclick = true;
        mdown = true;
    }
    if(pos(mouse)&&mousePressed&&!mdown&&dclick&&!slider.mdown&&!drag){
        dclick = false;
        mdown = true;
    }}
    else{
      if(BMS.dropDownObject==null&&pos(mouse)&&mousePressed&&!mdown&&!dclick&&!drag){
        BMS.dropDownObject = this;
        println("c Slider null",BMS.dropDownObject);
        dclick = true;
        mdown = true;
    }
    if(pos(mouse)&&mousePressed&&!mdown&&dclick&&!drag){
        dclick = false;
        mdown = true;
    }}
    if(!mousePressed)mdown = false;
  };
  
  void toggled(int i,Object o,String c){
    Button b = items.get(i);
    
    if(b.visible)b.toggle2(o,c);
    
  };
  
  void sptoggled(Object o,String c){
    
    for(int i=0;i<items.size();i++){
      Button b = items.get(i);
      if(b.visible)b.toggle3(o,c);
      if(!b.pos()&&mousePressed)b.toggle=0;
    }
    
  };
  
  boolean subPos(){
    return mouseX>x&&mouseX<x+w&&mouseY>y+20&&mouseY<y+20+items.size()*20;
  };
  
  boolean subPos(PVector m){
    return m.x>x&&m.x<x+w&&m.y>y+20&&m.y<y+20+items.size()*20;
  };
  
  boolean dpos(){
    return mouseX>x&&mouseX<x+w&&mouseY>y-10&&mouseY<y;
  };
  
  boolean dpos(PVector m){
    return m.x>x&&m.x<x+w&&m.y>y+20&&m.y<y;
  };

  boolean subMenuPos(){
    return mouseX>x+w-20&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
  };

  boolean subMenuPos(PVector m){
    return m.x>x+w-20&&m.x<x+w&&m.y>y&&m.y<y+h;
  };
};
