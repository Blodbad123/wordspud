char letter;
String word = "";
String intro = "Hi Quick Quick Obey - Use me for lyrics"; 
String[] words = new String[1000]; 
String[] finalWords; 
int[] textSizes = new int[words.length];
float[] textPositionsX = new float [words.length]; 
int[] alphaValues = new int[words.length]; 
int wordCount = 0; 
int maxWords = 21; 

// Hor fast the words should fade out. Can just be altered to fit. 
float decreaseVal = 1.2; 

int spacingToAdd = 35; 
int textPosY = 34; 
int sizeOfText = 30; 
int sizeToAdd = 10; 
float minusAlpha = 0.02;
boolean enterType = false; 


void setup() {
  size(1200, 800);
  background(0); 
  textSize(sizeOfText);
  text(intro, width/4, 70);
  textAlign(CENTER);
  stroke(255); 
  strokeWeight(7); 
  line(0, 700, width, 700); 


  for (int i = 0; i < alphaValues.length; i++) {
    alphaValues[i] = 255;
  }
}

void draw() {
}
void keyTyped() {
  intro = ""; 
  if ((key >= 'A' && key <= 'z') || key == ' ') {
    letter = key;
    word = word + key;
    enterType = false; 
    AddWordToBackground();
  }

  if (key == BACKSPACE && word.length() != 0) {
    word = word.substring(0, word.length()-1); 
    AddWordToBackground();
  }
  textSize(sizeOfText); 
  text(word, 0, height-65, width, 50);
}

void keyPressed() {
  if (key == ENTER) {  
    AddToWords(word); 
    word = "";
    enterType = true; 
  }
}

void mousePressed(){
  saveFrame("Snapshot("+hour()+"_"+minute()+"_"+day()+"_"+month()+"_"+year()+").png");


  finalWords = new String[wordCount]; 
  for (int i = 0; i < finalWords.length; i++) {
    finalWords[i] = words[i];
  }
  saveStrings("LyricsIspiration("+hour()+"_"+minute()+"_"+day()+"_"+month()+"_"+year()+").txt", finalWords);
}


void AddToWords(String input) {
  textSize(int(random(14, 50))); 
  words[wordCount] = input; 
  textPositionsX[wordCount] = random(0, width - textWidth(words[wordCount]) + 20); 
  textSizes[wordCount] = int(random(14, 80)); 
  wordCount ++; 
  AddWordToBackground();
}

void AddWordToBackground() {
  background(0); 
  stroke(255); 
  strokeWeight(7);
  line(0, 700, width, 700); 
  textPosY = 34;
  for (int i = 0; i < wordCount; i++) {
    textSize(textSizes[i]); 
    fill(255, 255, 255, alphaValues[i]); 
    text(words[i], textPositionsX[i], textPosY, textWidth(words[i]) +20, 100); 
    if (textPosY < 700) {
      textPosY += spacingToAdd;
    } else {
      textPosY = 34;

      for (int j = 0; j < wordCount-maxWords; j++) {
        // Begin to fade out first text portions and slowly fade out more and more. 
        alphaValues[j] -= decreaseVal;
      }
    }
  }
}
