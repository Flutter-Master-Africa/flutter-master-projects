/// ============================================================================
/// FLUTTER COUNTER APP - RIVERPOD STATE MANAGEMENT
/// ============================================================================
/// 
/// Cette application démontre la gestion d'état avec Riverpod.
/// Riverpod est une réécriture moderne de Provider qui résout ses limitations.
///
/// Caractéristiques principales de Riverpod :
/// 1. Sûreté de type (Type Safety) au moment de la compilation
/// 2. Testabilité excellente
/// 3. Flexibilité et composabilité
/// 4. Pas besoin de BuildContext pour accéder à l'état
/// 5. Gestion automatique du cycle de vie des providers
///
/// Riverpod propose plusieurs types de providers :
/// - Provider : Pour les valeurs immuables
/// - StateProvider : Pour l'état simple
/// - StateNotifierProvider : Pour l'état complexe avec logique
///
/// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ============================================================================
// ÉTAPE 1 : CRÉER LE NOTIFIER (StateNotifier)
// ============================================================================
/// 
/// StateNotifier est une classe qui gère l'état et les modifications.
/// Contrairement à GetX, Riverpod utilise une approche plus fonctionnelle
/// et immuable pour gérer l'état.
///
/// Caractéristiques :
/// - state : La variable d'état (immuable)
/// - Méthodes pour modifier l'état (créent un nouvel état)
/// - Pas de ".obs", utilise la réactivité de Riverpod
///

class CounterNotifier extends StateNotifier<int> {
  // Le constructeur initialise l'état avec la valeur 0
  // super(0) signifie que l'état initial est 0
  CounterNotifier() : super(0);

  // Méthode pour incrémenter
  // En Riverpod, on ne modifie pas l'état directement
  // On crée un nouvel état et on l'assigne à la variable 'state'
  void increment() {
    state = state + 1;
  }

  // Méthode pour décrémenter
  void decrement() {
    state = state - 1;
  }

  // Méthode pour réinitialiser
  void reset() {
    state = 0;
  }

  // Méthode pour incrémenter d'une certaine quantité
  void incrementByAmount(int amount) {
    state = state + amount;
  }
}

// ============================================================================
// ÉTAPE 2 : CRÉER LE PROVIDER
// ============================================================================
/// 
/// Le Provider est un objet qui encapsule le StateNotifier et le rend
/// accessible depuis n'importe où dans l'application.
///
/// StateNotifierProvider<T, S> où :
/// - T = Le type du Notifier (CounterNotifier)
/// - S = Le type de l'état (int)
///
/// Le provider est déclaré au niveau du module (pas dans une classe)
/// et peut être utilisé dans n'importe quel widget.
///

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  // Cette fonction est appelée une seule fois pour créer le provider
  // Elle retourne une instance du CounterNotifier
  return CounterNotifier();
});

// ============================================================================
// ÉTAPE 3 : CRÉER L'APPLICATION PRINCIPALE
// ============================================================================

void main() {
  runApp(
    // ProviderScope est le widget racine qui fournit l'accès aux providers
    // à toute l'application. C'est obligatoire pour utiliser Riverpod.
    const ProviderScope(
      child: CounterAppRiverpod(),
    ),
  );
}

class CounterAppRiverpod extends StatelessWidget {
  const CounterAppRiverpod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App - Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CounterScreenRiverpod(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// ÉTAPE 4 : CRÉER L'ÉCRAN PRINCIPAL (UI)
// ============================================================================
/// 
/// Dans Riverpod, on utilise ConsumerWidget au lieu de StatelessWidget.
/// ConsumerWidget permet d'accéder aux providers via le paramètre 'ref'.
///
/// Pour accéder à l'état :
/// 1. Hériter de ConsumerWidget (au lieu de StatelessWidget)
/// 2. Utiliser ref.watch() pour écouter les changements
/// 3. Utiliser ref.read() pour accéder à la valeur sans écouter
///

class CounterScreenRiverpod extends ConsumerWidget {
  const CounterScreenRiverpod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ================================================================
    // ref.watch() - ÉCOUTE LES CHANGEMENTS DU PROVIDER
    // ================================================================
    /// 
    /// ref.watch() écoute le provider et reconstruit le widget
    /// lorsque la valeur du provider change.
    ///
    /// Avantage clé : RECONSTRUCTION GRANULAIRE
    /// - Seul ce widget est reconstruit
    /// - Riverpod gère automatiquement les dépendances
    /// - Pas de fuite mémoire (gestion automatique du cycle de vie)
    ///
    /// Différence avec ref.read() :
    /// - ref.watch() : Écoute et reconstruit
    /// - ref.read() : Accède à la valeur une seule fois (pas de reconstruction)
    ///

    final count = ref.watch(counterProvider);

    // Pour accéder au notifier et appeler ses méthodes
    final counterNotifier = ref.read(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App - Riverpod'),
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
            // AFFICHAGE DE L'ÉTAT
            // ================================================================
            /// 
            /// Grâce à ref.watch(), ce Text se reconstruit automatiquement
            /// chaque fois que 'count' change.
            ///
            Text(
              '$count',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 40),

            // Boutons d'action
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton Décrémenter
                ElevatedButton.icon(
                  onPressed: counterNotifier.decrement,
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
                  onPressed: counterNotifier.increment,
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
              onPressed: counterNotifier.reset,
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
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Informations Riverpod :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Valeur actuelle : $count',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Riverpod utilise des Providers',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'ref.watch() pour écouter les changements',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Sûreté de type et testabilité excellente',
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
// RÉSUMÉ - POINTS CLÉS DE RIVERPOD
// ============================================================================
/// 
/// 1. NOTIFIER (StateNotifier)
///    - Gère l'état de manière immuable
///    - Les méthodes créent un nouvel état
///    - Logique métier encapsulée
///
/// 2. PROVIDER
///    - Encapsule le Notifier
///    - Déclaré au niveau du module
///    - Accessible globalement
///
/// 3. CONSUMER WIDGET
///    - Hérite de ConsumerWidget (pas StatelessWidget)
///    - Reçoit un paramètre 'ref' pour accéder aux providers
///
/// 4. ÉCOUTE (ref.watch)
///    - Écoute les changements du provider
///    - Reconstruit le widget automatiquement
///    - ref.read() pour accès sans reconstruction
///
/// 5. AVANTAGES
///    - Sûreté de type (Type Safety)
///    - Testabilité excellente
///    - Gestion automatique du cycle de vie
///    - Pas de fuite mémoire
///    - Flexibilité et composabilité
///
/// 6. CAS D'USAGE IDÉAL
///    - Applications de taille moyenne à grande
///    - Quand la maintenabilité est prioritaire
///    - Projets d'équipe avec besoin de testabilité
///    - Applications complexes avec états interdépendants
///
/// ============================================================================
