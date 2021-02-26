 class Boundary{
  
  float x1,x2,y1,y2,w,h,x3,y3,size = 1,x4,y4,D1,D2,T1,T2,collision_index,menux,menuy,deltamx,deltamy,tacx,tacy,dir;
  float x,y,bx = x,by = y;
  public float mass,vx,vy,ax,ay,density,friction_u,momentum,bax ,bay,pathWidth=20,gconst = 0.1,floor = 590,rtheta = 0,avoidance,cohesion,broom;
  PVector p1,midpoint1,midpoint2,midpoint3,m = new PVector(0,0);
  PVector p2,p3,p4,center = new PVector(-1,-1),vel,ac,rotatep;
  int key1,key2,type,t,t2,vert,vert1,vert3,trit,id,index,lindex,sindex,ccount,sid,vcount,hcount,uindex = -1,counter,tpoints,mcount,sides,shapeIndex,lineIndex,lcount,pcount,options = -1,numm,state,state1=1,gid;
  public int cols = 40,rows = 25;
  public boolean toggle = false,mdown,mup = true,circle,square,bezier,tri,c_poligon,poligon,drag,none,spline,hover,hover2,point1,point2,point3,point4,gravity,hidemenu,clear,edit,complex,cstart,showgrid,cfinish = false,border,fill,hidden,connectedlines,path,avoidBoundary,cohesionBoundary,amendBoundary,amendInnerBoundary, amendCohesion,amendAvoidance,dashed;
  boolean linedown = false,sdown,rtoggle,click,open,dynamic = true,falling = true,rotating,update,lock,pdown,updatep,updateg,tdown,trow,menudown,pointadded,converted,rdown,phover,lhover,contextClick,visible = true;
  float dx,dy,Theta,Norm;
  color col = color(255),bg = color(0,180);
  ArrayList<Integer> indices = new ArrayList<Integer>();
  ArrayList<Button> Buttons = new ArrayList<Button>();
  ArrayList<Boundary> Boundaries = new ArrayList<Boundary>();
  ArrayList<Boundary> innerBoundaries = new ArrayList<Boundary>();
  ArrayList<Boundary> outerBoundaries = new ArrayList<Boundary>();
  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<PVector> rotation_points = new ArrayList<PVector>();
  Scene scene;
  ArrayList<Scene> scenes = new ArrayList<Scene>();
  Boundary parent;
  Boundary child;
  PShape bpath;
  ArrayList<PShape> paths = new ArrayList<PShape>();
  ArrayList<Float[]> velocity = new ArrayList<Float[]>();
  ArrayList<PVector> velocitypv = new ArrayList<PVector>();
  ArrayList<Boundary> Quadrants = new ArrayList<Boundary>();
  ArrayList<PVector> Midpoints = new ArrayList<PVector>();
  ArrayList<PVector> collision_array = new ArrayList<PVector>();
  //ArrayList<PVector> Midpoints = new ArrayList<PVector>();
  
  String []contextlabels = {"Undo","Redo"};
  String []contextDellabels = {"Delete Point","Cancel","Shape"};
  String []palletelabels = {"Fill","Gravity","Friction","Velocity","Connect","Amend B","Amend iB","Avoid","Seek",
                            "Follow","Dashed","Border","Clear","Visible","Grid","Hide","Edit","Reset"};
  String []complexmenu = {"Finish"};
  String []convertmenu = {"Convert","Delete Shape","Shape"};
  String []connectedlMenul = {"Convert","Delete Line","Delete Shape","Shape"};
  
  Menu palletehide,context,contextDel,pallete,complexsub,convertToPath,connectedlMenu;
  String [] settingsLabel = {"Cohesion","Separation","B room"};
  sliderBox settings;
  
  TextBox Sides = new TextBox (W-200,H-200,20,20,5,"Sides");
  ArrayList<Float> norm = new ArrayList<Float>();
  ArrayList<Float[]> mdist = new ArrayList<Float[]>();
  ArrayList<Float[]> pdist = new ArrayList<Float[]>();
  ArrayList<Float> dist = new ArrayList<Float>();
  ArrayList<Integer> types = new ArrayList<Integer>();
  ArrayList<Float> theta = new ArrayList<Float>();
  ArrayList<Float> mtheta = new ArrayList<Float>();
  ArrayList<PVector> temp = new ArrayList<PVector>();
  ArrayList<ArrayList> polytemp = new ArrayList<ArrayList>();
  HashMap<String,Boolean> values = new HashMap<String,Boolean>();
  
  PVector polymidpoint = new PVector(0,0);
  Grid gridlayout;
  ArrayList<Point> grid = new ArrayList<Point>();
  ArrayList<Point> ugrid = new ArrayList<Point>();
  ArrayList<Point> ogrid = new ArrayList<Point>();
  
  tab palleteTab;
  Boundary(){
    
    palletehide = new Menu(0,200+300/2 - 100,20,50);
    context = new Menu(mouseX,mouseY,90,contextlabels);
    contextDel = new Menu(mouseX,mouseY,90,contextDellabels);
    pallete = new Menu(0,200,90,palletelabels,0);
    complexsub = new Menu(W-200,H-200,90,complexmenu);
    convertToPath = new Menu(mouseX,mouseY,90,convertmenu);
    connectedlMenu = new Menu(mouseX,mouseY,90,connectedlMenul);
    settings = new sliderBox(mouseX,mouseY,90,5,settingsLabel);
    settings.menu.draggable = false;
    settings.tooltip.visible = false;
    type = -1;
    
    setupPallete();
    
  };
  
  Boundary(float X1, float Y1,float X2, float Y2){
    
    x1 = X1;
    y1 = Y1;
    x2 = X2;
    y2 = Y2;
    type = 2;
    p1 = new PVector(x1,y1);
    p2 = new PVector(x2,y2);
    center = new PVector((x1+x2)/2,(y1+y2)/2);
    
  };
  
  Boundary(float X1, float Y1,float ww,float hh,int Type){
    
    float t1 = 0;
    x1 = X1;
    y1 = Y1;
    w = ww;
    h = hh;
    
    Float [] d1 = {0.0,0.0};
    Float [] vel = {0.0,0.0};
    
    if(Type==0){
    
    x1 = X1;
    y1 = Y1;
    w = ww;
    h = hh;
    x2 = x1 + ww;
    y2 = y1 + hh;
    
    type = 0;
    center = new PVector((x1+x2)/2,(y1+y2)/2);
    d1[0] = center.x - x1;
    d1[1] = center.y - y1;
    pdist.add(d1);
    t1 = atan2(y1-center.y,x1-center.x);
    theta.add(t1);
    d1[0] = center.x - x2;
    d1[1] = center.y - y2;
    pdist.add(d1);
    t1 = atan2(y2-center.y,x2-center.x);
    theta.add(t1);
    
    }
    
    if(Type==2){
    x1 = X1;
    y1 = Y1;
    x2 = ww;
    y2 = hh;
    
    type = 2;
    center = new PVector((x1+x2)/2,(y1+y2)/2);
    Boundaries.add(new Boundary(x1,y1,x2,y2));
    d1[0] = center.x - x1;
    d1[1] = center.y - y1;
    pdist.add(d1);
    t1 = atan2(y1-center.y,x1-center.x);
    theta.add(t1);
    d1[0] = center.x - x2;
    d1[1] = center.y - y2;
    pdist.add(d1);
    t1 = atan2(y2-center.y,x2-center.x);
    theta.add(t1);
    velocity.add(vel);
    create_rotation_points(Boundaries);
    create_points(Boundaries);
    
    }
    
    if(Type==0||Type==2){
      center = new PVector((x1+x2)/2,(y1+y2)/2);
    }
    
    if(Type==3){
    
    w = dist(x1,y1,ww,hh);
    h = dist(x1,y1,ww,hh);
    
    Norm = -atan2(x1 - ww,y1 - hh);
    
    x2 = ww + w/1.5 * cos(Norm);
    y2 = hh + h/1.5 * sin(Norm);
    x3 = ww - w/1.5 * cos(Norm);
    y3 = hh - h/1.5 * sin(Norm);
    
    center = new PVector((x1+x2+x3)/3,(y1+y2+y3)/3);
    Boundaries.add(new Boundary(x1,y1,x2,y2));
    velocity.add(vel);
      d1[0] = center.x - x1;
      d1[1] = center.y - y1;
      pdist.add(d1);
      t1 = atan2(y1-center.y,x1-center.x);
      theta.add(t1);
    midpoint1 = new PVector((x1 + x2)/2,(y1 + y2)/2);
    Boundaries.add(new Boundary(x2 , y2 ,x3 , y3));
     d1[0] = center.x - x2;
     d1[1] = center.y - y2;
     pdist.add(d1);
     t1 = atan2(y2-center.y,x2-center.x);
     theta.add(t1);
    midpoint2 = new PVector((x2 + x3)/2,(y2 + y3)/2);
    velocity.add(vel);
    Boundaries.add(new Boundary(x3, y3,x1,y1 ));
      d1[0] = center.x - x3;
      d1[1] = center.y - y3;
      pdist.add(d1);
      t1 = atan2(y3-center.y,x3-center.x);
      theta.add(t1);
    velocity.add(vel);
    midpoint3 = new PVector((x3 + x1)/2,(y3 + y1)/2);
    type = 3;
    create_rotation_points(Boundaries);
    create_points(Boundaries);
    
    }
    
    if(Type==4){
      
    x2 = x1 + ww;
    y2 = y1;
    x3 = x1 + ww;
    y3 = y1 + hh;
    x4 = x1;
    y4 = y1 + hh;
    
    center = new PVector((x1+x2+x3+x4)/4,(y1+y2+y3+y4)/4);
    Boundaries.add(new Boundary(x1,y1,x2,y2));
    velocity.add(vel);
      d1[0] = center.x - x1;
      d1[1] = center.y - y1;
      pdist.add(d1);
      t1 = atan2(y1-center.y,x1-center.x);
      theta.add(t1);
    Boundaries.add(new Boundary(x2,y2,x3,y3));
    velocity.add(vel);
      d1[0] = center.x - x2;
      d1[1] = center.y - y2;
      pdist.add(d1);
      t1 = atan2(y2-center.y,x2-center.x);
      theta.add(t1);
    Boundaries.add(new Boundary(x3,y3,x4,y4));
    velocity.add(vel);
      d1[0] = center.x - x3;
      d1[1] = center.y - y3;
      pdist.add(d1);
      t1 = atan2(y3-center.y,x3-center.x);
      theta.add(t1);
    Boundaries.add(new Boundary(x4,y4,x1,y1));
    velocity.add(vel);
      d1[0] = center.x - x4;
      d1[1] = center.y - y4;
      pdist.add(d1);
      t1 = atan2(y4-center.y,x4-center.x);
      theta.add(t1);

    center = new PVector((x1+x2+x3+x4)/4,(y1+y2+y3+y4)/4);
    type = 4;
    }
    
    if(Type==103){
      
    Norm = -atan2(x1 - ww,y1 - hh);
    
    x2 = x1 + w/2 ;
    y2 = y1 + h ;
    x3 = x1 - w/2 ;
    y3 = y1 + h ;
    center = new PVector((x1+x2+x3)/3,(y1+y2+y3)/3);
    Boundaries.add(new Boundary(x1,y1,x2,y2));
    velocity.add(vel);
      d1[0] = center.x - x1;
      d1[1] = center.y - y1;
      pdist.add(d1);
      t1 = atan2(y1-center.y,x1-center.x);
      theta.add(t1);
    midpoint1 = new PVector((x1 + x2)/2,(y1 + y2)/2);
    Boundaries.add(new Boundary(x2 , y2 ,x3 , y3));
     d1[0] = center.x - x2;
     d1[1] = center.y - y2;
     pdist.add(d1);
     t1 = atan2(y2-center.y,x2-center.x);
     theta.add(t1);
    midpoint2 = new PVector((x2 + x3)/2,(y2 + y3)/2);
    velocity.add(vel);
    Boundaries.add(new Boundary(x3, y3,x1,y1 ));
      d1[0] = center.x - x3;
      d1[1] = center.y - y3;
      pdist.add(d1);
      t1 = atan2(y3-center.y,x3-center.x);
      theta.add(t1);
    velocity.add(vel);
    midpoint3 = new PVector((x3 + x1)/2,(y3 + y1)/2);
    type = 3;
    create_points(Boundaries);
    
    }
    
    type = Type;
    create_points(Boundaries);
    create_dist();
    create_angles(Boundaries);
    create_rotation_points(Boundaries);
  };
  
  Boundary (float X1, float Y1,float X2,float Y2,float X3, float Y3){

    x1 = X1;
    y1 = Y1;
    x2 = X2;
    y2 = Y2;
    x3 = X3;
    y3 = Y3;
    type = 3;
  };
  
  Boundary(PVector A, PVector B,PVector C){

    p1 = A;
    p2 = B;
    p3 = C;
    x1 = p1.x;
    y1 = p1.y;
    x2 = p2.x;
    y2 = p2.y;
    type = 3;
  };
  
  Boundary(PVector A, PVector B){

    p1 = A;
    p2 = B;
    x1 = p1.x;
    y1 = p1.y;
    x2 = p2.x;
    y2 = p2.y;
  };
  
  Boundary(ArrayList<Point> A){
  
   center = new PVector (0,0);
    for(int i=0;i<A.size();i++){
      
      Point a = A.get(i);
      Point b = A.get(i);
      
      if(i<A.size()-1)b = A.get(i+1);
      else b = A.get(0);
      Boundary B = new Boundary(a.x,a.y,b.x,b.y,2);
      Boundaries.add(B);
      
    }
    
      calc_center();
      create_points(Boundaries);
      create_dist();
      create_angles(Boundaries);
      create_rotation_points(Boundaries);
      type = 105;
  };
  
  Boundary(ArrayList<Point> A,int k){
  
   center = new PVector (0,0);
    for(int i=0;i<A.size();i++){
      
      Point a = A.get(i);
      Point b = null;
      Point c = null;
      
      if(i+2<A.size()){
       b = A.get(i+1);
       c = A.get(i+2);
      
      if(((b.x==a.x)&&(c.x==a.x)||b.y==a.y&&(c.y==a.y))){
        A.remove(i+1);
        i--;
        
      }else{
        Boundary B = new Boundary(a.x,a.y,b.x,b.y,2);
        Boundaries.add(B);
      }}else if(i+1<A.size()){
        b = A.get(i+1);
        Boundary B = new Boundary(a.x,a.y,b.x,b.y,2);
        Boundaries.add(B);
      }}
    
      calc_center();
      create_points(Boundaries);
      create_dist();
      create_angles(Boundaries);
      create_rotation_points(Boundaries);
      type = 106;
  };
  
  Boundary(Boundary B){
   
   //Boundaries = B.Boundaries;
   
   if(B.type==106){
     
   float pw = pathWidth; 
   
   center = new PVector (0,0);
   
   Boundary b0 = B.Boundaries.get(0);
   
   PVector p0 = new PVector(b0.x1,b0.y1);
   PVector p1 = new PVector(b0.x2,b0.y2);
   
   float t = -atan2(p0.x-p1.x,p0.y-p1.y);
   
   PVector p2 =  new PVector(p0.x+pw*cos(t),p0.y+pw*sin(t));
   PVector p3 =  new PVector(p0.x-pw*cos(t),p0.y-pw*sin(t));
   
   Boundary b = new Boundary(p1,p2);
   
   Boundaries.add(b);
   
    for(int i=1;i<B.Boundaries.size()-1;i++){
      
      b = B.Boundaries.get(i);
      
      Boundary b1 = B.Boundaries.get(i-1);
      Boundary b2 = B.Boundaries.get(i+1);
      
      p0 = new PVector(b.x1,b.y1);
      p1 = new PVector(b1.x2,b1.y2);
      
      p2 = new PVector(b2.x2,b2.y2);
      p3 = new PVector();
      
      float t1 = atan2(p0.y-p1.y,p0.x-p1.x);
      float t2 = atan2(p0.y-p2.y,p0.x-p2.x);
      
      t = -1/((t1+t2)/2);
      
      PVector p4 = new PVector(p0.x+pw*cos(t),p0.y+pw*sin(t));
      PVector p5 = new PVector(p1.x+pw*cos(t),p1.y+pw*sin(t));
      
      Boundaries.add(new Boundary(p4.x,p4.y,p5.x,p5.y));
      
      }
      
      b0 =  B.Boundaries.get(B.Boundaries.size()-1);
      p0 = new PVector(b0.x1,b0.y1);
     
      t = radians(90);
      p1 =  new PVector(p0.x+pw*cos(t),p0.y+pw*sin(t));
      p2 =  new PVector(p0.x-pw*cos(t),p0.y-pw*sin(t));
     
      b = new Boundary(p1,p2);
     
      Boundaries.add(b);
      
      for(int i=B.Boundaries.size()-1;i>-1;i--){
      
      b = B.Boundaries.get(i);
      Boundary b1 = B.Boundaries.get(i-1);
      Boundary b2 = B.Boundaries.get(i+1);
      
      p0 = new PVector(b.x1,b.y1);
      p1 = new PVector(b1.x2,b1.y2);
      
      p2 = new PVector(b2.x2,b2.y2);
      p3 = new PVector();
      
      float t1 = atan2(p0.y-p1.y,p0.x-p1.x);
      float t2 = atan2(p0.y-p2.y,p0.x-p2.x);
      
      t = -1/((t1+t2)/2);
      
      PVector p4 = new PVector(p0.x-pw*cos(t),p0.y-pw*sin(t));
      PVector p5 = new PVector(p1.x-pw*cos(t),p1.y-pw*sin(t));
      
      Boundaries.add(new Boundary(p4.x,p4.y,p5.x,p5.y));
      
      }
    
      calc_center();
      create_points(Boundaries);
      create_dist();
      create_angles(Boundaries);
      create_rotation_points(Boundaries);
      type = 107;
      
   }else if(B.type!=0){
     
     float pw = pathWidth; 
   
      center = B.center;
      calcInner(B);
      calcOuter(B);
    
      create_points(innerBoundaries);
      create_points(outerBoundaries);
      create_angles(innerBoundaries);
      create_angles(outerBoundaries);
      create_rotation_points(innerBoundaries);
      create_rotation_points(outerBoundaries);
      type = 107;
   }else {
     
   }
  };
  
  Point getNextPoint(ArrayList<Point> a,Point b){
    Point c = null;
    for(int i=0;i<a.size();i++){
      Point d = a.get(i);
      if(d.x!=b.x&&d.y!=b.y)c = d; 
    }
    
    return c;
  };
  
  void debug(){
    fill(255);
  };
  
  void calcInner(Boundary a){
    if(a.type==0){
      
    }else if(a.type!=0&&a.type!=106){
      
      float pw = a.pathWidth;
      
    for(int i=0;i<a.Boundaries.size();i++){
      Boundary b = a.Boundaries.get(i);
      Boundary b1 = a.Boundaries.get(i);
      
      if(i<a.Boundaries.size()-1)b1 = a.Boundaries.get(i+1);
      else b1 = a.Boundaries.get(0);
      
      PVector p = new PVector(b.x1,b.y1);
      PVector p1 = new PVector(b.x2,b.y2);
      
      float t = atan2(a.center.y-p.y,a.center.x-p.x);
      float d = dist(p.x,p.y,a.center.x,a.center.y);
      
      float t1 = atan2(a.center.y-p1.y,a.center.x-p1.x);
      float d1 = dist(p1.x,p1.y,a.center.x,a.center.y);
      
      PVector p2 = new PVector(a.center.x+(d-pw)*cos(t),a.center.y+(d-pw)*sin(t));
      PVector p3 = new PVector(a.center.x+(d1-pw)*cos(t1),a.center.y+(d1-pw)*sin(t1));
      
      
      //a.innerBoundaries.add(new Boundary(p2.x,p2.y,p3.x,p3.y));
      //a.outerBoundaries.add(new Boundary(p2.x,p2.y,p3.x,p3.y));
    }a.type = 107;}else{
      
    }
    
  };
  
  void calcOuter(Boundary a){
    if(a.type==0){
      
    }else if(a.type!=0&&a.type!=106){
      
      float pw = a.pathWidth;
      
    for(int i=0;i<a.Boundaries.size();i++){
      Boundary b = a.Boundaries.get(i);
      Boundary b1 = a.Boundaries.get(i);
      
      if(i<a.Boundaries.size()-1)b1 = a.Boundaries.get(i+1);
      else b1 = a.Boundaries.get(0);
      
      PVector p = new PVector(b.x1,b.y1);
      PVector p1 = new PVector(b1.x1,b1.y1);
      
      float t = atan2(a.center.y-p.y,a.center.x-p.x)-PI;
      float d = dist(p.x,p.y,a.center.x,a.center.y);
      
      float t1 = atan2(a.center.y-p1.y,a.center.x-p1.x)-PI;
      float d1 = dist(p1.x,p1.y,a.center.x,a.center.y) ;
      
      PVector p2 = new PVector(a.center.x+(d+pw)*cos(t),a.center.y+(d+pw)*sin(t));
      PVector p3 = new PVector(a.center.x+(d1+pw)*cos(t1),a.center.y+(d1+pw)*sin(t1));
      
      PVector p4 = new PVector(a.center.x+(d)*cos(t) - pw*cos(t),a.center.y+(d)*sin(t) - pw*sin(t));
      PVector p5 = new PVector(a.center.x+(d1)*cos(t1) - pw*cos(t),a.center.y+(d1)*sin(t1) - pw*sin(t));
      
      a.innerBoundaries.add(new Boundary(p4.x,p4.y,p5.x,p5.y));
      a.outerBoundaries.add(new Boundary(p2.x,p2.y,p3.x,p3.y));
    }a.type = 107;}else{
      
    }
  };
  
  void setupPallete(){
    if(type==-1){
    palleteTab = new tab(25,H-70,W-50,70,this);
    palleteTab.scrollable = true;
    palleteTab.states.get(0).scrollable = true;
    //palleteTab.toggle=true;
    palleteTab.visible = true;
    palleteTab.sliderh.visible = false;
    palleteTab.sliderv.valuex = 0;
    palleteTab.sliderv.h +=20;
    //palleteTab.states.remove(1);
    }
  };
  
  void save(){
    
  };
  
  void load(){
    
  };
  
  void draw(){
      if((open||none))palleteTab.displayTab();
      
      
     hcount = 0;lcount = 0;pcount = 0;
     boolean lineHover = false;
     int k = -1;
     fill(255);
     
     if(mouseX>0)m.x = mouseX;
     if(mouseY>0)m.y = mouseY;
    if(!clear){
    //for(int i=Boundaries.size()-1;i>-1;i--){
      for(int i=1;i<Boundaries.size();i++){
      Boundary b = Boundaries.get(i);
      
      b.id = i;
      if(!b.visible&&pos(b,m)){
        if(visible&&mousePressed&&mouseButton==LEFT)b.visible = true;
      }
      if(b.visible){
      if((edit&&!settings.visible)||(settings.visible&&!settings.pos())){
      if(b.type!=2&&!point1&&!point2&&!linedown&&!rdown)mtranslate(b,m);
      if(!point1&&!point2&&!tdown&&!rdown)move(b,m);
      if((b.type!=0)&&!linedown&&!tdown&&!rdown)pospoint(b);
      if(!point1&&!point2&&!linedown&&!tdown)pos_rotationpoint(b);
      b.update(b);
      }
      
      if(!pospoint(b,0))pcount++;
      
      if(gravity)b.gravity = true;
      else b.gravity = false;
      
      strokeWeight(1);
      if(pos(b,m)){
        //if(
        if(!visible&&mousePressed)b.visible = false;
        if(mousePressed)lineIndex = -1;
        if(amendBoundary){
          fill(255);
          text(b.state,b.x1,b.y1);
                if(mousePressed){
                if(amendCohesion&&amendAvoidance)b.state = 1;
                else if(amendCohesion&&!amendAvoidance)b.state = 2;
                else if(!amendCohesion&&amendAvoidance)b.state = 3;
                else if(!amendCohesion&&!amendAvoidance)b.state = 4;
         }}
        indices.add(i);
        if(indices.size()>2)indices.remove(0);
      }
      if(!pos(b,m))hcount ++;
        
        if(b.type==0){
          stroke(0);
          fill(0,50);strokeWeight(1);
          if(pos(b,m)){
            shapeIndex=i;
            fill(255,50);
          }
          ellipseMode(CENTER);
          ellipse(b.center.x,b.center.y,b.w,b.h);
        }else if(b.type!=107){
          
          if(b.type!=106)fill(0,50);
          else noFill();
          if(pos(b,m)){
            shapeIndex=i; 
            fill(255,50);
            if(mousePressed)lineIndex = -1;
          }
          stroke(0);
          beginShape();
          
          for(int j=0;j<b.Boundaries.size();j++){
            Boundary c = b.Boundaries.get(j);
            
            vertex(c.x1,c.y1);
            vertex(c.x2,c.y2);
          }}}
          if(b.type==106)endShape();
          else if(b.type!=107)endShape(CLOSE);
          
          if(b.type==107){
            
            //if(!b.converted){
              
          b.bpath = createShape();
          //---------------begin shape------------------------------------
          beginShape();
          fill(0,150);
          stroke(0);
          strokeWeight(1);
          //-------------exterior------------------------------------
          
          for(int j=0;j<b.outerBoundaries.size()-1;j++){
            
            Boundary c = b.outerBoundaries.get(j);
            Boundary c1 = b.outerBoundaries.get(j+1);
            
            vertex(c.x1,c.y1);
            vertex(c1.x1,c1.y1);
            
            
            
            if(pos(c,m)){
              if(amendInnerBoundary){
                if(mousePressed){
                     lineIndex = -1;
                     if(amendCohesion&&amendAvoidance)c.state1 = 1;
                else if(amendCohesion&&!amendAvoidance)c.state1 = 2;
                else if(!amendCohesion&&amendAvoidance)c.state1 = 3;
                else if(!amendCohesion&&!amendAvoidance)c.state1 = 4;
              }}
              if(c.state1==3)stroke(255,0,0);
              else if(c.state1==2)stroke(0,0,255);
              else if(c.state1==1)stroke(0,255,0);
              line(c.x1,c.y1,c.x2,c.y2);
              lineHover = true;
              k = j;
          }}
          //------------interior------------------------------------
          beginContour();
          
          for(int j=b.innerBoundaries.size()-1;j>0;j--){
            
            Boundary c = b.innerBoundaries.get(j);
            Boundary c1 = b.innerBoundaries.get(j-1);
            
            vertex(c.x1,c.y1);
            vertex(c1.x1,c1.y1);
            if(pos(c,m)){
              if(amendInnerBoundary){
                if(mousePressed){
                     lineIndex = -1;
                     if(amendCohesion&&amendAvoidance)c.state1 = 1;
                else if(amendCohesion&&!amendAvoidance)c.state1 = 2;
                else if(!amendCohesion&&amendAvoidance)c.state1 = 3;
                else if(!amendCohesion&&!amendAvoidance)c.state1 = 4;
              }}
              if(c.state1==3)stroke(255,0,0);
              else if(c.state1==2)stroke(0,0,255);
              else if(c.state1==1)stroke(0,255,0);
              line(c.x1,c.y1,c.x2,c.y2);
              lineHover = true;
              k = j;
          }}
          //for(int j=0;j<b.innerBoundaries.size()-1;j++){
            
          //  Boundary c = b.innerBoundaries.get(j);
          //  Boundary c1 = b.innerBoundaries.get(j+1);
            
          //  vertex(c.x1,c.y1);
          //  vertex(c.x2,c.y2);
          //  //vertex(c1.x1,c.y1);
          //}
            endContour();
            //----------end shape------------------------------------
            endShape(CLOSE);
            //b.converted = true;
            //shape(b.bpath);
          //}
            //else shape(b.bpath);
          }
        if(!clear){
          
          for(int j=0;j<b.Boundaries.size();j++){
        
            Boundary c = b.Boundaries.get(j);
            lineHover = false;
            
            if(pos(c,m)){
              lineIndex = j;
              
              if(amendInnerBoundary){
                if(mousePressed){
                     if(amendCohesion&&amendAvoidance)c.state1 = 1;
                else if(amendCohesion&&!amendAvoidance)c.state1 = 2;
                else if(!amendCohesion&&amendAvoidance)c.state1 = 3;
                else if(!amendCohesion&&!amendAvoidance)c.state1 = 4;
              }}
              if(c.state1==3)stroke(255,0,0);
              else if(c.state1==2)stroke(0,0,255);
              else if(c.state1==1)stroke(0,255,0);
              line(c.x1,c.y1,c.x2,c.y2);
              lineHover = true;
              k = j;
          }}
          lindex = k;
          
          if(lineHover&&shapeIndex==-1)shapeIndex = i;
          else lcount++;
        }}
          if(hcount>0) hover2 = true;
          else hover2  = false;
    }
    rmenu();
    int n = Boundaries.size();
    if(pcount==0)phover = false;
    if(lcount==0){lhover = false;lineIndex = -1;}
    if(hcount==n&&lcount==n&&pcount==n)shapeIndex=-1;
    if(clear)clear();
    
    
  };
  
  void clear(){
    //Boundary a = Boundaries.get(0);
      //Boundaries = new ArrayList<Boundary>();
      //Boundaries.add(a);
      lineIndex = -1;
      shapeIndex = -1;
      palleteTab = null;
      setupPallete();
      for (int i=Boundaries.size()-1;i>0;i--)Boundaries.remove(i);
      clear = false;
  };
  
  void draw2(){
    logic();
    debug();
    
    strokeWeight(1);
    for(int i=0;i<Boundaries.size();i++){
      Boundary b = Boundaries.get(i);
      b.id = i;
      move(b,m);
      beginShape();
      stroke(0);
      vertex(b.x1,b.y1);
      vertex(b.x2,b.y2);
      endShape(CLOSE);
    }
  };

  void draw3(){
    strokeWeight(1);
    stroke(col);
    // for(int i=0;i<Boundaries.size();i++){
    //   Boundary b = Boundaries.get(i);
    //   b.id = i;
    //   line(b.x1,b.y1,b.x2,b.y2);
    // }
    // vertex(x1,y1);
    // vertex(x2,y2);
    line(x1,y1,x2,y2);
  };

  void drawLine(){
    strokeWeight(1);
    stroke(0);
    line(x1,y1,x2,y2);
  };
  
  void trace(){
    
    //scene.draw(9);
    
  };
  
  void rmenu(){
    logic();
    
    if(clear){
       shapeIndex = -1;
       lineIndex = -1;
     }
      if((open||none)){
        
         settings.visible = false;
       
       if(showgrid){
         if(gridlayout==null){
           gridlayout = new Grid(x+1,y+1,w,h,15);
         }
         //gridlayout.toggle=true;
         ////gridlayout.gridFunctions();
         //gridlayout.displayGridAsLines();
         //gridlayout.terrain2d = true;
         }

       else if(type==-2){
         //gridlayout.toggle=false;
       }
       pallete.draw();
       
       //if(mousePressed&&mouseButton == RIGHT&&!rtoggle){rtoggle = true;}
         //-----------------------------------------------------------------------------
         
         if(mousePressed&&mouseButton==RIGHT&&!rtoggle&&!contextClick)rtoggle=true;
         
         
         if(rtoggle&&edit){
           
         contextDel.visible = false;
         convertToPath.visible = false;
         context.visible = false;
         connectedlMenu.visible = false;
         
         if(shapeIndex==-1)options = 0;
         else {
           if(Boundaries.get(shapeIndex).type==106){
             numm = shapeIndex;
               if(pcount==1)options = 5;
               else if(lcount==pcount) options = 1;
              //else if((pcount<lcount))options = 1;
              //else options = 5;
         }else {
               if(pcount==lcount&&pcount>0)options = 3;
              else if(pcount>lcount)options = 2;
              else if((pcount<lcount))options = 1;
              else options = 4;
         }}
         if(!edit||Boundaries.size()==0)options=4;
         context.x = mouseX;
         context.y = mouseY;
         
         connectedlMenu.x = mouseX;
         connectedlMenu.y = mouseY;
         
         contextDel.x = mouseX;
         contextDel.y = mouseY;
         
         convertToPath.x = mouseX;
         convertToPath.y = mouseY;
         
         
         if(options==1)contextDel.items.get(0).label = "Delete Point";
         else if(options==2)contextDel.items.get(0).label = "Delete Line";
         
         contextDel.items.get(2).label = "Shape : " + shapeIndex + ", " + lineIndex;
         convertToPath.items.get(2).label = "Shape : " + shapeIndex + ", " + lineIndex;
         connectedlMenu.items.get(2).label = "Shape : " + shapeIndex + ", " + lineIndex;
         
         if(!mousePressed){
           contextClick = true;
           rtoggle=false;
         }}
         //------------------------------------------------------------------------------------
         //if(mousePressed&&mouseButton==LEFT)options = 4;
         if(options==0){
           contextDel.visible = false;
           convertToPath.visible = false;
           context.visible = true;
           connectedlMenu.visible = false;
           settings.x = context.x;
           settings.y = context.y+context.h;
           settings.visible = true;
         }
         else if(options==1||options==2){
             contextDel.visible = true;
             convertToPath.visible = false;
             context.visible = false;
             connectedlMenu.visible = false;
             settings.x = contextDel.x;
             settings.y = contextDel.y+contextDel.h;
             settings.visible = true;
           }else if(options==3){
             contextDel.visible = false;
             convertToPath.visible = true;
             context.visible = false;
             connectedlMenu.visible = false;
             settings.x = convertToPath.x;
             settings.y = convertToPath.y+convertToPath.h;
             settings.visible = true;
           }else if(options==4){
             contextDel.visible = false;
             convertToPath.visible = false;
             context.visible = false;
             connectedlMenu.visible = false;
             settings.x = mouseX;
             settings.y = mouseY;
             settings.visible = true;
           }else if(options==5){
             connectedlMenu.visible = true;
             contextDel.visible = false;
             convertToPath.visible = false;
             context.visible = false;
             settings.x = connectedlMenu.x;
             settings.y = connectedlMenu.y+connectedlMenu.h;
             settings.visible = true;
           }
           
         if(contextClick){
         if(contextDel.visible){
           contextDel.draw();
         if(mousePressed&&!contextDel.items.get(0).pos()&&!contextDel.items.get(1).pos()&&!settings.pos()){
                rtoggle=false;
                contextClick=false;
                settings.visible = false;
           }}
         else if(context.visible){
           context.draw();
           if(mousePressed&&!context.items.get(0).pos()&&!context.items.get(1).pos()&&!settings.pos()){
                rtoggle=false;
                contextClick=false;
                settings.visible = false;
           }}
         else if(convertToPath.visible){
            convertToPath.draw();
            //if(mousePressed&&mouseButton==LEFT){
              if(mousePressed&&convertToPath.items.get(1).pos()){
                if(shapeIndex>-1)Boundaries.remove(shapeIndex);
                rtoggle=false;
                contextClick=false;
                settings.visible = false;
           }else if(mousePressed&&convertToPath.items.get(0).pos()){
                calcInner(Boundaries.get(shapeIndex));
                calcOuter(Boundaries.get(shapeIndex));
                
                rtoggle=false;
                contextClick=false;
                settings.visible = false;
           }else if(mousePressed&&!convertToPath.items.get(0).pos()&&!convertToPath.items.get(1).pos()&&!settings.pos()){
                rtoggle=false;
                contextClick=false;
                settings.visible = false;
           }}
           else if(connectedlMenu.visible){
             connectedlMenu.draw();
             
             if(mousePressed&&connectedlMenu.items.get(2).pos()){
                if(numm>-1)Boundaries.remove(numm);
                rtoggle=false;
                contextClick=false;
                settings.visible = false;
           }else if(mousePressed&&connectedlMenu.items.get(0).pos()){
                calcInner(Boundaries.get(numm));
                calcOuter(Boundaries.get(numm));
                
                rtoggle=false;
                contextClick=false;
           }}
         else if (mousePressed&&!settings.pos()){
           contextClick = false;
           rtoggle = false;
       }}}
         
         if(contextClick&&!contextDel.pos()&&context.pos()&&!settings.pos()&&!convertToPath.pos()&&mousePressed){
           contextClick=false;
           rtoggle = false;
         }
       
           
  };
  
  void update(Boundary a){
    float midx = 0;
    float midy = 0;
    
    float aa = 0.05;
    vcount = 0;
    
    //dir = atan2(a.Boundaries.get(0).y1 - center.y,a.Boundaries.get(0).x1 - center.x);
    //line(Boundaries.get(0).x1,Boundaries.get(0).y1,center.x,center.y);
    if(type!=0){
      
      if(!mousePressed){trow = true;}
      
      if(gravity){
        
        //updateg = true;
        if(falling){
          vy += gconst;
          if(vy>=4)vy = 4.0;
          if(vy<=-4)vy = -4.0;
          if(vy>=4)vy = 4.0;
          if(vy<=-4)vy = -4.0;
          center.y += vy;
        }
        if(type!=2){
          update_Boundaries();
          a.update_angles();
          create_rotation_points(Boundaries);
        }else{
          //center.x = (x1+x2)/2;
          //center.y = (y1+y2)/2;
          a.update_line();
        }
        
      }else updateg = false;
    
      for(int i=0;i<Boundaries.size();i++){
        
        Boundary b = Boundaries.get(i);
        
        if(b.y1>=floor)vcount++;rotatep = (new PVector(b.x1,b.y1));
        if(b.y2>=floor)vcount++;rotatep = (new PVector(b.x2,b.y2));
      }
      
      if(vcount>0) falling = false;
      if(vcount>0) rotating = true;
    
    }
    
    if(type==0){
      if(gravity){
        
        if(center.y<floor){
          vy += ay;
          center.y += vy;
       }}}
    
    strokeWeight(20);
    stroke(255);
    point(center.x,center.y);
    strokeWeight(1);
    
      if(!mousePressed)sdown = false;linedown = false;
      if(mousePressed&&!linedown)linedown = true;
      
      if(!mousePressed&&!a.point1&&!a.point2&&!a.point3&&a.updatep&&a.uindex==id&&a.type!=2){
        
        calc_center();
        update_dist(Boundaries);
        a.create_rotation_points(Boundaries);
        a.update_angles();
        a.updatep = false;
      }
  };
  
  void create_points(ArrayList<Boundary> a){
    for(int i=0;i<a.size();i++){
      
      Boundary b = a.get(i);
      if(points.size()==i)points.add(new PVector(b.x1,b.y1));
      }
  };
  
  void create_angles(ArrayList<Boundary> a){
    for(int i=0;i<a.size();i++){
      
      Boundary b = Boundaries.get(i);
      
      float t1 = atan2(b.y1 - center.y,b.x1 - center.x);
      
      if(theta.size()<a.size())theta.add(t1);
      else theta.set(i,t1);
    }
  };
  
  void update_points(ArrayList<Boundary> a){
    
    
    for(int i=0;i<a.size();i++){
      
      PVector b = points.get(i);
      
      float d1 = dist(b.x,b.y,center.x,center.y);
      
      float t1 = theta.get(i);;
      
      float ax = center.x + (d1) * cos(t1);
      float ay = center.y + (d1) * sin(t1);
      
      if(points.size()<a.size())points.add(new PVector(ax,ay));
      else rotation_points.set(i,new PVector(ax,ay));
    }
  };
  
  void create_dist(){
    for(int i=0;i<Boundaries.size();i++){
      
      Boundary b = Boundaries.get(i);
      
      dist.add(dist(center.x,center.y,b.x1,b.y1));
    }
  };
  
  void update_Boundaries(){
    
    for(int i=0;i<Boundaries.size();i++){
      
      Boundary b = Boundaries.get(i);
      
      float t = theta.get(i);
      Float d = dist.get(i);
      
      float t1 = 0;
      Float d1 = dist.get(i);
      
      if(i<Boundaries.size()-1){
        t1 = theta.get(i+1);
        d1 = dist.get(i+1);
      }else if(type!=106){
        t1 = theta.get(0);
        d1 = dist.get(0);
      }
      strokeWeight(10);
      stroke(0);
      
      b.x1 = center.x + d * cos(t);
      b.y1 = center.y + d * sin(t);
      if(type!=106){
      b.x2 = center.x + d1 * cos(t1);
      b.y2 = center.y + d1 * sin(t1);
      }else {
        
      }
      strokeWeight(1);
    }
  };
  
  void update_line(){
    
    Boundary a = Boundaries.get(0);
    
    float b = theta.get(0);
    Float d = dist.get(0);
    
    a.x1 = center.x - d * cos(b) ;
    a.y1 = center.y - d * sin(b) ;
    
    a.x2 = center.x + d * cos(b) ;
    a.y2 = center.y + d * sin(b) ;
  };
  
  void update_Boundaries(Boundary a){
    
    for(int i=0;i<a.Boundaries.size();i++){
      
      Boundary b = a.Boundaries.get(i);
      
      float t = a.theta.get(i);
      Float d = a.dist.get(i);
      
      float t1 = 0;
      Float d1 = a.dist.get(i);
      
      if(i<Boundaries.size()-1){
        t1 = a.theta.get(i+1);
        d1 = a.dist.get(i+1);
      }else if(a.type!=106){
        t1 = a.theta.get(0);
        d1 = a.dist.get(0);
      }
      strokeWeight(10);
      stroke(0);
      
      b.x1 = center.x + d * cos(t);
      b.y1 = center.y + d * sin(t);
      if(a.type!=106){
      b.x2 = center.x + d1 * cos(t1);
      b.y2 = center.y + d1 * sin(t1);
      }
      strokeWeight(1);
    }
  };
  
  void rotate(float t){
    
    for(int i=0;i<Boundaries.size();i++){
      
      Boundary b = Boundaries.get(i);
      float t2 = theta.get(i);
      float d2 = dist.get(i);
      
      if(i<theta.size()-1){
        t2 = theta.get(i+1);
        d2 = dist.get(i+1);
      }else if(type!=106){
        t2 = theta.get(0);
        d2 = dist.get(0);
      }
      
      b.x1 = center.x + dist.get(i) * cos(theta.get(i)+radians(t));
      b.y1 = center.y + dist.get(i) * sin(theta.get(i)+radians(t));
      
      b.x2 = center.x + d2 * cos(t2+radians(t));
      b.y2 = center.y + d2 * sin(t2+radians(t));
    }
    
  };
  void rotate2(float t){
    
    float t3 = radians(90);
    for(int i=0;i<Boundaries.size();i++){
      
      Boundary b = Boundaries.get(i);
      float t2 = theta.get(i);
      float d2 = dist.get(i);
      
      if(i<theta.size()-1){
        t2 = theta.get(i+1);
        d2 = dist.get(i+1);
      }else if(type!=106){
        t2 = theta.get(0);
        d2 = dist.get(0);
      }
      
      b.x1 = center.x + dist.get(i) * cos(theta.get(i)+(t)+t3);
      b.y1 = center.y + dist.get(i) * sin(theta.get(i)+(t)+t3);
      
      b.x2 = center.x + d2 * cos(t2+(t)+t3);
      b.y2 = center.y + d2 * sin(t2+(t)+t3);
    }
    
  };
  
  void update_angles(){
    for(int i=0;i<Boundaries.size();i++){
      
      Boundary b = Boundaries.get(i);
      
      float t = atan2(b.y1 - center.y,b.x1 - center.x);
      if(i<theta.size())theta.set(i,t);
      else theta.add(t);
    }
  };
  
  void angular_vel(float a, float u){
    
  };
  
  void create_rotation_points(ArrayList<Boundary>a){
    
    float d = 10;
    
    for(int i=0;i<a.size();i++){
      
      Boundary b = a.get(i);
      
      float d1 = dist(b.x1,b.y1,center.x,center.y);
      
      float t1 = atan2(b.y1 - center.y,b.x1 - center.x);
      
      float ax = center.x + (d1+d) * cos(t1);
      float ay = center.y + (d1+d) * sin(t1);
      
      if(rotation_points.size()<a.size())rotation_points.add(new PVector(ax,ay));
      else rotation_points.set(i,new PVector(ax,ay));
    }
    
  };
  
  void rotate_about(PVector a,Float v){
    
    for(int i=0;i<Boundaries.size();i++){
      
      Boundary b = Boundaries.get(i);
      
      float d1 = dist(b.x1,b.y1,center.x,center.y);
      float d2 = dist(b.x2,b.y2,center.x,center.y);
      float t1 = atan2(b.y2 - b.y1,b.x2 - b.x1);
      float t2 = atan2(b.y1 - b.y2,b.x1 - b.x2);
      
      b.x1 = center.x + d1 * cos(t1+v);
      b.y1 = center.y + d1 * sin(t1+v);
      b.x2 = center.x + d2 * cos(t2+v);
      b.y2 = center.y + d2 * sin(t2+v);
    }
    
  };
  
  void pos_rotationpoint(Boundary a){
    
    float X = mouseX;
    float Y = mouseY;
    
    t2 = 0;
    float t0 = 0;
    
    boolean k = false;
    
    for(int i=0;i<a.rotation_points.size();i++){
      PVector b = a.rotation_points.get(i);
      
      float d1 = dist(b.x,b.y,X,Y);
      
    if(d1<5){
      strokeWeight(5);
      stroke(255);
      point(b.x,b.y);
      if(mousePressed&&!point3){
        point3 = true;
        vert = i;
        index = a.id;
        rdown = true;
      }}}
      
      if(point3&&mousePressed&&index == a.id&&!point1&&!point2&&!linedown){
        rdown = true;
        float t2 = atan2(a.center.y -  mouseY,a.center.x - mouseX);
        
        for(int i=0;i<a.Boundaries.size();i++){
          
          Boundary b = a.Boundaries.get(i);
          
          PVector c = a.rotation_points.get(i);
          PVector d = null;
          
          float d1 = dist(c.x,c.y,a.center.x,a.center.y)-10;
          float t1 = atan2(a.center.y - c.y,a.center.x - c.x);
          
          float d2 = 0,t3 = 0;
          
          if(i<a.Boundaries.size()-1)d = a.rotation_points.get(i+1);
          else if(a.type!=106)d = a.rotation_points.get(0);
          
          if(d!=null){
          d2 = dist(d.x,d.y,a.center.x,a.center.y)-10;
          t3 = atan2(a.center.y - d.y,a.center.x - d.x);
          }
          b.x1 = a.center.x + d1 * cos(t1 + t2);
          b.y1 = a.center.y + d1 * sin(t1 + t2);
          
          b.x2 = a.center.x + d2 * cos(t3 + t2);
          b.y2 = a.center.y + d2 * sin(t3 + t2);
        }}
        
      if(!mousePressed&&point3){
        vert = -1;
        vert1 = -1;
        index = -1;
        rdown = false;
        point3 = false;
        a.update_dist(a.Boundaries);
        a.create_rotation_points(a.Boundaries);
        uindex = a.id;
        updatep = true;
      }
  };
  
  void calc_center(){
    
    float midx = 0;
    float midy = 0;
    
    for(int i=0;i<Boundaries.size();i++){
      Boundary b = Boundaries.get(i);
      midx += (b.x1 + b.x2)/2;
      midy += (b.y1 + b.y2)/2;
    }
    
    midx /= Boundaries.size();
    midy /= Boundaries.size();
    
    center = new PVector(midx,midy);
  };
  
  void logic(){
    if((tri||toggle||circle||bezier||square||spline||poligon||c_poligon||connectedlines||path)){ open = true;}
    if(mousePressed&&open_menus)menudown = true;
    else menudown = false;
    if(none)open = false;
    if(pallete!=null)pallete.click(12,main,"clear");
    if(hidemenu){
      
      if(pallete.x+pallete.w>=0){
      //if(type==0)palletelist.menu.x -= 2;
      pallete.x -= 6;
      for(int i=0;i<pallete.items.size();i++){
        Button a = pallete.items.get(i);
        a.x = pallete.x;
      }
      rect(pallete.x,pallete.y,pallete.w,pallete.h);
      }else if(pallete.x+pallete.w<0){
      palletehide.draw();
      
      if(palletehide.pos()&&mousePressed){
        hidemenu = false;
        pallete.items.get(10).toggle=0;
      }
    }}else if(pallete!=null&&pallete.x<0){
      main.pallete.items.get(15).toggle=0;
      pallete.x += 6;
      for(int i=0;i<pallete.items.size();i++){
        Button a = pallete.items.get(i);
        a.x = pallete.x;
      }
      rect(pallete.x,pallete.y,pallete.w,pallete.h);
    }
    
    
    if(type==-1&&clear){
      Boundaries = new ArrayList<Boundary>();
      ArrayList<Float[]> velocity = new ArrayList<Float[]>();
      ArrayList<PVector> velocitypv = new ArrayList<PVector>();
      ArrayList<Boundary> Quadrants = new ArrayList<Boundary>();
      ArrayList<PVector> Midpoints = new ArrayList<PVector>();
      clear = false;
    }
  };
  
  void mtranslate(Boundary b ,PVector m){
    
    float mx = m.x;
    float my = m.y;
    
    if(!point1&&!point2&&!point3&&!linedown&&!rdown&&type!=2){
      if(pos(b,m)&&mousePressed&&!tdown){
         index = b.id;
         deltamx = (b.center.x - mx);
         deltamy = (b.center.y - my);
         
         b.tdown = true;
         tdown = true;
    }}
    
    
    if(b.tdown&&index == b.id&&type!=2){
      if(index>=0){
        
      Boundary c = Boundaries.get(index);
      b.center.x = mx + deltamx;
      b.center.y = my + deltamy;
      b.create_rotation_points(b.Boundaries);
      //b.update_angles();
      b.update_Boundaries();
      }}
    
    if(!mousePressed&&type!=2){
      if(index>=0){
        Boundary c = Boundaries.get(index);
        index = -1;
        deltamx = 0;deltamy = 0;
        uindex = c.id;
        updatep = true;
        b.tdown = false;
        tdown = false;
      
    }}
    
  };
  
  void mtranslate(PVector m){
    
    float mx = m.x;
    float my = m.y;
    
   if(mousePressed&&!mdown){
    mdown = true; 
    dx = center.x - mx;
    dy = center.y - my;
   }
    
   if(mdown){
     center.x = mx + dx;
     center.y = my + dy;
   }
     update_Boundaries();
   if(!mousePressed){
     mdown = false;
     
   }
   
  };
  
  void functions(){
      debug();
      if(!edit&&!open_menus&&!pallete.pos()&&open&&!palletehide.pos()){
    if (toggle)create();
    else if (square)create_rect();
    else if(circle)create_circle();
    else if(tri)create_tri();
    else if(bezier)create_bezier();
    else if(poligon)create_poligon();
    else if(complex)create_complex_poligon();
    else if(connectedlines)connectedLines();
    else if(path)drawPath();
    else if(spline){
      
    }}
  
  };
  
  boolean pos(Boundary a,PVector p){
    float X = p.x;
    float Y = p.y;
    boolean k = false;
    trit = 0;
    if(a.type==0){
          
          float mx = abs((a.x2-a.x1))/2;
          float my = abs((a.y2-a.y1))/2;
          
          float A = sq(X - a.center.x);
          float B = sq(Y - a.center.y);
          
          float C = sq(mx);
          float D = sq(my);
          return A/C + B/D <1;
          
      } if(a.type==2){
      return check_lineP(new PVector(a.x1,a.y1),new PVector(a.x2,a.y2),new PVector(X,Y));
    }
      if(a.type==4||a.type==3||a.type==103||a.type==201){
      
      for(int i=0;i<a.Boundaries.size();i++){
        
        Boundary b = a.Boundaries.get(i);
        
        Boundary A = new Boundary((b.x1 + b.x2)/2,(b.y1 + b.y2)/2,X,Y);
        
        for(int j=0;j<a.Boundaries.size();j++){
          
          Boundary C = a.Boundaries.get(j);
          
          PVector i1 = check_intersect(A,C);
          
          if(i1!=null&&i!=j){
            trit++;
            
          }}}
          if(trit>0)k = false;
          else k = true;
      }
    return k;
    
  };
    
  boolean check_lineP(PVector a, PVector b,PVector c){
    
    boolean k = false;
    float d1 = dist(a.x,a.y,b.x,b.y);
    float d2 = dist(a.x,a.y,c.x,c.y);
    float d3 = dist(b.x,b.y,c.x,c.y);
    float d4 = d2 + d3;
    
    if(d4 <= d1 + 0.05 && d4 >= d1 - 0.05){
      k = true;
    }
    return k;
  };
  
  boolean check_lineP(float x1, float y1,float x2,float y2, PVector c){
    
    boolean k = false;
    float d1 = dist(x1,y1,x2,y2);
    float d2 = dist(x1,y1,c.x,c.y);
    float d3 = dist(x2,y2,c.x,c.y);
    float d4 = d2 + d3;
    
    if(d4 <= d1 + 0.05 && d4 >= d1 - 0.05){
      k = true;
    }
    return k;
  };
  
  void drag(){
  };
  
  boolean pospoint(Boundary a,int n){
    float X = mouseX;
    float Y = mouseY;
    
    boolean k = false;
    
    for(int i=0;i<a.Boundaries.size();i++){
      Boundary b = a.Boundaries.get(i);
      
      float d1 = dist(b.x1,b.y1,X,Y);
      float d2 = dist(b.x2,b.y2,X,Y);
      
    if(d1<5){
      k = true;
    }
      
      if(d2<5){
        k = true;
    }}
    return k;
  };
  
  void pospoint(Boundary a){
    float X = mouseX;
    float Y = mouseY;
    
    t = 0;
    
    boolean k = false;
    //if(!a.linedown){
    for(int i=0;i<a.Boundaries.size();i++){
      Boundary b = a.Boundaries.get(i);
      
      float d1 = dist(b.x1,b.y1,X,Y);
      float d2 = dist(b.x2,b.y2,X,Y);
      
    if(d1<5){
      strokeWeight(5);
      stroke(255);
      point(b.x1,b.y1);
      if(mousePressed&&!point1&&!a.point1){
        
        t++;
        vert = i;
        index = a.id;
        point1 = true;
        a.point1 = true;
        a.pdown = true;
        pdown = true;
      }}
      
      if(d2<5){
      strokeWeight(5);
      stroke(255);
      point(b.x2,b.y2);
      if(mousePressed&&!point2&&!a.point2){
        
        t++;
        vert1 = i;
        index = a.id;
        point2 = true;
        a.point2 = true;
        a.pdown = true;
        pdown = true;
      }}
      if(point1&&vert>=0&&index==a.id){
        Boundary c = a.Boundaries.get(vert);
        c.x1 = X;
        c.y1 = Y;
      }
      if(point2&&vert1>=0&&index==a.id){
        Boundary c = a.Boundaries.get(vert1);
        c.x2 = X;
        c.y2 = Y;
      }
      if(a.type==2){
        a.x1 = b.x1;a.y1 = b.y1;
        a.x2 = b.x2;a.y2 = b.y2;
      }
      if(a.type==4){
        
          if(vert==0)a.x1 = b.x1;
          if(vert==1)a.x2 = b.x1;
          if(vert==2)a.x3 = b.x1;
          if(vert==3)a.x4 = b.x1;
          
          if(vert1==0)a.x2 = b.x2;
          if(vert1==1)a.x3 = b.x2;
          if(vert1==2)a.x4 = b.x2;
          if(vert1==3)a.x1 = b.x2;
        }
      if(a.type==3||a.type==103){
        if(vert==0)a.x1 = b.x1;a.y1 = b.y1;
        if(vert==1)a.x2 = b.x1;a.y2 = b.y1;
        if(vert==2)a.x3 = b.x1;a.y3 = b.y1;
        
        if(vert1==0)a.x2 = b.x2;a.y2 = b.y2;
        if(vert1==1)a.x3 = b.x2;a.y3 = b.y2;
        if(vert1==2)a.x1 = b.x2;a.y1 = b.y2;
     
    }}
      
    if(t>0){
      k = true;
      hover = true;
    }
    if(!mousePressed){
      a.update_dist(a.Boundaries);
      a.calc_center();
      a.create_rotation_points(a.Boundaries);
      a.update_angles();
    }
    if(!mousePressed){
      
      vert = -1;
      vert1 = -1;
      index = -1;
      point1 = false;
      point2 = false;
      a.point2 = false;
      a.point1 = false;
      uindex = a.id;
      updatep = true;
      a.pdown = false;
      pdown = false;
      
    }
  };
  
  void update_dist(ArrayList<Boundary> a){
   
    
    for(int i=0;i<a.size();i++){
      
      Boundary b = a.get(i);
      int id = b.id;
      //float Dist = dist.get
      float dx = (b.x1 - center.x);
      float dy = (b.y1 - center.y);
      float d  = dist(b.x1,b.y1,center.x,center.y);
      Float [] d1 = {dx,dy};
      
      if(dist.size()==Boundaries.size()){dist.set(i,d);}
      else {dist.add(d);}
      if(pdist.size()==Boundaries.size()*2)pdist.set(i,d1);
      else pdist.add(d1);
    }
  };
  
  void move(Boundary a,PVector p){
    float mx = p.x;
    float my = p.y;
    
    boolean down = false;
    
    for (int i=0;i<a.Boundaries.size();i++){
      
      Boundary b = a.Boundaries.get(i);
      
     float d1 = dist(b.x1,b.y1,mx,my);
     float d2 = dist(b.x2,b.y2,mx,my);
     
    boolean k = check_lineP(b.x1,b.y1,b.x2,b.y2,new PVector(mx,my));
    if(k&&!linedown&&d1>6&&d2>6&&!point1&&!point2&&mousePressed&&!a.linedown){
      vert3 = i;
      sid = a.id;
      D1 = d1;
      D2 = d2;
      T1 = atan2(b.y2 - b.y1,b.x2 - b.x1);
      T2 = atan2(b.y1 - b.y2,b.x1 - b.x2);
      
      linedown = true;
      a.linedown = true;
    }}
    
    if(linedown && sid==a.id && a.linedown&&a.Boundaries.size()>0){
      
      Boundary b   = a.Boundaries.get(vert3);
      Boundary b_1 = a.Boundaries.get(0);
      Boundary bp1 = a.Boundaries.get(0);
      
      if(vert3>0)b_1 = a.Boundaries.get(vert3-1);
      else if(a.type!=106)b_1 = a.Boundaries.get(a.Boundaries.size()-1);
      if(vert3<a.Boundaries.size()-1)bp1 = a.Boundaries.get(vert3+1);
      else if(a.type!=106)bp1 = a.Boundaries.get(0);
      
      stroke(255,0,0);
      PVector p1 = new PVector( mx + D2 * cos(T1),my + D2 * sin(T1));
      PVector p2 = new PVector( mx + D1 * cos(T2),my + D1 * sin(T2));
      //line(p1.x,p1.y,p2.x,p2.y);
      
      b.x2 = p1.x;
      b.y2 = p1.y;
      b.x1 = p2.x;
      b.y1 = p2.y; 
      
      b_1.x2 = p2.x;
      b_1.y2 = p2.y;
      bp1.x1 = p1.x;
      bp1.y1 = p1.y;
      
    }
    
    if(!mousePressed&&a.linedown){
      D1 = 0;D2 = 0;T1 = 0;T2 = 0;vert3 = -1;sid = -1;down = false;
      a.update_dist(a.Boundaries);
      uindex = a.id;
      updatep = true;
      linedown = false;
      a.linedown = false;
    }
  };
  
  void create_circle(){
    float ax = mouseX;
    float ay = mouseY;
    
    Boundary n;
    if (circle&&!menudown&&mousePressed&&mouseButton == LEFT&&shapes.toggle==0&&mouseX>main.x&&mouseY>main.y){
       
      mdown = true;
      ax = mouseX;
      ay = mouseY;
       
      temp.add(new PVector(ax,ay));
      dx = ax - temp.get(0).x;
      dy = ay - temp.get(0).y;
       
      strokeWeight(1);
      stroke(col);
      ellipseMode(CORNER);
      ellipse(temp.get(0).x,temp.get(0).y,dx,dy);
      }
      if(mdown&&!mousePressed&&!point1&&!point2){
        
      if((temp.get(0).x!=temp.get(temp.size()-1).x&&temp.get(0).y!=temp.get(temp.size()-1).y)){
      Boundary a = new Boundary(temp.get(0).x,temp.get(0).y,dx,dy,0);
      a.id = Boundaries.size();
      Boundaries.add (a);
      //scene.Boundaries.add (a);
      theta.add(atan2((temp.get(0).y + dy) - temp.get(0).y,(temp.get(0).x + dx) - temp.get(0).x));
      norm.add(atan2((temp.get(0).x + dx) - temp.get(0).x, (temp.get(0).y + dy) - temp.get(0).y));
      Float [] vel = {0.0,0.0};
      velocity.add(vel);
      velocitypv.add(new PVector(0,0));
      temp = new ArrayList<PVector>();
      mdown = false;
      
      updateSliderMenu(a);
      
      }}
  };
  
  void updateSliderMenu(Boundary a){
    
      settings = new sliderBox(X, 10,90,5,settingsLabel,palleteTab);
      settings.visible = true;
      settings.parentCanvas = true;
      palleteTab.addState(1);
      palleteTab.states.get(palleteTab.states.size()-1).sliderBoxes.add(settings);
  }
  
  void create(){
    
    float ax = mouseX;
    float ay = mouseY;
    
    Boundary n;
    //temp = new ArrayList<
    
      if (toggle&&!menudown&&mousePressed&&!open_menus&&mouseButton == LEFT&&mouseX>main.x&&mouseY>main.y&&shapes.toggle==0){
       
      mdown = true;
      ax = mouseX;
      ay = mouseY;
      
      temp.add(new PVector(ax,ay));
      
      line(temp.get(0).x,temp.get(0).y,temp.get(temp.size()-1).x,temp.get(temp.size()-1).y);
      }
      if(mdown&&!mousePressed&&!point1&&!point2){
      if((temp.get(0).x!=temp.get(temp.size()-1).x&&temp.get(0).y!=temp.get(temp.size()-1).y)){
      n = new Boundary(temp.get(0).x,temp.get(0).y,temp.get(temp.size()-1).x,temp.get(temp.size()-1).y,2);
      n.id = Boundaries.size();
      Boundaries.add (n);
      theta.add(atan2(temp.get(temp.size()-1).y - temp.get(0).y,temp.get(temp.size()-1).x - temp.get(0).x));
      norm.add(atan2(temp.get(temp.size()-1).x - temp.get(0).x, temp.get(temp.size()-1).y - temp.get(0).y));
      Float [] vel = {0.0,0.0};
      velocity.add(vel);
      velocitypv.add(new PVector(0,0));
      temp = new ArrayList<PVector>();
      
      }mdown = false;
    }
  };
  
  void create_tri(){
    
    float ax = mouseX;
    float ay = mouseY;
    
    Boundary n;
    float d;
    
    if (tri&&mousePressed&&!open_menus&&shapes.toggle==0&&mouseButton == LEFT&&mouseX>main.x&&mouseY>main.y){
       
      mdown = true;
      ax = mouseX;
      ay = mouseY;
      
      temp.add(new PVector(ax,ay));
      d = dist(ax,ay,temp.get(0).x,temp.get(0).y);
      
      float Norm = -atan2(temp.get(0).x - ax,temp.get(0).y - ay);
      
      float X2 = ax + d/1.5 * cos(Norm);
      float Y2 = ay + d/1.5 * sin(Norm);
      float X3 = ax - d/1.5 * cos(Norm);
      float Y3 = ay - d/1.5 * sin(Norm);
      
      beginShape();
      stroke(255);
      fill(0);
      
      vertex(temp.get(0).x,temp.get(0).y);
      vertex(X2,Y2);
      vertex(X3,Y3);
      endShape(CLOSE);
      }
      if(mdown&&!mousePressed&&!point1&&!point2){
      if((temp.get(0).x!=temp.get(temp.size()-1).x&&temp.get(0).y!=temp.get(temp.size()-1).y)){
      n = new Boundary(temp.get(0).x,temp.get(0).y,ax,ay,3);
      n.id = Boundaries.size();
      Boundaries.add (n);
      theta.add(atan2(temp.get(temp.size()-1).y - temp.get(0).y,temp.get(temp.size()-1).x - temp.get(0).x));
      norm.add(atan2(temp.get(temp.size()-1).x - temp.get(0).x, temp.get(temp.size()-1).y - temp.get(0).y));
      Float [] vel = {0.0,0.0};
      velocity.add(vel);
      velocitypv.add(new PVector(0,0));
      temp = new ArrayList<PVector>();
      updateSliderMenu(n);
      }mdown = false;
    }
  };
  
  void create_rect(){
    
    float ax = mouseX;
    float ay = mouseY;
    //if(mousePressed)println(shapes.toggle);
    if (square&&!menudown&&mousePressed&&!open_menus&&shapes.toggle==0&&mouseButton == LEFT&&mouseX>main.x&&mouseY>main.y){
      
      mdown = true;
      ax = mouseX;
      ay = mouseY;
       
      temp.add(new PVector(ax,ay));
      dx = ax - temp.get(0).x;
      dy = ay - temp.get(0).y;
       
      strokeWeight(20);
      stroke(0);
      point(ax,ay);
      strokeWeight(1);
      stroke(col);
      rect(temp.get(0).x,temp.get(0).y,dx,dy);
      }
      if(mdown&&!mousePressed&&!point1&&!point2){
        
      if((temp.get(0).x!=temp.get(temp.size()-1).x&&temp.get(0).y!=temp.get(temp.size()-1).y)){
      Boundary a = new Boundary(temp.get(0).x,temp.get(0).y,dx,dy,4);
      a.id = Boundaries.size();
      Boundaries.add (a);
      theta.add(atan2((temp.get(0).y + dy) - temp.get(0).y,(temp.get(0).x + dx) - temp.get(0).x));
      norm.add(atan2((temp.get(0).x + dx) - temp.get(0).x, (temp.get(0).y + dy) - temp.get(0).y));
      temp = new ArrayList<PVector>();
      Float [] vel = {0.0,0.0};
      velocity.add(vel);
      velocitypv.add(new PVector(0,0));
      mdown = false;
      updateSliderMenu(a);
      }
    }
  };
  
  void create_poligon(){
    float ax = mouseX;
    float ay = mouseY;
    
    Boundary n;
    
    Sides.draw();
    sides = int(Sides.value);
    if(sides>0){
      
    if (mousePressed&&mcount==0&&!complexsub.pos()&&shapes.toggle==0&&mouseX>main.x&&mouseY>main.y){
      
      mdown = true;
      ax = mouseX;
      ay = mouseY;
       
      temp.add(new PVector(ax,ay));
      dx = ax - temp.get(0).x;
      dy = ay - temp.get(0).y;
       
      strokeWeight(20);
      stroke(0);
      point(ax,ay);
      strokeWeight(1);
      stroke(col);
      beginShape();
      
      float X = (temp.get(0).x + ax)/2;
      float Y = (temp.get(0).y + ay)/2;
      
      for(int i=0;i<sides;i++){
       
        float theta = radians(360/sides*i);
        
        float w = abs((temp.get(0).x - ax))/2;
        float h = abs((temp.get(0).y - ay))/2;
        
        PVector a = new PVector(X + w * cos(theta),Y + h * sin(theta));
        vertex(a.x,a.y);
        
        //vertex(X + w * cos(theta2),Y + h * sin(theta2));
        
      }
      endShape(CLOSE);
      }
      if(mdown&&!mousePressed){
        
      if((temp.get(0).x!=temp.get(temp.size()-1).x&&temp.get(0).y!=temp.get(temp.size()-1).y)){
        n = new Boundary(temp.get(0).x,temp.get(0).y,ax,ay,201);
        float X = (temp.get(0).x + ax)/2;
        float Y = (temp.get(0).y + ay)/2;
        n.center = new PVector(X,Y);
      
      for(int i=0;i<sides;i++){
       
        float theta = radians(360/sides*i);
        float theta2 = radians(360/sides*(i+1));
        
        float w = abs((temp.get(0).x - ax))/2;
        float h = abs((temp.get(0).y - ay))/2;
        
        PVector a = new PVector(X + w * cos(theta),Y + h * sin(theta));
        PVector b = new PVector(X + w * cos(theta2),Y + h * sin(theta2));
        //vertex(a.x,a.y);
        n.Boundaries.add(new Boundary(a.x,a.y,b.x,b.y));
        
      }
      
      n.id = Boundaries.size();
      Boundaries.add (n);
      theta.add(atan2((temp.get(0).y + dy) - temp.get(0).y,(temp.get(0).x + dx) - temp.get(0).x));
      norm.add(atan2((temp.get(0).x + dx) - temp.get(0).x, (temp.get(0).y + dy) - temp.get(0).y));
      temp = new ArrayList<PVector>();
      Float [] vel = {0.0,0.0};
      velocity.add(vel);
      velocitypv.add(new PVector(0,0));
      mdown = false;
      updateSliderMenu(n);
      }}}else {
        fill(255);
        noStroke();
        rect(100,100,200,15);
        text("Please define number of sides",100,100);
        
      }
  };
  
  void create_bezier(){
    
  };
  
  void create_complex_poligon(){
    //mcount = 0;
    float mx = mouseX;
    float my = mouseY;
    
    float sw = w/cols, sh = h/rows;
    if(!mousePressed){mcount = 0;}
    //text(x + "         " + scene.x + "          " + scene.w,100,110);
    if(complex){
      
      complexsub.draw();
      
      for(int i=0;i<ogrid.size();i++){
          Point a = ogrid.get(i);
          
          a.draw();
        }
      
      if(mousePressed&&mcount==0&&!complexsub.pos()&&shapes.toggle==0&&mouseX>main.x&&mouseY>main.y)mdown = true;
      else mdown = false;
      if(mdown) mcount++;
      if(mousePressed&&complexsub.pos()){
        cfinish = true;
        temp = new ArrayList<PVector>();
      }
      else if(!mousePressed)cfinish = false;
      
      if(mdown){
        
        counter++;
        if(!complexsub.pos())grid.add(new Point(floor(mx/sw)*sw,floor(my/sh)*sh,counter));
        polymidpoint = new PVector(0,0);
        ogrid = new ArrayList<Point>();
        for(int i=0;i<grid.size();i++){
          Point a = grid.get(i);
          boolean b = ugrid.contains(a);
          
          if(!b){
            ugrid.add(a);
            polymidpoint.x += a.x;
            polymidpoint.y += a.y;
          }}polymidpoint.div(grid.size());}
          
            sortpoints(grid,ugrid,ogrid,polymidpoint);
  
        if(ogrid.size()>1&&!cfinish){
          for(int i=0;i<ogrid.size();i++){
          Point a = ogrid.get(i);
          int pos = 0;
            
          if(i<ogrid.size()-1){
            pos = i+1;
          }
          else{
            pos = 0;
          }
          
          Point b = ogrid.get(pos);
          stroke(0);
          strokeWeight(1);
          line(b.x,b.y,a.x,a.y);
          
        }}
        
        strokeWeight(20);
        stroke(0);
        point(polymidpoint.x,polymidpoint.y);
        strokeWeight(1);
        }
        
        if(cfinish){
          
          Boundaries.add(new Boundary(ogrid));
          
          ogrid = new ArrayList<Point>();
          grid = new ArrayList<Point>();
          ugrid = new ArrayList<Point>();
          
          cfinish = false;
        }
    
  };
  
  void connectedLines(){
    //mcount = 0;
    float mx = mouseX;
    float my = mouseY;
    
    float sw = w/cols, sh = h/rows;
    if(!mousePressed){
      mcount = 0;
      pointadded = false;
    }
    if(connectedlines){
      complexsub.draw();
      
      if(mousePressed&&mcount==0&&!complexsub.pos()&&shapes.toggle==0)mdown = true;
      else mdown = false;
      if(mousePressed&&complexsub.pos())cfinish = true;
      else if(!mousePressed)cfinish = false;
      
      if(mdown){
        
        if(!complexsub.pos()){
          Point a = new Point(floor(mx/sw)*sw,floor(my/sh)*sh,grid.size());
          Point b;
          boolean k = grid.contains(a);
          if(grid.size()==0)grid.add(a);
          else{
            b = grid.get(grid.size()-1);
            if(b.x!=a.x||b.y!=a.y)grid.add(a);
          }}
        //pointadded = true;
      }
        for(int i=grid.size()-1;i>-1;i--){
          Point a = grid.get(i);
          
          a.draw();
          
        if(grid.size()>1&&!cfinish){
          int pos = 0;
            
          if(i<grid.size()-1)pos = i+1;
          
          Point b = grid.get(pos);
          stroke(0);
          strokeWeight(1);
          if(i<grid.size()-1)line(b.x,b.y,a.x,a.y);
          
        }}
        
        if(cfinish){
          
          Boundary a = new Boundary(grid,0);
          
          if(grid.size()>0)Boundaries.add(a);
          
          grid = new ArrayList<Point>();
          updateSliderMenu(a);
          cfinish = false;
          mdown = false;
        }}
        strokeWeight(1);
  };
  
  void drawPath(){
    //mcount = 0;
    float mx = mouseX;
    float my = mouseY;
    
    float sw = w/cols, sh = h/rows;
    if(!mousePressed){
      mcount = 0;
      pointadded = false;
    }
    if(path){
      complexsub.draw();
      
      if(mousePressed&&mcount==0&&!complexsub.pos()&&shapes.toggle==0)mdown = true;
      else mdown = false;
      if(mousePressed&&complexsub.pos())cfinish = true;
      else if(!mousePressed)cfinish = false;
      
      if(mdown){
        
        if(!complexsub.pos()){
          Point a = new Point(floor(mx/sw)*sw,floor(my/sh)*sh,grid.size());
          Point b;
          boolean k = grid.contains(a);
          if(grid.size()==0)grid.add(a);
          else{
            b = grid.get(grid.size()-1);
            if(b.x!=a.x||b.y!=a.y)grid.add(a);
          }}
        //pointadded = true;
      }
        for(int i=grid.size()-1;i>-1;i--){
          Point a = grid.get(i);
          
          a.draw();
          
        if(grid.size()>1&&!cfinish){
          int pos = 0;
            
          if(i<grid.size()-1)pos = i+1;
          
          Point b = grid.get(pos);
          stroke(0);
          strokeWeight(1);
          if(i<grid.size()-1)line(b.x,b.y,a.x,a.y);
          
        }}
        
        if(cfinish){
          
          if(grid.size()>0)Boundaries.add(new Boundary(grid,0));
          
          grid = new ArrayList<Point>();
          
          cfinish = false;
          mdown = false;
        }}
        strokeWeight(1);
  };
  
  void create_free(){
    
  };
  
  Boolean posWindow(){
    
    float mx = mouseX;
    float my = mouseY;
    
    return(mx>x1&&mx<x2&&my>y1&&my<y2);
    
  };
  
  void mass_Center(){
    
    ccount = 0;
    PVector Center = new PVector(0,0);
    if(center == null|| center !=Center){
      for(int i=0;i<Boundaries.size();i++){
        
        Boundary a = Boundaries.get(i);
        PVector midp = new PVector((a.x1+a.x2)/2,(a.y1+a.y2)/2);
        Center.add(midp);
        Midpoints.add(midp);
        ccount++;
      }
      if(ccount==Boundaries.size())center = Center;
    }
  };
    
};

