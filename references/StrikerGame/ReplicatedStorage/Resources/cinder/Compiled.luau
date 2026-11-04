 
 

return {
    { 14, function(p1) -- Line: 3
            shared.vfx.emit(p1.kickup);
        end },
    { 35, function(p2) -- Line: 8
            shared.vfx.emit(p2.JumpVFX);
        end },
    { 46, function(p3, p4) -- Line: 13
            shared.vfx.emit(p3.KickVFX);
            shared.vfx.emit(p4.Highlight);
        end }
};