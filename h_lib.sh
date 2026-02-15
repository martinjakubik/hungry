# sets up usage
USAGE="usage: $0 --home -h [--days 3|-d 3] --office -o [-w | --what {Burrito, Ravioli, Burger, Pho, Sushi, Sushhhhiiiiiifdidiiiissqihiii}] --badminton -b [--when n]"

location=0
day_count=0
eat_intention=0
when_count=0
current_date=$1; shift;

# parses and reads command line arguments
while [ $# -gt 0 ]
do
  case "$1" in
    (--home) location="-1";;
    (-h) location="-1";;
    (--office) location=0;;
    (-o) location=0;;
    (--badminton) location=1;;
    (-b) location=1;;
    (--days) day_count="$2"; shift;;
    (-d=* | --days=*) day_count="${1#*=}";;
    (-d) day_count="$2"; shift;;
    (-w=* | --what=*) eat_intention_arg="${1#*=}";;
    (-w) eat_intention_arg="$2"; shift;;
    (--what) eat_intention_arg="$2"; shift;;
    (--when) when_count="$2"; shift;;
    (--when=*) when_count="${1#*=}";;
    (-*) echo >&2 ${USAGE}
    exit 1;;
  esac
  shift
done

if ! [[ "$when_count" =~ ^[0-9]+$ ]] || [[ "$when_count" -lt 0 ]]; then
    echo "Error: --when must be a positive integer" >&2
    exit 1
fi

case "$eat_intention_arg" in
   (Burrito) eat_intention=1;;
   (Ravioli) eat_intention=2;;
   (Burger) eat_intention=3;;
   (Pho) eat_intention=4;;
   (Sushi) eat_intention=5;;
   (Sushhhhiiiiiifdidiiiissqihiii) eat_intention=5;;
esac

if [[ location -eq -1 ]] ; then
  echo Awwww
  if [[ day_count -gt 1 && day_count -lt 5 ]] ; then
    echo One hopes that you feel better soon
  elif [[ day_count -gt 4 && day_count -lt 9 ]] ; then
    echo Wow that sounds serious.
  elif [[ day_count -gt 8 ]] ; then
    echo Wow that sounds really serious, wtf. Are you Ok?
  fi
elif [[ location -eq 1 ]] ; then
  echo Awwww 🏸
elif [[ location -eq 0 ]] ; then
  if [[ "$when_count" -eq 0 ]]; then
    echo -n "Meet in lobby at 12:00:00.001?"
  elif [[ "$when_count" -eq 1 ]]; then
    echo -n "12:00:00.001 in lobby tomorrow?"
  else
    echo -n "12:00:00.001 in lobby in $when_count days?"
  fi
  if [[ eat_intention -eq 1 ]] ; then
    echo " It's Burrrrittooo time!!!"
  elif [[ eat_intention -eq 2 ]] ; then
    echo " It's Raviooooooli time!!!"
  elif [[ eat_intention -eq 3 ]] ; then
    echo " It's Buuuuuuurger time!!!"
  elif [[ eat_intention -eq 4 ]] ; then
    echo " It's Phhooooooooo time!!!"
  elif [[ eat_intention -eq 5 ]] ; then
    if [[ "$(date -jf "%Y-%m-%d" $current_date +%a)" = "Fri" ]] ; then
      echo " It's Suuuuuuuushi time!!!"
    else
      echo " Whoa, it's $(date -jf "%Y-%m-%d" $current_date +%A)!"
    fi
  else
    echo
  fi
fi
