import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit/cubit.dart';

//     this param is here because the data in key and value form
Widget buildTaskItem(Map model,context)=>
    Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
      children: [
         CircleAvatar(
          radius: 40,
          child: Text('${model['time']}'), //that is not complete yet it is waiting the list
           //look at new tasks screen
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              Text('${model['title']}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              Text('${model['date']}',style: const TextStyle(color: Colors.grey),),
            ],
          ),
        ),
        const SizedBox(width: 20,),
        IconButton(
            onPressed:(){
              AppCubit.get(context).updateData(id: model['id'], status: 'done');
            },
            icon: const Icon(Icons.check_box,color: Colors.green,),
        ),
        IconButton(
            onPressed:(){
              AppCubit.get(context).updateData(id: model['id'], status: 'archived');
            },
            icon: const Icon(Icons.archive,color: Colors.black45 ,)
        ),
      ],
  ),
),
      onDismissed:(direction){
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );



Widget TasksBuilder({required List<Map>tasks})=>
    tasks.isEmpty? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.menu,
            size: 100,
            color: Colors.grey,),
          Text('NO TASKS YET, PLEASE ADD TASKS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),),
        ],
      ),
    )

        : ListView.separated(

      itemBuilder: (context,index)=>buildTaskItem(tasks[index],context), //here we give the list to the function


      separatorBuilder: (context,index)=>
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),


      itemCount: tasks.length,

    );