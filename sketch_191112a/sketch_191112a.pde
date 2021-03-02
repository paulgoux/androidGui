
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
int W = 1340,H = 600;
tab tab1;
TextBox t1;
TextArea t2;
void settings(){
  
  size(W,H,P2D);
  //size(W,H,P2D);
};

void setup(){
  //orientation(LANDSCAPE);
  BMS = new BMScontrols(this);
  BMS.begin();
  
  tab1 = new tab(300,100,200,300,"tab1");
  tab1.toggle = true;
  tab1.visible = true;
  tab1.draggable = true;
  
  String []s = {"test","test","test"};
  Menu menu = new Menu(10,20,100,s);
  Dropdown dMenu = new Dropdown(10,90,100,s);
  tab1.add(menu);
  tab1.add(dMenu);
  
  t1 = new TextBox(400,200,100,40,10);
  t2 = new TextArea(700,200,100,40,10,20);
  
};

void draw(){
  fill(255);
  //background(BMS.bgcol);
  background(50);
  text(frameRate,50,100);
  BMS.run();
  BMS.menus.get(0).items.get(2).submenu.self_toggle(1);
  tab1.displayTab();
  t1.draw();
  t2.draw();
  //Reset();
  //if(mousePressed)println("bms",BMS.sliderBoxes.size());
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
