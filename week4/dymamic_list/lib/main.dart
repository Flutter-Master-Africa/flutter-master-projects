/// ============================================================================
/// FLUTTER DYNAMIC LISTS & DISPLAY EXPLORATION PROJECT
/// ============================================================================
/// 
/// Cette application démontre les concepts clés des listes dynamiques et
/// de l'affichage en Flutter, incluant :
/// 
/// 1. ListView - Listes linéaires
///    - ListView simple
///    - ListView.builder (lazy loading)
///    - ListView.separated (avec séparateurs)
/// 
/// 2. GridView - Grilles bidimensionnelles
///    - GridView.count (nombre fixe de colonnes)
///    - GridView.builder (lazy loading)
/// 
/// 3. Chargement dynamique (Infinite Scrolling)
///    - Détection de la fin de la liste
///    - Chargement asynchrone de données
///    - Indicateur de chargement
///    - Gestion des erreurs
/// 
/// 4. Bonnes pratiques
///    - Performance avec les grandes listes
///    - Gestion d'état
///    - Accessibilité
///
/// ============================================================================

import 'package:flutter/material.dart';

// ============================================================================
// ÉTAPE 1 : MODÈLE DE DONNÉES
// ============================================================================
/// 
/// Créer une classe simple pour représenter les données affichées.
/// Dans une vraie application, ces données viendraient d'une API.
///

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String category;
  final int imageColor; // Couleur pour simuler une image

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageColor,
  });

  // Méthode factory pour générer des produits de test
  factory Product.generate(int index) {
    final colors = [
      Colors.blue.value,
      Colors.red.value,
      Colors.green.value,
      Colors.orange.value,
      Colors.purple.value,
      Colors.pink.value,
    ];
    
    return Product(
      id: index,
      name: 'Produit ${index + 1}',
      description: 'Description du produit ${index + 1}',
      price: (index + 1) * 10.0 + 99,
      category: ['Électronique', 'Vêtements', 'Livres', 'Maison'][index % 4],
      imageColor: colors[index % colors.length],
    );
  }
}

// ============================================================================
// ÉTAPE 2 : APPLICATION PRINCIPALE
// ============================================================================

void main() {
  runApp(const DynamicListsApp());
}

class DynamicListsApp extends StatelessWidget {
  const DynamicListsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Lists & Display',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DynamicListsDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// ÉTAPE 3 : ÉCRAN DE DÉMONSTRATION
// ============================================================================

class DynamicListsDemoScreen extends StatefulWidget {
  const DynamicListsDemoScreen({Key? key}) : super(key: key);

  @override
  State<DynamicListsDemoScreen> createState() => _DynamicListsDemoScreenState();
}

class _DynamicListsDemoScreenState extends State<DynamicListsDemoScreen> {
  // Index de l'onglet sélectionné
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listes Dynamiques & Affichage'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          // Onglet 1 : ListView
          const ListViewDemoTab(),
          
          // Onglet 2 : GridView
          const GridViewDemoTab(),
          
          // Onglet 3 : Chargement dynamique
          const DynamicLoadingDemoTab(),
        ],
      ),
      // Navigation par onglets
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'ListView',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_3x3),
            label: 'GridView',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_download),
            label: 'Chargement',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ONGLET 1 : DÉMONSTRATION DE LISTVIEW
// ============================================================================
/// 
/// Cet onglet démontre les trois variantes principales de ListView :
/// - ListView simple
/// - ListView.builder (lazy loading)
/// - ListView.separated (avec séparateurs)
///

