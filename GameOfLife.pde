// GameOfLife, by Clément Hardouin

int baseFrameRate = 60;
boolean play;

World world;
int cellSize = 10;
int evolveSpeed = 10;

// Init method
void setup() {
  frameRate(60);
  size(480, 340, P2D);
  background(20);
  orientation(LANDSCAPE);
  
  world = new World(width/cellSize,height/cellSize);
  pause();
  
} 

// Main loop
void draw () {
  // Evolve an display the world
  if(play){
    world.update();  
  }
  world.display();
  
  // Write stuff on screen
  fill(255);
  textSize(12);
  text("Frame rate: " + int(frameRate), 10, height - 10);
  text("SPACE : play/pause", 10, 20);
  text("MOUSE LEFT : rebirth cell", 10, 40);
  text("MOUSE RIGHT : kill cell", 10, 60);
  
  if(play){
    text("(play)", width-50, height - 10);
  }else{
    text("(pause)", width-65, height - 10);
  }
}

void mouseDragged() {
  // On pause, we can edit the world
  if( !play && (mouseX>0) && (mouseX<width) && (mouseY>0) && (mouseY<height)){
    if( mouseButton == LEFT ){
      world.newCells[mouseY/cellSize][mouseX/cellSize].state=1;
    }else{
      world.newCells[mouseY/cellSize][mouseX/cellSize].state=0;
    }
  }
}

void keyPressed() {
  // Play/Pause by pressing SPACE
  if (key == ' ' && play) {
    pause();
  } else {
    play();
  } 
 
}

void play(){
  play = true;
  // We limit the frame rate to control the evolve speed
  frameRate(evolveSpeed);
}
void pause(){
  play = false;
  // On pause, we don't care about the evolve speed. Let's speed this up.
  frameRate(baseFrameRate);
}

