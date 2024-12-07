import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cement_flutter/controllers/ClientController.dart';
import 'package:cement_flutter/components/SideBar.dart';

class CreateClientPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Access the controller
    final controller =
        Provider.of<CreateClientController>(context, listen: true);

    // Validation for email and phone
    String? _validatePhone(String? value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer un numéro de téléphone';
      }
      // You can add more specific phone validation logic here
      return null;
    }

    String? _validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer un email';
      }
      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
        return 'Veuillez entrer un email valide';
      }
      return null;
    }

    Widget buildTextField({
      required String label,
      required TextEditingController textController,
      String? errorText,
      bool isEmail = false,
      bool isPhone = false,
      String? Function(String?)? validator,
    }) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        width: screenWidth * 0.85,
        child: TextFormField(
          controller: textController,
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : isPhone
                  ? TextInputType.phone
                  : TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFBFBFB),
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            errorText: errorText,
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
          validator: validator,
        ),
      );
    }

    Widget buildDropdown({
      required String label,
      required String value,
      required List<String> items,
      required Function(String?) onChanged,
      String? errorText,
    }) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        width: screenWidth * 0.85,
        child: DropdownButtonFormField<String>(
          value: items.contains(value)
              ? value
              : null, // Ensure value exists in items
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFBFBFB),
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            errorText: errorText,
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    final cities = ['Tunis', 'Sfax', 'Sousse', 'Nabeul', 'Bizerte'];
    final regions = [
      'Ariana', 'Béja', 'Ben Arous', 'Bizerte', 'Gabès', 'Gafsa', 'Jendouba', 
      'Kairouan', 'Kasserine', 'Kébili', 'Le Kef', 'Mahdia', 'La Manouba', 
      'Médenine', 'Monastir', 'Nabeul', 'Sfax', 'Sidi Bouzid', 'Siliana', 'Sousse',
      'Tataouine', 'Tozeur', 'Tunis', 'Zaghouan'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un nouveau client'),
        backgroundColor: Colors.red,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6, // Sidebar width
        child: Sidebar(
          avatarUrl: 'assets/images/logo.png',
          cityName: 'Tunis',
          userName: 'Habib',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Créer un nouveau client',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.06,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField(
                  label: 'Nom',
                  textController: controller.nameController,
                  errorText: controller.nameError,
                ),
                buildTextField(
                  label: 'Téléphone',
                  textController: controller.phoneController,
                  errorText: controller.phoneError,
                  isPhone: true,
                  validator: _validatePhone,
                ),
                buildTextField(
                  label: 'Email',
                  textController: controller.emailController,
                  errorText: controller.emailError,
                  isEmail: true,
                  validator: _validateEmail,
                ),
                buildDropdown(
                  label: 'Ville',
                  value: controller.selectedCity,
                  items: cities,
                  onChanged: (value) {
                    controller.selectedCity = value ?? '';
                  },
                  errorText: controller.cityError,
                ),
                buildDropdown(
                  label: 'Région',
                  value: controller.selectedRegion,
                  items: regions,
                  onChanged: (value) {
                    controller.selectedRegion = value ?? '';
                  },
                  errorText: controller.regionError,
                ),

                const SizedBox(height: 30),
                Center(
                  child: controller.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEC1C24), // Red color for button background
                            foregroundColor: Colors.white, // White color for text
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Slightly round corners for better look
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14), // More padding for a larger button
                            fixedSize: Size(screenWidth * 0.7, 50), // Adjusted size for better alignment
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              controller.addClient(
                                name: controller.nameController.text,
                                phone: controller.phoneController.text,
                                email: controller.emailController.text,
                                city: controller.selectedCity,
                                region: controller.selectedRegion,
                                context: context,
                              );
                            }
                          },
                          child: const Text(
                            'Ajouter Client',
                            style: TextStyle(
                              fontSize: 18, // Larger text for better visibility
                              fontFamily: 'Roboto', // Different font for better aesthetics
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
