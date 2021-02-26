class Window extends Scene{
  
  //float x,y,w,h;
  float bw,bh, navheight = 50,deltay,transparency = 200,transparency1 = 50,transparency2 = 80,transparency3 = 100,transparency4 = 150;
  String label,itemLabel;
  int type = 0,index = -1,click,windex = -1,level = 0,wid;
  color main = color(0);
  color navcol = main,quicknavcol = main,fcol = main,bcol = main,xcol = main,quickNavItemcol = main,navItemcol = main,buttoncol = main,selectcol = main;
  //boolean drag,resize,hover,border,background,hidden,fill = true;
  Button child;
  Menu parent;
  
  float bsize = 12,tsize = 12,svalue,svalue2,colwidth = 100,rowheight = 80;;
  
  boolean smdown,ddown,amendslider,initB,launchable = true,quickAccess,navtoggle = true,transparent;
  public boolean show,open,close;
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Button> quicknav = new ArrayList<Button>();
  ArrayList<Button> buttongrid = new ArrayList<Button>();
  ArrayList<Slider> sliders = new ArrayList<Slider>();
  ArrayList<Window> windows = new ArrayList<Window>();
  ArrayList<PVector> track = new ArrayList<PVector>();
  ArrayList<String> Links = new ArrayList<String>();
  //sliderBox sliders;
  String []list;
  String link,currentp,back,forward,currentl,currentf;
  float [] window;
  color wcol = color(255,50);
  
  Window(){
    
  };
  
  Window(float X,float Y,float WW,float HH){
    
    x = X;
    y = Y;
    w = WW;
    h = HH;
    
    x1 = x;
    y1 = y;
    x2 = x + w;
    y2 = y + h;
    fill = true;
    //scene = new Sc
    
  };
  
  Window(float xx, float yy, float ww,float hh,String dir){
    
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    bw = w;
    bh = h;
    list = listFileNames(dir);
    link = dir;
    currentp = dir;
    ArrayList<String> temp = new ArrayList<String>();
    ArrayList<String> temp2 = new ArrayList<String>();
    
    if(list!=null)
    temp = trimNames(list);
    list = null;
    for(int i =0;i<temp.size();i++){
      
      String l = temp.get(i);
      String ndir = dir + "\\" + l + "\\";
      list = listFileNames(ndir);
      Button a = new Button( x ,y + 20 *(i), w-10,20,l);;
      if(list==null){
        
      
      
      }else {
        temp2 = trimNames(list);
        if(temp2.size()>0){
          a.submenu = new Menu(a.x+20,a.y+a.h,a.w-20,temp2);
          a.submenu.slide = true;
          a.submenu.visible = false;
        }
      }
      a.border = false;
      a.togglebox = true;
      buttons.add(a);
      
  }
  
    parent = new Menu( x + w - 10,y , 10,h-20);
    
    Slider s = new Slider( x + w - 10,y , 10,h);
    //h = buttons.size()*20;
    s.bar = true;
    s.classic = true;
    s.visible = true;
    s.valuex = 0;
    s.vertical = true;
    s.tvisible = false;
    s.tooltip = null;
   
    sliders.add(s);
    Boundary b = new Boundary(x,y-10,w,h+10,4);
    Boundaries.add(b);
    
    for(int i =0;i<buttons.size();i++){
      Button b1 = buttons.get(i);
      Button a = new Button(0,0,40,40,b1.label);
      a.textbtm = true;
      a.tcol = 0;
      a.border = false;
      buttongrid.add(a);
    }
     cols = 5;
     rows = round(buttongrid.size()/cols)+1;
    
    b = new Boundary(x,y-50,cols*colwidth,5*rowheight + navheight,4);
    Boundaries.add(b);
    windows.add(this);
    
     s = new Slider( x + cols*colwidth - 10,y , 10,5*rowheight );
    //h = buttons.size()*20;
    s.bar = true;
    s.classic = true;
    s.visible = true;
    s.valuex = 0;
    s.vertical = true;
    s.tvisible = false;
    s.tooltip = null;
   
    sliders.add(s);
    
    Window W = windows.get(0);
    
    Button b2 = new Button(x+w - 80,y - 40 + 10, 30,30,"Back");
    Button f = new Button(x+w - 80,y - 40 + 10, 30,30,"Forward");
    Button X = new Button(x + colwidth*cols - 35,y-50 + 5, 30,30,"X");
    X.txoff = 7;
    b2.border = false;
    f.border = false;
    X.border = false;
    //X.textbtm = true;
    nav.add(b2);
    nav.add(f);
    nav.add(X);
    
    for(int i=0;i<nav.size()-1;i++){
        Button b1 = nav.get(i);
        
        b1.x = x + 5 + 40 * i;
        b1.y = y - 50 + 5 + dy;
      }
      
   initqNav();
   h = sliders.get(1).h;
  };
  
  Window(float xx, float yy, float ww,float hh,String dir,int n){
    
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    bw = w;
    bh = h;
    list = listFileNames(dir);
    link = dir;
    ArrayList<String> temp = new ArrayList<String>();
    ArrayList<String> temp2 = new ArrayList<String>();
    
    
    if(list!=null)temp = trimNames(list);
    //h = temp.size();
    int j = 0;
    int k = floor(temp.size()/n);
      for(int i =0;i<temp.size();i++){
      
      String l = temp.get(i);
      String ndir = "C:\\Users\\admin" + "\\" + l + "\\";
      list = listFileNames(ndir);
      if(list==null){
      Button a = new Button( x + w*j,y + 20 *(i)-k*20*(j), w-10,20,l);
      a.submenu = new Menu(x+20,y,w-20,20);
      a.submenu.borders(false);
      if(j>0) a = new Button( x + w*j,y + 20 *(i)-k*20*(j)-40, w-10,20,l);
      a.border = false;
      a.togglebox = true;
      buttons.add(a);
      if(i>k*(j+1))j++;
      }else {
        
      Button a = new Button( x + w*j,y + 20 *(i)-k*20*(j), w-10,20,l);
      a.submenu = new Menu(x+20,y,w-20,list);
      a.submenu.visible = false;
      a.submenu.slide = true;
      a.submenu.borders(false);
      if(j>0) a = new Button( x + w*j,y + 20 *(i)-k*20*(j)-40, w-10,20,l);
      a.border = false;
      a.togglebox = true;
      buttons.add(a);
      if(i>k*(j+1))j++;
  }}
    //h = temp.size()*20;
    parent = new Menu( x + w*n - 10,y, 10,h-20);
    
    Slider s = new Slider( x + w*n - 10,y, 10,h);
    //h = buttons.size()*20;
    s.bar = true;
    s.classic = true;
    s.visible = true;
    s.valuex = 0;
    s.vertical = true;
    s.tvisible = false;
    s.tooltip = null;
   
    sliders.add(s);
    w = w*n;
    type = 1;
    Boundary b = new Boundary(x,y-10,w,h+20,4);
    //b.id = -1;
    Boundaries.add(b);
    
    for(int i =0;i<buttons.size();i++){
      Button b1 = buttons.get(i);
      Button a = new Button(0,0,40,40,b1.label);
      a.tcol = 0;
      a.textbtm = true;
      a.border = false;
      buttongrid.add(a);
    }
    cols = 5;
    rows = round(buttongrid.size()/cols);
    windows.add(this);
    
    Button b2 = new Button(x+w - 80,y - 40 + 10, 30,30,"Back");
    Button f = new Button(x+w - 80,y - 40 + 10, 30,30,"Forward");
    Button X = new Button(x + colwidth*cols - 35,y-50 + 5, 30,30,"X");
    b2.border = false;
    f.border = false;
    X.border = false;
    nav.add(b2);
    nav.add(f);
    nav.add(X);
    
    for(int i=0;i<nav.size()-1;i++){
        Button b1 = nav.get(i);
        
        b1.x = x + 5 + 40 * i;
        b1.y = y - 50 + 5 + dy;
      }
      
      initqNav();
      h = sliders.get(1).h;
  };
  
  void initNav(){
    
  };
  
  void initqNav(){
     Button n = new Button(x - 35,y,25,25,"My Computer");
     n = new Button(x - 35,y,25,25,"Data Folder");
     n.textbtm = true;
     n.border = false;
     n.tcol = 0;
     quicknav.add(n);
     n = new Button(x - 35,y + 50,25,25,"Documents");
     n.textbtm = true;
     n.border = false;
     n.tcol = 0;
     quicknav.add(n);
     n = new Button(x - 35,y + 100,25,25,"Downloads");
     n.textbtm = true;
     n.border = false;
     n.tcol = 0;
     quicknav.add(n);
  };
  
  
  void render(){
    
    if(!hidden){
      stroke(0);if(!border)noStroke();
      noFill();
      rect(x,y,w,h);
      display();
      draw();
      functions();
      fill(255);
      for(int i=0;i<scenes.size();i++){
        //scenes.get(i).display();
      }
    }
    sLogic();
  };

  void sLogic(){

    if(mousePressed&&pos()){
      if(BMS.currentMouseObject==null)BMS.currentMouseObject = this.itemLabel;
    }

  };
  
  void display(){
    if(sliders.size()>0)h = sliders.get(0).h;
    if(toggle||show){
    boundingbox();
    submenu();
    menu();
    scrollbar();
    wlogic();
    
    if(Boundaries.size()>0)Boundaries.get(0).draw2();
    }
  };
  
  void boundingbox(){
    noStroke();
    if(!transparent)fill(255);
    else fill(255,transparency);
    // rect(x,y,w,h);
    // rect(x,y-10,w,10);
    
    // fill(0,transparency4);
    // rect(x,y,w,h);
    // fill(0,transparency1);
    // rect(x,y-10,w,10);
  };
  
  void menu(){
    
    if(sliders.size()>0){
      Slider s = sliders.get(0);
      
      //s.value = map(s.valuex,0,s.h,0,buttons.get(index).submenu.items.size()*20);
      
      for(int i=0;i<buttons.size();i++){
        
        Button b = buttons.get(i);
        
        if(b.y>y+h)b.visible = false;
        else b.visible = true;

        if(index<0)svalue = s.value;
        if(index>=i||index==-1)b.y = b.by - s.valuex;
        else if(index>=0&&i>index)b.y = b.by - s.valuex + buttons.get(index).submenu.items.size()*20;
        
        b.x = x;
        b.by = y+10 + b.h*i;
        if(b.y+b.h<=y+h&&b.y>=y){
          if(b.pos())b.self_click2();
          b.draw();
          fill(255);
          textSize(b.bsize);
        if(b.submenu!=null)text(">",b.x+b.w-10,b.y+20);
        textSize(12);
        if(b.submenu!=null&&b.subpos()&&mousePressed&&!smdown){
          smdown = true;
          amendslider = false;
          index = i;
        }
        if(mousePressed&&!b.pos())b.toggle=0;
        b.highlight();
        }
      }
    }
  };
  
  void submenu(){
    if(index>-1){
    Button a = buttons.get(index);
      Menu m = a.submenu;
      //w = bw + 20;
      m.y = a.y+a.h + (dy);
      
      for(int j=0;j<m.items.size();j++){
          Button b = m.items.get(j);
          b.x = x + 20;
          if(b.y+b.h>y+h||b.y<y){
            b.visible=false;
            float dy2 = abs(y - by);
            
            noStroke();
            //if(b.border)strokeWeight(1);
            fill(255);
            rect(b.x,y,b.w,dy2);
            fill(0,150);
            rect(b.x,y,b.w,dy2);
          }
          //b.draw();
          else b.visible = true;
          
        }
      m.draw();
    }
  };
  
  void scrollbar(){
    if(sliders.size()>0){
      Slider s = sliders.get(0);
      
        s.x = x+w-10;
        s.y = y;
        s.draw();
        s.mouseFunctions();
    }
  };
  
  void scrollbar(PGraphics canvas){
    if(sliders.size()>0){
      Slider s = sliders.get(0);
      
        s.x = x+w-10;
        s.y = y;
        // s.draw(mouse);
        // s.mouseFunctions(mouse);
    }
  };
  
  void wlogic(){
    
    float my = mouseY;
    if(click>2)click=0;
    ArrayList<Float> temp = new ArrayList<Float>();
    float dy = 0;

    if(sliders.size()>0){
      Slider s = sliders.get(0);
      if(type==0)s.set(0,buttons.size()-h/20);
      else s.set(0,buttons.size()/3-h/20);
      if(index>-1&&buttons.get(index).pos()&&mousePressed&&!smdown){index=-1;smdown = true;}
      if(pos()&&!s.mdown&&mousePressed)smdown = true;
      if(!mousePressed){smdown = false;ddown=false;}
      if(!pos()&&mousePressed&&!s.mdown){index = -1;smdown = false;}
      if(dpos()&&mousePressed&&!smdown&&!s.mdown){
        ddown = true;
      }
    
    if(ddown){
      
      Boundary b = Boundaries.get(0);
      b.mtranslate(b,new PVector(mouseX,mouseY));
      
      x = b.Boundaries.get(0).x1;
      y = b.Boundaries.get(0).y1+10;
      
    }
    
    if(index>-1&&!amendslider){
      if(!amendslider&&!s.pos()&&!mousePressed){
        s.value = (index)*20;
        s.valuex = map(index,0,buttons.size(),0,h);
        
      }
      
      if(s.pos()&&mousePressed){
        temp.add(my);
        amendslider = true;
        dy = mouseY - temp.get(0);
      }}
    }
  };
  
  void display_grid(){
    h = sliders.get(1).h;
    if(close){
      toggle = false;
      open = false;
      close = false;
    }
    if(toggle){
      close = false;
      open = true;
      toggle = false;
    }
    //else open = false;
    
    if(open){
      gridscrollbar();
      gridboundingbox();
      nav_();
      grid();
      drawQuicknav();
      drawBorder();
      gridlogic();
      
      
    }
    
  };
  
  void drawQuicknav(){
    noStroke();
    if(quickAccess&&navtoggle){
      
        if(!transparent)fill(255);
        else fill(255,transparency);
        rect(x - 80,y - 50,80,h + 50);
        //text("Back",)
        fill(0,transparency1);
        rect(x - 80,y - 50,80,h + 50);
      
      for(int i=0;i<quicknav.size();i++){
        Button b = quicknav.get(i);
        b.x = x - 70;
        b.y = y + 20 + 50 * i;
        //fill(0);
        b.draw();
        fill(0);
        text(b.label,b.x-20,b.h+b.y+20);
        b.highlight();
      }
    }
  };
  
  void gridscrollbar(){
    
    Slider s = sliders.get(1);
    
      s.x = x+cols*colwidth-10;
      s.y = y;
      s.draw();
      s.mouseFunctions();
      s.set(0,rows);
  };
  
  void gridlogic(){
    
    ArrayList<Float> temp = new ArrayList<Float>();
    
    float my = mouseY;
    Button X = nav.get(2);
    if(dposg()&&mousePressed&&!navPos()){
      // BMS.currentObject==this;
      // BMS.currentMouseObject==currentf;
      // fill(255,50);
      // rect(0,0,width,height);
      ddown = true;
    }
    //if(pos()&&mousePressed&&!dposg()&&!ddown)smdown = true;

    //if(dposg()&&mousePressed&&!nav.get(0).pos()&&!nav.get(1).pos()&&!sliders.get(1).mdown&&!smdown&&!globaldown&&!X.pos())ddown = true;
    
    if(sliders.size()>0&&sliders.get(1)!=null){
    if(!ddown&&pos()&&mousePressed&&!dposg()&&!sliders.get(1).pos()&&!mdown&&!ddown&&!sliders.get(1).mdown){
      if(track.size()<2)track.add(new PVector(mouseX,mouseY));
      //mdown = true;
    }}
    else {
      if(mousePressed&&!dposg()&&!sliders.get(1).pos()&&!mdown&&!ddown){
      if(track.size()<2)track.add(new PVector(mouseX,mouseY));
      //mdown = true;
    }}
    
    
    if(!mousePressed){
      smdown = false;
      ddown = false;
      mdown = false;
      track = new ArrayList<PVector>();
      ddown = false;
    }
    
    //text(track.size(),100,100);
    if(track.size()>0){
      
      //noFill();
      fill(0,20);
      stroke(0,50);
      strokeWeight(1);
      rect(track.get(0).x,track.get(0).y,(mouseX - track.get(0).x ),(mouseY - track.get(0).y));
      
    }
    
    
    if(ddown){
      
    }
    Boundary b = Boundaries.get(1);
    
    
    if(!mdown&&!ddown)X.latch(this,"close");
    if(ddown){
      
      b.mtranslate(new PVector(mouseX,mouseY));
      x = b.Boundaries.get(0).x1;
      y = b.Boundaries.get(0).y1+50;
      
      X.y = y-50 + 5 + dy;
      X.x = x + colwidth*cols - 35;
      
      for(int i=0;i<nav.size()-1;i++){
        Button b1 = nav.get(i);
        
        b1.x = x + 5 + 40 * i;
        b1.y = y - 50 + 5 + dy;
      }
    }else{
      b.mdown = false;
    }
    
    Boundaries.get(1).draw2();
    
    if(sliders.get(1).pos()&&mousePressed){
        temp.add(float(mouseY));
        deltay = mouseY - temp.get(0);
      }
      
     rows = round(windows.get(windows.size()-1).buttons.size()/5)+1;
  };
  
  void gridboundingbox(){
      noStroke();
      if(!transparent)fill(255);
      else fill(255,transparency);
      rect(x,y,colwidth*cols,rowheight*(5));
      
      fill(0,transparency3);
      //rect(x,y,colwidth*cols,rowheight*(5));
      if(!transparent)fill(255);
      else fill(255,transparency);
      rect(x,y-navheight,colwidth*cols,navheight);
      
      fill(0,transparency1);
      rect(x,y-navheight,colwidth*cols,navheight);
      fill(0);
      //if(currentp!=null)text(currentp,x+100,y-20);
  };
  
  void drawBorder(){
    if(!quickAccess&&border||!navtoggle){
        stroke(0);
        noFill();
        rect(x,y-50,colwidth*cols,h+50);
      }
      else if(quickAccess&&border){
        stroke(0);
        noFill();
        rect(x - 80,y-50,colwidth*cols+80,h+50);
      }
  };
  
  void nav_(){

    for(int i=0;i<nav.size();i++){
        Button b = nav.get(i);
        
        b.textbtm = true;
        
        b.draw();
        b.highlight();
        
        if(b.pos()&&mousePressed&&b.label=="Back"&&!smdown){
          if(windows.size()>1){
            windows.remove(windows.size()-1);
            currentp = windows.get(windows.size()-1).link;
            sliders.get(0).value = 0;sliders.get(0).valuey = 0;
          }
        }
        if(b.pos()&&mousePressed&&b.label=="Forward"&&!smdown&&forward!=null){
          Window w1 = new Window(x,y,w,h,forward);
          windows.add(w1);
          currentp = windows.get(windows.size()-1).link;
        }
      }
      // Button b = nav.get(0);
      // Button n = nav.get(1);
      // Button x = nav.get(2);
      // fill(0);
      // if(transparent&&b.pos())fill(255);
      // text(b.label,b.x ,b.y + b.h + 10);
      // fill(0);
      // if(transparent&&n.pos())fill(255);
      // text(n.label,n.x ,n.y + n.h + 10);
      // fill(0);
      // if(transparent&&x.pos())fill(255);
      // textSize(20);
      // text(x.label,x.x + 10,x.y + 25);
      // textSize(12);
      // Button X = nav.get(2);
      // X.draw();
      // X.highlight();
      
  };
  
  void grid(){
    
    Window w2 = windows.get(windows.size()-1);
    Slider s = sliders.get(1);
    
    for(int i=0;i<rows;i++){
      for(int j=0;j<cols;j++){
        
        int pos = j+i*cols;
        Button b = null;
        if(pos<w2.buttongrid.size()){
        b = w2.buttongrid.get(pos);
        Button b1 = w2.buttons.get(pos);
        b1.border = false;
        b.textbtm = true;
        b.x = x + 10 + colwidth * j;
        b.y = y + 10 + (rowheight+b.tsize) * i - s.value;
        b.highlight3();
        if(b.y<y||b.y+b.h + b.tsize>y + rowheight * 5)b.visible = false;
        else b.visible = true;
        if(!b.textcheck)b.labelcheck(colwidth);
          
        if(b.visible)b.draw();
        fill(0);
        if(b.pos())b.highlight();
        
        fill(0); 
        if(b.pos()&&b.submenu!=null){
          int size = currentp.length();
          if(currentp.charAt(size-1)!='\\')currentp += "\\";
           currentl = currentp + b.blabel;
        }
        //else if(b.pos()&&b.submenu==null){
        //  int size = currentp.length();
        //  if(currentp.charAt(size-1)!='\\')currentp += "\\";
        //   currentf = currentp + b.blabel;
        //}
        if(b.pos()&&mousePressed&&b1.submenu!=null&&!smdown){
          int size = currentp.length();
          if(currentp.charAt(size-1)!='\\')currentp += "\\";
          back = currentp;
          currentp += b.blabel;
          forward = currentp;
          Window w1 = new Window(w2.x+200,w2.y,w,h,currentp);
          windows.add(w1);
          windex = 0;
          s.value = 0;
          s.valuex = 0;
          wid = windows.size()-1;
          smdown = true;
        }else if(b.pos()&&mousePressed&&b1.submenu==null&&!smdown){
          int size = currentp.length();
          if(currentp.charAt(size-1)!='\\')currentp += "\\";
          String file = currentp + b.blabel;
          currentf = file;
          //if(launchable)launch(file);
          smdown = true;
        }
      }}}
    if(!mousePressed)smdown = false;
  };
  
  void navbar(){
    
  };

  boolean navPos(){
    boolean k = false;
    if(nav!=null){
      for(int i=0;i<nav.size();i++){
        if(nav.get(i).pos()){
          k = true;
          break;
        }
      }
    }
    return k;
  };
  
  boolean dpos(){
    return mouseX>x&&mouseX<x+w&&mouseY>y-10&&mouseY<y;
    
  };
  
  boolean dposg(){
    return mouseX>x&&mouseX<x+cols*colwidth&&mouseY>y-50&&mouseY<y;
    
  };
  
  boolean pos(){
    
    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
    
  }
  
};
