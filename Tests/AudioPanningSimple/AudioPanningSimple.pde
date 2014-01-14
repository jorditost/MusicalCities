/**
  * This sketch demonstrates how to play a file with Minim using an AudioPlayer.
  * It's also a good example of how to draw the waveform of the audio.
  */

import ddf.minim.*;

Minim minim;
AudioPlayer player1, player2;

void setup()
{
  size(400, 400);
  
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player1 = minim.loadFile("mock.mp3");
  player2 = minim.loadFile("tost.wav");
  
  // play the file
  player1.loop();
  player2.loop();
}

void draw()
{
  background(0);
  
  for (int i = 0; i<width/2; i++) {
    int c = (int) map(i, 0, width/2, 255, 0);
    stroke(c,0,0);
    line(i, 0, i, height);
  }
  for (int i = width/2; i<width; i++) {
    int c = (int) map(i, width/2, width, 0, 255);
    stroke(0,0,c);
    line(i, 0, i, height);
  }
  
  noStroke();
  fill(200, 0, 0, 140);
  ellipse(mouseX, mouseY, 20, 20);
  
  // Master Gain with current value: 0.0 dB (range: -80.0 - 13.9794)
  player1.setGain(map(mouseX, 0, width, -40, 0));
  player2.setGain(map(mouseX, 0, width, 12, -40));
}
