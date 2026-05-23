DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$DIR/.." && pwd)"

echo $DIR
echo $ROOT

. "$DIR/funcs.sh"
. ~/.lib.sh

# bash funcs
alias scriptrepo="code ../../"
alias reload=". ~/.bash_profile"

# aspire
alias aspclean="pwsh ../pwsh/aspire_clean.ps1"