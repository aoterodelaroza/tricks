#! /usr/bin/awk -f

# converts seconds to days/hours/minutes/seconds format

{
    days = mins = hours = days = 0
    string = ""
    secs = $0
    if (secs > 60) {
	mins = int(secs/60)
	secs = secs - mins * 60
	if (mins > 60) {
	    hours = int(mins/60)
	    mins = mins - hours * 60
	    if (hours > 24) {
		days = int(hours/24)
		hours = hours - days * 24
	    }
	}
    }
    if (days)
	string = string " " days "d"
    if (hours)
	string = string " " hours "h"
    if (mins)
	string = string " " mins "m"
    if (secs)
	string = string " " secs "s"
    print string
}
