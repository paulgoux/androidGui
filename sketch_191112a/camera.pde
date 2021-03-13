class Camera{
  KetaiCamera cam ;
  tab settings;
  tab parentTab;
  
  Camera(KetaiCamera cam){
    
    this.cam = cam;
    
    settings = new tab(0,200,200,400,"Settings");
    settings.toggle = true;
    settings.visible = true;
    settings.draggable = true;
    settings.scrollable = true;
    settings.vscroll = true;
    
    //String []s = {"Save","Load","Flash"};
    //Menu menu = new Menu(10,40,100,s);
    String []s = {"Save","Load","Flash"};
    toggleMenu menu = new toggleMenu(0,40,60,s);
    settings.add(menu);
    
    String []s2 = {"Counter","Mult"};
    sliderBox sl1 = new sliderBox(20,120,90,90,10,s2,0);
    sl1.menu.draggable = false;
    sl1.tooltip = null;
    sl1.setFloat(0,0,7);
    sl1.setFloat(1,1,20);
    settings.add(sl1);
    settings.setRadius(10);
    settings.setAlignment("center");
    
    BMS.dock.add(settings);
  };

  void displayCam(){
    
    if(BMS.getToggle(0,1)){
      canvas.beginDraw();
      if (frameCount>10&&!cam.isStarted()){cam.start();}
      //settings.selfToggle(0,2);
      //settings.selfToggle(0,1);
      //settings.setValue(0,1,1,20);
      mult = settings.getValue(0,1);
      //settings.setValue(0,0,0,7);
      counter = floor(settings.getValue(0,0));
      //mult = 1.0;
      //counter = 1.0;
      edges.set("mult",mult);
      edges.set("type",counter);
      canvas.shader(edges);
      canvas.fill(0);
      canvas.rect(0,0,width,height);
      canvas.imageMode(CENTER);
      canvas.image(cam, width/2, height/2+20);
      canvas.imageMode(CORNER);
      canvas.fill(0);
      canvas.rect(0,0,width,20);
      canvas.endDraw();
      image(canvas,0,0);
    }
    camLogic();
  };
  
  void displayCam(PGraphics canvas){
    
    if(BMS.getToggle(0,1)){
      canvas.beginDraw();
      if (frameCount>10&&!cam.isStarted()){cam.start();}
      //settings.selfToggle(0,2);
      //settings.selfToggle(0,1);
      //settings.setValue(0,1,1,20);
      mult = settings.getValue(0,1);
      //settings.setValue(0,0,0,7);
      counter = floor(settings.getValue(0,0));
      //mult = 1.0;
      //counter = 1.0;
      edges.set("mult",mult);
      edges.set("type",counter);
      canvas.shader(edges);
      canvas.fill(0);
      canvas.rect(0,0,width,height);
      canvas.imageMode(CENTER);
      canvas.image(cam, width/2, height/2+20);
      canvas.imageMode(CORNER);
      canvas.fill(0);
      canvas.rect(0,0,width,20);
      canvas.endDraw();
      image(canvas,0,0);
    }
    camLogic(parentTab.canvas);
  };

  void camLogic(){
    BMS.selfToggle(0,1);
    if(BMS.getToggle(0,1)){
      //settings.selfToggle(0,2);
      if (!settings.getToggleMenu(0,2)) {
          if (cam.isFlashEnabled())
            cam.disableFlash();
        }else cam.enableFlash();
    }else if(cam.isFlashEnabled())cam.disableFlash();
    
    
    if(BMS.getToggle(0,1))
    settings.displayTab();
    settings.sliderv.set(0,100);
  };
  
  void camLogic(PGraphics canvas){
    BMS.selfToggle(0,1);
    if(BMS.getToggle(0,1)){
      //settings.selfToggle(0,2);
      if (!settings.getToggleMenu(0,2)) {
          if (cam.isFlashEnabled())
            cam.disableFlash();
        }else cam.enableFlash();
    }else if(cam.isFlashEnabled())cam.disableFlash();
    
    
    if(BMS.getToggle(0,1))
    settings.displayTab(canvas);
    settings.sliderv.set(0,100);
  };
  
  void read(){
    if(BMS.getToggle(0,1))cam.read();
  };
};
