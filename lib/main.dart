import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/user_input.dart';
import 'package:expense_tracker/widgets/user_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      home: MyHomePage(),
      theme: _getThemeData(),
    );
  }

  ThemeData _getThemeData() {
    return ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.amber,
      fontFamily: "Quicksand",
      textTheme: ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.bold, fontSize: 18),
        button: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 20,
              fontWeight: FontWeight.bold),),),
    );
  }

}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _transactions = [];

  void _addNewTransaction(String title, double amount, DateTime date) {
    setState(() {
      _transactions.add(createTransaction(title, amount, date));
    });
    print("Add new transactions");
  }

  Transaction createTransaction(String title, double amount, DateTime date) {
    return Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: date);
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){_startAddNewTransaction(context);},
          )
        ],
      ),
      body:  ListView(
          children: [
            Chart(_recentTransactions),
            UserTransactions(_transactions)
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){_startAddNewTransaction(context);},),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return UserInput(_addNewTransaction);
    });
  }
}
