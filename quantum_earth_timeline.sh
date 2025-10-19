#!/bin/bash
# ============================================================================
# QUANTUM EARTH TIMELINE CALCULATOR v2.0
# ============================================================================
# Calculates probabilistic remaining time for Earth's habitability
# using quantum simulation and Monte Carlo methods
# With enhanced visual effects inspired by quantum simulators
#
# Compatible with: MSYS2, Git Bash, Windows WSL, Linux, macOS
# Author: Andrea Giani - Quantum Earth Research Project
# License: MIT
# ============================================================================

# Force C locale for consistent number formatting
export LC_ALL=C
export LANG=C

# Color definitions for terminal output
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    MAGENTA=''
    CYAN=''
    WHITE=''
    BOLD=''
    DIM=''
    RESET=''
else
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    MAGENTA='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[1;37m'
    BOLD='\033[1m'
    DIM='\033[2m'
    RESET='\033[0m'
fi

# Global configuration
SIMULATION_RUNS=5000
QUANTUM_STATES=16
OUTPUT_DIR="./output"
DATA_DIR="./data"
ANIMATION_SPEED=0.02

# ============================================================================
# VISUAL EFFECTS LIBRARY
# ============================================================================

typewriter_effect() {
    local text="$1"
    local speed="${2:-0.03}"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep "$speed"
    done
    echo ""
}

draw_earth_ascii() {
    local frame=$1
    echo -e "${BLUE}"
    case $((frame % 4)) in
        0)
            echo "        .--."
            echo "       /    \\"
            echo "      | .  . |"
            echo "       \\    /"
            echo "        \`--'"
            ;;
        1)
            echo "        .--."
            echo "       / .. \\"
            echo "      |  ..  |"
            echo "       \\ .. /"
            echo "        \`--'"
            ;;
        2)
            echo "        .--."
            echo "       / :  \\"
            echo "      | : : |"
            echo "       \\ :  /"
            echo "        \`--'"
            ;;
        3)
            echo "        .--."
            echo "       /  : \\"
            echo "      |  :  |"
            echo "       \\  : /"
            echo "        \`--'"
            ;;
    esac
    echo -e "${RESET}"
}

scanning_animation() {
    local text="$1"
    echo -e "${CYAN}${BOLD}"
    echo "╔═══════════════════════════════════════════════════════════════════╗"
    echo "║                    QUANTUM EARTH SCANNER v2.0                     ║"
    echo "╚═══════════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo ""
    
    for i in {1..3}; do
        draw_earth_ascii $i
        echo -e "${YELLOW}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${RESET} Scanning: $text"
        sleep 0.3
        if [ $i -lt 3 ]; then
            clear
            echo -e "${CYAN}${BOLD}"
            echo "╔═══════════════════════════════════════════════════════════════════╗"
            echo "║                    QUANTUM EARTH SCANNER v2.0                     ║"
            echo "╚═══════════════════════════════════════════════════════════════════╝"
            echo -e "${RESET}"
            echo ""
        fi
    done
    echo -e "${GREEN}✓ Scan complete${RESET}"
    echo ""
    sleep 0.5
}

draw_wave_pattern() {
    local amplitude=$1
    local phase=$2
    local length=60
    
    echo -n "  "
    for ((i=0; i<length; i++)); do
        local val=$(echo "scale=2; s(($i + $phase) * 0.2) * $amplitude" | bc -l)
        local normalized=$(echo "scale=0; ($val + 1) * 5" | bc)
        
        case $normalized in
            0|1|2) echo -n "." ;;
            3|4|5) echo -n "~" ;;
            6|7) echo -n "≈" ;;
            *) echo -n "∿" ;;
        esac
    done
    echo ""
}

quantum_particle_effect() {
    local count=$1
    local description="$2"
    
    echo -e "${MAGENTA}▶ $description${RESET}"
    echo -n "  "
    
    for ((i=0; i<60; i++)); do
        if [ $((RANDOM % 100)) -lt $count ]; then
            echo -ne "${CYAN}●${RESET}"
        else
            echo -n " "
        fi
    done
    echo ""
}

draw_probability_wave() {
    local probability=$1
    local label="$2"
    
    echo -e "${YELLOW}$label${RESET}"
    
    # Draw 5 wave frames
    for phase in 0 2 4 6 8; do
        draw_wave_pattern $probability $phase
        sleep 0.1
    done
    echo ""
}

