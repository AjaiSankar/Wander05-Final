import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BudgetTrackerPage extends StatefulWidget {
  final String tripId;

  BudgetTrackerPage({required this.tripId});

  @override
  _BudgetTrackerPageState createState() => _BudgetTrackerPageState();
}

class _BudgetTrackerPageState extends State<BudgetTrackerPage> {
  final _formKey = GlobalKey<FormState>();
  final _budgetController = TextEditingController();
  final _expenseController = TextEditingController();
  final _expenseTypeController = TextEditingController();
  double _totalBudget = 0.0;
  double _remainingPurse = 0.0;
  List<Map<String, dynamic>> _expenses = [];

  @override
  void initState() {
    super.initState();
    _createBudgetCollection();
    _fetchBudgetData();
  }

  void _createBudgetCollection() {
    FirebaseFirestore.instance
        .collection('itinerary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('plans')
        .doc(widget.tripId)
        .collection('budget')
        .get()
        .then((snapshot) {
      if (snapshot.docs.isEmpty) {
        _createBudgetDocument();
      } else {
        _fetchBudgetData();
      }
    });
  }

  void _createBudgetDocument() {
    FirebaseFirestore.instance
        .collection('itinerary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('plans')
        .doc(widget.tripId)
        .collection('budget')
        .doc('budget')
        .set({
      'remaining':0.0,
      'totalBudget': 0.0,
      'expenses': [],
    });
  }



void _fetchBudgetData() {
  FirebaseFirestore.instance
      .collection('itinerary')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('plans')
      .doc(widget.tripId)
      .collection('budget')
      .doc('budget')
      .snapshots()
      .listen((snapshot) {
    if (snapshot.exists) {
      setState(() {
        _totalBudget = snapshot.data()?['totalBudget'] ?? 0.0;
        _remainingPurse = snapshot.data()?['remainingPurse'] ?? _totalBudget;
        _expenses = List<Map<String, dynamic>>.from(snapshot.data()?['expenses'] ?? []); //food: 500
      });
    }
  });
}



  void _saveBudget() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _totalBudget = double.parse(_budgetController.text);
      _saveBudgetDocument();
    }
  }

 void _saveBudgetDocument() {
  FirebaseFirestore.instance
      .collection('itinerary')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('plans')
      .doc(widget.tripId)
      .collection('budget')
      .doc('budget')
      .update({
    'totalBudget': _totalBudget,
    'remainingPurse': _totalBudget,
  });
}

void _addExpense() {
  final expense = double.parse(_expenseController.text);
  final expenseType = _expenseTypeController.text.trim();

  if (expense > 0 && expenseType.isNotEmpty) {
    setState(() {
      _remainingPurse -= expense;
      _expenses.add({
        'amount': expense,
        'type': expenseType,
      });
    });
    _expenseController.clear();
    _expenseTypeController.clear();
    _saveExpenseDocument();
  }
}


void _saveExpenseDocument() {
  FirebaseFirestore.instance
      .collection('itinerary')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('plans')
      .doc(widget.tripId)
      .collection('budget')
      .doc('budget')
      .update({
    'expenses': FieldValue.arrayUnion([
      {
        'amount': _expenses.last['amount'], //500
        'type': _expenses.last['type'],//food
      },
    ]),
    'remainingPurse': _remainingPurse,
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Budget Tracker'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBudgetBox(),
          SizedBox(height: 16.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _budgetController,
                  decoration: InputDecoration(
                    labelText: 'Enter Total Budget',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the total budget';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _saveBudget,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 3.0,
                  ),
                  child: Text(
                    'Save Budget',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Divider(
            color: Colors.grey.shade300,
            thickness: 3.0,
          ),
          SizedBox(height: 16.0),
          _buildExpenseInput(),
          SizedBox(height: 16.0),
          Expanded(
            child: _buildExpenseList(),
          ),
        ],
      ),
    ),
  );
}


Widget _buildBudgetBox() {
  return Container(
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.symmetric(horizontal: 20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Color.fromARGB(255, 112, 123, 195)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 4.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet, color: Colors.white, size: 32.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Total Budget: ₹ $_totalBudget',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.attach_money, color: Colors.white, size: 32.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Remaining Purse: ₹ $_remainingPurse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
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



  Widget _buildExpenseInput() {
  return Row(
    children: [
      Expanded(
        child: TextFormField(
          controller: _expenseController,
          decoration: InputDecoration(
            labelText: 'Amount',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      SizedBox(width: 16.0),
      Expanded(
        child: TextFormField(
          controller: _expenseTypeController,
          decoration: InputDecoration(
            labelText: 'Type',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      SizedBox(width: 16.0),
      ElevatedButton(
        onPressed: _addExpense,
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 3.0,
        ),
        child: Text(
          'Add Expense',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}



Widget _buildExpenseList() {
  return ListView.separated(
    itemCount: _expenses.length,
    separatorBuilder: (context, index) => Divider(
      color: Colors.grey.shade300,
      thickness: 1.0,
    ),
    itemBuilder: (context, index) {
      final expense = _expenses[index];
      IconData iconData = Icons.attach_money; // Default icon

      // Map expense types to corresponding icons
      switch (expense['type']) {
        case 'Shop':
          iconData = Icons.shopping_cart;
          break;
        case 'Transportation':
          iconData = Icons.directions_car;
          break;
        case 'Petrol':
          iconData = Icons.directions_car;
          break;
        case 'Food':
          iconData = Icons.restaurant;
          break;
        case 'food':
          iconData = Icons.restaurant;
          break;
        // Add more cases for other expense types
      }

      return Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                  color: Colors.blue,
                  size: 24.0,
                ),
                SizedBox(width: 12.0),
                Text(
                  '${expense['type']}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              '₹ ${expense['amount']}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    },
  );
}
}