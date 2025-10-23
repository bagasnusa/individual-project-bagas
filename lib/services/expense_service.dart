import '../models/expense.dart';

class ExpenseService {
  static final List<Expense> _expenses = [];

  static void addExpense(Expense expense) {
    _expenses.add(expense);
  }

  static List<Expense> getExpenses() {
    return _expenses;
  }
}
