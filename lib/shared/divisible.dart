import 'units/percentage.dart';

abstract class SelfDivisible<TSelf> {
  Percentage operator /(TSelf other);
}
