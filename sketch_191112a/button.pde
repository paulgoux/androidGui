class Button{
  
  public float x,y,bx = x,by = y,w,h,size,textsize = 12,xoff,yoff,bsize,tsize = 12,tyoff,txoff,tmax = 2;
  int id,toggle,toggle2,type;
  float scalew,scaleh;
  
  public String label,blabel;
  PImage img;
  boolean drag,resize, radio,update,border = true,vertical,horizontal,gif,Img,value,textright,textbtm,textleft,textup,texttoggle,animate = true,toggleb,mdown,sdown,visible = true
          ,up,right,down,togglebar,togglebox,mdown2,textcheck,parentCanvas,subLeft,click,mclick,m2down,toggle_;
  color fcol = color(255,80),bcol = color(0,100),hcol = color(255,50),col = fcol,tcol = color(255),col1 = fcol;
  Menu parent;
  Menu submenu;
  Window subwindow;
  listBox sublist;
  ArrayList<Button> buttons = new ArrayList<Button>();
  HashMap<String,Boolean> values = new HashMap<String,Boolean>();
  String Text = "" ;
  TextBox textbox;
  PVector mouse;
  tab parentTab;
  Dropdown dMenu;
  tooltip info;
  
  Button(float xx, float yy, float ww, float hh, String Label){
    
    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = hh;
    label = Label;
    blabel = label;
    size = 1;
    textsize = 12;
    bsize = tsize;
    
  }
  
  Button(float xx, float yy, float ww, float hh){
    
    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = hh;
    size = 1;
    textsize = 12;
    bsize = tsize;
  }
  
  Button(float xx, float yy, float ww, float hh,int Cols){
    
    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = hh;
    size = 1;
    tsize = 12;
    bsize = tsize;
    value = true;
    textbox = new TextBox(x,y,ww+1,hh,Cols);
  }
  
  Button(float xx, float yy, float ww, float hh,int Cols, String Label){
    
    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = hh;
    size = 1;
    tsize = 12;
    bsize = tsize;
    label = Label;
    blabel = label;
    value = true;
    textbox = new TextBox(x,y,ww+1,hh,Cols,Label);
  }
  
  public Button(){
    
  };
  
  void save(){
    
  };
  
  void load(){
    
  };
  
  void draw2(){
    fill(0);
    rect(x,y,w,h);
  };
  
  void btn(){
    if(!radio&&!togglebar){
      stroke(255);
      strokeWeight(size);
      if(!border)noStroke();
      if(parent!=null&&type!=0){
        x = parent.x;
        //y = parent.y;
      }
      
      fill(50);
      rect(x,y,w,h);
      fill(col);
      rect(x ,y,w,h);
      
      textSize(textsize);
      
      if(label!=null){
        
      if(scaleh>0){
        pushMatrix();
        translate(0,y*scaleh+h/2);
        scale(1,scaleh);
      }
      if(scalew>0){
        pushMatrix();
        translate(x*scalew,0);
        scale(scalew,1);
      }
      
        fill(tcol);
        textSize(bsize);
        // if(!textbtm&&!textright&&!textup)text(label,x+5+txoff,y+13+tyoff+5);
        if(textbtm)text(label,x+xoff,y+h+yoff+tsize);
        textSize(12);
        if(scaleh>0){
          scale(1,1/scaleh);
          popMatrix();
        }
        if(scalew>0){
          scale(-scalew,1/scalew);
          popMatrix();
        }
        
      }
      if(value){
        
        if(textup)textbox.y     = y - h;
        if(textbtm)textbox.y    = y + h;
        if(textleft) textbox.x  = x - w;
        if(textright) textbox.x = x + w;
        Text = textbox.textBox;
        
        if(pos()||textbox.pos()||textbox.toggle==1)texttoggle=true;
        else texttoggle = false;
        if(texttoggle)textbox.draw();
        if(textbox.pos()&&mousePressed&&parent!=null){ parent.draw();}
        else parent.toggle=0;
      }
      if(img!=null){
        image(img,x,y+1,w,h);
      }}
  };
  
  void toggleBar(){
    
  };
  
  //void radio(){
    
  //};
  
  void draw(){
    logic();
    textSize(12);
    
    btn();
    if(radio){
      fill(0);
      stroke(col);
      if(!border)noStroke();
      
      if(w>h){
      fill(fcol);
      rect(x +textWidth(label)+20,y,w,h);
      if(label!=null){
        textSize(tsize);
        if(up)text(label,x,y-3);
        if(right)text(label,x+w+2,y);
        if(down)text(label,x,y+tsize*2+2);
        else text(label,x +5 + txoff,y + tsize + tyoff);
        textSize(12);
      }
      fill(bcol);if(toggle==1)fill(255);
      ellipse(x+w/2 +textWidth(label)+20,y+h/2,w-8,h-8);
    }
    else if(w==h){
      fill(fcol);
      rect(x + textWidth(label)+5,y,w,h);
      if(label!=null){
        textSize(tsize);
        if(up)text(label,x,y-3);
        if(right)text(label,x+w+2,y);
        if(down)text(label,x,y+tsize*2+2);
        else text(label,x + 5 +txoff,y+w/2+tsize/2+tyoff);
        textSize(12);
      }
      fill(bcol);if(toggle==1)fill(255);
      ellipse(x+w/2 + textWidth(label)+5,y+h/2,w-8,h-8);
    }}
    
    else if(togglebar){
      fill(0);
      stroke(col);
      if(!border)noStroke();
      
      if(w>h){
      fill(fcol);
      rect(x + textWidth(label)+5,y,w,h);
      if(label!=null){
        textSize(tsize);
        if(up)text(label,x,y-3);
        if(right)text(label,x+w+2,y);
        if(down)text(label,x,y+tsize*2+2);
        else text(label,x + 5 + txoff,y+tsize + tyoff + 4);
        textSize(12);
      }
      fill(bcol);
      if(toggle==0){rect(x +textWidth(label)+5+ w/2,y,w/2,h);text("OFF",x+textWidth(label)+w+10+txoff,y+tsize+tyoff+4);}
      else{ rect(x+textWidth(label)+5,y,w/2,h);text("ON",x+textWidth(label)+w+10+txoff,y+tsize+tyoff+4);}
    }
    else{
      fill(fcol);
      rect(x+textWidth(label),y,w,h);
      if(label!=null){
        textSize(tsize);
        if(up)text(label,x,y-3);
        if(right)text(label,x+w+2,y);
        if(down)text(label,x,y+tsize*2+2);
        else text(label,x + 5 +txoff,y+w/2+tsize/2+tyoff);
        textSize(12);
      }
      fill(fcol);
      if(toggle==0){rect(x+textWidth(label)+h/2,y,w,h/2);text("OFF",x+textWidth(label)+txoff,y+h+2+tyoff+4);}
      else{ rect(x + textWidth(label),y,w,h/2);text("ON",x+textWidth(label)+txoff,y+h+2+tyoff+4);}
    }}

    else if(togglebox){
      fill(0);
      stroke(col);
      if(!border)noStroke();
      
      if(w>h){
      fill(fcol,0);
      if(toggle==1)fill(bcol);
      rect(x,y,w,h);
      if(label!=null){
        fill(tcol);
        textSize(tsize);
        if(up)text(label,x,y-3);
        if(right)text(label,x+w+2,y+tyoff);
        if(down)text(label,x,y+tsize*2+2+tyoff);
        else text(label,x +5 + txoff,y+tsize + tyoff + 4);
        textSize(12);
      }}
      else{
        fill(fcol);
        if(toggle==1)fill(bcol);
        if(!border)noStroke();
        rect(x,y,w,h);
        if(label!=null){
          textSize(tsize);
          if(up)text(label,x,y-3);
          if(right)text(label,x+w+2,y);
          if(down)text(label,x,y+tsize*2+2);
          else text(label,x + 5 +txoff,y+w/2+tsize/2+tyoff);
          textSize(12);
      }}}
    
    if(subpos())toggle2 = 1;
    else toggle2 = 0;
    
    strokeWeight(1);
    if(info!=null)info.draw();
  };
  
  
  
  void logic(){
    if(animate){
      if(pos()||toggle==1){
        if(bsize<tsize+tmax) bsize += 0.5;
      }else if(bsize>tsize)bsize -= 0.5;
      }
      
      if(radio||togglebar){
        if(pos2()||toggle==1)bcol = hcol;
        else bcol = color(0,100);
      }
      
  };
  
  void logic(PVector m){
    if(animate){
      if(pos(m)){
        if(bsize<tsize+tmax) bsize += 0.5;
        }else if(bsize>tsize)bsize -= 0.5;
      
      }
      
      if(radio||togglebar){
        // if(pos2(m)||toggle==1)bcol = hcol;
        // else bcol = color(0,100);
      }
      
  };
  
  void draw(PGraphics canvas){
    logic(mouse);
    canvas.textSize(12);
    if(subpos(mouse)){
      //toggle = 1;
    }
    float X = 0;
    float Y = 0;
    if(parent!=null){
      X = parent.x;
      Y = parent.y;
    }
    
    if(!radio&&!togglebar){
      canvas.stroke(255);
      canvas.strokeWeight(size);
      if(!border)canvas.noStroke();
      if(parent!=null&&type!=0){
        x = parent.x;
        //y = parent.y;
      }
      
      canvas.fill(50);
      canvas.rect(x,y,w,h);
      canvas.fill(col1);
      canvas.rect(x ,y,w,h);
      
      canvas.textSize(textsize);
      
      if(label!=null){
        
      if(scaleh>0){
        canvas.pushMatrix();
        canvas.translate(0,y*scaleh+h/2);
        canvas.scale(1,scaleh);
      }
      if(scalew>0){
        canvas.pushMatrix();
        canvas.translate(x*scalew,0);
        canvas.scale(scalew,1);
      }
      
        canvas.fill(tcol);
        canvas.textSize(bsize);
        if(!textbtm&&!textright&&!textup)canvas.text(label,x+5+txoff,y+13+tyoff+5);
        if(textbtm)text(label,x+xoff,y+h+yoff+tsize);
        canvas.textSize(12);
        if(scaleh>0){
          canvas.scale(1,1/scaleh);
          canvas.popMatrix();
        }
        if(scalew>0){
          canvas.scale(-scalew,1/scalew);
          canvas.popMatrix();
        }
        
      }
      if(value){
        
        if(textup)textbox.y     = y - h;
        if(textbtm)textbox.y    = y + h;
        if(textleft) textbox.x  = x - w;
        if(textright) textbox.x = x + w;
        Text = textbox.textBox;
        
        if(pos(mouse)||textbox.pos(mouse)||textbox.toggle==1)texttoggle=true;
        else texttoggle = false;
        if(texttoggle)textbox.draw();
        if(textbox.pos()&&mousePressed&&parent!=null){ parent.draw();}
        else parent.toggle=0;
      }
      if(img!=null)canvas.image(img,x,y+1,w,h);
      }
    
    if(radio){
      canvas.fill(0);
      canvas.stroke(col);
      if(!border)canvas.noStroke();
      
      if(w>h){
      canvas.fill(fcol);
      canvas.rect(x ,y,w,h);
      if(label!=null){
        canvas.textSize(tsize);
        if(up)canvas.text(label,x,y-3);
        if(right)canvas.text(label,x+w+2,y);
        if(down)canvas.text(label,x,y+tsize*2+2);
        else canvas.text(label,x - canvas.textWidth(label) - 4 + txoff,y+tsize + tyoff);
        canvas.textSize(12);
      }
      canvas.fill(bcol);if(toggle==1)canvas.fill(255);
      canvas.ellipse(x+w/2 ,y+w/2,w-8,h-8);
    }
    else{
      canvas.fill(fcol);
      canvas.rect(x,y,h,h);
      if(label!=null){
        canvas.textSize(tsize);
        if(up)canvas.text(label,x,y-3);
        if(right)canvas.text(label,x+w+2,y);
        if(down)canvas.text(label,x,y+tsize*2+2);
        else text(label,x - textWidth(label) - 4 +txoff,y+tsize+tyoff);
        canvas.textSize(12);
      }
      canvas.fill(fcol);if(toggle==1)canvas.fill(255);
      canvas.ellipse(x+h/2,y+h/2,w-8,h-8);
    }}
    
    if(togglebar){
      canvas.fill(0);
      canvas.stroke(col);
      if(!border)canvas.noStroke();
      
      if(w>h){
      canvas.fill(fcol);
      canvas.rect(x ,y,w,h);
      if(label!=null){
        canvas.textSize(tsize);
        // if(up)canvas.text(label,x,y-3);
        // if(right)canvas.text(label,x+w+2,y);
        // if(down)canvas.text(label,x,y+tsize*2+2);
        // else text(label,x - textWidth(label) - 4 + txoff,y+tsize + tyoff + 4);
        canvas.textSize(12);
      }
      canvas.fill(bcol);
      if(toggle==0){canvas.rect(x + w/2,y,w/2,h);canvas.text("OFF",x+w+2+txoff,y+tsize+tyoff+4);}
      else{ canvas.rect(x,y,w/2,h);canvas.text("ON",x+w+2+txoff,y+tsize+tyoff+4);}
    }
    else{
      canvas.fill(fcol);
      canvas.rect(x,y,w,h);
      if(label!=null){
        canvas.textSize(tsize);
        if(up)canvas.text(label,x,y-3);
        if(right)canvas.text(label,x+w+2,y);
        if(down)canvas.text(label,x,y+tsize*2+2);
        else text(label,x - textWidth(label) - 4 +txoff,y+w/2+tsize/2+tyoff);
        canvas.textSize(12);
      }
      canvas.fill(fcol);
      if(toggle==0){canvas.rect(x+h/2,y,w,h/2);canvas.text("OFF",x+txoff,y+h+2+tyoff+4);}
      else{ canvas.rect(x,y,w,h/2);canvas.text("ON",x+txoff,y+h+2+tyoff+4);}
    }}
    else if(togglebox){
      canvas.fill(0);
      canvas.stroke(col);
      if(!border)canvas.noStroke();
      
      if(w>h){
      canvas.fill(fcol,0);
      if(toggle==1)canvas.fill(bcol);
      canvas.rect(x ,y,w,h);
      if(label!=null){
        canvas.textSize(tsize);
        // if(up)canvas.text(label,x,y-3);
        // if(right)canvas.text(label,x+w+2,y+tyoff);
        // if(down)canvas.text(label,x,y+tsize*2+2+tyoff);
        // else text(label,x - textWidth(label) - 4 + txoff,y+tsize + tyoff + 4);
        canvas.textSize(12);
      }}
    else{
      canvas.fill(fcol);
      if(toggle==1)canvas.fill(bcol);
      if(!border)canvas.noStroke();
      canvas.rect(x,y,w,h);
      if(label!=null){
        canvas.textSize(tsize);
        // if(up)canvas.text(label,x,y-3);
        // if(right)canvas.text(label,x+w+2,y);
        // if(down)canvas.text(label,x,y+tsize*2+2);
        // else canvas.text(label,x + 4 +txoff,y+w/2+tsize/2+tyoff);
        canvas.textSize(12);
      }}}
    
    if(subpos(mouse))toggle2 = 1;
    else toggle2 = 0;
    canvas.strokeWeight(1);
    if(info!=null)info.draw();
  };
  
  void radio(){
    
    radio = true;
  };
  
  
  
  void labelcheck(float a){
    
    if(textWidth(label)>a){
    for(int i=10;i<label.length();i++){
      float lw = textWidth(label.substring(0,i)+ " ...");
      if(lw>a){
        label = label.substring(0,i-1) + "...";
        textcheck = true;
        break;
      }
    }}
    else textcheck = true;
    
  };
  
  boolean pos(){
    
    return x  < mouseX && mouseX < x + w && y < mouseY && mouseY < y + h+2;
  };
  
  boolean pos(PVector m){
    boolean k = false;
    if(m==null&&label!=null)println(label);
    else if(x  < m.x && m.x < x + w && y < m.y && m.y < y + h+2)k = true;
    return x  < m.x && m.x < x + w && y < m.y && m.y < y + h+2;
  };
  boolean pos(PGraphics m){
    
    return x  < mouse.x && mouse.x < x + w && y < mouse.y && mouse.y < y + h+2;
  };
  
  boolean pos2(){
    
    return x < mouseX && mouseX < x + w + textWidth(label)+5 && y < mouseY && mouseY < y + h+2;
  };
  
  boolean pos2(PVector m){
    
    return x < m.x && m.x < x + w + textWidth(label)+5 && y < m.y && m.y < y + h+2;
  };
  
  boolean pos3(){
    
    return x + textWidth(label)+5 < mouseX && mouseX < x + w + textWidth(label)+5 && y < mouseY && mouseY < y + h+2;
  };
  
  boolean pos3(PVector m){
    
    return x + textWidth(label)+5 < m.x && m.x < x + w + textWidth(label)+5 && y < m.y && m.y < y + h+2;
  };
  
  void getValue(){
    //if(key='ENTER')
  };
  
  void setName(String a){
    label = a;
  };
  
  String getName(){
    String a = "";
    if (label!=null) a = label;
    
    return a;
  };
  
  public void self_toggle(){
    if(parent==null){
      if(pos()){
      toggle++;
    }
    if(toggle==2){
     toggle=0; 
    }}else{
    if(pos()&&parent.toggle==1){
      toggle++;
    }
    if(toggle==2){
     toggle=0; 
    }}
  };

  boolean hold(){
    if(mdown)return true;
    else return false;
  };
  
  void self_click(){
    if(!pos()&&parent!=null&&parent.toggle==1&&mousePressed){mdown = true;}
    //else if(!pos()&&parent==null&&toggle==1&&mousePressed){mdown = false;}
    if(pos()&&parent!=null&&parent.toggle==1&&!mdown){
      mdown = true;
    }
    else if(pos()&&parent==null&&!mdown){
      mdown = true;
    }
    if(mdown)toggle = 1;
    else toggle = 0;
    if(mdown && !mousePressed){mdown = false;}
  };
  
  void self_click2(){
     if(pos()&&parent==null&&mousePressed&&toggle==0&&!mdown){
      toggle++;
      col = hcol;
      mdown = true;
    }
    
    if(pos()&&parent==null&&mousePressed&&toggle>0&&!mdown){
      toggle=0;
      col = fcol;
      mdown = true;
    }
    
    if(!mousePressed)mdown = false;
  };
  
  void self_click2(PVector m){
     if(pos(m)&&parent==null&&mousePressed&&toggle==0&&!mdown){
      toggle++;
      col = hcol;
      mdown = true;
    }
    
    if(pos(m)&&parent==null&&mousePressed&&toggle>0&&!mdown){
      toggle=0;
      col = fcol;
      mdown = true;
    }
    
    if(!mousePressed)mdown = false;
  };
  
  void self_click3(){
     if(pos()&&parent==null&&mousePressed&&toggle==0&&!mdown){
      toggle++;
      col = hcol;
      mdown = true;
    }
    
    if(!mdown){
      toggle=0;
      col = fcol;
      mdown = true;
    }
    
    if(!mousePressed)mdown = false;
  };
  
  void self_click4(){
    boolean k = false;
     if(pos()&&parent==null&&mousePressed&&toggle==0&&!mdown){
      toggle++;
      col = hcol;
      mdown = true;
    }
    
    if(mdown)k = true;
    
    if(k){
      toggle=0;
      col = fcol;
      mdown = false;
    }
    
    if(!mousePressed)mdown = false;
  };

  boolean click(){
      boolean k = false;
      // if(pos())k = true;
      // else k = false;
      if (pos()&&mousePressed&&!click){
        click = true;
        k = false;
      }else if(click&&!mousePressed){
        k = true;
        click = false;
      }
      
      return k;
  };

  boolean click(PVector m){
      boolean k = false;
      // if(pos())k = true;
      // else k = false;
      if (pos(m)&&mousePressed&&!click){
        click = true;
        k = false;
      }else if(click&&!mousePressed){
        k = true;
        click = false;
      }
      
      return k;
  };
  
  boolean mouseDown(){
    boolean k = false;
    if(pos()&&mousePressed)k = true;
    if(!mousePressed)k = false;
    return k;
  };
  
  void click(Object a,String b){
    
    if(parent!=null){
    Field field = null;
    
    try{
         field = a.getClass().getField(b); 
        
         if(click()&&parent.toggle==1){
           field.set(a, true); 
           toggle = 1;
         }else {
           field.set(a, false);
           toggle = 0;
         }
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}
    else{
    
    Field field = null;
    
    try{
         field = a.getClass().getField(b); 
        
         if(click()){
           field.set(a, true); 
         }else {
           field.set(a, false);
         }
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }
    }
  };

  void toggleField(){

  };
  
  void latch(Object a,String b){
    PVector n = new PVector(mouseX,mouseY);
    if(mouse!=null)n = mouse;
    boolean mousedown = false;
    if(parent!=null){
    if(pos(n)&&parent.toggle==1&&mousePressed&&toggle==0)toggle++;
    if(!mousePressed&&toggle>0){mdown = true;toggle = 0;}
    
    Field field = null;
    
    try{
         field = a.getClass().getField(b); 
        
         if(mdown)field.set(a, true); 
         //else field.set(a, false); 
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }if(!mousePressed)mdown = false;}
    else{
      if(pos(n)&&mousePressed&&toggle==0)toggle++;
      if(!mousePressed&&toggle>0){mdown = true;toggle = 0;}
      
    
    Field field = null;
    
    try{
         field = a.getClass().getField(b); 
        
         if(mdown){
           field.set(a, true); 
         }
         //else field.set(a, false); 
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }
  if(!mousePressed)mdown = false;
}
  };
  
  void reverseclick(Object a,String b){
    if(parent!=null){
    //if(!pos()&&parent.toggle==1&&mousePressed)mdown = true;
    if(pos()&&parent.toggle==1&&mousePressed&&!mdown)mdown = true;
    
    if(mdown)toggle = 1;
    else toggle = 0;
    if(mdown && !mousePressed){mdown = false;}
    
    Field field = null;
    
    try{
         field = a.getClass().getField(b); 
        
         if(mdown)field.set(a, true); 
         else field.set(a, false);
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}
    else{
      if(pos()&&mousePressed&&!mdown)mdown = true;
    
    if(mdown){
      toggle = 1;
    }
    else toggle = 0;
    if(mdown && !mousePressed){mdown = false;}
    
    Field field = null;
    
    try{
         field = a.getClass().getField(b); 
        
         if(!mdown)field.set(a, true); 
         else field.set(a, false);
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }
    }
  };
  
   public void self_Toggle(){
   if(parent!=null){
    if(pos() && parent.toggle==1){
      toggle ++;
    
    if(toggle==2){
      toggle = 0;
    }}}else {
      if(pos()){
      toggle ++;
    
    if(toggle==2){
      toggle = 0;
    }}
    }
    
  };

  void toggle() {
    
    if (pos()&&mousePressed&&!mdown)mdown = true;
    if(mdown&&!toggle_&&!m2down){
      toggle_ = true;
      m2down = true;
    }
    if(mdown&&toggle_&&!m2down){
      toggle_ = false;
      m2down = true;
    }
    
    if(!mousePressed){
      mdown = false;
      m2down = false;
    }
    
  };
  
  public void toggle( String b){
    if(parent!=null){
    if(pos() && parent.toggle==1){
      toggle ++;
      
      if(toggle==2){
        toggle=0;
    }}
    if(pos() && parent.toggle==1){
        
    
         //if(toggle==1)field.set(a, true); 
         //else if(toggle==0)field.set(a, false);
        }}
    
    else{
      
    }
  };
  
  public void toggle(Object a, String b){
    if(parent!=null){
    if(pos() && parent.toggle==1){
      toggle ++;
      
      if(toggle==2)toggle=0;
    }
    if(pos() && parent.toggle==1){
        
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
        
         if(toggle==1)field.set(a, true); 
         else if(toggle==0)field.set(a, false);
         
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}}else{
      
      if(pos()){
      toggle ++;
      if(toggle==2)toggle=0;
    }
    if(pos()&&toggle==1){
        
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
        
         if(toggle==1)field.set(a, true); 
         else if(toggle==0)field.set(a, false);
         
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}}
  };

  public void toggle(Object a, String b,PGraphics c){
    
    if(mousePressed){
    if(parent!=null){
    if(pos(mouse) && parent.toggle==1){
      toggle ++;
      if(toggle==2)toggle=0;
    }
    if(pos(mouse) && parent.toggle==1){
        
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
        
         if(toggle==1)field.set(a, true); 
         else if(toggle==0)field.set(a, false);
         
    }catch (NullPointerException e) {
      println("np np");
    }catch (NoSuchFieldException e) {
      println("np nsf");
    }catch (IllegalAccessException e) {
      println("np ia");
    }}}else{
      
      if(pos(mouse)&&mousePressed&&!mdown){
      toggle ++;
      if(toggle==2)toggle=0;
      mdown = true;
    }
    if(pos(mouse)){
      
    Field field = null;
    
    try{
      
        field = a.getClass().getField(b); 
        
        if(toggle==1)field.set(a, true); 
        else if(toggle==0)field.set(a, false);
        if(field.getBoolean(a)==true)c.fill(255,0,0);
        // else c.fill(255,255,0);
        // c.ellipse(mouse.x,mouse.y,20,20);
        //  if(mousePressed)println(a,b,field.get(a));
    }catch (NullPointerException e) {
      println("p np");
    }catch (NoSuchFieldException e) {
      println("p nsf");
    }catch (IllegalAccessException e) {
      println("p ia");
    }}}}
    if(!mousePressed)mdown = false;
  };
  
  public void toggle(PApplet a, String b){
    if(parent!=null){
    if(pos() && parent.toggle==1){
      toggle ++;
      
      if(toggle==2){
        toggle=0;
    }}
    if(pos() && parent.toggle==1){
        
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
        
         if(toggle==1)field.set(a, true); 
         else if(toggle==0)field.set(a, false);
         
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}}
    
    else{
      
    }
  };
  
  
  public void toggle2(Object a, String b){
    
    
    if(parent!=null){
    if(pos()&&parent.toggle==1&&mousePressed&&toggle==0&&!mdown){
      toggle=1;
      mdown = true;
    }
    
    if(pos()&&parent.toggle==1&&mousePressed&&toggle>0&&!mdown){
      toggle=0;
      mdown = true;
    }
    if(!mousePressed)mdown = false;
    
    if(pos() && parent.toggle==1){
        
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
        
         if(toggle==1)field.set(a, true); 
         else field.set(a, false);
         
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}}
    else {
      
    if(pos()&&mousePressed&&toggle==0&&!mdown){
      toggle++;
      mdown = true;
    }
    
    else if(pos()&&mousePressed&&toggle>0&&!mdown){
      toggle=0;
      mdown = true;
    }
    if(!mousePressed)mdown = false;
    
    if(mdown){
        
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
        
         if(toggle==1){
           field.set(a, true); 
         }else {
           field.set(a, false);
         }
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}if(!mousePressed)toggle = 0;}
  };
  
  public void toggle4(Object a, String b){
    
    
    if(parent!=null){
    if(pos()&&parent.toggle==1&&mousePressed&&toggle==0&&!mdown){
      toggle=1;
      mdown = true;
    }
    
    if(pos()&&parent.toggle==1&&mousePressed&&toggle>0&&!mdown){
      toggle=0;
      mdown = true;
    }
    if(!mousePressed)mdown = false;
    
    if(pos() && parent.toggle==1){
        
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
        
         if(toggle==1){
           field.set(a, true); 
         }else {
           field.set(a, false);
         }
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}}
    else {
      
    if(pos()&&mousePressed&&toggle==0&&!mdown){
      toggle++;
      mdown = true;
    }
    
    else if(pos()&&mousePressed&&toggle>0&&!mdown){
      toggle=0;
      mdown = true;
    }
    if(!mousePressed)mdown = false;
    
    if(mdown){
        
    Field field = null;
    
    //try{
      
    //     field = a.getClass().getField(b); 
        
    //     if(toggle==1&&field){
    //     }else if(toggle==1&&!field){
    //       field.set(a, true);
    //     }else if(toggle==0&&!field){
    //     }else if(toggle==0&&field){
    //       field.set(a, false);
    //     }
    //}catch (NullPointerException e) {
    //}catch (NoSuchFieldException e) {
    //}catch (IllegalAccessException e) {
    //}
  }
  }
  };
  
  void toggled(Object a,String b){
    //if(dclick)
    if(pos()&&mousePressed&&toggle==0&&!mdown){
      toggle++;
      mdown = true;
    }
    
    else if(pos()&&mousePressed&&toggle>0&&!mdown){
      toggle=0;
      mdown = true;
    }
    if(!mousePressed)mdown = false;
    
    if(mdown){
        
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
        
         if(toggle==1){
           field.set(a, true); 
         }else {
           field.set(a, false);
         }
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}
  
  };
  
   void sptoggle(Object a, String b,String [] c){
     
     
    if(pos() && parent.toggle==1){
      toggle ++;
      if(toggle==2){
        toggle=0;
    }}
    if(pos() && parent.toggle==1){
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
         
         if(toggle==1){
           
           field.set(a, true); 
         }else {
           field.set(a, false);
           //println("button ",next,a," ");
         }}catch (NoSuchFieldException e) {
           println("nsf");
          }catch (NullPointerException e) {
            println("npe");
          }catch (IllegalAccessException e) {
            println("iae");
          }
          
        for(int i=0;i<c.length;i++){
           String next = c[i];
           if(next!=b){
             //println("button ",next,b," ");
             try{
             field = a.getClass().getField(next); 
             field.set(a, false); 
             parent.items.get(i).toggle=0;
             //print(field.get(a)," ");
             }catch (NullPointerException e) {
               println("nsf");
             }catch (NoSuchFieldException e) {
               println("npe");
             }catch (IllegalAccessException e) {
               println("iae");
             }
           }}}
  };

  void sptoggle2(Object a, String b,String [] c){
     
     
    if(pos() && parent.toggle==1){
      toggle ++;
      if(toggle==2){
        toggle=0;
    }}
    if(pos() && parent.toggle==1){
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
         
         if(toggle==1){
           
           field.set(a, true); 
         }else {
           field.set(a, false);
           //println("button ",next,a," ");
         }}catch (NoSuchFieldException e) {
           println("nsf");
          }catch (NullPointerException e) {
            println("npe");
          }catch (IllegalAccessException e) {
            println("iae");
          }
          
        for(int i=0;i<c.length;i++){
           String next = c[i];
           if(next!=b){
             println("button ",next,b," ");
             try{
             field = a.getClass().getField(next); 
             field.set(a, false); 
             print(field.get(a)," ");
             }catch (NullPointerException e) {
               println("nsf");
             }catch (NoSuchFieldException e) {
               println("npe");
             }catch (IllegalAccessException e) {
               println("iae");
             }
           }}}
  };
  
  void toggle3(Object a, String b){
    
    if(mousePressed&&pos()){
      toggle++;
    }
    
    if(toggle>2)toggle=0;
    
    Field field = null;
    
    try{
      
         field = a.getClass().getField(b); 
        
         if(toggle==1){
           field.set(a, true); 
         }else {
           field.set(a, false);
         }
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }
  };
  
  void highlight2(){
    col = color(255,50);
  }
  
  void highlight3(){
    // if(pos())col = color(255,255,255,80);
    // else col = color(255,255,255,50);
    
  };
  
  void highlight(){
    if(toggle==1)col = hcol;
    else col = fcol;
    if(buttons.size()==0){
    if(pos())col = hcol;
    else col = fcol;
    }else{
      if(pos())col = hcol;
      else col = fcol;
    }
  };
  
  void highlight(PVector m){
    if(toggle==1||pos(m))col1 = hcol;
    else if(!pos(m))col1 = fcol;
    
    // if(buttons.size()==0){
    // if(pos(m))col = hcol;
    // else col = fcol;
    // }else{
    //   if(pos(m))col = hcol;
    //   else col = fcol;
    // }
  };
  
  boolean subpos(){
     float X = 0;
     float Y = 0;
      if(parent!=null){
        X = parent.x;
        Y = parent.y;
      }
    
      return mouseX> x + w-20+xoff&& mouseX < x + w&& mouseY > y&& mouseY < y + h;
    
  };
  
  boolean subpos(PVector m){
     float X = 0;
     float Y = 0;
      if(parent!=null){
        X = parent.x;
        Y = parent.y;
      }
    
      return m.x> x + w-20+xoff&& m.x < x + w&& m.y > y&& m.y < y + h;
    
  };
  
  boolean subposLeft(){
     float X = 0;
     float Y = 0;
      if(parent!=null){
        X = parent.x;
        Y = parent.y;
      }
    
      return mouseX> x&& mouseX < x + 20&& mouseY > y&& mouseY < y + h;
    
  };
  
  boolean subposLeft(PVector m){
    
      return m.x> x&& m.x < x + 20&& m.y > y&& m.y < y + h;
    
  };
};

