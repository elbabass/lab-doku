---
description: Lance le linter markdown sur tous les fichiers du projet
---

# Linter Markdown

Je vais lancer le linter markdown sur tous les fichiers du projet.

## Actions à effectuer

1. **Exécuter markdownlint** :

   ```bash
   npx markdownlint-cli2 "**/*.md"
   ```

2. **Analyser les résultats** :
   - Si 0 erreurs : Confirmer que tout est OK ✅
   - Si erreurs détectées :
     - Lister les fichiers concernés
     - Lister les types d'erreurs (MD### codes)
     - Grouper par type d'erreur pour faciliter la correction

3. **Proposer des corrections** (si erreurs) :
   - Pour chaque erreur, expliquer brièvement le problème
   - Proposer la correction appropriée
   - Indiquer si la correction peut être automatique (--fix) ou manuelle

4. **Corriger automatiquement si possible** :
   - Identifier les erreurs auto-corrigibles
   - Si l'utilisateur confirme, lancer : `npx markdownlint-cli2 --fix "**/*.md"`
   - Relancer le linter pour vérifier

5. **Corriger manuellement les erreurs restantes** :
   - Utiliser l'outil Edit pour corriger les erreurs qui nécessitent intervention manuelle
   - Re-linter après chaque batch de corrections

## Format de sortie attendu

### Si aucune erreur

```
✅ Linter markdown - Tous les fichiers passent

Fichiers vérifiés : XX
Erreurs : 0
```

### Si erreurs détectées

```
❌ Linter markdown - Erreurs détectées

## Résumé

- Fichiers avec erreurs : X
- Total erreurs : Y

## Erreurs par type

### MD032 (blanks-around-lists) - N occurrences
- `file1.md:42` : Les listes doivent être entourées de lignes vides
- `file2.md:67` : Les listes doivent être entourées de lignes vides

### MD025 (single-title) - N occurrences
- `file3.md:10` : Un seul titre de niveau 1 autorisé

## Corrections proposées

1. **Corrections automatiques** (--fix disponible) :
   - MD012 : Lignes vides multiples
   - MD009 : Espaces en fin de ligne
   [Exécuter : npx markdownlint-cli2 --fix "**/*.md"]

2. **Corrections manuelles** :
   - MD032 dans file1.md:42 : Ajouter ligne vide avant liste
   - MD025 dans file3.md:10 : Changer # en ## pour titre secondaire

Dois-je procéder aux corrections ?
```
