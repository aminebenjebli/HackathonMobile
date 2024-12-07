import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateVisitController extends ChangeNotifier {
  // Current month and selected date
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDate;

  // Form field controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  // Priority dropdown value
  String? _selectedPriority;

  // Getter for current month
  DateTime get currentMonth => _currentMonth;

  // Getter and setter for selected date
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  // Getter and setter for priority
  String? get selectedPriority => _selectedPriority;
  set selectedPriority(String? priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  // Increment or decrement month
  void changeMonth(bool isNext) {
    _currentMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + (isNext ? 1 : -1),
    );
    notifyListeners();
  }

  // Get days in the current month
  List<DateTime> getDaysInMonth() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(_currentMonth.year, _currentMonth.month, index + 1),
    );
  }

  // Reset all fields
  void resetFields() {
    _selectedDate = null;
    nameController.clear();
    descriptionController.clear();
    startTimeController.clear();
    endTimeController.clear();
    _selectedPriority = null;
    notifyListeners();
  }

  // Validate inputs and submit task
  void createVisit(BuildContext context) {
    if (_selectedDate == null) {
      _showSnackbar(context, 'Please select a date.');
      return;
    }
    if (nameController.text.isEmpty) {
      _showSnackbar(context, 'Please enter a name.');
      return;
    }
    if (descriptionController.text.isEmpty) {
      _showSnackbar(context, 'Please enter a description.');
      return;
    }
    if (startTimeController.text.isEmpty || endTimeController.text.isEmpty) {
      _showSnackbar(context, 'Please enter start and end times.');
      return;
    }
    if (_selectedPriority == null) {
      _showSnackbar(context, 'Please select a priority.');
      return;
    }

    // Simulate task creation
    _showSnackbar(context, 'Visit created successfully!');
    resetFields();
  }

  // Show a snackbar with a message
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Dispose controllers when no longer needed
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }
}
