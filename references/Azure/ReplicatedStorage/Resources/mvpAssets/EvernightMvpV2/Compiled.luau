 

 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2.thing2.Top.shine);
        end },
    { 52, function(p3, p4, p5) -- Line: 8
            if p5 then
                p5 = p5.CamPart;
            end;

            shared.vfx.emit(p3.vfx.beambg, p5);
        end },
    { 60, function(p6) -- Line: 13
            shared.vfx.emit(p6.vfx.fire);
        end },
    { 178, function(p7) -- Line: 18
            shared.vfx.emit(p7.EvernightStarRail.Head.eye2, p7.EvernightStarRail.Head.eye);
        end },
    { 287, function(p8) -- Line: 23
            shared.vfx.emit(p8.vfx.blackbg, p8.vfx.smack);
        end },
    { 473, function(p9) -- Line: 28
            shared.vfx.emit(p9.vfx.glasssmash);
        end },
    { 763, function(p10) -- Line: 33
            shared.vfx.emit(p10.EvernightStarRail.Head.longereyeglint, p10.EvernightStarRail.Head.longereyeglint2, p10.vfx.finalbeambg, p10.ScreenEffect);
        end }
};