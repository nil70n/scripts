DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$DIR/.." && pwd)"

. "$DIR/funcs.sh"
. ~/.lib.sh

# bash funcs
alias scriptrepo="code $ROOT"
alias reload=". ~/.bash_profile"

# aspire
alias aspclean="pwsh $ROOT_DIR/pwsh/aspire_clean.ps1"