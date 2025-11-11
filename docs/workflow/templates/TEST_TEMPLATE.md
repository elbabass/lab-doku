# Tests Session YYYYMMDD_N

**Date prévue** : YYYY-MM-DD
**Phase** : phase-X-nom
**Branche** : `phase-X-nom`
**Session précédente** : Session (N-1) (lien si applicable)

## Contexte

### État actuel du projet

- Dernière feature ajoutée : Description
- Derniers problèmes résolus : Liste courte
- WIP en cours : Description (si applicable)

### Dépendances

- [ ] Dépendance 1 : À résoudre avant cette session
- [ ] Dépendance 2 : Peut bloquer certains tests
- [x] Dépendance 3 : Déjà résolue

## Objectifs de la session

### Priorité HAUTE (obligatoires)

#### Problème 1 : Titre descriptif

**Description** :

Description détaillée du problème à résoudre ou de la feature à implémenter.

**Critères de succès** :

- [ ] Critère mesurable 1
- [ ] Critère mesurable 2
- [ ] Critère mesurable 3

**Tests à effectuer** :

- [ ] **Test unitaire** : `test_xxx.gd`
  - Fonction à tester : `xxx()`
  - Scénarios :
    - Cas nominal : entrée X → sortie Y
    - Edge case 1 : entrée Z → sortie W
    - Edge case 2 : entrée invalide → erreur

- [ ] **Test manuel** :
  1. Étape 1 : Action à effectuer
  2. Étape 2 : Action à effectuer
  3. Vérification : Résultat attendu

**Complexité estimée** : Simple / Moyen / Complexe

**Durée estimée** : X-X min

#### Problème 2 : Titre descriptif

**Description** :

Description détaillée du problème à résoudre ou de la feature à implémenter.

**Critères de succès** :

- [ ] Critère mesurable 1
- [ ] Critère mesurable 2

**Tests à effectuer** :

- [ ] **Test d'intégration** :
  - Scénario : Description du flux complet à tester
  - Étapes :
    1. Setup initial
    2. Action 1
    3. Action 2
    4. Vérification résultat final
  - Résultat attendu : Description

**Complexité estimée** : Simple / Moyen / Complexe

**Durée estimée** : X-X min

### Priorité MOYENNE (si temps disponible)

#### Problème 3 : Titre descriptif

**Description** : Description courte

**Critères de succès** :

- [ ] Critère 1
- [ ] Critère 2

**Tests** : Description rapide

**Durée estimée** : X min

### Priorité BASSE (nice-to-have)

- Problème 4 : Description en une ligne
- Problème 5 : Description en une ligne

## Plan d'action (RED phase)

### Séquence recommandée

1. **Commencer par Problème 1** (priorité haute, plus critique)
2. **Puis Problème 2** (priorité haute, dépend ou non de 1)
3. **Si temps restant** : Problème 3 (priorité moyenne)

### Temps alloué par problème

| Problème | RED  | GREEN | REFACTO | REFLECT | Total |
|----------|------|-------|---------|---------|-------|
| 1        | 3 min| 8 min | 3 min   | -       | 14 min|
| 2        | 2 min| 7 min | 2 min   | -       | 11 min|
| REFLECT  | -    | -     | -       | 3 min   | 3 min |
| **TOTAL**| 5 min| 15 min| 5 min   | 3 min   | **28 min** |

## Détails techniques

### Fichiers à créer/modifier

**Création prévue** :

- `scripts/xxx/yyy.gd` - Description du script
- `scenes/xxx/yyy.tscn` - Description de la scène
- `tests/unit/test_yyy.gd` - Tests pour le script

**Modification prévue** :

- `scripts/xxx/zzz.gd` - Modifications à apporter
- `scenes/xxx/zzz.tscn` - Modifications à apporter

### Fonctions à implémenter

#### Fonction 1 : `nom_fonction()`

```gdscript
func nom_fonction(param1: Type1, param2: Type2) -> ReturnType:
    ## Description de ce que fait la fonction.
    ##
    ## Args:
    ##     param1: Description du paramètre
    ##     param2: Description du paramètre
    ##
    ## Returns:
    ##     Description du retour
    pass
```

**Tests associés** :

- Test cas nominal
- Test edge case 1
- Test edge case 2

#### Fonction 2 : `autre_fonction()`

```gdscript
func autre_fonction(param: Type) -> ReturnType:
    ## Description
    pass
```

**Tests associés** :

- Test cas nominal

### Signaux à émettre/écouter

**Signaux à émettre** :

```gdscript
signal signal_name(param1: Type1, param2: Type2)
# Émis quand : Description de la condition
```

**Signaux à écouter** :

- `EventBus.xxx_signal` → Réaction : Description
- `OtherObject.yyy_signal` → Réaction : Description

### Constantes/Configuration

```gdscript
# Constantes à définir
const CONSTANT_NAME = value
const ANOTHER_CONSTANT = value
```

