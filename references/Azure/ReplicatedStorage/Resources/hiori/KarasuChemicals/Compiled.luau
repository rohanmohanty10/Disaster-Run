 
 

return {
    { 0, function(p1, p2, p3, p4, p5, p6) -- Line: 3
            shared.vfx.emit(p6.Hold2, p6.Hold1);
            shared.vfx.emit(p5);
            shared.vfx.emit(p6.Attachment);

            if p4 then
                shared.vfx.emit(p4.Part.zoom2);
            end;
        end },
    { 258, function(p7, p8, p9, p10) -- Line: 13
            if p10 then
                shared.vfx.emit(p10.Part.zoom2);
            end;
        end },
    { 263, function(p11, p12, p13, p14) -- Line: 20
            shared.vfx.emit(p12.Head.nagieyes1, p12.Head.nagieyes2);
        end },
    { 348, function(p15, p16, p17, p18) -- Line: 25
            shared.vfx.emit(p17.Head.Eyes);
        end },
    { 420, function(p19, p20, p21, p22) -- Line: 30
            shared.vfx.emit(p21.HumanoidRootPart.ShotSlowMo);
        end },
    { 450, function(p23, p24, p25, p26) -- Line: 35
            if p26 then
                shared.vfx.emit(p26.Part.zoom);
            end;
        end },
    { 485, function(p27, p28, p29, p30) -- Line: 42
            shared.vfx.emit(p27.windemitsheel);
            shared.vfx.emit(p29.HumanoidRootPart.Shot);
            shared.vfx.emit(p27.finale);

            if p30 then
                shared.vfx.emit(p30.Part.zoom3.ParticleEmitterRough, p30.Part.zoom3.ParticleEmitterSoft);
            end;
        end }
};