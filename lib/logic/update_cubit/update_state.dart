part of 'update_cubit.dart';

abstract class PutState {
  final GetModel? getModel;
  PutState ({this.getModel});
}
class PutInital extends PutState{
  PutInital({super.getModel});
}
class PutLoading extends PutState{
  PutLoading({super.getModel});
}
class PutLoaded extends PutState{
  PutLoaded({super.getModel});
}
class PutError extends PutState {
  final String? errorMessage;
  PutError({this.errorMessage});
}
class PutSuccess extends PutState{
  PutSuccess();
}