class ButtonGrid{
  
};

class listBox{
  
  float x,y,w,h,vspacing,hspacing;
  ArrayList<Button> buttons = new ArrayList<Button>();
  String type;
  boolean vertical, horizontal,Menu,toggle;
  Menu menu;
  Menu mlist;
  
  listBox(float xx, float yy,float ww,int num){
    
    x = xx;
    y = yy;
    w = ww;
    h = (20) * num;
    Menu = true;
    
    menu = new Menu(x,y,w,h,"none");
    
    for(int i=0;i<num;i++){
      float ypos = y+(20) *i;
      Button a =  new Button(x ,ypos,w,20);
      //a.id = i;
      a.border = false;
      a.parent = menu;
      buttons.add(a);
      menu.items.add(a);
    }
    menus.add(menu);
  };
  
  listBox(int xx, int yy,int ww,int hh,int num){
    
    x = xx;
    y = yy;
    w = ww;
    h = (20) * num;
    Menu = true;
    
    menu = new Menu(x,y,w,h,"none");
    
    for(int i=0;i<num;i++){
      float ypos = y+(20) *i;
      Button a =  new Button(x ,ypos,w,20);
      //a.id = i;
      a.border = false;
      a.parent = menu;
      buttons.add(a);
      menu.items.add(a);
    }
    menus.add(menu);
  };
  
