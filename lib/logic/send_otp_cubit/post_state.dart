part of 'post_cubit.dart';

abstract class PostState{}

final class PostInital extends PostState{}

final class PostSuccess extends PostState{}

final class PostError extends PostState{
  final String? errorMessage;
  PostError({this.errorMessage});
}