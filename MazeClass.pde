class Maze {
  
  int[][] grid;
  boolean [][]visited;
  int rows,cols;
  
  Maze(int rows, int cols){
    this.rows = rows;
    this.cols = cols;
    grid = new int[rows][cols];
    visited = new boolean[rows][cols];
  }
  
void depthFirstGenerate(int r, int c) {
  // Start maze generation, do not mark visited here
  this.grid[r][c] = 1;  // Mark as part of the path
  
  // Possible directions to move (right, down, left, up)
  int[] directions = {0, 1, 2, 3};
  
  // Shuffle the directions array
  shuffleArray(directions);
  
  for (int dir : directions) {
    int newR = r;
    int newC = c;
    
    // Move in the direction
    if (dir == 0) newC += 2;  // Move right
    if (dir == 1) newR += 2;  // Move down
    if (dir == 2) newC -= 2;  // Move left
    if (dir == 3) newR -= 2;  // Move up
    
    // Check if the new position is within bounds and unvisited
    if (newR >= 0 && newR < rows && newC >= 0 && newC < cols && m.grid[newR][newC] == 0) {
      // Create a path by knocking down the wall
      this.grid[(r + newR) / 2][(c + newC) / 2] = 1;
      // Recursively generate the maze
      depthFirstGenerate(newR, newC);
    }
  }
}

void drawMaze(){
  // Draw the maze
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (grid[i][j] == 0) {
        fill(255);  // Wall
      } 
      
     else if(grid[i][j] == 4){fill(0,255,0);}
     else if(grid[i][j] == 5){fill(255,255,0);}
      else if(solving == true && grid[i][j] == 3){fill(0,0,255,150);}
      else {
        fill(0);  // Pathway
      }
      //stroke(0);
      noStroke();
      rect(j * cellSize, i * cellSize, cellSize, cellSize);
    }
  }
  
  // Draw the solution path if solving
  if (solving && currentStep < solutionPath.size()) {

    elapsedTime = ((millis()-startTime)-subtractTime)/1000;
    PVector p = solutionPath.get(currentStep);
    fill(255, 255, 0);  // Yellow for solution path
    noStroke();
   

   rect(p.y*cellSize,p.x*cellSize, cellSize, cellSize);
    currentStep++;
  }
  
  // If the maze is solved, stop solving
  if (solving && currentStep >= solutionPath.size()) {
    solving = false;
    noLoop();
    rsCheck.setSelected(false);
  rhfCheck.setSelected(false);
  djkCheck.setSelected(false);
  clicks_djk = 0;
  clicks_rs = 0;
  clicks_rhf = 0;
    this.reSolve();
  } 
}

void createStartEnd(){
   grid[0][0] = 1;
  grid[rows - 1][cols - 1] = 1;
}

void optimizePath() {
  
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      
     int chance = int(random(0,100));
     
     if(chance >= wallChance){
       grid[i][j] = 1;
     }
    }   
  }
  grid[rows-1][cols-2] = 1;
  grid[0][0] = 5;
  grid[rows-1][cols-1] = 4;
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
  grid[0][0] = 1;
  grid[rows - 1][cols - 1] = 1;

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
  
  for (int i = 0; i < rows; i++) {
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
