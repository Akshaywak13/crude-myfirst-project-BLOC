import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/logic/delete/delete_cubit.dart';
import 'package:myfirst_bloc/logic/update_cubit/update_cubit.dart';
import 'package:myfirst_bloc/model/get_model.dart';

class PutScreenn extends StatefulWidget {
  final GetModel items;

  const PutScreenn({Key? key, required this.items}) : super(key: key);

  @override
  State<PutScreenn> createState() => _PutScreennState();
}

class _PutScreennState extends State<PutScreenn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idController.text = widget.items.id ?? '';
    nameController.text = widget.items.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocConsumer<PutCubit, PutState>(
            listener: (context, state) {
              if (state is PutLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Data Updated Successfully"),
                  ),
                );
              } else if (state is PutError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.errorMessage}'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.items.id ?? ''),
                          SizedBox(
                            width: 30,
                          ),
                          BlocBuilder<DeleteCubit,DeleteState>(
                            builder: (context,state){
                              if(state is DeleteLoading){
                                return CircularProgressIndicator();
                              }else{
                                return ElevatedButton(
                              onPressed: () {
                                context.read<DeleteCubit>().deleteData(id: widget.items.id??'');
                              },
                             child: Icon(Icons.delete));
                              }
                          })
                          
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: idController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            hintText: "ID ",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final name = nameController.text;
                            final id = idController.text;
                            context
                                .read<PutCubit>()
                                .putData(name: name, id: id);
                          }
                        },
                        child: Text('Update Data'),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
