import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  double get _weeklyTotal {
    return _recentTransactions.fold(0.0, (weeklyTotal, element) => weeklyTotal+element.amount);
  }

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0;

      for(var i=0; i<_recentTransactions.length; ++i){

        if (DateFormat.yMd().format(_recentTransactions[i].date) == DateFormat.yMd().format(weekDay)) {
          total += _recentTransactions[i].amount;
        }
      }

      print ('day ${DateFormat.E().format(weekDay)}, amount  ${total}');

      return {'day' : DateFormat.E().format(weekDay).substring(0,1), 'amount': total};
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {

    print(_groupedTransactions);

    return Container(
      child: Card(
          elevation: 6,
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _groupedTransactions.map((tx) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar('${tx['day']}', tx['amount'], _weeklyTotal != 0 ? (tx['amount'] as double) /_weeklyTotal : 0 ))).toList(),
            ),
          )
      ),
      width: double.infinity,
    );
  }
}
