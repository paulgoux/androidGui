class BMScontrols{
  
  int Mcount;
  HashMap<Object,String> booleans = new HashMap<Object,String>();
  color bgcol = color(0);
  PApplet applet = null;
  boolean updated,autoSave;
  String currentMouseObject;
  Object currentObject;
  Menu mouseObject;
  Dropdown dropDownObject;
  String[] Lines;
  Button checkbox;
  Dock dock;
  public float autoSaveTimeout = 30;
  ArrayList<Slider> Sliders = new ArrayList<Slider>();
  ArrayList<sliderBox> sliderBoxes = new ArrayList<sliderBox>();
  ArrayList<TextBox> textBoxes = new ArrayList<TextBox>();
  ArrayList<TextArea> textAreas = new ArrayList<TextArea>();
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Menu> menus = new ArrayList<Menu>();
  ArrayList<tab> tabs = new ArrayList<tab>();
  Boundary bb;
  //fileInput File,Folder;
  Menu menu;
  
  //String[] cameras = Capture.list();
  String[] files;
  
  //Capture Cam;
  Dropdown dd;
  
  BMScontrols(PApplet Applet){
    applet = Applet;
    //startCam();
    
  };
  
  void add(Object o,String globalVar,boolean localVar){
    Field field = null;
    
    booleans.put(o,globalVar);
  
};

void draw(){
  // fill(255);
  
  // text("hello",100,100);
};

void begin(){
  //File = new fileInput();
  //Folder = new fileInput(true);
  
  setupWindows();
  setupMenus();
  setupRGB();
  setupReset();
  
  setupDock();
};


void setupDock(){
  dock = new Dock(0,height -22,width,24);
  //dock = b;
};


void setupWindows(){
  main = new Window(23,20,W-46,H-90-20);
  main.fill = false;
  main.border = false;
  Boundary b = new Boundary(main.x+1,main.y+1,main.w-2,main.h-2,4);
  //b.cohesionBoundary = true;
  //b.avoidBoundary = true;
  b.state = 1;
  b.visible = false;
  main.Boundaries.add(b);
  
  header = new Window(0,0,W,20);
  windows.add(header);
  
  footer = new Window(0,H-90,W,90);
  windows.add(footer);
  
  header.border = false;
  footer.border = true;
  footer.col = 0;
  
  fmenu = new Window(200,200,200,200,"C:\\Users\\paul goux\\");
};

void setupMenus(){
  // file----------------------------------------------
  
  
  String [] flabels = {"Open","Save","Grid","Plot 2D","Plot 3D","Attractor","Reset"};
  file = new Menu(0,0,30,40,"File",flabels,0);
  
  menus.add(file);
  

  //----------------------file -----------------------------------
  if(file!=null){
  String []glabels = {"Terrain","Img","Cam","Video","Audio","Text"};
  file.items.get(2).submenu  = new Menu(file.items.get(2).x+file.items.get(2).w,file.items.get(2).y,70,glabels,0);
  file.set_link(2);
  String [] attractor_labels = {"Show/Hide","On/Off"};
  file.items.get(5).submenu = new Menu(file.items.get(5).x+file.items.get(5).w,file.items.get(5).y,100,attractor_labels,0);
  file.set_link(5);
  }
  //-------------------------------------------------------------------
  String [] shapesLabels = {"Line drawing","Connected Lines","Ellipse","Rectangle","Tri","Poligon","C Poligon","Bezier","Spline","none","Arc","Path Straight","Path Corner"};
  shapes = new Menu(file.x + file.w,0,50,40,"Shapes",shapesLabels,0);
  menus.add(shapes);

  //-------------------------------------------------------------------------------------------
  //physics------------------------------------------------------------------------
  String [] physicsLabels = {"Physics","Gravity","Electromagnetism","Strong","Weak"};
  physics = new Menu(shapes.x + shapes.w,0,50,40,"Physics",physicsLabels,0);
  menus.add(physics);
  //Map--------------------------------------------------------------------
  
  String []mapLabels = {"Humans","Plants","Animals","Minerals","Metals"};
  
  mapMenu = new Menu(physics.x+physics.w,0,40,40,"Maps",mapLabels,0);
  menus.add(mapMenu);

  //---------------------------------------------------------------------------
  
  String [] neuralNetworkMenuLabels = {"Open","Close","Simple"};
  //file.horizontal = false;
  neuralNetworkMenu = new Menu(mapMenu.x+mapMenu.w,mapMenu.y,90,40,"Neural Network",neuralNetworkMenuLabels,0);
  menus.add(neuralNetworkMenu);
  String [] twitterMenuLabels = {"Stream","Show Keywords","Add Keyword","Stream To File","Open Saved Stream"};
  //file.horizontal = false;
  twitter = new Menu(neuralNetworkMenu.x+neuralNetworkMenu.w,neuralNetworkMenu.y,60,40,"Twitter",twitterMenuLabels,0);
  menus.add(twitter);
  
  
  file.set(6,0);

  
};

void setupRGB(){
  //rgb_slider = new rgb_Slider(500,200,90,40,15);
  //rgb_slider.display("vertical");
  //rgb_slider.set("color");
  //rgb_slider.set("radio");
};


void setupReset(){
  reset_dialogue = new Menu(W/2 - 136,H/2 - 22,275,45,"Are you sure you want to exit?");
  reset_dialogue.visible = true;
  reset_dialogue.highlightable = false;
  reset_dialogue.free = true;
  yes = new Button(W/2 - 136 ,H/2 +2,reset_dialogue.w/2,20,"Yes");
  yes.border = false;
  yes.togglebox = true;
  
  no = new Button(yes.x + yes.w,H/2 +2,reset_dialogue.w/2,20,"No");
  no.border = false;
  no.togglebox = true;
  
  reset_dialogue.items.add(yes);
  reset_dialogue.items.add(no);
  yes.parent = reset_dialogue;
  no.parent = reset_dialogue;
};


void loadImg(){
    
};

void run(){
  globalLogic();
  mainFunctions();
  displayButtons();
  menuFunctions();
  //neuralnet.run(100);
  //bb.draw3();
  //dd.displayDropdown();
  //checkbox.draw();
};

void displayButtons(){
  for(int i=0;i<buttons.size();i++){
    Button b = buttons.get(i);
    
    b.draw();
    b.highlight();
  };
};



void mainFunctions(){
  main.render();
};


void displayTextBoxes(){
  for(TextArea textb : textboxes){
    //textb.draw();
  }
  
  for(TextBox textb : textb){
    //textb.draw();
  }
};

void manageClipBoard(){
  //if(getTextFromClipboard ()!=clipBoard)clipBoard = getTextFromClipboard ();
};

void click(){
  buttons();
};

void reload(){
  if(buttons.get(0).toggle==1&&!updated){
    frameCount = -1;
    updated = true;
  }
};

void buttons(){
  
  file.self_toggle(6);
  yes.self_Toggle();
  no.self_Toggle();
  String [] gridm = {"forward","backward","pause"};
  Menu grid = file.items.get(2).submenu;
  Menu attractor = file.items.get(5).submenu;
  
  

  //----------Shapes------------------------
  String [] shapes_bool = {"toggle","connectedlines","circle","square","tri","bezier","none"};
  
  // for(int i=0;i<shapes_bool.length;i++){
  //   shapes.sptoggle(i,main,shapes_bool[i],shapes_bool);
  // }
  //shapes.sptoggle(main,shapes_bool);
  shapes.sptoggle(0,main,"toggle",shapes_bool);
  shapes.sptoggle(1,main,"connectedlines",shapes_bool);
  shapes.sptoggle(2,main,"circle",shapes_bool);
  shapes.sptoggle(3,main,"square",shapes_bool);
  shapes.sptoggle(4,main,"tri",shapes_bool);
  shapes.sptoggle(5,main,"poligon",shapes_bool);
  shapes.sptoggle(6,main,"complex",shapes_bool);
  shapes.sptoggle(7,main,"bezier",shapes_bool);
  shapes.sptoggle(8,main,"spline",shapes_bool);
  shapes.sptoggle(9,main,"none",shapes_bool);
  shapes.sptoggle(11,main,"path",shapes_bool);
  
  String [] ld = {"draw","edit"};
  
  main.pallete.toggle(0,main,"fill");
  main.pallete.toggle(1,main,"gravity");
  main.pallete.toggle(2,main,"friction");
  main.pallete.toggle(3,main,"velocity");
  main.pallete.toggle(4,main,"connect");
  main.pallete.toggle(5,main,"amendBoundary");
  main.pallete.toggle(6,main,"amendInnerBoundary");
  main.pallete.toggle(7,main,"amendAvoidance");
  main.pallete.toggle(8,main,"amendCohesion");
  main.pallete.toggle(9,main,"followBoundary");
  main.pallete.toggle(10,main,"follow");
  main.pallete.toggle(11,main,"dashed");
  main.pallete.toggle(12,main,"border");
  main.pallete.toggle(13,main,"amendAvoidance");
  main.pallete.toggle(14,main,"showgrid");
  main.pallete.toggle(15,main,"hidemenu");
  main.pallete.sptoggle(16,main,"edit",ld);
  main.pallete.toggle(17,main,"reset");
  //main.complexsub.toggle(0,main,"cfinish");
  
};


void menuFunctions(){
  
  Mcount = 0;
  
  for(int i=0;i<BMS.menus.size();i++){
    
    Menu m = BMS.menus.get(i);
    m.draw();
    
  //   if(m.parent==null&&(m.pos()||m.toggle==1)){Mcount++;}
  //   else if(m.parent!=null&&m.items.size()>0&&m.parent.toggle==1){
  //     for(int j=0;j<m.items.size();j++){
  //       Button b = m.items.get(j);
  //       if(b.pos())Mcount++;
  //     }}
  //     else if(m.sliders.size()>0&&m.parent.toggle==1){
  //     for(int j=0;j<m.sliders.size();j++){
  //       Slider b = m.sliders.get(j);
  //       if(b.pos())Mcount++;
  //     }
  // }
  
  if(Mcount>0)open_menus = true;
  else open_menus = false;
  }
};

void boundariesNscenes(){
  
  //------------------------------------------------------
  //Boundaries--------------------------------------------
};


void autoSave(){
  
  if(autoSave){
    saveText();
  }
  
};

void load(){
  
};

void saveText(){
  
  for(int i=0;i<textBoxes.size();i++){
    TextBox t = textBoxes.get(i);
    
    t.save();
  }
  
  for(int i=0;i<textAreas.size();i++){
    TextArea t = textAreas.get(i);
    
    t.save();
  }
};

void saveSliderBox(){
  
  for(int i=0;i<sliderBoxes.size();i++){
    sliderBox s = sliderBoxes.get(i);
    
    s.save();
  }
};

void saveButtons(){
  
  for(int i=0;i<buttons.size();i++){
    Button b = buttons.get(i);
    
    b.save();
  }
};

void saveMenu(){
  
  for(int i=0;i<menus.size();i++){
    Menu m = menus.get(i);
    
    m.save();
  }
  
  for(int i=0;i<textAreas.size();i++){
    TextArea t = textAreas.get(i);
    
    t.save();
  }
};


void saveTabs(){
  
  for(int i=0;i<tabs.size();i++){
    tab t = tabs.get(i);
    
    t.save();
  }
  
  for(int i=0;i<tabs.size();i++){
    tab t = tabs.get(i);
    
    t.save();
  }
};

void saveImgp(){
  
  for(int i=0;i<textBoxes.size();i++){
    TextBox t = textBoxes.get(i);
    
    t.save();
  }
};

void save(){
  
};

void start(Object o,boolean localVar){
    Field field = null;
    
    String s = "hello";
    
    try{
      //field = o.getClass().getfield(s);
      field = applet.getClass().getField(s); 
      }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }}
    
    void eventListener(){
  
};

void toggle(Object o,String globalVar,boolean localVar){
    Field field = null;
    
    try{
      
      field = applet.getClass().getField(globalVar);
      
      
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }
  
};

void globalLogic(){
  //if(dropDownObject!=null)println(dropDownObject.label);
  if(dropDownObject!=null&&!dropDownObject.dclick){
    dropDownObject = null;
  }
  if(mousePressed) globaldown = true;
  else {
    currentMouseObject = null;
    currentObject = null;
    globaldown = false;
  }

};
  
};
