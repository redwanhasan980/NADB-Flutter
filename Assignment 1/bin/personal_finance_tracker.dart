import 'dart:io';

void main() {
  print('Personal Finance Tracker');
  print('');

  final income = readRequiredAmount('Enter your monthly income: ');

  final expenses = <String, double>{
    'food': readOptionalAmount('Enter food expense: ') ?? 0,
    'rent': readOptionalAmount('Enter rent expense: ') ?? 0,
    'transport': readOptionalAmount('Enter transport expense: ') ?? 0,
  };

  final totalExpenses = calculateTotalExpenses(expenses);
  final remainingBalance = income - totalExpenses;
  final savingsPercentage = calculateSavingsPercentage(
    income,
    remainingBalance,
  );

  printSummary(
    income: income,
    expenses: expenses,
    totalExpenses: totalExpenses,
    remainingBalance: remainingBalance,
    savingsPercentage: savingsPercentage,
  );
}

double readRequiredAmount(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync();
    final amount = double.tryParse(input ?? '');

    if (amount != null && amount >= 0) {
      return amount;
    }

    print('Please enter a valid amount.');
  }
}

double? readOptionalAmount(String prompt) {
  stdout.write(prompt);
  final input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    return null;
  }

  return double.tryParse(input);
}

double calculateTotalExpenses(Map<String, double> expenses) {
  return expenses.values.fold(0, (total, amount) => total + amount);
}

double calculateSavingsPercentage(double income, double remainingBalance) {
  if (income == 0) {
    return 0;
  }

  return (remainingBalance / income) * 100;
}

void printSummary({
  required double income,
  required Map<String, double> expenses,
  required double totalExpenses,
  required double remainingBalance,
  required double savingsPercentage,
}) {
  print('');
  print('========== Finance Summary ==========');
  print('Income: \$${income.toStringAsFixed(2)}');
  print('');
  print('Expenses:');

  expenses.forEach((category, amount) {
    print('${formatCategory(category)}: \$${amount.toStringAsFixed(2)}');
  });

  print('');
  print('Total Expenses: \$${totalExpenses.toStringAsFixed(2)}');
  print('Remaining Balance: \$${remainingBalance.toStringAsFixed(2)}');
  print('Savings Percentage: ${savingsPercentage.toStringAsFixed(2)}%');
  print('=====================================');
}

String formatCategory(String category) {
  return '${category[0].toUpperCase()}${category.substring(1)}';
}
