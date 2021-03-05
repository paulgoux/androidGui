ArrayList<Window> windows = new ArrayList<Window>();
ArrayList<Menu> menus = new ArrayList<Menu>();
ArrayList<Button> buttons = new ArrayList<Button>();
ArrayList<Slider> Sliders = new ArrayList<Slider>();
ArrayList<PImage> images = new ArrayList<PImage>();
ArrayList<Boundary> boundaries = new ArrayList<Boundary>();
ArrayList<TextArea> textboxes = new ArrayList<TextArea>();
ArrayList<TextBox> textb = new ArrayList<TextBox>();

String[] Lines ;
String hello = "hello",Location;
int gw = 25,gh = 20,clipboard_toggle,ctrl=0,totalraces,maxFolderSize = 1000;
color backgroundcol = 51;
boolean gridtype,restart,open_menus,Terrain3d = false,xdown,ydown,leftdown,copy_clipboard,selectAll,pastedown,Qgrid = false,wrap = false,globaldown,
        camOpen,gridCreated;
float kkkk = 0.1;
String clipBoard=""; 
//important
//String[] cameras = Capture.list();
public final int IMAGES = 0,VIDEOS = 2,AUDIO = 1,MOVIE = 4,SOUND = 3,CAM = 6;
Button reset,yes,no;
Button grav;
Window header,main,rightmenu,leftmenu,footer,fmenu;
Grid g,g2,gterrain,gplain;
Boundary lines;
Boundary l1 = new Boundary(20,20,100,100,4);
Menu file,gridbox,plotbox,reset_dialogue,shapes,physics,mapMenu,Entities_sub,menu1,imgsliderMenu,sliderMenu,
     neuralNetworkMenu,Entities_debug,Entities_sublist,twitter;
color bgcol = color(50);
sliderBox sliderbox,fRate,imgsliderList, cammenuList;
listBox list1,shapesList;
Dropdown d1,d2;
