 
 

return {
    { 0, function(p1, p2) -- Line: 3
            p1.Impact({
                Character = p2
            });
            p1.Clash({
                Character = p2
            });
            p1.WindMesh({
                Character = p2
            });
        end },
    { 33, function(p3, p4) -- Line: 11
            p3.Wings({
                Character = p4
            });
            p3.Impact({
                Character = p4
            });
            p3.ImpactEnemy({
                Character = p4
            });
            p3.SpeedLines({
                Character = p4
            });
        end },
    { 38, function(p5, p6) -- Line: 20
            p5.RushMeshes({
                Character = p6
            });
        end }
};