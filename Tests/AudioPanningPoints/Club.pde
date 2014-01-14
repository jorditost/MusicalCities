import ddf.minim.*;

class Club {
  
  String name;
  //Location location;
  PVector location;
  
  Minim minim;
  AudioPlayer player;
  
  Club(PApplet theParent, String theName, PVector theLocation) {
    // we pass this to Minim so that it can load files from the data directory
    minim = new Minim(theParent);
    name = theName;
    location = theLocation;
  }
  
  void display() {
    ellipse(location.x, location.y, 20, 20);
  }
  
  public void loadFile(String fileSrc) {
    player = minim.loadFile(fileSrc); 
  }
  
  public void loop() {
    player.loop(); 
  }
  
  
  // Set gain. Values between 0.0 - 1.0
  public void setGain(float gain) {
    
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