  listBox(float xx, float yy,float ww,int num,Menu m){
    
    x = xx;
    y = yy;
    w = ww;
    h = (20) * num;
    
    menu = new Menu(x,y,w,h);
    menu.listbox = true;
    
    for(int i=0;i<num;i++){
      float ypos = y+(20) *i;
      Button a =  new Button(x ,ypos,w,20);
      //a.id = i;
      a.border = false;
      a.parent = menu;
      buttons.add(a);
      menu.items.add(a);
    }
    //menus.add(menu);
  };
  
  listBox(int xx, int yy,int ww,int num,Menu m){
    
    x = xx;
    y = yy;
    w = ww;
    h = (20) * num;
    
    menu = m;
    menu.listbox = true;
    
    for(int i=0;i<num;i++){
      float ypos = y+(20) *i;
      Button a =  new Button(x ,ypos,w,20);
      //a.id = i;
      a.border = false;
      a.parent = menu;
      buttons.add(a);
      menu.items.add(a);
    }
    //menus.add(menu);
  };
  
  listBox(float xx, float yy,float ww,int num,Menu m,String[] list){
    
    x = xx;
    y = yy;
    w = ww;
    h = (20) * num;
    
    menu = m;
    menu.h = m.h;
    
    for(int i=0;i<num;i++){
      
      float ypos = y+(20) *i;
      Button a =  new Button(x ,ypos,w,20);
      //a.id = i;
      if(i<list.length){
        String label = list[i];
        a.label = label;
      }
      a.border = false;
      a.parent = menu;
      buttons.add(a);
      menu.items.add(a);
    }
      
      
  };
  
