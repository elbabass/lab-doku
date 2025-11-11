---
description: Démarre une nouvelle session de développement avec préparation
---

# Démarrer une nouvelle session de développement

Je vais démarrer une nouvelle session de développement en suivant le workflow RED → GREEN → REFACTO → REFLECT.

## Actions à effectuer

1. **Créer le fichier de tests pour cette session** :
   - Identifier le numéro de session (format : `YYYYMMDD_NN`)
   - Créer `docs/workflow/tests/YYYYMMDD_NN.md` basé sur le template
   - Remplir les objectifs et tests à effectuer

2. **Vérifier l'état du projet** :
   - Lancer le linter markdown : `npx markdownlint-cli2 "**/*.md"`
   - Vérifier qu'il n'y a pas de commits WIP à résoudre : `git log --oneline -5`
   - Si le projet Godot existe : vérifier qu'il se lance sans erreurs

3. **Identifier la phase et branche actuelle** :
   - Afficher la branche git courante
   - Confirmer la phase de développement (Phase 0, 1, 2, 3)

4. **Résumer le contexte** :
   - Dernière session effectuée (si fichier retro existe)
   - Problèmes en attente identifiés dans la dernière rétro
   - État global du projet (documents à jour, tests passants, etc.)

5. **Proposer les objectifs** :
   - Lister 1-3 problèmes prioritaires à résoudre dans cette session
   - Estimer la durée à partir des statistiques de durées précédentes et nombre de problèmes à résoudre (20-30 min cible)
   - Définir les critères de succès clairs

## Format de sortie attendu

```markdown
# Session YYYYMMDD_NN - [Titre court]

**Phase** : phase-X-nom
**Branche** : `nom-branche`
**Durée estimée** : XX-XX min

## État du projet

- Linter markdown : ✅/❌
- Commits WIP : [liste ou "aucun"]
- Dernière session : [date + résumé ou "première session"]

## Objectifs proposés

1. **[Objectif 1]** - Complexité : Simple/Moyen/Complexe
   - Critères de succès : ...
   - Durée estimée : X min

2. **[Objectif 2]** - Complexité : Simple/Moyen/Complexe
   - Critères de succès : ...
   - Durée estimée : X min

## Prêt à commencer ?

Le fichier de tests `docs/workflow/tests/YYYYMMDD_NN.md` a été créé.
Tu peux maintenant commencer la phase RED en détaillant les problèmes.
```

Attends ma confirmation avant de passer à la phase RED.
