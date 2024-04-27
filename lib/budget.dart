import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BudgetTrackerPage extends StatefulWidget {
  @override
  _BudgetTrackerPageState createState() => _BudgetTrackerPageState();
}

class _BudgetTrackerPageState extends State<BudgetTrackerPage> {
  final _formKey = GlobalKey<FormState>();
  double totalBudget = 0;
  double remainingBalance = 0;

  Future<void> getItineraryData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance.collection('itinerary').doc(uid).collection('budget').doc('budget');
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      setState(() {
        totalBudget = data?['totalBudget'] ?? 0.0;
        remainingBalance = data?['remainingBalance'] ?? totalBudget;
      });
    }
  }

  Future<void> setBudget(double budget) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance.collection('itinerary').doc(uid).collection('budget').doc('budget');
    await docRef.set({
      'totalBudget': budget,
      'remainingBalance': budget,
    });
  }

  Future<void> addExpense(double amount) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance.collection('itinerary').doc(uid).collection('budget').doc('budget');

    await docRef.update({
      'remainingBalance': remainingBalance - amount,
    });

    setState(() {
      remainingBalance -= amount;
    });
  }

  @override
  void initState() {
    super.initState();
    getItineraryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Total Budget',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a budget';
                  }
                  return null;
                },
                onSaved: (newValue) => totalBudget = double.parse(newValue!),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setBudget(totalBudget);
                  getItineraryData();
                }
              },
              child: Text('Set Budget'),
            ),
            SizedBox(height: 20),
            Text(
              'Total Budget: \$' + totalBudget.toStringAsFixed(2),
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Remaining Balance: \$' + remainingBalance.toStringAsFixed(2),
              style: TextStyle(fontSize: 18),
            ),
            // Add expense section (implement your UI and functionality here)
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Add Expense'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Expense Amount'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              double amount = double.parse(newValue!);
                              addExpense(amount);
                            },
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Add'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
