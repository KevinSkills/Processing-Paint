//Jeg har lavet en hel side dedikeret til fill, da jeg syntes det var kompliceret og havde brug for et overblik.


//fill varialber

Vector2[] mainPoints = new Vector2[1]; //det er den liste som indeholder de pixels, som man er igang med at checke
Vector2[] placeHolder; //den liste som indeholder de pixels man checker efter man har checket alle mainPoints.


void fillBucket(){
  //theColor er den farve man skal farvelægge
  color theColor = get(mouseX, mouseY);
  noStroke();
  
  //listen bliver nulstillet
  mainPoints[0] = new Vector2(mouseX, mouseY);
  
  while(mainPoints.length != 0){ // så længe, at der er nogle pixels at checke, så skal man fortsætte
    placeHolder = new Vector2[0]; //place holde bliver nulstillet, da man nu har checket alle mainPoints, og fortsætter med at køre while-loopen
    
    for (int i = 0; i < mainPoints.length; i++ ){ // i denne for-loop bliver alle mainPoints checket
      //finder punktets position
      int x = mainPoints[i].x;
      int y = mainPoints[i].y;
      
      
      // checker den for hver pixel, om der er nogle pixels ved siden af, som skal farves. 
      //Hvis disse pixels skal farves, så farv dem, og derefter tilføj dem til placeHolder, da de så skal gennemcheckes senere.
      if(get(x + 1, y) == color(theColor) ) {
        rect(x + 1, y, 1,1); placeHolder = (Vector2[])append(placeHolder, new Vector2(x + 1, y));
      }
      if(get(x -1, y) == color(theColor) ){
        rect(x - 1, y, 1,1); placeHolder = (Vector2[])append(placeHolder, new Vector2(x -1, y));
      }
      if(get(x, y + 1) == color(theColor) ){
        rect(x, y + 1, 1,1); placeHolder = (Vector2[])append(placeHolder, new Vector2(x, y + 1));
      }
      if(get(x, y - 1) == color(theColor) ){
        rect(x, y - 1, 1,1); placeHolder = (Vector2[])append(placeHolder, new Vector2(x, y -1));
      }
    }
    
    //efter man har checket alle mainPoints, skal man checke dem i placeHolder. Det gør man ved at lave mainPoints om til placeHolder.
    mainPoints = placeHolder;
    
  }
  //når alt er færdigt, så nulstiller man mainPoints, og sætter farven tilbage på stroke.
  mainPoints = new Vector2[1];
  stroke(chosenColor);
  

}




class Vector2{
  //dette object kan lagre 2 tal, som gør det meget brugbart, når man skal have en måde at gemme en position.
  int x = 0;
  int y = 0;
  
  Vector2(int x, int y){
    this.x = x;
    this.y = y;
  
  
  }



}
