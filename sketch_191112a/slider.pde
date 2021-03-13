class Slider{
  
  int id = -1,type,functionId;
  float x,y,w,h,bx,by,bw,bh,valuex,valuey,btnw,btnh, value = 0,toffx,toffy,spacing = 20,tsize = 12,ssize,temp,startvalue,endvalue,start,end,r1,r2,r3,r4,radius,pieVal;
  String label,parentVar,parentBool,itemLabel;
  boolean drag,resize,border,fill = true ,toggle,visible = true,horizontal = true,vertical,matrix,classic,pie,radio,square,bar,mdown,mup,Label,right,up,down,left,tvisible = true,update = true,
          tdown,parentCanvas,mdown1;
  public boolean localTheme;
  color col = color(0);
  color col2 = color(255);
  color col3 = color(255,100);
  color barcol = color(0, 255, 73),col4 = color(0,50),tcol = color(255),slidercol = color(255),hovercol = BMS.hcol,toggleCol = color(50,0),sliderbgcol = color(255);
  String control = "";
  Object Link,parentObject;
  Menu parent;
  tab tooltip,parentTab;
  PVector mouse;
  TextBox Start = null,End = null,Current = null;
  HashMap<String,Boolean> values = new HashMap<String,Boolean>();
  
  Slider(float xx,float yy, float ww, float hh){
    
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    bx = x;
    by = y;
    bw = w;
    bh = h;
    btnh = h+2;
    btnw = h;
    valuex = w/2;
    valuey = y;
    //value = 0;
    //valuex = 0;
    classic = true;
    bar = true;
    
    createOptionsMenu();
    
  };
  Slider(float xx,float yy, float ww, float hh,String Label){
    
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    bx = x;
    by = y;
    bw = w;
    bh = h;
    btnh = h+2;
    btnw = h;
    label = Label;
    valuex = w/2;
    valuey = y;
    value = 0;
    classic = true;
    bar = true;
    createOptionsMenu();
    
  };
  
  void createOptionsMenu(){
    tooltip = new tab(x,w,50,120,this);
    String[] s1 = {"Reset"};
    float X = x+w+textWidth("0.000")+20;
    Menu options = new Menu(0,0,80,s1,0);
    tooltip.w = options.w;
    tooltip.add(options);
    TextBox t1 = new TextBox(0,0+30,68,20,20,"Start");
    tooltip.add(t1);
    t1.w = options.w;
    t1 = new TextBox(0,0+60,68,20,20,"End");
    t1.w = options.w;
    tooltip.add(t1);
    t1 = new TextBox(0,0+90,68,20,20,"Value");
    t1.w = options.w;
    tooltip.textboxes.add(t1);
    Start = tooltip.textboxes.get(0);
    End = tooltip.textboxes.get(1);
    tooltip.h = 90+20;
    
  };
  
  void updateOptionsMenu(){
    //if(!tooltip.drag&&!dragged){
    tooltip.x = x+w+textWidth("0.000")+20;
    Menu options = tooltip.menus.get(0);
    
    
    options.x = 0;
    options.y = 0;
    for(int i=0;i<tooltip.menus.get(0).items.size();i++){
      Button b = tooltip.menus.get(0).items.get(i);
      b.x = 0;
      b.y = 0 + 20 * i;
    }
    TextBox t1 = tooltip.textboxes.get(0);
    t1.y = 0+30;
    t1.x = 0;
    t1 = tooltip.textboxes.get(1);
    t1.y = 0+60;
    t1.x = 0;
    t1 = tooltip.textboxes.get(2);
    t1.y = 0+90;
    t1.x = 0;
    Start = tooltip.textboxes.get(0);
    End = tooltip.textboxes.get(1);
    
    if(tooltip.y+tooltip.h>height)tooltip.draggable = true;
    else tooltip.draggable = false;
    
  };
  
  void updateOptionsMenu(PGraphics canvas){
    //if(!tooltip.drag&&!dragged){
    tooltip.x = x+w+textWidth("0.000")+20;
    tooltip.y = y;
    Menu options = tooltip.menus.get(0);
    
    options.x = 0;
    options.y = 0;
    for(int i=0;i<tooltip.menus.get(0).items.size();i++){
      Button b = tooltip.menus.get(0).items.get(i);
      b.x = 0;
      b.y = 0 + 20 * i;
    }
    TextBox t1 = tooltip.textboxes.get(0);
    t1.y = 0+30;
    t1.x = 0;
    t1 = tooltip.textboxes.get(1);
    t1.y = 0+60;
    t1.x = 0;
    t1 = tooltip.textboxes.get(2);
    t1.y = 0+90;
    t1.x = 0;
    Start = tooltip.textboxes.get(0);
    End = tooltip.textboxes.get(1);
    
    if(tooltip.y+tooltip.h>height)tooltip.draggable = true;
    else tooltip.draggable = false;
    
  };
  
  void draw(){
    functions();
     fill(255);
     
    if(tooltip!=null){
      if(tooltipPos()){
        noStroke();
        //if(stroke)stroke(0);
        fill(BMS.col);
        if(localTheme)fill(barcol);
        String k = "0.0000";
        rect(x+w+textWidth(k),y,20,h);
      }
      if(tooltipPos()&&!mdown&&mousePressed){
        
        tooltip.x = x+w+textWidth("0.000")+20;
        tooltip.y = y;
        tooltip.trace();
        
        //important
        tooltip.toggle = true;
        tooltip.visible = true;
        mdown = true;
        tdown = true;
      }
       if(!tooltip.draggable){
       if((!tooltip.posTab()&&!mdown&&tdown&&mousePressed)){
        
         tooltip.toggle = false;
         tooltip.visible = false;
         mdown = true;
         tdown = false;
         //cursor(ARROW);
       }}else 
      if((!tooltip.posTabd()&&!mdown&&tdown&&mousePressed)&&!tooltip.posTab()){
        
        tooltip.toggle = false;
        tooltip.visible = false;
        mdown = true;
        tdown = false;
        //cursor(ARROW);
      }
      if(!mousePressed)mdown = false;
      if(tdown){
        updateOptionsMenu();
        tooltip.displayTab(); 
        
        if(tooltip.menus.get(0).items.get(0).pos(new PVector(mouseX-tooltip.x,mouseY-tooltip.y))&&mousePressed){
          tooltip.menus.get(0).items.get(0).toggle=1;
          resetControl();
          valuex = w/2;
          value = 0;
          //cursor(ARROW);
          tdown = false;
      }
      //if(!tdown)cursor(ARROW);
      TextBox t = tooltip.textboxes.get(2);
      
      if(float(t.textBox)>-99999999&&keyPressed&&key==ENTER){
        if(parent!=null){

            valuex = t.value;
            switch(functionId){
              
              case(0):set(startvalue,endvalue,parentObject, parentVar);
              break;
              case(1):set(startvalue,endvalue,parentObject, parentVar,parentBool);
              break;
              case(2):setint((int)startvalue,(int)endvalue,parentObject, parentVar);
              break;
              case(3):setint((int)startvalue,(int)endvalue);
              break;
            }
          }
        setControl(t.value);
      }}

    if(!mousePressed){
      mdown = false;
      
      for(int i=0;i<tooltip.menus.get(0).items.size();i++){
        Button b = tooltip.menus.get(0).items.get(i);
        
        b.toggle=0;
      }}}
  };

  void draw(PGraphics canvas){
    functions(canvas);
    //if(mouse==null)mouse = new PVector(mouseX,mouseY);
    //classicBar(canvas);
    //canvas.fill(0,255,0);
    //if (parentTab!=null)mouse = new PVector(mouseX-parentTab.x,mouseY-parentTab.y);
    //else println("no tab");
    //canvas.ellipse(m.x,m.y,20,20);
    if(tooltip!=null){
      if(tooltipPos(mouse)){
        canvas.noStroke();
        //if(stroke)stroke(0);
        canvas.fill(BMS.col);
        if(localTheme)canvas.fill(barcol);
        String k = "0.0000";
        PVector m = tooltip.getMouse(mouse);
        //canvas.rect(x+w+textWidth(k),y,20,h);
      }
      if(tooltip!=null&&tooltipPos(mouse)&&!mdown&&!tdown&&mousePressed){
        
        tooltip.x = x+w+textWidth("0.000")+20;
        tooltip.y = y;
        //important
        tooltip.toggle=true;
        tooltip.visible = true;
        mdown = true;
        tdown = true;
      }
      if(tooltip!=null&&!tooltip.draggable){

      if((!tooltip.posTab(mouse)&&!mdown&&tdown&&mousePressed)||pos(mouse)&&mousePressed){
        
        tooltip.toggle=false;
        tooltip.visible = false;
        mdown = true;
        tdown = false;
        //cursor(ARROW);
      }}else if((tooltip!=null&&!tooltip.posTabd(mouse)&&!mdown&&tdown&&mousePressed)||pos(mouse)&&mousePressed){
        
        tooltip.toggle=false;
        tooltip.visible = false;
        mdown = true;
        tdown = false;
        //cursor(ARROW);
      }
      
      if(tdown&&!mdown){
        updateOptionsMenu(canvas);
        tooltip.mouse2 = mouse;
        if(parentTab!=null)tooltip.parentTab = parentTab;
        tooltip.displayTab(canvas); 
        fill(255);
        
        if(tooltip.menus.get(0).items.get(0).pos(new PVector(mouse.x-tooltip.x,mouse.y-tooltip.y))&&mousePressed){
          tooltip.menus.get(0).items.get(0).toggle=1;
          resetControl();
          valuex = w/2;
          value = 0;
          
          
          //cursor(ARROW);
      }
      //else if(!tdown)cursor(ARROW);
      TextBox t = tooltip.textboxes.get(2);
      
      if(float(t.textBox)>-99999999&&keyPressed&&key==ENTER){
        //update = true;
        if(parent!=null){

            // for(int i=0;i<5;i++;){
            //   if(functionId==i){
            //     set()
            //   }
            // }
            valuex = t.value;
            switch(functionId){
              case(0):set(startvalue,endvalue,parentObject, parentVar);
              //println(startvalue,endvalue,parentObject, parentVar);
              break;
              case(1):set(startvalue,endvalue,parentObject, parentVar,parentBool);
              break;
              case(2):setint((int)startvalue,(int)endvalue,parentObject, parentVar);
              break;
              case(3):setint((int)startvalue,(int)endvalue);
              break;
            }
          }
      }
      //println(valuex);
        //setControl(t.value);
        //update = false;
      }
      if(!mousePressed){
        mdown = false;
        if(tooltip!=null)
        for(int i=0;i<tooltip.menus.get(0).items.size();i++){
          Button b = tooltip.menus.get(0).items.get(i);
          
          b.toggle=0;
    }}}
  };
  
  void set(String a){
    if(a=="vertical"||a=="Vertical"||a=="VERTICAL"){}
  };
  
  
  void resetControl(){
    Field field = null;

    try{
         field = Link.getClass().getField("sUpdate"); 
         //field.set(Link, "sUpdate");
         field.set(Link, true); 
         //println(field.get(Link),"update",control,Link);
    }catch (NullPointerException e) {
      println("null slider");
    }catch (NoSuchFieldException e) {
      println("no field: update");
    }catch (IllegalAccessException e) {
    } 
            
    try{
         field = Link.getClass().getField(control); 
         field.set(Link, 0); 
         //println(valuex);
    }catch (NullPointerException e) {
      println("null p slider");
    }catch (NoSuchFieldException e) {
      println("no field");
    }catch (IllegalAccessException e) {
    } 
  };
  
  void setControl(float a){
    value = a;
    valuex = map( value,startvalue,endvalue, 0+1, w-1);
            Field field = null;
    try{
         field = Link.getClass().getField("sUpdate"); 
         //field.set(Link, "sUpdate");
         field.set(Link, true); 
         //println(field.get(Link),"update",control,Link);
    }catch (NullPointerException e) {
      println("s control; null");
    }catch (NoSuchFieldException e) {
      println("s control; no field: update");
    }catch (IllegalAccessException e) {
    } 
    try{
         field = Link.getClass().getField(control); 
         //field.set(Link, "update");
         field.set(Link, a); 
         //println(field.get(Link),valuex,control,Link);
    }catch (NullPointerException e) {
      println("s control; null");
    }catch (NoSuchFieldException e) {
      println("s control; no field");
    }catch (IllegalAccessException e) {
    } 
  };
  
  void setStart(float a){
            Field field = null;
    try{
         field = Link.getClass().getField(control); 
         field.set(Link, a); 
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    } 
  };
  
  void setEnd(float a){
            Field field = null;
    try{
         field = Link.getClass().getField(control); 
         field.set(Link, a); 
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    } 
  };
  
  void functions(){
    stroke(col);
    if(!border){
     noStroke(); 
    }
    if(classic){
      if(square)classicSquare();
      else if(radio)classicRadio();
      else if(bar)classicBar();
    }else if(matrix){
      if(square)Matrix();
      else if(radio){}
      else if(bar){}
    }else if(pie){
      if(square)pieSquare();
      else if(radio)pieRadio();
      else if(bar)pieBar();
    }
  };
  
  void functions(PGraphics canvas){
    if(visible){
    canvas.stroke(col);
    if(!border){
     canvas.noStroke(); 
    }
    if(classic){
      if(square)classicSquare(canvas);
      else if(radio)classicRadio(canvas);
      else if(bar)classicBar(canvas);
    }else if(matrix){
      if(square)Matrix();
      else if(radio){}
      else if(bar){}
    }else if(pie){
      if(square)pieSquare(canvas);
      else if(radio)pieRadio();
      else if(bar)pieBar();
    }}
  };
  
 void classicSquare(){
    //----------slider bg-----------
    fill(slidercol);
    if(vertical)rect(x,y,w,h,r1,r2,r3,r4);
    else rect(x,y,w,h,r1,r2,r3,r4);
    
    if(pos())fill(BMS.hcol);if(!fill)noFill();
    
    if(vertical)rect(x,y,w,h,r1,r2,r3,r4);
    else rect(x,y,w,h,r1,r2,r3,r4);
    
    textSize(tsize);
    strokeWeight(ssize);
    stroke(0);
    if(parent==null){
    if(btnpos()||pos()||mdown)fill(col4);btnh = h+10;
    }
    
      if(label!=null){
        fill(tcol);
        if(vertical)text(label,x,y-tsize);
        else text(label,x-textWidth(label),y+h);
      }
      if(!vertical)btnh = h;
      noStroke();
      
      fill(barcol);
      
      if(vertical)rect(x,y+valuex,btnw-2,btnw-2,r1,r2,r3,r4);
      else  rect(x + valuex,y,btnw,btnh,r1,r2,r3,r4);
      fill(255);
      
      //slider value-------------------
      rectMode(CORNER);
      fill(BMS.col);
      if(vertical)rect(x,y+valuex,btnw-2,btnw-2,r1,r2,r3,r4);
      else rect(x+valuex,y,btnw,btnh,r1,r2,r3,r4);
      
      
      
      fill(tcol);
      if(vertical){
        pushMatrix();
        translate(x+w+toffx,y+h+toffy);
        rotate(PI/2);
        
        translate(-(x+w+toffx),-(y+h+toffy-w));
        text(value,x+w+toffx,y+h+toffy);
        popMatrix();
      }else text(value,x+w+toffx,y+h+toffy);
      
  };
  
  void classicSquare(PGraphics canvas){
    //----------slider bg-----------
    canvas.fill(slidercol);
    if(vertical)canvas.rect(x,y,w,h,r1,r2,r3,r4);
    else canvas.rect(x,y,w,h,r1,r2,r3,r4);
    
    if(pos(mouse))canvas.fill(BMS.hcol);if(!fill)canvas.noFill();
    
    if(vertical)canvas.rect(x,y,w,h,r1,r2,r3,r4);
    else canvas.rect(x,y,w,h,r1,r2,r3,r4);
    
    canvas.textSize(tsize);
    canvas.strokeWeight(ssize);
    canvas.stroke(0);
    if(parent==null){
    if(btnpos(mouse)||pos(mouse)||mdown)canvas.fill(col4);btnh = h+10;
    }
    
      if(label!=null){
        canvas.fill(tcol);
        if(vertical)canvas.text(label,x,y-tsize);
        else canvas.text(label,x-textWidth(label),y+h);
      }
      if(!vertical)btnh = h;
      canvas.noStroke();
      
      canvas.fill(barcol);
      //canvas.fill(BMS.col);
      if(pos(mouse))canvas.fill(BMS.hcol);
      if(vertical)canvas.rect(x,y+valuex,btnw-2,btnw-2,r1,r2,r3,r4);
      else  canvas.rect(x + valuex,y,btnw,btnh,r1,r2,r3,r4);
      canvas.fill(255);
      
      //slider value-------------------
      canvas.rectMode(CORNER);
      canvas.fill(BMS.fcol);
      if(vertical)canvas.rect(x,y+valuex,btnw-2,btnw-2,r1,r2,r3,r4);
      else canvas.rect(x+valuex,y,btnw,btnh,r1,r2,r3,r4);
      
      canvas.fill(tcol);
      if(vertical){
        canvas.pushMatrix();
        canvas.translate(x+w+toffx,y+h+toffy);
        canvas.rotate(PI/2);
        
        canvas.translate(-(x+w+toffx),-(y+h+toffy-w));
        canvas.text(value,x+w+toffx,y+h+toffy);
        canvas.popMatrix();
      }else canvas.text(value,x+w+toffx,y+h+toffy);
      
  };
  
  void classicRadio(){
    //----------slider bg-----------
    fill(slidercol);
    if(vertical)rect(x+w/2-2,y+valuex,4,h-valuex,r1,r2,r3,r4);
    else rect(x,y+h/2-2,w,4,r1,r2,r3,r4);
    
    if(pos())fill(hovercol);if(!fill)noFill();
    
    if(vertical)rect(x+w/2-2,y+valuex,4,h-valuex,r1,r2,r3,r4);
    else rect(x,y+h/2-2,w,4,r1,r2,r3,r4);
    
    textSize(tsize);
    strokeWeight(ssize);
    stroke(0);
    if(parent==null){
    if(btnpos()||pos()||mdown)fill(col4);btnh = h+10;
    }
    
      if(label!=null){
        fill(tcol);
        if(vertical)text(label,x,y-tsize);
        else text(label,x-textWidth(label),y+h);
      }
      if(!vertical)btnh = h;
      noStroke();
      fill(255);
      
      //slider value-------------------
      ellipseMode(CORNER);
      //text(valuex , 500,500 + 10*id);
      if(vertical)ellipse(x,y+valuex,btnw-2,btnw-2);
      else ellipse(x+valuex,y,btnw,btnh);
      
      fill(barcol);
      
      if(vertical)ellipse(x,y+valuex,btnw-2,btnw-2);
      else  ellipse(x + valuex,y,btnw,btnh);
      
      fill(tcol);
      if(vertical){
        pushMatrix();
        translate(x+w+toffx,y+h+toffy);
        rotate(PI/2);
        
        translate(-(x+w+toffx),-(y+h+toffy-w));
        text(value,x+w+toffx,y+h+toffy);
        popMatrix();
      }else text(value,x+w+toffx,y+h+toffy);
      
  };
  
  void classicRadio(PGraphics canvas){
    //----------slider bg-----------
    canvas.fill(slidercol);
    if(vertical)canvas.rect(x+w/2-2,y+valuex,4,h-valuex,r1,r2,r3,r4);
    else canvas.rect(x,y+h/2-2,w,4,r1,r2,r3,r4);
    
    if(pos())canvas.fill(hovercol);if(!fill)canvas.noFill();
    
    if(vertical)canvas.rect(x+w/2-2,y+valuex,4,h-valuex,r1,r2,r3,r4);
    else canvas.rect(x,y+h/2-2,w,4,r1,r2,r3,r4);
    
    canvas.textSize(tsize);
    canvas.strokeWeight(ssize);
    canvas.stroke(0);
    if(parent==null){
    if(btnpos()||pos()||mdown)canvas.fill(col4);btnh = h+10;
    }
    
      if(label!=null){
        canvas.fill(tcol);
        if(vertical)canvas.text(label,x,y-tsize);
        else canvas.text(label,x-textWidth(label),y+h);
      }
      if(!vertical)btnh = h;
      canvas.noStroke();
      canvas.fill(255);
      
      //slider value-------------------
      canvas.ellipseMode(CORNER);
      //text(valuex , 500,500 + 10*id);
      if(vertical)canvas.ellipse(x,y+valuex,btnw-2,btnw-2);
      else canvas.ellipse(x+valuex,y,btnw,btnh);
      
      canvas.fill(barcol);
      
      if(vertical)canvas.ellipse(x,y+valuex,btnw-2,btnw-2);
      else  canvas.ellipse(x + valuex,y,btnw,btnh);
      
      canvas.fill(tcol);
      if(vertical){
        canvas.pushMatrix();
        canvas.translate(x+w+toffx,y+h+toffy);
        canvas.rotate(PI/2);
        
        canvas.translate(-(x+w+toffx),-(y+h+toffy-w));
        canvas.text(value,x+w+toffx,y+h+toffy);
        canvas.popMatrix();
      }else canvas.text(value,x+w+toffx,y+h+toffy);
      
  };
  
  void classicBar(){
    //----------slider bg-----------
    fill(slidercol);
    if(vertical)rect(x,y+valuex,w,h-valuex,r1,r2,r3,r4);
    else rect(x+valuex,y,w-valuex,h,r1,r2,r3,r4);
    
    if(pos())fill(hovercol);if(!fill)noFill();
    
    if(vertical)rect(x,y+valuex,w,h-valuex,r1,r2,r3,r4);
    else rect(x + valuex,y,w-valuex,h,r1,r2,r3,r4);
    
    textSize(tsize);
    strokeWeight(ssize);
    stroke(0);
    if(parent==null){
    if(btnpos()||pos()||mdown)fill(col4);btnh = h+10;
    }
    
      if(label!=null){
        fill(BMS.tcol);
        if(localTheme)fill(tcol);
        if(vertical)text(label,x,y-tsize);
        else text(label,x-textWidth(label),y+h);
      }
      if(!vertical)btnh = h;
      noStroke();
      fill(255);
      
      //slider value-------------------
      if(vertical)rect(x,y,w,valuex,r1,r2,r3,r4);
      else rect(x,y,valuex,btnh,r1,r2,r3,r4);
      fill(barcol);
      if(vertical)rect(x,y,w,valuex,r1,r2,r3,r4);
      else rect(x,y,valuex,btnh,r1,r2,r3,r4);
      fill(BMS.tcol);
      if(localTheme)fill(tcol);
      if(vertical){
        pushMatrix();
        translate(x+w+toffx,y+h+toffy);
        rotate(PI/2);
        
        translate(-(x+w+toffx),-(y+h+toffy-w));
        if(tvisible)text(value,x+w+toffx,y+h+toffy);
        popMatrix();
      }else if(tvisible)text(value,x+w+toffx,y+h+toffy);
      
   
  };
  
  void classicBar(PGraphics canvas){
    canvas.fill(255);
    if(mouse==null){
      if(parentTab!=null)println("cb","parent tab");
      else println("cb","no parent tab");
      mouse = new PVector(mouseX,mouseY);
    }

    //----------slider bg-----------
    canvas.fill(slidercol);
    if(vertical)canvas.rect(x,y+valuex,w,h-valuex,r1,r2,r3,r4);
    else canvas.rect(x,y,w,h,r1,r2,r3,r4);
    
    if(pos(mouse))canvas.fill(hovercol);if(!fill)canvas.noFill();
    
    if(vertical)canvas.rect(x,y+valuex,w,h-valuex,0,r2,r3,0);
    else canvas.rect(x ,y,w,h,r1,r2,r3,r4);
    
    canvas.textSize(tsize);
    canvas.strokeWeight(ssize);
    canvas.stroke(0);
    if(parent==null){
    if(btnpos(mouse)||pos(mouse)||mdown)canvas.fill(col4);btnh = h+10;
    }
    
      if(label!=null){
        canvas.fill(tcol);
        if(vertical)canvas.text(label,x,y-tsize);
        else canvas.text(label,x-canvas.textWidth(label),y+h);
      }
      if(!vertical)btnh = h;
      canvas.noStroke();
      canvas.fill(255);
      //slider value-------------------
      //if(vertical)canvas.rect(x,y,w,valuex,r1,0,r3,r4);
      //else canvas.rect(x,y,valuex,btnh,r1,0,r3,r4);
      canvas.fill(barcol);
      if(vertical)canvas.rect(x,y,w,valuex,r1,r2,r3,r4);
      else canvas.rect(x,y,valuex,btnh,r1,r2,r3,r4);
      canvas.fill(tcol);
      if(vertical){
        canvas.pushMatrix();
        canvas.translate(x+w+toffx,y+h+toffy);
        canvas.rotate(PI/2);
        
        canvas.translate(-(x+w+toffx),-(y+h+toffy-w));
        if(tvisible)canvas.text(value,x+w+toffx,y+h+toffy);
        canvas.popMatrix();
      }else if(tvisible)canvas.text(value,x+w+toffx,y+h+toffy);
      
   
  };
  
  void Matrix(){
    if(!fill){
      noFill();
    }
    fill(col2);
    rect(x,y,w,h);
    
  };
  
  void pieSquare(){
    float val = 0;
    float v1 = 5;
    if(dist(mouseX,mouseY,x,y)<radius&&mousePressed&&!mdown1&&BMS.sliderObject ==null){
      mdown1 = true;
      BMS.sliderObject = this;
    }
    //if(mdown)val = map(mouseX,0,width,0,2*PI);
    if(mdown1)pieVal = abs(2*PI-(atan2(x-mouseX,y-mouseY)+PI/2));
    if(pieVal>2*PI)pieVal -=PI*2;
    
    fill(255);
    if(dist(mouseX,mouseY,x,y)<radius)
    fill(BMS.fcol);
    ellipse( x,y,radius*2-v1,radius*2-v1);
    fill(255);
    ellipse( x,y,radius*2-v1,radius*2-v1);
    fill(BMS.fcol);
    if(dist(mouseX,mouseY,x,y)<radius)
    fill(BMS.hcol);
    arc(x,y, 120, 120, 0, pieVal, PIE);
    fill(255);
    ellipse( x,y,75,75);
    fill(BMS.hcol);
    if(dist(mouseX,mouseY,x,y)<radius)
    fill(BMS.fcol);
    ellipse( x,y,75,75);
    stroke(255);
    strokeWeight(5);
    fill(BMS.tcol);
    float val1 = map(pieVal,0,2*PI,startvalue,endvalue);
    if(mdown1)value = val1;
    fill(0);
    text(val1,x-40,y+h-40);
    if(!mousePressed){
      mdown1 = false;
      if(BMS.sliderObject == this)BMS.sliderObject = null;
    }
  };
  
  void pieSquare(PGraphics canvas){
    float v1 = 10;
    pieLogic(mouse);
    
    canvas.fill(255);
    if(dist(mouse.x,mouse.y,x,y)<radius)
    canvas.fill(BMS.fcol);
    canvas.ellipse( x,y,radius*2-v1,radius*2-v1);
    canvas.fill(255);
    canvas.ellipse( x,y,radius*2-v1,radius*2-v1);
    canvas.fill(BMS.fcol);
    if(dist(mouse.x,mouse.y,x,y)<radius)
    canvas.fill(BMS.hcol);
    canvas.arc(x,y, radius*2, radius*2, 0, pieVal, PIE);
    canvas.fill(255);
    canvas.ellipse( x,y,radius*2-25,radius*2-25);
    canvas.fill(BMS.hcol);
    if(dist(mouse.x,mouse.y,x,y)<radius)
    canvas.fill(BMS.fcol);
    canvas.ellipse( x,y,radius*2-25,radius*2-25);
    canvas.stroke(255);
    fill(BMS.tcol);
    fill(0);
    canvas.text(value,x-20,y+h-h/2+10);
    if(mdown1&&!mousePressed){
      mdown1 = false;
      if(BMS.sliderObject == this)BMS.sliderObject = null;
    }
  };
  void pieLogic(){
    
  };
  
  void pieLogic(PVector mouse){
    if(dist(mouse.x,mouse.y,x,y)<radius&&mousePressed&&!mdown1&&BMS.sliderObject ==null){
      mdown1 = true;
      BMS.sliderObject = this;
      
    }
    if(dist(mouse.x,mouse.y,x,y)>radius&&mousePressed&&!mdown1&&BMS.sliderObject ==this){
      BMS.sliderObject = null;
      
    }
    if(mdown1&&BMS.sliderObject==this){
      pieVal = abs(2*PI-(atan2(x-mouse.x,y-mouse.y)+PI/2));
      if(pieVal>2*PI)pieVal -=PI*2;
      value = map(pieVal,0,2*PI,startvalue,endvalue);
    }
  };
  
  void pieRadio(){
    if(!fill){
      noFill();
    }
    fill(col2);
    ellipseMode(CENTER);
    ellipse(x,y,w,h);
    arc(x,y,w,h,valuex,valuey);
    arc(x+10,y+10,w,h,valuex,valuey);
    fill(col3);
    ellipseMode(CENTER);
    if(!horizontal){
      ellipse(x+valuex,y,btnw,btnh);
    }else{
      ellipse(x,y + valuey,10,btnh);
    }
  };
  void pieBar(){
    if(!fill){
      noFill();
    }
    fill(col2);
    ellipseMode(CENTER);
    ellipse(x,y,w,h);
    arc(x,y,w,h,valuex,valuey);
    arc(x+10,y+10,w,h,valuex,valuey);
    //line();
  };
  
  void mouseFunctions(){
    if(pos()&&mousePressed&&BMS.sliderObject==null){
      BMS.sliderObject = this;
      mup = false;
      mdown = true;
      toggle = true;
    }
    
    if(mdown&&!tdown&&!parentCanvas&&BMS.sliderObject==this){
      if(bar){
        if(vertical){
        if(mouseY>y&&mouseY<y + h-1)valuex = mouseY-y;
        if(mouseY>y+h-1)valuex = h-1;
        }else{
          if(mouseX>x&&mouseX<x + w-1)valuex = mouseX-x;
          if(mouseX>x+w-1)valuex = w-1;
        }}
      else if(radio||square){
        if(vertical){
          if(mouseY>y-1&&mouseY<y + h-1&&mouseX>x && mouseX < x + w)valuex = mouseY-y-1;
          if(mouseY>y+h-btnw)valuex = h-btnw;
        }else{
          if(mouseX>x-1&&mouseX<x + w-btnw && mouseY>y && mouseY < y + h)valuex = mouseX-x;
          if(mouseX>x+w-btnw)valuex = w-btnw;
        }}
      }
    if(mdown&&!mousePressed&&!tdown&&BMS.sliderObject==null){
      BMS.sliderObject = this;
      mdown = false;
      toggle = false;
    }
    if(mdown&&!mousePressed&&BMS.sliderObject==this){
      BMS.sliderObject = null;
      mdown = false;
    }
  };
  
  void mouseFunctions(PVector m){
    // if(mouse==null){
      //  if(parentTab!=null)println("mf","parent tab");
      //  else println("mf","no parent tab");
    //   mouse = new PVector(mouseX,mouseY);
    // }
    // fill(255,0,0);
    // ellipse(m.x,m.y,20,20);
    if(!pos(mouse)&&mousePressed&&!mdown&&BMS.sliderObject==this){
      BMS.sliderObject = null;
      //mdown = true;
      //println(parentTab.x,parentTab.y,mouseX,mouse.x,mouseY,mouse.y);
    }
    if(pos(mouse)&&mousePressed&&!tdown&&BMS.sliderObject==null){
      BMS.sliderObject = this;
      mdown = true;
      //println(parentTab.x,parentTab.y,mouseX,mouse.x,mouseY,mouse.y);
    }
    
    if(mdown){
      if(bar){
        if(vertical){
          if(m.y>y&&m.y<y + h-1)valuex = m.y-y;
          if(m.y>y+h-1)valuex = h-1;
        }else{
          if(m.x>x&&m.x<x + w-1)valuex = m.x-x;
          if(m.x>x+w-1)valuex = w-1;
        }}
      else if(radio||square){
        if(vertical){
          if(m.y>y-1&&m.y<y + h-1&&m.x>x && m.x < x + w)valuex = m.y-y-1;
          if(m.y>y+h-btnw)valuex = h-btnw;
          
        }else{
          if(m.x>x-1&&m.x<x + w-btnw && m.y>y && m.y < y + h)valuex = m.x-x;
          if(m.x>x+w-btnw)valuex = w-btnw;
        }}}
    if(mdown&&!mousePressed){
      if(BMS.sliderObject==this)BMS.sliderObject = null;
      mdown = false;
    }
  };
  
  boolean pos(){
    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
  }
  
  boolean pos(PVector m){
    return m.x>x&&m.x<x+w&&m.y>y&&m.y<y+h;
    // else 
    //return mouseX-parentTab.x>x&&mouseX-parentTab.x<x+w&&mouseY-parentTab.y>y&&mouseY-parentTab.y<y+h;
    //return false;
  }
  
  boolean btnpos(){
    
    if(!horizontal){
    return mouseX>x + valuex &&mouseX<x+valuex+btnw&&mouseY>y&&mouseY<y+h;
    
    }
    else{
      return mouseX>x&&mouseX<x+w&&mouseY>y+ valuey&&mouseY<y + valuey +btnh;
    }
  };
  
  boolean btnpos(PVector m){
    
    if(!horizontal){
    return m.x>x + valuex &&m.x<x+valuex+btnw&&m.y>y&&m.y<y+h;
    
    }
    else{
      return m!=null&&m.x>x&&m.x<x+w&&m.y>y+ valuey&&m.y<y + valuey;
    }
  };
  
  boolean tooltipPos(){
    return mouseX>x+w+textWidth("0.0000")&&mouseX<x+w+textWidth("0.0000")+20&&mouseY>y&&mouseY<y+h;
  };
  
  boolean tooltipMenuPos(){
    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
  };
  
  boolean tooltipPos(PVector m){
    return m!=null&&m.x>x+w&&m.x<x+w+textWidth("0.0000")+20&&m.y>y&&m.y<y+h;
  };
  
  boolean tooltipMenuPos(PVector m){
    return m.x>tooltip.x&&m.x<tooltip.x+tooltip.w&&m.y>tooltip.y&&m.y<tooltip.y+tooltip.h;
  };
  
  void click(){
    
  };
  
  void set(float start, float end,Object a,String b) {
    startvalue = start;
    endvalue = end;
    if(Link==null)Link = a;
    if(control=="")control = b;
    float v = 0;
    if(!tdown||update){
    if(mdown||update){
      v = map( valuex, 0+1, w-1,start,end);
      value = v;
    }
            Field field = null;
    try{
         field = a.getClass().getField(b); 
         if(mdown||update){
           field.set(a, v); 
           update = false;
         }
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }} 
  };
  
  void set(float start, float end,Object a,String b,String c) {
    startvalue = start;
    endvalue = end;
    if(Link==null)Link = a;
    if(control=="")control = b;
    float v = 0;
    if(!tdown||update){
    if(mdown||update){
      v = map( valuex, 0+1, w-1,start,end);
      value = v;
    }
            Field field1 = null;
    try{
         field1 = a.getClass().getField(c); 
         if(mdown||update)field1.set(a, true); 
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }
            Field field = null;
    try{
         field = a.getClass().getField(b); 
         if(mdown||update){
           field.set(a, v); 
           update = false;
         }
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }} 
  };
  
  void set(float start, float end) {
    
    float v = 0;
    if(!vertical){
    if((mdown||update)){
      v = map( valuex, 1, w-1,start,end);
      value = v;
      update = false;
    }}else{
      if(mdown||update){
      v = map( valuex, 1, h-1,start,end);
      value = v;
      update = false;
    }}
    //if(mdown&&!mousePressed){
    //  if(BMS.sliderObject==this)BMS.sliderObject = null;
    //  mdown = false;
    //}
  };
  
  void setint(int start, int end,Object a,String b) {
    if(Link==null)Link = a;
    if(control=="")control = b;
    int v = 0;
    if(mdown||update){
      //valuex = 
      v = floor(map( valuex, 1, w-1,start,end));
      value = v;
    }
            Field field = null;
    try{
         field = a.getClass().getField(b); 
         if(mdown||update){
           field.set(a, int(v)); 
           update = false;
         }
         }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }      //noLoop();
  };
  
  void setint(int start, int end) {
    int v = 0;
    if(mdown||update){
      v = floor(map( valuex, 1, w-1,start,end));
      value = v;
      update = false;
    }
  };
  
  
};
