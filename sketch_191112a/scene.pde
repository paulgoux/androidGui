class Scene extends Boundary{
  
  int id;
  //public float x,y,w,h,
  public float bordersize = 1,limit;
  public int cols = 40, rows = 30;
  public String label;
  public boolean showq,showf;
  //public boolean drag,resize,border = true,fill = true ,toggle,visible,clear;
  //public color col = color(0);
  public color scol = color(0,150);
  HashMap<String,Boolean> values = new HashMap<String,Boolean>();
  ArrayList<Menu> menus = new ArrayList<Menu>();
  ArrayList<Slider> sliders = new ArrayList<Slider>();
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Button> nav = new ArrayList<Button>();
  //Boundary boundary;
  
  
  PImage bgimage;
  ArrayList<Quad> fields = new ArrayList<Quad>();
  
  Scene(float xx,float yy, float ww, float hh){
    
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    //main.Boundaries.add(new Boundary(x,y,w,h,4));
    float gW = (w)/cols, gH = h/rows;
    int k = gw;
    
    float sw = w /cols;
    float sh = h / rows;
    
    for(int i=0;i<rows;i++){
      for(int j=0;j<cols;j++){
        
        float X = x + (gW * j);  
        float Y = y + (gH * i);
        int ID = int(j + i * cols);
        
        fields.add(new Quad(new PVector(X,Y),ID,gW,gH,this));
        
      }}
    scenes.add(this);
  };
  
  
  
  Scene(){
    float gW = (w)/cols, gH = h/rows;
    int k = gw;
    
    float sw = w /cols;
    float sh = h / rows;
    
    for(int i=0;i<rows;i++){
      for(int j=0;j<cols;j++){
        
        float X = x + gW/2 + (gW * j);  
        float Y = y + gH/2 + (gH * i);
        int ID = int(j + i * cols);
        
        fields.add(new Quad(new PVector(X,Y),ID,gW,gH,this));
        
      }}
    scenes.add(this);
  };
  
  void save(){
    
  };
  
  void load(){
    
  };
  
  void display(){
    
    noStroke();fill(255);rect(x,y,w,h);
    strokeWeight(bordersize);
    stroke(bg);if(!border){noStroke();}
    fill(bg);if(!fill)noFill();
    
    rect(x,y,w,h);
    
  };
  
  void regression(){
    
  };
  
  void field(){
    
    for(int i=0;i<fields.size();i++){
      
      Quad q = fields.get(i);
      
      q.draw();
      //q.setField();
      //q.field();
    }
    
  };
  
  boolean pos(){
    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
  }
  
};
