 
 

local RigAfterimages = require(game:GetService("ReplicatedStorage").mvputils.RigAfterimages);

return {
    { 10, function(p1, p2, p3) -- Line: 5
            -- upvalues: RigAfterimages (copy)
            RigAfterimages.play(p2, p3, {
                name = "AfterImages",
                emitDuration = 0.5,
                imagesPerSecond = 3,
                lifetime = 1.5,
                mode = "outandin",
                direction = Vector3.new(1, 0, 0),
                positionOffset = Vector3.new(-0.1, 0.2, 1),
                colorFadeDelay = 0.1,
                colorFadeTime = 2,
                initialTransparency = 0.3,
                fadeOut = true,
                fadeDelay = 0.5,
                fadeTime = 1.5,
                parent = p1,
                template = script.Parent.TemplateAfter,
                excludeParts = {
                    Head = true
                },
                spread = Vector2.new(35, 35),
                distance = NumberRange.new(0, 0),
                startColor = Color3.fromRGB(66, 93, 217),
                endColor = Color3.fromRGB(50, 71, 165)
            });
        end },
    { 88, function(p4, p5, p6) -- Line: 31
            shared.vfx.emit(p4.VFXCaM.FIRSTOFALL);
        end },
    { 103, function(p7, p8, p9) -- Line: 36
            local AfterImages = p7:FindFirstChild("AfterImages");

            if AfterImages then
                AfterImages:ClearAllChildren();
            end;
        end },
    { 104, function(p10, p11, p12) -- Line: 44
            shared.vfx.emit(p10.VFXCaM.BlackBackground2Wind);
        end },
    { 240, function(p13, p14, p15) -- Line: 49
            shared.vfx.emit(p13.VFXCaM.JulianLoki);
        end },
    { 534, function(p16, p17, p18) -- Line: 54
            shared.vfx.emit(p16.Kick);
        end },
    { 568, function(p19, p20, p21) -- Line: 59
            shared.vfx.emit(p19.StepsLoki);
        end },
    { 580, function(p22, p23, p24) -- Line: 64
            shared.vfx.emit(p22.StepsLoki);
        end },
    { 596, function(p25, p26, p27, u28) -- Line: 69
            u28(1);
            p27:Add(task.delay(1.57, function() -- Line: 71
                -- upvalues: u28 (copy)
                u28(0);
            end));
        end },
    { 596, function(p29, p30, p31) -- Line: 77
            shared.vfx.emit(p29.Highlight);
        end },
    { 599, function(p32, p33, p34) -- Line: 82
            shared.vfx.emit(p32.Feint);
        end },
    { 763, function(p35, p36, p37) -- Line: 87
            shared.vfx.emit(p35.VFXCaM.Transition);
        end },
    { 786, function(p38, p39, p40) -- Line: 92
            shared.vfx.emit(p38.StepsVictim);
        end },
    { 797, function(p41, p42, p43) -- Line: 97
            shared.vfx.emit(p41.StepsVictim);
        end },
    { 830, function(p44, p45, p46) -- Line: 102
            shared.vfx.emit(p44.StepsVictim);
        end },
    { 859, function(p47, p48, p49) -- Line: 107
            shared.vfx.emit(p47.StepsLoki);
        end },
    { 875, function(p50, p51, p52) -- Line: 112
            shared.vfx.emit(p50.StepsLoki);
        end },
    { 877, function(p53, p54, p55) -- Line: 117
            shared.vfx.emit(p53.StepsVictim);
        end },
    { 896, function(p56, p57, p58) -- Line: 122
            shared.vfx.emit(p56.StepsLoki);
        end },
    { 910, function(p59, p60, p61) -- Line: 127
            shared.vfx.emit(p59.StepsLoki);
        end },
    { 923, function(p62, p63, p64) -- Line: 132
            shared.vfx.emit(p62.StepsLoki);
        end },
    { 951, function(p65, p66, p67) -- Line: 137
            shared.vfx.emit(p65.StepsVictim);
        end },
    { 970, function(p68, p69, p70) -- Line: 142
            shared.vfx.emit(p68.StepsVictim);
        end },
    { 992, function(p71, p72, p73) -- Line: 147
            shared.vfx.emit(p71.StepsLoki);
        end },
    { 993, function(p74, p75, p76) -- Line: 152
            shared.vfx.emit(p74.StepsVictim);
        end },
    { 1014, function(p77, p78, p79) -- Line: 157
            shared.vfx.emit(p77.StepsVictim);
        end },
    { 1114, function(p80, p81, p82) -- Line: 162
            shared.vfx.emit(p80.WindFInal);
        end }
};