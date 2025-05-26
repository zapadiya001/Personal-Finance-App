import 'package:flutter/material.dart';
import 'services/database_service.dart';
import 'models/account.dart';
import 'models/income_category.dart';
import 'models/purchase_category.dart';
import 'models/income.dart';
import 'models/purchase.dart';
import 'models/transfer.dart';
import 'models/transaction_log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before DB use

  final db = DatabaseService();

  print('--- Inserting Sample Data ---');

  // Insert accounts
  final cashAccountId = await db.insertAccount(Account(name: 'Cash'));
  final bankAccountId = await db.insertAccount(Account(name: 'Savings Account'));

  // Insert income category
  final salaryCatId = await db.insertIncomeCategory(IncomeCategory(name: 'Salary'));
  final bonusCatId = await db.insertIncomeCategory(IncomeCategory(name: 'Bonus'));

  // Insert purchase category
  final foodCatId = await db.insertPurchaseCategory(PurchaseCategory(name: 'Food'));
  final billsCatId = await db.insertPurchaseCategory(PurchaseCategory(name: 'Utilities'));

  // Insert income
  await db.insertIncome(Income(
    amount: 3000.0,
    date: '2025-05-26',
    accountId: cashAccountId,
    categoryId: salaryCatId,
    note: 'May Salary',
  ));

  await db.insertIncome(Income(
    amount: 500.0,
    date: '2025-05-26',
    accountId: bankAccountId,
    categoryId: bonusCatId,
    note: 'Project bonus',
  ));

  // Insert purchase
  await db.insertPurchase(Purchase(
    amount: 100.0,
    date: '2025-05-26',
    accountId: cashAccountId,
    categoryId: foodCatId,
    note: 'Groceries',
  ));

  await db.insertPurchase(Purchase(
    amount: 150.0,
    date: '2025-05-26',
    accountId: bankAccountId,
    categoryId: billsCatId,
    note: 'Electricity bill',
  ));

  // Insert transfer
  await db.insertTransfer(Transfer(
    fromAccountId: cashAccountId,
    toAccountId: bankAccountId,
    amount: 200.0,
    date: '2025-05-26',
    note: 'Move to savings',
  ));

  print('\n--- Fetching and Printing Data ---');

  final accounts = await db.getAccounts();
  print('\nAccounts:');
  for (var acc in accounts) {
    print('${acc.id}: ${acc.name}');
  }

  final incomes = await db.getIncomes();
  print('\nIncomes:');
  for (var income in incomes) {
    print('${income.id}: \$${income.amount}, Account: ${income.accountId}, Category: ${income.categoryId}, Note: ${income.note}');
  }

  final purchases = await db.getPurchases();
  print('\nPurchases:');
  for (var purchase in purchases) {
    print('${purchase.id}: \$${purchase.amount}, Account: ${purchase.accountId}, Category: ${purchase.categoryId}, Note: ${purchase.note}');
  }

  final transfers = await db.getTransfers();
  print('\nTransfers:');
  for (var transfer in transfers) {
    print('${transfer.id}: \$${transfer.amount}, From: ${transfer.fromAccountId}, To: ${transfer.toAccountId}, Note: ${transfer.note}');
  }

  final logs = await db.getTransactionLogs();
  print('\nTransaction Logs:');
  for (var log in logs) {
    print('${log.id}: [${log.type}] ID: ${log.relatedId} - ${log.description}');
  }
}
