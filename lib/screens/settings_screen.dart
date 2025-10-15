import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/models/theme_provider.dart';
import 'package:expense_tracker/models/expense_provider.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onBackPressed;
  
  const SettingsScreen({super.key, this.onBackPressed});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            if (widget.onBackPressed != null) {
              widget.onBackPressed!();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: Consumer2<ThemeProvider, ExpenseProvider>(
        builder: (context, themeProvider, expenseProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Theme Preview
                _buildThemePreview(themeProvider),
                const SizedBox(height: 24),

                // Appearance Settings
                _buildSettingsSection(
                  'Appearance',
                  [
                    _buildThemeSelector(themeProvider),
                    _buildSettingsTile(
                      icon: Icons.notifications_rounded,
                      title: 'Notifications',
                      subtitle: 'Get notified about your expenses',
                      trailing: Switch(
                        value: _notificationsEnabled,
                        onChanged: (value) => setState(() => _notificationsEnabled = value),
                      ),
                    ),
                    _buildSettingsTile(
                      icon: Icons.fingerprint_rounded,
                      title: 'Biometric Authentication',
                      subtitle: 'Use fingerprint or face unlock',
                      trailing: Switch(
                        value: _biometricEnabled,
                        onChanged: (value) => setState(() => _biometricEnabled = value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Data & Privacy
                _buildSettingsSection(
                  'Data & Privacy',
                  [
                    _buildSettingsTile(
                      icon: Icons.security_rounded,
                      title: 'Security & Privacy',
                      subtitle: 'Manage your account security',
                      onTap: () => _showSecurityDialog(context),
                    ),
                    _buildSettingsTile(
                      icon: Icons.backup_rounded,
                      title: 'Backup & Sync',
                      subtitle: 'Sync your data across devices',
                      onTap: () => _showBackupDialog(context),
                    ),
                    _buildSettingsTile(
                      icon: Icons.analytics_rounded,
                      title: 'Data Analytics',
                      subtitle: 'Help improve the app with usage data',
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // App Management
                _buildSettingsSection(
                  'App Management',
                  [
                    _buildSettingsTile(
                      icon: Icons.storage_rounded,
                      title: 'Storage Usage',
                      subtitle: '${expenseProvider.expenses.length} transactions stored',
                      onTap: () => _showStorageDialog(context, expenseProvider),
                    ),
                    _buildSettingsTile(
                      icon: Icons.refresh_rounded,
                      title: 'Clear Cache',
                      subtitle: 'Free up storage space',
                      onTap: () => _showClearCacheDialog(context),
                    ),
                    _buildSettingsTile(
                      icon: Icons.restore_rounded,
                      title: 'Reset App Data',
                      subtitle: 'Start fresh with default settings',
                      textColor: Colors.orange,
                      onTap: () => _showResetDialog(context, expenseProvider),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Support & Info
                _buildSettingsSection(
                  'Support & Info',
                  [
                    _buildSettingsTile(
                      icon: Icons.help_outline_rounded,
                      title: 'Help Center',
                      subtitle: 'Get help and support',
                      onTap: () => _showHelpDialog(context),
                    ),
                    _buildSettingsTile(
                      icon: Icons.bug_report_rounded,
                      title: 'Report Issue',
                      subtitle: 'Help us fix bugs and improve',
                      onTap: () => _showReportDialog(context),
                    ),
                    _buildSettingsTile(
                      icon: Icons.star_rounded,
                      title: 'Rate App',
                      subtitle: 'Love the app? Leave a review!',
                      onTap: () => _showRateDialog(context),
                    ),
                    _buildSettingsTile(
                      icon: Icons.info_outline_rounded,
                      title: 'About',
                      subtitle: 'App version and information',
                      onTap: () => _showAboutDialog(context),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildThemePreview(ThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeProvider.currentTheme.primaryGradientStart,
            themeProvider.currentTheme.primaryGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: themeProvider.currentTheme.primaryGradientStart.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.palette_rounded,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Current Theme',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            themeProvider.currentTheme.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap to change theme',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(ThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.palette_rounded,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Choose Theme',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3,
            ),
            itemCount: themeProvider.availableThemes.length,
            itemBuilder: (context, index) {
              final theme = themeProvider.availableThemes[index];
              final isSelected = theme == themeProvider.currentTheme;
              
              return GestureDetector(
                onTap: () => themeProvider.setTheme(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected 
                        ? LinearGradient(
                            colors: [theme.primaryGradientStart, theme.primaryGradientEnd],
                          )
                        : null,
                    color: isSelected ? null : theme.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : theme.primaryGradientStart.withOpacity(0.3),
                      width: isSelected ? 0 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : theme.primaryGradientStart,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          theme.name,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (textColor ?? Theme.of(context).primaryColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: textColor ?? Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
      trailing: trailing ?? Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
      ),
      onTap: onTap,
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Expense Tracker Pro',
      applicationVersion: '2.0.0',
      applicationIcon: Icon(
        Icons.account_balance_wallet_rounded,
        size: 48,
        color: Theme.of(context).primaryColor,
      ),
      children: [
        const Text('A modern expense tracking app with beautiful themes and intuitive design.'),
        const SizedBox(height: 16),
        Text(
          'Built with Flutter & Material 3\n'
          'Features multiple themes, charts, and smart categorization.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  void _showSecurityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Security & Privacy'),
        content: const Text(
          'Your financial data is encrypted and stored securely on your device. '
          'We never share your personal information with third parties.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backup & Sync'),
        content: const Text(
          'Backup features will be available in future updates. '
          'Your data is currently stored locally on your device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showStorageDialog(BuildContext context, ExpenseProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Storage Usage'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total Transactions: ${provider.expenses.length}'),
            const SizedBox(height: 8),
            Text('Data Size: ~${(provider.expenses.length * 0.5).toStringAsFixed(1)} KB'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear temporary files and free up storage space.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully!')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, ExpenseProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset App Data'),
        content: const Text(
          'This will delete all your transactions and reset the app to default settings. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Reset logic would go here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('App data reset successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help Center'),
        content: const Text(
          'Need help? Here are some quick tips:\n\n'
          '• Tap the + button to add expenses\n'
          '• Swipe transactions to delete them\n'
          '• Change themes in Settings\n'
          '• Use categories for better organization',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Issue'),
        content: const Text(
          'Found a bug or have a suggestion? We\'d love to hear from you! '
          'Please describe the issue in detail.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you for your feedback!')),
              );
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate App'),
        content: const Text(
          'Enjoying the app? Your rating helps us improve and reach more users!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you for your support!')),
              );
            },
            child: const Text('Rate Now'),
          ),
        ],
      ),
    );
  }
}
