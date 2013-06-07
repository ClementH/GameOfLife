// GameOfLife, by Clément Hardouin

GOLWorld world;
boolean play;

void setup() {
  size(480, 340, P2D);
  frameRate(10);
  
  orientation(LANDSCAPE);
  world = new GOLWorld(width/10,height/10);
  background(20);
} 

void draw () {
  
  if(play){
    world.update();  
  }
  world.display();
  
  fill(255);
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
}

void mouseDragged() {
  if( (mouseX>0) && (mouseX<width) && (mouseY>0) && (mouseY<height) ){
    if( mouseButton == LEFT ){
      world.newCells[mouseY/10][mouseX/10].state=1;
    }else{
      world.newCells[mouseY/10][mouseX/10].state=0;
    }
  }
}

void keyPressed() {
 if (key == ' ' && play) {
    play = false;
    frameRate(60);
  } else {
    play = true;
    frameRate(10);
  } 
 
}

void mousePressed(){
  play = false;
  frameRate(60);
}
void mouseReleased(){
  play = true;
  frameRate(10);
}
