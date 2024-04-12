import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirst_bloc/logic/get_cubit/get_cubit.dart';
import 'package:myfirst_bloc/screen/put.dart';
import 'package:myfirst_bloc/screen/put_screen.dart';

class GetScreen extends StatefulWidget {
  const GetScreen({super.key});

  @override
  State<GetScreen> createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Ak>().getData(context: context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("GET API"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PutPage()));
      },
      child: Icon(Icons.add),
      ),
      body:BlocBuilder<Ak,GetState>(
        builder: (context,state){
        if(state is GetLoading){
          return Center(child: CircularProgressIndicator(),);
        }else if (state is GetLoaded){
          return ListView.builder(
            itemCount: state.getModel?.length,
            itemBuilder: (context,index){
            final items = state.getModel![index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PutScreenn(items: items)));
              },
              child: Card(
                    shadowColor: Colors.red,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       
                          Text(
                            state.getModel?[index].id ?? '',style: TextStyle(color: Colors.amber),
                            maxLines: 1,
                          ),
                          Text(
                           "Name : ${ state.getModel?[index].name ?? ''}",
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
            );
          });
        }else if(state is GetError){
          return Text(state.errorMessage.toString());
        }
        return const SizedBox();
      }),
    ));
  }
}