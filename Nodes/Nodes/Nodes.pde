import org.processing.wiki.triangulate.*;

ArrayList triangles = new ArrayList();
ArrayList points = new ArrayList();

void setup() {
  size(2000, 2000);
  smooth();
  noLoop();
}

void draw() {
  model();
  view();
  saveFrame();
}

void model() {
  
  for (int i = 0; i < 1000; i++) {
    // PVector.z is used to store an angle (particle's direction)
    points.add(new PVector(random(-100, width + 100), random(-100, height + 100), random(TWO_PI)));
  }
  
  for (int i = 0; i < points.size(); i++) {
    PVector p = (PVector)points.get(i);
    // p.z is used to store an angle value (particle's direction)
    p.x += 2.0*cos(p.z);
    p.y += 2.0*sin(p.z);
    if (p.x < 0 || p.x > width) { p.z += PI; }
    if (p.y < 0 || p.y > height) { p.z += PI; }
  }
  
  // get the triangulated mesh
  triangles = Triangulate.triangulate(points);
  
}
  
void view() {
  
  background(0);    
 
  // draw the mesh of triangles
  stroke(255, 100);
  fill(255, 0);
  strokeWeight(1.25);
  beginShape(TRIANGLES);
 
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
    if (random(2) < 1 + 20*(i / triangles.size())) {i = i + int(random(10));}
  }
  
  endShape();
  
    noStroke();
  
  // draw the points
  for (int i = 0; i < points.size(); i++) {
    PVector p = (PVector)points.get(i);
    fill(0, 0, 0);
    ellipse(p.x, p.y, 10, 10);
    fill(255, 255, 255);
    ellipse(p.x, p.y, 5, 5);
  }
  
}

