# Description

## Résumé des changements

<!-- Décris en 2-3 phrases ce que cette PR accomplit -->

## Contexte et motivation

<!-- Pourquoi ces changements sont nécessaires ? Quel problème résout cette PR ? -->
<!-- Lien vers issue(s) si applicable : Fixes #123 -->

## Type de changement

<!-- Coche toutes les cases applicables -->

- [ ] 🐛 Bug fix (correction d'un bug existant)
- [ ] ✨ Feature (nouvelle fonctionnalité)
- [ ] ♻️ Refactoring (amélioration du code sans changer le comportement)
- [ ] 📚 Documentation (mise à jour de la documentation uniquement)
- [ ] ✅ Tests (ajout ou amélioration de tests)
- [ ] 🔧 Chore (tâches diverses : config, assets, etc.)

## Changements détaillés

## Fonctionnalités ajoutées/modifiées

<!-- Liste des fonctionnalités impactées -->

- Feature 1 : Description
- Feature 2 : Description

## Fichiers principaux

<!-- Liste des fichiers créés/modifiés les plus importants -->

### Créés

- `scripts/xxx.gd` - Description du rôle
- `scenes/xxx.tscn` - Description de la scène

### Modifiés

- `scripts/yyy.gd` - Description des modifications
- `docs/zzz.md` - Documentation mise à jour

## Architecture

<!-- Si applicable, décris les changements architecturaux -->

- Pattern utilisé : Description
- Nouveaux signaux/événements : Liste
- Impact sur l'architecture existante : Description

## Tests

### Tests effectués

<!-- Décris les tests qui ont été effectués -->

#### Tests unitaires

- [ ] `test_xxx.gd` - X tests ajoutés/modifiés
- [ ] `test_yyy.gd` - X tests ajoutés/modifiés
- [ ] Tous les tests unitaires passent : ✅ / ❌

#### Tests manuels

<!-- Décris les scénarios testés manuellement -->

1. **Scénario 1** : Description
   - Étapes : 1) Action A, 2) Action B
   - Résultat attendu : Description
   - Résultat obtenu : ✅ OK / ❌ Problème

2. **Scénario 2** : Description
   - Étapes : 1) Action A, 2) Action B
   - Résultat attendu : Description
   - Résultat obtenu : ✅ OK / ❌ Problème

#### Tests d'intégration

<!-- Si applicable -->

- [ ] Test intégration X : Description + résultat
- [ ] Test intégration Y : Description + résultat

### Environnement de test

- **OS** : macOS / Windows / Linux
- **Godot version** : 4.x.x
- **Configuration** : Standard / Spécifique (détails)

## Checklist pré-merge

### Code

- [ ] Le code respecte les conventions ([`docs/godot/CONVENTIONS.md`](docs/godot/CONVENTIONS.md))
- [ ] Les fonctions publiques sont documentées
- [ ] Pas de code dupliqué (DRY appliqué)
- [ ] Pas de valeurs "magic numbers" (constantes utilisées)
- [ ] Typage fort appliqué (fonctions publiques)

### Tests

- [ ] Tous les tests unitaires passent
- [ ] Tests manuels effectués et OK
- [ ] Pas de régression détectée
- [ ] Nouveaux tests ajoutés pour nouvelles features

### Documentation

- [ ] Documentation mise à jour (`README.md`, `docs/*`)
- [ ] Commentaires de code ajoutés si nécessaire
- [ ] Changements architecturaux documentés

### Qualité

- [ ] Linter markdown passe (0 erreurs) : `npx markdownlint-cli2 "**/*.md"`
- [ ] Projet Godot se lance sans erreurs
- [ ] Pas de warnings Godot (ou justifiés dans la PR)
- [ ] Performance vérifiée (pas de lag introduit)

### Git

- [ ] Messages de commits suivent la convention (`type: description`)
- [ ] Pas de commits WIP non résolus
- [ ] Branche à jour avec `main` (rebase si nécessaire)
- [ ] Conflits résolus (si applicable)

### Autres

- [ ] Pas de fichiers sensibles commités (`.env`, credentials, etc.)
- [ ] Assets ajoutés sont optimisés (taille raisonnable)
- [ ] Pas de `print()` ou `print_debug()` oubliés dans le code final

## Captures d'écran / Vidéos

<!-- Si applicable, ajoute des captures d'écran ou vidéos montrant les changements visuels -->

### Avant

<!-- Capture d'écran de l'état avant les changements -->

### Après

<!-- Capture d'écran de l'état après les changements -->

## Notes pour les reviewers

<!-- Indique aux reviewers les points d'attention particuliers -->

- Point d'attention 1 : Description
- Point d'attention 2 : Description
- Questions ouvertes : Liste de questions si incertain sur certains choix

## Breaking changes

<!-- Si cette PR introduit des breaking changes (incompatibilités) -->

- [ ] Pas de breaking changes
- [ ] Breaking changes présents (détails ci-dessous)

<!-- Si oui, décris les breaking changes et les migrations nécessaires -->

### Migration nécessaire

<!-- Étapes pour migrer le code existant si breaking changes -->

1. Étape 1 : Description
2. Étape 2 : Description

## Dépendances

<!-- Cette PR dépend-elle d'autres PRs ou issues ? -->

- Dépend de : #XXX (lien vers PR/issue)
- Bloque : #YYY (lien vers PR/issue)
- Lié à : #ZZZ (lien vers PR/issue)

---

**Phase** : phase-X-nom (si applicable)
**Session(s)** : Session XX, YY (si applicable)
**Temps de développement** : X heures / X sessions
