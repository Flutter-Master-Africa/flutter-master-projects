/// ============================================================================
/// FLUTTER COUNTER APP - VALUENOTIFIER STATE MANAGEMENT
/// ============================================================================
///
/// Cette application démontre la gestion d'état avec ValueNotifier.
/// ValueNotifier est une solution légère native de Flutter.
///
/// Caractéristiques principales de ValueNotifier :
/// 1. Léger et natif à Flutter (pas de package externe)
/// 2. Simple à utiliser
/// 3. Performance excellente (reconstruction granulaire)
/// 4. Parfait pour l'état simple partagé
/// 5. Alternative à Provider pour les cas simples
///
/// Architecture ValueNotifier :
/// - ValueNotifier<T> : Conteneur qui peut notifier ses écouteurs
/// - ValueListenableBuilder<T> : Widget qui écoute les changements
/// - value : Propriété pour lire/écrire la valeur
///
/// ============================================================================

import 'package:flutter/material.dart';

// ============================================================================
/// ÉTAPE 1 : CRÉER LE VALUENOTIFIER
// ============================================================================
///
/// ValueNotifier<T> est une classe qui encapsule une valeur
/// et notifie ses écouteurs lorsque cette valeur change.
///
/// Contrairement à setState :
/// - Peut être utilisé en dehors des widgets
/// - Reconstruction granulaire (seuls les widgets qui écoutent)
/// - Peut être facilement partagé entre plusieurs widgets
///

class CounterNotifier {
  // ValueNotifier qui contient le compteur
  // Chaque fois que .value change, les écouteurs sont notifiés
  final ValueNotifier<int> count = ValueNotifier<int>(0);

  // Méthode pour incrémenter
  void increment() {
    count.value++;
  }

  // Méthode pour décrémenter
  void decrement() {
    count.value--;
  }

  // Méthode pour réinitialiser
  void reset() {
    count.value = 0;
  }

  // Méthode pour incrémenter d'une certaine quantité
  void incrementByAmount(int amount) {
    count.value += amount;
  }

  // Méthode pour libérer les ressources
  // IMPORTANT : Toujours appeler dispose() pour éviter les fuites mémoire
  void dispose() {
    count.dispose();
  }
}

// ============================================================================
// ÉTAPE 2 : CRÉER L'APPLICATION PRINCIPALE
// ============================================================================

void main() {
  runApp(const CounterAppValueNotifier());
}

