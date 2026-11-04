 
 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

local function lights(p1, p2) -- Line: 3
    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("PointLight") then
            descendant.Enabled = p2;
        end;
    end;
end;

local function timescale(p3, p4) -- Line: 11
    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.TimeScale = p4;
        end;
    end;
end;

local function trails(p5, p6) -- Line: 19
    for _, descendant in p5:GetDescendants() do
        if descendant:IsA("Trail") then
            descendant.Enabled = p6;
        end;
    end;
end;

return {
    { 0, function(p7) -- Line: 29
            -- upvalues: lights (copy), timescale (copy)
            lights(p7, false);
            lights(p7.scene1.Light, true);
            shared.vfx.emit(p7.scene1.space);
            task.wait(0.23);
            timescale(p7.scene1.space.space2, 0);
        end },
    { 482, function(p8, p9) -- Line: 38
            shared.vfx.emit(p9.Head.lightning);
        end },
    { 831, function(p10) -- Line: 43
            shared.vfx.emit(p10.scene1.magic_circle);
        end },
    { 1314, function(p11) -- Line: 48
            -- upvalues: lights (copy)
            lights(p11.scene2.Light, true);
            lights(p11.scene1.Light, false);
            shared.vfx.emit(p11.scene2.magic_circle);
        end },
    { 1372, function(p12) -- Line: 55
            shared.vfx.emit(p12.scene2.walk["1"]);
        end },
    { 1431, function(p13) -- Line: 60
            shared.vfx.emit(p13.scene2.walk["2"]);
        end },
    { 1446, function(p14) -- Line: 65
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p14.scene2.Light2.Attachment.PointLight);
        end },
    { 1494, function(p15) -- Line: 70
            shared.vfx.emit(p15.scene2.walk["3"]);
        end },
    { 1587, function(p16) -- Line: 75
            -- upvalues: lights (copy), Part_Icles (copy)
            lights(p16.scene2.Light, false);
            Part_Icles:AbsoluteEmit(p16.scene3.Light);
            lights(p16.scene3.Light2, true);
        end },
    { 1895, function(p17) -- Line: 82
            shared.vfx.emit(p17.scene2.magic_circle2);
        end },
    { 2066, function(p18, p19) -- Line: 87
            -- upvalues: trails (copy)
            trails(p19["Right Arm"], true);
        end },
    { 2196, function(p20, p21) -- Line: 92
            -- upvalues: trails (copy)
            shared.vfx.emit(p21["Right Arm"].Bezier);
            trails(p21["Right Arm"], false);
        end },
    { 2291, function(p22) -- Line: 98
            -- upvalues: Part_Icles (copy)
            local u23 = {};

            for _, descendant in workspace:GetDescendants() do
                if descendant:IsA("Highlight") and descendant.Enabled then
                    descendant.Enabled = false;
                    table.insert(u23, descendant);
                end;
            end;

            Part_Icles:AbsoluteEmit(p22.scene2.InvertedDistortion);
            task.delay(0.5, function() -- Line: 107
                -- upvalues: u23 (copy)
                for _, v in u23 do
                    v.Enabled = true;
                end;
            end);
        end },
    { 2357, function(p24) -- Line: 115
            shared.vfx.emit(p24.scene4.Huh);
        end },
    { 2429, function(p25) -- Line: 120
            -- upvalues: timescale (copy)
            timescale(p25.scene1.space.space2, 1);
            shared.vfx.emit(p25.scene3.explode1);
            shared.vfx.emit(p25.scene1.space3);
            task.wait(0.13);
            timescale(p25.scene1.space3, 0);
        end },
    { 2523, function(p26) -- Line: 129
            shared.vfx.emit(p26.scene3.s);
        end },
    { 2795, function(p27) -- Line: 134
            shared.vfx.emit(p27.scene3.explode2);
        end },
    { 3046, function(p28) -- Line: 139
            -- upvalues: timescale (copy)
            timescale(p28.scene1.space3, 1);
        end },
    { 3086, function(p29, p30, p31) -- Line: 144
            p31.Parent = p29;
        end }
};