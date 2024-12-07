import 'package:cement_flutter/services/ClientService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var baseUrl = "http://localhost:3050/api/v2";

class CreateClientController extends ChangeNotifier {
  final ClientService _clientService = ClientService(baseUrl);

  // Loading and error handling
  bool _isLoading = false;
  String _errorMessage = '';

  // Field-specific error messages
  String nameError = '';
  String phoneError = '';
  String emailError = '';
  String cityError = '';
  String regionError = '';

  // Dropdown selections
  String _selectedCity = 'Tunis';
  String _selectedRegion = 'Ariana';

  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Getters and setters for dropdown selections
  String get selectedCity => _selectedCity;
  set selectedCity(String city) {
    _selectedCity = city;
    notifyListeners();
  }

  String get selectedRegion => _selectedRegion;
  set selectedRegion(String region) {
    _selectedRegion = region;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Set error message
  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Add Client Method
Future<void> addClient({
  required String name,
  required String phone, // Ensure 'phone' is defined here
  required String email,
  required String city,
  required String region,
  required BuildContext context,
}) async {
  // Validate fields
  _validateFields(
    name: name,
    phone: phone,
    email: email,
    city: city,
    region: region,
  );

  if (nameError.isNotEmpty ||
      phoneError.isNotEmpty ||
      emailError.isNotEmpty ||
      cityError.isNotEmpty ||
      regionError.isNotEmpty) {
    return;
  }

  _isLoading = true;
  notifyListeners();

  try {
    await _clientService.createClient({
      "name": name,
      "phone": phone, // Pass 'phone' here
      "email": email,
      "city": city,
      "region": region,
    });

    _isLoading = false;
    _clearErrors();
    notifyListeners();

    // Navigate back or show success message
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Client ajouté avec succès!')),
    );
  } catch (e) {
    _isLoading = false;
    _errorMessage = 'Échec de l\'ajout du client. Veuillez réessayer.';
    notifyListeners();

      // Navigate back or show success message
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Client ajouté avec succès!')),
      );
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Échec de l\'ajout du client. Veuillez réessayer.';
      notifyListeners();
    }
  }

  // Validation logic
  void _validateFields({
    required String name,
    required String phone,
    required String email,
    required String city,
    required String region,
  }) {
    // Name validation
    if (name.isEmpty) {
      nameError = 'Le nom ne peut pas être vide';
    } else {
      nameError = '';
    }

    // Phone validation
    if (phone.isEmpty) {
      phoneError = 'Le téléphone ne peut pas être vide';
    } else if (!RegExp(r'^\d+$').hasMatch(phone)) {
      phoneError = 'Le téléphone doit contenir uniquement des chiffres';
    } else {
      phoneError = '';
    }

    // Email validation
    if (email.isEmpty) {
      emailError = 'L\'e-mail ne peut pas être vide';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      emailError = 'Format d\'e-mail invalide';
    } else {
      emailError = '';
    }

    // City validation
    if (city.isEmpty) {
      cityError = 'La ville ne peut pas être vide';
    } else {
      cityError = '';
    }

    // Region validation
    if (region.isEmpty) {
      regionError = 'La région ne peut pas être vide';
    } else {
      regionError = '';
    }

    notifyListeners();
  }

  // Clear errors after successful addition
  void _clearErrors() {
    nameError = '';
    phoneError = '';
    emailError = '';
    cityError = '';
    regionError = '';
    _errorMessage = '';
  }

  // Dispose controllers when not needed
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
