---
description: Vérifie que le projet Godot compile et se lance sans erreurs
---

# Vérifier le projet Godot

Je vais vérifier que le projet Godot compile correctement et se lance sans erreurs.

## Actions à effectuer

1. **Vérifier que le projet Godot existe** :
   - Chercher le fichier `project.godot` à la racine
   - Si absent : Informer que le projet n'est pas encore initialisé
   - Si présent : Continuer les vérifications

2. **Lancer la vérification headless** (sans interface) :

   ```bash
   godot --headless --check-only --path .
   ```

   **Note** : Cette commande vérifie que le projet peut se charger sans erreurs fatales.

3. **Analyser les erreurs/warnings** :
   - **Erreurs** : Problèmes bloquants qui empêchent le lancement
   - **Warnings** : Problèmes non bloquants mais à résoudre
   - Grouper par type et fichier source

4. **Exécuter les tests unitaires** (si disponibles) :

   ```bash
   godot --headless --script tests/run_tests.gd
   ```

   **Note** : Uniquement si le framework de tests (Gut) est installé et configuré.

5. **Vérifier la structure du projet** :
   - Présence des dossiers essentiels : `scripts/`, `scenes/`, `assets/`
   - Autoloads configurés : GameManager, EventBus
   - Scènes principales créées

## Format de sortie attendu

### Si projet non initialisé

```
⚠️ Projet Godot non initialisé

Le fichier `project.godot` n'existe pas encore.
Le projet est actuellement en phase de spécifications.

Pour initialiser le projet Godot :
1. Ouvrir Godot 4.x
2. Créer un nouveau projet dans ce dossier
3. Configurer les autoloads (voir docs/godot/ARCHITECTURE.md)
4. Créer la structure de dossiers (voir docs/godot/CONVENTIONS.md)
```

### Si projet OK

```
✅ Projet Godot - Aucune erreur

- Compilation : OK
- Warnings : 0
- Erreurs : 0
- Tests unitaires : X/X passants (si disponibles)

## Structure vérifiée

- [x] project.godot
- [x] scripts/autoloads/
- [x] scripts/game/
- [x] scenes/
- [x] Autoloads configurés : GameManager, EventBus

Le projet est prêt pour le développement.
```

### Si erreurs détectées

```
❌ Projet Godot - Erreurs détectées

## Erreurs (bloquantes)

- `scripts/game/grid_manager.gd:42` : Syntax error - Expected ')'
- `scenes/main.tscn` : Cannot load scene - Missing dependency

## Warnings (non bloquants)

- `scripts/autoloads/game_manager.gd:15` : Unused variable 'temp'
- `scripts/game/player_controller.gd:67` : Function declared but not used

## Tests unitaires

- Total : X tests
- Passants : Y
- Échoués : Z
  - test_sudoku_validator:42 : Expected true, got false

## Actions recommandées

1. Corriger les erreurs de syntaxe dans grid_manager.gd:42
2. Vérifier les dépendances de main.tscn
3. Nettoyer les variables/fonctions inutilisées
4. Fixer les tests échoués

Dois-je t'aider à corriger ces problèmes ?
```

## Notes

- Cette commande nécessite que Godot 4.x soit installé et accessible via `godot` en ligne de commande
- Si Godot n'est pas dans le PATH, ajuster la commande avec le chemin complet
- Les tests unitaires nécessitent le framework Gut installé
