// debug_inspector.dart
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Widget de debug : wrap ta HomeScreen avec DebugInspector(child: HomeScreen())
/// Exécute des contrôles post-frame et affiche un overlay avec les warnings.
class DebugInspector extends StatefulWidget {
  final Widget child;
  const DebugInspector({super.key, required this.child});

  @override
  State<DebugInspector> createState() => _DebugInspectorState();
}

class _DebugInspectorState extends State<DebugInspector> {
  final List<String> _warnings = [];

  @override
  void initState() {
    super.initState();
    // Ne faire les checks qu'en mode debug (pas en release).
    assert(() {
      WidgetsBinding.instance.addPostFrameCallback((_) => _runChecks());
      return true;
    }());
  }

  void _addWarning(String s) {
    // Eviter doublons
    if (!_warnings.contains(s)) {
      setState(() => _warnings.add(s));
      debugPrint('🔴 DebugInspector: $s');
    }
  }

  void _runChecks() {
    // Récupère la racine de l'arbre d'éléments (peut être null dans certains cas)
    final Element? root = WidgetsBinding.instance.renderViewElement;
    if (root == null) {
      _addWarning('Impossible de récupérer le renderViewElement (root == null).');
      return;
    }

    // 1) Trouver le Scaffold racine / utilisé (celui le plus proche du widget enfant)
    final scaffoldWidget = context.findAncestorWidgetOfExactType<Scaffold>()
        ?? _findFirstWidgetOfType<Scaffold>(root);
    if (scaffoldWidget == null) {
      _addWarning('Aucun Scaffold détecté autour du DebugInspector — l\'AppBar ne pourra pas apparaître.');
    } else {
      // Vérifier extendBodyBehindAppBar
      if (scaffoldWidget.extendBodyBehindAppBar == true) {
        _addWarning('Scaffold.extendBodyBehindAppBar = true. Si ton AppBar est transparent, le body risque de le recouvrir.');
      }
      // Vérifier s'il y a un appBar dans ce Scaffold (attention : il n\'est pas toujours accessible ici)
      // On va rechercher des AppBar dans l'arbre.
    }

    // 2) Rechercher AppBar(s) dans l'arbre
    final appbars = <AppBar>[];
    _traverse(root, (el) {
      if (el.widget is AppBar) appbars.add(el.widget as AppBar);
    });

    if (appbars.isEmpty) {
      _addWarning('Aucun AppBar trouvé dans l\'arbre. Vérifie que tu fournis bien un AppBar (CustomAppBar doit retourner un AppBar).');
    } else {
      for (var i = 0; i < appbars.length; i++) {
        final ab = appbars[i];
        final bg = ab.backgroundColor;
        if (bg == Colors.transparent) {
          _addWarning('AppBar #${i + 1} => backgroundColor = transparent -> risque d\'être masquée si body est plein écran.');
        } else {
          debugPrint('🔵 AppBar #${i + 1} backgroundColor = $bg');
        }
      }
    }

    // 3) Rechercher TextField sans ancêtre Material/Scaffold (cause No Material widget found)
    final List<Element> textFields = <Element>[];
    _traverse(root, (el) {
      final w = el.widget;
      if (w is TextField || w is EditableText) textFields.add(el);
    });

    for (final tfEl in textFields) {
      final hasMaterialAncestor = _hasAncestorOfType(tfEl, (t) =>
          t is Material || t is Scaffold || t is Card || t is Dialog || t is Drawer);
      if (!hasMaterialAncestor) {
        _addWarning('TextField trouvé sans ancêtre Material/Scaffold/Card/Dialog/Drawer. Causant possible "No Material widget found".');
      }
    }

    // 4) Rechercher Scaffold imbriqués (autres Scaffold que le Scaffold principal)
    final List<Element> scaffolds = <Element>[];
    _traverse(root, (el) {
      if (el.widget is Scaffold) scaffolds.add(el);
    });

    if (scaffolds.length > 1) {
      // Trouver "scaffolds" qui ne sont pas le Scaffold parent le plus haut
      _addWarning('Plusieurs Scaffold détectés (${scaffolds.length}). Un Scaffold enfant peut recouvrir l\'AppBar du parent.');
    }

    // 5) Rechercher widgets fréquemment problématiques : MediaQuery manquant, etc.
    final hasMediaQuery = _findFirstWidgetOfType<MediaQuery>(root) != null;
    if (!hasMediaQuery) {
      _addWarning('MediaQuery introuvable — à vérifier (généralement fourni par MaterialApp).');
    }

    // Résumé minimal si aucune alerte
    if (_warnings.isEmpty) debugPrint('✅ DebugInspector : aucune anomalie évidente détectée.');
  }

  // Helper : traverse l'arbre d'éléments récursivement
  void _traverse(Element el, void Function(Element) callback) {
    callback(el);
    el.visitChildElements((child) => _traverse(child, callback));
  }

  // Helper : trouve le premier widget du type T sous root (descendant)
  T? _findFirstWidgetOfType<T extends Widget>(Element root) {
    T? result;
    _traverse(root, (el) {
      if (result != null) return;
      final w = el.widget;
      if (w is T) result = w as T;
    });
    return result;
  }

  // Helper : check ancestor types for a given element
  bool _hasAncestorOfType(Element el, bool Function(Widget) predicate) {
    Element? cur = el;
    while (true) {
      final parent = _getParentElement(cur!);
      if (parent == null) return false;
      if (predicate(parent.widget)) return true;
      cur = parent;
    }
  }

  Element? _getParentElement(Element el) {
    Element? parent;
    el.visitAncestorElements((anc) {
      parent = anc;
      return false; // stop at first
    });
    return parent;
  }

  @override
  Widget build(BuildContext context) {
    // Overlay qui montre les warnings (debug only)
    return Stack(
      children: [
        widget.child,
        // n'afficher le panneau que si on est en mode debug
        if (kDebugMode && _warnings.isNotEmpty)
          Positioned(
            right: 12,
            top: MediaQuery.of(context).padding.top + 12,
            child: _WarningCard(warnings: _warnings),
          ),
      ],
    );
  }
}

class _WarningCard extends StatelessWidget {
  final List<String> warnings;
  const _WarningCard({required this.warnings});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 360),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.95),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black26)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              const Icon(Icons.bug_report, color: Colors.white),
              const SizedBox(width: 8),
              Text('DebugInspector', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 6),
            ...warnings.map((w) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.white70, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(w, style: const TextStyle(color: Colors.white, fontSize: 12))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
