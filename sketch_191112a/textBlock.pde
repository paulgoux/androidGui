class textBlock{
    boolean parentCanvas;
    public boolean vertical,horizontal ;
    public float x,y,w,h,offsetX,offsetY;
    public float tSize = 12;

    String [] text;
    String line;
    color col = color(0);

    textBlock(float x,float y,float w,float h){

        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;

    };

    textBlock(float x,float y,float w,float h,String[] s){

        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        text = s;
    };

    textBlock(float x,float y,float w,float h,String s){

        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        line = s;
    };

    textBlock(){

    };

    void draw(){
        if(text!=null);
        for(int i=0;i<text.length;i++){
            String s1 = text[i];
            fill(0);
            textSize(tSize);
            if(y + i*tSize - offsetY<y+h&&y + i*tSize - offsetY>0)text(s1,x + offsetX,y + i*tSize - offsetY);

        }
    
    };

    void draw(PGraphics canvas){
        //canvas.beginDraw();
        if(text!=null);
        for(int i=0;i<text.length;i++){
            String s1 = text[i];
            canvas.fill(col);
            canvas.textSize(tSize);
            if(y + i*tSize-offsetY<y+h&&y + i*tSize - offsetY>0)canvas.text(s1,x + offsetX,y + i*tSize - offsetY);
        }
        //canvas.endDraw();
    
    };

    void draw(PGraphics canvas,boolean a){
        canvas.beginDraw();
        if(text!=null);
        for(int i=0;i<text.length;i++){
            String s1 = text[i];
            canvas.fill(col);
            canvas.textSize(tSize);
            if(y + i*tSize-offsetY<y+h&&y + i*tSize - offsetY>0)canvas.text(s1,x + offsetX,y + i*tSize - offsetY);
        }
        canvas.endDraw();
    
    };
};
