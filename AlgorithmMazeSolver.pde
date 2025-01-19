//IMPORTS
import g4p_controls.*;
import java.util.PriorityQueue;
import java.util.HashMap;
import g4p_controls.*;

int rows = 30;  // Number of rows in the maze
int cols = 30;  // Number of columns in the maze
int cellSize = 20;  // Size of each cell

int clicks_rhf = 0;
int clicks_djk = 0;
int clicks_rs = 0;

String[] algos = {"DJK","RS","RHF"};
int[][] visitCount;

Maze m = new Maze(rows,cols);


boolean solving = false;
boolean showData;

ArrayList<PVector> solutionPath;
int currentStep = 0;

float startTime = 0;
float storeTime = 0;
float elapsedTime = 0;
float subtractTime = 0;
int wallChance = 80;

String algoName = "";
String selectedAlgo = "";
PFont boldFont;
String endText;

String djkDes = "This uses Dijkstra's \n shortest path algorithm \n(used for google maps). \n It interprets the maze \nas a graph with \n each square being a node and \npaths between adjacent \n squares as edges. It then \nruns Dikjstra's algorithm on the \n  graph with equal edge weightings \n to find the shortest path \nfrom the given start to end squares. ";
String rhfDes = "This always turns right when it can, \n like the common advice \n given to someone lost. \n Though, by making it recursive, \n it always finds a solution. \n It tries to go right,forward, \n down,left, in that order. \n It's does not always \n find the fastest path. \n To resemble humans, it \n does not prioritize right \n if it would take it to \n a square it's visited";
String rsDes = "This algorithm uses recursion \n to solve the maze. \nFrom a given square, it gathers \n the possible moves and \n recursively calls itself on \n all those new squares. \n It is guaranteed to solve the maze \n However, it doesn't necesssarily \n produce the fastest solution.";
String algoDes = "";

String genDes = "This program visualizes \n several maze solving algorithms. \n The algorithms must go from \n the yellow tile to the green tile. \n Pick one and click 'solve maze' to \n see how long it takes and \n how many tiles it travels. \n You can adjust the animation \n speed and wall density of the maze";

void setup() {
  size(900, 600);  // Set the canvas size to 800x600
  solutionPath = new ArrayList<PVector>();
  createGUI();
  m.setMaze();
  loop();  // Start the animation loop
  frameRate(20); // Slow down the frame rate for better visualization
}

void draw() {
  background(0);
  m.drawMaze();
  display();
}
