#!/usr/bin/awk 

substr($0, 2, 5) ~ /\[ [0-9]\]/ {
	if ($2 == "0]") next;
	value=sprintf("%s%d,", value, strtonum("0x" $5));
	name=sprintf("%s%s,", name, substr($3, 2, length($3)-1));
	len=sprintf("%s%d,", len, strtonum("0x" $7));
}
substr($0, 2, 5) ~ /\[[0-9][0-9]\]/ {
	value=sprintf("%s%d,", value, strtonum("0x" $4));
	name=sprintf("%s%s,", name, substr($2, 2, length($2)-1));
	len=sprintf("%s%d,", len, strtonum("0x" $6));
}

END {
	split(name, aname, ",");
	split(value, avalue, ",");
	split(len, alen, ",");
	for (i = 1 ; i <= length(aname) ; i++) {
		printf("%20s %8s %5s\n", aname[i], avalue[i], alen[i]) > "/dev/stderr";
	}
	printf "%s;%s;%s\n", name, value, len;
}
