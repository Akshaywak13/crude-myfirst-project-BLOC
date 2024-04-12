part of 'verify_cubit.dart';

abstract class VerifyState{}

class VerifyInitial extends VerifyState{}

class VerifyInProgress extends VerifyState{}

class VerifySuccess extends VerifyState{}

class VerifyError extends VerifyState{
  final String? errorMessage;
  VerifyError({this.errorMessage});
}