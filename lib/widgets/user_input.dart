import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInput extends StatefulWidget {

  final Function _addTransaction;

  UserInput(this._addTransaction);

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;

  void _submitData() {
    final _enteredTitle = _titleController.text;
    final _enteredAmount = _amountController.text;

    if (_enteredTitle.isEmpty || _enteredAmount.isEmpty || _pickedDate == null) {
      return;
    }

    try {
      widget._addTransaction(_enteredTitle, double.parse(_enteredAmount), _pickedDate);
      print("User input");
    } catch (ex) {
      print(ex);
    }

    Navigator.of(context).pop();

  }

  void _openDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _pickedDate = pickedDate;
        });
      }
    });
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
              onSubmitted: (_) => _submitData,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_pickedDate == null ? "No date chosen!" : "Picked Date : ${DateFormat.yMd().format(_pickedDate)}", key: Key("pickedDate"),),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text("Choose date", style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: (){_openDatePicker();},
                  ),
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("Add Transaction",),
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: (){
                _submitData();
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
