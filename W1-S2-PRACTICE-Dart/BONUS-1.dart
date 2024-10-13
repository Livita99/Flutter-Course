enum Direction { north, east, south, west }

void main() {
  // Initial position {7, 3} and facing north
  int x = 7;
  int y = 3;
  Direction direction = Direction.north;

  // Example instruction sequence
  const instructions = "RAALAL";

  // Process the instructions and get the final position and direction
  for (var char in instructions.split('')) {
    if (char == 'R') {
      if (direction == Direction.north) {
        direction = Direction.east;
      } else if (direction == Direction.east) {
        direction = Direction.south;
      } else if (direction == Direction.south) {
        direction = Direction.west;
      } else if (direction == Direction.west) {
        direction = Direction.north;
      }
    } else if (char == 'L') {
      if (direction == Direction.north) {
        direction = Direction.west;
      } else if (direction == Direction.east) {
        direction = Direction.north;
      } else if (direction == Direction.south) {
        direction = Direction.east;
      } else if (direction == Direction.west) {
        direction = Direction.south;
      }
    } else if (char == 'A') {
      if (direction == Direction.north) {
        ++y;
      } else if (direction == Direction.east) {
        ++x;
      } else if (direction == Direction.south) {
        --y;
      } else if (direction == Direction.west) {
        --x;
      }
    }
  }

  // Print the final position and direction
  print("Final position: ($x, $y)");
  print("Facing: ${direction.toString().split('.').last}");
}
