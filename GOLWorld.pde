// GameOfLife, by Clément Hardouin

class GOLWorld {
  
  GOLCell[][] oldCells;
  GOLCell[][] newCells;
  int w;
  int h;
  PShape worldShape;

  GOLWorld(int worldWidth, int worldHeight) {
    
    w = worldWidth;
    h = worldHeight;
    
    oldCells = new GOLCell[h][w];
    newCells = new GOLCell[h][w];
  
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        newCells[y][x] = new GOLCell();
        newCells[y][x].position = new PVector(x,y);
        if(random(0,1) > 1){
          newCells[y][x].state = 1;
        }else{
          newCells[y][x].state = 0;
        }
      }
    }
    
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        updateVoisins(x, y);
      }
    }
    
  }

  void update() {
    // TODO : free oldCells ?
    oldCells = newCells;
    
    newCells = new GOLCell[h][w];
    
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        newCells[y][x] = oldCells[y][x].evolve();
      }
    }
    
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        updateVoisins(x, y);
      }
    }
  }

  void updateVoisins(int x, int y){
    
    // If x & y are in range
    if( (x>=0) && (x<w) && (y>=0) && (y<h) ){
      GOLCell cell = newCells[y][x];
      cell.voisins.clear();
      // left
      if(x > 0){
        cell.voisins.add(newCells[y][x-1]);
        // bottom left
        if(y > 0){
          cell.voisins.add(newCells[y-1][x-1]);
        }
        // top left
        if(y < h-1){
          cell.voisins.add(newCells[y+1][x-1]);
        }
      }
      // right
      if(x < w-1){
        cell.voisins.add(newCells[y][x+1]);
         // bottom right
        if(y > 0){
          cell.voisins.add(newCells[y-1][x+1]);
        }
        // top right
        if(y < h-1){
          cell.voisins.add(newCells[y+1][x+1]);
        }
      }
      // bottom
      if(y > 0){
        cell.voisins.add(newCells[y-1][x]);
      }
      // up
      if(y < h-1){
        cell.voisins.add(newCells[y+1][x]);
      }
    }
  }

  void display() {
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        GOLCell cell = newCells[y][x];
        if(cell.state == 1){
          fill(255, 255, 100);
          stroke(100);
          rect(cell.position.x*10,cell.position.y*10, 10, 10);
        }else{
          fill(20,200);
          noStroke();
          rect((cell.position.x*10)+1,(cell.position.y*10)+1, 10, 10);
        }
      }
    }
  }
  
}