PVector check_intersect(Boundary a, Boundary b){

  float a1 = a.y2 - a.y1;
  float b1 = a.x1 - a.x2;
  float c1 = a1 * a.x1 + b1 * a.y1;
  float a2 = b.y2 - b.y1;
  float b2 = b.x1 - b.x2;
  float c2 = a2 * b.x1 + b2 * b.y1;
  float denom = a1 * b2 - a2 * b1;
  
  if((a.x1==b.x1||a.x2==b.x2)&&(a.y1==b.y1||a.y2==b.y2)){
    
    return null;
  }
    else{
      
  Float X = (b2 *c1 - b1 * c2) / denom;
  Float Y = (a1 *c2 - a2 * c1) / denom;
  
  PVector p = new PVector(X,Y);   
    boolean Linea = ((p.x<a.x1&&p.x>a.x2)||(p.x>a.x1&&p.x<a.x2))||((p.y<a.y1&&p.y>a.y2)||(p.y>a.y1&&p.y<a.y2));
    boolean Lineb = ((p.x<b.x1&&p.x>b.x2)||(p.x>b.x1&&p.x<b.x2))||((p.y<b.y1&&p.y>b.y2)||(p.y>b.y1&&p.y<b.y2));
    boolean Linec = (p.x!=a.x1&&p.x!=a.x2)&&(p.y!=a.y1&&p.y!=a.y2);
    
    Linec = (dist(p.x,p.y,a.x1,a.y1)>0.5&&dist(p.x,p.y,a.x1,a.y1)>0.5);
      if(Linec&&Linea&&Lineb){
          //strokeWeight(20);
          //  stroke(0);
          //  point(p.x,p.y);
          //  strokeWeight(1);
      return p;
    }
    else{
    return null;
    }}
};

