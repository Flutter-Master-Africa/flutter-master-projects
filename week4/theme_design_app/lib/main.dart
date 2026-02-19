/// ============================================================================
/// FLUTTER THEMES & MODERN DESIGN EXPLORATION PROJECT
/// ============================================================================
/// 
/// Cette application démontre les concepts clés des thèmes et du design moderne
/// en Flutter, incluant :
/// 
/// 1. Thèmes clair et sombre (Light & Dark Themes)
/// 2. Changement dynamique de thème
/// 3. Material Design 3 avec ColorScheme
/// 4. Personnalisation UI
/// 5. Widgets Material et Cupertino
/// 6. Bonnes pratiques de design
///
/// L'application inclut un écran de démonstration avec :
/// - Un bouton pour basculer entre les thèmes
/// - Différents types de widgets stylisés
/// - Une galerie de couleurs du ColorScheme
/// - Des exemples de typographie
/// - Des composants interactifs
///
/// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ============================================================================
// ÉTAPE 1 : DÉFINIR LES THÈMES PERSONNALISÉS
// ============================================================================
/// 
/// Créer une classe centralisée pour tous les thèmes de l'application.
/// Cela permet de maintenir la cohérence et facilite les modifications globales.
///

class AppThemes {
  // ========================================================================
  // THÈME CLAIR (Light Theme)
  // ========================================================================
  /// 
  /// Le thème clair utilise des couleurs claires avec du texte sombre.
  /// Idéal pour une utilisation en plein jour.
  ///
  static ThemeData get lightTheme {
    return ThemeData(
      // Activer Material Design 3
      useMaterial3: true,
      
      // Définir la luminosité
      brightness: Brightness.light,
      
      // ColorScheme généré à partir d'une couleur de départ (seed color)
      // Material Design 3 génère automatiquement une palette cohérente
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      
      // Couleur de fond du Scaffold
      scaffoldBackgroundColor: Colors.white,
      
      // Typographie personnalisée
      textTheme: TextTheme(
        // Titre très grand
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        // Titre moyen
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        // Texte normal
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
        // Texte petit
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.black54,
        ),
      ),
      
      // Style de la barre d'application
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      
      // Style des boutons élevés
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // Style des boutons de texte
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
        ),
      ),
      
      // Style des champs de texte
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  // ========================================================================
  // THÈME SOMBRE (Dark Theme)
  // ========================================================================
  /// 
  /// Le thème sombre utilise des couleurs sombres avec du texte clair.
  /// Idéal pour une utilisation en faible luminosité ou selon les préférences.
  ///
  static ThemeData get darkTheme {
    return ThemeData(
      // Activer Material Design 3
      useMaterial3: true,
      
      // Définir la luminosité
      brightness: Brightness.dark,
      
      // ColorScheme généré avec brightness: dark
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      
      // Couleur de fond du Scaffold (gris très sombre)
      scaffoldBackgroundColor: Color(0xFF121212),
      
      // Typographie personnalisée
      textTheme: TextTheme(
        // Titre très grand
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        // Titre moyen
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        // Texte normal
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.white70,
        ),
        // Texte petit
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.white54,
        ),
      ),
      
      // Style de la barre d'application
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      
      // Style des boutons élevés
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // Style des boutons de texte
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue[300],
        ),
      ),
      
      // Style des champs de texte
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF2C2C2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}

// ============================================================================
// ÉTAPE 2 : CRÉER LE CONTRÔLEUR DE THÈME
// ============================================================================
/// 
/// Un ValueNotifier pour gérer l'état du thème et permettre le changement
/// dynamique sans utiliser un gestionnaire d'état complexe.
///

final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

// ============================================================================
// ÉTAPE 3 : APPLICATION PRINCIPALE
// ============================================================================

void main() {
  runApp(const ThemesDesignApp());
}

class ThemesDesignApp extends StatelessWidget {
  const ThemesDesignApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder écoute les changements du thème
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Themes & Design Demo',
          
          // Appliquer les thèmes personnalisés
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeMode,
          
          home: const ThemesDesignDemoScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

// ============================================================================
// ÉTAPE 4 : ÉCRAN DE DÉMONSTRATION
// ============================================================================

class ThemesDesignDemoScreen extends StatefulWidget {
  const ThemesDesignDemoScreen({Key? key}) : super(key: key);

