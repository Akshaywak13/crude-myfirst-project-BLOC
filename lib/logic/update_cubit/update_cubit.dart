
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/api/api_base.dart';
import 'package:myfirst_bloc/model/get_model.dart';

part 'update_state.dart';

class PutCubit extends Cubit<PutState>{
  PutCubit() : super(PutInital());
  final ApiBase apiBase =ApiBase();

  void putData ({
    required String id,
    int? createdAt,
    required String name,
    int? avatar,
    
    }) async{
      final parameters ={
        "id": id,
        "createdAt": createdAt,
        "name": name,
        "avatar":avatar,
      };
    try{ 
      emit(PutLoading());
      await apiBase.put('https://65804ce16ae0629a3f54dbdb.mockapi.io/Apiendpoint/PostApi/$id',
       parameters,
        (data) {
          emit(PutSuccess());
          var response = GetModel.fromJson(data);
          emit(PutLoaded(getModel: response));
        }, (error) {
          emit(PutError(errorMessage: error));
        });
    }catch (e){
      emit(PutError(errorMessage: e.toString()));
    }
  }
}