import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/logic/add_post/add_cubit.dart';

class PutPage extends StatefulWidget {
  const PutPage({Key? key}) : super(key: key);

  @override
  State<PutPage> createState() => _PutPageState();
}

class _PutPageState extends State<PutPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("New Value"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Align children to the center
              mainAxisAlignment: MainAxisAlignment.center, // Align column to the center
              children: [
                // TextFormField(
                //   controller: idController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your Id';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     hintText: 'Enter Id',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AddCubit>().addData(
                        name: nameController.text,
                        id: idController.text,
                      );
                    }
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