  listBox(float xx, float yy,float ww,Menu m,String[] list){
    
    x = xx;
    y = yy;
    w = ww;
    h = m.h;
    
    menu = m;
    //menu.listbox = true;
    menu.h = list.length*20;
    
    for(int i=0;i<list.length;i++){
      
      float ypos = y+(20) *i;
      Button a =  new Button(x ,ypos,w,20);
      //a.id = i;
      if(i<list.length){
        String label = list[i];
        a.label = label;
      }
      a.border = false;
      a.parent = menu;
      buttons.add(a);
      menu.items.add(a);
    }
  };
  
  listBox(float xx, float yy,float ww,Menu m,String[] list,int k){
    
    x = xx;
    y = yy;
    w = ww;
    h = m.h;
    
    menu = m;
    menu.h = list.length*20;
    //menu.listbox = true;
    
    for(int i=0;i<list.length;i++){
      
      float ypos = y+(20) *i;
      Button a =  new Button(x ,ypos,w,20);
      //a.id = i;
      if(i<list.length){
        String label = list[i];
        a.label = label;
      }
      a.border = false;
      a.parent = menu;
      a.togglebox = true;
      buttons.add(a);
      //menu.w = textWidth(a.label);
      menu.items.add(a);
    }
  ////if(menu.label!=null)menus.add(menu);
  if(menu.label!=null)menus.add(this.menu);
    
  };
  
