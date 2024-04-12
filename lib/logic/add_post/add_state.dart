part of'add_cubit.dart';


abstract class AddPostState{
  final GetModel? getModel;
  AddPostState({this.getModel});
}

final class AddInitial extends AddPostState{}

final class AddSuccess extends AddPostState{}

final class AddLoading extends AddPostState{}

final class AddError extends AddPostState{
  final String? errorMessage;
  AddError({this.errorMessage});
}