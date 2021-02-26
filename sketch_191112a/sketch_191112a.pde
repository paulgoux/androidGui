
import java.io.BufferedWriter;
import java.io.FileWriter;

PApplet app = this;
BMScontrols BMS;

import java.io.*;
import java.net.*;
import processing.core.PApplet;

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

 
boolean k1 = false;
PImage img;
//SetFieldValueExample n = new SetFieldValueExample();
int W = 1440,H = 600;
void settings(){
  
  size(W,H,P2D);
  //size(W,H,P2D);
};

void setup(){
  //orientation(LANDSCAPE);
  BMS = new BMScontrols(this);
  BMS.begin();
  
  
};

void draw(){
  fill(255);
  //background(BMS.bgcol);
  background(0);
  text(frameRate,50,100);
  BMS.run();
  //Reset();
  for(Menu menu : BMS.menus)menu.click();
};




void mousePressed(){
  
};

//void mouseReleased(){
  
//};

//void mouseClicked(){
//  BMS.click();
//};

//void mouseDragged(){
  
//  //file.dpos();
//  //BMS.slider_functions();
//};
