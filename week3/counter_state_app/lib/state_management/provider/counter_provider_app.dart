/// ============================================================================
/// FLUTTER COUNTER APP - PROVIDER STATE MANAGEMENT
/// ============================================================================
///
/// Cette application démontre la gestion d'état avec Provider.
/// Provider est la solution officielle recommandée par l'équipe Flutter.
///
/// Caractéristiques principales de Provider :
/// 1. Recommandé officiellement par Flutter
/// 2. Approche déclarative et réactive
/// 3. Bonne performance avec reconstruction granulaire
/// 4. Intégration native avec Flutter
/// 5. Courbe d'apprentissage modérée
///
/// Architecture Provider :
/// - ChangeNotifier : Classe qui contient l'état et la logique
/// - ChangeNotifierProvider : Fournit le ChangeNotifier aux widgets
/// - Consumer : Widget qui écoute les changements
/// - context.read/watch : Accès direct à l'état
///
/// ============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ============================================================================
// ÉTAPE 1 : CRÉER LE CHANGENOTIFIER
// ============================================================================
///
/// ChangeNotifier est une classe qui peut notifier ses écouteurs
/// lorsqu'elle change.
///
/// Pour utiliser ChangeNotifier :
/// 1. Hériter de ChangeNotifier
/// 2. Définir les variables d'état
/// 3. Appeler notifyListeners() après chaque modification
///

class CounterProvider extends ChangeNotifier {
  // Variable d'état privée
  int _count = 0;

  // Getter public pour accéder à la valeur
  int get count => _count;

  // Méthode pour incrémenter
  void increment() {
    _count++;
    // notifyListeners() informe tous les widgets qui écoutent
    // que l'état a changé et qu'ils doivent se reconstruire
    notifyListeners();
  }

  // Méthode pour décrémenter
  void decrement() {
    _count--;
    notifyListeners();
  }

  // Méthode pour réinitialiser
  void reset() {
    _count = 0;
    notifyListeners();
  }

  // Méthode pour incrémenter d'une certaine quantité
  void incrementByAmount(int amount) {
    _count += amount;
    notifyListeners();
  }
}

// ============================================================================
// ÉTAPE 2 : CRÉER L'APPLICATION PRINCIPALE
// ============================================================================

void main() {
  runApp(const CounterAppProvider());
}

class CounterAppProvider extends StatelessWidget {
  const CounterAppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App - Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        // Créer l'instance du provider
        create: (context) => CounterProvider(),
        child: const CounterScreenProvider(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// ÉTAPE 3 : CRÉER L'ÉCRAN PRINCIPAL (UI)
// ============================================================================
///
/// Dans Provider, on peut utiliser plusieurs approches pour écouter l'état :
/// 1. Consumer<T> : Widget qui écoute et reconstruit
/// 2. context.watch<T>() : Écoute et reconstruit
/// 3. context.read<T>() : Accède sans écouter (pour les callbacks)
///

class CounterScreenProvider extends StatelessWidget {
  const CounterScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App - Provider'),
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
            // APPROCHE 1 : CONSUMER WIDGET
            // ================================================================
            ///
            /// Consumer<T> est un widget qui écoute les changements du provider
            /// et reconstruit uniquement ce widget (reconstruction granulaire).
            ///
            /// Avantages :
            /// - Reconstruction granulaire
            /// - Séparation claire entre UI et logique
            /// - Facile à tester
            ///
            Consumer<CounterProvider>(
              builder: (context, counterProvider, child) {
                return Text(
                  '${counterProvider.count}',
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
                  onPressed: () {
                    // ====================================================
                    // context.read<T>() - ACCÈS SANS ÉCOUTE
                    // ====================================================
                    ///
                    /// context.read<T>() permet d'accéder au provider
                    /// sans écouter les changements.
                    ///
                    /// À utiliser dans les callbacks (onPressed, etc.)
                    /// car on ne veut pas reconstruire le widget parent.
                    ///
                    context.read<CounterProvider>().decrement();
                  },
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
                  onPressed: () {
                    context.read<CounterProvider>().increment();
                  },
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
              onPressed: () {
                context.read<CounterProvider>().reset();
              },
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

            // ================================================================
            // APPROCHE 2 : context.watch<T>()
            // ================================================================
            ///
            /// context.watch<T>() est une alternative au Consumer.
            /// Il écoute les changements et reconstruit le widget.
            ///
            /// Note : context.watch() reconstruit TOUT le widget parent,
            /// tandis que Consumer ne reconstruit que son enfant.
            ///
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Informations Provider :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Valeur actuelle : ${context.watch<CounterProvider>().count}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Provider utilise ChangeNotifier',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Consumer pour reconstruction granulaire',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Solution officielle recommandée par Flutter',
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
// RÉSUMÉ - POINTS CLÉS DE PROVIDER
// ============================================================================
///
/// 1. CHANGENOTIFIER
///    - Classe qui contient l'état et la logique
///    - Hérite de ChangeNotifier
///    - Appelle notifyListeners() après chaque modification
///
/// 2. CHANGENOTIFIERPROVIDER
///    - Fournit le ChangeNotifier aux widgets enfants
///    - Gère automatiquement le cycle de vie
///    - Utilise create: pour créer l'instance
///
/// 3. CONSUMER
///    - Widget qui écoute les changements
///    - Reconstruction granulaire
///    - builder: (context, provider, child)
///
/// 4. CONTEXT.READ / CONTEXT.WATCH
///    - context.watch<T>() : Écoute et reconstruit
///    - context.read<T>() : Accède sans écouter (pour callbacks)
///
/// 5. AVANTAGES
///    - Solution officielle de Flutter
///    - Intégration native excellente
///    - Bonne performance
///    - Documentation complète
///    - Large communauté
///
/// 6. INCONVÉNIENTS
///    - Plus verbeux que GetX
///    - Nécessite de bien comprendre le cycle de vie
///    - Peut être complexe pour les cas avancés
///
/// 7. CAS D'USAGE IDÉAL
///    - Applications de toute taille
///    - Quand on préfère les solutions officielles
///    - Projets qui nécessitent une bonne documentation
///    - Équipes qui veulent un standard éprouvé
///
/// ============================================================================
