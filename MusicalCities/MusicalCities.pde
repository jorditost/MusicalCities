  import java.util.ArrayList;

import processing.core.PApplet;
import de.fhpotsdam.unfolding.UnfoldingMap;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.utils.MapUtils;
import de.fhpotsdam.unfolding.utils.ScreenPosition;
import de.fhpotsdam.unfolding.providers.*;

  
  UnfoldingMap map;
  ArrayList<Club> clubs;

  public void setup() {
    size(1200, 1000);
    
    String mbTilesConnectionString = "jdbc:sqlite:";
  mbTilesConnectionString += sketchPath("data/BERLIN_RAILS_STREETS.mbtiles");

    map = new UnfoldingMap(this, new MBTilesMapProvider(mbTilesConnectionString));
    map.zoomAndPanTo(new Location(52.5, 13.4), 10);
    MapUtils.createDefaultEventDispatcher(this, map);

    clubs = loadClubsFromCSV("clubs_berlin.csv");
  }

  public void draw() {
    map.draw();
    
    
    noStroke();
    fill(255,255,255, 150);
    for (Club club : clubs) {
      ScreenPosition pos = map.getScreenPosition(club.location);
      ellipse(pos.x, pos.y, 10, 10);
    }

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
        clubs.add(club);
      }
    }

    return clubs;
  }

  class Club {
    String name;
    Location location;
    // ...
  }


