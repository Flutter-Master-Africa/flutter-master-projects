/// ============================================================================
/// FLUTTER COUNTER APP - INHERITEDWIDGET STATE MANAGEMENT
/// ============================================================================
///
/// Cette application démontre la gestion d'état avec InheritedWidget.
/// InheritedWidget est le mécanisme fondamental de Flutter pour propager
/// des données dans l'arbre de widgets.
///
/// Caractéristiques principales d'InheritedWidget :
/// 1. Mécanisme de base de Flutter (Provider est construit dessus)
/// 2. Permet de propager des données dans l'arbre de widgets
/// 3. Reconstruction automatique des widgets dépendants
/// 4. Approche de bas niveau (plus complexe)
/// 5. Rarement utilisé directement en production
///
/// Architecture InheritedWidget :
/// - InheritedWidget : Widget qui propage les données
/// - updateShouldNotify : Méthode qui détermine si les écouteurs doivent être notifiés
/// - of(context) : Méthode statique pour accéder aux données
///
/// ============================================================================

import 'package:flutter/material.dart';

// ============================================================================
// ÉTAPE 1 : CRÉER LE MODÈLE DE DONNÉES
// ============================================================================
///
/// Cette classe contient l'état de l'application.
/// Elle est immuable pour suivre les bonnes pratiques Flutter.
///

class CounterData {
  final int count;

  const CounterData({this.count = 0});

  // Méthode pour créer une nouvelle instance avec une valeur différente
  CounterData copyWith({int? count}) {
    return CounterData(count: count ?? this.count);
  }
}

// ============================================================================
// ÉTAPE 2 : CRÉER L'INHERITEDWIDGET
// ============================================================================
///
/// InheritedWidget est un widget spécial qui peut propager efficacement
/// des données dans l'arbre de widgets.
///
/// Caractéristiques :
/// - Les widgets enfants peuvent accéder aux données via context
/// - Flutter optimise automatiquement les reconstructions
/// - updateShouldNotify détermine quand notifier les dépendants
///

class CounterInheritedWidget extends InheritedWidget {
  final CounterData data;
  final Function() increment;
  final Function() decrement;
  final Function() reset;
  final Function(int) incrementByAmount;

  const CounterInheritedWidget({
    Key? key,
    required this.data,
    required this.increment,
    required this.decrement,
    required this.reset,
    required this.incrementByAmount,
    required Widget child,
  }) : super(key: key, child: child);

  // ====================================================================
  // MÉTHODE STATIQUE OF - ACCÈS AUX DONNÉES
  // ====================================================================
  ///
  /// Cette méthode permet aux widgets enfants d'accéder aux données
  /// de l'InheritedWidget.
  ///
  /// dependOnInheritedWidgetOfExactType<T>() :
  /// - Enregistre le widget appelant comme dépendant
  /// - Reconstruit automatiquement le widget quand les données changent
  ///
  static CounterInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>();
  }

  // ====================================================================
  // UPDATESHOULDNOTIFY - CONTRÔLE DES RECONSTRUCTIONS
  // ====================================================================
  ///
  /// Cette méthode détermine si les widgets dépendants doivent être
  /// notifiés et reconstruits.
  ///
  /// Return true : Les widgets dépendants sont reconstruits
  /// Return false : Aucune reconstruction
  ///
  /// Flutter appelle cette méthode chaque fois que l'InheritedWidget
  /// est reconstruit.
  ///
  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) {
    // Notifier uniquement si la valeur du compteur a changé
    return data.count != oldWidget.data.count;
  }
}

// ============================================================================
// ÉTAPE 3 : CRÉER LE WIDGET CONTENEUR AVEC ÉTAT
// ============================================================================
///
/// Ce widget gère l'état et fournit l'InheritedWidget aux widgets enfants.
/// C'est le "provider" qui encapsule la logique et l'InheritedWidget.
///

class CounterProvider extends StatefulWidget {
  final Widget child;

  const CounterProvider({Key? key, required this.child}) : super(key: key);

  @override
  State<CounterProvider> createState() => _CounterProviderState();
}

class _CounterProviderState extends State<CounterProvider> {
  // État local
  CounterData _data = const CounterData();

  // Méthodes pour modifier l'état
  void _increment() {
    setState(() {
      _data = _data.copyWith(count: _data.count + 1);
    });
  }

  void _decrement() {
    setState(() {
      _data = _data.copyWith(count: _data.count - 1);
    });
  }

  void _reset() {
    setState(() {
      _data = const CounterData();
    });
  }

