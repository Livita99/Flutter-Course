enum Color { red, blue, yellow, green, pink }

enum Country { CAMBODIA, FRANCE, USA }

enum Position { right, left, center }

class Tree {
  final String type;
  final double height;

  Tree(this.type, this.height);

  @override
  String toString() {
    return "$type tree ($height meters)";
  }
}

class Address {
  final String street;
  final String city;
  final Country country;

  Address({required this.street, required this.city, required this.country});

  @override
  String toString() {
    return "$street, $city, ${country.toString().split('.').last}";
  }
}

class Room {
  final String roomType;
  final int numberOfDoors;
  final int numberOfWindows;

  Room({
    required this.roomType,
    required this.numberOfDoors,
    required this.numberOfWindows,
  });

  @override
  String toString() {
    return "$roomType room with $numberOfDoors doors and $numberOfWindows windows";
  }
}

class Door {
  final Color doorColor;

  Door({required this.doorColor});

  @override
  String toString() {
    return "Door color: ${doorColor.toString().split('.').last}";
  }
}

class Window {
  final Color windowColor;
  final Position windowPositon;

  Window({required this.windowColor, required this.windowPositon});

  @override
  String toString() {
    return "Window position : ${windowPositon.toString().split('.').last}, "
        "Window color: ${windowColor.toString().split('.').last}\n";
  }
}

class Roof {
  final String roofType;

  Roof({required this.roofType});

  @override
  String toString() {
    return "Roof type: $roofType";
  }
}

class Chimney {
  final Color chimneyColor;

  Chimney({required this.chimneyColor});

  @override
  String toString() {
    return "Chimney color: ${chimneyColor.toString().split('.').last}";
  }
}

class House {
  final Address address;
  final List<Tree> trees = [];
  final Roof roofType;
  final Chimney chimneyColor;
  final Door doorColor;
  final List<Room> rooms = [];
  final List<Window> windows = [];

  House({
    required this.address,
    required this.roofType,
    required this.doorColor,
    required this.chimneyColor,
  });

  void addTree(Tree newTree) {
    this.trees.add(newTree);
  }

  void addRoom(Room newRoom) {
    this.rooms.add(newRoom);
  }

  void addWindow(Window newWindow) {
    this.windows.add(newWindow);
  }

  int get numberOfWindows => windows.length;

  @override
  String toString() {
    return "House at $address"
        "\nTrees: ${trees.join(", ")}"
        "\nRooms: ${rooms.join(", ")}"
        "\n$roofType"
        "\n$doorColor"
        "\n$chimneyColor"
        "\nNumber of windows: $numberOfWindows"
        "\n${windows.join(", ")}";
  }
}

void main() {
  final myHouse = House(
    address: Address(
      street: "BKK",
      city: "Phnom Penh",
      country: Country.CAMBODIA,
    ),
    roofType: Roof(roofType: "Tile"),
    doorColor: Door(doorColor: Color.blue),
    chimneyColor: Chimney(chimneyColor: Color.red),
  );

  myHouse.addTree(Tree("Pine", 10));
  myHouse.addTree(Tree("Oak", 15));
  myHouse
      .addRoom(Room(roomType: "Living", numberOfDoors: 1, numberOfWindows: 2));
  myHouse.addRoom(Room(roomType: "Bed", numberOfDoors: 1, numberOfWindows: 1));
  myHouse
      .addWindow(Window(windowPositon: Position.left, windowColor: Color.blue));
  myHouse
      .addWindow(Window(windowPositon: Position.right, windowColor: Color.red));

  print(myHouse);
}
