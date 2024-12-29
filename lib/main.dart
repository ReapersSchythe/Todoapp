import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ToDoListPage(),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask(String task) {
    setState(() {
      _tasks.add({"text": task, "completed": false});
    });
    _taskController.clear();
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: Text('To Do List', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.yellow[800],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'New Task',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  ),
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      _addTask(_taskController.text);
                    }
                  },
                  child: Text('Add', style: TextStyle(fontSize: 16, color: Colors.yellow[100])),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final task = _tasks.removeAt(oldIndex);
                  _tasks.insert(newIndex, task);
                });
              },
              children: _tasks.asMap().entries.map((entry) {
                int index = entry.key;
                final task = entry.value;
                return Dismissible(
                  key: Key(task['text']),
                  onDismissed: (direction) {
                    _deleteTask(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    color: Colors.yellow[800],
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 3,
                    child: ListTile(
                      key: ValueKey(task['text']),
                      leading: Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.yellow[100],
                        value: task['completed'],
                        onChanged: (value) {
                          _toggleCompletion(index);
                        },
                      ),
                      title: Text(
                        task['text'],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          decoration: task['completed']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
