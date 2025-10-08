import 'package:expense_tracker_provider/models/my_transaction.dart';
import 'package:flutter/material.dart';
import '../providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class AddEditTransactionScreen extends StatefulWidget {
  static const String routeName = '/add-edit-transaction';

  const AddEditTransactionScreen({super.key});

  @override
  State<AddEditTransactionScreen> createState() =>
      _AddEditTransactionScreenState();
}

class _AddEditTransactionScreenState extends State<AddEditTransactionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่ม/แก้ไข รายการ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await context.read<TransactionProvider>().addMyTransaction(
                  _titleController.text,
                  double.tryParse(_amountController.text) ?? 0.0,
                  DateTime.now(),
                  TransactionType.income,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Insert Note'),
            ),
            // พื้นที่สำหรับแสดงผล (จะเพิ่มในขั้นตอนถัดไป)
          ],
        ),
      ),
    );
  }
}
