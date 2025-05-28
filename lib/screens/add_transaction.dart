import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color primary = Color(0xFF4CAF50); // Emerald Green
  static const Color secondary = Color(0xFF03A9F4); // Light Blue
  static const Color background = Color(0xFFF9F9F9); // Almost White
  static const Color textPrimary = Color(0xFF212121); // Dark Grey
  static const Color income = Color(0xFF2E7D32); // Deep Green
  static const Color expense = Color(0xFFD32F2F); // Red
  static const Color neutral = Color(0xFF9E9E9E); // Grey
}

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  int selectedTab = 1; // 0: Income, 1: Expense, 2: Transfer
  final TextEditingController notesController = TextEditingController();
  String calculatorDisplay = '0';
  String previousValue = '';
  String operator = '';
  bool waitingForOperand = false;

  final List<String> tabLabels = ['INCOME', 'EXPENSE', 'TRANSFER'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;
    final isVerySmallScreen = size.height < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Cancel and Save
            _buildTopBar(),

            // Tab Section
            _buildTabSection(),

            // Account and Category Buttons
            _buildButtonSection(),

            // Notes Section
            _buildNotesSection(isVerySmallScreen),

            // Calculator Section
            Expanded(
              child: _buildCalculatorSection(isSmallScreen, isVerySmallScreen),
            ),

            // Date and Time Section - Always visible
            _buildDateTimeSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(
              children: [
                Icon(Icons.close, color: Colors.amber, size: 24),
                SizedBox(width: 8),
                Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle save action
            },
            child: const Row(
              children: [
                Icon(Icons.check, color: Colors.amber, size: 24),
                SizedBox(width: 8),
                Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: List.generate(3, (index) {
          final isSelected = selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? Colors.amber : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isSelected)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.amber,
                        size: 20,
                      ),
                    if (isSelected) const SizedBox(width: 8),
                    Text(
                      tabLabels[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey,
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildButtonSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildButton('Account', Icons.account_balance_wallet),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildButton('Category', Icons.local_offer),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Handle button tap
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF3D3D3D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade600),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade400, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection(bool isVerySmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: isVerySmallScreen ? 60 : 80,
        decoration: BoxDecoration(
          color: const Color(0xFF3D3D3D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade600),
        ),
        child: TextField(
          controller: notesController,
          maxLines: isVerySmallScreen ? 2 : 3,
          decoration: const InputDecoration(
            hintText: 'Add notes',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(12),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildCalculatorSection(bool isSmallScreen, bool isVerySmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3D3D3D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade600),
        ),
        child: Column(
          children: [
            // Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isVerySmallScreen ? 12 : 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side - show current operation
                  if (operator.isNotEmpty && previousValue.isNotEmpty)
                    Text(
                      '$previousValue $operator',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: isVerySmallScreen ? 14 : 16,
                      ),
                    )
                  else
                    const SizedBox(),

                  // Right side - current display and clear button
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            calculatorDisplay,
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: isVerySmallScreen ? 24 : 32,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _clearCalculator(),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Calculator Buttons
            Expanded(
              child: _buildCalculatorGrid(isSmallScreen, isVerySmallScreen),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorGrid(bool isSmallScreen, bool isVerySmallScreen) {
    final buttonHeight = isVerySmallScreen ? 45.0 : (isSmallScreen ? 50.0 : 55.0);

    return Column(
      children: [
        // Row 1: +, 7, 8, 9
        Expanded(child: _buildCalculatorRow(['+', '7', '8', '9'], buttonHeight)),
        // Row 2: -, 4, 5, 6
        Expanded(child: _buildCalculatorRow(['-', '4', '5', '6'], buttonHeight)),
        // Row 3: ×, 1, 2, 3
        Expanded(child: _buildCalculatorRow(['×', '1', '2', '3'], buttonHeight)),
        // Row 4: ÷, 0, ., =
        Expanded(child: _buildCalculatorRow(['÷', '0', '.', '='], buttonHeight)),
      ],
    );
  }

  Widget _buildCalculatorRow(List<String> buttons, double height) {
    return Row(
      children: buttons.map((button) {
        return Expanded(
          child: _buildCalculatorButton(button, height),
        );
      }).toList(),
    );
  }

  Widget _buildCalculatorButton(String label, double height) {
    final bool isOperator = ['+', '-', '×', '÷', '='].contains(label);
    final bool isNumber = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'].contains(label);

    Color backgroundColor;
    Color textColor;

    if (isOperator) {
      backgroundColor = const Color(0xFF5D5D5D);
      textColor = Colors.white;
    } else {
      backgroundColor = const Color(0xFF4D4D4D);
      textColor = Colors.white;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => _onCalculatorButtonPressed(label),
        child: Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: height < 50 ? 16 : 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onCalculatorButtonPressed(String button) {
    setState(() {
      if (button == 'C') {
        _clearCalculator();
      } else if (['+', '-', '×', '÷'].contains(button)) {
        _handleOperator(button);
      } else if (button == '=') {
        _calculateResult();
      } else if (button == '.') {
        _handleDecimal();
      } else {
        _handleNumber(button);
      }
    });
  }

  void _clearCalculator() {
    calculatorDisplay = '0';
    previousValue = '';
    operator = '';
    waitingForOperand = false;
  }

  void _handleNumber(String number) {
    if (waitingForOperand) {
      calculatorDisplay = number;
      waitingForOperand = false;
    } else {
      calculatorDisplay = calculatorDisplay == '0' ? number : calculatorDisplay + number;
    }
  }

  void _handleOperator(String newOperator) {
    final double inputValue = double.parse(calculatorDisplay);

    if (previousValue.isEmpty) {
      previousValue = calculatorDisplay;
    } else if (!waitingForOperand) {
      final double prevValue = double.parse(previousValue);
      final double result = _performCalculation(prevValue, inputValue, operator);

      calculatorDisplay = _formatNumber(result);
      previousValue = calculatorDisplay;
    }

    waitingForOperand = true;
    operator = newOperator;
  }

  void _handleDecimal() {
    if (waitingForOperand) {
      calculatorDisplay = '0.';
      waitingForOperand = false;
    } else if (!calculatorDisplay.contains('.')) {
      calculatorDisplay += '.';
    }
  }

  void _calculateResult() {
    if (operator.isNotEmpty && previousValue.isNotEmpty && !waitingForOperand) {
      final double prevValue = double.parse(previousValue);
      final double currentValue = double.parse(calculatorDisplay);
      final double result = _performCalculation(prevValue, currentValue, operator);

      calculatorDisplay = _formatNumber(result);
      previousValue = '';
      operator = '';
      waitingForOperand = true;
    }
  }

  double _performCalculation(double prev, double current, String operator) {
    switch (operator) {
      case '+':
        return prev + current;
      case '-':
        return prev - current;
      case '×':
        return prev * current;
      case '÷':
        return current != 0 ? prev / current : 0;
      default:
        return current;
    }
  }

  String _formatNumber(double number) {
    if (number == number.toInt()) {
      return number.toInt().toString();
    } else {
      return number.toString();
    }
  }

  Widget _buildDateTimeSection() {
    final now = DateTime.now();
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dateFormat.format(now),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Text(
            timeFormat.format(now).toUpperCase(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}