class ListViewDemoTab extends StatelessWidget {
  const ListViewDemoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Générer une liste de produits
    final products = List.generate(50, (index) => Product.generate(index));

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // Barre d'onglets
          TabBar(
            tabs: const [
              Tab(text: 'Simple'),
              Tab(text: 'Builder'),
              Tab(text: 'Separated'),
            ],
          ),
          // Contenu des onglets
          Expanded(
            child: TabBarView(
              children: [
                // ============================================================
                // LISTVIEW SIMPLE
                // ============================================================
                /// 
                /// ListView simple : tous les éléments sont rendus à l'avance.
                /// À utiliser uniquement pour les petites listes.
                ///
                ListView(
                  children: products.take(10).map((product) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(product.imageColor),
                        child: Text('${product.id + 1}'),
                      ),
                      title: Text(product.name),
                      subtitle: Text(product.category),
                      trailing: Text('${product.price.toStringAsFixed(2)} €'),
                    );
                  }).toList(),
                ),

                // ============================================================
                // LISTVIEW.BUILDER
                // ============================================================
                /// 
                /// ListView.builder : construction à la demande (lazy loading).
                /// Idéal pour les grandes listes ou listes infinies.
                /// Seuls les éléments visibles sont rendus.
                ///
                ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(product.imageColor),
                        child: Text('${product.id + 1}'),
                      ),
                      title: Text(product.name),
                      subtitle: Text(product.description),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} sélectionné'),
                          ),
                        );
                      },
                    );
                  },
                ),

                // ============================================================
                // LISTVIEW.SEPARATED
                // ============================================================
                /// 
                /// ListView.separated : comme builder, mais avec séparateurs.
                /// Améliore visuellement la distinction entre les éléments.
                ///
                ListView.separated(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(product.imageColor),
                        child: Text('${product.id + 1}'),
                      ),
                      title: Text(product.name),
                      subtitle: Text('${product.price.toStringAsFixed(2)} €'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                      color: Colors.grey[300],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ONGLET 2 : DÉMONSTRATION DE GRIDVIEW
// ============================================================================
/// 
/// Cet onglet démontre les deux variantes principales de GridView :
/// - GridView.count (nombre fixe de colonnes)
/// - GridView.builder (lazy loading)
///

class GridViewDemoTab extends StatelessWidget {
  const GridViewDemoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Générer une liste de produits
    final products = List.generate(50, (index) => Product.generate(index));

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // Barre d'onglets
          TabBar(
            tabs: const [
              Tab(text: 'Count'),
              Tab(text: 'Builder'),
            ],
          ),
          // Contenu des onglets
          Expanded(
            child: TabBarView(
              children: [
                // ============================================================
                // GRIDVIEW.COUNT
                // ============================================================
                /// 
                /// GridView.count : nombre fixe de colonnes.
                /// Idéal pour les grilles simples avec un nombre connu d'éléments.
                ///
                GridView.count(
                  crossAxisCount: 2, // 2 colonnes
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  padding: const EdgeInsets.all(8),
                  children: products.take(20).map((product) {
                    return _buildGridItem(product);
                  }).toList(),
                ),

                // ============================================================
                // GRIDVIEW.BUILDER
                // ============================================================
                /// 
                /// GridView.builder : construction à la demande.
                /// Idéal pour les grandes grilles ou grilles infinies.
                ///
                GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 colonnes
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.0,
                  ),
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildGridItem(product);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour afficher un élément de grille
  Widget _buildGridItem(Product product) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(product.imageColor),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${product.id + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${product.price.toStringAsFixed(2)} €',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ONGLET 3 : DÉMONSTRATION DU CHARGEMENT DYNAMIQUE
// ============================================================================
/// 
/// Cet onglet démontre le chargement dynamique de données (infinite scrolling).
/// Les données sont chargées progressivement à mesure que l'utilisateur
/// fait défiler la liste.
///

class DynamicLoadingDemoTab extends StatefulWidget {
  const DynamicLoadingDemoTab({Key? key}) : super(key: key);

  @override
  State<DynamicLoadingDemoTab> createState() => _DynamicLoadingDemoTabState();
}

class _DynamicLoadingDemoTabState extends State<DynamicLoadingDemoTab> {
  // Liste des produits chargés
  final List<Product> _products = [];
  
  // Contrôleur de défilement pour détecter la fin de la liste
  late ScrollController _scrollController;
  
  // Indicateur de chargement en cours
  bool _isLoading = false;
  
  // Indicateur s'il y a plus de données à charger
  bool _hasMoreData = true;
  
  // Nombre total de produits à simuler
  static const int _totalProducts = 100;

  @override
  void initState() {
    super.initState();
    
    // Initialiser le contrôleur de défilement
    _scrollController = ScrollController();
    
    // Ajouter un écouteur pour détecter la fin de la liste
    _scrollController.addListener(_onScroll);
    
    // Charger les premiers produits
    _loadMoreProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ========================================================================
  // MÉTHODE POUR CHARGER PLUS DE PRODUITS
  // ========================================================================
  /// 
  /// Cette méthode simule le chargement de données depuis une API.
  /// Dans une vraie application, on ferait un appel HTTP ici.
  ///
  Future<void> _loadMoreProducts() async {
    // Vérifier s'il y a déjà un chargement en cours
    if (_isLoading || !_hasMoreData) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simuler un délai réseau (2 secondes)
      await Future.delayed(const Duration(seconds: 2));

      // Ajouter 10 nouveaux produits
      final newProducts = List.generate(
        10,
        (index) => Product.generate(_products.length + index),
      );

      setState(() {
        _products.addAll(newProducts);
        _isLoading = false;

        // Vérifier s'il y a plus de données à charger
        if (_products.length >= _totalProducts) {
          _hasMoreData = false;
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      // Afficher un message d'erreur
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors du chargement : $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // ========================================================================
  // MÉTHODE APPELÉE LORS DU DÉFILEMENT
  // ========================================================================
  /// 
  /// Cette méthode est appelée chaque fois que l'utilisateur fait défiler.
  /// Elle détecte si on est à la fin de la liste et déclenche le chargement.
  ///
  void _onScroll() {
    // Vérifier si on est à la fin de la liste
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      // Charger plus de produits
      _loadMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _products.isEmpty && !_isLoading
          ? // Afficher un message si aucun produit n'est chargé
          Center(
              child: ElevatedButton(
                onPressed: _loadMoreProducts,
                child: const Text('Charger les produits'),
              ),
            )
          : // Afficher la liste avec chargement dynamique
          ListView.separated(
              controller: _scrollController,
              itemCount: _products.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                // Afficher l'indicateur de chargement à la fin
                if (index == _products.length) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          'Chargement des produits...',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                }

                // Afficher un élément de la liste
                final product = _products[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(product.imageColor),
                    child: Text('${product.id + 1}'),
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text(
                    '${product.price.toStringAsFixed(2)} €',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: Colors.grey[300],
                );
              },
            ),
      floatingActionButton: _products.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                // Retourner au début de la liste
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}

// ============================================================================
// RÉSUMÉ - POINTS CLÉS DÉMONTRÉS
// ============================================================================
/// 
/// 1. LISTVIEW
///    - ListView simple : pour petites listes
///    - ListView.builder : lazy loading, idéal pour grandes listes
///    - ListView.separated : avec séparateurs visuels
///
/// 2. GRIDVIEW
///    - GridView.count : nombre fixe de colonnes
///    - GridView.builder : lazy loading pour grandes grilles
///    - Personnalisation de l'espacement et du ratio d'aspect
///
/// 3. CHARGEMENT DYNAMIQUE (Infinite Scrolling)
///    - ScrollController pour détecter la fin de la liste
///    - Chargement asynchrone de données
///    - Indicateur de chargement
///    - Gestion des erreurs
///    - Vérification s'il y a plus de données
///
/// 4. PERFORMANCE
///    - Lazy loading pour économiser les ressources
///    - Construction à la demande des éléments
///    - Gestion efficace de la mémoire
///
/// 5. UX/ACCESSIBILITÉ
///    - Feedback visuel pendant le chargement
///    - Messages d'erreur clairs
///    - Navigation fluide (FAB pour retourner au début)
///    - Séparateurs pour meilleure lisibilité
///
/// ============================================================================
