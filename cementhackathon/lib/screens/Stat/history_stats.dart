import 'package:cement_flutter/components/SideBar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HistoryStats()));
}

class HistoryStats extends StatefulWidget {
  @override
  _HistoryStatsState createState() => _HistoryStatsState();
}

class _HistoryStatsState extends State<HistoryStats> {
  // Store the selected filter here
  String selectedFilter = 'This Week';

  final Map<String, List<Map<String, dynamic>>> filterData = {
    'This Week': [
      {'value': 20.0, 'label': 'Mon'},
      {'value': 15.5, 'label': 'Tue'},
      {'value': 18.2, 'label': 'Wed'},
      {'value': 22.3, 'label': 'Thu'},
      {'value': 10.7, 'label': 'Fri'},
      {'value': 25.0, 'label': 'Sat'},
      {'value': 30.0, 'label': 'Sun'},
    ],
    'Last Week': [
      {'value': 18.5, 'label': 'Mon'},
      {'value': 17.0, 'label': 'Tue'},
      {'value': 19.2, 'label': 'Wed'},
      {'value': 23.0, 'label': 'Thu'},
      {'value': 11.5, 'label': 'Fri'},
      {'value': 24.0, 'label': 'Sat'},
      {'value': 28.0, 'label': 'Sun'},
    ],
    'Last Month': [
      {'value': 120.0, 'label': 'Week 1'},
      {'value': 150.5, 'label': 'Week 2'},
      {'value': 180.2, 'label': 'Week 3'},
      {'value': 200.3, 'label': 'Week 4'},
    ],
    'Last Year': [
      {'value': 1000.0, 'label': 'Q1'},
      {'value': 1200.5, 'label': 'Q2'},
      {'value': 1100.2, 'label': 'Q3'},
      {'value': 1300.3, 'label': 'Q4'},
    ],
    'This Year': [
      {'value': 1000.0, 'label': 'Q1'},
      {'value': 1200.5, 'label': 'Q2'},
      {'value': 1100.2, 'label': 'Q3'},
      {'value': 1300.3, 'label': 'Q4'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Get the appropriate data based on selected filter
    List<Map<String, dynamic>> data = filterData[selectedFilter]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('History Statistics',
            style: TextStyle(fontSize: 24)), // Titre de l'application
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width *
            0.6, // Largeur de la barre latérale (60% de la largeur de l'écran)
        child: const Sidebar(
            avatarUrl: 'assets/images/logo.png',
            cityName: 'Tunis',
            userName: 'Habib'),
      ),
      body: Container(
        width: 414,
        height: 826,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              //const Header(),
              const SizedBox(height: 20),
              TimeFilter(
                selectedFilter: selectedFilter,
                onFilterChanged: (newFilter) {
                  setState(() {
                    selectedFilter = newFilter;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Dynamically change the text based on the selected filter
              Text(selectedFilter, style: TextStyle(fontSize: 18)),
              BarChart(data: data),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back, size: 24, color: Color(0xFF303840)),
        ),
        const Text(
          'Statistics',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF303840),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFFDEE6EE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.notifications, color: Color(0xFF303840)),
        ),
      ],
    );
  }
}

class TimeFilter extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const TimeFilter({
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> filters = [
      'This Week',
      'Last Week',
      'Last Month',
      'Last Year',
      'This Year',
    ];

    return Container(
      height: 36,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            return GestureDetector(
              onTap: () {
                onFilterChanged(
                    filter); // Call the callback when a filter is selected
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TimeFilterButton(
                  label: filter,
                  isActive: selectedFilter == filter,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TimeFilterButton extends StatelessWidget {
  final String label;
  final bool isActive;

  const TimeFilterButton({
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      height: 36,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF94C3F6) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isActive
            ? null
            : [BoxShadow(color: Color(0x0A000000), blurRadius: 48)],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isActive ? Colors.white : Color(0xFF7C8894),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const BarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 263,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 48,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: data.map((entry) {
          return Bar(
            value: entry['value'] as double,
            label: entry['label'] as String,
            data: data,
          );
        }).toList(),
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final double value;
  final String label;
  final List<Map<String, dynamic>> data;

  const Bar({
    required this.value,
    required this.label,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final double maxHeight = 175;
    double maxValue =
        data.map((e) => e['value'] as double).reduce((a, b) => a > b ? a : b);
    final double barHeight = (value / maxValue) * maxHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(
            color: Color(0xFF303840),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 24,
              height: maxHeight,
              decoration: BoxDecoration(
                color: Color(0xFFECEEEF),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Container(
              width: 24,
              height: barHeight,
              decoration: BoxDecoration(
                color: Color(0xFFD42027),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7C8894),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
