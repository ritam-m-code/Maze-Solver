void shuffleArray(int[] array) {
  for (int i = array.length - 1; i > 0; i--) {
    int j = (int) random(i + 1);
    int temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
}


boolean stringInArray(String s, String[] all){
  for (String test : all){
    if (test.equals(s)){
      return true;
    }
  }
  return false;
}

void resetButtons(){
  showData = false;
  selectedAlgo = "";
  algoName = "";
  rsCheck.setSelected(false);
  rhfCheck.setSelected(false);
  djkCheck.setSelected(false);
  clicks_djk = 0;
  clicks_rs = 0;
  clicks_rhf = 0;
  
}

void display(){
  fill(170,0,255);
  
  rect(cols*cellSize,0,cellSize/2,height);
  rect(cols*cellSize,0,width-(cols*cellSize),cellSize/2);
  rect(cols*cellSize,height-cellSize/2,width-(cols*cellSize),cellSize/2);
  rect(width-cellSize/2,0,cellSize/2,height);
  
  
 // rect(0,rows*cellSize,width,cellSize/2);
 // rect(0,rows*cellSize,cellSize/2,height-(rows*cellSize));
//  rect(0,height-cellSize/2,width,cellSize/2);
//  rect(width-cellSize/2,rows*cellSize,cellSize/2,height-(rows*cellSize));

  
  fill(255);
  textSize(15);
   boldFont = createFont("Trebuchet MS Bold", 20);
  textFont(boldFont);
  textAlign(CENTER,CENTER);

  String time = nfc(elapsedTime,1);
  
  if(algoName != ""){
    text(algoName,width*5/6,(rows+2)*cellSize*2/3-300);
    
    textSize(15);
    text(endText,width*5/6,(rows+5.5)*cellSize*2/3-225);
    text(algoDes,width*5/6,(rows+10.5)*cellSize*2/3-150);
    if(stringInArray(selectedAlgo,algos) && showData == true){
      textSize(15);
      text("Time Taken: "+ time,width*5/6,(rows+3.5)*cellSize*2/3-275);
      text("Steps Taken: "+ currentStep,width*5/6,(rows+4.5)*cellSize*2/3-250);
       }
     }
     else{
       textSize(15);
       text(genDes,width*5/6,(height/2));
       
     } 
}
