# sets up usage
USAGE="usage: $0 --home -h [--days 3|-d 3] --office -o [-w | --what {Burrito, Ravioli, Burger, Pho, Sushi, Sushhhhiiiiiifdidiiiissqihiii}] --badminton -b [--when {Mo, Tu, We, Th, Sh, 1, 2, 3, ...}]"

location=0
day_count=0
eat_intention=0
current_date=$1; shift;
when_option=""
hungry_message=""

# Configuration file support
hungry_config_directory="${HUNGRYCONFIGDIR:-$HOME/.config/h}"
config_file="$hungry_config_directory/config.h"

# Create config directory if it doesn't exist
mkdir -p "$hungry_config_directory"

# Create config file if it doesn't exist
if [[ ! -f "$config_file" ]]; then
  cat > "$config_file" << EOF
## hungry configuration file
## automatically created at $(date)
#
## example configuration (remove # to enable the line)
#
## Azure AD authentication
# team.webhook.tenant.id=<your-tenant-id>
# team.webhook.client.id=<your-client-id>
# team.webhook.client.secret=<your-client-secret>
#
## URL of Teams webhook to post message to a specific team
# team.webhook.url=<url>
# team.webhook.authentication ...
#
## calendar of activities
## name of activity
# activity.0.name=activityName
## days of week on which activity typically takes place (mon, tue, wed, thu, fri, sat, sun), comma or comma+whitespace separated
# activity.0.weekdays=activityWeekdays
## dates in the year on which activity does not take place (MM-DD formatted dates), comma or comma+whitespace separated
# activity.0.exceptiondays.<year>=activityExceptionDays
EOF
fi

# Read configuration file
config_values=()
while IFS= read -r line || [[ -n "$line" ]]; do
  # Skip comments and empty lines
  if [[ "$line" =~ ^[[:space:]]*# ]] || [[ -z "$line" ]]; then
    continue
  fi

  # Parse key-value pairs
  if [[ "$line" =~ ^[[:space:]]*([^=]+)=(.*)$ ]]; then
    key="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"
    # Trim whitespace from key and value
    key=$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    config_values+=("$key=$value")
  fi
done < "$config_file"

# Read tenant_id, client_id, client_secret from config
tenant_id=""
client_id=""
client_secret=""
for entry in "${config_values[@]}"; do
  case "$entry" in
    (team.webhook.tenant.id=*) tenant_id="${entry#team.webhook.tenant.id=}" ;;
    (team.webhook.client.id=*) client_id="${entry#team.webhook.client.id=}" ;;
    (team.webhook.client.secret=*) client_secret="${entry#team.webhook.client.secret=}" ;;
  esac
done

# If all are set, perform Azure AD token request and authenticated API call
if [[ -n "$tenant_id" && -n "$client_id" && -n "$client_secret" ]]; then
  # Get bearer token from Azure AD
  token_response=$(curl -s -X POST "https://login.microsoftonline.com/${tenant_id}/oauth2/v2.0/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "grant_type=client_credentials" \
    -d "client_id=${client_id}" \
    -d "client_secret=${client_secret}" \
    -d "scope=https://graph.microsoft.com/.default")
  bearer_token=$(echo "$token_response" | grep -o '"access_token":"[^"]*"' | cut -d'"' -f4)
  if [[ -z "$bearer_token" ]]; then
    echo "Failed to obtain bearer token from Azure AD." >&2
  else
    # Use bearer token to authenticate second POST request
    api_url="https://a9e783c64191e1c187e90717075a3b.4e.environment.api.powerplatform.com/powerautomate/automations/direct/workflows/f64b9f6c96ec451993e1901223aa87e0/triggers/manual/paths/invoke?api-version=1"
    json_body='{ "message": "This is the message" }'
    api_response=$(curl -s -X POST "$api_url" \
      -H "Authorization: Bearer $bearer_token" \
      -H "Content-Type: application/json" \
      -d "$json_body")
    echo "API response: $api_response"
  fi
fi

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
    (--when=*) when_option="${1#*=}";;
    (--when) when_option="$2"; shift;;
    (-*) echo >&2 ${USAGE}
    exit 1;;
  esac
  shift
done

case "$eat_intention_arg" in
   (Burrito) eat_intention=1;;
   (Ravioli) eat_intention=2;;
   (Burger) eat_intention=3;;
   (Pho) eat_intention=4;;
   (Sushi) eat_intention=5;;
   (Sushhhhiiiiiifdidiiiissqihiii) eat_intention=5;;
esac

nl='\n'
if [[ location -eq -1 ]] ; then
  hungry_message="Awwww"
  if [[ day_count -gt 1 && day_count -lt 5 ]] ; then
    hungry_message+="${nl}One hopes that you feel better soon"
  elif [[ day_count -gt 4 && day_count -lt 9 ]] ; then
    hungry_message+="${nl}Wow that sounds serious."
  elif [[ day_count -gt 8 ]] ; then
    hungry_message+="${nl}Wow that sounds really serious, wtf. Are you Ok?"
  fi
elif [[ location -eq 1 ]] ; then
  hungry_message="Awwww 🏸"
elif [[ location -eq 0 ]] ; then
  if [[ -n "$when_option" ]] ; then
    if [[ "$when_option" =~ ^-?[0-9]+$ ]] ; then
      if [[ "$when_option" -le 0 ]] ; then
        echo >&2 ${USAGE}
        exit 1
      elif [[ "$when_option" -eq 1 ]] ; then
          hungry_message="12:00:00.001 in lobby tomorrow?"
      else
        hungry_message="12:00:00.001 in lobby in $when_option days?"
      fi
    else
      case "$when_option" in
        (Mo) hungry_message="12:00:00.001 in lobby Monday?" ;;
        (Tu) hungry_message="12:00:00.001 in lobby Tuesday?" ;;
        (We) hungry_message="12:00:00.001 in lobby Wednesday?" ;;
        (Th) hungry_message="12:00:00.001 in lobby Thursday?" ;;
        (Sh) hungry_message="12:00:00.001 in lobby SushiDay?" ;;
        (*) hungry_message="Meet in lobby at 12:00:00.001?" ;;
      esac
    fi
  else
    hungry_message="Meet in lobby at 12:00:00.001?"
    if [[ eat_intention -eq 1 ]] ; then
      hungry_message+=" It's Burrrrittooo time!!!"
    elif [[ eat_intention -eq 2 ]] ; then
      hungry_message+=" It's Raviooooooli time!!!"
    elif [[ eat_intention -eq 3 ]] ; then
      hungry_message+=" It's Buuuuuuurger time!!!"
    elif [[ eat_intention -eq 4 ]] ; then
      hungry_message+=" It's Phhooooooooo time!!!"
    elif [[ eat_intention -eq 5 ]] ; then
      if [[ "$(date -jf "%Y-%m-%d" $current_date +%a)" = "Fri" ]] ; then
        hungry_message+=" It's Suuuuuuuushi time!!!"
      else
        hungry_message+=" Whoa, it's $(date -jf "%Y-%m-%d" $current_date +%A)!"
      fi
    fi
  fi
fi

printf '%b\n' "$hungry_message"