import 'package:cement_flutter/screens/profile/components/SignoutModal.dart';
import 'package:cement_flutter/screens/profile/settings/SettingsScreen.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isAboutSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // User Information Section
              Container(
                width: 335,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x21BEBEBE),
                      blurRadius: 9,
                      offset: Offset(3, 3),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Habib Bibani',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (isAboutSelected)
                            ...[
                              _userInfoText('Email', 'habib@gmail.com'),
                              _userInfoText('Date of Birth', 'December 07, 2020'),
                              _userInfoText('Address', 'Tunis, Soukra'),
                            ]
                          else
                            ...[
                              _userInfoText('Type', 'Controleur'),
                              _userInfoText('Joined', 'Sep 2018'),
                              _userInfoText('Experience', '4 Years'),
                            ],
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        'https://via.placeholder.com/80',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Tabs: About and Work
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAboutSelected = true;
                      });
                    },
                    child: _tabButton('ABOUT', isAboutSelected),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAboutSelected = false;
                      });
                    },
                    child: _tabButton('WORK', !isAboutSelected),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // About Content
              if (isAboutSelected)
                Column(
                  children: [
                    _infoCard(
                      title: 'BIO',
                      content:
                          'Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit. '
                          'Tortor Turpis Sodales Nulla Velit. Nunc Cum Vitae, Rhoncus '
                          'Leo Id. Volutpat Duis Tinunt Pretium Luctus Pulvinar Pretium.',
                    ),
                    SizedBox(height: 16),
                    _infoCard(
                      title: 'PHONE',
                      content: '98987987',
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _showSignOutModal(context);
                      },
                      style: ElevatedButton.styleFrom(
                        overlayColor: Colors.transparent,
                        elevation: 0,
                        side: BorderSide(color: Colors.red, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ],
                )
              else
                _workContent(),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SignOutDialog(
            onCancel: () => Navigator.pop(context),
            onConfirm: () {
              Navigator.pop(context);
              // Perform sign-out logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Déconnecté avec succès!')),
              );
            },
          ),
        );
      },
    );
  }

  Widget _userInfoText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String text, bool isSelected) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.red : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 2,
            width: 40,
            color: Colors.red,
          ),
      ],
    );
  }

  Widget _workContent() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _statisticCard('17', 'Visites effectuées'),
        _statisticCard('92%', 'Taux de réussite'),
        _statisticCard('5', 'Équipes'),
        _statisticCard('243', 'Rapports client'),
      ],
    );
  }

  Widget _infoCard({required String title, required String content}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statisticCard(String value, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
