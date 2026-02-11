/// ============================================================================
/// FLUTTER COUNTER APP - GETX STATE MANAGEMENT
/// ============================================================================
/// 
/// Cette application démontre la gestion d'état avec GetX.
/// GetX est une solution "tout-en-un" qui combine :
/// - La gestion d'état (State Management)
/// - L'injection de dépendances (Dependency Injection)
/// - La gestion de la navigation (Route Management)
///
/// Caractéristiques principales de GetX :
/// 1. Syntaxe simple et concise
/// 2. Boilerplate minimal
/// 3. Performance excellente grâce aux reconstructions granulaires
/// 4. Pas besoin de BuildContext pour accéder à l'état
///
/// ============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ============================================================================
// ÉTAPE 1 : CRÉER LE CONTRÔLEUR (GetxController)
// ============================================================================
/// 
/// Le contrôleur GetX contient :
/// - La logique métier (business logic)
/// - Les variables d'état (state variables)
/// - Les méthodes pour modifier l'état
///
/// En GetX, on utilise le suffixe ".obs" pour transformer une variable
/// en "observable". Cela signifie que la variable peut être "écoutée"
/// par l'interface utilisateur, et chaque fois qu'elle change, les widgets
/// qui l'écoutent sont automatiquement reconstruits.
///

class CounterController extends GetxController {
  // Variable d'état avec ".obs" (observable)
  // Cette variable sera écoutée par l'UI et déclenchera une reconstruction
  // lorsqu'elle change.
  var count = 0.obs;

  // Méthode pour incrémenter le compteur
  void increment() {
    count++; // Modification simple - GetX détecte automatiquement le changement
  }

  // Méthode pour décrémenter le compteur
  void decrement() {
    count--;
  }

  // Méthode pour réinitialiser le compteur
  void reset() {
    count.value = 0; // Accès à la valeur via .value
  }

  // Exemple de logique métier plus complexe
  void incrementByAmount(int amount) {
    count.value += amount;
  }

  // Getter pour accéder à la valeur actuelle
  int get currentCount => count.value;
}

// ============================================================================
// ÉTAPE 2 : CRÉER L'APPLICATION PRINCIPALE
// ============================================================================

void main() {
  runApp(const CounterAppGetX());
}

class CounterAppGetX extends StatelessWidget {
  const CounterAppGetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Counter App - GetX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CounterScreenGetX(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// ÉTAPE 3 : CRÉER L'ÉCRAN PRINCIPAL (UI)
// ============================================================================
/// 
/// Dans GetX, on utilise un StatelessWidget simple (pas besoin de StatefulWidget).
/// La gestion d'état est entièrement déléguée au contrôleur.
///
/// Pour accéder à l'état et le mettre à jour, on utilise :
/// 1. Get.put() - pour injecter le contrôleur
/// 2. Obx() - pour écouter les changements et reconstruire le widget
///

class CounterScreenGetX extends StatelessWidget {
  const CounterScreenGetX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Injection du contrôleur
    // Get.put() crée une instance du contrôleur et la rend disponible
    // dans toute l'application. Cette ligne est exécutée une seule fois.
    final CounterController controller = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App - GetX'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Vous avez appuyé sur le bouton ce nombre de fois :',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // ================================================================
            // WIDGET OBX - ÉCOUTE LES CHANGEMENTS D'ÉTAT
            // ================================================================
            /// 
            /// Obx() est un widget GetX qui écoute les variables ".obs"
            /// utilisées à l'intérieur de sa fonction.
            /// 
            /// Avantage clé : RECONSTRUCTION GRANULAIRE
            /// - Seul le widget à l'intérieur de Obx() est reconstruit
            /// - Pas de reconstruction de l'écran entier
            /// - Performance optimale même avec des changements fréquents
            ///
            Obx(
              () => Text(
                '${controller.count.value}',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            const SizedBox(height: 40),

            // Boutons d'action
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton Décrémenter
                ElevatedButton.icon(
                  onPressed: controller.decrement,
                  icon: const Icon(Icons.remove),
                  label: const Text('Décrémenter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Bouton Incrémenter
                ElevatedButton.icon(
                  onPressed: controller.increment,
                  icon: const Icon(Icons.add),
                  label: const Text('Incrémenter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Bouton Réinitialiser
            ElevatedButton.icon(
              onPressed: controller.reset,
              icon: const Icon(Icons.refresh),
              label: const Text('Réinitialiser'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Affichage d'informations supplémentaires
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Informations GetX :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Text(
                      'Valeur actuelle : ${controller.currentCount}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'GetX utilise des Observables (.obs)',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Reconstruction granulaire avec Obx()',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// RÉSUMÉ - POINTS CLÉS DE GETX
// ============================================================================
/// 
/// 1. CONTRÔLEUR (GetxController)
///    - Contient la logique métier
///    - Les variables d'état sont marquées avec ".obs"
///    - Les méthodes modifient l'état
///
/// 2. INJECTION (Get.put)
///    - Crée et injecte le contrôleur
///    - Rend le contrôleur disponible globalement
///
/// 3. ÉCOUTE (Obx)
///    - Écoute les changements des variables ".obs"
///    - Reconstruit uniquement le widget à l'intérieur
///    - Pas de BuildContext nécessaire
///
/// 4. AVANTAGES
///    - Syntaxe simple et concise
///    - Boilerplate minimal
///    - Performance excellente
///    - Pas besoin de setState()
///
/// 5. CAS D'USAGE IDÉAL
///    - Petites à moyennes applications
///    - Développement rapide
///    - Quand la simplicité est prioritaire
///
/// ============================================================================
