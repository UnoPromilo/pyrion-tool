final class ElectricPotential {
  const ElectricPotential.fromVolts(this._potentialInVolts);

  final double _potentialInVolts;

  double get volts => _potentialInVolts;

  @override
  String toString() {
    return '${volts.toStringAsFixed(2)} V';
  }
}
