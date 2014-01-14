ArrayList<Club> clubsArray;

void setup()
{
  size(400, 400);
  
  clubsArray = new ArrayList<Club>();
  
  Club club1 = new Club(this, "post", new PVector(20, 20));
  club1.loadFile("audio/mock.mp3");
  clubsArray.add(club1);
  
  Club club2 = new Club(this, "punk", new PVector(width-20, 20));
  club2.loadFile("audio/accidente.mp3");
  clubsArray.add(club2);
 
  Club club3 = new Club(this, "emo", new PVector(20, height-20));
  club3.loadFile("audio/10-Loose-Cannons.mp3");
  clubsArray.add(club3);
  
  Club club4 = new Club(this, "math", new PVector(width-20, height-20));
  club4.loadFile("audio/tost.wav");
  clubsArray.add(club4);
}

void draw()
{
  for (Club club : clubsArray) {
    club.display();
  }
}

void mouseMoved() {
  
  for (Club club : clubsArray) {
    
    // Check distance
    float distance = dist(mouseX, mouseY, club.location.x, club.location.y);
    
    club.setGain(map(distance, 20, 500, 1.0, 0.0));
  }
}

