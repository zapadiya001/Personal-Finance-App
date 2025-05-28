import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/light_theme.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  DateTime selectedDate = DateTime.now();

  // Sample data - you can replace this with your actual data source
  double monthlyExpense = 0.00;
  double monthlyIncome = 0.00;
  double monthlyTotal = 0.00;
  List<Transaction> transactions = []; // Empty for now

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: Column(
        children: [
          // Date Navigation Section
          _buildDateNavigation(),

          // Financial Summary Section
          _buildFinancialSummary(),

          // Transaction List or Empty State
          Expanded(
            child: _buildTransactionContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Month Button
          GestureDetector(
            onTap: _goToPreviousMonth,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

          // Current Month Display
          Text(
            DateFormat('MMM, yyyy').format(selectedDate),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          // Next Month Button
          GestureDetector(
            onTap: _goToNextMonth,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Expense Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EXPENSE',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${monthlyExpense.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.expense,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Income Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'INCOME',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${monthlyIncome.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.income,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Total Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'TOTAL',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${monthlyTotal.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: monthlyTotal >= 0 ? AppColors.income : AppColors.expense,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionContent() {
    if (transactions.isEmpty) {
      return _buildEmptyState();
    } else {
      return _buildTransactionList();
    }
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty State Icon
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade700.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.description_outlined,
              size: 48,
              color: Colors.grey.shade500,
            ),
          ),

          const SizedBox(height: 24),

          // Empty State Text
          Text(
            'No record in this month. Tap + to add new expense or income.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    // This will be implemented when you have actual transaction data
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _buildTransactionItem(transaction);
      },
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3D3D3D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Transaction Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: transaction.type == TransactionType.income
                  ? AppColors.income.withOpacity(0.2)
                  : AppColors.expense.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              transaction.type == TransactionType.income
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
              color: transaction.type == TransactionType.income
                  ? AppColors.income
                  : AppColors.expense,
              size: 16,
            ),
          ),

          const SizedBox(width: 12),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (transaction.notes.isNotEmpty)
                  Text(
                    transaction.notes,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),

          // Transaction Amount
          Text(
            '₹${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: transaction.type == TransactionType.income
                  ? AppColors.income
                  : AppColors.expense,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _goToPreviousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
      _updateFinancialData();
    });
  }

  void _goToNextMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
      _updateFinancialData();
    });
  }

  void _updateFinancialData() {
    // This method should fetch data for the selected month
    // For now, we'll keep it empty since there's no data
    // You can implement your data fetching logic here

    // Example:
    // final monthTransactions = getTransactionsForMonth(selectedDate);
    // monthlyExpense = calculateExpense(monthTransactions);
    // monthlyIncome = calculateIncome(monthTransactions);
    // monthlyTotal = monthlyIncome - monthlyExpense;
    // transactions = monthTransactions;
  }
}

// Transaction Model Classes
enum TransactionType { income, expense, transfer }

class Transaction {
  final String id;
  final double amount;
  final TransactionType type;
  final String category;
  final String account;
  final String notes;
  final DateTime date;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.account,
    required this.notes,
    required this.date,
  });
}
