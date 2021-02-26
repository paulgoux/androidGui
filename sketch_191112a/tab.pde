class tab extends tabBoundary {

  PGraphics canvas,canvas2;
  float x, y, w, h,bx,by,bh,bw;
  int tabindex = -1, state, current,id,Width,Height;
  String label,itemLabel;
  boolean border,open,parentCanvas,overflow,docking,docked,dmdown;
  PVector mouse,mouse2;
  Dock parentDock; 
  
  ArrayList<Grid> grids = new ArrayList<Grid>();
  
  ArrayList<Window> windows = new ArrayList<Window>();
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<PImage> images = new ArrayList<PImage>();
  ArrayList<PImage> temp_images = new ArrayList<PImage>();
  ArrayList<Menu> menus = new ArrayList<Menu>();
  ArrayList<sliderBox> sliderBoxes = new ArrayList<sliderBox>();
  ArrayList<Dropdown> dmenus = new ArrayList<Dropdown>();
  ArrayList<Table_> tables = new ArrayList<Table_>();
  ArrayList<String> links = new ArrayList<String>();
  
  ArrayList<TextArea> textareas = new ArrayList<TextArea>();
  ArrayList<textBlock> textBlocks = new ArrayList<textBlock>();
  ArrayList<TextBox> textboxes = new ArrayList<TextBox>();
  ArrayList<String[]> temp_text = new ArrayList<String[]>();
  ArrayList<processing.data.Table> temp_tables = new ArrayList<processing.data.Table>();
  String folder = "";
  String file = "";
  HashMap<String, Boolean> keys = new HashMap<String, Boolean>();

  ArrayList<Boolean> bools = new ArrayList<Boolean>();
  PVector window = new PVector(0, 0);
  Slider sliderv;
  Slider sliderh;
  tab navigator;
  tab child, parent,parentTab;
  tab current_tab, next_tab, previous_tab;


  ArrayList<tab> tabs = new ArrayList<tab>();
  ArrayList<tab> states = new ArrayList<tab>();
  ArrayList<Integer> transitions = new ArrayList<Integer>();
  public boolean visible = true, scrollable,draggable,drag;
  boolean sliderset, displayChild, init, setTab,slidersUpdated;
  Button title;

  tab( float x, float y, float w, float h,int k) {
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    canvas = createCanvas();
    //tabs.add(this);
    createConstruct();
    
  };
  
  tab( float x, float y, float w, float h) {
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //tabs.add(this);
    canvas = createCanvas();
    createConstruct();
    
    //this.label = label;this.itemLabel = label;
    //title = new Button(x, y, w, 20, label);
    //title.border = false;
  };
  
  tab( float x, float y, float w, float h,Slider s) {
    
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    canvas = createCanvas();
    states.add(this);
    
  };
  
  tab( float x, float y, float w, float h,Boundary b) {
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    canvas = createCanvas();
    states.add(this);
    createConstruct2();
    
  };
  
  tab( float x, float y, float w, float h, String label,int k) {
    //super();
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    canvas = createCanvas();
    this.label = label;
    this.itemLabel = label;
    title = new Button(0, 0, w, 20, label);
    title.border = false;

    createConstruct();
  };

  tab( float x, float y, float w, float h, String label) {
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    canvas = createCanvas();
    this.label = label;
    this.itemLabel = label;
    title = new Button(0, 0, w, 20, label);
    title.border = false;

    createConstruct();
  };
  
    tab( float x, float y, float w, float h, String label,boolean n) {
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    canvas = createCanvas();
    this.label = label;
    this.itemLabel = label;
    title = new Button(0, 0, w, 20, label);
    title.border = false;
    createConstruct();
  };

  tab() {
  };
  
  void createConstruct(){
    bx = x;
    by = y;
    Window w1 = new Window(83, 80, 200, 200, "C:\\Users\\paul goux\\");
    windows.add(w1);

    sliderv = new Slider(w-10, 20, 10, h-20);
    sliderv.classic = true;
    sliderv.bar = true;
    sliderv.vertical = true;
    sliderv.tooltip = null;
    sliderv.parentCanvas = true;
    sliderv.parentTab = this;
    sliderh = new Slider(0, h-10, w-10, 10);
    sliderh.tooltip = null;
    sliderh.classic = true;
    sliderh.bar = true;
    sliderh.parentCanvas = true;
    sliderh.parentTab = this;

    //Boundaries.add(new Boundary(0, 0, w, h, 4));
    states.add(this);
  };
  
  void createConstruct2(){

    sliderv = new Slider(w-10, 0, 10, h-10);
    sliderv.classic = true;
    sliderv.bar = true;
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(0, h-10, w-10, 10);
    sliderh.tvisible = false;
    sliderh.classic = true;
    sliderh.bar = true;
    //Boundaries.add(new Boundary(0, 0, w, h, 4));
  };
  
PGraphics createCanvas() {
  PGraphics pg = createGraphics(int(w), int(h));
  //pg.setLocation(x, y);
  return pg;
}

PGraphics createCanvas2() {
  PGraphics pg = createGraphics(int(w), int(h+50));
  //pg.setLocation(x, y);

 
  return pg;
}

PGraphics createCanvas(float w,float h) {
  PGraphics pg = createGraphics(int(w), int(h));
  //pg.setLocation(x, y);
  
 
  return pg;
}

void setCanvas(tab t){
    if (!sliderh.mdown)sliderv.mouseFunctions(t.mouse);
    // fill(0);
    // ellipse(t.mouse.x,t.mouse.y,20,20);
    sliderv.mouse = mouse;
    sliderv.draw(t.canvas);
    if (!sliderv.mdown)sliderh.mouseFunctions(t.mouse);
    sliderh.mouse = mouse;
    sliderh.draw(t.canvas);

};
  
  void save(){
    
  };
  
  void load(){
    
  };
  

  void displayTab(PGraphics scene) {
    
    tab t = states.get(state);
    
    if (toggle&&canvas!=null) {
      t.mouse = mouse2;
      mouse = mouse2;
      canvas.beginDraw();
      canvas.background(50);
      logic();
      t.drawBorder();
      t.boundingBox();
      
      t.drawButtons();
      t.drawMenus();
      t.drawTextboxes();
      t.drawTextareas();
      t.drawTextBlocks();
      t.drawSliderBoxes();
    if(t.title!=null&&t.visible){
      t.title.toggle=1;
      t.drawTitle();
      t.drawBorder();
      t.drawDmenu();
    }
      //t.drawImages();
    if(t.scrollable)t.drawSlider();
      //t.drawWindows();
      canvas.endDraw();
      scene.image(canvas,x,y);
    }
  };
  
  void displayTab() {
    fill(255);
    tab t = states.get(state);
    //println(t.menus.size());
    if (toggle&&visible&&canvas!=null) {
      if(!parentCanvas){
        t.mouse = getMouse();
        mouse = getMouse();
      }
      else{
        t.mouse = getMouse();
        mouse = getMouse();
      }
      canvas.beginDraw();
      //canvas.background(50);
      logic();
      t.drawBorder();
      t.boundingBox();
      t.drawButtons();
      t.drawMenus();
      t.drawTextboxes();
      t.drawTextareas();
      t.drawSliderBoxes();
      t.drawTextBlocks();
      if(t.title!=null&&t.visible){
        if(!toggle)t.title.toggle=1;
        t.drawTitle();
        t.drawBorder();
        t.drawDmenu();
      }
      //t.drawWindows();
      if(t.scrollable)t.drawSlider();
      // if(docked){
      //   canvas.fill(0);
      //   canvas.rect(0,0,w,h);
      // }
      canvas.endDraw();
      image(canvas,x,y);
    }
  };

  
  void displayTabs() {
    
    tab t = states.get(state);
    //println(t.menus.size());
    if (toggle&&t!=null&&canvas!=null) {
      t.mouse = getMouse();
      mouse = getMouse();
      canvas.beginDraw();
      canvas.background(50);
      //for(int i=0;i<states.size();i++){
      //tab t1 = states.get(i);
      
      //if(i!=state&&toggle){
      //  t1.toggle = false;
      //  t1.visible = false;
      //  if(t1.title!=null)t1.title.toggle=1;
      //}else t1.toggle=true;}
      t.logic();
      t.boundingBox();
      t.drawButtons();
      t.drawMenus();
      t.drawTextboxes();
      t.drawTextareas();
      t.drawTable_s();
      //t.displayInnerTabs();
      t.drawText();
      t.drawTitle();
      t.drawBorder();
      t.drawDmenu();
      t.drawSliderBoxes();
      t.drawTextBlocks();
      //t.drawWindows();
    if (t!=null&&t.scrollable&&t.toggle)t.drawSlider();
      
      canvas.endDraw();
      image(canvas,x,y);
    }
  };
  
  void displayTabs(PGraphics scene) {
    
    tab t = states.get(state);
    
    if (toggle&&t!=null&&canvas!=null) {
      t.mouse = mouse2;
      mouse = mouse2;
      
      canvas.beginDraw();
      
      for(int i=0;i<states.size();i++){
      tab t1 = states.get(i);
      
      if(i!=state&&toggle){
        // t1.toggle = false;
        // t1.visible = false;
        // if(t1.title!=null)t1.title.toggle=1;
      }else t1.toggle=true;}
      t.logic();
      t.boundingBox();
      t.drawButtons();
      t.drawMenus();
      t.drawTextboxes();
      t.drawTextareas();
      t.drawTable_s();
      //t.displayInnerTabs();
      t.drawText();
      t.drawTitle();
      t.drawBorder();
      t.drawDmenu();
      t.drawSliderBoxes();
      t.drawTextBlocks();
    if (t!=null&&t.scrollable&&t.toggle)t.drawSlider();
    
      canvas.endDraw();
      scene.image(canvas,x,y);
      
    }
  };
  
  void addState(int k){
    if(title==null){
    for(int i=0;i<k;i++){
      states.add(new tab(x,y,w,h));
    }}else{
      for(int i=0;i<k;i++){
      states.add(new tab(x,y,w,h,"hello"+i));
    }}
  };

  void addState(int k,String[] names){
    if(title==null){
    for(int i=0;i<k;i++){
      states.add(new tab(x,y,w,h));
    }}else{
      for(int i=0;i<k;i++){
      states.add(new tab(x,y,w,h,names[i]));
    }}
  };
  
  void setTitle(int i,String s){
    tab k = states.get(i);
    
    if(k.title!=null)k.title.label = s;
  };
  
  void add(int i,Button b){
    //clear();
    tab k = states.get(i);
    b.parentCanvas = true;
    k.buttons.add(b);
  };
  
  void add(int i,Menu m){
    //clear();
    tab k = states.get(i);
    m.parentCanvas = true;
    k.menus.add(m);
  };
  
  void add(int i,Dropdown d){
    //clear();
    tab k = states.get(i);
    d.parentCanvas = true;
    k.dmenus.add(d);
  };
  
  void add(int i,TextBox t){
    //clear();
    tab k = states.get(i);
    t.parentCanvas = true;
    k.textboxes.add(t);
  };
  
  void add(int i,TextArea t){
    //clear();
    tab k = states.get(i);
    t.parentCanvas = true;
    k.textareas.add(t);
  };

  void add(int i,textBlock t){
    //clear();
    tab k = states.get(i);
    t.parentCanvas = true;
    k.textBlocks.add(t);
  };
  
  void add(int i,String s){
    //clear();
    // tab k = states.get(i);
    // k.textblock.add(s);
  };
  
  void add(int i,Table_ t){
    //clear();
    t.parentCanvas = true;
    tab k = states.get(i);
    k.tables.add(t);
  };
  
  void add(Button b){
    //clear();
    tab k = states.get(0);
    b.parentCanvas = true;
    k.buttons.add(b);
  };
  
  void add(Menu m){
    //clear();
    tab k = states.get(0);
    m.parentCanvas = true;
    //m.localCanvas = canvas;
    k.menus.add(m);
  };
  
  void add(Dropdown d){
    //clear();
    tab k = states.get(0);
    d.parentCanvas = true;
    k.dmenus.add(d);
  };
  
  void add(TextBox t){
    //clear();
    tab k = states.get(0);
    t.parentCanvas = true;
    k.textboxes.add(t);
  };
  
  void add(TextArea t){
    //clear();
    tab k = states.get(0);
    t.parentCanvas = true;
    k.textareas.add(t);
  };
  
  void add(String s){
    //clear();
    tab k = states.get(0);
    //k.textBlocks.add(s);
  };
  
  void add(Table_ t){
    //clear();
    t.parentCanvas = true;
    tab k = states.get(0);
    k.tables.add(t);
  };
  
  void add(sliderBox s){
    //clear();
    s.parentCanvas = true;
    tab k = states.get(0);
    k.sliderBoxes.add(s);
  };
  
  PVector getMouse(){
    return new PVector(mouseX-x,mouseY-y);
  };
  
  PVector getMouse2(){
    return new PVector(mouseX-x,mouseY-y);
  };
  
  PVector getMouse(PVector m){
    return new PVector(m.x-x,m.y-y);
  };
  
  void clear(){
    textboxes = new ArrayList<TextBox>();
    grids = new ArrayList<Grid>();
    textareas = new ArrayList<TextArea>();
    //windows = new ArrayList<Window>();
    buttons = new ArrayList<Button>();
    images = new ArrayList<PImage>();
    temp_images = new ArrayList<PImage>();
    menus = new ArrayList<Menu>();
    dmenus = new ArrayList<Dropdown>();
    tables = new ArrayList<Table_>();
    links = new ArrayList<String>();
    textBlocks = new ArrayList<textBlock>();
    //processedText = new ArrayList<vectorText>();
    temp_text = new ArrayList<String[]>();
    temp_tables = new ArrayList<processing.data.Table>();
  };
  
  void logic() {
    if(!mdown){
      drag = false;
      if(BMS.currentObject == this)BMS.currentObject = null;
    }
    if (navigator!=null)navigator.displayTabs();
    if (scrollable) {
      sliderh.mouse = getMouse();
      if (!sliderh.mdown) {
        //sliderv.mouseFunctions();
        //sliderv.set(-h+20, h-20, this, "window.y");
      }
      //sliderv.mouse = getMouse();
      if (!sliderv.mdown) {
        //sliderh.set(-w+10, w-10, this, "window.x");
        //sliderh.mouseFunctions();
      }
    }
    if(draggable){
      
      drawDragBox();
      if(!sliderv.mdown&&!sliderh.mdown&&title.pos(getMouse())&&mousePressed&&!mdown&&!drag&&BMS.currentObject==null){
        
        BMS.currentObject = this;
        
        if(title.label!=null)BMS.currentMouseObject = title.label;
        println(BMS.currentMouseObject);
        mdown = true;
        docked = false;
        docking = false;
        dx = x - mouseX;
        dy = y - mouseY;
        drag = true;
      }
      
      // if(mdown)drag = true;
      // else {
      //   drag = false;
      //   // BMS.currentObject = null;
      //   // BMS.currentMouseObject = null;
      // }
      
      if(drag){
        x = mouseX+dx;
        y = mouseY+dy;

        if(parentDock!=null&&parentDock.pos(new PVector(x,y))&&!docking){
          docking = true;
          parentDock.loc = itemLabel;
          parentDock.currentObject = this;
        }
      }

      if(!mousePressed&&docking&&!docked){
        //println("docked");
        docked = true;
        docking = false;
        x = bx;
        y = by;
      }
      
      if(!mousePressed)mdown = false;
    }
  };
  
  void drawSliderBoxes(){
    
    for (int i=states.get(state).sliderBoxes.size()-1;i>-1; i--) {
      
      sliderBox s = null;
      if(states.get(state).sliderBoxes.get(i)!=null){
        s = states.get(state).sliderBoxes.get(i);
        s.mouse = getMouse();
        s.parentTab = this;
        s.draw(canvas);
      }
    }
  };

  void drawSliderBoxes_(){
    if(mousePressed)println("hh");
    for (int i=states.get(state).sliderBoxes.size()-1;i>-1; i--) {
      
      sliderBox s = states.get(state).sliderBoxes.get(i);
      //s.mouse = getMouse();
      //s.parentTab = this;
      s.draw();
    }
  };

  void drawSliderBoxes(PGraphics canvas){
      
    if(canvas!=null){
      
      canvas.beginDraw();
      for (int i=states.get(state).sliderBoxes.size()-1;i>-1; i--) {
        
        sliderBox s = states.get(state).sliderBoxes.get(i);
        s.mouse = getMouse();
        s.parentTab = this;
        s.draw(canvas);
      }
      canvas.endDraw();
      }
  };

  void drawTextBlocks(){
    for (int i=states.get(state).textBlocks.size()-1;i>-1; i--) {
        
      textBlock t = states.get(state).textBlocks.get(i);
      //t.mouse = getMouse();
      //t.parentTab = this;
      t.draw(canvas);
    }
    //canvas.endDraw();

  };

  void drawTextBlocks(boolean b){
    canvas.beginDraw();
    for (int i=states.get(state).textBlocks.size()-1;i>-1; i--) {
        
      textBlock t = states.get(state).textBlocks.get(i);
      //t.mouse = getMouse();
      //t.parentTab = this;
      t.draw(canvas);
    }
    canvas.endDraw();

  };
  
  void drawDragBox(){
    
    canvas.fill(0);
    canvas.noStroke();
    if(border)canvas.stroke(255);
    canvas.rect(x,y-5,w,5);
    
  };
  
  void drawSlider() {
    //canvas.beginDraw();
    canvas.fill(0);
    //canvas.ellipse(getMouse().x,getMouse().y,20,20);
    //canvas.endDraw();
    //image(canvas,x,y);
    sliderv.mouse = getMouse();
    //if(posTab(getMouse())||sliderv.mdown)
    if(!sliderh.mdown)sliderv.mouseFunctions(mouse);
    sliderv.draw(canvas);
    sliderh.mouse = getMouse();
    //if(posTab(getMouse())||sliderh.mdown)
    if(!sliderv.mdown)sliderh.mouseFunctions(mouse);
    sliderh.draw(canvas);

  };

  void drawText() {
  };

  void drawDmenu() {
    boolean k = false;
    int id = -1;
    for (int i=states.get(state).dmenus.size()-1;i>-1; i--) {
      Dropdown d = states.get(state).dmenus.get(i);
      
      if(parentTab==null)d.mouse = getMouse();
      else d.mouse = getMouse(mouse);
      if(mousePressed&&!dmdown&&d.toggle==1){
        id=i;
        dmdown = true;
      }
      if(d.toggle==1&&id!=i)d.toggle=0;
      d.displayDropdown(canvas);
      dmdown = false;
    };
  };

  void scrolllogic() {
  };

  void drawTitle() {
    canvas.fill(255);
    if(states.size()>0&&state<states.size()&&state>-1){
      if(states.get(state).title!=null){
        states.get(state).title.mouse = mouse;
        states.get(state).title.draw(canvas);
      }}
    
    if(states.size()>0&&state<states.size()&&states.get(state).title!=null)states.get(state).title.toggle2(this, "toggle");
  };
  
  void drawTitle(PGraphics scene) {
    scene.fill(255);
    if(states.size()>0&&state<states.size()&&state>-1){
      if(states.get(state).title!=null){
        states.get(state).title.mouse = mouse;
        states.get(state).title.draw(scene);
      }}
    
    if(states.size()>0&&state<states.size()&&states.get(state).title!=null)states.get(state).title.toggle2(this, "toggle");
  };
  
  void drawBorder() {
    if (border) {
      canvas.stroke(255, 200);
      canvas.noFill();
      canvas.rect(0, 0, w, h);
    }
    canvas.noStroke();
  };

  void boundingBox() {
    if(canvas!=null){
      canvas.noStroke();
      canvas.fill(255);
      
      canvas.rect(0, 0, w, h);
      canvas.fill(0, 50);
      canvas.rect(0, 0, w, h);
    }
  };
  
  //important
  void getFile(){
    //PImage t_img ;
    
    //Image t_Img;
    //String[] t_text;
    //processing.data.Table t_table;
    
    //ArrayList<Integer> k = new ArrayList<Integer>();
    
    //if(file.length()>0){
    //  if(file.endsWith("jpg")|| file.endsWith("jpeg") ||file.endsWith("png")||file.endsWith("bmp")||
    //      file.endsWith("gif")||file.endsWith("JPG")||file.endsWith("JPEG")||file.endsWith("PNG")||
    //      file.endsWith("BMP")||file.endsWith("GIF")){
            
    //      t_img = loadImage(file);
    //      if(!temp_images.contains(t_img))temp_images.add(t_img);
    //      //if(!temp_images.contains(t_img))images.add(t_img);
    //      Image img = new Image(t_img);
    //      if(!processedImages.contains(img))processedImages.add(img);
    //  }
      
    //  if(file.endsWith("txt")){
            
    //      t_text = loadStrings(file);
    //      if(!temp_text.contains(t_text))temp_text.add(t_text);
    //  }
      
    //  if(file.endsWith("csv")){
            
    //      t_table = loadTable(file);
    //      if(!temp_tables.contains(t_table))temp_tables.add(t_table);
    //  }
      
    //  if(file.endsWith("doc")){
            
    //      t_text = WordStream(file);
    //      if(!temp_text.contains(t_text))temp_text.add(t_text);
    //  }
    //  if(file.endsWith("mp3")|| file.endsWith("aiff") ||file.endsWith("ogg")||file.endsWith("flac")||
    //      file.endsWith("m4a")||file.endsWith("flac")){
            
    //      t_table = loadTable(file);
    //      if(!temp_tables.contains(t_table))temp_tables.add(t_table);
    //  }
    //}
  };
  
  boolean posTab() {
    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
  };
  
  boolean posTab(PVector m) {
    return mouse!=null&&mouse.x>x&&mouse.x<x+w&&mouse.y>y&&mouse.y<y+h;
  };
  
  boolean posTabd() {
    return mouseX>x&&mouseX<x+w&&mouseY>y-5&&mouseY<y;
  };
  
  boolean posTabd(PVector m) {
    return m.x>x&&m.x<x+w&&m.y>y-5&&m.y<y;
  };
  
  void drawImages(){
    
    for (int i=0; i<states.get(state).images.size(); i++) {
      PImage p = states.get(state).images.get(i);
      canvas.image(p,x,y);
    }
    
  };

  void drawDynamicImages(ArrayList<PImage> p,int k){
    
      
    tab t = states.get(state);
    if(t.toggle&&t.visible){
      canvas.beginDraw();
      int borderSize = 4;
      for (int i=p.size()-1;i>-1; i--) {
        PImage p1 = p.get(i);
        canvas.stroke(0);
        canvas.strokeWeight(borderSize);
        
        canvas.noFill();
        if(i==0){
          canvas.rect((p1.width+20) * i-borderSize*2 - p1.width+20-35,40-borderSize*2,p1.width+borderSize*4,p1.height+borderSize*4);
        }
        canvas.stroke(255,0,0);
        //float x = 
        if(0==k-i){
          canvas.rect((p1.width+20) * i-borderSize,40-borderSize*2,p1.width+borderSize*4,p1.height+borderSize*4);
        }
        canvas.stroke(0);
        canvas.rect((p1.width+20) * i-borderSize-p1.width+20-35,40-borderSize,p1.width+borderSize*2,p1.height+borderSize*2);
        canvas.image(p1,(p1.width+20) * i-p1.width+20-35,40);
      }
      //if(t.scrollable)t.drawSlider();
      canvas.endDraw();
      image(canvas,x,y);
    }
  };

  void drawButtons() {
    fill(255);

    for (int i=0; i<buttons.size(); i++) {
      
      Button b = buttons.get(i);
      b.mouse =  mouse;
      b.parentCanvas = true;
      b.draw(canvas);
      b.highlight(mouse);
      b.self_click2(mouse);
    }
  };
  
  void drawButtons(PGraphics scene) {
    scene.fill(255);

    for (int i=0; i<buttons.size(); i++) {
      Button b = buttons.get(i);
      b.mouse =  mouse;
      b.parentCanvas = true;
      b.draw(scene);
      b.self_click2(mouse);
    }
  };

  void drawMenus() {
    for (int i=0; i<menus.size(); i++) {
      
      Menu m = menus.get(i);
      
      //m.setParentCanvas(canvas);
      m.mouse = getMouse();
      // if(parentTab==null)m.mouse = getMouse();
      // else m.mouse = getMouse(mouse);
      m.draw(canvas);
      }
  };

  void drawTextboxes() {
    for (int i=0; i<textboxes.size(); i++) {
      TextBox t = textboxes.get(i);
      if(parentTab==null)t.mouse = mouse;
      else t.mouse = getMouse(mouse);
      t.draw(canvas);
    }
  };

  void drawTextareas() {
    for (int i=0; i<textareas.size(); i++) {
      TextArea t = textareas.get(i);
      if(parentTab==null)t.mouse = getMouse();
      else t.mouse = getMouse(mouse);
      t.toggle=1;
      t.draw(canvas);
    }
  };

  void drawWindows() {
    for (int i=0; i<windows.size(); i++) {
      Window w = windows.get(i);
      //w.toggle = true;
      
      w.display_grid();
    }
  };

  void drawTable_s() {
    for (int i=0; i<tables.size(); i++) {
      Table_ t = tables.get(i);
      t.draw();
    }
  };

  void displayInnerTabs() {
    for (int i=0; i<tabs.size(); i++) {
      tab t = tabs.get(i);
      t.displayTabs();
    }
  };
};
