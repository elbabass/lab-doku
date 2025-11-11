#!/bin/bash
set -e

echo "=== Validation Setup Godot Phase 0 ==="
echo ""

# Configuration
GODOT_BIN="/Applications/Godot.app/Contents/MacOS/Godot"

# Test 1: Fichier project.godot existe
echo "[1/5] Vérification project.godot..."
if [ -f "project.godot" ]; then
    echo "✅ project.godot existe"
else
    echo "❌ project.godot manquant"
    exit 1
fi
echo ""

# Test 2: Build Godot sans erreurs
echo "[2/5] Build Godot..."
if $GODOT_BIN --headless --quit --path . 2>&1 | grep -iE "^error:" > /dev/null; then
    echo "❌ Erreurs de build détectées"
    $GODOT_BIN --headless --quit --path . 2>&1 | grep -iE "^error:"
    exit 1
else
    echo "✅ Build OK"
fi
echo ""

# Test 3: Structure de dossiers
echo "[3/5] Vérification structure..."
REQUIRED_DIRS=(
    "scripts/autoloads"
    "scripts/game"
    "scripts/ui"
    "scripts/effects"
    "scripts/utils"
    "scenes/game"
    "scenes/ui"
    "scenes/effects"
    "tests/unit"
    "tests/integration"
    "assets/sprites"
    "assets/sounds"
    "assets/fonts"
)

MISSING_DIRS=()
for dir in "${REQUIRED_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        MISSING_DIRS+=("$dir")
    fi
done

if [ ${#MISSING_DIRS[@]} -eq 0 ]; then
    echo "✅ Structure complète (${#REQUIRED_DIRS[@]} dossiers)"
else
    echo "❌ Dossiers manquants:"
    for dir in "${MISSING_DIRS[@]}"; do
        echo "  - $dir"
    done
    exit 1
fi
echo ""

# Test 4: Fichiers autoloads existent et sont valides
echo "[4/5] Vérification autoloads..."
AUTOLOAD_FILES=(
    "scripts/autoloads/game_manager.gd"
    "scripts/autoloads/event_bus.gd"
)

for file in "${AUTOLOAD_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Fichier manquant: $file"
        exit 1
    fi
done

# Vérifier que les autoloads s'initialisent correctement
if $GODOT_BIN --headless --quit --path . 2>&1 | grep "GameManager initialized" > /dev/null && \
   $GODOT_BIN --headless --quit --path . 2>&1 | grep "EventBus initialized" > /dev/null; then
    echo "✅ Autoloads présents et fonctionnels"
else
    echo "❌ Autoloads ne s'initialisent pas correctement"
    exit 1
fi
echo ""

# Test 5: Markdown linting
echo "[5/5] Linting markdown..."
if command -v npx > /dev/null; then
    if npx markdownlint-cli2 "**/*.md" > /dev/null 2>&1; then
        echo "✅ Markdown OK"
    else
        echo "❌ Erreurs markdown détectées"
        npx markdownlint-cli2 "**/*.md"
        exit 1
    fi
else
    echo "⚠️  npx non disponible, markdown linting skipped"
fi
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Tous les tests passent !"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Projet Godot Phase 0 configuré avec succès."
echo "Prochaine étape : Phase 1 - MVP Core mechanics"
