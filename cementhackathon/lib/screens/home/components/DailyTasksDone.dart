import 'package:flutter/material.dart';

class DailyTasksDone extends StatefulWidget {
  final String storeName;
  final String productCount;
  final String date;

  const DailyTasksDone({
    Key? key,
    required this.storeName,
    required this.productCount,
    required this.date,
  }) : super(key: key);

  @override
  _DailyTasksDoneState createState() => _DailyTasksDoneState();
}

class _DailyTasksDoneState extends State<DailyTasksDone> {
  bool isTaskDone = false; // État pour suivre si la tâche est terminée

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section supérieure : Nom du magasin, Nombre de produits et Notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Informations sur le magasin
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.storeName,
                    style: TextStyle(
                      color: const Color(0xFF000B23),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: isTaskDone ? TextDecoration.lineThrough : null,
                      letterSpacing: -0.09,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.productCount,
                    style: const TextStyle(
                      color: Color(0xFF7B7B7B),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.06,
                    ),
                  ),
                ],
              ),

              // Cercle avec coche
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTaskDone = !isTaskDone; // Basculer l'état de la tâche
                  });
                },
                child: Container(
                  width: 36.8,
                  height: 36.8,
                  decoration: BoxDecoration(
                    color: isTaskDone
                        ? const Color(0xFFBC1F2A) // Rouge pour terminé
                        : Colors.grey[300], // Gris pour non terminé
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isTaskDone ? Icons.check : Icons.radio_button_unchecked,
                    color: isTaskDone ? Colors.white : const Color(0xFF7B7B7B),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Séparateur
          const Divider(color: Color(0xFFDFDFDF)),

          const SizedBox(height: 8),

          // Section inférieure : Logo et Date
          Row(
            children: [
              // Icône calendrier
              GestureDetector(
                onTap: () {
                  print('Icône de date cliquée');
                },
                child: const Icon(Icons.calendar_today,
                    size: 24, color: Color(0xFF7B7B7B)),
              ),
              const SizedBox(width: 8),

              // Date
              Text(
                widget.date,
                style: const TextStyle(
                  color: Color(0xFF7B7B7B),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.06,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
