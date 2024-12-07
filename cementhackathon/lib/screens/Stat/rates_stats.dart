import 'package:cement_flutter/components/SideBar.dart';
import 'package:flutter/material.dart';

class RateStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rates Staistics',
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
        decoration: ShapeDecoration(
          color: Color(0xFFFAFAFA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Header(),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'July 2024',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF303840),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              IncomeSummary(incomes: [8500.0, 3200.0]), // Static income values
              const SizedBox(height: 20),
              IncomeRate(
                  currentIncome: 8500.0, maxRate: 27000.0), // Static rates
              const SizedBox(height: 20),
              TotalSuccessChart(
                incomePoints: [8, 10, 6, 9, 11], // Static data points
                expensePoints: [4, 7, 5, 6, 8], // Static data points
              ),
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

class IncomeSummary extends StatelessWidget {
  final List<double> incomes;

  const IncomeSummary({required this.incomes});

  @override
  Widget build(BuildContext context) {
    final double totalIncome = incomes.reduce((a, b) => a + b);
    final double expense = incomes.length > 1 ? incomes[1] : 0.0;
    final double total = totalIncome - expense;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${totalIncome.toStringAsFixed(1)}',
              style: const TextStyle(
                color: Color(0xFF303840),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'revenue',
              style: TextStyle(
                color: Color(0xFF7C8894),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${expense.toStringAsFixed(1)}',
              style: const TextStyle(
                color: Color(0xFF303840),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'depense',
              style: TextStyle(
                color: Color(0xFF7C8894),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${total.toStringAsFixed(1)}',
              style: const TextStyle(
                color: Color(0xFF94F6AF),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Total',
              style: TextStyle(
                color: Color(0xFF7C8894),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class IncomeRate extends StatelessWidget {
  final double currentIncome;
  final double maxRate;

  const IncomeRate({required this.currentIncome, required this.maxRate});

  @override
  Widget build(BuildContext context) {
    final double progressWidth =
        (currentIncome / maxRate) * 386; // Adjust dynamically

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Income Rate',
          style: TextStyle(
            color: Color(0xFF303840),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              width: 386,
              height: 16,
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              width: progressWidth.clamp(0.0, 386.0),
              height: 16,
              decoration: BoxDecoration(
                color: Color(0xFFD42027),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('0', style: TextStyle(color: Color(0xFF7C8894), fontSize: 12)),
            Text('10k',
                style: TextStyle(color: Color(0xFF7C8894), fontSize: 12)),
            Text('27k',
                style: TextStyle(color: Color(0xFF7C8894), fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

class TotalSuccessChart extends StatelessWidget {
  final List<double> incomePoints;
  final List<double> expensePoints;

  const TotalSuccessChart(
      {required this.incomePoints, required this.expensePoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 326,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 48,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: LineChartPainter(
          incomePoints: incomePoints,
          expensePoints: expensePoints,
        ),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> incomePoints;
  final List<double> expensePoints;

  LineChartPainter({required this.incomePoints, required this.expensePoints});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint incomePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint expensePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Path incomePath = Path();
    final Path expensePath = Path();

    final double stepX = size.width / (incomePoints.length - 1);
    final double maxY = 12;

    for (int i = 0; i < incomePoints.length; i++) {
      final double x = stepX * i;
      final double incomeY =
          size.height - (incomePoints[i] / maxY) * size.height;
      final double expenseY =
          size.height - (expensePoints[i] / maxY) * size.height;

      if (i == 0) {
        incomePath.moveTo(x, incomeY);
        expensePath.moveTo(x, expenseY);
      } else {
        incomePath.lineTo(x, incomeY);
        expensePath.lineTo(x, expenseY);
      }
    }

    canvas.drawPath(incomePath, incomePaint);
    canvas.drawPath(expensePath, expensePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
