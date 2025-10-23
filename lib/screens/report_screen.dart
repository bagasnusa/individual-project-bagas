import 'package:flutter/material.dart';
import '../services/expense_service.dart';
import '../models/expense.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = ExpenseService.getExpenses();
    final total = expenses.fold<double>(
        0, (sum, expense) => sum + expense.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Pengeluaran"),
        backgroundColor: const Color(0xFF0A8F83),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Pengeluaran: Rp ${total.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  Expense e = expenses[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.attach_money,
                          color: Colors.teal),
                      title: Text(e.title),
                      subtitle: Text(
                          "Rp ${e.amount.toStringAsFixed(0)} - ${e.date.day}/${e.date.month}/${e.date.year}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
