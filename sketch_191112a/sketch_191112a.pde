import ketai.camera.*;
import ketai.cv.facedetector.*;
import ketai.data.*;
import ketai.net.*;
import ketai.net.bluetooth.*;
import ketai.net.nfc.*;
import ketai.net.nfc.record.*;
import ketai.net.wifidirect.*;
import ketai.sensors.*;
import ketai.ui.*;


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
tab tab1,tab2;

Permission storage,camera,readStorage;
PGraphics canvas;
PShader edges;
KetaiCamera Cam;
Camera cam;

float counter,mult;
boolean mdown;

void settings(){
  size(W,H,P2D);
};


void setup(){
  orientation(LANDSCAPE);
  canvas = createGraphics(W,H,P2D);
  edges = loadShader("edges.glsl");
  storage = new Permission(this,"WRITE_EXTERNAL_STORAGE");
  readStorage = new Permission(this,"READ_EXTERNAL_STORAGE");
  camera = new Permission(this,"CAMERA");
  BMS = new BMScontrols(this);
  BMS.begin();
  Cam = new KetaiCamera(this,W,H,60);
  cam = new Camera(Cam);
  
  
  tab2 = new tab(720,200,200,400,"Background");
  tab2.toggle = true;
  tab2.visible = true;
  tab2.draggable = true;
  tab2.scrollable = true;
  tab2.vscroll = true;
  
  String [] s3 = {"red","green","blue"};
  float [] v1 = {52, 235, 225};
  sliderBox sl2 = new sliderBox(0,40,90,90,10,s3,v1,0);
  sl2.menu.draggable = false;
  sl2.tooltip = null;
  sl2.setStart(0);
  sl2.setEnd(255);
  tab2.add(sl2);
  tab2.setAlignment("center");
  tab2.setRadius(10);
  
  BMS.dock.add(tab2);
  BMS.dock.setRadius(10);
  BMS.menus.get(0).setRadius(10);
  BMS.menus.get(0).setAlignment("center");
  
};

void draw(){
  fill(255);
  background(BMS.bgcol);
  //background(50);
  text(frameRate,50,100);
  cam.displayCam();
  logic();
  BMS.run();
  
};

void logic(){
  if(tab2.sliderBoxes.size()>0){
    Menu m1 = tab2.sliderBoxes.get(0).menu;
    Slider r = m1.sliders.get(0);
    Slider g = m1.sliders.get(1);
    Slider b = m1.sliders.get(2);
    BMS.bgcol = color(r.value,g.value,b.value);
  }
  
  BMS.selfToggle(0,0);
  tab2.sliderv.set(0,200);
  if(BMS.getToggle(0,0))
  tab2.displayTab();
};

void onCameraPreviewEvent(){
  cam.read();
};
