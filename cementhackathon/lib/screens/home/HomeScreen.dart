import 'package:cement_flutter/screens/home/components/DailyTasksDone.dart';
import 'package:cement_flutter/screens/home/components/HeadlineRow.dart'; // Importer UserProfileRow
import 'package:cement_flutter/screens/home/components/WeeklyTaskCard.dart';
import 'package:cement_flutter/screens/home/components/WeeklyTasksHeader.dart'; // Importer WeeklyTasksHeader
import 'package:flutter/material.dart';

import '../../components/SideBar.dart';

// Importer WeeklyTaskCard

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Couleur d'arrière-plan
      appBar: AppBar(
        title: Text('Cement',
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
      body: SafeArea(
        child: SingleChildScrollView(
          // Ajouter une fonctionnalité de défilement
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16), // Rembourrage horizontal uniforme
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligner les éléments au début
              children: [
                // En-tête : Ligne de profil utilisateur
                UserProfileRow(
                  greeting: 'Bonsoir !',
                  username: 'Habib',
                  avatarUrl:
                      'https://via.placeholder.com/150', // Remplacer par l'URL de votre avatar
                  onNotificationTap: () {
                    print('Icône de notification cliquée !');
                  },
                ),

                const SizedBox(height: 24), // Espacement accru pour la clarté

                // En-tête des tâches hebdomadaires
                WeeklyTasksHeader(
                  title: 'Mes tâches hebdomadaires',
                  subtitle: '18 tâches en attente',
                  onSliderTap: () {
                    print('Icône de curseur cliquée !');
                  },
                  onAddTap: () {
                    print('Icône d\'ajout cliquée !');
                  },
                ),

                const SizedBox(
                    height:
                        16), // Espacement entre l'en-tête et les cartes des tâches

                // Cartes des tâches hebdomadaires
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WeeklyTaskCard(
                        city: 'Ariana',
                        region: 'Nord',
                        storeName: 'Magasin Tijani',
                        date: 'Lun, 10 Nov 2024',
                        onTap: () {
                          print('Carte 1 cliquée !');
                        },
                      ),
                      const SizedBox(width: 16), // Espace entre les cartes
                      WeeklyTaskCard(
                        city: 'Tunis',
                        region: 'Centre',
                        storeName: 'Marché Central',
                        date: 'Mar, 11 Nov 2024',
                        onTap: () {
                          print('Carte 2 cliquée !');
                        },
                      ),
                      const SizedBox(width: 16), // Espace entre les cartes
                      WeeklyTaskCard(
                        city: 'Sousse',
                        region: 'Sud',
                        storeName: 'Bazaar de Sousse',
                        date: 'Mer, 12 Nov 2024',
                        onTap: () {
                          print('Carte 3 cliquée !');
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height:
                        24), // Rembourrage entre les cartes et l'en-tête dupliqué

                // En-tête des tâches du jour dupliqué
                WeeklyTasksHeader(
                  title: 'Tâche du jour',
                  subtitle: '5 à venir',
                  onSliderTap: () {
                    print('Icône de curseur cliquée pour les tâches à venir !');
                  },
                  onAddTap: () {
                    print('Icône d\'ajout cliquée pour les tâches à venir !');
                  },
                ),

                const SizedBox(
                    height:
                        16), // Rembourrage optionnel pour un contenu supplémentaire

                // Section des tâches quotidiennes terminées
                const DailyTasksDone(
                  storeName: 'Magasin Hamadi',
                  productCount: '30 Produits',
                  date: 'Lun, 10 Déc 2024',
                ),
                const DailyTasksDone(
                  storeName: 'Magasin Hamadi',
                  productCount: '30 Produits',
                  date: 'Lun, 10 Déc 2024',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
