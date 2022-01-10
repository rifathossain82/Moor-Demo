import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moor_database_demo/data/moor_database.dart';
import 'package:provider/provider.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  late DateTime newTaskDate;
  TextEditingController controller=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Task Name'
                ),
                onSubmitted: (inputName){
                  final databse=Provider.of<AppDatabase>(context);
                  final task=Task(
                      name: inputName,
                      dueDate: newTaskDate,
                    completed: false,
                    id: 1,
                  );
                  databse.insertTask(task);
                  resetValueAfterSubmit();
                },
              )
          ),
          IconButton(
              onPressed: ()async{
                newTaskDate=(await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2050)
                ))!;
              },
              icon: Icon(Icons.calendar_today))
        ],
      ),
    );
  }


  void resetValueAfterSubmit(){
    setState(() {
      newTaskDate=null!;
      controller.clear();
    });
  }
}
