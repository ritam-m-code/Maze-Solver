class Maze { //Maze Class
  
  //Fields
  int[][] grid; //The grid where maze will be represented
  boolean [][]visited; //Grid used for solving algorithms to check paths
  int rows,cols; // # of rows and columns 
  
  //Constructor
  Maze(int rows, int cols){ 
    
    //Set fields
    this.rows = rows;
    this.cols = cols;
    grid = new int[rows][cols];
    visited = new boolean[rows][cols];
  }
  
void depthFirstGenerate(int r, int c) {
  // Start maze generation, do not mark visited here
  this.grid[r][c] = 1;  // Mark as part of the path
  
  int[] directions = {0, 1, 2, 3}; // Possible directions to move (right, down, left, up)
  
  
  shuffleArray(directions); // Shuffle the directions array
  
  for (int dir : directions) { //Go through each direction to branch out in all ways
    int newR = r; 
    int newC = c;
    
    // Move in the direction
    if (dir == 0) newC += 2;  // Move right
    if (dir == 1) newR += 2;  // Move down
    if (dir == 2) newC -= 2;  // Move left
    if (dir == 3) newR -= 2;  // Move up
       
    if (newR >= 0 && newR < rows && newC >= 0 && newC < cols && m.grid[newR][newC] == 0) { // Check if the new position is within bounds and unvisited
      
      this.grid[(r + newR) / 2][(c + newC) / 2] = 1; // Create a path by knocking down the wall
      
      depthFirstGenerate(newR, newC); // Recursively generate the maze
    }
  }
}

void drawMaze(){
  // Draw the maze
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (grid[i][j] == 0) { //If the value in the maze is set as 0
        fill(255);  // White for wall
      } 
      
     else if(grid[i][j] == 4){fill(0,255,0);} //If the value is set as 4, make it green to show the end
     else if(grid[i][j] == 5){fill(255,255,0);} //If the value is set to 5, make the square yellow for the start square
      else if(solving == true && grid[i][j] == 3){fill(0,255,0,175);}  //If the value is set as 4, make it green to highlight the path during solving
      else {
        fill(0);  // movable squares
      }
      
      noStroke(); //Set no outline
      rect(j * cellSize, i * cellSize, cellSize, cellSize); //Draw the square with the earlier set color
    }
  }
  
  // Draw the solution path if solving
  if (solving && currentStep < solutionPath.size()) {

    elapsedTime = ((millis()-startTime)-subtractTime)/1000; //calculate the time by subtracting the current time from the time we started
    
    PVector p = solutionPath.get(currentStep); //Get the current step
    fill(255, 255, 0);  // Yellow for solution path
   
  //Draw the current square of the moving block
   rect(p.y*cellSize,p.x*cellSize, cellSize, cellSize);
    currentStep++; //Increment the current step
  }
  
  // If the maze is solved, stop solving
  if (solving && currentStep >= solutionPath.size()) {
    solving = false;//Set solving made to false 
    noLoop(); //pause drawing
    
    //Reset buttons, can't used the function as that does other things as well
    rsCheck.setSelected(false);
    rhfCheck.setSelected(false);
    djkCheck.setSelected(false);
    clicks_djk = 0;
    clicks_rs = 0;
    clicks_rhf = 0;
    this.reSolve();
  } 
}

void createStartEnd(){ //When solving becomes true, set the start and end to actual pathway squares instead of special blocks
   grid[0][0] = 1;
  grid[rows - 1][cols - 1] = 1;
}

void optimizePath() { //Function that uses wallChance from the slider to remove some walls
  
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      
     int chance = int(random(0,100)); //Generate a random number
     
     if(chance >= wallChance){ //If the generated number is less than the slider value
       grid[i][j] = 1; //Set it to a pathway piece
     } 
    }   
  }
  grid[rows-1][cols-2] = 1; //Ensure maze is solvable
  grid[0][0] = 5; //Mark the start 
  grid[rows-1][cols-1] = 4; //Mark the end
}

void setMaze() {
  // Reset the maze and related variables
  grid = new int[rows][cols];
  visited = new boolean[rows][cols];
  visitCount = new int[rows][cols];
  solutionPath.clear();
  currentStep = 0;
  solving = false;

  // Fill the maze with walls (0s)
  for (int i = 0; i < this.rows; i++) {
    for (int j = 0; j < this.cols; j++) {
      this.grid[i][j] = 0;
      visitCount[i][j] = 0;
      this.visited[i][j] = false;
    }
  }

  // Starting point (top left corner) and end point (bottom right corner)
  createStartEnd();

  // Generate the maze
  depthFirstGenerate(0, 0);
  
  //Make the path more complex
  optimizePath();
}

void reSolve() {
  // Reset flags and variables to prepare for a new algorithm
  solving = false;
  solutionPath.clear();
  subtractTime = 0;
  
  for (int i = 0; i < rows; i++) { //Loop through visited 2D array and set all squares to false
    for (int j = 0; j < cols; j++) {
     this.visited[i][j] = false; 
     visitCount[i][j] = 0;
    }
  }
  
    // Reset the maze: clear any path markings from previous solutions
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
     
      if (grid[i][j] == 3) {  // Reset the solution path markings (3 is the path)
        grid[i][j] = 1;
      }
      
    }
  }
  
    grid[0][0] = 5;
  grid[rows - 1][cols - 1] = 4;
  
}

}
