
//Det første jeg har, er alle mine variabler:

//billeder
PImage menu; // menuen, jeg bruger
PImage load; //billedet der bliver loaded lige når programmet starter

//variabler der har noget med fortrydelse at gøre
PImage[] regrets;
int posInArray = 0;
int regretSize = 50;

//Dette variabel styrer hvilken funktion jeg er igang med at bruge. 
String mode;

//Disse variabler bliver brugt når jeg skal tegne en geometrisk figur.
int pointA1 = -1;
int pointA2 = -1;
int pointB1 = -1;
int pointB2 = -1;
int pointC1 = -1;
int pointC2 = -1;


//Variabler til normal tegning
int oldPointX = -1;
int oldPointY;
float strokeWeight = 1;

//Farve
color chosenColor;

//For slideren, som ændrer størrelse
int sliderPos = 10;
int rectSizeX = 10;
int rectSizeY = 30;



void setup() {
  //Setup sker lige når programmet starter. Her sætter jeg Colormode, størelse af skærmen
  colorMode(HSB);
  size(1600, 600);

  //jeg gør, så at smooth er 0(det gør det mindre blødt, men så kan jeg fill bedre)
  smooth(0);

  //laver en ny liste, der gemmer data så man kan fortryde senere hen.
  regrets = new PImage[regretSize];
  regrets[0] = getFrame();
  background(255);

  //her gør jeg åbenlyse ting, som at sætte mode til drawing og sætte de forskellige billeder til hvad de skal være.
  mode = "Drawing";
  menu = loadImage("Menu.png");
  load = loadImage("load.png");
  image(load, 0, 0);

  //Jeg kalder denne funktion for første gang. Denne funktion bliver brugt meget i koden og er den der viser/opdaterer menuen i venstre side.
  displayMenu();


  stroke(0);
}

void draw() {
  //her sker alt det, som skal opdateres hvert billede. Her har jeg lavet både spray og drawing.

  if (mousePressed && mode == "Spray" && mouseX > 200) {
    strokeWeight(1);
    float x, y, v, r; 
    for (int i = 0; i < 3; i++) { // jeg laver en for loop, da jeg gerne vil have det til at gå 3 gange så hurtigt med at spraye.

      //sætter random tal, da spray skal være tilfældigt.
      v = random(0, 2*PI);
      r = random(0, strokeWeight/2);

      //sætter x, og y for hvor punktet skal sættes
      x = r*cos(v);
      y = r*sin(v);

      //tegner spray punktet
      rect(mouseX+x, mouseY + y, 1, 1);
    }
  }

  if (mousePressed && mode == "Drawing" && mouseX > 200) {

    if (oldPointX == -1) { // dette sker kun lige når man begynder at tegne, da oldpoint derefter bliver lavet om.
      oldPointX = mouseX;
      oldPointY = mouseY;
    }

    //tegner en linje fra hvor musen var sidste frame(oldPoints) til hvor musen er nu.
    line(mouseX, mouseY, oldPointX, oldPointY);
    oldPointX = mouseX;
    oldPointY = mouseY;

    //hvis man kommer til at tegne over menuen, skal den opdateres, så man ikke lægger mærke til det.
    if (mouseX < 200 + strokeWeight/2) displayMenu();
  }
}

boolean inBetween(int a, int b, int c) {
  //Denne funktion er meget simpel, den checker om værdi c er mellem a og b.
  if (a < c && c < b) return true; 

  return false;
}



void colorPalette(int x, int y) {
  //denne funktion bliver kørt inde i displayMenu. Den tegner selve farvePaletten man kan vælge fra.

  fill(255);

  //her er en for-loop inde i en for-loop. Det gør at man kan holde styr på to variabler og tegne 2-dimensionelt. 
  //Det der sker på en frame er, at den tegne alle ting en række ad gangen.
  for (int i = 0; i < 190; i++) { 
    for (int j = 0; j < 200; j++) {
      fill((float)(255/189)*(float)i, (float)(255/199)*(float)j, 255);
      if (inBetween(0, 10, i) && inBetween(-1, 10, j)) fill(0, 0, 0);
      if (inBetween(10, 20, i) && inBetween(-1, 10, j)) fill(0, 0, 255);
      noStroke();
      rect(i+x, j+y, 1, 1);
    }
  }
  //slutter af med at sætte farven til det den var før, så brugeren ikke mærker forskel.
  fill(chosenColor);
}

void displayMenu() {
  //Denne funktion er den der tegner menuen op, hver gang der er brug for det.

  //Den sætter menubilledet ind.
  image(menu, 0, 0);

  //tegner palletten.
  colorPalette(5, 400);

  //tegner slideren til størrelsesvalg
  drawWidthSlider();

  //sætter farve af praktiske grunde
  fill(0);
  noStroke();

  //tegner firkant, hvis spray er aktiveret.
  if (mode == "Spray") rect(150, 160, 25, 25);

  //tegner cirkel der hvor farven man har valgt er. Det kan man da jeg kom frem til farven ved at få en position. 
  //Derfor kan jeg også komme frem til en position hvis jeg får en farve.
  circle(hue(chosenColor) / (255/189) + 5, saturation(chosenColor) / (255/189) + 400, 20);
  fill(chosenColor);
  circle(hue(chosenColor) / (255/189) + 5, saturation(chosenColor) / (255/189) + 400, 10);
  stroke(chosenColor);
}



