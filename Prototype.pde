import SimpleOpenNI.*;
SimpleOpenNI  kinect;
ArrayList limitsList = new ArrayList();
float handpos;

float minThresh = 480;
float maxThresh = 1200;
PImage img;
boolean flowerReady = true;

int time;
int wait = 500;

void setup()
{
  fullScreen();
   // size(1920, 1080);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  kinect.setMirror(true);
  kinect.enableHand();
  time = millis();
  
}


void draw()
{
  kinect.update(); 
  img = kinect.userImage().get();
 // image(img, 0, 0);
//  PImage sceneImg = context.sceneImage();


 //background(0);

 img.loadPixels();

int[] depth = kinect.depthMap();

float sumX = 0;
float sumY = 0;
float totalPixels = 0;

for (int x = 0; x < img.width; x++) {
  for (int y = 0; y < img.height; y++) {
    int offset = x + y * img.width;
    int d = depth[offset];

    if (d > minThresh && d < maxThresh && x > 100) {
      img.pixels[offset] = color(255, 0, 150);

      sumX += x;
      sumY += y;
      totalPixels++;

    } else {
      img.pixels[offset] = color(0);
    }
  }
}



img.updatePixels();
//image(img, 0, 0);

float avgX = sumX / totalPixels;
float avgY = sumY / totalPixels;
//fill(150,0,255);
//ellipse(avgX, avgY, 64, 64);
avgX = avgX * 3;
avgY = avgY * 2.25;


strokeWeight(5);
stroke(51, 153, 51);
delay(30);

  fill(0,8);
  rect(-10,-10,width + 20,height + 10);
  
  //float bla = constrain(avgX, avgX-50, avgX+50);
  float spawn = random(avgX- 60 , avgX + 60);
  float bla = random(spawn- 10 , spawn + 10);
  //avgX = random(avgX + 10, avgX - 10);
//for (float i = avgX - 100; i < ; i += 2) {
 line(spawn, random(900,1000),bla, 1080 );

//}


//strokeCap(ROUND);



if(millis() - time >= wait){
  
if (flowerReady){
  flowerReady = false;
  drawFlower(avgX, random(900, 1000), random(2,5));
  flowerReady = true;
  time = millis();
}
}
}

int getRandomColor(){
 return color(random(120,255), random(255), random(255)); 
}
void drawFlower(float x, float y, float flowerSize){
  strokeWeight(flowerSize);
  stroke(getRandomColor());
  
  translate(x,y);
  for(int i = 0; i < 10; i++){
    rotate(TWO_PI / 10);
    line(0, 0, 3 * flowerSize,0);
    int m = millis();
     m = 1000;
     
}
strokeWeight(0);
fill(getRandomColor());
ellipse(0,0,1.5 * flowerSize, 1.5 * flowerSize);
}
