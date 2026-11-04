 
 

local vfxUtil = require(game:GetService("ReplicatedStorage").util.vfxUtil);

return {
    { 0, function(p1, p2, p3, p4, p5) -- Line: 6
            if p1 then
                shared.vfx.emit(p1.CamPart.Reg);
            end;
        end },
    { 12, function(p6, p7, p8, p9, p10) -- Line: 13
            shared.vfx.emit(p7.HumanoidRootPart.Pass);
            shared.vfx.emit(p7.HumanoidRootPart["Pass Spin"]);
            require(script.Modules.CCEffect)("emit", 0.1, 0.7, 0.5, Color3.fromRGB(90, 255, 214), 0.35);
        end },
    { 92, function(p11, p12, p13, p14, p15) -- Line: 28
            shared.vfx.emit(p12.HumanoidRootPart["ball Land"]);
        end },
    { 133, function(p16, p17, p18, p19, p20) -- Line: 33
            shared.vfx.emit(p17.HumanoidRootPart.Grass2);
            shared.vfx.emit(p17.HumanoidRootPart.Falling);
            shared.vfx.emit(p18["Left Leg"].Vines);
            require(script.Modules.highlight_emit).tweenHighlight(p18["Left Leg"], Color3.fromRGB(24, 74, 150), Color3.fromRGB(55, 98, 255), 0.7, Enum.HighlightDepthMode.Occluded, "In", 0);
            shared.vfx.emit(p17.HumanoidRootPart.Falling);
            game:GetService("ReplicatedStorage");
            require(script.Modules.CCEffect)("emit", 0.1, 1, 0.7, Color3.fromRGB(139, 156, 255), 0.4);
            shared.vfx.emit(p17.HumanoidRootPart.Falling);
        end },
    { 213, function(p21, p22, p23, p24, p25) -- Line: 66
            require(script.Modules.KIM).Comp2({
                Character = p22
            });
            shared.vfx.emit(p22.HumanoidRootPart.Glare);
            require(script.Modules.CCEffect)("emit", 0.3, 0.2, 1, Color3.fromRGB(153, 194, 255), 1.4);
            require(script.Modules.highlight_emit).tweenHighlight(p25, Color3.fromRGB(23, 36, 153), Color3.fromRGB(48, 69, 255), 1.3, Enum.HighlightDepthMode.Occluded, "In", 0);
            shared.vfx.emit(p25.Vines);
            shared.vfx.emit(p25.ballseeingaura);
        end },
    { 312, function(p26, p27, p28, p29, p30) -- Line: 100
            shared.vfx.emit(p27.HumanoidRootPart.Step1);
        end },
    { 321, function(p31, p32, p33, p34, p35) -- Line: 105
            shared.vfx.emit(p32.HumanoidRootPart.Step2);
            shared.vfx.emit(p32.HumanoidRootPart.FallingTimeScale);
        end },
    { 351, function(p36, p37, p38, p39, p40) -- Line: 112
            shared.vfx.emit(p37.HumanoidRootPart.WindUp);
            shared.vfx.emit(p38["Right Leg"].Legflare, p38["Right Leg"]["43"]);
        end },
    { 452, function(p41, p42, u43, p44, p45) -- Line: 120
            task.spawn(function() -- Line: 121
                -- upvalues: u43 (copy)
                local v46 = {};

                for _, descendant in ipairs(u43:GetDescendants()) do
                    if descendant.Name == "KAura" and descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                        table.insert(v46, descendant);
                    end;
                end;

                task.wait(7);

                for _, v in ipairs(v46) do
                    v.Enabled = false;
                end;
            end);
        end },
    { 470, function(p47, p48, p49, p50, p51) -- Line: 138
            -- upvalues: vfxUtil (copy)
            if p51 then
                print("hello?");
                vfxUtil.forge.emit(p51.Charge);
                vfxUtil.forge.emit(p51.flashend);
            end;

            local highlight_emit = require(script.Modules.highlight_emit);
            highlight_emit.tweenHighlight(p51, Color3.fromRGB(25, 56, 158), Color3.fromRGB(25, 56, 158), 0.35, Enum.HighlightDepthMode.AlwaysOnTop, "In", -4);
            highlight_emit.tweenHighlight(p49, Color3.fromRGB(21, 46, 156), Color3.fromRGB(25, 56, 158), 0.4, Enum.HighlightDepthMode.Occluded, "In", -3);

            if p47 then
                shared.vfx.emit(p47.CamPart.Kick);
            end;

            shared.vfx.emit(p50.ScreenEffect1);
            shared.vfx.emit(p50.BG);
            require(script.Modules.KIM).Comp1({
                Character = p48
            });
        end },
    { 620, function(p52, p53, p54, p55, p56) -- Line: 178
            shared.vfx.emit(p56.flashend);
        end },
    { 640, function(p57, p58, p59, p60, p61) -- Line: 183
            shared.vfx.emit(p58.HumanoidRootPart.Impact1);
        end },
    { 697, function(p62, p63, p64, p65, p66) -- Line: 188
            shared.vfx.emit(p63.HumanoidRootPart.Shot);
            shared.vfx.emit(p66.ballauranormal, p66.ballglare, p66.ballseeingaura);

            for _, descendant in p66:GetDescendants() do
                if descendant.ClassName == "Trail" then
                    descendant.Enabled = true;
                    task.delay(10, function(p67, p68, p69, p70, p71) -- Line: 195
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end },
    { 744, function(p72, p73, p74, p75, p76) -- Line: 202
            shared.vfx.emit(p73.HumanoidRootPart.Ground);
            shared.vfx.emit(p75.Beams);
        end },
    { 845, function(p77, p78, p79, p80, p81) -- Line: 208
            require(script.Modules.KIM).Shine({
                Character = p78
            });

            if p77 then
                shared.vfx.emit(p77.CamPart.KidKaiser);
            end;

            shared.vfx.emit(p78.HumanoidRootPart.KidKaiserLights);
        end },
    { 1161, function(p82, p83, p84, p85, p86) -- Line: 219
            shared.vfx.emit(p83.HumanoidRootPart["Ball hit"]);
        end },
    { 1251, function(p87, p88, p89, p90, p91) -- Line: 224
            shared.vfx.emit(p88.HumanoidRootPart.Grass);
        end },
    { 1300, function(p92, p93, p94, p95, p96) -- Line: 229
            shared.vfx.emit(p95.star);

            if p92 then
                shared.vfx.emit(p92.CamPart.Goal);
            end;

            shared.vfx.emit(p94.Torso.TopShoulder, p94.Torso.VFXEnd);
        end }
};