void mousePressed() {
  if (mouseX < 200) { 
    //den første del af mousePressed er hvis man klikker et sted på menuen.

    // alle punkter bliver nulstillet til når de skal bruges igen.
    pointA1 = -1;
    pointA2 = -1;
    pointB1 = -1;
    pointB2 = -1;
    pointC1 = -1;
    pointC2 = -1;

    //Her checker jeg, om der bliver klikket på nogle af de ting på menuen.

    //firkant
    if (inBetween(0, 50, mouseY)) mode = "Rect";

    //trekant
    if (inBetween(50, 100, mouseY)) mode = "Tria";

    //cirkel
    if (inBetween(100, 150, mouseY)) mode = "Circle";

    //spray
    if (inBetween(150, 200, mouseY)) mode = (mode != "Spray")? "Spray" : "Drawing"; 
    print(mode); // hvis den allerede er på spray, så skal den deaktivere det. Ellers skal den slå det til. Der er er en 

    //ryd skærm
    if (inBetween(200, 250, mouseY)) {
      background(255);
      mode = "Drawing";
    }

    //fortryd
    if (inBetween(250, 300, mouseY)) {
      if (posInArray > 0) { // hvis position i en liste er over 0, altså at der er noget data fra før det billede man er på..
        //.. så går man en tilbage i listen of viser det billede der er der.
        posInArray--;
        image(regrets[posInArray], 0, 0);
      }
    }
    //farvepaletten
    if (inBetween(400, 600, mouseY)) {
      int i = mouseX -5;
      int j = mouseY -400;

      //her regner jeg farven ud, ud fra musens position på skærmen.
      chosenColor = color((float)(255/189)*(float)i, (float)(255/199)*(float)j, 255);

      //her laver jeg en undtagelse: hvis man enten klikker på den hvide eller den sorte firkant, så bliver ens farve sort eller hvid.
      if (inBetween(0, 10, i) && inBetween(-1, 10, j)) chosenColor = color(0, 0, 0);
      if (inBetween(10, 20, i) && inBetween(-1, 10, j)) chosenColor = color(0, 0, 255);
    }

    //slideren for størrelse
    if (inBetween(350, 400, mouseY)) {
      sliderPos = mouseX;
      strokeWeight = mouseX/2;
      strokeWeight(strokeWeight);
      stroke(chosenColor);
    }

    //til sidst opdatere jeg menuen for at tage hensyn til de forskellige ændringer der er blevet lavet.
    displayMenu();
  } else {
    //else er hvis man ikke klikker på menuen(så klikker man på tegnepladen)
    switch(mode) {

    case "Rect": // hvis man har valgt at tegne en firkant.
      strokeWeight(0);
      print(pointA1);
      placePoints(2);
      if (pointA1 != -1 && pointB1 != -1) {
        rect(pointA1, pointA2, -pointA1 + pointB1, -pointA2 + pointB2);
        mode = "Drawing";
      }
      break;


    case "Tria": // trekant
      strokeWeight(0);
      placePoints(3);
      if (pointA1 != -1 && pointB1 != -1 && pointC1 != -1) {
        triangle(pointA1, pointA2, pointB1, pointB2, pointC1, pointC2);
        mode = "Drawing";
      }

      break;

    case "Circle": // cirkel
      strokeWeight(0);
      placePoints(2);
      if (pointA1 != -1 && pointB1 != -1) {
        circle((float)pointA1, (float)pointA2, sqrt( pow((pointB1 - pointA1), 2) + pow((pointB2 - pointA2), 2))*2);
        mode = "Drawing";
      }
      displayMenu();

      break;   

    case "Drawing": //bare tegne
      strokeWeight(strokeWeight);  
      break;
    }
  }
}

void placePoints(int numberOfPoints) { 
  //dette er funktion der bliver kaldt, når man skal sætte punkterne til de forskellige geometriske figurer.
  if (pointA1 == -1) {
    pointA1 = mouseX;
    pointA2 = mouseY;
  } else if (pointA1 != -1 && pointB1 == -1 && numberOfPoints > 1) {
    pointB1 = mouseX;
    pointB2 = mouseY;
  } else if (numberOfPoints > 2) {
    pointC1 = mouseX;
    pointC2 = mouseY;
  }
}

void mouseReleased() { 
  //hvis musen bliver slippet, så gemmer man, så man senere kan fortryde, og så gør man så oldPoint, bliver -1,
  //så der ikke bliver lavet en akavet streg, når man skal til at tegne igen
  saveRegret();
  oldPointX = -1;
}


void saveRegret() {
  
  if (mouseX > 200 && posInArray < regretSize-1) { 
    //hvis man ikke er ved enden i listen, så tilføjer man bare til listen.
    posInArray++;
    print(posInArray);
    regrets[posInArray] = getFrame();
  } else if (mouseX > 200) {
    //hvis man er ved enden af listen, så skal alle elementer i listen rykkes en tilbage. Det sidste element bliver kasseret.
    for (int i = 0; i < regretSize-1; i++) {
      regrets[i] = regrets[i+1];
    }
    regrets[regretSize-1] = getFrame();
  }
}



void drawWidthSlider() {
  //simpel funktion, der tegner nogle figurer, så det ligner en slider.
  fill(0);
  rect(0, 375, 200, 2);
  rect(sliderPos - rectSizeX/2, 375-rectSizeY/2, 10, 30);
  fill(chosenColor);
}

PImage getFrame() {
  //denne funtion, tager en billede af skærmen, og så returnere den det billede. Bliver brugt når man skal gemme til fortrydelser.
  saveFrame("regret.png");
  return loadImage("regret.png");
}

void keyPressed() {
  //nogle shortcorts
  if (key==' ') {
    //hvis man klikker på mellemrum, så skal man fylde ud, ved at kalde på funktion fillBucket
    fillBucket();
    saveRegret();
  }
  if (key=='s') {
    //gemmer til mappen.
    saveFrame("save###.png");
  }
  if (key =='g') {
    //man får farven som man holder over
    chosenColor = get(mouseX, mouseY);
    fill(chosenColor);
    stroke(chosenColor);
    displayMenu();
  }
}
