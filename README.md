# 💰 Expense Tracker Pro

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white" alt="Material Design">
  <img src="https://img.shields.io/badge/Responsive-Design-4CAF50?style=for-the-badge" alt="Responsive">
</div>

<div align="center">
  <h3>🎯 A Modern, Professional Expense Tracking Application</h3>
  <p>Built with Flutter • Material 3 Design • Fully Responsive • Multiple Themes</p>
</div>

---

## 📱 **App Preview**

### 🎨 **Multiple Beautiful Themes**
- **Modern Indigo** - Professional blue theme
- **Deep Ocean** - Calming ocean blue
- **Forest Green** - Natural green theme
- **Sunset Orange** - Warm orange theme
- **Royal Purple** - Elegant purple theme
- **Cherry Red** - Bold red theme

### 📊 **Key Features**
- 💳 **Transaction Management** - Add income and expenses
- 📈 **Visual Analytics** - Pie charts and spending insights
- 🎨 **Dynamic Theming** - 6 beautiful color schemes
- 📱 **Responsive Design** - Works on all devices
- 🔒 **Form Validation** - Secure input validation
- ✨ **Smooth Animations** - Professional user experience
- 🔐 **User Authentication** - Login and signup system

---

## 🚀 **Getting Started**

### **Prerequisites**
- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- Git

### **Installation**

1. **Clone the repository**
   ```bash
   git clone https://github.com/Venkatatejadegala/-expense-tracker-pro.git
   cd -expense-tracker-pro
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### **Build for Production**

**Android APK:**
```bash
flutter build apk --release
```

**iOS (macOS only):**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

---

## 🏗️ **Project Structure**

```
lib/
├── 📁 main.dart                    # App entry point
├── 📁 models/                      # Data management
│   ├── expense_provider.dart       # Transaction data
│   └── theme_provider.dart         # Theme management
├── 📁 screens/                     # App screens
│   ├── welcome_screen.dart         # Onboarding
│   ├── login_screen.dart           # User login
│   ├── signup_screen.dart          # User registration
│   ├── home_screen.dart            # Dashboard
│   ├── add_expense_screen.dart     # Add transactions
│   ├── profile_screen.dart         # User profile
│   ├── settings_screen.dart        # App settings
│   └── main_navigation_screen.dart # Bottom navigation
├── 📁 widgets/                     # Reusable components
│   ├── animated_button.dart        # Custom buttons
│   ├── responsive_card.dart        # Adaptive cards
│   └── transaction_list_item.dart  # Transaction display
└── 📁 utils/                       # Helper utilities
    ├── responsive_utils.dart       # Responsive design
    ├── validation_utils.dart       # Form validation
    ├── error_handler.dart          # Error management
    └── accessibility_utils.dart    # Accessibility features
```

---

## 🎯 **Features Overview**

### 💳 **Transaction Management**
- ➕ **Add Income/Expenses** with categories
- 📊 **Visual Analytics** with pie charts
- 📅 **Date Selection** for transactions
- 🏷️ **Category Management** (Food, Transport, etc.)
- 💰 **Balance Tracking** with real-time updates

### 🎨 **User Interface**
- 🌈 **6 Dynamic Themes** with instant switching
- 📱 **Responsive Design** for all screen sizes
- ✨ **Smooth Animations** and transitions
- 🎯 **Material 3 Design** guidelines
- 🌙 **Dark Mode** optimized themes

### 🔒 **Security & Validation**
- ✅ **Email Validation** with regex patterns
- 🔐 **Password Strength** indicators
- 📝 **Form Validation** with real-time feedback
- 🛡️ **Input Sanitization** for security

### 📱 **Cross-Platform**
- 🤖 **Android** support
- 🍎 **iOS** support
- 🌐 **Web** support
- 💻 **Desktop** support (Windows, macOS, Linux)

---

## 🛠️ **Technologies Used**

### **Core Framework**
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language

### **State Management**
- **Provider** - State management solution
- **ChangeNotifier** - Reactive state updates

### **UI/UX Libraries**
- **FL Chart** - Beautiful charts and graphs
- **Flutter Staggered Animations** - Smooth animations

### **Utilities**
- **SharedPreferences** - Local data storage
- **Intl** - Internationalization

---

## 📱 **Screens & Navigation**

### **App Flow**
```
Welcome Screen
    ↓
Login/Signup Screen
    ↓
Main Navigation (Bottom Tabs)
    ├── 🏠 Dashboard (Home)
    ├── ➕ Add Transaction
    ├── 👤 Profile
    └── ⚙️ Settings
```

### **Screen Descriptions**

#### 🏠 **Dashboard (Home)**
- Total balance display
- Income vs Expenses comparison
- Category-wise spending pie chart
- Recent transactions list
- Time period selector

#### ➕ **Add Transaction**
- Amount input with currency formatting
- Category selection with icons
- Date picker
- Income/Expense toggle
- Description field

#### 👤 **Profile**
- User information display
- Account statistics
- Settings shortcuts
- Logout functionality

#### ⚙️ **Settings**
- Theme selection (6 options)
- Notification preferences
- Security settings
- App information

---

## 🎨 **Theming System**

### **Available Themes**
1. **Modern Indigo** - Professional blue theme
2. **Deep Ocean** - Calming ocean blue
3. **Forest Green** - Natural green theme
4. **Sunset Orange** - Warm orange theme
5. **Royal Purple** - Elegant purple theme
6. **Cherry Red** - Bold red theme

### **Theme Features**
- 🎨 **Instant switching** between themes
- 💾 **Persistent storage** of user preference
- 🌈 **Complete color scheme** updates
- 📱 **Responsive** theme application

---

## 📊 **Data Management**

### **Expense Provider**
- Manages all transaction data
- Calculates totals and statistics
- Handles category-wise expenses
- Provides real-time updates

### **Theme Provider**
- Manages theme selection
- Persists user preferences
- Applies themes across the app
- Handles theme switching

---

## 🔧 **Development**

### **Code Quality**
- ✅ **Clean Architecture** with separation of concerns
- 📝 **Well-documented** code with comments
- 🧪 **Type-safe** Dart code
- 🎯 **Consistent** coding style

### **Performance**
- ⚡ **Optimized** rendering and animations
- 📱 **Responsive** design for all devices
- 💾 **Efficient** state management
- 🚀 **Fast** app startup and navigation

---

## 🤝 **Contributing**

We welcome contributions! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### **Contribution Guidelines**
- Follow Flutter/Dart style guidelines
- Add comments for complex logic
- Test on multiple devices
- Update documentation as needed

---

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 **Author**

**Venkatatejadegala**
- GitHub: [@Venkatatejadegala](https://github.com/Venkatatejadegala)
- Email: 23pa1a4227@vishnu.edu.in
- LinkedIn: (add your profile link here)

---

## 🙏 **Acknowledgments**

- **Flutter Team** for the amazing framework
- **Material Design** for design guidelines
- **Open Source Community** for inspiration
- **Contributors** who helped improve this project

---

## 📞 **Support**

If you have any questions or need help:

- 📧 **Email**: 23pa1a4227@vishnu.edu.in
- 🐛 **Issues**: [GitHub Issues](https://github.com/Venkatatejadegala/-expense-tracker-pro/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/Venkatatejadegala/-expense-tracker-pro/discussions)

---

<div align="center">
  <h3>⭐ Star this repository if you found it helpful!</h3>
  <p>Made with ❤️ using Flutter</p>
</div>