matrix_effect() {
    local lines=10
    local cols=70
    
    echo -e "${GREEN}${DIM}"
    for ((i=0; i<lines; i++)); do
        echo -n "  "
        for ((j=0; j<cols; j++)); do
            if [ $((RANDOM % 3)) -eq 0 ]; then
                printf "%x" $((RANDOM % 16))
            else
                echo -n " "
            fi
        done
        echo ""
        sleep 0.05
    done
    echo -e "${RESET}"
}

progress_bar_animated() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((width * current / total))
    
    echo -ne "\r  ["
    
    for ((i=0; i<width; i++)); do
        if [ $i -lt $filled ]; then
            echo -ne "${GREEN}█${RESET}"
        else
            echo -ne "${DIM}░${RESET}"
        fi
    done
    
    echo -ne "] ${percentage}%"
}

quantum_entanglement_visual() {
    echo -e "${MAGENTA}╔════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${MAGENTA}║           QUANTUM ENTANGLEMENT CORRELATIONS                    ║${RESET}"
    echo -e "${MAGENTA}╚════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    
    # Draw entangled pairs
    for i in {1..5}; do
        echo -ne "  ${CYAN}◉${RESET}"
        for j in {1..10}; do
            if [ $((RANDOM % 2)) -eq 0 ]; then
                echo -ne "~"
            else
                echo -ne "≈"
            fi
        done
        echo -e "${CYAN}◉${RESET}"
        sleep 0.1
    done
    echo ""
}

draw_risk_gauge() {
    local risk=$1
    local label="$2"
    local max_bars=40
    local filled=$(echo "scale=0; $risk * $max_bars / 100" | bc)
    
    printf "  %-20s [" "$label"
    
    for ((i=0; i<max_bars; i++)); do
        if [ $i -lt $filled ]; then
            if [ $i -lt $((max_bars / 3)) ]; then
                echo -ne "${GREEN}▓${RESET}"
            elif [ $i -lt $((max_bars * 2 / 3)) ]; then
                echo -ne "${YELLOW}▓${RESET}"
            else
                echo -ne "${RED}▓${RESET}"
            fi
        else
            echo -ne "${DIM}░${RESET}"
        fi
    done
    
    printf "] %.1f%%\n" "$risk"
}

collapsing_wavefunction() {
    echo -e "${CYAN}Quantum State Collapse in Progress...${RESET}"
    echo ""
    
    for i in {10..0}; do
        echo -ne "\r  "
        for j in {1..50}; do
            if [ $((RANDOM % 11)) -gt $i ]; then
                echo -ne "${BLUE}|${RESET}"
            else
                echo -ne "${MAGENTA}⟩${RESET}"
            fi
        done
        echo -ne " [$i] "
        sleep 0.1
    done
    
    echo ""
    echo -e "${GREEN}  ✓ Wavefunction Collapsed to Eigenstate${RESET}"
    echo ""
    sleep 0.3
}

# ============================================================================
# QUANTUM SIMULATION ENGINE
# ============================================================================

quantum_superposition() {
    local state=$1
    local amplitude=$(echo "scale=6; s($state * 3.14159 / $QUANTUM_STATES)" | bc -l)
    echo "$amplitude"
}

quantum_entangle() {
    local factor1=$1
    local factor2=$2
    local correlation=$(echo "scale=6; ($factor1 + $factor2) / 2 + (($factor1 * $factor2) / 100)" | bc -l)
    echo "$correlation"
}

quantum_collapse() {
    local probability=$1
    local random=$((RANDOM % 10000))
    local threshold=$(echo "scale=0; $probability * 10000 / 1" | bc)
    if [ $random -lt $threshold ]; then
        echo "1"
    else
        echo "0"
    fi
}

# ============================================================================
# RISK FACTOR CALCULATIONS
# ============================================================================

calculate_geological_risk() {
    local timeframe=$1
    
    local tectonic_risk=$(echo "scale=8; 1 - e(-$timeframe / 100000000)" | bc -l)
    local volcano_risk=$(echo "scale=8; 1 - e(-$timeframe / 75000)" | bc -l)
    local magnetic_risk=$(echo "scale=8; ($timeframe / 250000) * 0.15" | bc -l)
    
    local combined=$(echo "scale=8; $tectonic_risk * 0.1 + $volcano_risk * 0.6 + $magnetic_risk * 0.3" | bc -l)
    echo "$combined"
}

