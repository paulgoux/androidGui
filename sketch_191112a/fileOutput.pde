class fileOutput {
  PrintWriter output;
  boolean save, onMouseUp, mdown, debug, append, appendFile, match,append2,overWrite;
  int counter, counter2;
  File file;
  File[] SDcards ; 
  String location, filePath,folderPath = "";
  PApplet applet;
  
  
  fileOutput() {
    appendFile = true;
  };

  fileOutput(boolean a) {
    overWrite = true;
    appendFile = true;
  };

  fileOutput(PApplet applet,String location) {
    //appendFile = true;
    this.applet = applet;
    Activity activity = applet.getActivity();
    Context context = activity.getApplicationContext();
    SDcards = context.getExternalFilesDirs(null);
    checkLocation(location);
    open();
  };
  
  //currently unused
  fileOutput(String location, boolean m) {
    if(m)appendFile = true;
    checkLocation(location);
    //open();
    //file = dataFile(location);
    //filePath = file.getPath();
  };
  
  fileOutput(PApplet applet,String location, boolean m) {
    if(m)appendFile = true;
    
    this.applet = applet;
    Activity activity = applet.getActivity();
    Context context = activity.getApplicationContext();
    SDcards = context.getExternalFilesDirs(null);
    //println(SDcards.length);
    
    checkLocation(location);
    open();
    //file = dataFile(location);
    //filePath = file.getPath();
  };

  void checkLocation(String location){
    
    int count = 0;
    folderPath = SDcards[0].toString()+"//" +folderPath;
    for(int i=location.length()-1;i>-1;i--){
      char c = location.charAt(i);

      if(c=='\\'){
        folderPath = location.substring(0,i);
        this.location = location.substring(i,location.length());
        count ++;
        break;
      }
    }
    if(count==0)this.location = location;
    
    folderPath = SDcards[0].toString();
    this.location = this.location.replace("\\","");
    String s1 = folderPath;
    String s2 = this.location.replace("\\","");
    println("folder",folderPath,"file",location);


    println("checkLocation:",s1 + "/" + counter + "/" + s2);
  };

  void update(String folder, String file,int counter ){
    //filePath = folder + "\\" + file;
    this.folderPath = folder ;
    this.location = file;
    this.counter = counter;
    appendFile = false;
    overWrite = true;
  };

  void saveData() {
    if (mdown()) {
      checkFile( location, append);
    }
    if (mdown)
      output.println(mouseX + ",+ " + mouseY);
    close();
  };

  void open() {
    checkFile(location, append);
  };

  void write(String s) {
    //function to write without overwriting or append
    if(output!=null)
    {
      println("success",s);
      output.println(s);
      output.flush();
    }
    else print("Create Save File");
  };

  void write(float f) {
    output.println(str(f));
  };

  void write_(String s) {
    //function to overwrite file
    output.print(s);
    if(output!=null){
      println("success",s);
      output.flush(); // Writes the remaining data to the file
      output.close(); // Finishes the file
    }else println("failed",location,folderPath);
  };

  void write(String []s) {
    String s1 = "";
    for (int i=0; i<s.length; i++) {
      s1 += s[i];
    }
    if(s1!=null&&output!=null)output.println(s1);
  };

  void close() {
    if(output!=null){
      output.flush(); // Writes the remaining data to the file
      output.close(); // Finishes the file
    }else println(location,folderPath);
  };

  boolean onMouseUp() {
    boolean k = false;
    if (pos()&&!mousePressed&&onMouseUp) {
      onMouseUp = false;
    } else if (pos()&&mousePressed&&!onMouseUp) {
      output.println(counter);
      onMouseUp = true;
      k = false;
    } else if (onMouseUp&&!mousePressed) {
      k = true;
      onMouseUp = false;
      counter ++;
    }

    return k;
  };

  boolean mdown() {
    boolean k= false;
    if (mdown)k = false;
    if (mousePressed&&!mdown) {
      mdown = true;
      k = true;
    }
    if (!mousePressed)mdown = false;    
    return k;
  };

  boolean pos() {
    return mouseX>0&&mouseX<width&&mouseY>0&&mouseY<height;
  };

  void checkFile(String location, boolean append) {
    if (appendFile) {

      file = dataFile(folderPath + "/" + location);
      filePath = file.getPath();
      filePath = filePath.replace(location, "");
      String[] list = null;
      if(debug)println("checkFile");
      //println(filePath);
      if (listNames(filePath)!=null&&!match) {
        
        list = listNames(filePath);
        boolean b = false;
        for(int j=maxFolderSize;j>-1;j--){
          //println(j);
          if(b)break;
          counter = j;
          for (int i=list.length-1;i>-1; i--) {

            int n = int(list[i]);
            if (j == n){
              //println(j + ", " + list[i]);
              counter = j;
              b = true;
              break;
            }}}
          match = true;
          if(!b)counter = -1;
          if(counter>=0)counter = counter + 1;
          else counter = 0;
          
          //println(counter);
      }
      else{
       file = dataFile(folderPath + "/" + location);
       filePath = file.getPath();
       filePath = filePath.replace(location, ""); 
      }
      file = dataFile(folderPath + "/" + counter + location);
      filePath = file.getPath();
      appendFile = false;
      append = true;
    }
    if(file!=null&&(!file.exists()&&!append2)) {
      //output = createWriter("/data/" + folderPath + "/" + counter + location);
      //println("folderpath " + folderPath + "\\" + counter+"\\" + location);
    }

    if(overWrite||output == null){
      output = createWriter(folderPath + "/" + counter + "/"+ location);
      //println("new folderpath " + folderPath + counter + "\\" + location);
      file = dataFile(folderPath + "/" + counter + "/" + location);
      filePath = file.getPath();
      filePath = filePath.replace(location, ""); 
    }
    if (debug) println(filePath);
    try {

      FileWriter fw = new FileWriter(file, append);///true = append
      BufferedWriter bw = new BufferedWriter(fw);
      output = new PrintWriter(bw);
      println("success",output);
    }
    catch(IOException ioe) {
      System.out.println("Exception ");
      ioe.printStackTrace();
      println(filePath);
    }
  };
};

String[] listNames(String dir) {
  
  if(dir==null)return null;
  File file  = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
};

int totalFiles(String dir) {
  File file  = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names.length;
  } else {
    // If it's not a directory
    return -1;
  }
};

String getFileExtension(File file) {
  String fileName = file.getName();
  if(fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0)
  return fileName.substring(fileName.lastIndexOf(".")+1);
  else return null;
};
