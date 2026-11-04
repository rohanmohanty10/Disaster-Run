 
 

return {
    { 23, function(p1) -- Line: 3
            shared.vfx.emit(p1.VFXHERE.Speedlines1);
            shared.vfx.emit(p1.VFXHERE.ScreenEffect);
        end },
    { 63, function(p2) -- Line: 9
            shared.vfx.emit(p2["1st evil dude"]);
        end },
    { 296, function(p3) -- Line: 14
            shared.vfx.emit(p3.VFXHERE.Beamplaceholder2);
        end },
    { 459, function(p4) -- Line: 19
            shared.vfx.emit(p4.VFXHERE.Beamplaceholder3);
        end },
    { 829, function(p5) -- Line: 24
            shared.vfx.emit(p5.VFXHERE.BeamPlaceholder);
        end }
};