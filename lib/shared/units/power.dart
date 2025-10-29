final class Power {
  const Power.fromWatts(this._powerInWatts);

  final double _powerInWatts;

  @override
  String toString() {
    return '${_powerInWatts.toStringAsFixed(0)} W';
  }
}
