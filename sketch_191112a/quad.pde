

class Quad{
  int id,iid,counter,xpos,ypos;
  float x,y,w,h,dens,dens2,dens3,dens4,v,v2,v3,v4,kv,kv2,kv3,kv4;
  float dir,dir2,dir3,dir4;
  PVector p, kp = new PVector(0,0),kp2 = new PVector(0,0),kp3 = new PVector(0,0);
  color col = 0,col2 = 0,col3 = 0,col4 = 0;
  //ArrayList<Entity> children  = new ArrayList<Entity>();
  ArrayList<Quad> affectees  = new ArrayList<Quad>();
  ArrayList<Quad> affectors  = new ArrayList<Quad>();
  ArrayList<PVector> children  = new ArrayList<PVector>();
  //HashMap<Quad,ArrayList
  Scene scene;
  
  Quad(PVector P,int ID,float W,float H){
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
    w = W;
    h = H;
  };
  
  Quad(PVector P,int ID,float W,float H,Scene s){
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
    w = W;
    h = H;
    scene = s;
  };

  void draw(){
    
  };
  
  void fillc(){
    fill(255);
    //rect(p.x,p.y,w,h);
    
  }; 

  void drawSpace(){
    noFill();
    stroke(0);
    strokeWeight(1);
    rect(p.x,p.y,w,h);

  };
  
  void field(){
    dens2 = 0;
    kv2 = 0;
    col2 = 0;
    dir2 = 0;
    if(x+w<scene.x+scene.w + w&&y+h<scene.y+scene.h+w){
    for(int i=0;i<scene.fields.size();i++){
      Quad q = scene.fields.get(i);
      
      float d = dist(x,y,q.x,q.y);
      if(dens*4>d&&q!=this){
        q.dens2 = dens/4;
        q.kv2 = kv/4;
        q.col2 = col/4;
        q.kp = kp;
        q.dir2 = atan2(y-q.y,x-q.x);
        
      }}}
  };
  
  void humans(){
    
  }
  
};

  
