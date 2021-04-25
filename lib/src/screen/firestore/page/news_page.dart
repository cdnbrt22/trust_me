import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustme/src/screen/firestore/api/firebase_api.dart';
import 'package:trustme/src/screen/firestore/model/todo.dart';
import 'package:trustme/src/screen/firestore/provider/todos.dart';
import 'package:trustme/src/screen/firestore/widget/add_todo_dialog_widget.dart';
import 'package:trustme/src/screen/firestore/widget/completed_list_widget.dart';
import 'package:trustme/src/screen/firestore/widget/todo_list_widget.dart';
import 'package:trustme/src/screen/menu_dashboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Share News'), actions: [
        BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MenuDashboardsAndHome();
                },
              ),
            );
          },
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black.withOpacity(0.7),
        selectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'News draft',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed news',
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final todos = snapshot.data;

                final provider = Provider.of<TodosProvider>(context);
                provider.setTodos(todos);

                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodoDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
