import processing.video.*;
import blobDetection.*;

Capture cam;
BlobDetection theBlobDetection;
PImage img;
boolean newFrame=false;

// TODO: Create a config object
// TODO: Support irregular polygons
PVector[] vertex = new PVector[2];
int currentVertex = 0;
PVector ratio = new PVector(1,1);
boolean calibrated = false;

void setup()
{
  vertex[0] = new PVector(0,0);
  vertex[1] = new PVector(0,0);
  String[]cameras = Capture.list();
  size(displayWidth, displayHeight);
  cam = new Capture(this, cameras[0]);
  cam.start();

  img = new PImage(320, 160); 
  theBlobDetection = new BlobDetection(img.width, img.height);
  theBlobDetection.setPosDiscrimination(true);
  theBlobDetection.setThreshold(0.8f);
  background(0);
  noFill();
}

void captureEvent(Capture cam)
{
  cam.read();
  newFrame = true;
}

void draw()
{
  if (newFrame)
  {
    // TODO: Add background learning and substraction
    newFrame=false;
    img.copy(cam, 0, 0, cam.width, cam.height, 
    0, 0, img.width, img.height);
    fastblur(img, 1);
    theBlobDetection.computeBlobs(img.pixels);
    // TODO: Clean this function
    drawBlobsAndEdges(false, true);
  }
}

void mousePressed()
{
  if(currentVertex < 2) 
  {
  vertex[currentVertex].x = mouseX;
  vertex[currentVertex].y = mouseY;
  currentVertex++;
  }
  if(currentVertex == 2)
  {
    ratio.x = width/abs(vertex[1].x-vertex[0].x);
    ratio.y = height/abs(vertex[1].y-vertex[0].y);
    background(0);
    calibrated = true;
  }
}


