import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:expense_tracker/models/expense_provider.dart';
import 'package:expense_tracker/models/theme_provider.dart';
import 'package:expense_tracker/widgets/transaction_list_item.dart';
import 'package:expense_tracker/widgets/responsive_card.dart';
import 'package:expense_tracker/widgets/animated_button.dart';
import 'package:expense_tracker/utils/responsive_utils.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showTotal = true;
  int _selectedTimeframe = 0; // 0: Week, 1: Month, 2: Year

  void _toggleBalanceVisibility() {
    setState(() {
      _showTotal = !_showTotal;
    });
  }

  Widget _buildStat(String title, double amount, Color color, IconData icon) {
    return ResponsiveCard(
      padding: EdgeInsets.all(ResponsiveUtils.getResponsiveSpacing(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.getResponsiveSpacing(context, 8)),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon, 
                  color: color, 
                  size: ResponsiveUtils.getResponsiveIconSize(context, 20),
                ),
              ),
              SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, 8)),
              Expanded(
                child: ResponsiveText(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 8)),
          ResponsiveText(
            '${amount.abs().toStringAsFixed(2)} ₹',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseChart(ExpenseProvider provider) {
    final categoryData = provider.categoryExpenses;
    if (categoryData.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            'No data available',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: categoryData.entries.map((entry) {
            final colors = [
              Colors.blue,
              Colors.orange,
              Colors.green,
              Colors.purple,
              Colors.red,
              Colors.yellow,
              Colors.cyan,
              Colors.pink,
            ];
            final color = colors[categoryData.keys.toList().indexOf(entry.key) % colors.length];
            
            return PieChartSectionData(
              color: color,
              value: entry.value,
              title: '${(entry.value / categoryData.values.fold(0.0, (a, b) => a + b) * 100).toStringAsFixed(0)}%',
              radius: 50,
              titleStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    final timeframes = ['Week', 'Month', 'Year'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: timeframes.asMap().entries.map((entry) {
          final index = entry.key;
          final timeframe = entry.value;
          final isSelected = _selectedTimeframe == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTimeframe = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  timeframe,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCardSection(BuildContext context, bool isMobile, ExpenseProvider provider, ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // GREETING AND SETTINGS ICON
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good ${_getGreeting()}!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Here\'s your financial overview',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.settings_rounded,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              onPressed: () => Navigator.pushNamed(context, '/profile'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // MAIN BALANCE CARD
        GestureDetector(
          onTap: _toggleBalanceVisibility,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeProvider.currentTheme.primaryGradientStart,
                  themeProvider.currentTheme.primaryGradientEnd,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                  color: themeProvider.currentTheme.primaryGradientStart.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Balance',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Icon(
                      _showTotal ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                      color: Colors.white.withOpacity(0.7),
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Text(
                    _showTotal ? '${provider.totalBalance.toStringAsFixed(2)} ₹' : '******',
                        key: ValueKey<bool>(_showTotal),
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                          fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStat(
                        'Income',
                        provider.totalIncome,
                        Colors.greenAccent,
                        Icons.trending_up_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStat(
                        'Expenses',
                        -provider.totalExpenses,
                        Colors.redAccent,
                        Icons.trending_down_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }

  Widget _buildTransactionList(BuildContext context, ExpenseProvider provider) {
    final recentExpenses = provider.recentExpenses.take(5).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {
                // Navigate to full transaction list
              },
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (recentExpenses.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No transactions yet',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your first expense to get started',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          )
        else
          AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: recentExpenses.map((expense) {
            return TransactionListItem(
                    categoryIcon: expense.categoryIcon,
                    categoryName: expense.title,
                    amount: expense.amount,
                    date: DateFormat('MMM dd').format(expense.date),
                    color: expense.categoryColor,
            );
          }).toList(),
              ),
            ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ExpenseProvider, ThemeProvider>(
      builder: (context, provider, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: ResponsiveText(
              'Dashboard',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            actions: [
              AnimatedIconButton(
                icon: Icons.notifications_outlined,
                onPressed: () {
                  // Handle notifications
                },
                size: ResponsiveUtils.getResponsiveIconSize(context, 24),
              ),
            ],
          ),
          body: ResponsiveContainer(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = ResponsiveUtils.isMobile(context);
                
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Balance and Stats Section
                      _buildCardSection(context, isMobile, provider, themeProvider),
                      
                      // Timeframe Selector
                      _buildTimeframeSelector(),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 24)),
                      
                      // Stats Row - Responsive Layout
                      ResponsiveWidget(
                        mobile: Column(
                          children: [
                            _buildStat('Income', provider.totalIncome, Colors.green, Icons.trending_up_rounded),
                            SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 16)),
                            _buildStat('Expenses', provider.totalExpenses, Colors.red, Icons.trending_down_rounded),
                          ],
                        ),
                        tablet: Row(
                          children: [
                            Expanded(
                              child: _buildStat('Income', provider.totalIncome, Colors.green, Icons.trending_up_rounded),
                            ),
                            SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, 16)),
                            Expanded(
                              child: _buildStat('Expenses', provider.totalExpenses, Colors.red, Icons.trending_down_rounded),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 24)),
                      
                      // Expense Chart
                      ResponsiveText(
                        'Expense Breakdown',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 16)),
                      _buildExpenseChart(provider),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 32)),
                      
                      // Recent Transactions
                      _buildTransactionList(context, provider),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, 32)),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}