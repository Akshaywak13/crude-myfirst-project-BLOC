
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/api/api_base.dart';
import 'package:myfirst_bloc/model/get_model.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddPostState>{
  AddCubit() : super(AddInitial());
  final ApiBase apiBase =ApiBase();

 Future <void> addData(
    {
      required String id,
      required String name,
    }) async {
         try{
      final parameters ={
        "id": id,
        "name":name,
      };
   
        emit(AddLoading());
        await apiBase.post('https://65804ce16ae0629a3f54dbdb.mockapi.io/Apiendpoint/PostApi/$id',
         parameters,
          (data) {
            emit(AddSuccess());
            
          }, (error) {
            emit(AddError(errorMessage: error));
          });
      } catch (e){
        emit(AddError(errorMessage: e.toString()));
      }
    }
}