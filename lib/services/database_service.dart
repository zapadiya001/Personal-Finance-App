import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/account.dart';
import '../models/income.dart';
import '../models/income_category.dart';
import '../models/purchase.dart';
import '../models/purchase_category.dart';
import '../models/transfer.dart';
import '../models/transaction_log.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  static Database? _db;
  DatabaseService._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'finance_app.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE income_categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE purchase_categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE incomes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        account_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        note TEXT,
        FOREIGN KEY (account_id) REFERENCES accounts(id),
        FOREIGN KEY (category_id) REFERENCES income_categories(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE purchases (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        account_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        note TEXT,
        FOREIGN KEY (account_id) REFERENCES accounts(id),
        FOREIGN KEY (category_id) REFERENCES purchase_categories(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE transfers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        from_account_id INTEGER NOT NULL,
        to_account_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        note TEXT,
        FOREIGN KEY (from_account_id) REFERENCES accounts(id),
        FOREIGN KEY (to_account_id) REFERENCES accounts(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE transaction_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        related_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        description TEXT
      );
    ''');
  }

  // ---------------- Accounts ----------------
  Future<int> insertAccount(Account account) async {
    final db = await database;
    return await db.insert('accounts', account.toMap());
  }

  Future<List<Account>> getAccounts() async {
    final db = await database;
    final result = await db.query('accounts');
    return result.map((map) => Account.fromMap(map)).toList();
  }

  // ---------------- Income Categories ----------------
  Future<int> insertIncomeCategory(IncomeCategory category) async {
    final db = await database;
    return await db.insert('income_categories', category.toMap());
  }

  Future<List<IncomeCategory>> getIncomeCategories() async {
    final db = await database;
    final result = await db.query('income_categories');
    return result.map((map) => IncomeCategory.fromMap(map)).toList();
  }

  // ---------------- Purchase Categories ----------------
  Future<int> insertPurchaseCategory(PurchaseCategory category) async {
    final db = await database;
    return await db.insert('purchase_categories', category.toMap());
  }

  Future<List<PurchaseCategory>> getPurchaseCategories() async {
    final db = await database;
    final result = await db.query('purchase_categories');
    return result.map((map) => PurchaseCategory.fromMap(map)).toList();
  }

  // ---------------- Incomes ----------------
  Future<int> insertIncome(Income income) async {
    final db = await database;
    final id = await db.insert('incomes', income.toMap());
    await insertTransactionLog(TransactionLog(
      type: 'income',
      relatedId: id,
      date: income.date,
      description: 'Income added: ${income.amount}',
    ));
    return id;
  }

  Future<List<Income>> getIncomes() async {
    final db = await database;
    final result = await db.query('incomes');
    return result.map((map) => Income.fromMap(map)).toList();
  }

  // ---------------- Purchases ----------------
  Future<int> insertPurchase(Purchase purchase) async {
    final db = await database;
    final id = await db.insert('purchases', purchase.toMap());
    await insertTransactionLog(TransactionLog(
      type: 'purchase',
      relatedId: id,
      date: purchase.date,
      description: 'Purchase: ${purchase.amount}',
    ));
    return id;
  }

  Future<List<Purchase>> getPurchases() async {
    final db = await database;
    final result = await db.query('purchases');
    return result.map((map) => Purchase.fromMap(map)).toList();
  }

  // ---------------- Transfers ----------------
  Future<int> insertTransfer(Transfer transfer) async {
    final db = await database;
    final id = await db.insert('transfers', transfer.toMap());
    await insertTransactionLog(TransactionLog(
      type: 'transfer',
      relatedId: id,
      date: transfer.date,
      description: 'Transferred ${transfer.amount} from account ${transfer.fromAccountId} to ${transfer.toAccountId}',
    ));
    return id;
  }

  Future<List<Transfer>> getTransfers() async {
    final db = await database;
    final result = await db.query('transfers');
    return result.map((map) => Transfer.fromMap(map)).toList();
  }

  // ---------------- Transaction Logs ----------------
  Future<int> insertTransactionLog(TransactionLog log) async {
    final db = await database;
    return await db.insert('transaction_logs', log.toMap());
  }

  Future<List<TransactionLog>> getTransactionLogs() async {
    final db = await database;
    final result = await db.query('transaction_logs', orderBy: 'date DESC');
    return result.map((map) => TransactionLog.fromMap(map)).toList();
  }

  // ---------------- Utilities ----------------
  Future<void> deleteAllData() async {
    final db = await database;
    await db.delete('incomes');
    await db.delete('purchases');
    await db.delete('transfers');
    await db.delete('transaction_logs');
    await db.delete('accounts');
    await db.delete('income_categories');
    await db.delete('purchase_categories');
  }
}
