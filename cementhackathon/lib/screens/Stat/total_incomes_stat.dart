import 'package:cement_flutter/components/SideBar.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics',
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
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Uniform padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Top spacing
            HeaderSection(),
            const SizedBox(height: 16), // Spacing between header and filter
            FilterSection(),
            const SizedBox(
                height: 32), // Spacing between filter and total income
            Center(
              child: TotalIncomeWidget(),
            ),
            const SizedBox(
                height: 32), // Spacing between income widget and cards
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2, // Adjusted ratio to prevent overflow
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final cardData = [
                    {
                      "title": "Tunis",
                      "value": "1,400",
                      "description":
                          "Mauris hendrerit mollis bibendum quisque.",
                      "color": const Color(0xFF94C3F6),
                    },
                    {
                      "title": "Marsa",
                      "value": "2,700 tons",
                      "description":
                          "Ut pulvinar arcu lacus a sit amet posuere.",
                      "color": const Color(0xFF50C474),
                    },
                    {
                      "title": "Bizerte",
                      "value": "500",
                      "description":
                          "Maecenas quis purus at metus posuere dapib.",
                      "color": const Color(0xFF94EDF7),
                    },
                    {
                      "title": "Sfax",
                      "value": "2,100",
                      "description":
                          "Proin sagittis imperdiet egestas aenean maxi.",
                      "color": const Color(0xFF559BE6),
                    },
                  ];
                  return InfoCard(
                    title: cardData[index]["title"] as String,
                    value: cardData[index]["value"] as String,
                    description: cardData[index]["description"] as String,
                    indicatorColor: cardData[index]["color"] as Color,
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

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context); // Go back to the previous screen
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Color(0xFF303840),
          ),
        ),
        const Text(
          'Statistics',
          style: TextStyle(
            color: Color(0xFF303840),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFDEE6EE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.notifications, color: Color(0xFF303840)),
        ),
      ],
    );
  }
}

class FilterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Monthly',
            style: TextStyle(
              color: Color(0xFF7C8894),
              fontSize: 14,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF7C8894),
          ),
        ],
      ),
    );
  }
}

class TotalIncomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      height: 270,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(270, 270),
            painter: CircularSegmentPainter(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Total Income',
                style: TextStyle(
                  color: Color(0xFF7C8894),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '6,000',
                style: TextStyle(
                  color: Color(0xFF303840),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircularSegmentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 20;
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Create Paint for the segments
    final Paint segmentPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Segments colors
    final List<Color> colors = [
      Color.fromARGB(255, 171, 201, 248),
      Color.fromARGB(255, 36, 111, 191),
      Color.fromARGB(255, 114, 201, 255),
      Color(0xFF50C474),
    ];

    // Angles for each segment
    final List<double> angles = [90, 90, 90, 90]; // Each segment is 90 degrees

    double startAngle = -90; // Start at the top
    for (int i = 0; i < colors.length; i++) {
      segmentPaint.color = colors[i];
      canvas.drawArc(
        rect.deflate(strokeWidth / 2), // Adjust for stroke width
        radians(startAngle),
        radians(angles[i]),
        false,
        segmentPaint,
      );
      startAngle += angles[i];
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  double radians(double degrees) => degrees * (3.141592653589793 / 180);
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String description;
  final Color indicatorColor;

  const InfoCard({
    required this.title,
    required this.value,
    required this.description,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: indicatorColor,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF303840),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: indicatorColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFF7C8894),
                fontSize: 12,
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
