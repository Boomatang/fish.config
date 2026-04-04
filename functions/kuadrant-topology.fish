function kuadrant-topology
	set -l format -Tpng
	set -l location /tmp/kuadrant-topology.png
	set -l old_hash "does not exist"

	if test "$argv[1]" = "--svg"
		# icat is slower rendering svg's so by default use png
		set format -Tsvg
		set location /tmp/kuadrant-topology.svg
	end
	rm $location

	if test -f $location
		clear
		kitty icat $location
	end

	while true
		if test -f $location
			set old_hash (md5sum $location)
		end
		
		kubectl get cm topology -n kuadrant-system -o jsonpath='{.data.topology}' | dot $format > $location
		set -l new_hash (md5sum $location)

		if test $old_hash != $new_hash
			kitty icat --clear
			clear
			kitty icat $location
		end

		sleep 5
	end
end
