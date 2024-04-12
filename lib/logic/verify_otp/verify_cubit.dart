

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/api/api_base.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState>{
  VerifyCubit() : super(VerifyInitial());
  ApiBase apiBase =ApiBase();

  Future<void> verifyOtp ({ 
      required BuildContext context,
      required String phoneNumber,
      required int otp,
      })async{
        emit(VerifyInProgress());
    try{
      final parameters ={
        "phoneNumber": phoneNumber,
        "otp":otp,
      };
      await apiBase.post('https://4r4iwhot12.execute-api.ap-south-1.amazonaws.com/auth/auth/validateOtp/',
      parameters,
        (data) {
          emit(VerifySuccess());
        },
        (error) {
          emit(VerifyError(errorMessage: error));
        });
    } catch (e){
      emit(VerifyError(errorMessage: e.toString()));
    }
  }
  
}