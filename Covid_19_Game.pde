
PImage background;
PImage finish;
PImage end;
boolean isStartPage = false;
Ball[] balls = new Ball[50];
ArrayList<Line> lines   = new ArrayList(); 
float coX[], coY[];  //for the fallen masks
int fallingspeedY=7;  //masks speed
float t=0;
int x=100;
int y=100;
int xspeed=5;
int yspeed=5;
int healthy=0;
int deadballs=0;

void setup() {
  size(900, 700);
  textSize(20);
  surface.setTitle("Coronavirus Game");
  background = loadImage("coronavirus.png");
  for (int i=0; i< balls.length; i++) {
    balls[i] = new Ball(random(width), random(height));
  }
  end = loadImage("sterilization4.jpg");
  finish = loadImage("surgical-mask.png");
  coX = new float[80];
  coY = new float[80];
  for (int i=0; i<80; i++) {
    coX[i] = 30*i;
    coY[i] = random(0, 1000);
  }
}

void draw()
{
  if (isStartPage == false)
    start_Page();
  else if (isStartPage == true)
  {
    //game started
    background(255);
    for (int i=0; i< lines.size(); i++) {
      lines.get(i).move();
      if (dist(mouseX, mouseY, lines.get(i).x, lines.get(i).y)<100 && keyPressed && key == ' ') {
        lines.remove(i);
        i--;
      }
    }
    for (int i=0; i<balls.length; i++) {
      balls[i].move();
      for (int j=0; j<balls.length; j++) {
        float d=dist(balls[i].x, balls[i].y, balls[j].x, balls[j].y);
        if (d<20 && i!= j) {
          if (balls[i].inf && !balls[j].inf && round(random(50))==1) {
            balls[j].inf=true;
          }
        }
        if (d<20 && i!= j) {
          if (balls[j].inf && !balls[i].inf && round(random(50))==1) {
            balls[i].inf=true;
          }
        }
      }
    }
    push();
    strokeWeight(30);
    if (mousePressed) { 
      lines.add(new Line(mouseX, mouseY, pmouseX, pmouseY));
    }
    pop();
    healthy=0;
    deadballs=0;
    for (int i=0; i< balls.length; i++) {
      if (balls[i].healthy) {
        healthy++;
      }
      if (balls[i].dead) {
        deadballs++;
      }
      if (healthy+deadballs == balls.length) {
        background(255);
        display();
      }
    }
  }
}

/////////////////////////////////////////////////////
void start_Page()
{
  image(background, 0, 0, width, height);
  push();
  fill(255);
  text("Healthy \nInfected \nRecovered \nDead", width-170, 55);
  noStroke();
  fill(0, 255, 0);
  ellipse(width-200, 50, 20, 20);
  fill(255, 0, 0);
  ellipse(width-200, 80, 20, 20); //height+30 of the above ball
  fill(255, 255, 0);
  ellipse(width-200, 110, 20, 20);
  fill(0);
  ellipse(width-200, 140, 20, 20);
  pop();
  fill(255);
  text(" Rules: \n Draw lines to isolate the infected. \n Spacebar to erase lines.", 50, 50);
  push();
  fill(255);
  noStroke();
  rect(80, 150, 200, 200);
  fill(0, 255, 0);
  ellipse(120, 250, 20, 20);
  fill(255, 0, 0);
  ellipse(240, 250, 20, 20);
  pop();
  fill(0);
  strokeWeight(8);
  line(180, 150, 180, frameCount%(200)+150);
  //start button
  push();
  noStroke();
  fill(0);
  ellipse(width/2, height-200, 150, 100);
  fill(255);
  textSize(40);
  text("Start", width/2 -40, height-190);
  pop();
  float distance=dist(mouseX, mouseY, width/2, height-200);
  if ( distance<75) {
    
    push();
    fill(0);
    ellipse(width/2, height-200, 150, 100);
    translate(0, -2);
    fill(255);
    textSize(40);
    text("Start", width/2 -40, height-190);
    scale(13);
    fill(0);
    ellipse(width/2, height-200, 150, 100);
    pop();
    
  }
  if (mouseX > (width/2)-75 && mouseX < (width/2)+75 && mouseY > height-250 && mouseY < height-150 && mousePressed)
    isStartPage = true;
}

/////////////////////////////////////////////////////
void display() {
  push();
  background(255);
  image(end, 100, 100, width-200, height-100);
  fill(0);
  textSize(70);
  text("DONE!!  ALL IS CLEAN", 120, height-600);
  for (int i=0; i<80; i++) {
    image(finish, coX[i], coY[i], 70, 70);
    if (coY[i] > height) {
      coY[i] = 0;
    }
  }
  for (int i=0; i<80; i++) {
    coY[i] += fallingspeedY;
  }
  pop();
  //restart button
  push();
  noStroke();
  fill(0);
  ellipse(width-175, height-280, 150, 100);
  fill(255);
  textSize(30);
  text("Re-Start", width-230, height-270);
  if (mouseX > width-250 && mouseX < width-100 && mouseY > height-330 && mouseY < height-230 && mousePressed)
  {
    isStartPage = false;
    lines   = new ArrayList();
    setup();
  }
  pop();
  //exit button
  push();
  noStroke();
  fill(0);
  ellipse(width-175, height-150, 150, 100);
  fill(255);
  textSize(30);
  text("Exit", width-200, height-140);
  pop();
  if (mouseX > width-250 && mouseX < width-100 && mouseY > height-200 && mouseY < height-100 && mousePressed)
    exit();
}

/////////////////////////////////////////////////////
