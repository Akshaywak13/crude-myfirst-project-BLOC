
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/api/api_base.dart';
import 'package:myfirst_bloc/model/get_model.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState>{
  DeleteCubit() : super(DeleteInital());
  final ApiBase apiBase = ApiBase();

  Future<void> deleteData({required String id})async{
    try{
      emit(DeleteLoading());
      await apiBase.delete('https://65804ce16ae0629a3f54dbdb.mockapi.io/Apiendpoint/PostApi/$id',
       (data) {
        final response = GetModel.fromJson(data);
        emit(DeleteLoadded(getModel: response));
        emit(DeleteSuceess());
       }, 
       (error) {
        emit(DeleteError(errorMessage: error));
       });
    }catch (e){
      emit(DeleteError(errorMessage: e.toString()));
    }
  }
}