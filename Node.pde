// Node class for the priority queue
class Node implements Comparable<Node> {
  PVector position;
  float cost;

  Node(PVector position, float cost) {
    this.position = position;
    this.cost = cost;
  }

  public int compareTo(Node other) {
    return Float.compare(this.cost, other.cost);
  }
}
