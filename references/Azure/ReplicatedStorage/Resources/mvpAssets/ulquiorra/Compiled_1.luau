 
 

return {
    { 32, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2["Right Arm"].spinslash);
        end },
    { 159, function(p3, p4) -- Line: 9
            shared.vfx.emit(p4["Right Arm"].main, p4["Right Arm"].impactslow, p4["Right Arm"].impactfast);
        end },
    { 196, function(p5, p6) -- Line: 15
            local shared_vfx = shared.vfx;
            shared_vfx.emit(p5.stuffmain);
            shared_vfx.emit(p5.charge);
        end },
    { 494, function(p7, p8) -- Line: 22
            shared.vfx.emit(p7.elaura);
        end },
    { 717, function(p9, p10) -- Line: 28
            shared.vfx.emit(p9.beams);
        end },
    { 781, function(p11, p12) -- Line: 34
            shared.vfx.emit(p11.rainrain);
        end },
    { 815, function(p13, p14) -- Line: 40
            shared.vfx.emit(p13.beamwindlast);
        end },
    { 1477, function(p15, p16) -- Line: 46
            local shared_vfx = shared.vfx;
            shared_vfx.emit(p15.stuff);
            shared_vfx.emit(p15.beamwindlast2);
        end },
    { 1738, function(p17, p18) -- Line: 53
            shared.vfx.emit(p17.stuff);
        end },
    { 1930, function(p19, p20) -- Line: 59
            shared.vfx.emit(p19.HighlightTextures);
        end },
    { 2014, function(p21, p22) -- Line: 65
            local shared_vfx = shared.vfx;
            shared_vfx.emit(p21.riches, p21.chargered);
            shared_vfx.emit(p21.beamsred);
            shared_vfx.emit(p21.beamwindlast2);
        end }
};