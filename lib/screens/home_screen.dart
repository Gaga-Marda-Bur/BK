import 'package:flutter/material.dart';
import 'demo_screen.dart';
import 'info_screen.dart';
import 'vocabulary_screen.dart';
import 'settings_screen.dart';
import 'favorites_screen.dart';
import 'quiz_screen.dart';
import 'gallery_screen.dart';
import 'history_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../constants/colors.dart';
import '../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<Widget> _screens;
  late List<String> _screenTitles; 
  late final List<IconData> _screenIcons;

  @override
  void initState() {
    super.initState();
    _screens = const [
      DemoScreen(),
      InfoScreen(),
      VocabularyScreen(),
      QuizScreen(),
      GalleryScreen(),
      HistoryScreen(),
      FavoritesScreen(),
      SettingsScreen(),
    ];

    _screenIcons = const [
      Icons.text_fields,
      Icons.info,
      Icons.book,
      Icons.quiz,
      Icons.photo_library,
      Icons.history,
      Icons.favorite,
      Icons.settings,
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final loc = AppLocalizations.of(context)!;
    _screenTitles = [
      loc.demo,
      loc.information,
      loc.vocabulary,
      loc.quiz,
      loc.gallery,
      loc.history,
      loc.favorites,
      loc.settings,
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
  }

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

@override
Widget build(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  final bool isLargeScreen = MediaQuery.of(context).size.width > 600;

  return Scaffold(
    key: _scaffoldKey,
    extendBodyBehindAppBar: false, // IMPORTANT: false
    backgroundColor: AppColors.darkGreen,
    appBar: CustomAppBar(
      title: _screenTitles[_selectedIndex],
      onMenuPressed: _openDrawer,
    ),
    drawer: isLargeScreen ? null : _buildDrawer(context, loc),
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.darkGreen, AppColors.darkerGreen],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      // SUPPRIMEZ le SafeArea et le Padding top
      child: _screens[_selectedIndex],
    ),
    bottomNavigationBar: isLargeScreen ? null : _buildBottomNavBar(loc),
  );
}

  Widget _buildDrawer(BuildContext context, AppLocalizations loc) {
    return Drawer(
      backgroundColor: AppColors.darkGreen,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.darkerGreen, AppColors.darkGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Beriya Erfe',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  loc.exploreZaghawa,
                  style: TextStyle(
                    color: AppColors.goldOpacity08,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(
            _screens.length,
            (index) => _buildDrawerItem(_screenIcons[index], _screenTitles[index], index),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    final bool selected = _selectedIndex == index;
    return ListTile(
      leading: Icon(icon, color: selected ? AppColors.gold : Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? AppColors.gold : Colors.white,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      selectedTileColor: AppColors.darkerGreenWithOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () => _onItemTapped(index),
    );
  }

 Widget _buildBottomNavBar(AppLocalizations loc) {
  final navItems = [
    {'icon': Icons.text_fields, 'label': loc.demo, 'index': 0},
    {'icon': Icons.book, 'label': loc.vocabulary, 'index': 2},
    {'icon': Icons.quiz, 'label': loc.quiz, 'index': 3},
    {'icon': Icons.info, 'label': loc.information, 'index': 1}, // ✅ correction ici
  ];

  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.darkGreen, AppColors.darkerGreen],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.blackOpacity05,
          spreadRadius: 1,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: BottomNavigationBar(
      items: navItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isSelected = _getCurrentBottomNavIndex(navItems) == index;

        return BottomNavigationBarItem(
          icon: Stack(
            children: [
              if (isSelected)
                Container(
                  width: 48,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.goldOpacity02,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    item['icon'] as IconData,
                    key: ValueKey<bool>(isSelected),
                    color: isSelected ? AppColors.gold : Colors.grey[300],
                    size: isSelected ? 26 : 24,
                  ),
                ),
              ),
              if (item['label'] == loc.quiz)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          ),
          label: item['label'] as String,
        );
      }).toList(),
      currentIndex: _getCurrentBottomNavIndex(navItems),
      onTap: (index) {
        _onItemTapped(navItems[index]['index'] as int); // ✅ plus besoin de condition
      },
      backgroundColor: Colors.transparent,
      selectedItemColor: AppColors.gold,
      unselectedItemColor: Colors.grey[300],
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 11,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
  );
}


  int _getCurrentBottomNavIndex(List<Map<String, dynamic>> navItems) {
    for (int i = 0; i < navItems.length; i++) {
      if (navItems[i]['index'] == _selectedIndex) {
        return i;
      }
    }
    return 0;
  }
}
