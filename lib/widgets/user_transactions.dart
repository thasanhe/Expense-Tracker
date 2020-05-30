import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatelessWidget {

  final List<Transaction> _transactions;

  UserTransactions(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
      ],
    );
  }
}
