void shuffleArray(int[] array) { //Function that shuffles elements in an array; used in choosing random directions to search
  for (int i = array.length - 1; i > 0; i--) {
    int j = (int) random(i + 1);
    int temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
}


boolean stringInArray(String s, String[] all){ //Check if a string S is an array
  for (String test : all){ //Checking the string through the array
    if (test.equals(s)){
      return true;
    }
  }
  return false;
}

void resetButtons(){ //Reset the maze
  showData = false;
  selectedAlgo = "";
  algoName = "";
  
  //Reset buttons and click counter
  rsCheck.setSelected(false); 
  rhfCheck.setSelected(false);
  djkCheck.setSelected(false);
  clicks_djk = 0;
  clicks_rs = 0;
  clicks_rhf = 0;
  
}

void display(){ //Function to display information 
  fill(170,0,255);
  
  rect(cols*cellSize,0,cellSize/2,height); //draw purple border around info section 
  rect(cols*cellSize,0,width-(cols*cellSize),cellSize/2);
  rect(cols*cellSize,height-cellSize/2,width-(cols*cellSize),cellSize/2);
  rect(width-cellSize/2,0,cellSize/2,height);
  
  
  fill(255); //Set text settings for display section
  textSize(15);
   boldFont = createFont("Trebuchet MS Bold", 20);
  textFont(boldFont);
  textAlign(CENTER,CENTER);

  String time = nfc(elapsedTime,1); //Format the time number into text 
  
  if(algoName != ""){ //If an algorithm is selected 
    text(algoName,width*5/6,(rows+2)*cellSize*2/3-300); //Display the algorithm name
    
    textSize(15);
    text(endText,width*5/6,(rows+5.5)*cellSize*2/3-225); //Display the text about solution status
    text(algoDes,width*5/6,(rows+10.5)*cellSize*2/3-150); //Display text for describing the selected algorithm
    if(stringInArray(selectedAlgo,algos) && showData == true){ //If an algorithm is solving
      textSize(15);
      text("Time Taken: "+ time,width*5/6,(rows+3.5)*cellSize*2/3-275); //Show the time taken
      text("Steps Taken: "+ currentStep,width*5/6,(rows+4.5)*cellSize*2/3-250); //Display what step the solver is on based on what index on the solution path array
       }
     }
     else{ //If there is no algorithm selected
       textSize(15);
       text(genDes,width*5/6,(height/2)); //Display the general text
       
     } 
}
