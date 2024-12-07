import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateVisitPage extends StatefulWidget {
  @override
  _CreateVisitPageState createState() => _CreateVisitPageState();
}

class _CreateVisitPageState extends State<CreateVisitPage> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDate;
  String? _selectedUser;
  String? _selectedClient;
  String? _selectedPriority;
  final List<String> _users = ['User 1', 'User 2', 'User 3']; // Replace with dynamic data
  final List<String> _clients = ['Client 1', 'Client 2', 'Client 3']; // Replace with dynamic data
  final List<String> _products = ['CEM |  42,5', 'CEM || 32,5', 'CEM | 42,5 SR-3','CHAUX'];
  List<String> _selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _daysInMonth(_currentMonth);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Create New Visit',
                  style: TextStyle(
                    fontSize: 25,
                  fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16),

                // Month and Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          _currentMonth = DateTime(
                            _currentMonth.year,
                            _currentMonth.month - 1,
                          );
                        });
                      },
                    ),
                    Text(
                      DateFormat.yMMMM().format(_currentMonth),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        setState(() {
                          _currentMonth = DateTime(
                            _currentMonth.year,
                            _currentMonth.month + 1,
                          );
                        });
                      },
                    ),
                  ],
                ),

                // Calendar Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: daysInMonth.length,
                  itemBuilder: (context, index) {
                    final day = daysInMonth[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = day;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedDate == day
                              ? Colors.red
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: _selectedDate == day
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 16),

                // Selected Date
                if (_selectedDate != null)
                  Text(
                    'Selected Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                SizedBox(height: 16),

                // User Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'User',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  value: _selectedUser,
                  items: _users
                      .map((user) => DropdownMenuItem(
                            value: user,
                            child: Text(user),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedUser = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Client Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Client',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  value: _selectedClient,
                  items: _clients
                      .map((client) => DropdownMenuItem(
                            value: client,
                            child: Text(client),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedClient = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Products Selection
                Text(
                  'Select Products',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _products.map((product) {
                    final isSelected = _selectedProducts.contains(product);
                    return FilterChip(
                      label: Text(product),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedProducts.add(product);
                          } else {
                            _selectedProducts.remove(product);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Priority Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  value: _selectedPriority,
                  items: ['High', 'Medium', 'Low']
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value;
                    });
                  },
                ),
                SizedBox(height: 24),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle submit logic
                      if (_selectedDate == null ||
                          _selectedUser == null ||
                          _selectedClient == null ||
                          _selectedProducts.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill all fields')),
                        );
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Visit created successfully!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Create Visit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper function to get all days in the current month.
  List<DateTime> _daysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(month.year, month.month, index + 1),
    );
  }
}