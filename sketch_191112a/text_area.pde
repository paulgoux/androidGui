class TextArea{
  
  int id,toggle,cols,rows,size,t,timer = 101,blkrate = 30,t1 = blkrate,t2 = blkrate,start,end,hcount,index,lindex,vindex = -1,hindex = -1,windex,vpos = 0,hpos,sltcounter,vcount = 0
      ,delay=10, maxCount = 51;
  float x,y,w,h,textsize = 12,twidth = 0,posx,posy,tposx,tposy,strposx,strposy,tbwidth,strwidth,strheight,cursorx, cursory,crwidth,totalwidth;
  public float inputDelay = 9,delay2 = 5;
  String label,text,label_backup,cboard = "",value;
  boolean drag,resize,hover,border,background,hidden,fill = true,init,ready,label_bool,clear,copied,tbox = true,tsize = false,parentCanvas,setDelay,firstPress,getChar;
  //Menu toolBox;
  //Button child;
  //Slider
  ArrayList<Letter> textbox = new ArrayList<Letter>();
  ArrayList<Letter> tm0 = new ArrayList<Letter>();
  ArrayList<Letter> tm1 = new ArrayList<Letter>();
  String textBox = "";
  String temp = "";
  String stringImport = "";
  String [] backup;
  ArrayList<Integer> counted = new ArrayList<Integer>();
  ArrayList<Integer> lines = new ArrayList<Integer>();
  ArrayList<Integer> dragh = new ArrayList<Integer>();
  //ArrayList<Float> tsize = new ArrayList<Float>();
  Letter b = null;
  color col = color(255),col2 = color(0);
  PVector mouse;
  //Window parent;
  
  TextArea(float X,float Y,float WW,float HH,int Cols,int Rows){
    
    x = X;
    y = Y;
    w = WW;
    h = HH;
    cols = Cols;
    rows = Rows;
    totalwidth = w * rows;
    size = textbox.size();
    lines.add(0);
    textsize = 12;
    //toolBox = new Menu(x+1,y-20,200-1,20);
    fill = true;
  };
  
  TextArea(float X,float Y,float WW,float HH,int Cols,int Rows,String Label){
    
    x = X;
    y = Y;
    w = WW;
    h = HH;
    cols = Cols;
    rows = Rows;
    totalwidth = w * rows;
    textsize = 12;
    size = textbox.size();
    label = Label;
    label_backup = Label;
    lines.add(0);
    label_bool = true;
    //toolBox = new Menu(x+1,y-20,200-1,20);
  };
  
  TextArea(float X,float Y,float WW,float HH,int Cols,int Rows,String []Lines){
    
    x = X;
    y = Y;
    w = WW;
    h = HH;
    cols = Cols;
    rows = Rows;
    
    //String [] text = null;
    //if(BMScontrols.Lines!=null)text = null;
    if(Lines!=null){
      //for(int i=0;i<Lines.length;i++){
        
      //  //String[] space = match(Lines[i],"  ");
      //  //if(space!=null){
      //  //  //Lines.splice(i+1,"")
      //  //  for(int j=0;j<cols;j++){
      //  //    Lines[i]+= " ";
      //  //  }}
      //  //Lines[i] = Lines[i].replace("//+", "\n  ");
      //}
    
      for(int i=0;i<Lines.length;i++){
      textBox += Lines[i];
      for(int j=0;j<Lines[i].length();j++){
      //label_backup += Lines[i];
      //textbox.add(new Letter(str(Lines[i].charAt(j)),x,y));
      //lines.add(i);
      }}
    backup = Lines;
    textsize = 12;
    if(Lines.length> rows){
      rows = floor(Lines.length);
      h = textsize * rows;
      }
    totalwidth = w * rows;
    size = textbox.size();
    tbox = false;
    //toolBox = new Menu(x+1,y-20,200-1,20);
    testcode(textBox);
    }
  };
  
  void testcode(String a){
      
      //for(
    };
    
  void save(){
    
  };
  
  void load(){
    
  };
  
  void init(){
    
  };
  
  void getKey2(){
   
    if(toggle==1){
      if(!keyPressed){
        timer=101;
        firstPress = false;
      }
      if(keyPressed&&key != CODED){
        if((timer%delay==0&&!firstPress)||(firstPress&&timer%delay2==0)||timer==maxCount-1){
          getChar = true;
        }else getChar = true;
        if(timer<0)firstPress=true;
      }
    }
  };
  
  void draw(){
    
    twidth = 0;
    box();
    getCursor();
    mpos();
    nav();
    conditionals();
    highlight();
    //selectall();
    toolbox();
    error();
    //debug();
    if(!tsize)getKey();;
    
    //----------------------------------------------------- amend letters
    float c1 = 0;
    int cindex = -1;
    
    for(int i=0;i<textBox.length();i++){
      
      //text(textbox.get(i).l,x+ 10 *i,y);
       Letter a = null;
       String b = str(textBox.charAt(i));
       
      if(textbox.size()==textBox.length()){a = textbox.get(i);}
        else{a = new Letter(b,x,y);textbox.add(a);}
      
      if(a!=null){
        if(c1 + a.w > w)c1=0;
        if(c1==0){cindex++;
        a.id = i;
        a.vpos = cindex;
        boolean k = lines.contains(i);
        if(!k)lines.add(i);
      }
      }
      
      if(a==null&&b!=null){
        a = new Letter(b,x,y);
        if(a.id!=i)a.id = i;
        a.y = y + cindex*textsize;
        a.x = x+c1;
        a.vpos = cindex;
        textbox.add(a);
      }
      
      if(a.l!=b){ 
      textbox.get(i).l = b;
      a.w = textWidth(b);
      if(a.id!=i)a.id = i;
      a.y = y + cindex*textsize;
      a.x = x+c1;
      a.vpos = cindex;
      }
      fill(a.col2);
      text(a.l,a.x,a.y+textsize);
      c1 += textWidth(a.l);
      
      if(selectAll&&toggle==1&&dragh.size()==textBox.length()){
        
        if(dragh.get(i)!= i) dragh.set(i,i);
      }}
    
    //-------------------------------------------------
    
        for(int j=0;j<dragh.size();j++){
            Letter b = null;
            if(j<dragh.size()-1){
              if(dragh.get(j)<textbox.size()){
              b = textbox.get(dragh.get(j));
              fill(0,0,255,125);
              noStroke();
              rect(b.x,b.y,b.w,b.h);
          }}}
        if(!mousePressed){
          //dragh = new ArrayList<Integer>();
        }
        strokeWeight(1);
  };
  
  void draw(PGraphics canvas){
    
    twidth = 0;
    box(canvas);getCursor(canvas);mpos(mouse);nav();conditionals(canvas);highlight(canvas);selectall();toolbox(canvas);error(canvas);
    //debug();
    if(!tsize)getKey();;
    
    //----------------------------------------------------- amend letters
    float c1 = 0;
    int cindex = -1;
    
    for(int i=0;i<textBox.length();i++){
      //text(textbox.get(i).l,x+ 10 *i,y);
       Letter a = null;
       String b = str(textBox.charAt(i));
       
      if(textbox.size()==textBox.length()){a = textbox.get(i);}
        else{a = new Letter(b,x,y);textbox.add(a);}
      
      if(a!=null){
        if(c1 + a.w > w)c1=0;
        if(c1==0){cindex++;
        a.id = i;
        a.vpos = cindex;
        boolean k = lines.contains(i);
        if(!k)lines.add(i);
      }
      }
      
      if(a==null&&b!=null){
        a = new Letter(b,x,y);
        if(a.id!=i)a.id = i;
        a.y = y + cindex*textsize;
        a.x = x+c1;
        a.vpos = cindex;
        textbox.add(a);
      }
      
      if(a.l!=b){ 
      textbox.get(i).l = b;
      a.w = textWidth(b);
      if(a.id!=i)a.id = i;
      a.y = y + cindex*textsize;
      a.x = x+c1;
      a.vpos = cindex;
      }
      canvas.fill(a.col2);
      canvas.text(a.l,a.x,a.y+textsize);
      c1 += textWidth(a.l);
      
      if(selectAll&&toggle==1&&dragh.size()==textBox.length()){
        
        if(dragh.get(i)!= i) dragh.set(i,i);
      }}
    
    //-------------------------------------------------
    
        for(int j=0;j<dragh.size();j++){
            Letter b = null;
            if(j<dragh.size()-1){
              if(dragh.get(j)<textbox.size()){
              b = textbox.get(dragh.get(j));
              canvas.fill(0,0,255,125);
              canvas.noStroke();
              canvas.rect(b.x,b.y,b.w,b.h);
          }}}
        if(!mousePressed){
          //dragh = new ArrayList<Integer>();
        }
        canvas.strokeWeight(1);
  };
  
  void selectall(){
    
    if(toggle==1&&ctrl==1&&selectAll){
      fill(0);
      text("Select all", 100,200);
    }
  };
  
  String getValue(){
    return textBox;
  };
  
  ArrayList getObject(){
    return textbox;
  };
  
  void regex(){
    
  };
  
  void toolbox(){
    //tbox = true;
    if(tbox){
      stroke(col);
      fill(col2);
      //toolBox.draw();
      // btn quote
      // btn Bold
      // btn Italic
      // btn Underlined
      // btn Link
      // btn Quotes
      // btn Html tag
      // btn Picture
      // btn Bulletpoints
      // btn Numbered
      // btn Smiley
      // btn Calendar
      // btn Options
      
    }
    
  };
  
  void toolbox(PGraphics canvas){
    //tbox = true;
    if(tbox){
      canvas.stroke(col);
      canvas.fill(col2);
      //toolBox.draw();
      // btn quote
      // btn Bold
      // btn Italic
      // btn Underlined
      // btn Link
      // btn Quotes
      // btn Html tag
      // btn Picture
      // btn Bulletpoints
      // btn Numbered
      // btn Smiley
      // btn Calendar
      // btn Options
      
    }
    
  };
  
  void highlight(){
    float c = 0;
        int d = 0;
      
      if(textbox.size()>0){
        
        for(int i=0;i<textbox.size();i++){
          Letter a = textbox.get(i);
          noStroke();
          if(a.pos()){a.col = color(255,255,0);fill(a.col);rect(a.x,a.y,a.w,a.h);}
          else a.col  = color(0);
          if(mousePressed&&a.pos()){
            vindex = a.vpos;
            hindex = a.id;
            cursorx = a.x-x+a.w;
            cursory = a.y;
            boolean n = dragh.contains(i);
            if(!n) dragh.add(i);
            //text(a.id,a.x + x,a.y);
          }}}
  };
  
  void highlight(PGraphics canvas){
    float c = 0;
        int d = 0;
      
      if(textbox.size()>0){
        
        for(int i=0;i<textbox.size();i++){
          Letter a = textbox.get(i);
          canvas.noStroke();
          if(a.pos(mouse)){a.col = color(255,255,0);canvas.fill(a.col);canvas.rect(a.x,a.y,a.w,a.h);}
          else a.col  = color(0);
          if(mousePressed&&a.pos(mouse)){
            vindex = a.vpos;
            hindex = a.id;
            cursorx = a.x-x+a.w;
            cursory = a.y;
            boolean n = dragh.contains(i);
            if(!n) dragh.add(i);
            //text(a.id,a.x + x,a.y);
          }}}
  };
  
  void getKey(){
   
    if(toggle==1){
    String clipboard = null;
    Letter current = null;
    
    String a = getChar();
    String tm = "";
    String tm2 = "";
    tm0 = new ArrayList<Letter>();
    tm1 = new ArrayList<Letter>();
    float current_width = textWidth(textBox);
    
    if(textbox.size()>0&&hindex!=-1)current = textbox.get(hindex);
    if(textbox.size()>0&&hindex==-1)current = textbox.get(textbox.size()-1);
    
    if(clipboard_toggle==0)cboard = "";
    
    if(cboard != clipBoard&&copy_clipboard){ clipboard = clipBoard;cboard = clipBoard;}
    else{ clipboard = null;}
    float delay = delay2;
    if(!copy_clipboard&&clipboard_toggle==0){
      
        timer --;
        Letter l = null;
        if(setDelay)delay = inputDelay;
        if(a!=null) l = new Letter(a,x+strwidth,y + vcount * textsize);
        if(a!=null&&getChar&&key!=BACKSPACE&&(current_width+ l.w<totalwidth)){
          
          l.id = hindex +1;
          
          if(hindex==-1){
            if(textbox.size()==0){
              l.y = y;
              l.x = x;
              textbox.add(l);
              textBox += a;
            }
              else if(l.vpos < rows||l.x+l.w<x+w){
              l.y = y + vcount * textsize;
              cursory = l.y;
              textbox.add(l);
              textBox += a;
              
          }}else{
            
            Letter end = textbox.get(textbox.size()-1);
            Letter n = new Letter(a,cursorx,cursory);
            if((hindex!=textbox.size()-1||hindex!=-1)&&getChar){
              
            Letter b = textbox.get(hindex);
            l.id = b.id ;
            
            n.x = cursorx ;
            if(hindex-1> 0)l.y = y + textbox.get(hindex-1).vpos * textsize;
                else l.y = y; cursory = y;
                
            if(hindex<textBox.length())tm = textBox.substring ( 0, hindex + 1);
            tm += a;
            if(hindex<textBox.length())tm2  = textBox.substring ( hindex + 1, textBox.length()  );
            textBox = tm + tm2;
            hindex ++;
            if(hindex < textbox.size()-1)cursorx = textbox.get(hindex+1).x;
          }}
          
          if(timer<=0){
            timer = maxCount;
          }}
        else if(keyPressed && key==BACKSPACE&&getChar){delete();}
        //setDelay = true;
    }
    else if(copy_clipboard&&clipboard_toggle==1&&!tsize){
      
            if(hindex>-1){
            if(hindex<textBox.length())tm = textBox.substring ( 0, hindex + 1  );
            if(hindex<textBox.length())tm2  = textBox.substring ( hindex + 1, textBox.length()  );
            tm += cboard;
            tm += tm2;
            
            textBox = tm;
            
         }else{
             
              for (int i=0;i<cboard.length();i++){
                String b = str(cboard.charAt(i));
                textBox += b;
              }}
              clipboard_toggle = 0;
              copy_clipboard = false;
              }}
  };
  
  
  //((((
  
  void error(){
    
    if(clipBoard.length()>0&&textWidth(clipBoard)+textWidth(textBox)*textsize/12>w*(rows-1)&&copy_clipboard&&clipboard_toggle==1){tsize = true;}
    
    if(toggle==1||pos()){
          if(tsize){
              String message = "ClipBoard too large";
              float l = textWidth(message);
              stroke(0);
              fill(255);
              rect(W/2-l/2+200,H/2-textsize,l*2,textsize*2);
              fill(0);
              text(message,W/2+200,H/2);
          
          }
          
          if(tsize&&mousePressed)tsize = false;
    }
  };

void error(PGraphics canvas){

  if(clipBoard.length()>0&&textWidth(clipBoard)+textWidth(textBox)*textsize/12>w*(rows-1)&&copy_clipboard&&clipboard_toggle==1){tsize = true;}
    
  if(mouse!=null&&(toggle==1||pos(mouse))){
          if(tsize){
              String message = "ClipBoard too large";
              float l = textWidth(message);
              canvas.stroke(0);
              canvas.fill(255);
              canvas.rect(W/2-l/2+200,H/2-textsize,l*2,textsize*2);
              canvas.fill(0);
              canvas.text(message,W/2+200,H/2);
          
          }
          
          if(tsize&&mousePressed)tsize = false;
    }
};

  void getCursor(){
    
    getClick();
    
    if(hindex==-1){
      if(textbox.size()==0){
        cursory = y;
        cursorx = 1;
        vindex = 0;
      }else{
      if(textbox.size()>0&&hindex<textbox.size()){
      cursory = y + textbox.get(textbox.size()-1).vpos * textsize;
      cursorx = textbox.get(textbox.size()-1).x + textbox.get(textbox.size()-1).w*(textsize/12)-x;
      }
    }}
    if(hindex>-1){
      if(textbox.size()>hindex+1){
      cursorx = textbox.get(hindex).x + textbox.get(hindex).w*(textsize/12) - x;
      cursory = y + textbox.get(hindex).vpos * textsize;
    }}
    if(pos()||toggle==1){
      //cursor(POINT);
        if(t1>0){
          t1 --;
          if(strheight<y+h){
          stroke(0);
          strokeWeight(1);
          line(x+cursorx,cursory ,x+cursorx,cursory+textsize);
          }
        if(t1<=0)t2 = blkrate;
        }
        if(t2>0&&t1<=0){
          t2--;if(t2<=0)t1 = blkrate;
          }}
          //else {
          //  cursor(ARROW);
          //}
  };
  
  void getCursor(PGraphics canvas){
    
    getClick();
    
    if(hindex==-1){
      if(textbox.size()==0){
        cursory = y;
        cursorx = 1;
        vindex = 0;
      }else{
      if(textbox.size()>0&&hindex<textbox.size()){
      cursory = y + textbox.get(textbox.size()-1).vpos * textsize;
      cursorx = textbox.get(textbox.size()-1).x + textbox.get(textbox.size()-1).w*(textsize/12)-x;
      }
    }}
    if(hindex>-1){
      if(textbox.size()>hindex+1){
      cursorx = textbox.get(hindex).x + textbox.get(hindex).w*(textsize/12) - x;
      cursory = y + textbox.get(hindex).vpos * textsize;
    }}
    if(pos(mouse)||toggle==1){
      //cursor(POINT);
        if(t1>0){
          t1 --;
          if(strheight<y+h){
          canvas.stroke(0);
          canvas.strokeWeight(1);
          canvas.line(x+cursorx,cursory ,x+cursorx,cursory+textsize);
          }
        if(t1<=0)t2 = blkrate;
        }
        if(t2>0&&t1<=0){
          t2--;if(t2<=0)t1 = blkrate;
          }}
          else {
            //cursor(ARROW);
          }
  };
  
  void delete(){
    Letter current = null;
    
    if(textbox.size()>0&&hindex!=-1)current = textbox.get(hindex);
    if(textbox.size()>0&&hindex==-1)current = textbox.get(textbox.size()-1);
    
    String tm1 = "",tm2 = "";
    String tma;
    
    if(keyPressed && key == BACKSPACE){
      if(hindex==-1&&textBox.length()>0){
        if(current!=null&&current.id>0){
          //text
          if(lines.get(lines.size()-1) > current.id-1) lines.remove(lines.size()-1);
          if(lines.size()-1>0&&current.vpos<lines.size()-1){
              vcount --;
              lines.remove(lines.size()-1);
          }
          hindex = current.id;
          textbox.remove(textbox.size()-1);
          textBox = textBox.substring ( 0, textBox.length()-1  );
        }else{
          textbox = new ArrayList<Letter>();
          textBox = "";
        }
      }
      else{
        if(current!=null&&current.id>-1){
          if(current!=null&&lines.get(lines.size()-1) > textbox.get(textbox.size()-1).id-1) lines.remove(lines.size()-1);
          if(lines.size()>0&&textbox.get(textbox.size()-1).vpos<lines.size()-1){
              vcount --;
              lines.remove(lines.size()-1);
          }
          hindex = current.id-1;
          
          textbox.remove(textbox.size()-1);
          if(current.id >0){
            tm1 = textBox.substring ( 0, hindex+1 );
            tm2 = textBox.substring ( hindex +2, textBox.length()  );
          }else if(current.id==0){
            tm1 = "";
            tm2 = textBox.substring ( 0, textBox.length()  );
          }
          textBox = tm1 + tm2;
          
        }}}
    
  };
  
  void paste(){
    
    for(int i=0;i<cboard.length();i++){
      String a = str(cboard.charAt(i));
      getKey();
    }
    
  };
  
  void box(){
    if(!hidden){
      //------------------------------- border
      if(border)stroke(col2);
      else noStroke();
      //-------------------------------label
      if(label!=null){
        fill(col2);
        text(label,x,y+textsize);
      }
      //---------------------------------fill
      if(fill)if(pos())fill(col);else fill(0);
        else noFill();fill(col);
      
      rect(x,y,w,h);
      }
  };

  void box(PGraphics canvas){
    if(!hidden){
      //------------------------------- border
      if(border)canvas.stroke(col2);
      else canvas.noStroke();
      //-------------------------------label
      if(label!=null){
        canvas.fill(col2);
        canvas.text(label,x,y+textsize);
      }
      //---------------------------------fill
      if(fill)if(pos())canvas.fill(col);else canvas.fill(0);
        else canvas.noFill();canvas.fill(col);
      
      canvas.rect(x,y,w,h);
      }
  };
  
  Letter sort(ArrayList<Letter>a){
    Letter k = a.get(0);
    
    for(int i=0;i<a.size();i++){
      
      if(k.id>a.get(i).id){
        k = a.get(i);
      }}
    return k;
  };
  
  void conditionals(){
    
    if(vpos<=0) vpos = 0;
    
    if(selectAll&&toggle==1){
        if(dragh.size()!=textBox.length())dragh.add(0);
      }
     
    if(keyPressed&&keyCode!=SHIFT){
      timer --;
    }else {
      timer = maxCount;
      firstPress = false;
    }
    if(lines.size()>rows)lines.remove(lines.size()-1);
    if(lines.size()<=1)vcount = 0;
    if(toggle==1)clear = true;
    if(mousePressed&&!pos()){
      //vindex = -1;
      hindex = -1;
    }
    if(mousePressed&&pos()){toggle=1;}
    
    if(toggle==1){
    if(keyPressed&&keyCode!=SHIFT){
      //println(timer);
        if((timer==maxCount-2||(timer%delay==0&&!firstPress))||(firstPress&&timer%delay2==0)){
          getChar = true;
        }else getChar = false;
        if(timer<0)firstPress=true;
      }else getChar = false;
    }
    //if(keyPressed&&keyCode==16)firstPress = false;
  };
  
  void conditionals(PGraphics canvas){
    
    if(vpos<=0) vpos = 0;
    
    if(selectAll&&toggle==1){
        if(dragh.size()!=textBox.length())dragh.add(0);
      }
    if(keyPressed&&keyCode!=SHIFT){
      timer --;
    }else {
      timer = maxCount;
      firstPress = false;
    }
    if(lines.size()>rows)lines.remove(lines.size()-1);
    if(lines.size()<=1)vcount = 0;
    if(toggle==1)clear = true;
    if(mousePressed&&!pos(mouse)){
        //vindex = -1;
        hindex = -1;
      }
      if(mousePressed&&pos(mouse)){toggle=1;}
      if(toggle==1){
    if(keyPressed&&keyCode!=SHIFT){
      //println(timer);
        if((timer==maxCount-2||(timer%delay==0&&!firstPress))||(firstPress&&timer%delay2==0)){
          getChar = true;
        }else getChar = false;
        if(timer<0)firstPress=true;
      }else getChar = false;
    }
  };
  
  void constants(){
    strheight = (floor(textWidth(textBox)/(w)));
    strwidth = ((textWidth(textBox))%(w));
  };
  
  boolean exclusion(){
    boolean k = false;
    
    if(keyCode==37||keyCode==38||keyCode==39||keyCode==40||keyCode==33||keyCode==34||keyCode==17||keyCode==18||keyCode==9||
       keyCode==20||keyCode==16||keyCode==255||keyCode==91||keyCode==36||keyCode==35||keyCode==45||keyCode==46||keyCode==8){
      k = true;
    }
    return k;
  };
  
  void select_All(){
    if(selectAll){
      
    }
  };
  
  void debug(){
    fill(255);
    text(textbox.size(),140,80);
    text(backup.length,140,90);
    text(totalwidth,140,100);
    //text(currentwidth,140,110);
    
    text("lines " + lines.size(),140,150);
    if(hindex>-1){text(hindex,140,120);}
    else {text(hindex,140,120);}
    if(vcount>-1)text(vcount,140,130);
    //if(clipBoard!=""){text(clipBoard,140,100);}
    for(int i=0;i<lines.size();i++){
      text(lines.get(i),x+x,y+textsize+10*i);
    }
  };

  String getChar(){
    String a = null;
    
    if(keyPressed){
      a  = str(key);
    }
    if(keyCode==9) a = null;
    
    return a;
    
  }
  char getchar(){
    char a = 'k';
    
    if(keyPressed){
      a  = char(key);
    }
    if(keyCode == 8){
      
    }
    pos();
    return a;
    
  };
  
  boolean pos(){
    
    float X = mouseX;
    float Y = mouseY;
    
    return X > x && X < x + w && Y > y && Y < y + h; 
  };
  
  boolean pos(PVector m){
    
    float X = m.x;
    float Y = m.y;
    
    return X > x && X < x + w && Y > y && Y < y + h-20; 
  };
  
  void calc_lwidth(){
    for (int i=0;i<strheight+1;i++){
      for(int j=0;j<w;j++){
        
        
    }}
  };
  
  void insert(){
    if(hindex>-1){
      
    }else{
      
    }
  };
  
  void mpos(){
    float X = mouseX;
    float Y = mouseY;
    float ww = w/cols;
    float hh = h/rows;
    
    if(pos())posx = floor(X/ww)*ww-10;posy = floor(Y/hh)*hh;
  };
  
  void mpos(PVector m){
    float X = m.x;
    float Y = m.y;
    float ww = w/cols;
    float hh = h/rows;
    
    if(pos(m))posx = floor(X/ww)*ww-10;posy = floor(Y/hh)*hh;
  };
  
  void getClick(){
  if(pos() && mousePressed)toggle=1;
  if(!pos()&& mousePressed)toggle=0;
  //if(toggle==2)toggle=0;
  };
  
  void getClick(PVector m){
  if(pos(m) && mousePressed)toggle=1;
  if(!pos(m)&& mousePressed)toggle=0;
  //if(toggle==2)toggle=0;
  };
  
  void nav(){
    if(hindex>=textbox.size()-1){hindex  =-1;}
    if(textbox.size()>0){
      if(hindex>=1){
    if(keyPressed && keyCode == 37 &&getChar){hindex --;}}
    if(hindex<=textbox.size()-1&&hindex>-1){
    if(keyPressed && keyCode == 39 &&getChar){ hindex ++;}}
    //if(keyPressed && key == UP && strheight >0) hindex += vpos *2;
    //if(keyPressed && key == DOWN && strheight )
    
    if(hindex==-1){
      if(keyPressed && keyCode == 37 &&getChar){hindex = textbox.size()-2;}
      //if(keyPressed && keyCode == 39 &&getChar){ hindex = 0;}
    }
    
    
    }
  };
  
};

class Letter{
  
  int id,vpos,hpos;
  float x,y,w,h,tsize;
  String l;
  color col = color(255,0);
  color col2 = color(0,0);
  boolean visible = true;
  
  Letter(String ll,float xx, float yy){
    x = xx;
    y = yy;
    l = ll;
    w = textWidth(l);
    h = 12;
  };
  
  boolean pos(){
    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
  }
  
  boolean pos(PVector m){
    return m.x>x&&m.x<x+w&&m.y>y&&m.y<y+h;
  }
};
