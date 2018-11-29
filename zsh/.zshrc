# Executes commands at the start of an interactive session.
# Author: Tom Scogland

# use a decent version...
# TODO: make this more general
if [[ $ZSH_VERSION < "5.0.0" ]] ; then
  [[ -x ~/programs/chaos_5_x86_64_ib/bin/zsh ]] && exec ~/programs/chaos_5_x86_64_ib/bin/zsh
fi

mkdir -p ~/.cache/zsh
export ZSH_CACHE_DIR=~/.cache/zsh

# ensure my funcs, and prompts are there before load
fpath=($ZDOTDIR/funcs $fpath)

if ssh-add -l >& /dev/null ; then
  echo ${SSH_AUTH_SOCK} > ~/.cache/current-auth
else
  auth_sock="$(cat ~/.cache/current-auth)"
  if [[ -S $auth_sock ]] ; then
    export SSH_AUTH_SOCK=$auth_sock
    if ssh-add -l >& /dev/null ; then
    else
      echo warning: no auth
      unset SSH_AUTH_SOCK
    fi
  fi
fi

if infocmp xterm-256color-italic >& /dev/null ; then
else
  cat > /tmp/xterm-256-italic.terminfo <<EOF
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
EOF
  tic -x /tmp/xterm-256-italic.terminfo
fi


if infocmp tmux-256color >& /dev/null ; then
else
  cat > /tmp/tmux.terminfo <<EOF
