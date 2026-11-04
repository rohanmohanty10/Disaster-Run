 
 

return {
    { 42, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.HumanoidRootPart.AuraStart);
        end },
    { 108, function(p4, p5, p6) -- Line: 8
            shared.vfx.emit(p6);
        end }
};