PVector check_intersect2(Boundary a, Boundary b){

  float a1 = a.y2 - a.y1;
  float b1 = a.x1 - a.x2;
  float c1 = a1 * a.x1 + b1 * a.y1;
  float a2 = b.y2 - b.y1;
  float b2 = b.x1 - b.x2;
  float c2 = a2 * b.x1 + b2 * b.y1;
  float denom = a1 * b2 - a2 * b1;
  
  Float X = (b2 *c1 - b1 * c2) / denom;
  Float Y = (a1 *c2 - a2 * c1) / denom;
  
  PVector p = new PVector(X,Y);   
    boolean Linea = ((p.x<=a.x1&&p.x>=a.x2)||(p.x>=a.x1&&p.x<=a.x2))||((p.y<=a.y1&&p.y>=a.y2)||(p.y>=a.y1&&p.y<=a.y2));
    boolean Lineb = ((p.x<=b.x1&&p.x>=b.x2)||(p.x>=b.x1&&p.x<=b.x2))||((p.y<=b.y1&&p.y>=b.y2)||(p.y>=b.y1&&p.y<=b.y2));
    boolean Linec = (p.x==a.x1||p.x==a.x2)||(p.y==a.y1||p.y==a.y2);
    boolean Lined = (p.x==b.x1||p.x==b.x2)&&(p.y==b.y1||p.y==b.y2);
      if(Linea&&Lineb||Linec){
      return p;
    }
    else{
    return null;
    }
};
  