  void _incrementByAmount(int amount) {
    setState(() {
      _data = _data.copyWith(count: _data.count + amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fournir l'InheritedWidget aux widgets enfants
    return CounterInheritedWidget(
      data: _data,
      increment: _increment,
      decrement: _decrement,
      reset: _reset,
      incrementByAmount: _incrementByAmount,
      child: widget.child,
    );
  }
}

// ============================================================================
// ÉTAPE 4 : CRÉER L'APPLICATION PRINCIPALE
// ============================================================================

void main() {
  runApp(const CounterAppInheritedWidget());
}

class CounterAppInheritedWidget extends StatelessWidget {
  const CounterAppInheritedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App - InheritedWidget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Envelopper l'écran avec le CounterProvider
      home: const CounterProvider(
        child: CounterScreenInheritedWidget(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// ÉTAPE 5 : CRÉER L'ÉCRAN PRINCIPAL (UI)
// ============================================================================
///
/// Dans InheritedWidget, on accède aux données via la méthode of(context).
/// Les widgets qui utilisent of(context) sont automatiquement enregistrés
/// comme dépendants et seront reconstruits lorsque les données changent.
///

class CounterScreenInheritedWidget extends StatelessWidget {
  const CounterScreenInheritedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ====================================================================
    // ACCÈS AUX DONNÉES VIA INHERITEDWIDGET.OF(CONTEXT)
    // ====================================================================
    ///
    /// Cette ligne :
    /// 1. Récupère l'InheritedWidget le plus proche dans l'arbre
    /// 2. Enregistre ce widget comme dépendant
    /// 3. Reconstruit automatiquement ce widget quand les données changent
    ///
    final counterWidget = CounterInheritedWidget.of(context);

    // Sécurité : Vérifier que l'InheritedWidget existe
    if (counterWidget == null) {
      return const Scaffold(
        body: Center(
          child: Text('Erreur : CounterInheritedWidget non trouvé'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App - InheritedWidget'),
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

            // Affichage du compteur
            Text(
              '${counterWidget.data.count}',
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
                  onPressed: counterWidget.decrement,
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
                  onPressed: counterWidget.increment,
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
              onPressed: counterWidget.reset,
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
              onPressed: () => counterWidget.incrementByAmount(10),
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
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Informations InheritedWidget :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Valeur actuelle : ${counterWidget.data.count}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'InheritedWidget est le mécanisme de base',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Provider, Riverpod utilisent InheritedWidget',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Reconstruction automatique des dépendants',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Avertissement
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: const Column(
                children: [
                  Icon(Icons.warning_outlined, color: Colors.red, size: 30),
                  SizedBox(height: 10),
                  Text(
                    'Note Importante :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'InheritedWidget est rarement utilisé directement en production. Utilisez plutôt Provider, Riverpod ou BLoC qui sont construits sur InheritedWidget.',
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
// RÉSUMÉ - POINTS CLÉS D'INHERITEDWIDGET
// ============================================================================
///
/// 1. INHERITEDWIDGET
///    - Mécanisme de base de Flutter pour propager des données
///    - Reconstruction automatique des widgets dépendants
///    - updateShouldNotify contrôle les reconstructions
///
/// 2. MÉTHODE OF(CONTEXT)
///    - Accède aux données de l'InheritedWidget
///    - Enregistre le widget comme dépendant
///    - dependOnInheritedWidgetOfExactType<T>()
///
/// 3. UPDATESHOULDNOTIFY
///    - Détermine si les dépendants doivent être notifiés
///    - Optimise les performances
///    - Retourne true si les données ont changé
///
/// 4. AVANTAGES
///    - Mécanisme fondamental de Flutter
///    - Reconstruction automatique
///    - Performance optimisée par Flutter
///    - Comprendre InheritedWidget aide à comprendre Provider/Riverpod
///
/// 5. INCONVÉNIENTS
///    - Complexe à utiliser directement
///    - Beaucoup de boilerplate
///    - Pas adapté pour les débutants
///    - Pas de gestion d'état intégrée
///
/// 6. CAS D'USAGE
///    - APPRENTISSAGE : Pour comprendre comment fonctionne Flutter en interne
///    - RAREMENT EN PRODUCTION : Utilisez Provider, Riverpod ou BLoC à la place
///    - BASE DE COMPRÉHENSION : Provider, Riverpod, Theme, MediaQuery utilisent InheritedWidget
///
/// 7. ALTERNATIVES RECOMMANDÉES
///    - Provider : Construit sur InheritedWidget, plus simple
///    - Riverpod : Améliore Provider avec type safety
///    - BLoC : Pour les applications complexes
///
/// 8. RELATION AVEC D'AUTRES SOLUTIONS
///    - Provider = InheritedWidget + ChangeNotifier + Utilities
///    - Riverpod = Provider reimaginé avec type safety
///    - Theme, MediaQuery = InheritedWidget en interne
///
/// ============================================================================
