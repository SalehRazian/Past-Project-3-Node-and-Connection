//The movement is not with Sin function, it is with a a/b function
//Change in plan, a/b produce a curve shape
// I want a straight line
//The movement of all particles is the same with the same steps and same time
//The speed is the same for every particle

int num = 100;
float circle = 120;
float cirsz = circle*circle;
float smallang=20;

int timestep=1;
int time=0;

float step=1;
float eachstep=step/timestep;

boolean x_range=false;
boolean o_range=false;
boolean ox_link=false;
boolean[] connection=new boolean[num];

float[] x = new float[num];
float[] y = new float[num]; 

float[] ang = new float[num];
float[] nxtang = new float[num];

void setup(){
  size(600,600);
  background(0);
  for(int i=0;i<num;i++){
    x[i]=(float)Math.floor(Math.random()*width);
    y[i]=(float)Math.floor(Math.random()*height);
    ang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
    nxtang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
  }
  
}

void draw(){
  clear();
  stroke(255);
  strokeWeight(1);
  
  analyse_points();
  //The angle change can be from small to big back to small or the nearest wy yo reach it
  //I choose the nearest wy to reach it
  for(int i=0;i<num;i++){
    x[i]=x[i]+((cos(radians(ang[i])))*eachstep);
    y[i]=y[i]+((sin(radians(ang[i])))*eachstep);
  }
  time++;
  if (time==timestep){
    time=0;
    angle_change();
  }
}

void analyse_points(){
  
  for(int i=0;i<num;i++){

    for(int j=i+1;j<num;j++){
      
      float lnsz = (float)(Math.pow(x[i]-x[j],2)+Math.pow(y[i]-y[j],2));
      
      if((lnsz) < (cirsz)){
        stroke(((cirsz-lnsz)/cirsz)*255);
        line(x[i],y[i],x[j],y[j]);
      } 
    }
  }
}

void angle_change(){
  for(int i=0;i<num;i++){
    if (ang[i] == -smallang || ang[i]==360+smallang){
      ang[i]=smallang;
    }
    float difang = nxtang[i]-ang[i];
    if(difang==0){
      nxtang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
    } else if (difang >= 90 && difang <= 270){
      ang[i]=ang[i]+smallang;
    } else {
      ang[i]=ang[i]-smallang;
    }
  }
}
