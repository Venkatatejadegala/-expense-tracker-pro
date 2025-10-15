import 'package:flutter/material.dart';

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final String category;
  final IconData categoryIcon;
  final Color categoryColor;
  final DateTime date;
  final String? description;
  final bool isIncome;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.categoryIcon,
    required this.categoryColor,
    required this.date,
    this.description,
    required this.isIncome,
  });
}

class ExpenseProvider extends ChangeNotifier {
  final List<ExpenseModel> _expenses = [];
  final bool _isLoading = false;

  List<ExpenseModel> get expenses => List.unmodifiable(_expenses);
  bool get isLoading => _isLoading;

  // Mock data for demonstration
  ExpenseProvider() {
    _loadMockData();
  }

  void _loadMockData() {
    _expenses.addAll([
      ExpenseModel(
        id: '1',
        title: 'Groceries',
        amount: -850.00,
        category: 'Food',
        categoryIcon: Icons.shopping_bag,
        categoryColor: Colors.orange,
        date: DateTime.now().subtract(const Duration(days: 2)),
        description: 'Weekly grocery shopping',
        isIncome: false,
      ),
      ExpenseModel(
        id: '2',
        title: 'Travel',
        amount: -155.00,
        category: 'Transport',
        categoryIcon: Icons.directions_bus,
        categoryColor: Colors.blue,
        date: DateTime.now().subtract(const Duration(days: 3)),
        description: 'Bus fare to work',
        isIncome: false,
      ),
      ExpenseModel(
        id: '3',
        title: 'Salary',
        amount: 15000.00,
        category: 'Income',
        categoryIcon: Icons.currency_exchange,
        categoryColor: Colors.green,
        date: DateTime.now().subtract(const Duration(days: 4)),
        description: 'Monthly salary',
        isIncome: true,
      ),
      ExpenseModel(
        id: '4',
        title: 'Entertainment',
        amount: -400.00,
        category: 'Entertainment',
        categoryIcon: Icons.movie,
        categoryColor: Colors.purple,
        date: DateTime.now().subtract(const Duration(days: 4)),
        description: 'Movie tickets',
        isIncome: false,
      ),
      ExpenseModel(
        id: '5',
        title: 'Rent',
        amount: -5000.00,
        category: 'Housing',
        categoryIcon: Icons.home,
        categoryColor: Colors.red,
        date: DateTime.now().subtract(const Duration(days: 5)),
        description: 'Monthly rent payment',
        isIncome: false,
      ),
      ExpenseModel(
        id: '6',
        title: 'Dinner Out',
        amount: -652.00,
        category: 'Food',
        categoryIcon: Icons.fastfood,
        categoryColor: Colors.yellow,
        date: DateTime.now().subtract(const Duration(days: 6)),
        description: 'Restaurant dinner',
        isIncome: false,
      ),
    ]);
    notifyListeners();
  }

  void addExpense(ExpenseModel expense) {
    _expenses.insert(0, expense);
    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  void updateExpense(ExpenseModel updatedExpense) {
    final index = _expenses.indexWhere((expense) => expense.id == updatedExpense.id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
      notifyListeners();
    }
  }

  // Statistics calculations
  double get totalIncome {
    return _expenses
        .where((expense) => expense.isIncome)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  double get totalExpenses {
    return _expenses
        .where((expense) => !expense.isIncome)
        .fold(0.0, (sum, expense) => sum + expense.amount.abs());
  }

  double get totalBalance {
    return _expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  // Category-wise expenses
  Map<String, double> get categoryExpenses {
    final Map<String, double> categoryMap = {};
    for (final expense in _expenses.where((e) => !e.isIncome)) {
      categoryMap[expense.category] = (categoryMap[expense.category] ?? 0) + expense.amount.abs();
    }
    return categoryMap;
  }

  // Recent expenses (last 7 days)
  List<ExpenseModel> get recentExpenses {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return _expenses.where((expense) => expense.date.isAfter(weekAgo)).toList();
  }

  // Monthly expenses
  List<ExpenseModel> get monthlyExpenses {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    return _expenses.where((expense) => expense.date.isAfter(startOfMonth)).toList();
  }
}
