// GameOfLife, by Clément Hardouin

/**
 * A cell evolve in a world with other cells and follow some rules to change its state (alive, dead, ...)
 */
class Cell {

  public PVector position;
  public float state;
  public int age;
  public int lifespan;
  
  // Each cell has some neighbors
  public ArrayList<Cell> neighbors;
  
  Cell() {
    neighbors = new ArrayList<Cell>();
    position = new PVector(0, 0);
    state = 0;
    age = 0;
    lifespan = floor(random(40, 100));
  }
  
  public Cell clone() {
    // Duplicate the cell. Don't clone neighbors /!\
    Cell clone = new Cell();
    clone.position = new PVector(position.x, position.y);
    clone.state = state;
    clone.age = age;
    clone.lifespan = lifespan;
    return clone;
  }
  
  public boolean isDead() {
    if (state <= 0) {
      // sorry for your loss
     return true;
    } else {
     return false;
    } 
  }
  
  public Cell evolve() {
    Cell newCell = clone();
    
    if(newCell.isDead()){
      lifespan = floor(random(40, 100));
      newCell.age = 0;
    }else{
      newCell.age++;
    }
    
    int nbAlive = 0;
    int nbDead = 0;
    
    for(int i = 0; i < neighbors.size(); i++) {
     Cell neighbor = neighbors.get(i);
     if(neighbor.isDead()){
       nbDead++;
     }else{
       nbAlive++;
     }
    }
    
    if(newCell.state == 0){
      // A dead cell with exactly three live neighbors becomes alive.
      if(nbAlive == 3){
         newCell.state = 1; 
      }
    }else{
      // A living cell with two or three live neighbors stay alive, otherwise it dies.
      if(nbAlive != 2 && nbAlive != 3){
         newCell.state = 0; 
      }
      
      // If it is 80 yo, it die
      if(newCell.age >= newCell.lifespan){
         newCell.state = 0; 
      }
    }
    
 
    return newCell;
  }
  
}
