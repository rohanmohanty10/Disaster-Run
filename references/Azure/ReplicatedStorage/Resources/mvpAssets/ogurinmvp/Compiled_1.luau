 
 

local Part_Icles = require(game:GetService("ReplicatedStorage").Part_Icles);
local RunService = game:GetService("RunService");
Part_Icles:Activate();

local function setLights(p1, p2, p3) -- Line: 6
    for _, descendant in (p2 and p1.Light[tostring(p2)] or p1.Light):GetDescendants() do
        if descendant:IsA("PointLight") then
            descendant.Enabled = p3;
        end;
    end;
end;

local function followTransition(u4, u5, p6) -- Line: 15
    -- upvalues: RunService (copy)
    local u7 = CFrame.new(0.077, 0.086, -1.628) * CFrame.fromOrientation(-0.029792770331543206, 0.15126768627034853, -1.2762720155208536);
    u4.Transition.CFrame = u5.CamPart.CFrame * u7;
    local u8 = p6:Add(RunService.Heartbeat:Connect(function() -- Line: 17, Name: update
        -- upvalues: u4 (copy), u5 (copy), u7 (copy)
        u4.Transition.CFrame = u5.CamPart.CFrame * u7;
    end));
    p6:Add(task.delay(0.7, function() -- Line: 23
        -- upvalues: u8 (copy)
        u8:Disconnect();
    end));
end;

return {
    { 0, function(p9, p10, p11, p12) -- Line: 30
            shared.vfx.emit(p9.mesh.Glass1);
            shared.vfx.emit(p9.mesh.inverted_sphere1);

            for _, descendant in p9.Light:GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in (p9.Light[tostring(1)] or p9.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 58, function(p13, p14, p15, p16) -- Line: 38
            shared.vfx.emit(p13.first);
        end },
    { 83, function(p17, p18, p19, p20) -- Line: 43
            -- upvalues: Part_Icles (copy)
            shared.vfx.emit(p17.mesh.inverted_sphere);
            shared.vfx.emit(p17.breaking);

            for _, descendant in (p17.Light[tostring(1)] or p17.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in (p17.Light[tostring(2)] or p17.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = true;
                end;
            end;

            Part_Icles:AbsoluteEmit(p17.mesh.w);
        end },
    { 327, function(p21, p22, p23, p24) -- Line: 52
            -- upvalues: followTransition (copy)
            followTransition(p21, p22, p24);
        end },
    { 328, function(p25, p26, p27, p28) -- Line: 57
            shared.vfx.emit(p25.Transition);
            shared.vfx.emit(p26.CamPart["2"]);
        end },
    { 341, function(p29, p30, p31, p32) -- Line: 63
            for _, descendant in (p29.Light[tostring(2)] or p29.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in (p29.Light[tostring(3)] or p29.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p29.aura1);
            shared.vfx.emit(p30.CamPart["1"]);
        end },
    { 410, function(p33, p34, p35, p36) -- Line: 71
            -- upvalues: followTransition (copy)
            followTransition(p33, p34, p36);
        end },
    { 411, function(p37, p38, p39, p40) -- Line: 76
            shared.vfx.emit(p37.Transition);
        end },
    { 441, function(p41, p42, p43, p44) -- Line: 81
            for _, descendant in (p41.Light[tostring(3)] or p41.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in (p41.Light[tostring(4)] or p41.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p42.CamPart["Color grading"]);
            shared.vfx.emit(p41.aura2);
        end },
    { 503, function(p45, p46, p47, p48) -- Line: 89
            -- upvalues: followTransition (copy)
            followTransition(p45, p46, p48);
        end },
    { 504, function(p49, p50, p51, p52) -- Line: 94
            shared.vfx.emit(p49.Transition);
            shared.vfx.emit(p50.CamPart["2"]);
        end },
    { 528, function(p53, p54, p55, p56) -- Line: 100
            for _, descendant in (p53.Light[tostring(4)] or p53.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;

            for _, descendant in (p53.Light[tostring(5)] or p53.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p53.aura3);
        end },
    { 653, function(p57, p58, p59, p60) -- Line: 107
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p57.wind);
            Part_Icles:AbsoluteEmit(p57.kanji);
        end },
    { 840, function(p61, p62, p63, p64) -- Line: 113
            for _, descendant in (p61.Light[tostring(5)] or p61.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;

            shared.vfx.emit(p61.ScreenEffect);
        end },
    { 923, function(p65, p66, p67, p68) -- Line: 119
            for _, descendant in (p65.Light[tostring(6)] or p65.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = true;
                end;
            end;

            shared.vfx.emit(p65.aura4);
        end },
    { 1076, function(p69, p70, p71, p72) -- Line: 125
            for _, descendant in (p69.Light[tostring(6)] or p69.Light):GetDescendants() do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;

            shared.vfx.emit(p69.aura5);
        end }
};