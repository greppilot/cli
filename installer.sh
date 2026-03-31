#!/usr/bin/env bash
set -euo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

CLI_URL="https://raw.githubusercontent.com/greppilot/cli/main/greppilot"

echo -e "${CYAN}Installing Greppilot CLI...${NC}"

# ── Prerequisites ─────────────────────────────────────────────────────────────

for cmd in docker curl; do
  if ! command -v "$cmd" &>/dev/null; then
    echo -e "${RED}Required tool not found: $cmd${NC}"
    echo "Install $cmd and re-run: curl https://get.greppilot.com | bash"
    exit 1
  fi
done

if ! docker compose version &>/dev/null 2>&1; then
  echo -e "${RED}docker compose (v2) not found.${NC}"
  echo "Install Docker Desktop or the Docker Compose plugin and re-run."
  exit 1
fi

# ── Install ───────────────────────────────────────────────────────────────────

if [[ -w "/usr/local/bin" ]]; then
  INSTALL_PATH="/usr/local/bin/greppilot"
else
  INSTALL_PATH="$HOME/.local/bin/greppilot"
  mkdir -p "$HOME/.local/bin"
fi

curl -fsSL "$CLI_URL" -o "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo -e "${GREEN}✓ Greppilot CLI installed to $INSTALL_PATH${NC}"

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && [[ "$INSTALL_PATH" == "$HOME/.local/bin/greppilot" ]]; then
  if [[ -f "$HOME/.zshrc" ]]; then
    PROFILE="$HOME/.zshrc"
  elif [[ -f "$HOME/.bashrc" ]]; then
    PROFILE="$HOME/.bashrc"
  else
    PROFILE="$HOME/.profile"
  fi
  echo '' >> "$PROFILE"
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$PROFILE"
  export PATH="$HOME/.local/bin:$PATH"
  echo -e "${GREEN}✓ Added ~/.local/bin to PATH in $PROFILE${NC}"
fi
echo ""
echo "Run: greppilot install"
echo ""
