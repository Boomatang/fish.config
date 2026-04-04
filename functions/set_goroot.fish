function set_goroot

	set -f v (grep -PiI  'go ([+-]?(?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))?' go.mod | awk '{print $2}')

	set s "go"$v"*"
	set -f new_goroot (find ~/sdk -type d -name "$s" | sort -t'.' -k2,2n -k3,3n -k4,4n | tail -n 1)
	if test -z "$new_goroot"
		echo "no go version found in sdk directory for $v"
		# exit
	end
	echo $new_goroot
	set -f REMOVE_PATH $GOROOT"/bin"
	set PATH (string split ':' -- $PATH | string match -v $REMOVE_PATH | string join ':')

	set -gx GOROOT $new_goroot
	set -f new_path $GOROOT"/bin"
	set -gx PATH $PATH $new_path
end
