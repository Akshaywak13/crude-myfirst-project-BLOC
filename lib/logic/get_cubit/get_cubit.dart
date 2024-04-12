import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/api/api_base.dart';
import 'package:myfirst_bloc/model/get_model.dart';

part 'get_state.dart';

class Ak extends Cubit<GetState>{
  Ak(): super(GetInitial());
  ApiBase apiBase =ApiBase();

  Future<void> getData ({required BuildContext context}) async{
    emit(GetLoading());
    try{
      await apiBase.get('https://65804ce16ae0629a3f54dbdb.mockapi.io/Apiendpoint/PostApi',
       (data) {
        List<GetModel> posts = [];
        for(var postJson in data){
          var items = GetModel.fromJson(postJson);
          posts.add(items);
        }
        emit(GetLoaded(getModel: posts));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfull")));
       }, 
       (error) {
        emit(GetError(errorMessage: error));
       });
    }catch (e){
      emit(GetError(errorMessage:e.toString()));
    }
  }
}