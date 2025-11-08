# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Lab-doku is a puzzle game that fuses sudoku with spatial navigation. Players explore a sudoku grid from a top-down view, where each number is a colored door requiring a key to traverse. The core mechanic: you navigate ON the sudoku grid itself, and solving it unlocks movement possibilities. Errors trigger chaotic events (explosions, teleportation, resource loss) that can sometimes be exploited strategically.

**Player fantasy**: "I'm an investigator-defuser tracking a serial bomber obsessed with numbers."

**Current phase**: Paper prototype and design phase. No digital implementation exists yet.

## Project Structure

- `README.md` - Main project overview (in French)
- `EXECUTIVE_SUMMARY.md` - 1-page condensed pitch
- `docs/DESIGN_DOC.md` - Complete design document with all game systems, mechanics, and parameters
- `prototypes/paper/` - Paper prototype kit for playtesting
  - `LABDOKU_PROTOTYPE_PAPIER_v1_tables.typ` - Typst source (4 pages)
  - `LABDOKU_PROTOTYPE_PAPIER_v1_tables.pdf` - Print-ready PDF with colored numbers
  - `LABDOKU_PROTOTYPE_PAPIER.md` - Usage guide and rules
  - Material: 1 player token, key tracker (checkboxes), numbered index tokens (1-4), event markers, error counter
  - External: D4 (random index rewards), D6 (error events)
- `prototypes/digital/` - Future Godot prototypes (empty for now)
- `assets/concept/` - Concept art and sketches

## Core Game Systems

### Navigation & Keys

- 4x4 sudoku grid (prototype scope)
- 4 color-coded keys (one per number: Red=1, Green=2, Blue=3, Yellow=4)
- Players can only move to adjacent cells (up/down/left/right) if they possess the matching key
- Completing a series (row/column/2x2 block) grants 1 key of player's choice

### Resources & Placement

- **Indices (numbered tokens)**: Physical tokens placed on grid cells, each showing a number (1-4)
- Player **collects indices** by moving onto cells containing them (automatic pickup)
- Collected indices go into player's **inventory** (unlimited capacity)
- **Constraint**: Total (grid + inventory) ≤ 4 for each number
  - Example: If 3×"2" are on grid, player can have max 1×"2" in inventory
- On **empty cell**, player chooses which number from inventory to place (or cancel & retreat)
- Starting resources: 1-2 keys, 2-3 numbered indices
- Rewards per completed series: +1 key (choice) + 2 random indices (2× D4 rolls)

### Error Events (D6 roll when placing incorrect number)

When placing an incorrect number, roll 1D6:

- **1-2: Explosion**: Clears 4 adjacent cells (cross pattern), pre-filled cells protected
- **3-4: Teleportation**: Moves player to random pre-filled accessible cell
- **5-6: Resource Loss**: Lose 1 random index from inventory

Philosophy: Events are mostly punitive but can accidentally help (emergent gameplay moments).

### Victory Condition

- Fill all 16 cells correctly (solved sudoku)
- No defeat condition in v0.1
- Score: Number of errors (lower is better)

## Planned Technology Stack

**Game Engine**: Godot 4.x + GDScript

When the digital prototype phase begins (Phase 4), the minimal scope includes:

- 4x4 grid with 5-6 pre-filled cells (hardcoded)
- Movement system with key requirements
- Number placement and validation
- 3 error events
- Minimal UI (counters, clear grid display)
- Placeholder assets (colored squares + emojis)

## Design Philosophy

Key differentiators:

- **You ARE in the puzzle** (not beside it) - no separation between play space and puzzle
- **Solving and navigating are the same action** - organic feedback loop
- **The sudoku isn't decorative** - it IS the terrain
- **Errors are tools** - not just punishments

Inspirations: Baba Is You (meta-puzzles), The Witness (solving unlocks exploration), Puzzle Quest (genre fusion).

## Parameters to Tune (Post-Testing)

Values to adjust based on playtesting:

- Starting keys (currently 1-2)
- Starting indices (currently 2-3 numbered tokens)
- Indices per completed series (currently 2 random via D4)
- Keys per completed series (currently 1)
- Index placement on grid (how many? where?)
- Error event probabilities on D6 (currently 2/6 each)
- Explosion radius (currently 4 cells in cross pattern)
- Number of pre-filled cells (currently 5-6)

## Development Phases

1. ✅ Essence definition (pitch, core mechanic, player fantasy)
2. ✅ Mechanics exploration (keys, indices, events)
3. 🔄 Paper prototype & playtesting (current phase)
4. ⏳ Digital prototype (Godot)
5. ⏳ Iterations & polish

## Testing Validation Criteria

Paper prototype success metrics:

- Playable start to finish without blocking
- Average duration: 5-15 minutes
- Rules understood in < 3 minutes
- At least 1 "magic moment" emerges naturally
- Player wants to replay after 1 game
- Fun rating > 6/10

Digital prototype success metrics:

- 3-5 people tested and understood it
- Completion rate > 70%
- Average time: 7-12 minutes
- At least 2 spontaneous positive feedback
- No blocking bugs
- Core loop is satisfying

## Known Risks

1. **Player blocking**: May run out of keys/indices and cannot progress
2. **Cognitive complexity**: Juggling sudoku logic + spatial navigation + resource management
3. **Event chaos**: Errors might destroy well-progressed games (frustration vs fun)
4. **Game duration**: Too short (< 3 min) or too long (> 15 min)
5. **Replayability**: Once solved, why replay?

Mitigations focus on extensive playtesting and parameter adjustments.

## Language & Documentation

All project documentation is in French. The game targets French-speaking audiences initially.
