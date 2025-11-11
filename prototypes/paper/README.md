# Lab-doku - Prototype Papier

**Kit de test pour valider les mécaniques core avant développement digital**

---

## 📄 Fichiers principaux

### Version actuelle (v1)

- **[LABDOKU_PROTOTYPE_PAPIER_v1_tables.typ](LABDOKU_PROTOTYPE_PAPIER_v1_tables.typ)** - Fichier source Typst (5 pages)
- **[LABDOKU_PROTOTYPE_PAPIER_v1_tables.pdf](LABDOKU_PROTOTYPE_PAPIER_v1_tables.pdf)** - PDF prêt à imprimer
- **[LABDOKU_PROTOTYPE_PAPIER.md](LABDOKU_PROTOTYPE_PAPIER.md)** - Notice complète (règles, scénarios, checklist)

### Versions antérieures

Les versions précédentes (v0, v2 expérimentales) sont archivées dans [`archives/`](archives/).

---

## 🚀 Démarrage rapide

### 1. Compilation du PDF (optionnel)

Si tu veux recompiler le PDF depuis la source Typst :

```bash
# Nécessite Typst installé (https://typst.app/)
typst compile LABDOKU_PROTOTYPE_PAPIER_v1_tables.typ
```

Le PDF `LABDOKU_PROTOTYPE_PAPIER_v1_tables.pdf` est déjà généré et prêt à l'emploi.

### 2. Impression

**Paramètres recommandés :**

- ✅ **Couleur obligatoire** (chiffres colorés + tracker de clés 🔴🟢🔵🟡)
- ✅ Papier 120g si possible (meilleure durabilité pour le matériel découpé)
- ⚪ Recto-verso optionnel (5 pages → 3 feuilles)

### 3. Préparation du matériel

**Matériel à découper** (pages 3-4 du PDF) :

- 1× Pion joueur 🚶
- 16× Jetons indices numérotés (4×"1", 4×"2", 4×"3", 4×"4")
- 1× Tracker de clés avec cases à cocher (🔴1, 🟢2, 🔵3, 🟡4)
- 3× Marqueurs d'événements (💥🌀📉)
- 1× Compteur d'erreurs

**Matériel externe nécessaire :**

- 1× **Dé à 4 faces (D4)** - pour génération aléatoire d'indices en récompense
- 1× **Dé à 6 faces (D6)** - pour événements d'erreur
- Stylo/crayon - pour remplir les grilles
- Ciseaux - pour découper le matériel

### 4. Jouer

Consulte **[LABDOKU_PROTOTYPE_PAPIER.md](LABDOKU_PROTOTYPE_PAPIER.md)** pour :

- 📖 **Règles complètes du jeu**
- 🎮 **2 scénarios prêts à jouer** (avec solutions)
- 🧪 **Variantes à tester** (ajustements de paramètres)
- ✅ **Checklist de validation** (critères GO/NO-GO)

**Durée estimée par partie :** 10-20 minutes

---

## 📦 Contenu du PDF (5 pages)

| Page | Contenu |
|------|---------|
| **1** | 2 scénarios de test avec grilles pré-remplies |
| **2** | 2 grilles vierges réimprimables |
| **3** | 16 jetons indices chiffrés à découper (4 de chaque chiffre) |
| **4** | Matériel complet (pion, tracker, marqueurs, compteur) |
| **5** | Checklist de validation et espace pour notes |

---

## 🎯 Objectifs des tests papier

### Questions clés à valider

1. **Jouabilité** : Le jeu est-il jouable du début à la fin sans blocage ?
2. **Décisions intéressantes** : Le joueur anticipe-t-il et planifie-t-il ?
3. **Événements d'erreur** : Créent-ils des moments magiques ou de la frustration ?
4. **Système indices** : Le ramassage/inventaire/contrainte fonctionne-t-il bien ?
5. **Durée** : Le jeu est-il trop court (< 5 min) ou trop long (> 20 min) ?

### Critères de succès

**✅ GO pour proto digital si :**

- Jouable du début à la fin (au moins 1 partie complète)
- Au moins 1 "moment magique" émerge naturellement
- Envie de rejouer après 1 partie
- Fun rating > 6/10

**⚠️ Ajustements nécessaires si :**

- Blocage fréquent (manque de clés/indices)
- Événements trop chaotiques/frustrants
- Durée inadéquate (< 3 min ou > 20 min)

**❌ Pivot ou abandon si :**

- Pas fun du tout (< 4/10)
- Décisions pas intéressantes (placement au hasard)
- Core mechanic ne fonctionne pas

---

## 🔧 Modifications et variantes

Pour créer tes propres scénarios :

1. Utilise les **grilles vierges** (page 2 du PDF)
2. Choisis un **sudoku 4×4 valide** avec solution unique
3. Pré-remplis **5-6 cases**
4. Place des **jetons indices** sur certaines cases
5. Définis l'**état de départ** (position, clés, indices inventaire)
6. **Teste et itère !**

---

## 📝 Feedback et observations

Après avoir testé le prototype papier :

1. **Remplis la checklist** (page 5 du PDF)
2. **Note tes observations** dans l'espace prévu
3. **Partage tes retours** via issue GitHub ou contact direct

Les retours des tests papier guideront les décisions pour le prototype digital Godot.

---

## 🔗 Ressources complémentaires

- [Document de design complet](../../docs/DESIGN_DOC.md) - Spécifications complètes
- [Executive Summary](../../EXECUTIVE_SUMMARY.md) - Pitch condensé
- [README principal](../../README.md) - Vue d'ensemble du projet

---

**Bon test ! 🎮**

N'hésite pas à gribouiller sur les grilles, modifier les règles à la volée, et casser les conventions. C'est exactement pour ça que le proto papier existe.
