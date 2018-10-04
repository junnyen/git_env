CSCOPE_FILE=cscope.out
if [ -n "$1" ]; then
  echo "Source code directory: " $1
  echo "Create file map : " $CSCOPE_FILE
  find -L $1 -name "*.h" -o -name "*.c" > $CSCOPE_FILE
  cscope -Rbkq -i ./$CSCOPE_FILE
  # cscope -Rbkq
  ctags -R
else
  echo "Please key-in path of project"
fi 
