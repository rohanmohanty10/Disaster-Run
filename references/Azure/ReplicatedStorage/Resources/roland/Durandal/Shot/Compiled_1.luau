 
 

local TweenService = game:GetService("TweenService");
local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Linear);

return {
    { 79, function(p1) -- Line: 8
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p1.Shot.KickUp);
        end },
    { 121, function(p2, p3) -- Line: 13
            for _, child in p3.Durandal:GetChildren() do
                child.Transparency = 0;
            end;

            shared.vfx.emit(p3.Durandal);
        end },
    { 128, function(p4) -- Line: 21
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p4.Shot.startup);
        end },
    { 191, function(p5) -- Line: 26
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p5.Shot.Slash);
        end },
    { 238, function(p6, p7) -- Line: 31
            -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
            for _, child in p7.Durandal:GetChildren() do
                TweenService:Create(child, TweenInfo_new_ret, {
                    Transparency = 1
                }):Play();
            end;
        end }
};