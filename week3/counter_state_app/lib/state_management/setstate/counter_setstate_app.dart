/// ============================================================================
/// FLUTTER COUNTER APP - SETSTATE (ÉTAT LOCAL)
/// ============================================================================
///
/// Cette application démontre la gestion d'état avec setState.
/// setState est la méthode la plus basique et native de Flutter.
///
/// Caractéristiques principales de setState :
/// 1. Approche la plus simple (natif Flutter)
/// 2. Aucune dépendance externe nécessaire
/// 3. Parfait pour l'état local simple
/// 4. Facile à comprendre pour les débutants
/// 5. Limitations pour les applications complexes
///
/// Architecture setState :
/// - StatefulWidget : Widget qui peut changer d'état
/// - State : Classe qui contient l'état et la logique
/// - setState() : Méthode qui notifie Flutter de reconstruire le widget
///
/// ============================================================================

import 'package:flutter/material.dart';

// ============================================================================
// ÉTAPE 1 : CRÉER L'APPLICATION PRINCIPALE
// ============================================================================

void main() {
  runApp(const CounterAppSetState());
}

class CounterAppSetState extends StatelessWidget {
  const CounterAppSetState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App - setState',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CounterScreenSetState(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// ÉTAPE 2 : CRÉER LE STATEFULWIDGET
// ============================================================================
///
/// StatefulWidget est un widget qui peut changer d'état au fil du temps.
///
/// Un StatefulWidget se compose de deux classes :
/// 1. Le widget lui-même (immutable)
/// 2. La classe State qui contient l'état mutable
///

class CounterScreenSetState extends StatefulWidget {
  const CounterScreenSetState({Key? key}) : super(key: key);

  @override
  State<CounterScreenSetState> createState() => _CounterScreenSetStateState();
}

// ============================================================================
// ÉTAPE 3 : CRÉER LA CLASSE STATE
// ============================================================================
///
/// La classe State contient :
/// 1. Les variables d'état (mutables)
/// 2. Les méthodes pour modifier l'état
/// 3. La méthode build() qui construit l'UI
///
/// setState() est la méthode clé :
/// - Elle marque le widget comme "dirty" (à reconstruire)
/// - Flutter planifie une reconstruction du widget
/// - La méthode build() est appelée avec les nouvelles valeurs
///

class _CounterScreenSetStateState extends State<CounterScreenSetState> {
  // ====================================================================
  // VARIABLE D'ÉTAT
  // ====================================================================
  ///
  /// Cette variable est mutable et peut être modifiée.
  /// Chaque fois qu'on la modifie avec setState(), le widget
  /// est reconstruit.
  ///
  int _count = 0;

  // ====================================================================
  // MÉTHODES POUR MODIFIER L'ÉTAT
  // ====================================================================
  ///
  /// Ces méthodes modifient l'état et appellent setState()
  /// pour notifier Flutter de reconstruire le widget.
  ///

  void _increment() {
    setState(() {
      // La modification est faite à l'intérieur de setState()
      // Flutter va reconstruire le widget après cette fonction
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  void _incrementByAmount(int amount) {
    setState(() {
      _count += amount;
    });
  }

  // ====================================================================
  // MÉTHODE BUILD
  // ====================================================================
  ///
  /// La méthode build() est appelée :
  /// - Lors de la création du widget
  /// - Chaque fois que setState() est appelé
  /// - Lorsque le widget parent change
  ///
  /// Important : TOUT le widget est reconstruit, pas seulement
  /// les parties qui ont changé. Pour des performances optimales,
  /// il faut minimiser la taille du widget qui utilise setState.
  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App - setState'),
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
            /// Chaque fois que setState() est appelé, cette partie
            /// est reconstruite avec la nouvelle valeur de _count.
            ///
            Text(
              '$_count',
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
                  onPressed: _decrement,
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
                  onPressed: _increment,
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
              onPressed: _reset,
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
              onPressed: () => _incrementByAmount(10),
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
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Informations setState :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Valeur actuelle : $_count',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'setState() est la méthode native de Flutter',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Parfait pour l\'état local simple',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Pas de dépendances externes nécessaires',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Conseil sur les performances
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: const Column(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.orange, size: 30),
                  SizedBox(height: 10),
                  Text(
                    'Conseil de Performance :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'setState() reconstruit TOUT le widget. Pour les applications complexes, utilisez des solutions de gestion d\'état plus avancées (Provider, BLoC, Riverpod, etc.)',
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
// RÉSUMÉ - POINTS CLÉS DE SETSTATE
// ============================================================================
///
/// 1. STATEFULWIDGET
///    - Widget qui peut changer d'état
///    - Se compose de deux classes : Widget et State
///    - createState() crée l'instance de State
///
/// 2. STATE
///    - Contient les variables d'état (mutables)
///    - Contient les méthodes pour modifier l'état
///    - Contient la méthode build() pour construire l'UI
///
/// 3. SETSTATE()
///    - Méthode qui notifie Flutter de reconstruire le widget
///    - Prend une fonction en paramètre
///    - La modification de l'état se fait dans cette fonction
///
/// 4. CYCLE DE VIE
///    - initState() : Appelé une seule fois lors de la création
///    - build() : Appelé à chaque reconstruction
///    - dispose() : Appelé lors de la destruction du widget
///
/// 5. AVANTAGES
///    - Simple et facile à comprendre
///    - Pas de dépendances externes
///    - Natif à Flutter
///    - Parfait pour l'état local
///    - Idéal pour les débutants
///
/// 6. INCONVÉNIENTS
///    - Reconstruit tout le widget (performance)
///    - Difficile à partager l'état entre widgets
///    - Pas adapté aux applications complexes
///    - Pas de séparation claire entre logique et UI
///
/// 7. CAS D'USAGE IDÉAL
///    - État local simple (formulaires, animations)
///    - Widgets isolés
///    - Prototypes rapides
///    - Applications très simples
///    - Apprentissage de Flutter
///
/// 8. QUAND NE PAS UTILISER SETSTATE
///    - État global partagé entre plusieurs écrans
///    - Logique métier complexe
///    - Applications avec beaucoup d'états interdépendants
///    - Quand la testabilité est importante
///
/// ============================================================================