calculate_astronomical_risk() {
    local timeframe=$1
    
    local neo_major=$(echo "scale=8; 1 - e(-$timeframe / 100000000)" | bc -l)
    local neo_minor=$(echo "scale=8; 1 - e(-$timeframe / 1000000)" | bc -l)
    
    local solar_expansion=0
    if (( $(echo "$timeframe > 1000000000" | bc -l) )); then
        solar_expansion=$(echo "scale=8; ($timeframe - 1000000000) / 4000000000" | bc -l)
    fi
    
    local supernova_risk=$(echo "scale=8; 1 - e(-$timeframe / 500000000)" | bc -l)
    local grb_risk=$(echo "scale=8; 1 - e(-$timeframe / 1000000000)" | bc -l)
    
    local combined=$(echo "scale=8; $neo_major * 0.4 + $neo_minor * 0.2 + $solar_expansion * 0.25 + $supernova_risk * 0.1 + $grb_risk * 0.05" | bc -l)
    echo "$combined"
}

calculate_climate_risk() {
    local timeframe=$1
    
    local immediate_climate=$(echo "scale=8; 1 - e(-$timeframe / 150)" | bc -l)
    local natural_cycle=$(echo "scale=8; 1 - e(-$timeframe / 100000)" | bc -l)
    local ocean_acid=$(echo "scale=8; 1 - e(-$timeframe / 500)" | bc -l)
    
    local greenhouse=0
    if (( $(echo "$timeframe > 100000000" | bc -l) )); then
        greenhouse=$(echo "scale=8; ($timeframe - 100000000) / 900000000" | bc -l)
    fi
    
    local combined=$(echo "scale=8; $immediate_climate * 0.4 + $natural_cycle * 0.1 + $ocean_acid * 0.3 + $greenhouse * 0.2" | bc -l)
    echo "$combined"
}

calculate_anthropic_risk() {
    local timeframe=$1
    
    local nuclear_risk=$(echo "scale=8; 1 - e(-$timeframe / 100)" | bc -l)
    if (( $(echo "$nuclear_risk > 0.8" | bc -l) )); then
        nuclear_risk="0.8"
    fi
    
    local bio_risk=$(echo "scale=8; 1 - e(-$timeframe / 200)" | bc -l)
    if (( $(echo "$bio_risk > 0.7" | bc -l) )); then
        bio_risk="0.7"
    fi
    
    local ai_risk=$(echo "scale=8; 1 - e(-$timeframe / 50)" | bc -l)
    if (( $(echo "$ai_risk > 0.6" | bc -l) )); then
        ai_risk="0.6"
    fi
    
    local nano_risk=$(echo "scale=8; 1 - e(-$timeframe / 300)" | bc -l)
    if (( $(echo "$nano_risk > 0.4" | bc -l) )); then
        nano_risk="0.4"
    fi
    
    local resource_risk=$(echo "scale=8; 1 - e(-$timeframe / 500)" | bc -l)
    
    local combined=$(echo "scale=8; $nuclear_risk * 0.25 + $bio_risk * 0.2 + $ai_risk * 0.3 + $nano_risk * 0.1 + $resource_risk * 0.15" | bc -l)
    echo "$combined"
}

calculate_quantum_physics_risk() {
    local timeframe=$1
    
    local vacuum_decay=$(echo "scale=12; 1 - e(-$timeframe / 10000000000000)" | bc -l)
    local higgs_instability=$(echo "scale=12; 1 - e(-$timeframe / 100000000000000)" | bc -l)
    local black_hole=$(echo "scale=12; 1 - e(-$timeframe / 1000000000000)" | bc -l)
    
    local combined=$(echo "scale=12; $vacuum_decay * 0.5 + $higgs_instability * 0.4 + $black_hole * 0.1" | bc -l)
    echo "$combined"
}

# ============================================================================
# ENHANCED MONTE CARLO SIMULATION
# ============================================================================