tmux-256color|tmux with 256 colors and italics,
	am, hs, km, mir, msgr, xenl,
	colors#0x100, cols#80, it#8, lines#24, pairs#0x10000,
	acsc=++\,\,--..00``aaffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~,
	bel=^G, blink=\E[5m, bold=\E[1m, cbt=\E[Z, civis=\E[?25l,
	clear=\E[H\E[J, cnorm=\E[34h\E[?25h, cr=\r,
	csr=\E[%i%p1%d;%p2%dr, cub=\E[%p1%dD, cub1=^H,
	cud=\E[%p1%dB, cud1=\n, cuf=\E[%p1%dC, cuf1=\E[C,
	cup=\E[%i%p1%d;%p2%dH, cuu=\E[%p1%dA, cuu1=\EM,
	cvvis=\E[34l, dch=\E[%p1%dP, dch1=\E[P, dim=\E[2m,
	dl=\E[%p1%dM, dl1=\E[M, dsl=\E]0;\007, ed=\E[J, el=\E[K,
	el1=\E[1K, enacs=\E(B\E)0, flash=\Eg, fsl=^G, home=\E[H,
	hpa=\E[%i%p1%dG, ht=^I, hts=\EH, ich=\E[%p1%d@,
	il=\E[%p1%dL, il1=\E[L, ind=\n, indn=\E[%p1%dS,
	invis=\E[8m, is2=\E)0, kDC=\E[3;2~, kEND=\E[1;2F,
	kHOM=\E[1;2H, kIC=\E[2;2~, kLFT=\E[1;2D, kNXT=\E[6;2~,
	kPRV=\E[5;2~, kRIT=\E[1;2C, kbs=^H, kcbt=\E[Z, kcub1=\EOD,
	kcud1=\EOB, kcuf1=\EOC, kcuu1=\EOA, kdch1=\E[3~,
	kend=\E[4~, kf1=\EOP, kf10=\E[21~, kf11=\E[23~,
	kf12=\E[24~, kf13=\E[1;2P, kf14=\E[1;2Q, kf15=\E[1;2R,
	kf16=\E[1;2S, kf17=\E[15;2~, kf18=\E[17;2~,
	kf19=\E[18;2~, kf2=\EOQ, kf20=\E[19;2~, kf21=\E[20;2~,
	kf22=\E[21;2~, kf23=\E[23;2~, kf24=\E[24;2~,
	kf25=\E[1;5P, kf26=\E[1;5Q, kf27=\E[1;5R, kf28=\E[1;5S,
	kf29=\E[15;5~, kf3=\EOR, kf30=\E[17;5~, kf31=\E[18;5~,
	kf32=\E[19;5~, kf33=\E[20;5~, kf34=\E[21;5~,
	kf35=\E[23;5~, kf36=\E[24;5~, kf37=\E[1;6P, kf38=\E[1;6Q,
	kf39=\E[1;6R, kf4=\EOS, kf40=\E[1;6S, kf41=\E[15;6~,
	kf42=\E[17;6~, kf43=\E[18;6~, kf44=\E[19;6~,
	kf45=\E[20;6~, kf46=\E[21;6~, kf47=\E[23;6~,
	kf48=\E[24;6~, kf49=\E[1;3P, kf5=\E[15~, kf50=\E[1;3Q,
	kf51=\E[1;3R, kf52=\E[1;3S, kf53=\E[15;3~, kf54=\E[17;3~,
	kf55=\E[18;3~, kf56=\E[19;3~, kf57=\E[20;3~,
	kf58=\E[21;3~, kf59=\E[23;3~, kf6=\E[17~, kf60=\E[24;3~,
	kf61=\E[1;4P, kf62=\E[1;4Q, kf63=\E[1;4R, kf7=\E[18~,
	kf8=\E[19~, kf9=\E[20~, khome=\E[1~, kich1=\E[2~,
	kind=\E[1;2B, kmous=\E[M, knp=\E[6~, kpp=\E[5~,
	kri=\E[1;2A, nel=\EE, op=\E[39;49m, rc=\E8, rev=\E[7m,
	ri=\EM, ritm=\E[23m, rmacs=^O, rmcup=\E[?1049l, rmir=\E[4l,
	rmkx=\E[?1l\E>, rmso=\E[27m, rmul=\E[24m,
	rs2=\Ec\E[?1000l\E[?25h, sc=\E7,
	setab=\E[%?%p1%{8}%<%t4%p1%d%e%p1%{16}%<%t10%p1%{8}%-%d%e48;5;%p1%d%;m,
	setaf=\E[%?%p1%{8}%<%t3%p1%d%e%p1%{16}%<%t9%p1%{8}%-%d%e38;5;%p1%d%;m,
	sgr=\E[0%?%p6%t;1%;%?%p1%t;7%;%?%p2%t;4%;%?%p3%t;7%;%?%p4%t;            5%;%?%p5%t;2%;m%?%p9%t\016%e\017%;,
	sgr0=\E[m\017, sitm=\E[3m, smacs=^N, smcup=\E[?1049h,
	smir=\E[4h, smkx=\E[?1h\E=, smso=\E[7m, smul=\E[4m,
	tbc=\E[3g, tsl=\E]0;, vpa=\E[%i%p1%dd,
EOF
  tic -x /tmp/tmux.terminfo
fi

if infocmp $TERM >& /dev/null ; then
else
  echo $TERM: terminfo unavailable, falling back to xterm-256color
  export TERM=xterm-256color
fi


# prezto style settings
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:git:status:ignore' submodules 'all'
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'github_rsa'
zstyle ':prezto:module:syntax-highlighting' highlighters \
  'main' \
  'brackets' \
  'pattern' \
  'line' \
  'root'

if (( ! $+commands[antibody] )) ; then
  if (( $+commands[brew] )) ; then
    brew install getantibody/tap/antibody
  elif (( $+commands[go] )) ; then
    go get -v github.com/getantibody/antibody
  else
    echo Install go or brew!
  fi
fi


_ab_dir=${HOME}/.cache/antibody
_ab_path=$_ab_dir/init.zsh

function zupdate() {
  mkdir -p $_ab_dir
  rm -f $_ab_path
  antibody bundle < $ZDOTDIR/antibody_bundles.txt > $_ab_path
}
if [[ ! -s $_ab_path ]]; then
  zupdate
fi

# source antibody output
source $_ab_path

# load my prompt, must be after async loads
autoload -Uz promptinit && promptinit
prompt mypure

source $ZDOTDIR/completions.zsh
compdef bmake=make
compdef bcmake=cmake

roothosts=(storm vortex deb hurricane gale wind)
if [[ ${roothosts[(i)$HOST]} -le ${#roothosts} ]] ; then
  export gotroot=1
fi

export HISTFILE=~/.cache/zsh/zhistory

# use the builtin, seriously...
if typeset -f '[' > /dev/null ; then
  unset -f '['
fi

# Turn off the stop key binding
stty -ixon

# this is a re-work of z from oh-my-zsh
export _Z_NO_PROMPT_COMMAND=1
export _Z_DATA=$ZSH_CACHE_DIR/z-dirjump-list.txt
# export _Z_OWNER=$USER
. $ZDOTDIR/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}

if [ -x "$(which spack)" ] ; then
  SPACKDIR=$(dirname $(dirname $(which spack )))
  export MODULEPATH=${SPACKDIR}/share/spack/modules:${MODULEPATH}

  #TODO: takes WAY too long
  # source ${SPACKDIR}/share/spack/setup-env.sh

  # using links in programs dir
  # for PKG in git python tmux vim task taskd ruby tmuxinator the_silver_searcher; do
    #   spack use $PKG
    # done
fi

# pull in aliases
source $ZDOTDIR/aliases
# pull in backwards compatibility bindings for screen, etc.
  source $ZDOTDIR/bindings

# completion
setopt ALWAYS_TO_END


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# make tmux behave with bracketed paste supporting terminals
if [ ${TMUX} ]; then
  unset zle_bracketed_paste
fi

if [[ -x fzf && -f ~/.fzf.zsh ]] ; then
  . ~/.fzf.zsh
fi
