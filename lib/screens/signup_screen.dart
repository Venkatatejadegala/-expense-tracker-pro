import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/models/theme_provider.dart';
import 'package:expense_tracker/utils/validation_utils.dart';
import 'package:expense_tracker/widgets/animated_button.dart';
import 'package:expense_tracker/utils/responsive_utils.dart';
import 'package:expense_tracker/utils/error_handler.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  bool _isLoading = false;
  
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptTerms) {
      ErrorHandler.showWarningSnackBar(context, 'Please accept the Terms & Conditions');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate signup process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ErrorHandler.showSuccessSnackBar(context, 'Account created successfully!');
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
    return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  themeProvider.currentTheme.scaffoldBackground,
                  themeProvider.currentTheme.primaryGradientStart.withOpacity(0.1),
                  themeProvider.currentTheme.primaryGradientEnd.withOpacity(0.05),
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: ResponsiveUtils.getResponsivePadding(context),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: ResponsiveUtils.isMobile(context) ? double.infinity : 400,
                        ),
                        child: Card(
                          elevation: 20,
                          shadowColor: themeProvider.currentTheme.primaryGradientStart.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              colors: [
                                themeProvider.currentTheme.cardBackground,
                                themeProvider.currentTheme.cardBackground.withOpacity(0.9),
                              ],
                              ),
                            ),
                            child: Form(
                              key: _formKey,
        child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Logo and Welcome
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          themeProvider.currentTheme.primaryGradientStart,
                                          themeProvider.currentTheme.primaryGradientEnd,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      Icons.person_add_rounded,
                                      size: 48,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  
                                  Text(
                                    'Create Account',
                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: themeProvider.currentTheme.colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Join us and take control of your finances',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: themeProvider.currentTheme.colorScheme.onSurface.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(height: 32),

            // Name Field
            TextFormField(
                                    controller: _nameController,
              keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    validator: ValidationUtils.validateName,
                                    decoration: InputDecoration(
                labelText: 'Full Name',
                                      hintText: 'Enter your full name',
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: themeProvider.currentTheme.colorScheme.primary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: themeProvider.currentTheme.colorScheme.outline,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: themeProvider.currentTheme.colorScheme.primary,
                                          width: 2,
                                        ),
                                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Email Field
            TextFormField(
                                    controller: _emailController,
              keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: ValidationUtils.validateEmail,
                                    decoration: InputDecoration(
                labelText: 'Email Address',
                                      hintText: 'Enter your email',
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: themeProvider.currentTheme.colorScheme.primary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: themeProvider.currentTheme.colorScheme.outline,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: themeProvider.currentTheme.colorScheme.primary,
                                          width: 2,
                                        ),
                                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Password Field
            TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    textInputAction: TextInputAction.next,
                                    validator: ValidationUtils.validatePassword,
                                    onChanged: (value) {
                                      setState(() {}); // Trigger rebuild for password strength indicator
                                    },
                                    decoration: InputDecoration(
                labelText: 'Password',
                                      hintText: 'Create a strong password',
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: themeProvider.currentTheme.colorScheme.primary,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                          color: themeProvider.currentTheme.colorScheme.onSurface.withOpacity(0.6),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword = !_obscurePassword;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: themeProvider.currentTheme.colorScheme.outline,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: themeProvider.currentTheme.colorScheme.primary,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  // Password Strength Indicator
                                  PasswordStrengthIndicator(
                                    password: _passwordController.text,
                                    showIndicator: _passwordController.text.isNotEmpty,
                                  ),
                                  const SizedBox(height: 20),

                                  // Confirm Password Field
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: _obscureConfirmPassword,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) => ValidationUtils.validateConfirmPassword(value, _passwordController.text),
                                    onFieldSubmitted: (_) => _signUp(),
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      hintText: 'Confirm your password',
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: themeProvider.currentTheme.colorScheme.primary,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                                          color: themeProvider.currentTheme.colorScheme.onSurface.withOpacity(0.6),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword = !_obscureConfirmPassword;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: themeProvider.currentTheme.colorScheme.outline,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                          color: themeProvider.currentTheme.colorScheme.primary,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  // Terms and Conditions
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        value: _acceptTerms,
                                        onChanged: (value) {
                                          setState(() {
                                            _acceptTerms = value ?? false;
                                          });
                                        },
                                        activeColor: themeProvider.currentTheme.colorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _acceptTerms = !_acceptTerms;
                                            });
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'I agree to the ',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: themeProvider.currentTheme.colorScheme.onSurface.withOpacity(0.7),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Terms & Conditions',
                                                  style: TextStyle(
                                                    color: themeProvider.currentTheme.colorScheme.primary,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' and ',
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: themeProvider.currentTheme.colorScheme.onSurface.withOpacity(0.7),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Privacy Policy',
                                                  style: TextStyle(
                                                    color: themeProvider.currentTheme.colorScheme.primary,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 32),

            // Sign Up Button
                                  AnimatedButton(
                                    text: 'CREATE ACCOUNT',
                                    onPressed: _isLoading ? null : _signUp,
                                    isLoading: _isLoading,
                                    backgroundColor: themeProvider.currentTheme.primaryGradientStart,
                                    foregroundColor: Colors.white,
                                    width: double.infinity,
                                    height: 56,
                                    borderRadius: BorderRadius.circular(16),
                                    elevation: 8,
                                  ),
                                  const SizedBox(height: 24),

                                  // Divider
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: themeProvider.currentTheme.colorScheme.onSurface.withOpacity(0.3),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          'OR',
                                          style: TextStyle(
                                            color: themeProvider.currentTheme.colorScheme.onSurface.withOpacity(0.6),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: themeProvider.currentTheme.colorScheme.onSurface.withOpacity(0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),

                                  // Social Sign Up Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            ErrorHandler.showInfoSnackBar(context, 'Google sign-up coming soon!');
                                          },
                                          icon: const Icon(Icons.g_mobiledata, size: 24),
                                          label: const Text('Google'),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: OutlinedButton.icon(
              onPressed: () {
                                            ErrorHandler.showInfoSnackBar(context, 'Apple sign-up coming soon!');
                                          },
                                          icon: const Icon(Icons.apple, size: 20),
                                          label: const Text('Apple'),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),

                                  // Login Link
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account? ',
                                        style: TextStyle(
                                          color: themeProvider.currentTheme.colorScheme.onSurface.withOpacity(0.7),
                                        ),
                                      ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                            color: themeProvider.currentTheme.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
            ),
          ],
        ),
      ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
