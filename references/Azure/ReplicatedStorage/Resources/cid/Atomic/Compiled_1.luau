 
 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 0, function(p1, p2) -- Line: 6
            shared.vfx.emit(p1.rain);
            shared.vfx.emit(p2.CamPart.speedline);
        end },
    { 298, function(p3) -- Line: 13
            shared.vfx.emit(p3.S);
        end },
    { 394, function(p4) -- Line: 19
            for _, descendant in pairs(p4.MainLight:GetDescendants()) do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 402, function(p5) -- Line: 30
            shared.vfx.emit(p5.A);
        end },
    { 431, function(p6) -- Line: 36
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p6.InvertedDistortion);
        end },
    { 504, function(p7, p8) -- Line: 43
            shared.vfx.emit(p7["2"]);
            shared.vfx.emit(p8.CamPart.color0);
            shared.vfx.emit(p8.CamPart.flare);
        end },
    { 1002, function(p9, p10, p11) -- Line: 52
            shared.vfx.emit(p9.x);
            shared.vfx.emit(p11["ugly sword"]);
        end },
    { 1472, function(p12) -- Line: 60
            shared.vfx.emit(p12.hand);
        end },
    { 1606, function(p13, p14, p15) -- Line: 66
            shared.vfx.emit(p15.Head.eye);
        end },
    { 1622, function(p16) -- Line: 72
            shared.vfx.emit(p16.eye);
        end },
    { 1874, function(p17) -- Line: 78
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p17.Noise);
        end },
    { 1962, function(p18) -- Line: 86
            for _, descendant in pairs(p18.MainLight:GetDescendants()) do
                if descendant:IsA("PointLight") then
                    descendant.Enabled = false;
                end;
            end;
        end },
    { 2067, function(p19, p20) -- Line: 97
            shared.vfx.emit(p20.CamPart.color);
        end }
};