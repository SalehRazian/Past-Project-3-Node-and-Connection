//The movement is not with Sin function, it is with a a/b function
//Change in plan, a/b produce a curve shape
// I want a straight line
//The movement of all particles is the same with the same steps and same time
//The speed is the same for every particle

int num = 200;
float circle = 120;
float cirsz = circle*circle;
float smallang=1;

int timestep=5;
int time=0;

float step=5;
float eachstep=step/timestep;

boolean[] range=new boolean[num];
boolean ox_link=false;
boolean[] connection=new boolean[num];

float[] x = new float[num];
float[] y = new float[num]; 

float[] ang = new float[num];
float[] nxtang = new float[num];

int[] intensity = new int[num];
int intensityDiv=10;

void setup(){
  size(1000,1000);
  background(0);
  for(int i=0;i<num;i++){
    x[i]=(float)Math.floor(Math.random()*width+(circle))-circle;
    y[i]=(float)Math.floor(Math.random()*height+(circle))-circle;
    ang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
    nxtang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
    connection[i]=false;
    range[i]=true;
    intensity[i]=0;
  }
  
}

void draw(){
  clear();
  stroke(255);
  strokeWeight(1);
  
  analyse_points();
  
  //The angle change can be from small to big back to small or the nearest wy yo reach it
  //I choose th9e nearest wy to reach it
  
  for(int i=0;i<num;i++){
    x[i]=x[i]+((cos(radians(ang[i])))*eachstep);
    y[i]=y[i]+((sin(radians(ang[i])))*eachstep);
    range[i]=true;
    if(x[i]>width+(circle*2) || x[i]<0-(circle*2) || y[i]>height+(circle*2) || y[i]<0-(circle*2) ){
      range[i]=false;
    }
    noStroke();
    if (intensity[i]>intensityDiv){
      fill((255));
    } else{
      fill((255/intensityDiv)*intensity[i]);
    }
    ellipse(x[i],y[i],5,5);
    intensity[i]=0;
    stroke(255);
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
      ox_link=false;
      
      float lnsz = (float)(Math.pow(x[i]-x[j],2)+Math.pow(y[i]-y[j],2));
      
      if((lnsz < cirsz) && (range[i] == true || range[j]==true) ){
        stroke(((cirsz-lnsz)/cirsz)*255);
        line(x[i],y[i],x[j],y[j]);
        ox_link=true;
        intensity[i]++;
        intensity[j]++;
        if (range[i] == true){
          connection[j]=true;
        }
      }
      if(range[i] == true || ox_link == true){
        connection[i]=true;
      }
    }
    if(connection[i] == false && range[i]==false){
      float position =(float)Math.floor(Math.random()*360);
      x[i]=(cos(radians(position))*((width+circle)/2))+(width/2);
      y[i]=(sin(radians(position))*((height+circle)/2))+(height/2);
      //x[i]=(float)Math.floor(Math.random()*width+(circle))-circle;
      //y[i]=(float)Math.floor(Math.random()*height+(circle))-circle;
      ang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
      nxtang[i]=(float)Math.floor(Math.random()*(360/smallang))*smallang;
      range[i]=true;
      intensity[i]=0;
    }
    connection[i]=false;
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
