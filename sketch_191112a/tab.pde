class tab extends tabBoundary {

  PGraphics canvas,canvas2;
  float x, y, w, h,bx,by,bh,bw,r1,r2,r3,r4;
  int tabindex = -1, state, current,id,Width,Height;
  String label,itemLabel;
  boolean border,open,parentCanvas,overflow,docking,docked,dmdown;
  public boolean localTheme,resizable,vscroll,hscroll;
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
  ArrayList<toggleMenu> toggleMenus = new ArrayList<toggleMenu>();
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
  color titleColor = color(0),textColor = color(0),tabcol = color(0,255,175) ;


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
      t.drawToggleMenus();
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
    for (int i=0; i<k.sliderBoxes.size(); i++) {
        sliderBox s1 = k.sliderBoxes.get(i);
        s1.x = x+s1.bx;
        s1.y = y+s1.by;
      }
  };
  
  void add(toggleMenu s){
    //clear();
    s.parentTab = this;
    tab k = states.get(0);
    k.toggleMenus.add(s);
    //for (int i=0; i<k.toggleMenus.size(); i++) {
    //    toggleMenu s1 = k.toggleMenus.get(i);
    //    s1.x = x+s1.bx;
    //    s1.y = y+s1.by;
    //  }
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
    if(draggable&&BMS.sliderObject==null){
      
      drawDragBox();
      if(!sliderv.mdown&&!sliderh.mdown&&title.pos(getMouse())&&mousePressed&&!mdown&&!drag&&BMS.currentObject==null){
        
        BMS.currentObject = this;
        
        if(title.label!=null)BMS.currentMouseObject = title.label;
        //println("tab",BMS.currentMouseObject);
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
    //if(mousePressed)println("tab",states.get(state).sliderBoxes.size());
    for (int i=states.get(state).sliderBoxes.size()-1;i>-1; i--) {
      
      sliderBox s = null;
      if(states.get(state).sliderBoxes.get(i)!=null){
        s = states.get(state).sliderBoxes.get(i);
        if(scrollable&&vscroll)s.menu.y = s.by - sliderv.value;
        if(scrollable&&vscroll)s.y = s.by - sliderv.value;
        if(scrollable&&hscroll)s.menu.x = s.menu.bx - sliderh.value;
        if(scrollable&&hscroll)s.x = s.menu.bx - sliderh.value;
        s.mouse = getMouse();
        s.parentTab = this;
        //if(mousePressed)println(s.x,s.y,s.menu.x,s.menu.y);
        s.draw(canvas);
      }
    }
  };

  void drawSliderBoxes_(){
    if(mousePressed)println("hh");
    for (int i=states.get(state).sliderBoxes.size()-1;i>-1; i--) {
      
      sliderBox s = states.get(state).sliderBoxes.get(i);
      if(scrollable&&vscroll)s.menu.y = s.menu.by - sliderv.value;
      if(scrollable&&hscroll)s.x = s.bx - sliderh.value;
      s.mouse = getMouse();
      s.parentTab = this;
      s.draw();
    }
  };

  void drawSliderBoxes(PGraphics canvas){
      
    if(canvas!=null){
      
      canvas.beginDraw();
      for (int i=states.get(state).sliderBoxes.size()-1;i>-1; i--) {
        
        sliderBox s = states.get(state).sliderBoxes.get(i);
        if(scrollable&&vscroll)s.y = s.by - sliderv.value;
        if(scrollable&&hscroll)s.x = s.bx - sliderh.value;
        s.mouse = getMouse();
        s.parentTab = this;
        s.draw(canvas);
      }
      canvas.endDraw();
      }
  };
  
  void drawToggleMenus(){
    //if(mousePressed)println("tab",states.get(state).sliderBoxes.size());
    for (int i=states.get(state).toggleMenus.size()-1;i>-1; i--) {
      
      toggleMenu s = null;
      if(states.get(state).toggleMenus.get(i)!=null){
        s = states.get(state).toggleMenus.get(i);
        if(s.parentTab == null)s.parentTab = this;
        if(scrollable&&vscroll)s.menu.y = s.by - sliderv.value;
        if(scrollable&&vscroll)s.y = s.by - sliderv.value;
        //if(scrollable&&hscroll)s.menu.x = s.menu.bx - sliderh.value;
        //if(scrollable&&hscroll)s.x = s.menu.bx - sliderh.value;
        s.menu.mouse = getMouse();
        if(s.menu.parentTab == null)s.menu.parentTab = this;
        //if(mousePressed)println(s.x,s.y,s.menu.x,s.menu.y);
        s.draw(canvas);
      }
    }
  };

  void drawTextBlocks(){
    for (int i=states.get(state).textBlocks.size()-1;i>-1; i--) {
        
      textBlock t = states.get(state).textBlocks.get(i);
      //t.mouse = getMouse();
      //t.parentTab = this;
      if(scrollable&&vscroll)t.y = t.by - sliderv.value;
      if(scrollable&&hscroll)t.x = t.bx - sliderh.value;
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
      if(scrollable&&vscroll)t.y = t.by - sliderv.value;
      if(scrollable&&hscroll)t.x = t.bx - sliderh.value;
      t.draw(canvas);
    }
    canvas.endDraw();

  };
  
  void drawDragBox(){
    
    canvas.fill(0);
    canvas.noStroke();
    if(border)canvas.stroke(255);
    canvas.rect(x,y-5,w,5,r1,r2,r3,r4);
    
  };
  
  void drawSlider() {
    //canvas.beginDraw();
    canvas.fill(0);
    //canvas.ellipse(getMouse().x,getMouse().y,20,20);
    //canvas.endDraw();
    //image(canvas,x,y);
    if(vscroll){
      sliderv.mouse = getMouse();
      //if(posTab(getMouse())||sliderv.mdown)
      if(!sliderh.mdown)sliderv.mouseFunctions(mouse);
      sliderv.draw(canvas);
    }
    if(hscroll){
      sliderh.mouse = getMouse();
      //if(posTab(getMouse())||sliderh.mdown)
      if(!sliderv.mdown)sliderh.mouseFunctions(mouse);
      sliderh.draw(canvas);
    }

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
      if(scrollable&&vscroll)d.y = d.by - sliderv.value;
      if(scrollable&&hscroll)d.x = d.bx - sliderh.value;
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
      canvas.rect(0, 0, w, h,r1,r2,r3,r4);
    }
    canvas.noStroke();
  };

  void boundingBox() {
    if(canvas!=null){
      canvas.noStroke();
      canvas.fill(255);
      
      canvas.rect(0, 0, w, h,r1,r2,r3,r4);
      canvas.fill(BMS.tabcol);
      if(localTheme)canvas.fill(tabcol);
      canvas.rect(0, 0, w, h,r1,r2,r3,r4);
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
      if(scrollable&&vscroll)b.y = b.by - sliderv.value;
      if(scrollable&&hscroll)b.x = b.bx - sliderh.value;
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
      
      if(scrollable&&vscroll)b.y = b.by - sliderh.value;
      if(scrollable&&hscroll)b.x = b.bx - sliderv.value;
    }
  };

  void drawMenus() {
    for (int i=0; i<menus.size(); i++) {
      
      Menu m = menus.get(i);
      
      //m.setParentCanvas(canvas);
      if(scrollable&&vscroll)m.y = m.by - sliderv.value;
      if(scrollable&&hscroll)m.x = m.bx - sliderh.value;
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
      if(scrollable&&vscroll)t.y = t.by - sliderv.value;
      if(scrollable&&hscroll)t.x = t.bx - sliderh.value;
      t.draw(canvas);
    }
  };

  void drawTextareas() {
    for (int i=0; i<textareas.size(); i++) {
      TextArea t = textareas.get(i);
      if(parentTab==null)t.mouse = getMouse();
      else t.mouse = getMouse(mouse);
      if(scrollable&&vscroll)t.y = t.by - sliderv.value;
      if(scrollable&&hscroll)t.x = t.bx - sliderh.value;
      t.toggle=1;
      t.draw(canvas);
    }
  };

  void drawWindows() {
    for (int i=0; i<windows.size(); i++) {
      Window w = windows.get(i);
      //w.toggle = true;
      
      w.displayGrid();
    }
  };

  void drawTable_s() {
    for (int i=0; i<tables.size(); i++) {
      Table_ t = tables.get(i);
      if(scrollable&&vscroll)t.y = t.by - sliderv.value;
      if(scrollable&&hscroll)t.x = t.bx - sliderh.value;
      t.draw();
      
    }
  };

  void displayInnerTabs() {
    for (int i=0; i<tabs.size(); i++) {
      tab t = tabs.get(i);
      t.displayTabs();
    }
  };
  
  
  void setRadius(float a){
    r1 = a;
    r2 = a;
    r3 = a;
    r4 = a;
    
    title.r1 = a;
    title.r2 = a;
    
    for (int i=0; i<dmenus.size(); i++) {
      Dropdown d = dmenus.get(i);
      d.setRadius(a);
    }
    
    for (int i=0; i<menus.size(); i++) {
      Menu d = menus.get(i);
      d.setRadius(a);
    }
    
    for (int i=0; i<sliderBoxes.size(); i++) {
      sliderBox s = sliderBoxes.get(i);
      s.menu.setRadius(a);
    }
    
    for (int i=0; i<toggleMenus.size(); i++) {
      toggleMenu s = toggleMenus.get(i);
      s.menu.setRadius(a);
    }
  };
  
  void setRadius(float a,float b,float c,float d){
    r1 = a;
    r2 = b;
    r3 = c;
    r4 = d;
    
    title.r1 = a;
    title.r2 = b;
    
    for (int i=0; i<dmenus.size(); i++) {
      Dropdown d1 = dmenus.get(i);
      d1.setRadius(a,b,c,d);
    }
    
    for (int i=0; i<menus.size(); i++) {
      Menu m = menus.get(i);
      m.setRadius(a,b,c,d);
    }
    
    for (int i=0; i<sliderBoxes.size(); i++) {
      sliderBox s = sliderBoxes.get(i);
      s.menu.setRadius(a,b,c,d);
    }
    
    for (int i=0; i<toggleMenus.size(); i++) {
      toggleMenu t = toggleMenus.get(i);
      t.menu.setRadius(a,b,c,d);
    }
  };
  
  void setAlignment(String s){
    
    if(s=="CENTER"||s=="center"||s=="Center"){
      if(title!=null){
        title.txoff = (title.w-textWidth(title.label))/2;
        
      }
      
      for (int i=0; i<windows.size(); i++) {
        Window w = windows.get(i);
        //w.x = 5
      }
      
      for (int i=0; i<tables.size(); i++) {
        Table_ t = tables.get(i);
        t.x = 5;
        //(b.w-textWidth(b.label))/2-((b.w-textWidth(b.label))/2)/2
        t.x = (w-t.w)/2;
      }
      for (int i=0; i<textboxes.size(); i++) {
        TextBox t = textboxes.get(i);
        t.x = (w-t.w)/2;
      }
      
      for (int i=0; i<textareas.size(); i++) {
        TextArea t = textareas.get(i);
        t.x = (w-t.w)/2;
      }
      
      for (int i=0; i<menus.size(); i++) {
        Menu m = menus.get(i);
        m.x = 5;
        m.x = (w-m.w)/2;
      }
      
      for (int i=0; i<buttons.size(); i++) {
        Button b = buttons.get(i);
        b.x = (w-b.w)/2;
      }
      
      for (int i=0; i<sliderBoxes.size(); i++) {
        sliderBox s1 = sliderBoxes.get(i);
        s1.x = (w-s1.w)/2;
        s1.menu.x = (w-s1.w)/2;
      }
      
      for (int i=0; i<toggleMenus.size(); i++) {
        toggleMenu s1 = toggleMenus.get(i);
        s1.x = (w-s1.w)/2-s1.menu.items.get(0).rx;
        //s1.menu.x = (w-s1.w)/2;
      }
      
      for (int i=0; i<dmenus.size(); i++) {
        Dropdown d = dmenus.get(i);
        d.x = (w-d.w)/2;
        d.txoff = d.w/2-textWidth(d.label)/2;
        for (int j=0; j<dmenus.get(i).items.size(); j++) {
          Button d1 = dmenus.get(i).items.get(j);
          d1.x = (w-d1.w)/2;
          d1.txoff = (d1.w-textWidth(d1.label))/2;
        }
      }
    }
    
    if(s=="RIGHT"||s=="right"||s=="Right"){
      
      if(title!=null){
        title.txoff = (title.w-textWidth(title.label))/2-((title.w-textWidth(title.label))/2)/2;
        
      }
      
      for (int i=0; i<windows.size(); i++) {
        Window w = windows.get(i);
        //w.x = 5
      }
      
      for (int i=0; i<tables.size(); i++) {
        Table_ t = tables.get(i);
        t.x = 5;
        t.x = (w-t.w)/2-((w-t.w)/2)/2;
      }
      for (int i=0; i<textboxes.size(); i++) {
        TextBox t = textboxes.get(i);
        t.x = (w-t.w)/2-((w-t.w)/2)/2;
      }
      
      for (int i=0; i<textareas.size(); i++) {
        TextArea t = textareas.get(i);
        t.x = 5;
        t.x = (w-t.w)-((w-t.w))/4;
      }
      
      for (int i=0; i<menus.size(); i++) {
        Menu m = menus.get(i);
        m.x = 5;
        m.x = (w-m.w)-((w-m.w))/4;
      }
      
      for (int i=0; i<buttons.size(); i++) {
        Button b = buttons.get(i);
        b.x = (w-b.w)-((w-b.w))/4;
      }
      
      for (int i=0; i<sliderBoxes.size(); i++) {
        sliderBox s1 = sliderBoxes.get(i);
        s1.x = (w-s1.w)-((w-s1.w))/4;
      }
      
      for (int i=0; i<toggleMenus.size(); i++) {
        toggleMenu s1 = toggleMenus.get(i);
        s1.x = (w-s1.w)-((w-s1.w))/4-s1.menu.items.get(0).rx;
        //s1.menu.x = (w-s1.w)/2;
      }
      
      for (int i=0; i<dmenus.size(); i++) {
        Dropdown d = dmenus.get(i);
        d.x = (w-d.w)-((w-d.w))/4;
        //for (int j=0; j<dmenus.get(i).items.size(); j++) {
        //  Button d1 = dmenus.get(i).items.get(j);
        //  d1.x = (w-d1.w)-((w-d1.w))/4;
        //}
      }
    }
    
    if(s=="LEFT"||s=="left"||s=="Left"){
      
      if(title!=null){
        title.txoff = 5;
        
      }
      
      for (int i=0; i<windows.size(); i++) {
        Window w = windows.get(i);
        w.x = 5;
      }
      
      for (int i=0; i<tables.size(); i++) {
        Table_ t = tables.get(i);
        t.x = 5;
      }
      for (int i=0; i<textboxes.size(); i++) {
        TextBox t = textboxes.get(i);
        t.x = 5;
      }
      
      for (int i=0; i<textareas.size(); i++) {
        TextArea t = textareas.get(i);
        t.x = 5;
      }
      
      for (int i=0; i<menus.size(); i++) {
        Menu m = menus.get(i);
        m.x = 5;
      }
      
      for (int i=0; i<buttons.size(); i++) {
        Button b = buttons.get(i);
        b.x = 5;
      }
      
      for (int i=0; i<sliderBoxes.size();i++){
        sliderBox s1 = sliderBoxes.get(i);
        s1.x = 5;
      }
      
      for (int i=0; i<toggleMenus.size(); i++) {
        toggleMenu s1 = toggleMenus.get(i);
        s1.x = 5-s1.menu.items.get(0).rx;
        //s1.menu.x = (w-s1.w)/2;
      }
      
      for (int i=0; i<dmenus.size(); i++) {
        Dropdown d = dmenus.get(i);
        d.x = 5;
        d.txoff = 0;
        for (int j=0; j<dmenus.get(i).items.size(); j++) {
          Button d1 = dmenus.get(i).items.get(j);
          d1.x = 5;
          d1.txoff = 0;
        }
      }
    }
  };
  
  void selfToggle(int i,int j){
    if(i<menus.size()&&j<menus.get(i).items.size()){
      PVector mouse = getMouse();
      menus.get(i).self_toggle(j,mouse);
      
    }else {
      
      if(title!=null){if(mousePressed)println("tab",title.label,"button or menu not found");}
      else if(mousePressed)println("tab: button or menu not found");
      
    }
      
  };
  
  boolean getToggle(int i,int j){
    
    if(i<menus.size()&&j<menus.get(i).items.size()){
      
      Button b = menus.get(i).items.get(j);
      
      if(b.toggle==1)return true;
      else return false;
      
    }else {
      
      if(title!=null){if(mousePressed)println("tab",title.label,"button or menu not found.");}
      else if(mousePressed)println("tab: button or menu not found.");
      return false;
      
    }
  };
  
  boolean getToggleMenu(int i,int j){
    
    if(i<toggleMenus.size()&&j<toggleMenus.get(i).menu.items.size()){
      
      Button b = toggleMenus.get(i).menu.items.get(j);
      
      if(b.toggle==1)return true;
      else return false;
      
    }else {
      
      if(title!=null){if(mousePressed)println("tab",title.label,"button or menu not found.");}
      else if(mousePressed)println("tab: button or menu not found.");
      return false;
      
    }
  };
  
  float getValue(int i,int j){
    if(i<sliderBoxes.size()&&j<sliderBoxes.get(i).menu.sliders.size()){
      
      Slider b = sliderBoxes.get(i).menu.sliders.get(j);
      
      return b.value;
      
    }else {
      
      if(title!=null)if(mousePressed){println("tab",title.label,"slider or sliderBox not found.");}
      else if(mousePressed)println("tab: slider or sliderBox not found.");
      return -99999;
      
    }
  };
  
  void setValue(int i,int j,float start,float end){
    if(i<sliderBoxes.size()&&j<sliderBoxes.get(i).menu.sliders.size()){
      
      Slider b = sliderBoxes.get(i).menu.sliders.get(j);
      
      b.set(start,end);
      
    }else {
      
      if(title!=null){if(mousePressed)println("tab",title.label,"slider or sliderBox not found.");}
      else if(mousePressed)println("tab: slider or sliderBox not found.");
      
    }
  };
  
  void setValue(int i,int j,float start,float end,Object o,String field){
    if(i<sliderBoxes.size()&&j<sliderBoxes.get(i).menu.sliders.size()){
      
      Slider b = sliderBoxes.get(i).menu.sliders.get(j);
      
      b.set(start,end);
      
    }else {
      
      if(title!=null){if(mousePressed)println("tab",title.label,"slider or sliderBox not found.");}
      else if(mousePressed)println("tab: slider or sliderBox not found.");
      
    }
  };
  
  void setIntValue(int i,int j,int start,int end){
    if(i<sliderBoxes.size()&&j<sliderBoxes.get(i).menu.sliders.size()){
      
      Slider b = sliderBoxes.get(i).menu.sliders.get(j);
      
       b.setint(start,end);
      
    }else {
      
      if(title!=null){if(mousePressed)println("tab",title.label,"slider or sliderBox not found.");}
      else if(mousePressed)println("tab: slider or sliderBox not found.");
      
    }
  };
  
  
  
};