  @override
  State<ThemesDesignDemoScreen> createState() => _ThemesDesignDemoScreenState();
}

class _ThemesDesignDemoScreenState extends State<ThemesDesignDemoScreen> {
  // Variable pour contrôler le mode d'affichage
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Themes & Design'),
        actions: [
          // Bouton pour basculer le thème
          IconButton(
            icon: Icon(
              themeModeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              themeModeNotifier.value =
                  themeModeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            },
            tooltip: 'Basculer le thème',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================================================================
              // SECTION 1 : TYPOGRAPHIE
              // ================================================================
              Text(
                'Typographie',
                style: theme.textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Titre Large',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Texte normal avec le style bodyMedium',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Texte petit avec le style bodySmall',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 32),

              // ================================================================
              // SECTION 2 : PALETTE DE COULEURS (ColorScheme)
              // ================================================================
              Text(
                'Palette de Couleurs (ColorScheme)',
                style: theme.textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              _buildColorPalette(context, colorScheme),
              const SizedBox(height: 32),

              // ================================================================
              // SECTION 3 : COMPOSANTS INTERACTIFS
              // ================================================================
              Text(
                'Composants Interactifs',
                style: theme.textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              
              // Boutons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bouton Elevated cliqué!'),
                        ),
                      );
                    },
                    child: const Text('Elevated'),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Outlined'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Text'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Champ de texte
              TextField(
                decoration: InputDecoration(
                  labelText: 'Champ de texte personnalisé',
                  hintText: 'Entrez du texte',
                  prefixIcon: const Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 32),

              // ================================================================
              // SECTION 4 : CARTES (Cards)
              // ================================================================
              Text(
                'Cartes Stylisées',
                style: theme.textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Carte Material Design 3',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Cette carte démontre le style Material Design 3 '
                        'avec une élévation et une ombre appropriées.',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Action'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // ================================================================
              // SECTION 5 : INFORMATION SUR LE THÈME
              // ================================================================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information sur le Thème',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Thème actuel : ${themeModeNotifier.value == ThemeMode.light ? "Clair" : "Sombre"}',
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Brightness : ${theme.brightness == Brightness.light ? "Light" : "Dark"}',
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Material 3 : ${theme.useMaterial3 ? "Activé" : "Désactivé"}',
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // WIDGET POUR AFFICHER LA PALETTE DE COULEURS
  // ========================================================================
  Widget _buildColorPalette(BuildContext context, ColorScheme colorScheme) {
    return Column(
      children: [
        // Première ligne de couleurs
        Row(
          children: [
            _buildColorBox('Primary', colorScheme.primary),
            const SizedBox(width: 8),
            _buildColorBox('Secondary', colorScheme.secondary),
            const SizedBox(width: 8),
            _buildColorBox('Tertiary', colorScheme.tertiary),
          ],
        ),
        const SizedBox(height: 8),
        // Deuxième ligne de couleurs
        Row(
          children: [
            _buildColorBox('Surface', colorScheme.surface),
            const SizedBox(width: 8),
            _buildColorBox('Error', colorScheme.error),
            const SizedBox(width: 8),
            _buildColorBox('Background', colorScheme.background),
          ],
        ),
      ],
    );
  }

  // ========================================================================
  // WIDGET POUR AFFICHER UNE BOÎTE DE COULEUR
  // ========================================================================
  Widget _buildColorBox(String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// RÉSUMÉ - POINTS CLÉS DÉMONTRÉS
// ============================================================================
/// 
/// 1. THÈMES PERSONNALISÉS
///    - Classe AppThemes centralisée
///    - Thèmes clair et sombre séparés
///    - Utilisation de Material Design 3
///
/// 2. CHANGEMENT DYNAMIQUE DE THÈME
///    - ValueNotifier pour gérer l'état du thème
///    - ValueListenableBuilder pour reconstruire l'app
///    - Bouton dans l'AppBar pour basculer
///
/// 3. MATERIAL DESIGN 3
///    - useMaterial3: true
///    - ColorScheme.fromSeed() pour palette automatique
///    - Couleurs cohérentes et accessibles
///
/// 4. PERSONNALISATION UI
///    - TextTheme personnalisé
///    - AppBarTheme personnalisé
///    - ElevatedButtonTheme personnalisé
///    - InputDecorationTheme personnalisé
///
/// 5. COMPOSANTS STYLISÉS
///    - Boutons (Elevated, Outlined, Text)
///    - Champs de texte
///    - Cartes (Cards)
///    - Conteneurs avec couleurs du ColorScheme
///
/// 6. ACCESSIBILITÉ
///    - Contraste suffisant entre texte et fond
///    - Couleurs sémantiques (primary, secondary, error)
///    - Support du mode sombre
///
/// ============================================================================

