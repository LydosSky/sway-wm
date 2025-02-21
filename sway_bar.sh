# Change this according to your device
################
# Variables
################


# Date and time
date_and_week=$(date "+%m/%d/%Y (week %-V)")
current_time=$(date +"%I:%M %p")

#############
# Commands
#############

# Battery or charger
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

# Audio and multimedia
#audio_volume=$(pamixer --sink `pactl list sinks short | grep RUNNING | awk '{print $1}'` --get-volume)
audio_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
audio_is_muted=$(pamixer --sink `pactl list sinks short | grep RUNNING | awk '{print $1}'` --get-mute)
media_artist=$(playerctl metadata artist)
media_song=$(playerctl metadata title)
player_status=$(playerctl status)

speed=$(ifstat -i enx00e04c360150 1 1 | awk 'NR>2 {printf "In: %.2f Mb/s Out: %.2f Mb/s\n", $1 * 0.008, $2 * 0.008}')

if [ $audio_is_muted = "true" ]
then
    audio_active='󰝟'
else
    audio_active='󰕾'
fi

# echo "🎧 $song_status $media_artist - $media_song | ⌨ $language | $network_active $interface_easyname ($ping ms) | 🏋 $loadavg_5min | $audio_active $audio_volume% | $battery_pluggedin $battery_charge | $date_and_week 🕘 $current_time"
echo "$media_artist - $media_song | $date_and_week $current_time | ⇆ $speed |  $audio_active $audio_volume |  $battery_charge | "
