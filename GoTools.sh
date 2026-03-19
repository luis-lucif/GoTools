#!/bin/bash

cat << "EOF"
    __________      _____   ________________    __    __ 
   / ____/ __ \    /  _/ | / / ___/_  __/   |  / /   / / 
  / / __/ / / /    / //  |/ /\__ \ / / / /| | / /   / /  
 / /_/ / /_/ /  _/ // /|  /___/ // / / ___ |/ /___/ /___
 \____/\____/  /___/_/ |_//____//_/ /_/  |_/_____/_____/
                                                        
EOF

echo "Iniciando el script..."

GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RED="\033[0;31m"
NC="\033[0m"

echo -e "${BLUE}[*] Iniciando el script de instalación...${NC}"

GO_BIN_PATH="$HOME/go/bin"
mkdir -p $GO_BIN_PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if [[ "$SHELL" == *"zsh"* ]]; then
  RC_FILE="$HOME/.zshrc"
else
  RC_FILE="$HOME/.bashrc"
fi

if ! grep -q 'export GOPATH=$HOME/go' "$RC_FILE"; then
  echo -e '\n# Configuración de Go' >> "$RC_FILE"
  echo 'export GOPATH=$HOME/go' >> "$RC_FILE"
  echo 'export PATH=$PATH:$GOPATH/bin' >> "$RC_FILE"
fi

declare -A GO_TOOLS
GO_TOOLS=(
  [lfifinder]="github.com/rix4uni/lfifinder@latest"
  [naabu]="github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
  [gourlex]="github.com/trap-bytes/gourlex@latest"
  [xss-scanner]="github.com/haxshadow/cxss@latest"
  [cspfinder]="github.com/rix4uni/cspfinder@latest"
  [ipfinder]="github.com/rix4uni/ipfinder@latest"
  [emailextactor]="github.com/rix4uni/emailextractor@latest"
  [chaos]="github.com/projectdiscovery/chaos-client/cmd/chaos@latest"
  [asnmap]="github.com/projectdiscovery/asnmap/cmd/asnmap@latest"
  [github-subdomain]="github.com/gwen001/github-subdomains@latest"
  [quickpress]="github.com/incogbyte/quickpress@latest"
  [goDorks]="github.com/dwisiswant0/go-dork@latest"
  [urlfinder]="github.com/projectdiscovery/urlfinder/cmd/urlfinder@latest"
  [kxss]="github.com/Emoe/kxss@latest"
  [gxss]="github.com/KathanP19/Gxss@latest"
  [qsreplace]="github.com/tomnomnom/qsreplace@latest"
  [assetfinder]="github.com/tomnomnom/assetfinder@latest"
  [anew]="github.com/tomnomnom/anew@latest"
  [gowitness]="github.com/sensepost/gowitness@latest"
  [subzy]="github.com/PentestPad/subzy@latest"
  [puredns]="github.com/d3mondev/puredns/v2@latest"
  [amass]="github.com/owasp-amass/amass/v4/cmd/amass@latest"
  [alterx]="github.com/projectdiscovery/alterx/cmd/alterx@latest"
  [dnsx]="github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
  [gau]="github.com/lc/gau/v2/cmd/gau@latest"
  [gf]="github.com/tomnomnom/gf@latest"
  [gospider]="github.com/jaeles-project/gospider@latest"
  [gosqli]="github.com/sqlmapproject/gosqli/cmd/gosqli@latest"
  [hakrawler]="github.com/hakluke/hakrawler@latest"
  [httprobe]="github.com/tomnomnom/httprobe@latest"
  [httpx]="github.com/projectdiscovery/httpx/cmd/httpx@latest"
  [katana]="github.com/projectdiscovery/katana/cmd/katana@latest"
  [nuclei]="github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
  [shuffledns]="github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest"
  [subfinder]="github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
  [subjs]="github.com/lc/subjs@latest"
  [waybackurls]="github.com/tomnomnom/waybackurls@latest"
)

for tool in "${!GO_TOOLS[@]}"; do
  path=${GO_TOOLS[$tool]}
  echo -e "${YELLOW}[+] Instalando $tool...${NC}"
  go install -v $path
done

if command -v nuclei &> /dev/null; then
  nuclei -ut
fi

echo -e "\n${GREEN}--- ¡Proceso completado! ---${NC}"
echo -e "Ejecuta: ${YELLOW}source $RC_FILE${NC} para activar las herramientas."
