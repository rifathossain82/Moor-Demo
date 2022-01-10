import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moor_database_demo/data/moor_database.dart';
import 'package:moor_database_demo/widget/newTask.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moor Database Demo'),
      ),
      body: Column(
        children: [
          Expanded(child: buildTaskList(context)),
          NewTask(),
        ],
      ),
    );
  }

  StreamBuilder<List<Task>> buildTaskList(BuildContext context){
    final database=Provider.of<AppDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllTasks(),
        builder: (context,AsyncSnapshot<List<Task>> snapshot){
          final task=snapshot.data ?? null;

          return ListView.builder(
            itemCount: task!.length,
              itemBuilder: (context,index){
              final itemTask=task[index];
              return buildListItem(itemTask,database);
              }
          );
        }
    );
  }


  Widget buildListItem(Task itemTask, AppDatabase database){
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          IconButton(
            onPressed: (){
              database.deleteTask(itemTask);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      child: CheckboxListTile(
        title: Text(itemTask.name),
        subtitle: Text(itemTask.dueDate?.toString() ?? 'No Date'),
        value: itemTask.completed,
        onChanged: (newValue){
          database.updateTask(itemTask.copyWith(completed: newValue));
        },
      ),

    );

  }


}
