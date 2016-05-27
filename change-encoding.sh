# This script converts all the source files into CP1251

from=cp1251
to=utf8

function convert {
  for file in `find . -name '*.tex' | grep -v $to`; do
    convname=`echo $file | sed "s/\.tex/\.$to\.tex/"`
    [ -f $convname ] && rm $convname
    echo "conv $file --> $convname"
    iconv -f $from -t $to "$file" > $convname
  done

  for file in `find . -name '*.bib' | grep -v $to`; do
    convname=`echo $file | sed "s/\.bib/\.$to\.bib/"`
    [ -f $convname ] && rm $convname
    echo "conv $file --> $convname"
    iconv -f $from -t $to "$file" > $convname
  done
}

function move {
  for file in `find . -name "*.$to.tex" | grep -v git`; do
    mvname=`echo $file | sed "s/\.$to//"`
    # echo "mv $file --> $mvname"
    mv -v "$file" "$mvname"
  done

  for file in `find . -name "*.$to.bib" | grep -v git`; do
    mvname=`echo $file | sed "s/\.$to//"`
    # echo "mv $file --> $mvname"
    mv -v "$file" "$mvname"
  done
}

function remove {
  for file in `find . -name "*$to*" | grep -v git`; do
    rm -v "$file"
  done
}

case $1 in
  -c|--convert)
    convert
    ;;
  -m|--move)
    move
    ;;
  -r|--remove)
    remove
    ;;
  *)
    echo 'You need to provide either -c or -m argument'
esac
