 

 

local TweenService = game:GetService("TweenService");
local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Linear);

return {
    { 15, function(p1, p2) -- Line: 8
            for _, child in p2.Durandal:GetChildren() do
                child.Transparency = 0;
            end;

            shared.vfx.emit(p2.Durandal);
        end },
    { 30, function(p3) -- Line: 16
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p3.Breakthrough.startup);
        end },
    { 57, function(p4) -- Line: 21
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p4.Breakthrough.SlashVFX);
        end },
    { 98, function(p5, p6) -- Line: 26
            -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
            for _, child in p6.Durandal:GetChildren() do
                TweenService:Create(child, TweenInfo_new_ret, {
                    Transparency = 1
                }):Play();
            end;
        end }
};