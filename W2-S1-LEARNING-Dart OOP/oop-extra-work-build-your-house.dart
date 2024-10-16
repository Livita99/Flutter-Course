enum Color { red, blue, yellow, green, pink }

class Tree {
  String type;
  double height;

  Tree(this.type, this.height);

  @override
  String toString() {
    return "$type tree ($height meters)";
  }
}

class House {
  String address;
  List<Tree> trees = [];
  String roofType;
  Color? doorColor;
  bool hasChimney;
  int numberOfWindows;
  Color? windowColor;

  House({
    required this.address,
    required this.roofType,
    required this.doorColor,
    required this.hasChimney,
    required this.numberOfWindows,
    required this.windowColor,
  });

  void addTree(Tree newTree) {
    this.trees.add(newTree);
  }

  void describeHouse() {
    String treeDescriptions = trees.isEmpty
        ? "no trees"
        : trees.map((tree) => tree.toString()).join(", ");

    print("My house is at $address and it has a ${doorColor?.name} door, "
        "$numberOfWindows ${windowColor?.name} windows, "
        "${hasChimney ? 'a chimney' : 'no chimney'}, and a $roofType roof. "
        "It has $treeDescriptions.\n");
  }
}

void main() {
  House myHouse1 = House(
    address: "123 Main Street",
    roofType: "gable",
    doorColor: Color.red,
    hasChimney: true,
    numberOfWindows: 4,
    windowColor: Color.blue,
  );

  //before adding tree
  myHouse1.describeHouse();

  House myHouse2 = House(
    address: "456 Avenue",
    roofType: "flat",
    doorColor: Color.pink,
    hasChimney: false,
    numberOfWindows: 2,
    windowColor: Color.green,
  );

  myHouse2.addTree(Tree("Oak", 23.67));
  myHouse2.addTree(Tree("Pine", 15.5));

  //after adding tree
  myHouse2.describeHouse();
}