class Connection{
  float d,e,x,y;
  //ArrayList<Integer[]> vertex = new ArrayList<Integer[]>();
  PVector c;
  
  Connection(PVector C){
    c = C;
    x = c.x;
    y = c.y;
    
  };
  
  
};

class _rect{
  
  float x,y,w,h,mass,density,viscoscity,friction,moment,vx,vy,ax,ay;
  boolean border, dashed,connected;
  PVector pos,vel,ac;
  color bg,str;
  Boundary rect;
  
  _rect(float xx,float yy,float ww,float hh){
    x = xx;
    y = yy;
    h = hh;
    w = ww;
    
    rect = new Boundary(xx,yy,ww,hh,4);
  };
  
  void draw(){
    
  }
  
};
  
class _tri{
    
  float x,y,w,h,mass,density,viscoscity,friction,moment,vx,vy,ax,ay;
  boolean border, dashed,connected,fill = true;
  PVector pos,vel,ac;
  color bg = color(0,180),str = color(0);
  Boundary tri;
  
  _tri(float xx,float yy,float ww,float hh){
    x = xx;
    y = yy;
    h = hh;
    w = ww;
    
    tri = new Boundary(x,y,10,20,103);
  };
  _tri(){
  };
  
  void draw(){
    beginShape();
    stroke(str);
    if(!border)noStroke();
    fill(bg);
    //if(parent!=null)fill(parent.col);
    if(!fill)noFill();
    
    for(int i=0;i<tri.Boundaries.size();i++){
      Boundary b = tri.Boundaries.get(i);
      vertex(b.x1,b.y1);
      //vertex(b.x1,b.y1);
    }
    endShape(CLOSE);
  }
  void update(){
    for(int i=0;i<tri.Boundaries.size();i++){
      Boundary b = tri.Boundaries.get(i);
      
      b.create_rotation_points(tri.Boundaries);
      b.update_dist(tri.Boundaries);
      b.update_angles();
      b.create_angles(tri.Boundaries);
    }
  };

