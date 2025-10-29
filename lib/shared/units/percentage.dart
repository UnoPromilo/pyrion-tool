import '../divisible.dart';

class Percentage implements SelfDivisible<Percentage> {
  const Percentage.fromFraction(this._fraction);

  const Percentage.fromPercents(double value) : _fraction = value / 100;

  final double _fraction;

  double get fraction => _fraction;

  @override
  String toString() {
    return '${_fromFractionToPercents(_fraction).toStringAsFixed(1)} %';
  }

  @override
  Percentage operator /(Percentage other) {
    return Percentage.fromFraction(_fraction / other._fraction);
  }
}

double _fromFractionToPercents(double fraction) {
  return fraction * 100;
}
