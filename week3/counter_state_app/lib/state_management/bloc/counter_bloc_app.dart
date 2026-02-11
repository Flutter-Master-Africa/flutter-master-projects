/// ============================================================================
/// FLUTTER COUNTER APP - BLOC STATE MANAGEMENT
/// ============================================================================
/// 
/// Cette application démontre la gestion d'état avec BLoC (Business Logic Component).
/// BLoC est une solution qui met l'accent sur la séparation stricte des préoccupations.
///
/// Caractéristiques principales de BLoC :
/// 1. Séparation stricte entre la logique métier et l'UI
/// 2. Modèle événement-état très prévisible
/// 3. Testabilité maximale
/// 4. Scalabilité pour les grandes applications
/// 5. Courbe d'apprentissage plus élevée (plus de boilerplate)
///
/// Architecture BLoC :
/// - Events : Les actions déclenchées par l'utilisateur
/// - BLoC : La logique qui traite les événements et produit des états
/// - States : Les différents états de l'application
/// - Widgets : L'interface utilisateur qui affiche les états
///
/// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================================
// ÉTAPE 1 : DÉFINIR LES ÉVÉNEMENTS (Events)
// ============================================================================
/// 
/// Les événements représentent les actions que l'utilisateur peut effectuer
/// ou les événements que l'application peut déclencher.
/// 
/// En BLoC, tout est basé sur des événements. Chaque interaction utilisateur
/// génère un événement qui est traité par le BLoC.
///

abstract class CounterEvent {
  const CounterEvent();
}

class CounterIncrementPressed extends CounterEvent {
  const CounterIncrementPressed();
}

class CounterDecrementPressed extends CounterEvent {
  const CounterDecrementPressed();
}

class CounterResetPressed extends CounterEvent {
  const CounterResetPressed();
}

class CounterIncrementByAmountPressed extends CounterEvent {
  final int amount;
  const CounterIncrementByAmountPressed(this.amount);
}

// ============================================================================
// ÉTAPE 2 : DÉFINIR LES ÉTATS (States)
// ============================================================================
/// 
/// Les états représentent les différentes situations dans lesquelles
/// l'application peut se trouver.
/// 
/// En BLoC, l'UI réagit aux changements d'état. Chaque état produit
/// une interface utilisateur différente.
///

abstract class CounterState {
  final int count;
  const CounterState(this.count);
}

class CounterInitial extends CounterState {
  const CounterInitial() : super(0);
}

class CounterUpdated extends CounterState {
  const CounterUpdated(int count) : super(count);
}

// ============================================================================
// ÉTAPE 3 : CRÉER LE BLOC (Business Logic Component)
// ============================================================================
/// 
/// Le BLoC est le cœur de la gestion d'état en BLoC.
/// Il reçoit des événements et produit des états.
/// 
/// Responsabilités du BLoC :
/// - Recevoir les événements
/// - Traiter la logique métier
/// - Émettre les nouveaux états
///
/// Le BLoC hérite de Bloc<Event, State> où :
/// - Event = Le type d'événement traité
/// - State = Le type d'état produit
///

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  // Le constructeur initialise le BLoC avec un état initial
  CounterBloc() : super(const CounterInitial()) {
    // Enregistrement des gestionnaires d'événements
    // Chaque type d'événement a son propre gestionnaire
    on<CounterIncrementPressed>(_onIncrementPressed);
    on<CounterDecrementPressed>(_onDecrementPressed);
    on<CounterResetPressed>(_onResetPressed);
    on<CounterIncrementByAmountPressed>(_onIncrementByAmountPressed);
  }

  // Gestionnaire pour l'événement CounterIncrementPressed
  Future<void> _onIncrementPressed(
    CounterIncrementPressed event,
    Emitter<CounterState> emit,
  ) async {
    // Émettre un nouvel état avec le compteur incrémenté
    emit(CounterUpdated(state.count + 1));
  }

  // Gestionnaire pour l'événement CounterDecrementPressed
  Future<void> _onDecrementPressed(
    CounterDecrementPressed event,
    Emitter<CounterState> emit,
  ) async {
    // Émettre un nouvel état avec le compteur décrémenté
    emit(CounterUpdated(state.count - 1));
  }

  // Gestionnaire pour l'événement CounterResetPressed
  Future<void> _onResetPressed(
    CounterResetPressed event,
    Emitter<CounterState> emit,
  ) async {
    // Émettre un nouvel état avec le compteur réinitialisé à 0
    emit(const CounterUpdated(0));
  }

  // Gestionnaire pour l'événement CounterIncrementByAmountPressed
  Future<void> _onIncrementByAmountPressed(
    CounterIncrementByAmountPressed event,
    Emitter<CounterState> emit,
  ) async {
    // Émettre un nouvel état avec le compteur augmenté du montant spécifié
    emit(CounterUpdated(state.count + event.amount));
  }
}

