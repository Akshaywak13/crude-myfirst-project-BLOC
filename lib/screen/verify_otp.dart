import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/logic/verify_otp/verify_cubit.dart';
import 'package:myfirst_bloc/screen/get_screen.dart';
import 'package:pinput/pinput.dart';

class VerifyScreen extends StatefulWidget {
  final String phoneNumber;
  const VerifyScreen({super.key, required this.phoneNumber});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  bool isVerifying = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffFFBBB2),
          appBar: AppBar(
            title: const Text('Otp Verify'),
            centerTitle: true,
            backgroundColor: const Color(0xffFFBBB2),
          ),
          body: BlocConsumer<VerifyCubit, VerifyState>(
            listener: (context, state) {
              if (state is VerifySuccess) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => GetScreen()));
              }else if(state is VerifyError){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage?? 'An error occurred.'),
                )
                );
              }
            },
            builder: (context,state){
              if(state is VerifyInProgress){
                return Center(child: CircularProgressIndicator(),);
              }else{
                return Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      controller: otpController,
                      length: 6,
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value?.length != 6 && value!.length < 6) {
                          return 'Please enter the 6 digits otp';
                        }
                        return null;
                      },
                      enabled: !isVerifying,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: isVerifying?null : () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isVerifying = true;
                            });
                            context.read<VerifyCubit>().verifyOtp(
                                context: context,
                                phoneNumber: widget.phoneNumber.toString(),
                                otp: int.parse(otpController.text));
                          
                          }
                        },
                        child: Text('Verify Otp'))
                  ],
                ),
              ),
            ),
          );
              }
            },
          )

          // return Padding(
          //   padding: EdgeInsets.all(20),
          //   child: Center(
          //     child: Form(
          //       key: _formKey,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Pinput(
          //             controller: otpController,
          //             length: 6,
          //             keyboardType: TextInputType.number,
          //             validator: (String? value) {
          //               if (value?.length != 6 && value!.length < 6) {
          //                 return 'Please enter the 6 digits otp';
          //               }
          //               return null;
          //             },
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           ElevatedButton(
          //               onPressed: () {
          //                 if (_formKey.currentState!.validate()) {
          //                   context.read<VerifyCubit>().verifyOtp(
          //                       context: context,
          //                       phoneNumber: widget.phoneNumber.toString(),
          //                       otp: int.parse(otpController.text));
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => GetScreen()));
          //                 }
          //               },
          //               child: Text('Verify Otp'))
          //         ],
          //       ),
          //     ),
          //   ),
          // );
          ),
    );
  }
}
