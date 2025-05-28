import 'package:finance_app/screens/account.dart';
import 'package:finance_app/screens/analysis.dart';
import 'package:finance_app/screens/budget.dart';
import 'package:finance_app/screens/categories.dart';
import 'package:finance_app/screens/records.dart';
import 'package:finance_app/screens/templets/appbar.dart';
import 'package:finance_app/screens/templets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'add_transaction.dart';

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
              builder: (context) => AddTransactionPage(),
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
