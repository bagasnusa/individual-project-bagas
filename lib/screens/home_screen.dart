import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double income = 5000000;
  double expense = 3200000;

  List<Map<String, dynamic>> transactions = [
    {"title": "Gaji Bulanan", "amount": 5000000, "type": "income"},
    {"title": "Makan Siang", "amount": 50000, "type": "expense"},
    {"title": "Transportasi", "amount": 20000, "type": "expense"},
    {"title": "Belanja Online", "amount": 250000, "type": "expense"},
  ];

  @override
  Widget build(BuildContext context) {
    double balance = income - expense;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard Keuangan',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildBalanceCard(balance),
            const SizedBox(height: 20),
            _buildChart(),
            const SizedBox(height: 20),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(double balance) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Saldo Saat Ini",
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700])),
            const SizedBox(height: 8),
            Text(
              "Rp ${balance.toStringAsFixed(0)}",
              style: GoogleFonts.poppins(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem("Pendapatan", income, Colors.green),
                _buildSummaryItem("Pengeluaran", expense, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, double amount, Color color) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        const SizedBox(height: 4),
        Text(
          "Rp ${amount.toStringAsFixed(0)}",
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600, color: color),
        ),
      ],
    );
  }

  Widget _buildChart() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Perbandingan Keuangan",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: income,
                      title: "Pendapatan",
                      radius: 70,
                      titleStyle:
                          GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: expense,
                      title: "Pengeluaran",
                      radius: 70,
                      titleStyle:
                          GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Riwayat Transaksi",
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...transactions.map((t) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  t['type'] == 'income'
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color:
                      t['type'] == 'income' ? Colors.green : Colors.redAccent,
                ),
                title: Text(t['title'], style: GoogleFonts.poppins()),
                trailing: Text(
                  "Rp ${t['amount'].toStringAsFixed(0)}",
                  style: GoogleFonts.poppins(
                      color:
                          t['type'] == 'income' ? Colors.green : Colors.redAccent,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )),
      ],
    );
  }
}