  boolean pos(PVector a){
    boolean k = false;
    
    if(tri.pos(tri,a))k = true;
    return k;
  }
};
  
class _ellipse{
    
    float x,y,w,h,mass,density,viscoscity,friction,moment,vx,vy,ax,ay;
    boolean border, dashed,connected;
    PVector pos,vel,ac;
    color bg,str;
    Boundary ellipse;
    
    _ellipse(float xx,float yy,float ww,float hh){
      x = xx;
      y = yy;
      h = hh;
      w = ww;
      
      ellipse = new Boundary(xx,yy,ww,hh,2);
    };
    
    void draw(){
      
    }
    
};
  
class Point{
  
  float x,y;
  int id;
  
  Point(float X, float Y,int Id){
    
    x = X;
    y = Y;
    id = Id;
  }
  
  void draw(){
    
    strokeWeight(8);
    stroke(0);
    point(x,y);
    //float t1 = atan2(y-H/2,x-W/2);
    //float t1 = atan2(y-Boundary.midpoint.y,x-midpoint.x);
    
  }
};

void sortpoints(ArrayList<Point> grid,ArrayList<Point> ugrid,ArrayList<Point> ogrid,PVector midpoint){
  
  if(ogrid.size()!=grid.size()){
    if(ugrid.size()>0){
    
    Point next = closest(ugrid,midpoint);
    
    if(next!=null){
      
      next.id = ogrid.size();
      
      boolean c = ogrid.contains(next);
      
      if(!c){
      int k = ugrid.indexOf(next);
      ogrid.add(next);
      ugrid.remove(k);
    
  }}}}
};
  
