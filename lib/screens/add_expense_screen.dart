import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/models/expense_provider.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  int _selectedCategoryIndex = 0;
  bool _isIncome = false;
  DateTime _selectedDate = DateTime.now();
  
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.fastfood_rounded, 'label': 'Food', 'color': Colors.orange},
    {'icon': Icons.shopping_bag_rounded, 'label': 'Shopping', 'color': Colors.blue},
    {'icon': Icons.home_rounded, 'label': 'Housing', 'color': Colors.red},
    {'icon': Icons.directions_bus_rounded, 'label': 'Transport', 'color': Colors.green},
    {'icon': Icons.movie_rounded, 'label': 'Entertainment', 'color': Colors.purple},
    {'icon': Icons.school_rounded, 'label': 'Education', 'color': Colors.cyan},
    {'icon': Icons.local_hospital_rounded, 'label': 'Healthcare', 'color': Colors.yellow},
    {'icon': Icons.currency_exchange_rounded, 'label': 'Income', 'color': Colors.green},
    {'icon': Icons.more_horiz_rounded, 'label': 'Other', 'color': Colors.grey},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      final category = _categories[_selectedCategoryIndex];
      final amount = double.parse(_amountController.text);
      final finalAmount = _isIncome ? amount : -amount;
      
      final expense = ExpenseModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _descriptionController.text.isEmpty 
            ? category['label'] 
            : _descriptionController.text,
        amount: finalAmount,
        category: category['label'],
        categoryIcon: category['icon'],
        categoryColor: category['color'],
        date: _selectedDate,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
        isIncome: _isIncome,
      );

      Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_isIncome ? 'Income' : 'Expense'} added successfully!'),
          backgroundColor: Theme.of(context).primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Transaction Help'),
                  content: const Text(
                    '• Select the appropriate category for your transaction\n'
                    '• Enter the amount (positive for income, negative for expenses)\n'
                    '• Add a description to help you remember the transaction\n'
                    '• Choose the correct date for accurate tracking',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Got it'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transaction Type Toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isIncome = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !_isIncome ? Theme.of(context).primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.trending_down_rounded,
                                color: !_isIncome ? Colors.white : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Expense',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: !_isIncome ? Colors.white : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                  fontWeight: !_isIncome ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isIncome = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _isIncome ? Theme.of(context).primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.trending_up_rounded,
                                color: _isIncome ? Colors.white : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Income',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: _isIncome ? Colors.white : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                  fontWeight: _isIncome ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Amount Input Field
            TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Amount (₹)',
                hintText: '0.00',
                  prefixIcon: Icon(
                    _isIncome ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                    color: _isIncome ? Colors.green : Colors.red,
                  ),
                  suffixText: '₹',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Amount must be greater than 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Date Selection
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Date: ${DateFormat('MMM dd, yyyy').format(_selectedDate)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Category Selection
              Text(
                'Select Category',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategoryIndex == index;
                  
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategoryIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? category['color'].withOpacity(0.2)
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected 
                              ? category['color']
                              : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'],
                            color: isSelected ? category['color'] : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['label'],
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isSelected ? category['color'] : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Description Input Field
            TextFormField(
                controller: _descriptionController,
                maxLines: 3,
              decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Add a note about this transaction...',
                  prefixIcon: Icon(Icons.description_rounded),
                ),
              ),
              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveExpense,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
              children: [
                      Icon(
                        _isIncome ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'SAVE ${_isIncome ? 'INCOME' : 'EXPENSE'}',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                ),
              ],
            ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}