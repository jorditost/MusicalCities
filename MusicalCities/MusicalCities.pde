import java.util.ArrayList;

import processing.core.PApplet;
import de.fhpotsdam.unfolding.UnfoldingMap;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.utils.MapUtils;
import de.fhpotsdam.unfolding.utils.ScreenPosition;
import de.fhpotsdam.unfolding.utils.GeoUtils;
import de.fhpotsdam.unfolding.providers.*;

  
UnfoldingMap map;
ArrayList<Club> clubs;

public void setup() {
  size(1200, 1000);
  
  String mbTilesConnectionString = "jdbc:sqlite:";
  mbTilesConnectionString += sketchPath("data/BERLIN_RAILS_STREETS.mbtiles");

  map = new UnfoldingMap(this, new MBTilesMapProvider(mbTilesConnectionString));
  map.zoomAndPanTo(new Location(52.49, 13.44), 14);
  MapUtils.createDefaultEventDispatcher(this, map);

  clubs = loadClubsFromCSV("clubs_berlin.csv");
}

public void draw() {
  map.draw();
    
  noStroke();

  for (Club club : clubs) {
    ScreenPosition pos = map.getScreenPosition(club.location);
    
    if (club.hasTracklist()) {
      fill(255,0,0, 150);
      ellipse(pos.x, pos.y, 20, 20);
    } else {
      fill(255,255,255, 150);
      ellipse(pos.x, pos.y, 10, 10);
    }
  }
}

void mouseMoved() {
  
  for (Club club : clubs) {
    
    if (club.hasTracklist()) {
      ScreenPosition pos = map.getScreenPosition(club.location);
      
      // Get geo-location at mouse position
      Location pointerLocation = map.getLocation(mouseX, mouseY);
      
      // Calculate distance between mouse position and club
      float distance = (float)GeoUtils.getDistance(club.location, pointerLocation);
      
      // Set gain - Max. Distance: 0.6
      club.setGain(map(distance, 0.0, 0.6, 1.0, 0.0));
      
      // Check distance
      //float distance = dist(mouseX, mouseY, pos.x, pos.y);
      //club.setGain(map(distance, 20, 500, 1.0, 0.0));
    }
  }
  
  println(" ");
}

public ArrayList<Club> loadClubsFromCSV(String fileName) {
  ArrayList<Club> clubs = new ArrayList<Club>();

  String[] rows = loadStrings(fileName);
  for (String row : rows) {
    // Reads country name and population density value from CSV row
    String[] columns = row.split(",");
    if (columns.length >= 2) {
      Club club = new Club();
      club.name = columns[0];
      float lat = Float.parseFloat(columns[1]);
      float lng = Float.parseFloat(columns[2]);
      club.location = new Location(lat, lng);
      
      // Tracklist
      if (club.name.equals("Bei Roy")) {
        println("Load track for Bei Roy");
        club.loadFile(this, "audio/accidente.mp3");
      } else if (club.name.equals("about:blank")) {
        println("Load track for about:blank");
        club.loadFile(this, "audio/mock.mp3");
      } else if (club.name.equals("Rosi's")) {
        println("Load track for Rosi's");
        club.loadFile(this, "audio/emo.mp3");
      } else if (club.name.equals("Festsaal Kreuzberg")) {
        println("Load track for Festsaal Kreuzberg");
        club.loadFile(this, "audio/tost.wav");
      }
      
      clubs.add(club);
    }
  }

  return clubs;
}


