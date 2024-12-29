import 'package:flutter/material.dart';
import 'package:todoapp/util/my_button.dart';
class DialogBox extends StatelessWidget {
  final controller; 
  VoidCallback onSave;
  VoidCallback onCancel;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:Colors.deepOrangeAccent,
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Add new task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(text: "Save", onPressed: (){}),
                const SizedBox(width: 8,),
                // cancel button
                MyButton(text: "Cancel", onPressed: (){}),
              ],
            )
          ],
        ),
      ),
    );
  }
}