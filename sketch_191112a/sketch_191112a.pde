
import java.io.BufferedWriter;
import java.io.FileWriter;

PApplet app = this;
BMScontrols BMS;

import java.io.*;
import java.net.*;

//-------------hashmap---------------
//import java.util.Hashtable;
//import java.util.Map;
//import java.util.List;
//import java.util.Map.Entry;
//-------------------clipboard---------
//import java.awt.*;
//import java.awt.datatransfer.Clipboard;
//import java.awt.datatransfer.Transferable;
//import java.awt.datatransfer.DataFlavor;
//import java.awt.datatransfer.UnsupportedFlavorException;
//import java.awt.Toolkit;

//----------reflections-----------------
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.awt.*;
import java.lang.reflect.*;

import android.os.Environment;
import android.os.Build ;
import android.app.Activity;
import android.content.Context;

boolean k1 = false;
int W = 1440,H = 720;
tab tab1;

Permission storage,camera;
PGraphics canvas;
PShader edges;
KetaiCamera cam;
float counter,mult;
boolean mdown;

void settings(){
  
  size(W,H,P2D);
  //size(W,H,P2D);
};


void setup(){
  orientation(LANDSCAPE);
  canvas = createGraphics(W,H,P2D);
  edges = loadShader("edges.glsl");
  storage = new Permission(this,"WRITE_EXTERNAL_STORAGE");
  camera = new Permission(this,"CAMERA");
  cam = new KetaiCamera(this, 1440, 720, 60);
  BMS = new BMScontrols(this);
  BMS.begin();
  tab1 = new tab(500,200,200,300,"tab1");
  tab1.toggle = true;
  tab1.visible = true;
  tab1.draggable = true;
  
  String []s = {"test","test1","test2"};
  Menu menu = new Menu(10,40,100,s);
  menu.setRadius(5);
  Dropdown dMenu = new Dropdown(10,115,100,s);
  sliderBox s1 = new sliderBox(50,150,90,10,s,false);
  s1.menu.draggable = false;
  tab1.add(menu);
  tab1.add(dMenu);
  tab1.add(s1);
  tab1.setRadius(10);
  tab1.setAlignment("center");
  BMS.menus.get(0).setRadius(10);
  BMS.menus.get(0).setAlignment("center");
  
};

void draw(){
  fill(255);
  background(BMS.bgcol);
  //background(50);
  text(frameRate,50,100);
  
  displayCam();
  BMS.run();
  
  tab1.displayTab();
  
};

void onCameraPreviewEvent(){
  cam.read();
};
