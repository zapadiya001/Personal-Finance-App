import 'package:finance_app/screens/account.dart';
import 'package:finance_app/screens/analysis.dart';
import 'package:finance_app/screens/budget.dart';
import 'package:finance_app/screens/categories.dart';
import 'package:flutter/material.dart';

class MyMoneyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Money',
      theme: ThemeData(
        primaryColor: Color(0xFF4CAF50),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF4CAF50),
          secondary: Color(0xFF03A9F4),
          background: Color(0xFFF9F9F9),
          surface: Colors.white,
          onSurface: Color(0xFF212121),
        ),
        scaffoldBackgroundColor: Color(0xFFF9F9F9),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF9F9F9),
          foregroundColor: Color(0xFF212121),
          elevation: 0,
        ),
        fontFamily: 'Roboto',
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    RecordsScreen(),
    AnalysisScreen(),
    BudgetsScreen(),
    AccountsScreen(),
    CategoriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        backgroundColor: Color(0xFF4CAF50),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Custom App Bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFF9F9F9),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Color(0xFF4CAF50), size: 28),
        onPressed: () {},
      ),
      title: Text(
        'MyMoney',
        style: TextStyle(
          color: Color(0xFF4CAF50),
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Color(0xFF4CAF50), size: 28),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Custom Bottom Navigation Bar
class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF4CAF50),
        unselectedItemColor: Color(0xFF9E9E9E),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            activeIcon: Icon(Icons.calculate),
            label: 'Budgets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            activeIcon: Icon(Icons.account_balance),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
      ),
    );
  }
}

