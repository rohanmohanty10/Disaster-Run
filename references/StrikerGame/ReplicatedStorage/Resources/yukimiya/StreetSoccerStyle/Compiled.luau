 
 

return {
    { 112, function(p1, p2) -- Line: 3
            if p2 then
                shared.vfx.emit(p2.CamPart.CamVFX.yukipaintsplatter);
            end;
        end },
    { 145, function(p3, p4) -- Line: 10
            shared.vfx.emit(p3.WORDS.SHOOT);
        end },
    { 194, function(p5, p6) -- Line: 15
            shared.vfx.emit(p5.WORDS.FAKE);
        end },
    { 254, function(p7, p8) -- Line: 20
            shared.vfx.emit(p7.WORDS.CUTIN);
        end }
};