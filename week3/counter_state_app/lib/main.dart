import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as getx;

// Import all state management examples
import 'state_management/setstate/counter_setstate_app.dart';
import 'state_management/valuenotifier/counter_valuenotifier_app.dart';
import 'state_management/inheritedwidget/counter_inheritedwidget_app.dart';
import 'state_management/provider/counter_provider_app.dart';
import 'state_management/bloc/counter_bloc_app.dart';
import 'state_management/getx/counter_getx_app.dart';
import 'state_management/riverpod/counter_riverpod_app.dart';

void main() {
  runApp(const StateManagementLearningApp());
}

class StateManagementLearningApp extends StatelessWidget {
  const StateManagementLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Management Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StateManagementMenuScreen(),
    );
  }
}

// Model for state management approaches
class StateManagementOption {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String difficulty;
  final List<String> features;
  final Widget Function() appBuilder;

  const StateManagementOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.difficulty,
    required this.features,
    required this.appBuilder,
  });
}

class StateManagementMenuScreen extends StatelessWidget {
  const StateManagementMenuScreen({super.key});

  static final List<StateManagementOption> _options = [
    StateManagementOption(
      title: 'setState',
      description: 'La méthode native de Flutter. Parfait pour commencer et comprendre les bases.',
      icon: Icons.widgets,
      color: Colors.blue,
      difficulty: 'Débutant',
      features: [
        'Natif Flutter',
        'Simple à comprendre',
        'État local',
        'Aucune dépendance'
      ],
      appBuilder: () => const CounterScreenSetState(),
    ),
    StateManagementOption(
      title: 'ValueNotifier',
      description: 'Solution légère native pour l\'état simple avec reconstruction granulaire.',
      icon: Icons.notifications_active,
      color: Colors.teal,
      difficulty: 'Débutant',
      features: [
        'Natif Flutter',
        'Reconstruction granulaire',
        'Léger et rapide',
        'État partageable'
      ],
      appBuilder: () => const CounterScreenValueNotifier(),
    ),
    StateManagementOption(
      title: 'InheritedWidget',
      description: 'Le mécanisme fondamental de Flutter. Comprendre comment tout fonctionne en interne.',
      icon: Icons.account_tree,
      color: Colors.deepPurple,
      difficulty: 'Avancé',
      features: [
        'Mécanisme de base',
        'Éducatif',
        'Rarement utilisé directement',
        'Base de Provider'
      ],
      appBuilder: () => const CounterScreenInheritedWidget(),
    ),
    StateManagementOption(
      title: 'Provider',
      description: 'Solution officielle recommandée par Flutter. Excellente pour la plupart des projets.',
      icon: Icons.inventory,
      color: Colors.green,
      difficulty: 'Intermédiaire',
      features: [
        'Recommandé par Flutter',
        'ChangeNotifier',
        'Bonne performance',
        'Large communauté'
      ],
      appBuilder: () => const CounterScreenProvider(),
    ),
    StateManagementOption(
      title: 'BLoC',
      description: 'Pattern événement-état robuste. Excellent pour les grandes applications d\'entreprise.',
      icon: Icons.business_center,
      color: Colors.orange,
      difficulty: 'Avancé',
      features: [
        'Séparation stricte',
        'Très testable',
        'Pattern Event-State',
        'Grande scalabilité'
      ],
      appBuilder: () => BlocProvider(
        create: (context) => CounterBloc(),
        child: const CounterScreenBloc(),
      ),
    ),
    StateManagementOption(
      title: 'GetX',
      description: 'Solution "tout-en-un" ultra simple et rapide. Parfait pour le développement rapide.',
      icon: Icons.flash_on,
      color: Colors.purple,
      difficulty: 'Débutant',
      features: [
        'Syntaxe simple',
        'Boilerplate minimal',
        'DI + Routes + State',
        'Très performant'
      ],
      appBuilder: () {
        // Initialize GetX if not already done
        return const CounterScreenGetX();
      },
    ),
    StateManagementOption(
      title: 'Riverpod',
      description: 'Version améliorée de Provider avec type safety. Excellent pour les projets modernes.',
      icon: Icons.security,
      color: Colors.indigo,
      difficulty: 'Intermédiaire',
      features: [
        'Type Safety',
        'Testabilité excellente',
        'Pas de BuildContext',
        'Moderne et flexible'
      ],
      appBuilder: () => const CounterScreenRiverpod(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade50,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.school,
                      size: 60,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Flutter State Management',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choisissez une approche pour apprendre',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Options List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    final option = _options[index];
                    return _StateManagementCard(option: option);
                  },
                ),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Appuyez sur une carte pour tester l\'approche',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StateManagementCard extends StatelessWidget {
  final StateManagementOption option;

  const _StateManagementCard({required this.option});

  Color _getDifficultyColor() {
    switch (option.difficulty) {
      case 'Débutant':
        return Colors.green;
      case 'Intermédiaire':
        return Colors.orange;
      case 'Avancé':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                // Special handling for GetX and Riverpod
                if (option.title == 'GetX') {
                  return getx.GetMaterialApp(
                    title: 'Counter App - GetX',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                      useMaterial3: true,
                    ),
                    home: option.appBuilder(),
                    debugShowCheckedModeBanner: false,
                  );
                } else if (option.title == 'Riverpod') {
                  return const ProviderScope(
                    child: MaterialApp(
                      title: 'Counter App - Riverpod',
                      home: CounterScreenRiverpod(),
                      debugShowCheckedModeBanner: false,
                    ),
                  );
                }
                return option.appBuilder();
              },
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: option.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      option.icon,
                      color: option.color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: option.color.withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor().withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            option.difficulty,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getDifficultyColor(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                option.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 12),

              // Features
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: option.features.map((feature) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: option.color.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: option.color.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: option.color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          feature,
                          style: TextStyle(
                            fontSize: 12,
                            color: option.color.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
