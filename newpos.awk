BEGIN {
    D1 = 20; D2 = 20; D3 = 80
}
{
    sequence = $0
    context = substr($0, 10, 79)
    
    pos = 1
    while (match(substr(sequence, pos), PERM)) {
        perm_pos = pos + RSTART - 1
        start = perm_pos + RLENGTH
        
        gttc_pos = start
        while (match(substr(sequence, gttc_pos), /GTTC/)) {
            sl1_pos = gttc_pos + RSTART - 1
            distance = perm_pos - sl1_pos
            
            if (distance < -D1 && distance > -D3) {
                printf " SL1 at:%d %s at:%d Distance:%d %s\n", 
                       sl1_pos-8, PERM, perm_pos-8, distance, context
            }
            
            gttc_pos = sl1_pos + 1
        }
        
        pos = perm_pos + 1
    }
}
