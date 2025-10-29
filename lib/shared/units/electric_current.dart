import '../divisible.dart';
import 'percentage.dart';

final class ElectricCurrent implements SelfDivisible<ElectricCurrent> {
  const ElectricCurrent.fromAmperes(this._currentInAmperes);

  final double _currentInAmperes;

  double get amperes => _currentInAmperes;

  @override
  String toString() {
    return '${_currentInAmperes.toStringAsFixed(2)} A';
  }

  @override
  Percentage operator /(ElectricCurrent other) {
    return Percentage.fromFraction(_currentInAmperes / other._currentInAmperes);
  }
}
