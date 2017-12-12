# Ping a server with a terminal notification when server successfully pings
function nping() {
    local args=
    local pushover=
    for arg in "$@"; do
        case $arg in
            -p|--pushover)
                pushover=1
                ;;
            *)
                args="$args $arg"
        esac
    done

    ping -t1 -c1 $args > /dev/null 2>&1
    local ret=$?
    if [ $ret -eq 0 ]; then
        >&2 echo "error: host still pingable..."
        return
    elif [ $ret -ne 2 ]; then
        >&2 echo "error: ping exited with error code=$ret"
        return
    fi

    ping -o $args
    local ret=$?

    if [ $ret -eq 0 ]; then
        # Only notify if we recieved a packet... don't send notification if we
        # for example Ctrl-C'd
        terminal-notifier -message "ping $args" -title "Ping Finished" -sound default -group ping

        if [ -n "$pushover" ]; then
            curl https://api.pushover.net/1/messages.json \
                -F "token=$NPING_PUSHOVER_TOKEN" \
                -F "user=$NPING_PUSHOVER_USER" \
                -F "title=Ping Finished" \
                -F "message=ping $args" > /dev/null 2>&1
        fi
    fi
}