Point closest(ArrayList<Point> a,PVector midpoint){
    
    Point k = a.get(0);
    int c = 1;
    for(int i=c;i<a.size();i++){
      
      Point b = a.get(i);
      
      float t1 = atan2(k.y-midpoint.y,k.x-midpoint.x);
      float t2 = atan2(b.y-midpoint.y,b.x-midpoint.x);
      t1 = map(t1,-PI,PI,PI,0);
      t2 = map(t2,-PI,PI,PI,0);
      
      if(t1<t2){
        k = b;
      }}
    
    return k;
};
  
 class Polygon extends Boundary{
    
    Polygon(float xx,float yy,float ww,float hh,int _sides){
      
    sides = _sides;
    x1 = xx;
    y1 = yy;
    w = ww;
    h = hh;
    ax = xx + ww;
    ay = yy + hh;
    
    Boundary n;
    
    Sides.draw();
    sides = int(Sides.value);
    
        n = new Boundary(xx,yy,ax,ay,201);
        
        float X = (xx + w)/2;
        float Y = (yy + h)/2;
        
        n.center = new PVector(X,Y);
      
      for(int i=0;i<sides;i++){
       
        float theta = radians(360/sides*i);
        float theta2 = radians(360/sides*(i+1));
        
        PVector a = new PVector(X + w * cos(theta),Y + h * sin(theta));
        PVector b = new PVector(X + w * cos(theta2),Y + h * sin(theta2));
        //vertex(a.x,a.y);
        n.Boundaries.add(new Boundary(a.x,a.y,b.x,b.y));
        
      }
      
      n.id = Boundaries.size();
      Boundaries.add (n);
      
      theta.add(atan2((y1 + hh) - y1,(x1 + ww) - x1));
      norm.add(atan2((x1 + ww) - x1, (y1 + hh) - y1));
      
      temp = new ArrayList<PVector>();
      Float [] vel = {0.0,0.0};
      
      velocity.add(vel);
      velocitypv.add(new PVector(0,0));
      mdown = false;
      
      }
      
};
