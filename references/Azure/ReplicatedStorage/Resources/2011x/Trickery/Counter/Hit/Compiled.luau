 

 

local Lighting = game:GetService("Lighting");

local function emit_lighting(p1: string) -- Line: 4
    -- upvalues: Lighting (copy)
    local v2 = Lighting:FindFirstChild(p1);

    if v2 then
        shared.vfx.emit(v2);
    end;
end;

return {
    { 1, function(p3, p4, p5, p6, p7) -- Line: 14
            -- upvalues: Lighting (copy)
            shared.vfx.emit(p6["Right Arm"].Grab);
            local S = Lighting:FindFirstChild("S");

            if S then
                shared.vfx.emit(S);
            end;
        end },
    { 22, function(p8, p9, p10, p11, p12) -- Line: 21
            -- upvalues: Lighting (copy)
            local S = Lighting:FindFirstChild("S");

            if S then
                shared.vfx.emit(S);
            end;
        end },
    { 30, function(p13, p14, p15, p16, p17) -- Line: 27
            -- upvalues: Lighting (copy)
            shared.vfx.emit(p15.HumanoidRootPart.Appear);
            shared.vfx.emit(p17.HumanoidRootPart.Appear);
            shared.vfx.emit(p15.Highlight);
            shared.vfx.emit(p17.Highlight);
            local ImpactCC = Lighting:FindFirstChild("ImpactCC");

            if ImpactCC then
                shared.vfx.emit(ImpactCC);
            end;
        end },
    { 82, function(p18, p19, p20, p21, p22) -- Line: 37
            shared.vfx.emit(p20.Highlight);
        end },
    { 85, function(p23, p24, p25, p26, p27) -- Line: 43
            -- upvalues: Lighting (copy)
            shared.vfx.emit(p26.HumanoidRootPart.MissWind);
            shared.vfx.emit(p27.SideDash);
            shared.vfx.emit(p25.HumanoidRootPart.Disappear);
            local Sat = Lighting:FindFirstChild("Sat");

            if Sat then
                shared.vfx.emit(Sat);
            end;
        end },
    { 155, function(p28, p29, p30, p31, p32) -- Line: 52
            -- upvalues: Lighting (copy)
            local S = Lighting:FindFirstChild("S");

            if S then
                shared.vfx.emit(S);
            end;
        end },
    { 196, function(p33, p34, p35, p36, p37) -- Line: 58
            -- upvalues: Lighting (copy)
            shared.vfx.emit(p33.Teleport2);
            shared.vfx.emit(p37.Highlight);
            local ImpactCC = Lighting:FindFirstChild("ImpactCC");

            if ImpactCC then
                shared.vfx.emit(ImpactCC);
            end;
        end },
    { 208, function(p38, p39, p40, p41, p42) -- Line: 66
            -- upvalues: Lighting (copy)
            shared.vfx.emit(p41.Head.HeadGrab);
            local S = Lighting:FindFirstChild("S");

            if S then
                shared.vfx.emit(S);
            end;
        end },
    { 237, function(p43, p44, p45, p46, p47) -- Line: 73
            -- upvalues: Lighting (copy)
            shared.vfx.emit(p43.Throw);
            local Sat = Lighting:FindFirstChild("Sat");

            if Sat then
                shared.vfx.emit(Sat);
            end;
        end },
    { 239, function(p48, p49, p50, p51, p52) -- Line: 80
            shared.vfx.emit(p50.Torso.GlitchAura);
            shared.vfx.emit(p51.Head.InwardsBezier);
            shared.vfx.emit(p50.Highlight);
            shared.vfx.emit(p51.HumanoidRootPart.Tension);
            shared.vfx.emit(p51.Head.Glitch);
        end },
    { 244, function(p53, p54, p55, p56, p57) -- Line: 90
            shared.vfx.emit(p55["Right Leg"].RightStep);
            shared.vfx.emit(p57.HumanoidRootPart.Disappear);
        end },
    { 249, function(p58, p59, p60, p61, p62) -- Line: 97
            shared.vfx.emit(p62.Highlight);
        end },
    { 269, function(p63, p64, p65, p66, p67) -- Line: 103
            shared.vfx.emit(p65["Left Leg"].LeftStep);
        end }
};