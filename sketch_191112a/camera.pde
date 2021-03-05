void displayCam(){
  if(BMS.menus.get(0).items.get(1).toggle==1){
    canvas.beginDraw();
    if (frameCount>10&&!cam.isStarted()){cam.start();}
    mult = BMS.Sliders.get(0).value;
    counter = BMS.Sliders.get(1).value;
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
};
