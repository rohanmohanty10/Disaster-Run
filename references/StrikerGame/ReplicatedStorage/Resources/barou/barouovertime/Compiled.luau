 
 

return {
    { 105, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p3.HumanoidRootPart.Step);
        end },
    { 144, function(p4, p5, p6) -- Line: 8
            shared.vfx.emit(p5.Speedlines);
            shared.vfx.emit(p6.Head.righteye, p6.Head.lefteye);
        end },
    { 184, function(p7, p8, p9) -- Line: 14
            shared.vfx.emit(p7.camera.FX1.Lightning43);
            shared.vfx.emit(p9.Head.breath["Energy Esque"]);
        end },
    { 251, function(p10, p11, p12) -- Line: 20
            shared.vfx.emit(p10.camera.FX1.Lightning43);
        end },
    { 328, function(p13, p14, p15) -- Line: 25
            shared.vfx.emit(p15.Head.breath["Energy Esque"]);
        end },
    { 352, function(p16, p17, p18) -- Line: 30
            shared.vfx.emit(p17.LIONSHOTRAHHH.background1);
            shared.vfx.emit(p17.baroulionlightningstuff);
            shared.vfx.emit(p18.Head.eyeflarenable2, p18.Head.eyeflarenable);
            shared.vfx.emit(p18.HumanoidRootPart.LionStep);
            shared.vfx.emit(p18.Head.breath["Energy Esque"]);
        end },
    { 382, function(p19, p20, p21) -- Line: 39
            shared.vfx.emit(p21.HumanoidRootPart.Attachment);
        end },
    { 406, function(p22, p23, p24) -- Line: 44
            shared.vfx.emit(p22.camera.FX2.Lightning43);
            shared.vfx.emit(p24.HumanoidRootPart.Roar);
            shared.vfx.emit(p24.Head.breath["Energy Esque"]);
        end },
    { 538, function(p25, p26, p27) -- Line: 51
            shared.vfx.emit(p27.HumanoidRootPart.Hit);
        end },
    { 568, function(p28, p29, p30) -- Line: 56
            shared.vfx.emit(p30.HumanoidRootPart.Hit);
        end },
    { 594, function(p31, p32, p33) -- Line: 61
            shared.vfx.emit(p31.camera.FX1);
            shared.vfx.emit(p33.HumanoidRootPart.Roar2);
        end }
};