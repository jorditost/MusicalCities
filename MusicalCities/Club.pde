import ddf.minim.*;

class Club {
  
  String name;
  Location location;
  
  Minim minim;
  AudioPlayer player;
  
  Club() {
  }
  
  Club(PApplet theParent, String theName, Location theLocation) {
    name = theName;
    location = theLocation;
  }
  
  public void loadFile(PApplet theParent, String fileSrc) {
    // we pass this to Minim so that it can load files from the data directory
    minim = new Minim(theParent);
    player = minim.loadFile(fileSrc); 
  }
  
  public Boolean hasTracklist() {
    return (minim != null && player != null); 
  }
  
  public void loop() {
    player.loop(); 
  }
  
  
  // Set gain. Values between 0.0 - 1.0
  public void setGain(float gain) {
    
    if (player == null) return;
    
    if (gain == 0.0) {
      player.pause();
    } else {
      if (!player.isPlaying()) {
        player.play();
      }
      player.setGain(map(gain, 0.0, 1.0, -40, 0)); 
    }
  }
  
}
