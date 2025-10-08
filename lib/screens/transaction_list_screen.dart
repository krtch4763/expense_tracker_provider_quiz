// สร้างไฟล์ lib/screens/transaction_list_screen.dart
import 'package:expense_tracker_provider/screens/add_edit_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';
import '../models/my_transaction.dart';

class TransactionListScreen extends StatelessWidget {
  static const String routeName = '/';

  const TransactionListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text('รายรับ-รายจ่าย')),
      body: Consumer<TransactionProvider>(
        builder: (context, txProvider, child) => txProvider.transactions.isEmpty
            ? const Center(child: Text('ไม่มีรายการ'))
            : ListView.builder(
                itemCount: txProvider.transactions.length,
                itemBuilder: (ctx, i) {
                  final tx = txProvider.transactions[i];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        tx.type == TransactionType.income ? 'รับ' : 'จ่าย',
                      ),
                    ),
                    title: Text(tx.title),
                    subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${tx.amount.toStringAsFixed(2)} บาท',
                          style: TextStyle(
                            color: tx.type == TransactionType.income
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed: () {
                            // เรียกเมธอด delete
                            context.read<TransactionProvider>().deleteTransaction(tx.id!);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the add/edit screen. Replace '/add_edit' with your route name or use a MaterialPageRoute with the screen widget.
          Navigator.of(context).pushNamed(AddEditTransactionScreen.routeName);
        },
        tooltip: 'เพิ่มรายการ',
        child: const Icon(Icons.add),
      ),
    );
  }
}