run_monte_carlo_simulation() {
    local timeframe=$1
    local timeframe_name=$2
    
    echo ""
    echo -e "${CYAN}${BOLD}╔════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}${BOLD}║         QUANTUM MONTE CARLO SIMULATION INITIATED               ║${RESET}"
    echo -e "${CYAN}${BOLD}╚════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    
    typewriter_effect "  Timeline: $timeframe_name ($timeframe years)" 0.02
    typewriter_effect "  Quantum States: $QUANTUM_STATES" 0.02
    typewriter_effect "  Simulation Runs: $SIMULATION_RUNS" 0.02
    echo ""
    
    # Scanning animation
    scanning_animation "Geological Parameters"
    scanning_animation "Astronomical Data"
    scanning_animation "Climate Models"
    scanning_animation "Anthropic Factors"
    scanning_animation "Quantum Field States"
    
    local extinction_count=0
    
    # Calculate base risk factors
    echo -e "${YELLOW}Computing Base Risk Factors...${RESET}"
    echo ""
    
    local geo_risk=$(calculate_geological_risk $timeframe)
    local astro_risk=$(calculate_astronomical_risk $timeframe)
    local climate_risk=$(calculate_climate_risk $timeframe)
    local anthro_risk=$(calculate_anthropic_risk $timeframe)
    local quantum_risk=$(calculate_quantum_physics_risk $timeframe)
    
    # Display risks with animated gauges
    local geo_percent=$(echo "scale=2; $geo_risk * 100" | bc)
    local astro_percent=$(echo "scale=2; $astro_risk * 100" | bc)
    local climate_percent=$(echo "scale=2; $climate_risk * 100" | bc)
    local anthro_percent=$(echo "scale=2; $anthro_risk * 100" | bc)
    local quantum_percent=$(echo "scale=8; $quantum_risk * 100" | bc)
    
    sleep 0.3
    draw_risk_gauge $geo_percent "Geological"
    sleep 0.2
    draw_risk_gauge $astro_percent "Astronomical"
    sleep 0.2
    draw_risk_gauge $climate_percent "Climate"
    sleep 0.2
    draw_risk_gauge $anthro_percent "Anthropic"
    sleep 0.2
    draw_risk_gauge $quantum_percent "Quantum/Physics"
    echo ""
    
    # Quantum entanglement visualization
    sleep 0.5
    quantum_entanglement_visual
    
    # Monte Carlo simulation with visual effects
    echo -e "${MAGENTA}${BOLD}Executing Quantum Monte Carlo Iterations...${RESET}"
    echo ""
    
    local batch_size=100
    local batches=$((SIMULATION_RUNS / batch_size))
    
    for ((batch=0; batch<batches; batch++)); do
        for ((i=0; i<batch_size; i++)); do
            local q_state=$((RANDOM % QUANTUM_STATES))
            local q_amplitude=$(quantum_superposition $q_state)
            local q_modifier=$(echo "scale=6; 1 + ($q_amplitude * 0.1)" | bc -l)
            
            local geo_climate_entangled=$(quantum_entangle $geo_risk $climate_risk)
            local anthro_climate_entangled=$(quantum_entangle $anthro_risk $climate_risk)
            
            local mod_geo=$(echo "scale=8; $geo_risk * $q_modifier" | bc -l)
            local mod_astro=$(echo "scale=8; $astro_risk * $q_modifier" | bc -l)
            local mod_climate=$(echo "scale=8; ($climate_risk + $geo_climate_entangled * 0.05) * $q_modifier" | bc -l)
            local mod_anthro=$(echo "scale=8; ($anthro_risk + $anthro_climate_entangled * 0.03) * $q_modifier" | bc -l)
            local mod_quantum=$(echo "scale=8; $quantum_risk * $q_modifier" | bc -l)
            
            local combined_prob=$(echo "scale=8; 1 - ((1 - $mod_geo) * (1 - $mod_astro) * (1 - $mod_climate) * (1 - $mod_anthro) * (1 - $mod_quantum))" | bc -l)
            
            local extinction=$(quantum_collapse $combined_prob)
            extinction_count=$((extinction_count + extinction))
        done
        
        progress_bar_animated $((batch * batch_size + batch_size)) $SIMULATION_RUNS
        
        # Particle effect every few batches
        if [ $((batch % 10)) -eq 0 ]; then
            echo ""
            local particle_density=$((extinction_count * 100 / ((batch + 1) * batch_size)))
            quantum_particle_effect $particle_density "Extinction Events Detected"
        fi
    done
    
    echo ""
    echo ""
    
    # Wavefunction collapse animation
    collapsing_wavefunction
    
    # Calculate final probability
    local extinction_probability=$(echo "scale=4; ($extinction_count * 100) / $SIMULATION_RUNS" | bc -l)
    local survival_probability=$(echo "scale=4; 100 - $extinction_probability" | bc -l)
    
    # Display results with wave patterns
    echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${GREEN}${BOLD}║                    QUANTUM RESULTS                             ║${RESET}"
    echo -e "${GREEN}${BOLD}╚════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    
    draw_probability_wave $extinction_probability "Extinction Probability Wave:"
    
    echo -e "  ${RED}Extinction Probability: ${BOLD}${extinction_probability}%${RESET}"
    echo -e "  ${GREEN}Survival Probability: ${BOLD}${survival_probability}%${RESET}"
    echo -e "  ${CYAN}Extinction Events: ${extinction_count} / ${SIMULATION_RUNS}${RESET}"
    echo ""
    
    # Store results
    echo "$timeframe_name|$timeframe|$extinction_probability|$survival_probability" >> "$OUTPUT_DIR/simulation_results.txt"
    
    sleep 1
}

