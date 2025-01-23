// Node class for the priority queue
class Node implements Comparable<Node> {
  //Fields
  PVector position; 
  float cost;

  Node(PVector position, float cost) { //Constructor
    this.position = position;
    this.cost = cost;
  }

  public int compareTo(Node other) { //Function that returns the cost of one maze to another
    return Float.compare(this.cost, other.cost);
  }
}