// Records Screen
class RecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month Navigation Header
        Container(
          padding: EdgeInsets.all(16),
          color: Color(0xFFF9F9F9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left, color: Color(0xFF9E9E9E)),
                onPressed: () {},
              ),
              Text(
                'May, 2025',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF212121),
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, color: Color(0xFF9E9E9E)),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.tune, color: Color(0xFF9E9E9E)),
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Summary Cards
        Container(
          padding: EdgeInsets.all(16),
          color: Color(0xFFF9F9F9),
          child: Row(
            children: [
              Expanded(
                child: _buildSummaryCard('EXPENSE', '₹0.00', Color(0xFFD32F2F)),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildSummaryCard('INCOME', '₹0.00', Color(0xFF2E7D32)),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildSummaryCard('TOTAL', '₹0.00', Color(0xFF212121)),
              ),
            ],
          ),
        ),
        // Empty State
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 80,
                  color: Color(0xFF9E9E9E),
                ),
                SizedBox(height: 16),
                Text(
                  'No record in this month. Tap + to add new expense\nor income.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String amount, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF9E9E9E),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 18,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Account Model
class Account {
  final String name;
  final IconData icon;
  final Color color;
  final double balance;

  Account({
    required this.name,
    required this.icon,
    required this.color,
    this.balance = 0.00,
  });
}

// Category Model
class TransactionCategory {
  final String name;
  final IconData icon;
  final Color color;

  TransactionCategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

// Account Selection Screen
class AccountSelectionScreen extends StatelessWidget {
  final Function(Account) onAccountSelected;

  AccountSelectionScreen({
    Key? key,
    required this.onAccountSelected,
  }) : super(key: key);

  final List<Account> accounts = [
    Account(
      name: 'Card',
      icon: Icons.credit_card,
      color: Color(0xFFFF5722),
      balance: 0.00,
    ),
    Account(
      name: 'Cash',
      icon: Icons.money,
      color: Color(0xFF4CAF50),
      balance: 0.00,
    ),
    Account(
      name: 'Savings',
      icon: Icons.savings,
      color: Color(0xFFE91E63),
      balance: 0.00,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xFF555555),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Select an account',
              style: TextStyle(
                color: Color(0xFFD4AF37),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Account List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final account = accounts[index];
                return GestureDetector(
                  onTap: () {
                    onAccountSelected(account);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF3D3D3D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: account.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            account.icon,
                            color: account.color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            account.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          '₹${account.balance.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Add New Account Button
          Padding(
            padding: EdgeInsets.all(24),
            child: GestureDetector(
              onTap: () {
                // Handle add new account
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD4AF37)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Color(0xFFD4AF37),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ADD NEW ACCOUNT',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Category Selection Screen
class CategorySelectionScreen extends StatelessWidget {
  final Function(TransactionCategory) onCategorySelected;

  CategorySelectionScreen({
    Key? key,
    required this.onCategorySelected,
  }) : super(key: key);

  final List<TransactionCategory> categories = [
    TransactionCategory(name: 'Baby', icon: Icons.child_care, color: Color(0xFF8D6E63)),
    TransactionCategory(name: 'Beauty', icon: Icons.face, color: Color(0xFFE91E63)),
    TransactionCategory(name: 'Bills', icon: Icons.receipt, color: Color(0xFF424242)),
    TransactionCategory(name: 'Car', icon: Icons.directions_car, color: Color(0xFF673AB7)),
    TransactionCategory(name: 'Clothing', icon: Icons.checkroom, color: Color(0xFFFF9800)),
    TransactionCategory(name: 'Education', icon: Icons.school, color: Color(0xFF3F51B5)),
    TransactionCategory(name: 'Electronics', icon: Icons.devices, color: Color(0xFF009688)),
    TransactionCategory(name: 'Entertainment', icon: Icons.movie, color: Color(0xFF7986CB)),
    TransactionCategory(name: 'Food', icon: Icons.restaurant, color: Color(0xFFD32F2F)),
    TransactionCategory(name: 'Health', icon: Icons.health_and_safety, color: Color(0xFFFF5722)),
    TransactionCategory(name: 'Home', icon: Icons.home, color: Color(0xFFAD1457)),
    TransactionCategory(name: 'Insurance', icon: Icons.security, color: Color(0xFFFF9800)),
    TransactionCategory(name: 'Shopping', icon: Icons.shopping_cart, color: Color(0xFF2196F3)),
    TransactionCategory(name: 'Social', icon: Icons.people, color: Color(0xFF4CAF50)),
    TransactionCategory(name: 'Sport', icon: Icons.sports_tennis, color: Color(0xFF8BC34A)),
    TransactionCategory(name: 'Tax', icon: Icons.account_balance, color: Color(0xFFFF5722)),
    TransactionCategory(name: 'Telephone', icon: Icons.phone, color: Color(0xFFCDDC39)),
    TransactionCategory(name: 'Transportation', icon: Icons.directions_bus, color: Color(0xFF3F51B5)),
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xFF555555),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Select a category',
              style: TextStyle(
                color: Color(0xFFD4AF37),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Categories Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    onCategorySelected(category);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: category.color,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          category.icon,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        category.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Add New Category Button
          Padding(
            padding: EdgeInsets.all(24),
            child: GestureDetector(
              onTap: () {
                // Handle add new category
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD4AF37)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Color(0xFFD4AF37),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ADD NEW CATEGORY',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Add Transaction Screen
class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  int selectedType = 1; // 0: Income, 1: Expense, 2: Transfer
  String amount = '0';
  TextEditingController notesController = TextEditingController();
  Account? selectedAccount;
  TransactionCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9F9F9),
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.close, color: Color(0xFF4CAF50)),
              SizedBox(width: 4),
              Text(
                'CANCEL',
                style: TextStyle(
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 100,
        actions: [
          TextButton(
            onPressed: () {
              // Save transaction
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check, color: Color(0xFF4CAF50)),
                SizedBox(width: 4),
                Text(
                  'SAVE',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Transaction Type Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTypeButton('INCOME', 0),
                _buildTypeButton('EXPENSE', 1),
                _buildTypeButton('TRANSFER', 2),
              ],
            ),
            SizedBox(height: 20),

            // Account and Category Selection
            Row(
              children: [
                Expanded(
                  child: _buildSelectionCard(
                    'Account',
                    selectedAccount?.icon ?? Icons.account_balance_outlined,
                    selectedAccount?.name ?? 'Account',
                        () => _showAccountSelection(),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildSelectionCard(
                    'Category',
                    selectedCategory?.icon ?? Icons.local_offer_outlined,
                    selectedCategory?.name ?? 'Category',
                        () => _showCategorySelection(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Notes Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF9E9E9E)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add notes',
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
            SizedBox(height: 12),

            // Amount Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF9E9E9E)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (amount.length > 1) {
                        setState(() {
                          amount = amount.substring(0, amount.length - 1);
                        });
                      } else {
                        setState(() {
                          amount = '0';
                        });
                      }
                    },
                    icon: Icon(Icons.backspace_outlined, color: Color(0xFF9E9E9E)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Calculator
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return _buildCalculatorButton(_getButtonText(index));
                },
              ),
            ),

            // Date and Time
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'May 27, 2025',
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '9:26 PM',
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAccountSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AccountSelectionScreen(
        onAccountSelected: (account) {
          setState(() {
            selectedAccount = account;
          });
        },
      ),
    );
  }

  void _showCategorySelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CategorySelectionScreen(
        onCategorySelected: (category) {
          setState(() {
            selectedCategory = category;
          });
        },
      ),
    );
  }

  Widget _buildTypeButton(String title, int index) {
    bool isSelected = selectedType == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF4CAF50) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.white, size: 16),
            if (isSelected) SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xFF9E9E9E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard(String title, IconData icon, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF9E9E9E)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(icon, color: Color(0xFF4CAF50)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorButton(String text) {
    bool isOperator = ['+', '-', '×', '÷', '='].contains(text);
    return GestureDetector(
      onTap: () => _onCalculatorButtonPressed(text),
      child: Container(
        decoration: BoxDecoration(
          color: isOperator ? Color(0xFF4CAF50) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF9E9E9E)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isOperator ? Colors.white : Color(0xFF212121),
            ),
          ),
        ),
      ),
    );
  }

  String _getButtonText(int index) {
    List<String> buttons = [
      '+', '7', '8', '9',
      '-', '4', '5', '6',
      '×', '1', '2', '3',
      '÷', '0', '.', '='
    ];
    return buttons[index];
  }

  void _onCalculatorButtonPressed(String text) {
    setState(() {
      if (text == '.' && amount.contains('.')) return;

      if (amount == '0' && text != '.') {
        amount = text;
      } else {
        amount += text;
      }
    });
  }
}