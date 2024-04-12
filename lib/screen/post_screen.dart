import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:myfirst_bloc/logic/send_otp_cubit/post_cubit.dart';
import 'package:myfirst_bloc/screen/verify_otp.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _otpController =TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFBBB2),
        appBar: AppBar(
          title: Text('Send Otp'),
          centerTitle: true,
          backgroundColor: const Color(0xffFFBBB2),
        ),
        body: Padding(padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextFormField(
              //   controller: _otpController,
              //   decoration:  const InputDecoration(
              //     hintText: 'Enter Number',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(10))
              //     )
              //   ),
              //   keyboardType: TextInputType.phone,
              //   inputFormatters: [
              //     LengthLimitingTextInputFormatter(10),
              //     FilteringTextInputFormatter.digitsOnly
              //   ],
              //   validator: (value) {
              //     if(value == null || value.isEmpty){
              //       return 'Please enter a phone number';
              //     }else if(value.length != 10){
              //       return 'Phone number must be 10 digits';
              //     }
              //     return null ;
              //   },
              // ),
              SizedBox(
                  height: 10,
                ),
                IntlPhoneField(
                  controller: _otpController,
                  // focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  languageCode: "en",
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ' + country.name);
                  },
                ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
          if(_formKey.currentState!.validate()){
            context.read<PostCubit>().postData(phoneNumber: _otpController.text);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyScreen(phoneNumber: _otpController.text)));
          }
              },
              child: Text("Sent Otp"))
            ],
          ),
        ),
        ),
      ),
    );
  }
}