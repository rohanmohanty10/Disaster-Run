 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1.AuraImpact);
        end },
    { 9, function(p2) -- Line: 8
            shared.vfx.emit(p2.InsaneAura);
        end },
    { 250, function(p3) -- Line: 13
            shared.vfx.emit(p3.After);
        end }
};