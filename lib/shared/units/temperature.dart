final class Temperature {
  const Temperature.fromKelvins(this._tempInKelvins);

  final double _tempInKelvins;

  double get celsiusDegrees => _fromKelvinToCelsiusDegrees(_tempInKelvins);

  double get kelvins => _tempInKelvins;

  @override
  String toString() {
    return '${celsiusDegrees.toStringAsFixed(1)} °C';
  }
}

double _fromKelvinToCelsiusDegrees(double kelvins) {
  return kelvins - 273.15;
}
