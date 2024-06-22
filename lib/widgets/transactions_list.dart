import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expensetracker/providers/transactions.dart';
import 'package:expensetracker/providers/categories.dart'; // Import the Categories provider
import 'package:intl/intl.dart';
import 'package:expensetracker/widgets/edit_transaction.dart'; // Import the edit transaction widget

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionsData = Provider.of<Transactions>(context);
    final transactions = transactionsData.items;
    final categoriesData = Provider.of<Categories>(context); // Fetch categories data

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        // Find the category for the transaction
        final category = categoriesData.findById(transactions[index].category);

        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('\Rs.${transactions[index].amount}'),
                ),
              ),
            ),
            title: Text(transactions[index].title),
            subtitle: Text(
              '${DateFormat.yMMMd().format(transactions[index].date)} - ${category != null ? category.title : 'Unknown'}', // Display category title if found, otherwise 'Unknown'
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => EditTransaction(transaction: transactions[index]),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    transactionsData.deleteTransaction(transactions[index].id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
