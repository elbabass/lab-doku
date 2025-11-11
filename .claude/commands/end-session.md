---
description: Termine la session en cours avec rétro et préparation session suivante
---

# Terminer la session de développement en cours

Je vais terminer la session de développement en cours en suivant la phase REFLECT du cycle RED → GREEN → REFACTO → REFLECT.

## Actions à effectuer

1. **Identifier la session en cours** :
   - Trouver le dernier fichier de tests dans `docs/workflow/tests/`
   - Récupérer les objectifs définis

2. **Générer la rétrospective** :
   - Créer `docs/workflow/retros/YYYYMMDD_NN.md` basé sur le template
   - Remplir toutes les sections :
     - Objectifs complétés vs non complétés
     - Chronologie (RED/GREEN/REFACTO/REFLECT) avec durées
     - Ce qui a bien fonctionné
     - Difficultés rencontrées
     - Apprentissages
     - Problèmes identifiés pour sessions suivantes
     - Décisions techniques prises
     - Métriques (fichiers, commits, tests)
     - Notes pour la prochaine session

3. **Vérifier l'état final** :
   - Lancer le linter markdown : `npx markdownlint-cli2 "**/*.md"`
   - Vérifier l'état git : `git status`
   - Lister les commits de la session : `git log --oneline -N` (N = nombre de commits)

4. **Proposer le(s) commit(s)** :
   - Analyser les changements effectués
   - Suggérer le(s) message(s) de commit approprié(s) (feat/fix/refactor/test/docs/wip)
   - Format : `<type>: <description courte>`
   - **IMPORTANT** : Pas de signature AI dans les commits

5. **Interagir avec l'utilisateur** :
   - Lister des questions ouvertes concernant l'amélioration, avec comme exemples :
     - Que faudrait-il arrêter de faire ?
     - Que pourrions-nous commencer à faire ?
     - Qu'est-ce qu'il faut continuer à faire ?

6. **Créer le fichier de tests pour la session suivante** :
   - Numéro de session suivant (incrémenter)
   - Remplir avec les problèmes identifiés pendant cette session
   - Priorités HAUTE/MOYENNE/BASSE
   - Estimer durée et complexité

## Format de sortie attendu

```markdown
# Rétro Session YYYYMMDD_NN

## Résumé

- Durée réelle : XX min
- Objectifs complétés : X/Y
- Commits effectués : N

## Ce qui a bien fonctionné ✅

- [Liste des points positifs]

## Difficultés rencontrées ⚠️

- [Liste des difficultés]

## Apprentissages 💡

- [Liste des apprentissages]

## Problèmes pour sessions suivantes

- [Liste des nouveaux problèmes identifiés]

## Commits suggérés

```bash
# Commit 1
git add [fichiers]
git commit -m "type: description"

# Commit 2 (si applicable)
git add [fichiers]
git commit -m "type: description"
```

## Prochaine session

**Objectifs prioritaires** :

1. [Objectif 1]
2. [Objectif 2]

**Durée estimée** : XX-XX min

## Feedback utilisateur

---

✅ Fichier de rétro créé : `docs/workflow/retros/YYYYMMDD_NN.md`
✅ Fichier de tests suivant créé : `docs/workflow/tests/YYYYMMDD_(NN+1).md`

```

Dois-je procéder aux commits suggérés ?
