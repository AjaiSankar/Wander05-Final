import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BudgetManagementPage extends StatefulWidget {
  final String tripId;

  const BudgetManagementPage({Key? key, required this.tripId}) : super(key: key);

  @override
  _BudgetManagementPageState createState() => _BudgetManagementPageState();
}

class _BudgetManagementPageState extends State<BudgetManagementPage> {
  late TextEditingController _budgetController;
  late TextEditingController _expenseController;

  @override
  void initState() {
    super.initState();
    _budgetController = TextEditingController();
    _expenseController = TextEditingController();
  }

  @override
  void dispose() {
    _budgetController.dispose();
    _expenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Budget',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _budgetController,
              decoration: InputDecoration(labelText: 'Enter Budget'),
            ),
            SizedBox(height: 20),
            Text(
              'Track Expenses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _expenseController,
              decoration: InputDecoration(labelText: 'Enter Expense'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Update budget in Firestore
                _updateBudget();
              },
              child: Text('Update Budget'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateBudget() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Reference to the user's trip document
      DocumentReference tripDocRef = FirebaseFirestore.instance
          .collection('itinerary')
          .doc(userId)
          .collection('trips')
          .doc(widget.tripId);

      // Update budget in Firestore
      await tripDocRef.update({
        'budget': _budgetController.text,
        'expenses': FieldValue.arrayUnion([_expenseController.text]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Budget updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update budget. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Error updating budget: $e');
    }
  }
}
