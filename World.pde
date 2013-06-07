// GameOfLife, by Clément Hardouin

class World {
  
  Cell[][] oldCells;
  Cell[][] newCells;
  int w;
  int h;
  PShape worldShape;

  World(int worldWidth, int worldHeight) {
    
    w = worldWidth;
    h = worldHeight;
    
    oldCells = new Cell[h][w];
    newCells = new Cell[h][w];
  
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        newCells[y][x] = new Cell();
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
        updateNeighborhood(x, y);
      }
    }
    
  }

  void update() {
    // TODO : free oldCells ?
    oldCells = newCells;
    
    newCells = new Cell[h][w];
    
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        newCells[y][x] = oldCells[y][x].evolve();
      }
    }
    
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        updateNeighborhood(x, y);
      }
    }
  }

  void updateNeighborhood(int x, int y){
    
    // If x & y are in range
    if( (x>=0) && (x<w) && (y>=0) && (y<h) ){
      Cell cell = newCells[y][x];
      cell.neighbors.clear();
      // left
      if(x > 0){
        cell.neighbors.add(newCells[y][x-1]);
        // bottom left
        if(y > 0){
          cell.neighbors.add(newCells[y-1][x-1]);
        }
        // top left
        if(y < h-1){
          cell.neighbors.add(newCells[y+1][x-1]);
        }
      }
      // right
      if(x < w-1){
        cell.neighbors.add(newCells[y][x+1]);
         // bottom right
        if(y > 0){
          cell.neighbors.add(newCells[y-1][x+1]);
        }
        // top right
        if(y < h-1){
          cell.neighbors.add(newCells[y+1][x+1]);
        }
      }
      // bottom
      if(y > 0){
        cell.neighbors.add(newCells[y-1][x]);
      }
      // up
      if(y < h-1){
        cell.neighbors.add(newCells[y+1][x]);
      }
    }
  }

  void display() {
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        Cell cell = newCells[y][x];
        if(!cell.isDead()) {
          float p = ((float)cell.age / (float)cell.lifespan)*100;
          color c1 = color(100, 255, 100, 255-((p/100)*255) );
          
          fill(c1);
          noStroke();
          rect(cell.position.x*(width/w),cell.position.y*(height/h), (width/w)-1, (height/h)-1);
        } else {
          fill(40);
          noStroke();
          rect(cell.position.x*(width/w),cell.position.y*(height/h), (width/w)-1, (height/h)-1);
        }
      }
    }
  }
  
}

