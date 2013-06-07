// GameOfLife, by Clément Hardouin

class GOLCell {

  public ArrayList<GOLCell> voisins;
  public PVector position;
  
  public int state;
  
  GOLCell() {
    voisins = new ArrayList<GOLCell>();
    position = new PVector(0, 0);
    state = 0;
  }
  
  public GOLCell clone() {
    GOLCell clone = new GOLCell();
    clone.position = new PVector(position.x, position.y);
    clone.state = state;
    return clone;
  }
  
  public boolean isDead() {
    if (state <= 0) {
     return true;
    } else {
     return false;
    } 
  }
  
  public GOLCell evolve() {
    GOLCell newCell = clone();
    
    int nbAlive = 0;
    int nbDead = 0;
    for(int i = 0; i < voisins.size(); i++) {
     GOLCell voisin = voisins.get(i);
     if(voisin.isDead()){
       nbDead++;
     }else{
       nbAlive++;
     }
    }
    //Une cellule morte possédant exactement trois voisines vivantes devient vivante (elle naît).
    //Une cellule vivante possédant deux ou trois voisines vivantes le reste, sinon elle meurt.
    if(newCell.state == 0){
      if(nbAlive == 3){
         newCell.state = 1; 
      }
    }else{
      if(nbAlive != 2 && nbAlive != 3){
         newCell.state = 0; 
      }
    }
    return newCell;
  }
  
}
