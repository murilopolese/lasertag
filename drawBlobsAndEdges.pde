void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges)
{
  noFill();
  Blob b;
  EdgeVertex eA, eB;
  for (int n=0 ; n<theBlobDetection.getBlobNb() ; n++)
  {
    b=theBlobDetection.getBlob(n);
    if (b!=null)
    {
      // Edges
      if (drawEdges)
      {
        strokeWeight(3);
        fill(0, 150, 0);
        stroke(0, 150, 0);
        beginShape();
        for (int m=0;m<b.getEdgeNb();m++)
        {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
          if (eA !=null && eB !=null)
            if(calibrated)
            {
                // TODO: Fix this math
                vertex(
                (eA.x*width-vertex[0].x)*ratio.x, 
                (eA.y*height-vertex[0].y)*ratio.y); 
                vertex(
                (eB.x*width-vertex[0].x)*ratio.x, 
                (eB.y*height-vertex[0].y)*ratio.y);
            } else {
              vertex(eA.x*width, eA.y*height); 
              vertex(eB.x*width, eB.y*height);
            }
        }
        endShape(CLOSE);
        noFill();
      }

      // Blobs
      if (drawBlobs)
      {
        strokeWeight(1);
        stroke(255, 0, 0);
        rect(
        b.xMin*width, b.yMin*height, 
        b.w*width, b.h*height
          );
      }
    }
  }
}
