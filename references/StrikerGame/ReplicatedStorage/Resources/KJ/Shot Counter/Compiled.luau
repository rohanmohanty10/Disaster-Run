 
 

return {
    { 0, function(p1, p2, p3, p4) -- Line: 3
            local Lighting = game:GetService("Lighting");
            shared.vfx.emit(p2["2"], Lighting.STARTBLUR, Lighting.STARTCOL);
        end },
    { 100, function(p5, p6, p7, p8) -- Line: 10
            shared.vfx.emit(p5["Left Leg"].smoke);
        end },
    { 160, function(p9, p10, p11, p12) -- Line: 15
            shared.vfx.emit(p10["3"]);
        end },
    { 196, function(p13, p14, p15, p16) -- Line: 20
            shared.vfx.emit(p14["4"], p13.KJHighlight, p15.KJCOL3);
        end },
    { 202, function(p17, p18, p19, p20) -- Line: 27
            shared.vfx.emit(p19.KJCOL4);
        end },
    { 230, function(p21, p22, p23, p24) -- Line: 34
            shared.vfx.emit(p21.Torso.kjAura, p22["5"], p23.KJBLOOM1, p23.KJBLUR1);
        end },
    { 270, function(p25, p26, p27, p28, p29) -- Line: 41
            shared.vfx.emit(p26["6"], p29, p27.KJCOL1);
        end },
    { 307, function(p30, p31, p32, p33) -- Line: 48
            shared.vfx.emit(p31["7"]);
        end },
    { 312, function(p34, p35, p36, p37) -- Line: 53
            shared.vfx.emit(p37.VictimHighlight, p36.KJCOL2, p36.KJBLUR2, p36.KJBLOOM2, p35["8"]);
        end }
};