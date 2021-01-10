class Ball {
  float x; // x_coordiante 
  float y; // y_coordinate
  int time_to_recover=round(random(1000, 3000)); // this variable is initialized ith some random number and if the ball is infected this counter decreased each time draw is called until reach zero and ball is cured and turned yellow
  boolean dead=false;  // if ball dead it turn to black and do not move
  boolean movee=true; // check if ball move or stop
  boolean inf = (round(random(0, 20))==1) ? true : false;  // check if ball infected or not
  int die =round(random(20)); // initialize die variable randomly
  boolean healthy=true;
  float speedx = random(-1, 1);  // speed in x_direction
  float speedy = random(-1, 1); // spead in y_direction
  Ball(float xx, float yy) {
    x = xx;   //ball x position in the window
    y = yy;   //ball y position in the window
  }
  void move() {
    push();
    // check if balls collide with black line , then apply bouncing   
    if (get(int(x)+10, int(y)+10) == color(0, 0, 0)) {  
      speedx  *= -1;
      speedy  *= -1;
    }
    //  check boundry of screen to change direction
    if ((x > width) || (x < 0)) { 
      speedx  *= -1;
    }

    if ((y > height) || (y < 0)) {
      speedy  *= -1;
    }

    this.speedx += random(-0.1, 0.1);
    this.speedy += random(-0.1, 0.1);

    // if ball is infected then change color to read otherwise change color to green & reduce time_to_recover by 1
    if (this.inf) {
      fill(255, 0, 0);
      this.healthy=false;
      this.time_to_recover--;
    } else 
    fill(0, 255, 0); 

    // if time_to_recover less than zero , then ball is cured and its color is yellow
    if (this.time_to_recover <= 0) {
      this.inf = false;
      this.time_to_recover--;
      fill(255, 255, 0);
    }
    //check if all balls are recovered, color them with green
    if (this.time_to_recover<=-1000) {
      this.healthy=true;
      fill(0, 255, 0);
    }
    // if ball is moving change x ,y to simulate motion
    if (this.movee) {
      this.x += this.speedx;
      this.y += this.speedy;
    }
    noStroke();
    // if ball is already infected and die random variale is 1 and time_to_recover < 2000 , then the ball is dead
    if (this.inf && this.die==1 && this.time_to_recover<2000) {
      this.dead=true;
    }
    if (this.dead) {
      this.movee=false;
      fill(0);
    }
    ellipse(this.x, this.y, 20, 20);

    pop();
  }
}
