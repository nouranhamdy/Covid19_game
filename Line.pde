// line is a class used to define a line using  start_point(x,y) and end_point(px,py)  
class Line {
  float x;
  float y;
  float px;
  float py;
  Line(float xx, float yy, float px, float py) {
    this. x =xx;
    this.y =yy;
    this.px =px;
    this.py =py;
  }
  void move() {
    strokeWeight(10);
    line(x, y, px, py);
  }
}
