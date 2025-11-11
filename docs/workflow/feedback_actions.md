# Actions basées sur feedback utilisateur

Ce fichier liste les actions à prendre suite aux feedbacks utilisateur des sessions.

## Session 20251111_02 - Feedback du 2025-11-11

### 🛑 Arrêter

#### 1. Estimations à la place de statistiques

**Feedback** : "De mettre des estimations à la place de statistiques (exemple, section précédente "Durée estimée : 30-40 min" peut être remplacé par une évaluation basée sur la moyenne de durée des sessions équivalentes)"

**Actions** :

- [x] Corriger rétro session 02 pour retirer "Durée estimée"
- [ ] Documenter dans SESSIONS.md comment utiliser l'historique pour prédictions
- [ ] Mettre à jour templates pour utiliser "Durée de référence" au lieu de "Durée estimée"
- [ ] Ajouter section dans templates : "Sessions similaires : X min (moyenne)"

**Priorité** : HAUTE
**Complexité** : Simple
**Session cible** : Prochaine session refactoring docs

#### 2. Fichiers Markdown en UPPERCASE (sauf conventions)

**Feedback** : "De mettre tous les noms de fichier Markdown en MAJUSCULE [...] moins intéressant si cela est destiné à être lu par l'humain"

**Actions** :

- [x] Déjà documenté dans CONVENTIONS.md (migration progressive)
- [ ] Planifier migration progressive des fichiers existants
- [ ] Créer script de migration automatique (optionnel)
- [ ] Renommer fichiers prioritaires (docs les plus consultés)

**Priorité** : BASSE
**Complexité** : Simple
**Session cible** : Session refactoring future (non urgent)

### ▶️ Commencer

#### 1. Template prérempli de rétro avec questions

**Feedback** : "Créer le template prérempli de rétro avec les questions pour l'utilisateur"

**Actions** :

- [x] Templates mis à jour avec section feedback structurée
- [ ] Améliorer `/end-session` pour auto-remplir plus de sections
  - Git log automatique
  - Métriques calculées (fichiers, lignes, durée)
  - Liste des problèmes depuis fichier tests
- [ ] Ajouter génération automatique des commits effectués

**Priorité** : MOYENNE
**Complexité** : Moyenne
**Session cible** : Session amélioration workflow (Phase 1 ou 2)

#### 2. Tracking temps effectif vs temps pause (métriques Lean)

**Feedback** : "Noter la date et l'heure des interactions de l'utilisateur afin d'évaluer le temps de pause de celui-ci, et donc le temps réel effectif en plus du délai entre début et fin."

**Actions** :

- [ ] Rechercher mécanisme de hooks Claude Code pour timestamp interactions
- [ ] Explorer logging automatique des messages utilisateur avec timestamps
- [ ] Créer système de calcul : temps total - temps pause = temps effectif
- [ ] Ajouter métriques dans templates :
  - Durée totale (début → fin)
  - Temps effectif (sans pauses)
  - Nombre de pauses
  - Durée moyenne des pauses

**Priorité** : HAUTE (très utile pour métriques Lean)
**Complexité** : Moyenne-haute (nécessite recherche technique)
**Session cible** : Session dédiée recherche + implémentation (future)

**Notes** :

- Peut nécessiter hooks ou système externe
- Investiguer si Claude Code expose ces informations
- Alternative : demander à l'utilisateur de noter début/fin manuellement

#### 3. Migration snake_case/kebab-case pour Markdown

**Feedback** : "Utiliser plus souvent le snake_case ou le kebab-case pour les noms de fichiers Markdown, y compris ceux qui ont été créés comme cela dans le passé et qui devraient être renommé"

**Actions** :

- [ ] Lister tous les fichiers Markdown UPPERCASE actuels
- [ ] Prioritiser par fréquence d'accès (README, docs principaux, etc.)
- [ ] Créer plan de migration avec règles de nommage
- [ ] Exécuter migration par phases (éviter trop de renames simultanés)
- [ ] Mettre à jour tous les liens internes après migration

**Priorité** : MOYENNE
**Complexité** : Simple mais chronophage
**Session cible** : Session refactoring dédiée (après Phase 1 MVP)

**Fichiers concernés** (ordre de priorité) :

1. `EXECUTIVE_SUMMARY.md` → `executive_summary.md`
2. `CONTRIBUTING.md` → `contributing.md` (standard GitHub, garder?)
3. `docs/DESIGN_DOC.md` → `docs/design_doc.md`
4. `docs/PAPER_PROTOTYPE_TEST_RESULTS.md` → `docs/paper_prototype_test_results.md`
5. `docs/GODOT_PROTO_SPECS.md` → `docs/godot_proto_specs.md`

**Note** : `README.md` et `CLAUDE.md` restent UPPERCASE (convention GitHub/Claude Code)

### ✅ Continuer

**Feedbacks positifs** :

- ✅ Proposer des commits clairs et structurés
- ✅ Découper les todo de manière intelligible entre problèmes
- ✅ Donner recommandations sur suite et prochaines étapes
- ✅ Mettre des émojis avec parcimonie pour attirer l'attention

**Action** : Maintenir ces pratiques dans toutes les sessions futures.

## Prochaines étapes immédiates

1. **Commit ce feedback** (avec corrections rétro)
2. **Session suivante** : Implémenter Phase 1 MVP Core (GridManager, PlayerController, KeyManager)
3. **Session refactoring future** : Appliquer actions feedback (templates, migrations, métriques)

## Notes

- Ce fichier sera mis à jour après chaque session avec nouveau feedback
- Prioriser actions HAUTE avant de commencer nouvelles phases
- Actions BASSE peuvent être différées indéfiniment si non critiques
