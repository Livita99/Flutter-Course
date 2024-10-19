enum Skill { FLUTTER, DART, OTHER, HTML, CSS }

class Employee {
  final String name;
  final double baseSalary;
  final List<Skill> skill;
  final Address address;
  final int yearsOfExperience;

  const Employee.mobileDeveloper({
    required this.name,
    required this.baseSalary,
    this.skill = const [Skill.FLUTTER, Skill.DART],
    required this.address,
    required this.yearsOfExperience,
  });

  const Employee.frontendDeveloper({
    required this.name,
    required this.baseSalary,
    this.skill = const [Skill.HTML, Skill.CSS],
    required this.address,
    required this.yearsOfExperience,
  });

  get names => this.name;
  get baseSalaries => this.baseSalary;
  get skills => this.skill;
  get addresses => this.address;
  get yearsOfExperiences => this.yearsOfExperience;

  double computeSalary(baseSalary, yearsOfExperience) {
    double salary = baseSalary + (yearsOfExperience * 2000);
    print("Salary: \$$salary");
    return salary;
  }

  void printDetails() {
    List<String> skillNames =
        skill.map((s) => s.toString().split('.').last).toList();
    print("Employee: $name \nBase Salary: \$${baseSalary} "
        "\nSkills: ${skillNames.join(', ')} \nAddress: $address "
        "\nYears of Experience: $yearsOfExperience");
  }
}

class Address {
  final String street;
  final String city;
  final String zipCode;

  Address({required this.street, required this.city, required this.zipCode});

  @override
  String toString() {
    return "$street, $city, $zipCode";
  }
}

void main() {
  Employee emp1 = Employee.mobileDeveloper(
    name: "James",
    baseSalary: 20000,
    address: Address(street: "BKK", city: "Phnom Penh", zipCode: "135000"),
    yearsOfExperience: 2,
  );

  emp1.printDetails();
  emp1.computeSalary(emp1.baseSalary, emp1.yearsOfExperience);

  print("\n");

  Employee emp2 = Employee.frontendDeveloper(
    name: 'Jack',
    baseSalary: 10000,
    address: Address(street: "Tk", city: "Siem Reap", zipCode: "140280"),
    yearsOfExperience: 3,
  );

  emp2.printDetails();
  emp2.computeSalary(emp2.baseSalary, emp2.yearsOfExperience);
}
