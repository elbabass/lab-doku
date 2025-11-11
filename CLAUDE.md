# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Lab-doku is a puzzle game that fuses sudoku with spatial navigation. Players explore a sudoku grid from a top-down view, where each number is a colored door requiring a key to traverse. The core mechanic: you navigate ON the sudoku grid itself, and solving it unlocks movement possibilities. Errors trigger chaotic events (explosions, teleportation, resource loss) that can sometimes be exploited strategically.

**Player fantasy**: "I'm an investigator-defuser tracking a serial bomber obsessed with numbers."

**Current phase**: Paper prototype completed ✅ - Preparing digital prototype specifications. No digital implementation exists yet.

## Project Structure

- `README.md` - Main project overview (in French)
- `EXECUTIVE_SUMMARY.md` - 1-page condensed pitch
- `docs/DESIGN_DOC.md` - Complete design document with all game systems, mechanics, and parameters
- `docs/PAPER_PROTOTYPE_TEST_RESULTS.md` - Complete test results report with validated rules
- `prototypes/paper/` - Paper prototype kit for playtesting
  - `LABDOKU_PROTOTYPE_PAPIER_v1_tables.typ` - Typst source (5 pages)
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

- **Indices (numbered tokens)**: Numbered tokens (1-4) are **initially placed on certain grid cells**
- Player **collects indices** by moving onto cells containing them (automatic pickup)
- Collected indices go into player's **inventory** (unlimited capacity)
- **Constraint**: Total (grid + inventory) ≤ 4 for each number
  - Example: If 3×"2" are on grid, player can have max 1×"2" in inventory
- On **empty cell**, player chooses which number from inventory to place (or cancel & retreat)
- **Starting resources** (validated by paper tests):
  - Keys: 2 keys standard (1 for hard mode, 3 for easy mode)
  - Indices: **2 random indices** in inventory (respecting ≤4 constraint)
    - If random draw violates constraint, discard and redraw
    - **Critical rule**: Without starting indices, player cannot move to empty cells (game blocked)
- **Rewards per correct placement** (new mechanism): +1 random index
- **Rewards per completed series**: +1 key (choice) + 1-2 random indices (to be tuned)

### Navigation on Empty Cells (Special Rule - Validated)

**Critical mechanic discovered during paper tests**:

- Once a number is placed on an empty cell, player can **stay on that cell even without the matching key**
- Once the player leaves the cell, they **cannot return** without possessing the key
- **Justification**: Prevents blocking when starting keys don't provide any accessible path
- **Tactical impact**: Creates strategic decisions (placing a number opens a path but may trap if you leave)

### Error Events (when placing incorrect number) - REVISED SYSTEM

When placing an incorrect number, trigger an event. **Distribution revised after paper tests** to emphasize resource tension:

**Recommended distribution** (to be tuned in digital prototype):
- **Resource Loss** (PRIMARY EVENT, 60-100%): Lose 1 random index from inventory
  - **If inventory empty → Game Over** (see defeat condition below)
  - Creates direct pressure on resources
- **Teleportation** (SECONDARY EVENT, 10-30%): Moves player to random pre-filled cell (not necessarily accessible)
  - Can accidentally help strategically
- **Explosion** (OPTIONAL, 0-10%): Clears 4 adjacent cells (cross pattern), pre-filled cells protected
  - Tested in severe mode (8 cells) - playable but intense
  - May be removed or kept as rare event

**Note**: In digital version, use RNG. In paper prototype, use physical D6 die.

Philosophy: Events are mostly punitive but can accidentally help (emergent gameplay moments). Resource loss is now the primary punishment mechanism.

### Victory & Defeat Conditions

**Victory**:
- Fill all 16 cells correctly (solved sudoku)

**Defeat** (new rule validated by paper tests):
- **Game Over if inventory empty** - Player has no indices left
- Cannot move to empty cells or place numbers
- Creates real tension and failure risk
- Balanced by: +1 index reward per correct placement

**Score**: Number of errors (lower is better)

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

