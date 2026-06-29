part of 'fault_register_cubit.dart';

@immutable
final class FaultRegisterState {
  const FaultRegisterState(this.errors);

  final List<FaultEntry> errors;

  Iterable<FaultType> get resolved =>
      errors.where((e) => e.state == FaultState.latched).map((e) => e.type);

  Iterable<FaultType> get ongoing =>
      errors.where((e) => e.state == FaultState.ongoing).map((e) => e.type);
}
