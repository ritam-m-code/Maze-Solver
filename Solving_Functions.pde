boolean recursiveSolver(int r, int c, Maze m) {
  
  // Base case: reach the bottom-right corner
  if (r == rows - 1 && c == cols - 1) {
    solutionPath.add(new PVector(c, r)); // Add the final position
    m.grid[r][c] = 3;
    return true;
  }
  
  // If out of bounds or it's a wall or already visited, return false
  if (r < 0 || r >= rows || c < 0 || c >= cols || m.grid[r][c] == 0 || m.visited[r][c]) {
    return false;
  }
  
  // Mark the cell as visited
  m.visited[r][c] = true;
  
  // Add the current position to the solution path (while moving forward)
  solutionPath.add(new PVector(r, c));
  m.grid[r][c] = 3;

  
  // Try moving in all four directions (right, down, left, up)
  if (recursiveSolver(r, c + 1, m)) return true;  // Move right
  if (recursiveSolver(r + 1, c, m)) return true;  // Move down
  if (recursiveSolver(r, c - 1, m)) return true;  // Move left
  if (recursiveSolver(r - 1, c, m)) return true;  // Move up
  
  // If no path found, backtrack and remove the last position
  solutionPath.remove(solutionPath.size() - 1);
  m.grid[r][c] = 1;
  return false;
}

// Dijkstra's algorithm to find the shortest path
boolean dijkstraPath(Maze m, PVector start, PVector end) {
  int rows = m.grid.length, cols = m.grid[0].length;

  float[][] dist = new float[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      dist[i][j] = Float.MAX_VALUE;
    }
  }
  dist[(int) start.x][(int) start.y] = 0;

  PriorityQueue<Node> queue = new PriorityQueue<Node>();
  queue.add(new Node(start, 0));

  HashMap<PVector, PVector> predecessors = new HashMap<PVector, PVector>();
  int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

  while (!queue.isEmpty()) {
    Node current = queue.poll();
    PVector pos = current.position;

    if (pos.equals(end)) {
      // Path found, reconstruct the path and update the global solutionPath
      solutionPath.clear();
      solutionPath.addAll(reconstructPath(predecessors, end));
      return true;  // Return true if the path is found
    }

    for (int[] dir : directions) {
      int nx = (int) pos.x + dir[0], ny = (int) pos.y + dir[1];
      if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && m.grid[nx][ny] == 1) {
        float newDist = dist[(int) pos.x][(int) pos.y] + 1;
        if (newDist < dist[nx][ny]) {
          dist[nx][ny] = newDist;
          queue.add(new Node(new PVector(nx, ny), newDist));
          predecessors.put(new PVector(nx, ny), pos);
        }
      }
    }
  }
  return false;  // Return false if no path is found
}

// Reconstruct the shortest path and mark it in the grid
ArrayList<PVector> reconstructPath(HashMap<PVector, PVector> predecessors, PVector end) {
  ArrayList<PVector> path = new ArrayList<PVector>();
  for (PVector at = end; at != null; at = predecessors.get(at)) {
    path.add(0, at);
  }

  // Now mark the cells that are part of the solution path as visited (for blue highlighting)
  for (PVector p : path) {
    m.grid[(int) p.x][(int) p.y] = 3; // Mark cells on the path as part of the final path
  }
  return path;
}

boolean rightHandFollower(Maze m, int currentX, int currentY, int currentDirection, ArrayList<PVector> solutionPath) {
    // Directions: 0 = up, 1 = right, 2 = down, 3 = left
    int[][] directions = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}}; 
    visitCount[currentX][currentY]++;
    
    // Base case: Check if we exceed the recursion cap
    if (visitCount[currentX][currentY] >= 3) {
        return false;  // Return false if the recursion limit is exceeded
    }

    // Base case: Check if we've already visited this square
    if (m.visited[currentX][currentY]) {
        return false;
    }
    
    m.visited[currentX][currentY] = true;

    // Mark the current cell as part of the solution path
    m.grid[currentX][currentY] = 3;
    solutionPath.add(new PVector(currentX, currentY));

    // Base case: Check if we've reached the goal
    if (currentX == m.rows - 1 && currentY == m.cols - 1) {
        return true; // Goal reached
    }

    // Directions order: Right -> Forward -> Left -> Back
    int rightDirection = (currentDirection + 1) % 4;  // Right (90 degrees)
    int straightDirection = currentDirection;        // Forward (0 degrees)
    int leftDirection = (currentDirection + 3) % 4;   // Left (-90 degrees)
    int backDirection = (currentDirection + 2) % 4;   // Back (180 degrees)

    // Try to move right (priority 1)
    int nextX = currentX + directions[rightDirection][0];
    int nextY = currentY + directions[rightDirection][1];
    if (isValidMove(nextX, nextY)) {
        // Move right (turn right)
        if (rightHandFollower(m, nextX, nextY, rightDirection, solutionPath)) {
            return true;
        }
    }

    // Try to move forward (priority 2)
    nextX = currentX + directions[straightDirection][0];
    nextY = currentY + directions[straightDirection][1];
    if (isValidMove(nextX, nextY)) {
        // Move forward (no turn)
        if (rightHandFollower(m, nextX, nextY, straightDirection, solutionPath)) {
            return true;
        }
    }

    // Try to move left (priority 3)
    nextX = currentX + directions[leftDirection][0];
    nextY = currentY + directions[leftDirection][1];
    if (isValidMove(nextX, nextY)) {
        // Move left (turn left)
        if (rightHandFollower(m, nextX, nextY, leftDirection, solutionPath)) {
            return true;
        }
    }

    // Try to move back (priority 4)
    nextX = currentX + directions[backDirection][0];
    nextY = currentY + directions[backDirection][1];
    if (isValidMove(nextX, nextY)) {
        // Move back (turn around)
        if (rightHandFollower(m, nextX, nextY, backDirection, solutionPath)) {
            return true;
        }
    }

    // No valid move found, backtrack: unmark current cell and remove it from solution path
    m.grid[currentX][currentY] = 1;  // Unmark the path
    solutionPath.remove(solutionPath.size() - 1); // Remove from the solution path
    m.visited[currentX][currentY] = false;  // Mark as unvisited

    return false;  // Return false, as this path didn't work out
}

boolean isValidMove(int x, int y) {
    // Check if the move is within bounds and leads to an open cell (not a wall)
    return x >= 0 && x < rows && y >= 0 && y < cols && m.grid[x][y] != 0;  // 0 = wall, 1 = open path, 3 = part of the solution path
}