## Parameters Validated (Paper Tests Completed)

Fixed values after paper testing:

- **Starting keys**: 2 standard (1 hard, 3 easy)
- **Starting indices**: 2 random indices (respecting ≤4 constraint)
- **Inventory constraint**: ≤4 per number (validated)
- **Gain per correct placement**: +1 random index (new mechanism)
- **Defeat condition**: Inventory empty = Game Over
- **Navigation rule**: Can stay on empty cell after placing number without key

## Parameters to Tune (Digital Prototype)

Values to adjust during digital development:

- **Error event probabilities**:
  - Recommended initial: 70% Loss / 30% Teleportation / 0% Explosion
  - Currently equiprobable in paper version, needs adjustment
- **Indices per completed series**: Currently 1-2, may need tuning
- **Number of index tokens placed on grid initially**: How many? Where? Which values?
- **Explosion radius if kept**: 4 or 8 cells
- **Number of pre-filled cells**: Currently 5-6
- **Timer per series duration**: If timer mechanic implemented (30s? 60s?)

## Advanced Difficulty Systems (Post-MVP Priority)

Identified during paper tests to address short duration (2 min vs target 5-15 min):

1. **Timer per series** ⭐ PRIORITY
   - Each row/column/block has independent countdown
   - At zero: series explodes (all non-prefilled numbers disappear)
   - Forces resolution order and maintains pressure

2. **Progressive grid sizes** ⭐ PRIORITY
   - 4x4 (tutorial), 5x5 (intermediate), 6x6 (advanced)
   - Naturally increases complexity and duration

3. **Other ideas** (paper tests): Bomber NPC, capture objective, multiplayer modes

## Development Phases

1. ✅ Essence definition (pitch, core mechanic, player fantasy)
2. ✅ Mechanics exploration (keys, indices, events)
3. ✅ Paper prototype & playtesting (completed - GO validated)
4. 🔄 Digital prototype specifications (current phase)
5. ⏳ Digital prototype implementation (Godot)
6. ⏳ Iterations & polish

## Testing Validation Criteria

Paper prototype success metrics (Phase 3 - COMPLETED):

- ✅ Playable start to finish without blocking (with adjustments)
- ⚠️ Average duration: 2 minutes (too short, target 5-15 min) - solutions identified
- ✅ Rules understood in < 3 minutes
- ✅ At least 1 "magic moment" emerges naturally
- ⚠️ Player wants to replay after 1 game (mixed - needs more difficulty)
- ✅ Fun rating > 6/10 (concept validated)

**Test results**: See `docs/PAPER_PROTOTYPE_TEST_RESULTS.md` for complete report

**Critical findings**:
- 2 blocking issues identified and solved (starting indices, key adjacency)
- Duration too short → Timer per series + progressive grids needed
- Core loop validated, needs more complexity

Digital prototype success metrics:

- 3-5 people tested and understood it
- Completion rate > 70%
- Average time: 7-12 minutes
- At least 2 spontaneous positive feedback
- No blocking bugs
- Core loop is satisfying

## Known Risks & Mitigations

1. **Player blocking**: May run out of keys/indices and cannot progress
   - ✅ MITIGATED: 2 random starting indices + stay-on-empty-cell rule + +1 index per correct placement

2. **Cognitive complexity**: Juggling sudoku logic + spatial navigation + resource management
   - STATUS: Paper tests showed good comprehension, monitoring needed in digital

3. **Event chaos**: Errors might destroy well-progressed games (frustration vs fun)
   - ✅ ADJUSTED: Resource loss as primary event (less chaotic, more predictable tension)

4. **Game duration**: Too short (< 3 min) or too long (> 15 min)
   - ⚠️ IDENTIFIED: 2 min in paper tests → Timer per series + progressive grids planned

5. **Replayability**: Once solved, why replay?
   - PLANNED: Multiple difficulty modes, grid sizes, procedural generation

Mitigations validated through paper testing. Digital prototype will address duration issue.

## Language & Documentation

All project documentation is in French. The game targets French-speaking audiences initially.
