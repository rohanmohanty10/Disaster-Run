 
 

return {
    { 0, function(p1, p2, p3, p4) -- Line: 3
            shared.vfx.emit(p1.start_emit);
        end },
    { 21, function(p5, p6, p7, p8) -- Line: 8
            shared.vfx.emit(p7.FireBurst);
            shared.vfx.emit(p5.BurstEmit);
            shared.vfx.emit(p8.ViewportFrame:FindFirstChild("Ambient"));
        end },
    { 31, function(p9, p10, p11, p12) -- Line: 15
            shared.vfx.emit(p11.FireBurstSmaller);
            shared.vfx.emit(p9.BurstEmit);
        end },
    { 38, function(p13, p14, p15, p16) -- Line: 21
            shared.vfx.emit(p15.FireBurst);
            shared.vfx.emit(p13.BurstEmit);
        end },
    { 40, function(p17, p18, p19, p20) -- Line: 27
            shared.vfx.emit(p19.FireBurstSmaller);
            shared.vfx.emit(p17.BurstEmit);
        end },
    { 44, function(p21, p22, p23, p24) -- Line: 33
            shared.vfx.emit(p23.FireBurstSmaller);
            shared.vfx.emit(p21.BurstEmit);
        end },
    { 49, function(p25, p26, p27, p28) -- Line: 39
            shared.vfx.emit(p27.FireBurstSmaller);
            shared.vfx.emit(p25.BurstEmit);
        end },
    { 53, function(p29, p30, p31, p32) -- Line: 45
            shared.vfx.emit(p31.FireBurst);
            shared.vfx.emit(p29.BurstEmit);
        end },
    { 59, function(p33, p34, p35, p36) -- Line: 51
            shared.vfx.emit(p35.Fire);
        end },
    { 82, function(p37, p38, p39, p40) -- Line: 56
            shared.vfx.emit(p39.PreStomp);
        end },
    { 107, function(p41, p42, p43, p44) -- Line: 61
            shared.vfx.emit(p41.EndAura);
            shared.vfx.emit(p41.ending);
        end },
    { 127, function(p45, p46, p47, p48) -- Line: 67
            shared.vfx.emit(p46.Head.StarFlash);
        end }
};