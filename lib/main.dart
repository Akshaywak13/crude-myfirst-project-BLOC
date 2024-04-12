import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/logic/add_post/add_cubit.dart';
import 'package:myfirst_bloc/logic/delete/delete_cubit.dart';
import 'package:myfirst_bloc/logic/get_cubit/get_cubit.dart';
import 'package:myfirst_bloc/logic/send_otp_cubit/post_cubit.dart';
import 'package:myfirst_bloc/logic/update_cubit/update_cubit.dart';
import 'package:myfirst_bloc/logic/verify_otp/verify_cubit.dart';
import 'package:myfirst_bloc/screen/post_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>Ak()),
      BlocProvider(create: (context)=> PostCubit()),
      BlocProvider(create: (context)=>VerifyCubit()),
      BlocProvider(create: (context)=>PutCubit()),
      BlocProvider(create: (context)=>AddCubit()),
      BlocProvider(create: (context)=>DeleteCubit())
    ],
     child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostScreen(),
     ));
  }
}