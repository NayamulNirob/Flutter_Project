import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Transaction.dart';
import 'package:merchandise_management_system/services/TransactionService.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TransactionService _transactionService = TransactionService();
  List<Transaction> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      List<Transaction> transactions = await _transactionService.fetchTransactions();
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load transactions: $e')),
      );
    }
  }

  void _openTransactionForm({Transaction? transaction}) {
    showDialog(
      context: context,
      builder: (context) => TransactionForm(
        transaction: transaction,
        onSave: (Transaction updatedTransaction) async {
          if (transaction == null) {
            await _transactionService.createTransaction(updatedTransaction);
          } else {
            await _transactionService.updateTransaction(transaction.id!, updatedTransaction);
          }
          Navigator.of(context).pop();
          _loadTransactions();
        },
      ),
    );
  }

  Future<void> _deleteTransaction(int id) async {
    await _transactionService.deleteTransaction(id);
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionForm(),
            tooltip: 'Add Transaction',
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: TransactionPieChart(transactions: _transactions),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  return MouseRegion(
                    onEnter: (event) => setState(() {}),
                    onExit: (event) => setState(() {}),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          transaction.description ?? 'No description',
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'Amount: \$${transaction.amount} | Date: ${transaction.date?.toLocal()}',
                          style: GoogleFonts.roboto(color: Colors.grey[600]),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _openTransactionForm(transaction: transaction),
                              tooltip: 'Edit',
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTransaction(transaction.id!),
                              tooltip: 'Delete',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionForm extends StatefulWidget {
  final Transaction? transaction;
  final Function(Transaction) onSave;

  const TransactionForm({super.key, this.transaction, required this.onSave});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.transaction?.description);
    _amountController = TextEditingController(text: widget.transaction?.amount?.toString());
    _selectedDate = widget.transaction?.date;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.transaction == null ? 'Add Transaction' : 'Edit Transaction',
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Enter a description' : null,
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (value) =>
                value!.isEmpty || int.tryParse(value) == null ? 'Enter a valid amount' : null,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(_selectedDate == null
                      ? 'Select Date'
                      : 'Date: ${_selectedDate!.toLocal()}'),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Transaction transaction = Transaction(
                id: widget.transaction?.id,
                description: _descriptionController.text,
                amount: int.parse(_amountController.text),
                date: _selectedDate,
              );
              widget.onSave(transaction);
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class TransactionPieChart extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionPieChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(
        text: 'Transactions Overview',
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: <CircularSeries>[
        PieSeries<Transaction, String>(
          dataSource: transactions,
          xValueMapper: (Transaction tx, _) => tx.description ?? 'Unknown',
          yValueMapper: (Transaction tx, _) => tx.amount,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