# ============================================================================
# ENHANCED VISUALIZATION
# ============================================================================

draw_probability_chart() {
    echo ""
    echo -e "${MAGENTA}${BOLD}╔════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${MAGENTA}${BOLD}║       QUANTUM EARTH TIMELINE - PROBABILITY SPECTRUM            ║${RESET}"
    echo -e "${MAGENTA}${BOLD}╚════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    
    if [ ! -f "$OUTPUT_DIR/simulation_results.txt" ]; then
        echo "No results available"
        return
    fi
    
    while IFS='|' read -r name timeframe extinction survival; do
        local bar_length=$(echo "scale=0; $extinction / 2" | bc)
        local bar=""
        
        # Animated bar growth
        printf "  %-15s " "$name"
        echo -n "["
        
        for ((i=0; i<=bar_length; i++)); do
            if [ $i -lt 16 ]; then
                echo -ne "${GREEN}█${RESET}"
            elif [ $i -lt 33 ]; then
                echo -ne "${YELLOW}█${RESET}"
            else
                echo -ne "${RED}█${RESET}"
            fi
            sleep 0.01
        done
        
        printf "] %.2f%%\n" "$extinction"
        
    done < "$OUTPUT_DIR/simulation_results.txt"
    
    echo ""
}

generate_timeline_visualization() {
    echo ""
    echo -e "${CYAN}${BOLD}╔════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}${BOLD}║              EARTH'S QUANTUM HABITABILITY TIMELINE             ║${RESET}"
    echo -e "${CYAN}${BOLD}╚════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    
    # Animate timeline appearance
    local lines=(
        "           ${GREEN}NOW${RESET}"
        "            ${CYAN}|${RESET}"
        "            ${CYAN}├───${RESET} ${YELLOW}100 years${RESET} ────► ${RED}Anthropic risks peak${RESET}"
        "            ${CYAN}|${RESET}"
        "            ${CYAN}├───${RESET} ${YELLOW}1,000 years${RESET} ──► ${RED}Climate tipping points${RESET}"
        "            ${CYAN}|${RESET}"
        "            ${CYAN}├───${RESET} ${YELLOW}10K years${RESET} ────► ${MAGENTA}Supervolcano cycle${RESET}"
        "            ${CYAN}|${RESET}"
        "            ${CYAN}├───${RESET} ${YELLOW}100K years${RESET} ───► ${BLUE}Ice age cycles${RESET}"
        "            ${CYAN}|${RESET}"
        "            ${CYAN}├───${RESET} ${YELLOW}1M years${RESET} ─────► ${RED}Major asteroid impacts${RESET}"
        "            ${CYAN}|${RESET}"
        "            ${CYAN}├───${RESET} ${YELLOW}100M years${RESET} ───► ${MAGENTA}Tectonic reshaping${RESET}"
        "            ${CYAN}|${RESET}"
        "            ${CYAN}└───${RESET} ${YELLOW}1B years${RESET} ─────► ${RED}Solar luminosity↑${RESET}"
        "                      ${CYAN}|${RESET}"
        "                      ${CYAN}└───${RESET} ${YELLOW}5B years${RESET} ─────► ${RED}${BOLD}Sun → Red Giant${RESET}"
    )
    
    for line in "${lines[@]}"; do
        echo -e "$line"
        sleep 0.15
    done
    
    echo ""
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

banner() {
    clear
    echo -e "${GREEN}${BOLD}"
    echo "╔═══════════════════════════════════════════════════════════════════╗"
    echo "║                                                                   ║"
    echo "║        ██████  ██    ██  █████  ███    ██ ████████ ██    ██       ║"
    echo "║       ██    ██ ██    ██ ██   ██ ████   ██    ██    ██    ██       ║"
    echo "║       ██    ██ ██    ██ ███████ ██ ██  ██    ██    ██    ██       ║"
    echo "║       ██ ▄▄ ██ ██    ██ ██   ██ ██  ██ ██    ██    ██    ██       ║"
    echo "║        ██████   ██████  ██   ██ ██   ████    ██     ██████        ║"
    echo "║           ▀▀                                                      ║"
    echo "║                                                                   ║"
    echo "║              EARTH TIMELINE CALCULATOR v2.0                       ║"
    echo "║                                                                   ║"
    echo "║         Quantum Probabilistic Analysis of Planetary               ║"
    echo "║              Habitability & Extinction Events                     ║"
    echo "║                                                                   ║"
    echo "╚═══════════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo ""
    
    # Matrix effect intro
    matrix_effect
}

initialize() {
    typewriter_effect "⚛️  Initializing Quantum Earth Timeline Calculator..." 0.03
    echo ""
    
    # Create directories
    mkdir -p "$OUTPUT_DIR"
    mkdir -p "$DATA_DIR"
    
    # Clear previous results
    rm -f "$OUTPUT_DIR/simulation_results.txt"
    
    # Animated initialization
    local tasks=("Quantum Field Calibration" "Monte Carlo Engine" "Risk Assessment Modules" "Visualization Systems" "Data Storage")
    
    for task in "${tasks[@]}"; do
        echo -ne "  ${CYAN}▶${RESET} $task..."
        sleep 0.3
        echo -e " ${GREEN}✓${RESET}"
    done
    
    echo ""
    typewriter_effect "✓ All systems operational" 0.03
    echo ""
    sleep 0.5
}

main() {
    banner
    initialize
    
    # Define timeframes to analyze
    declare -A timeframes
    timeframes=(
        ["100_years"]=100
        ["1K_years"]=1000
        ["10K_years"]=10000
        ["100K_years"]=100000
        ["1M_years"]=1000000
        ["10M_years"]=10000000
        ["100M_years"]=100000000
        ["1B_years"]=1000000000
    )
    
    # Run simulations for each timeframe
    for tf_name in "100_years" "1K_years" "10K_years" "100K_years" "1M_years" "10M_years" "100M_years" "1B_years"; do
        run_monte_carlo_simulation ${timeframes[$tf_name]} $tf_name
        echo "────────────────────────────────────────────────────────────────────"
    done
    
    # Generate visualizations
    generate_timeline_visualization
    draw_probability_chart
    
    # Final summary
    echo ""
    echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${GREEN}${BOLD}║                    ANALYSIS COMPLETE                           ║${RESET}"
    echo -e "${GREEN}${BOLD}╚════════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    
    typewriter_effect "📊 Key Findings:" 0.02
    echo ""
    echo -e "  ${YELLOW}•${RESET} Near-term (100-1000y): ${RED}Anthropic factors dominate${RESET}"
    echo -e "  ${YELLOW}•${RESET} Medium-term (10K-100Ky): ${MAGENTA}Geological events significant${RESET}"
    echo -e "  ${YELLOW}•${RESET} Long-term (1M+y): ${BLUE}Astronomical events dominate${RESET}"
    echo -e "  ${YELLOW}•${RESET} Quantum risks: ${CYAN}Theoretical, extremely low${RESET}"
    echo ""
    echo -e "${CYAN}📁 Results: $OUTPUT_DIR/simulation_results.txt${RESET}"
    echo ""
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${YELLOW}⚠️  DISCLAIMER:${RESET} These are probabilistic estimates based on"
    echo -e "   current scientific understanding. Actual outcomes depend on"
    echo -e "   countless variables and human actions."
    echo ""
    echo -e "${MAGENTA}   \"The future is not set. There is no fate but what we make.\"${RESET}"
    echo ""
    echo -e "${GREEN}   Thank you for using Quantum Earth Timeline Calculator v2.0${RESET}"
    echo ""
}

# Run main program
main