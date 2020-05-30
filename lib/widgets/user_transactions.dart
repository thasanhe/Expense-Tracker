import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatelessWidget {

  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  UserTransactions(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_sortedTransactions, _deleteTransaction),
      ],
    );
  }

  List<Transaction> get _sortedTransactions {
    _transactions.sort(compare);

    return _transactions;
  }

  int compare(Transaction a, Transaction b) {
    return a.date.isAfter(b.date) ? -1 : 1;
  }
}
