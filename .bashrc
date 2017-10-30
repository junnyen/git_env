# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
#added because of NS2
#export PATH=$NS_HOME/tcl8.4.5/unix:$NS_HOME/tk8.4.5/unix:$NS_HOME/bin:$NS_HOME/ns-2.28:$PATH
export PATH=$PATH:./
#export LD_LIBRARY_PATH=$NS_HOME/tcl8.4.5/unix:$NS_HOME/tk8.4.5/unix:$NS_HOME/otcl-1.9:$NS_HOME/lib:$LD_LIBRARY_PATH:/home/phd/sysrq/ns-allinone-2.32/otcl-1.13::/home/phd/sysrq/ns-allinone-2.32/lib
#export TCL_LIBRARY=$NS_HOME/tcl8.4.5/library:/home/phd/sysrq/ns-allinone-2.32/tcl8.4.15/library

#export LC_ALL="zh_TW.UTF-8"
#export LANG="zh_TW.UTF-8"
export SVN_EDITOR=vim
export GIT_EDITOR=vim


## Git Function
_gitlog()
{
   /usr/bin/git log --graph --pretty=oneline --abbrev-commit --decorate --date=relative--format=format:'%C(dim white)%h%C(reset) - %C(bold green)(%ar)%C(reset)%C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold%yellow)%d%C(reset)' --all
}

_gitdiff()
{
   git diff "$1^" "$1"
}


_gitdiffh()
{
   git diff "HEAD^"
}

if [ -f /usr/bin/git ]
then
  alias gitlog='_gitlog'
   alias gitdiff='_gitdiff'
   alias gitdiffh='_gitdiffh'
fi

