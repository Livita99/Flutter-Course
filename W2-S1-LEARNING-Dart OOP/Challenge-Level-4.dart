class Distance {
  final double meters;

  const Distance.cms(double centimeters) : meters = centimeters / 100;
  const Distance.meters(double meters) : meters = meters;
  const Distance.kms(double kilometers) : meters = kilometers * 1000;

  double get cms => meters * 100;
  double get ms => meters;
  double get kms => meters / 1000;

  Distance operator +(Distance other) {
    return Distance.meters(this.meters + other.meters);
  }
}

void main() {
  Distance d1 = Distance.kms(3.4);
  Distance d2 = Distance.meters(1000);
  print((d1 + d2).kms);
}
