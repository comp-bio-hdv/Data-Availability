{
        substr_before = substr($0, 1, SL1P - 1)
        #pos1 = index(substr_before, SL2)
	pos1=0
	for (i = 1; i < SL1P; i++) {
		if (substr($0, i, length(SL2)) == SL2) {
			pos1=i
		}
	}	
	if (pos1 > 0) {
            print "amber/w: " AW " file: " ID " sl1: " SL1P " sl2: " pos1 " distance: "SL1P-pos1
        }
}
