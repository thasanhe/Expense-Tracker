import 'package:flutter/material.dart';

class UserInput extends StatefulWidget {

  final Function _addTransaction;

  UserInput(this._addTransaction);

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text;

    if (enteredTitle.isEmpty || enteredAmount.isEmpty) {
      return;
    }

    try {
      widget._addTransaction(enteredTitle, double.parse(enteredAmount));
      print("User input");
    } catch (ex) {
      print(ex);
    }

    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              onSubmitted: (_) => submitData,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text("No date chosen!"),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text("Choose date", style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: (){},
                  ),
                ],
              ),
            ),
            FlatButton(
              child: Text("Add Transaction",),
              textColor: Colors.purple,
              onPressed: (){
                submitData();
              },
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
        padding: EdgeInsets.all(10),
      ),
      elevation: 5,
    );
  }
}