// ============================================================================
// ÉTAPE 4 : CRÉER L'APPLICATION PRINCIPALE
// ============================================================================

void main() {
  runApp(const CounterAppBloc());
}

class CounterAppBloc extends StatelessWidget {
  const CounterAppBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App - BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
        // BlocProvider crée une instance du BLoC et la fournit à tous les widgets enfants
        create: (context) => CounterBloc(),
        child: const CounterScreenBloc(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// ÉTAPE 5 : CRÉER L'ÉCRAN PRINCIPAL (UI)
// ============================================================================
/// 
/// Dans BLoC, on utilise BlocBuilder pour écouter les changements d'état.
/// BlocBuilder reconstruit le widget chaque fois qu'un nouvel état est émis.
///
/// Flux en BLoC :
/// 1. L'utilisateur appuie sur un bouton
/// 2. Un événement est ajouté au BLoC (context.read<CounterBloc>().add())
/// 3. Le BLoC traite l'événement et émet un nouvel état
/// 4. BlocBuilder détecte le changement d'état et reconstruit le widget
///

class CounterScreenBloc extends StatelessWidget {
  const CounterScreenBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App - BLoC'),
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
            // BLOCBUILDER - ÉCOUTE LES CHANGEMENTS D'ÉTAT
            // ================================================================
            /// 
            /// BlocBuilder écoute le BLoC et reconstruit le widget
            /// chaque fois qu'un nouvel état est émis.
            ///
            /// Paramètres :
            /// - builder : La fonction qui construit le widget
            /// - state : L'état actuel du BLoC
            ///
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  '${state.count}',
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
                    // Ajouter un événement au BLoC
                    context.read<CounterBloc>().add(
                          const CounterDecrementPressed(),
                        );
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
                    // Ajouter un événement au BLoC
                    context.read<CounterBloc>().add(
                          const CounterIncrementPressed(),
                        );
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
                // Ajouter un événement au BLoC
                context.read<CounterBloc>().add(
                      const CounterResetPressed(),
                    );
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

            // Affichage d'informations supplémentaires
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'Informations BLoC :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<CounterBloc, CounterState>(
                    builder: (context, state) {
                      return Text(
                        'Valeur actuelle : ${state.count}',
                        style: const TextStyle(fontSize: 12),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'BLoC utilise un modèle Événement-État',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Séparation stricte de la logique métier',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Testabilité maximale et scalabilité',
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
// RÉSUMÉ - POINTS CLÉS DE BLOC
// ============================================================================
/// 
/// 1. ÉVÉNEMENTS (Events)
///    - Représentent les actions utilisateur
///    - Immuables et fortement typés
///    - Exemples : CounterIncrementPressed, CounterDecrementPressed
///
/// 2. ÉTATS (States)
///    - Représentent les différentes situations de l'app
///    - Immuables et fortement typés
///    - Exemples : CounterInitial, CounterUpdated
///
/// 3. BLOC (Business Logic Component)
///    - Reçoit les événements
///    - Traite la logique métier
///    - Émet les nouveaux états
///    - Hérite de Bloc<Event, State>
///
/// 4. GESTIONNAIRES D'ÉVÉNEMENTS
///    - Chaque événement a son propre gestionnaire
///    - Utilisent Emitter pour émettre les nouveaux états
///    - Peuvent être asynchrones (Future<void>)
///
/// 5. WIDGETS
///    - BlocBuilder : Écoute les changements d'état et reconstruit
///    - BlocProvider : Fournit le BLoC aux widgets enfants
///    - context.read<BLoC>().add() : Ajouter un événement
///
/// 6. AVANTAGES
///    - Séparation stricte des préoccupations
///    - Testabilité maximale (logique métier indépendante de l'UI)
///    - Très prévisible et maintenable
///    - Excellent pour les grandes applications
///    - Excellente scalabilité
///
/// 7. INCONVÉNIENTS
///    - Plus de boilerplate que GetX ou Riverpod
///    - Courbe d'apprentissage plus élevée
///    - Plus de code pour des cas simples
///
/// 8. CAS D'USAGE IDÉAL
///    - Grandes applications d'entreprise
///    - Projets d'équipe avec besoin de testabilité
///    - Applications complexes avec logique métier importante
///    - Quand la maintenabilité à long terme est prioritaire
///
/// ============================================================================
