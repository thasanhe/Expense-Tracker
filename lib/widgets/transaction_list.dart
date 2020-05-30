import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _transactions.isEmpty ? Column(
          children: [
            Text("No Transactions!", style: Theme.of(context).textTheme.headline6,),
            SizedBox(height: 50,),
            Container(child: Image.asset("assets/images/waiting.png", fit: BoxFit.cover,), height: 200,),
          ],
        ) : ListView.builder(
          itemBuilder: (ctx, index) {
            return  Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(child: Text("\$${_transactions[index].amount}"),),),
                  ),
                title: Text("${_transactions[index].title}"),
                subtitle: Text(DateFormat.yMMMd().format(_transactions[index].date),),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: (){_deleteTransaction(_transactions[index]);},
                ),
                ),
            );
          },
          itemCount: _transactions.length,
        ),
      height: 400,
    );
  }
}