class Table_ {

  int rows, cols, bcols, brows;
  float x, y, w, h, bw, bh, xpadding, ypadding;

  ArrayList<TextBox> grid = new ArrayList<TextBox>();
  ArrayList<Button> Buttons = new ArrayList<Button>();
  ArrayList<ArrayList<TextBox>> gridarray = new ArrayList<ArrayList<TextBox>>();
  boolean initialize,parentCanvas;

  Table_(float x, float y, float w, float h, int cols, int rows) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.cols = cols;
    this.rows = rows;
    bcols = cols;
    brows = rows;

    for (int i=0; i<rows; i++) {
      ArrayList<TextBox> g = new ArrayList<TextBox>();
      for (int j = 0; j<cols; j++) {

        TextBox t = new TextBox(x + w/cols * j, y + h/rows * i, w / cols - 5, h / rows - 5, 2);
        grid.add(t);
        g.add(t);
      }
      gridarray.add(g);
    }

    bw = w/cols;
    bh = h/rows;
  };

  Table_(float x, float y, float w, float h, int cols, int rows, int k) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.cols = cols;
    this.rows = rows;

    bcols = cols;
    brows = rows;

    for (int i=0; i<rows; i++) {
      ArrayList<TextBox> g = new ArrayList<TextBox>();
      for (int j = 0; j<cols; j++) {

        TextBox t = new TextBox(x + w/cols * j, y + h/rows * i, w / cols - 5, h / rows - 5, k);
        grid.add(t);
        g.add(t);
      }
      gridarray.add(g);
    }

    bw = w/cols;
    bh = h/rows;

    //Button b1 = new Button(x+w - 70, y - 30, 100, 20, "Randomize");

    //Buttons.add(b1);
    ////Buttons.add(b2);
  };
  
  void initialize(){
    if(!initialize){
      gridarray = new ArrayList<ArrayList<TextBox>>();
      for (int i=0; i<rows; i++) {
      ArrayList<TextBox> g = new ArrayList<TextBox>();
      for (int j = 0; j<cols; j++) {

        TextBox t = new TextBox(x + bw * j, y + bh * i, bw - 5, bh - 5, 2);
        grid.add(t);
        g.add(t);
      }
      gridarray.add(g);
    }initialize = true;}
    
  };
  
  void initialize(int Cols,int Rows){
    
    if(!initialize){
      cols = Cols;
      rows = Rows;
      gridarray = new ArrayList<ArrayList<TextBox>>();
      for (int i=0; i<rows; i++) {
      ArrayList<TextBox> g = new ArrayList<TextBox>();
      for (int j = 0; j<cols; j++) {

        TextBox t = new TextBox(x + bw * j, y + bh * i, bw - 5, bh - 5, 2);
        grid.add(t);
        g.add(t);
      }
      gridarray.add(g);
    }initialize = true;}
    
  };

  void draw() {
    if((gridarray.size()>0)&&(gridarray.size()!=rows||gridarray.get(0).size()!=cols)||gridarray.size()==0)initialize();initialize = false;
    for (int i=0; i<rows; i++) {
      ArrayList<TextBox> a = gridarray.get(i);
      
      for (int j=0; j<cols; j++) {

        TextBox t = a.get(j);
        if (t!=null)t.draw();
      }
    }

    for (int i=0; i<Buttons.size(); i++) {
      Button b = Buttons.get(i);

      b.draw();
      b.self_click3();
    }
    Button b = null;
    if(buttons.size()>0){b = Buttons.get(0);
    b.self_click3();
      
    if(b.toggle==1){
      for (int i=0; i<rows; i++) {
      ArrayList<TextBox> a = gridarray.get(i);
      
      for (int j=0; j<cols; j++) {

        TextBox t = a.get(j);
        int k = floor(random(0,10));
        if (t!=null){
          t.textBox = str(k);
          t.value = k;
      }}}b.toggle=0;}
    }
  };
  
  void old_button_functions(){
    
    //if(b.toggle==1){
    //      ArrayList<TextBox> temp = new ArrayList<TextBox>();
    //      for(int j=0;j<cols;j++){
            
    //        TextBox k = gridarray.get(0).get(0);
            
    //        temp.add(new TextBox(x + bw * j, y + h, k.w,k.h,10));
    //      }
    //  gridarray.add(temp);
    //  rows ++;
    //  h += bh;
    //  b.toggle=0;
    //  }
      
    //  Button b1 = Buttons.get(0);
      
    //  if(b1.toggle==1){
    //      for(int j=0;j<rows;j++){
            
    //        TextBox k = gridarray.get(0).get(0);
            
    //        gridarray.get(j).add(new TextBox(x + w, y + bh * j, k.w,k.h,10));
            
    //      }
      
    //  cols ++;
    //  w += bw;
    //  b1.toggle=0;
    //  }
    
  };
};
