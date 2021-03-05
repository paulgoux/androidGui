public class Permission{
  
  PApplet parent;
  
  public boolean requestedPortraitImage = false;

  public Permission(PApplet pParent,String permissionName) {
    parent = pParent;
    parent.requestPermission("android.permission."+permissionName, "onPermissionResult", this);
    println(permissionName);
  };

  public void onPermissionResult(boolean granted) {
    if (!granted) {
      PApplet.println("User did not grant camera permission. Camera is disabled.");
    }
  };

};
