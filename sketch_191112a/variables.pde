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
Button btn1,btn2,btn3,reset,attractor,grid,d2_plot,d3_plot,btn4,btn5,btn6,btn7,btn8,btn9,yes,no;
Button btn10,btn11,btn12,btn13,btn14,btn15,btn16,btn17,btn18,btn19;
Button btn20,btn21,btn22,btn23,btn24,btn25,btn26,btn27,btn28,btn29;
Button btn30, btn31,btn32,btn33,btn34,btn35,btn36,btn37,btn38,btn39;
Button btn40, btn41,btn42,btn43,btn44,btn45,btn46,btn47,btn48,btn49;
Button btn50, btn51,btn52,btn53,btn54,btn55,btn56,btn57,btn58,btn59;
Button btn60, btn61,btn62,btn63,btn64,btn65,btn66,btn67,btn68,btn69;
Button btn70, btn71,btn72,btn73,btn74,btn75,btn76,btn77,btn78,btn79,
       btn80, btn81,btn82,btn83,btn84,btn85,btn86,btn87,btn88,btn89,
       btn90, btn91,btn92,btn93,btn94,btn95,btn96,btn97,btn98,btn99;
Slider sld1,sld2,sld3,sld4,sld5,sld6,sld7,sld8,sld9,
       sld10,sld11,sld12,sld13,sld14,sld15,sld16,sld17,sld18,sld19,
       sld20,sld21,sld22,sld23,sld24,sld25,sld26,sld27,sld28,sld29,
       sld30,sld31,sld32,sld33,sld34,sld35,sld36,sld37,sld38,sld39,
       sld40,sld41,sld42,sld43,sld44,sld45,sld46,sld47,sld48,sld49;
Button grav;
Window header,main,rightmenu,leftmenu,footer,fmenu;
TextArea textb1,textb2,textb3,textb4,textb5,textb6,textb7,textb8,textb9,textb10,textb11,textb12,textb13;
TextBox txtb1, txtb2,txtb3, txtb4, txtb5, txtb6, txtb7, txtb8, txtb9, txtb10;
Grid g,g2,gterrain,gplain;
Boundary lines;
Boundary l1 = new Boundary(20,20,100,100,4);
Menu file,gridbox,plotbox,reset_dialogue,shapes,physics,mapMenu,Entities_sub,menu1,imgsliderMenu,sliderMenu,
     neuralNetworkMenu,Entities_debug,Entities_sublist,twitter;
color bgcol = color(50);
sliderBox sliderbox,fRate,imgsliderList, cammenuList;
listBox list1,shapesList;
Dropdown d1,d2;
