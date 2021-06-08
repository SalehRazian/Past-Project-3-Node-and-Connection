//The movement is not with Sin function, it is with a a/b function
//Change in plan, a/b produce a curve shape
// I want a straight line
//The movement of all particles is the same with the same steps and same time
//The speed is the same for every particle

int num = 100;
//int vari = 3;
float cirsz = 100*100;
float smallang=20;

int timestep=1;
int time=0;

float step=1;
float eachstep=step/timestep;

boolean out_range=false;
boolean point_out_range=false;
boolean connection=true;

float[] ax = new float[num];
float[] ay = new float[num]; 

float[] ang = new float[num];
float[] nxtang = new float[num];

//float[] bx = new float[num];
//float[] by = new float[num]; 

void setup(){
  size(600,600);
  background(0);
  for(int i=0;i<num;i++){
    ax[i]=(float)Math.floor(Math.random()*width);
    ay[i]=(float)Math.floor(Math.random()*height);
    ang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
    nxtang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
  }
  
  //for(int i=0;i<num;i++){
    //  bx[i]=(float)(Math.random()*vari*2)-vari;
      //by[i]=(float)(Math.random()*vari*2)-vari;
  //}
}

void draw(){
  clear();
  stroke(255);
  strokeWeight(1);
  
  analyse_points(ax,ay,cirsz);
  //The angle change can be from small to big back to small or the nearest way yo reach it
  //I choose the nearest way to reach it
  for(int i=0;i<num;i++){
    ax[i]=ax[i]+((cos(radians(ang[i])))*eachstep);
    ay[i]=ay[i]+((sin(radians(ang[i])))*eachstep);
  }
  time++;
  if (time==(timestep-1)){
    time=0;
    for(int i=0;i<num;i++){
      angle_change(ang[i], smallang, nxtang[i]);
    }
  }
}

void analyse_points(float[] x,float[] y,float circle){
  
  for(int i=0;i<num;i++){
    
    connection = false;
    point_out_range=false;
    out_range=false;
    
    if(ax[i]>width+circle || ax[i]<0-circle || ay[i]>height+circle  || ay[i]<0-circle ){
        point_out_range=true;
    }
    
    for(int j=i+1;j<num;j++){
      
      out_range = false;
      
      float lnsz = (float)(Math.pow(x[i]-x[j],2)+Math.pow(y[i]-y[j],2));
      
      if((lnsz) < (circle)){
        stroke(((circle-lnsz)/circle)*255);
        line(ax[i],ay[i],ax[j],ay[j]);
      } else {
        out_range = true;
      }
      
      if(point_out_range == false || out_range == false){
        connection = true;
      }
      
    }
    if(connection==false){
      ax[i]=(float)Math.floor(Math.random()*width);
      ay[i]=(float)Math.floor(Math.random()*height);
      ang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
      nxtang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
    }
  }
  
}

void angle_change(float ang,float smallang, float nxtang){
  if (ang == -smallang || ang==360+smallang){
        ang=smallang;
      }
      float difang = nxtang-ang;
      if(difang==0){
        nxtang=(float)Math.floor(Math.random()*(360/smallang))*smallang;
      } else if (difang >= 90 && difang <= 270){
        ang=ang+smallang;
      } else {
        ang=ang-smallang;
      }
}
