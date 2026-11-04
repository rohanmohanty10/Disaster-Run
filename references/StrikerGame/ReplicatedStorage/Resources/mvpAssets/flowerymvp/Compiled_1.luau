 
 

return {
    { 0, function(p1, p2) -- Line: 5
            shared.vfx.emit(p2.Bone.Side1);
        end },
    { 20, function(p3) -- Line: 12
            shared.vfx.emit(p3.Step3);
        end },
    { 44, function(p4) -- Line: 19
            shared.vfx.emit(p4.Step1);
        end },
    { 94, function(p5) -- Line: 26
            shared.vfx.emit(p5.Step2);
        end },
    { 122, function(p6) -- Line: 33
            shared.vfx.emit(p6.background3);
        end },
    { 436, function(p7) -- Line: 40
            shared.vfx.emit(p7.ScreenEffectuse);
        end },
    { 542, function(p8) -- Line: 47
            shared.vfx.emit(p8.spinmesh);
        end },
    { 760, function(p9) -- Line: 54
            shared.vfx.emit(p9.background);
            shared.vfx.emit(p9["eye flash2"], p9["eye flash"]);
        end }
};