## Tests pré-définis

### Tests unitaires

#### Test 1 : `test_fonction_cas_nominal`

```gdscript
# tests/unit/test_xxx.gd
func test_fonction_cas_nominal():
    # Arrange
    var input = ...

    # Act
    var result = fonction(input)

    # Assert
    assert_eq(result, expected_value, "Description du test")
```

**Résultat attendu** : ✅ PASS

#### Test 2 : `test_fonction_edge_case`

```gdscript
func test_fonction_edge_case():
    # Arrange
    var input = edge_case_value

    # Act
    var result = fonction(input)

    # Assert
    assert_false(result, "Should handle edge case")
```

**Résultat attendu** : ✅ PASS

### Tests manuels

#### Test manuel 1 : Vérifier feature X

**Objectif** : S'assurer que la feature X fonctionne visuellement

**Étapes** :

1. Lancer le jeu (F5 dans Godot)
2. Naviguer vers la scène de test
3. Effectuer action X
4. Observer résultat Y

**Résultat attendu** :

- Comportement visuel : Description
- Pas d'erreurs dans la console
- Performance fluide (pas de lag)

**Checklist** :

- [ ] Action X déclenche comportement Y
- [ ] Pas d'erreurs console
- [ ] Performance OK

#### Test manuel 2 : Vérifier intégration Y

**Objectif** : Tester l'intégration entre composant A et B

**Étapes** :

1. Setup : Configuration initiale
2. Action 1 : Description
3. Vérification 1 : Résultat attendu
4. Action 2 : Description
5. Vérification 2 : Résultat attendu

**Résultat attendu** : Description du comportement global

**Checklist** :

- [ ] Intégration A→B fonctionne
- [ ] Signaux émis correctement
- [ ] État synchronisé

## Critères de complétion

### Définition of Done

Pour que cette session soit considérée comme complète, les conditions suivantes doivent être remplies :

- [ ] Tous les problèmes priorité HAUTE sont résolus OU en WIP documenté
- [ ] Tous les tests unitaires passent (✅ PASS)
- [ ] Tous les tests manuels sont OK
- [ ] Le projet Godot se lance sans erreurs
- [ ] Le code respecte les conventions (voir `docs/godot/CONVENTIONS.md`)
- [ ] Le linter markdown passe (0 erreurs)
- [ ] Au moins 1 commit effectué
- [ ] Rétro de session complétée

### Acceptable en WIP

Si les conditions suivantes sont remplies, un commit WIP est acceptable :

- [ ] Au moins 50% des problèmes priorité HAUTE sont avancés
- [ ] Le blocage est identifié et documenté
- [ ] Un plan de résolution est défini pour session suivante
- [ ] Le commit WIP a un message clair expliquant l'état

### Critères d'échec (reporter session)

La session doit être reportée si :

- [ ] Dépendances critiques non résolues
- [ ] Environnement de dev cassé (Godot ne lance pas)
- [ ] Blocage technique majeur nécessitant recherche approfondie

## Risques identifiés

### Risque 1 : Titre du risque

- **Probabilité** : Faible / Moyenne / Élevée
- **Impact** : Faible / Moyen / Élevé
- **Description** : Explication du risque
- **Mitigation** : Comment réduire/éviter le risque
- **Plan B** : Quoi faire si le risque se réalise

### Risque 2 : Titre du risque

- **Probabilité** : Faible / Moyenne / Élevée
- **Impact** : Faible / Moyen / Élevé
- **Description** : Explication du risque
- **Mitigation** : Comment réduire/éviter le risque
- **Plan B** : Quoi faire si le risque se réalise

## Notes de préparation

### Documentation à consulter

- [ ] Documentation Godot : [Lien vers section pertinente]
- [ ] Architecture projet : `docs/godot/ARCHITECTURE.md` (section X)
- [ ] Conventions : `docs/godot/CONVENTIONS.md` (section Y)
- [ ] Issue/discussion : [Lien si applicable]

### Questions à résoudre avant de commencer

1. Question 1 : Formulation de la question
   - Réponse : (à remplir en début de session)

2. Question 2 : Formulation de la question
   - Réponse : (à remplir en début de session)

### Setup nécessaire

- [ ] Ouvrir projet Godot
- [ ] Ouvrir terminal pour git/linter
- [ ] Ouvrir éditeur pour scripts
- [ ] Préparer environnement de test (si applicable)

## Backlog (problèmes futurs identifiés)

Problèmes découverts pendant la session précédente mais non traités :

- Problème identifié 1 : Description courte
- Problème identifié 2 : Description courte
- Amélioration potentielle : Description courte

Ces problèmes seront à intégrer dans les sessions futures.

---

**Fichier de tests créé le** : YYYY-MM-DD à HH:MM
**Session prévue pour le** : YYYY-MM-DD (ou "à définir")
**Durée estimée totale** : XX-XX min
**Complexité globale** : Simple / Moyenne / Élevée