class CounterAppValueNotifier extends StatelessWidget {
  const CounterAppValueNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App - ValueNotifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CounterScreenValueNotifier(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// ÉTAPE 3 : CRÉER L'ÉCRAN PRINCIPAL (UI)
// ============================================================================
///
/// Dans ValueNotifier, on utilise ValueListenableBuilder pour écouter
/// les changements.
///
/// ValueListenableBuilder<T> :
/// - Écoute un ValueNotifier<T>
/// - Se reconstruit uniquement lorsque la valeur change
/// - Reconstruction granulaire (seul ce widget est reconstruit)
///

class CounterScreenValueNotifier extends StatefulWidget {
  const CounterScreenValueNotifier({Key? key}) : super(key: key);

  @override
  State<CounterScreenValueNotifier> createState() =>
      _CounterScreenValueNotifierState();
}

class _CounterScreenValueNotifierState
    extends State<CounterScreenValueNotifier> {
  // Instance du CounterNotifier
  // On crée une instance dans le State pour gérer le cycle de vie
  late final CounterNotifier _counterNotifier;

  @override
  void initState() {
    super.initState();
    // Initialiser le notifier
    _counterNotifier = CounterNotifier();
  }

  @override
  void dispose() {
    // IMPORTANT : Libérer les ressources pour éviter les fuites mémoire
    _counterNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App - ValueNotifier'),
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
            // VALUELISTENABLEBUILDER - ÉCOUTE LES CHANGEMENTS
            // ================================================================
            ///
            /// ValueListenableBuilder écoute un ValueNotifier et reconstruit
            /// le widget lorsque la valeur change.
            ///
            /// Paramètres :
            /// - valueListenable : Le ValueNotifier à écouter
            /// - builder : La fonction qui construit le widget
            /// - value : La valeur actuelle du ValueNotifier
            /// - child : Widget optionnel qui ne se reconstruit pas (pour performance)
            ///
            /// Avantages :
            /// - Reconstruction granulaire (seul ce widget)
            /// - Performance excellente
            /// - Simple et facile à comprendre
            ///
            ValueListenableBuilder<int>(
              valueListenable: _counterNotifier.count,
              builder: (context, value, child) {
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                );
              },
            ),

            const SizedBox(height: 40),

            // Boutons d'action
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton Décrémenter
                ElevatedButton.icon(
                  onPressed: _counterNotifier.decrement,
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
                  onPressed: _counterNotifier.increment,
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
              onPressed: _counterNotifier.reset,
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

            const SizedBox(height: 20),

            // Bouton Incrémenter par 10
            ElevatedButton.icon(
              onPressed: () => _counterNotifier.incrementByAmount(10),
              icon: const Icon(Icons.add_circle),
              label: const Text('+10'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Informations ValueNotifier :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<int>(
                    valueListenable: _counterNotifier.count,
                    builder: (context, value, child) {
                      return Text(
                        'Valeur actuelle : $value',
                        style: const TextStyle(fontSize: 12),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'ValueNotifier est natif à Flutter',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'ValueListenableBuilder pour écouter',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Reconstruction granulaire excellente',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Conseil
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: const Column(
                children: [
                  Icon(Icons.check_circle_outline,
                      color: Colors.green, size: 30),
                  SizedBox(height: 10),
                  Text(
                    'Conseil :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'ValueNotifier est parfait pour l\'état simple partagé. Plus performant que setState et plus simple que Provider pour les cas d\'usage simples.',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                    textAlign: TextAlign.center,
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
// RÉSUMÉ - POINTS CLÉS DE VALUENOTIFIER
// ============================================================================
///
/// 1. VALUENOTIFIER<T>
///    - Conteneur qui encapsule une valeur
///    - Notifie automatiquement les écouteurs lors des changements
///    - Utilise .value pour lire/écrire
///
/// 2. VALUELISTENABLEBUILDER<T>
///    - Widget qui écoute un ValueNotifier
///    - Se reconstruit uniquement quand la valeur change
///    - Reconstruction granulaire
///
/// 3. CYCLE DE VIE
///    - Créer le ValueNotifier dans initState()
///    - Toujours appeler dispose() dans dispose()
///    - Évite les fuites mémoire
///
/// 4. AVANTAGES
///    - Natif à Flutter (pas de dépendances)
///    - Simple et facile à utiliser
///    - Performance excellente (reconstruction granulaire)
///    - Léger et rapide
///    - Parfait pour l'état simple partagé
///
/// 5. INCONVÉNIENTS
///    - Pas adapté pour l'état complexe
///    - Nécessite de gérer manuellement le cycle de vie
///    - Pas de dépendances automatiques entre états
///    - Limité pour les applications complexes
///
/// 6. CAS D'USAGE IDÉAL
///    - État simple partagé entre quelques widgets
///    - Alternative légère à Provider
///    - Animations et contrôleurs
///    - Formulaires simples
///    - Quand la performance est critique
///
/// 7. COMPARAISON AVEC SETSTATE
///    - ValueNotifier : Reconstruction granulaire
///    - setState : Reconstruit tout le widget
///    - ValueNotifier : Peut être partagé facilement
///    - setState : Limité au widget local
///
/// 8. COMPARAISON AVEC PROVIDER
///    - ValueNotifier : Plus simple, moins de boilerplate
///    - Provider : Plus de fonctionnalités (DI, scopes, etc.)
///    - ValueNotifier : Parfait pour les cas simples
///    - Provider : Meilleur pour les applications complexes
///
/// ============================================================================