  void draw(){
    if(Menu){
      if(toggle)menu.draw();
    }else{
    menu.draw();
    }
  }
  
  void display(String a){
    
    if(a=="vertical"|| a== "Vertical"){
      float k = 0;
      menu.vertical = true;
      
      k = menu.h;
      menu.h = menu.w ;
      h = w;
      menu.w = k;
      w = k;
      
      for(int i=0;i<menu.items.size();i++){
        
        Button b = menu.items.get(i);
      b.horizontal = false;
      k = b.w;
      b.w = b.h;
      b.h = k;
      }
    }
    
  };
  
  void set(int b, String a){
    
    menu.items.get(b).label = a;
  };
  
  void set(int a, String b, String c){
    
  };
  
  void toggle(int i,Object o,String b){
    Button a = new Button();
    menu.items.get(i).toggle(o,b);
  };
  
  void click(int i,Object a,String b){
    Button k = menu.items.get(i);
    k.click(a,b);
    
      try{
      
         Field field = a.getClass().getField(b); 
         
         if(k.toggle==1){
           field.set(a, true); 
         }else {
           field.set(a, false);
           }
          }catch (NullPointerException e) {
          }catch (NoSuchFieldException e) {
          }catch (IllegalAccessException e) {
          }
  };
  
  
  void set(Window a, String b){
    
  };
  
  void set(Menu a, String b){
    
  };
  
  void set(Boundary a, String b){
    
  };
  
  
  void setbg(){
    
  };
  
  
};
