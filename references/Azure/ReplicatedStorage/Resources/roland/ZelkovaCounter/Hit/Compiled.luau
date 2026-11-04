 

 

local TweenService = game:GetService("TweenService");
local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Linear);
local TweenInfo_new_ret2 = TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear);
local TweenInfo_new_ret3 = TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear);

return {
    { 0, function(p1, p2) -- Line: 10
            -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
            TweenService:Create(p2.ZelkovaHighlight, TweenInfo_new_ret, {
                FillTransparency = 1,
                OutlineTransparency = 1
            }):Play();
            TweenService:Create(p2.ZelkovaHighlight, TweenInfo_new_ret2, {
                FillColor = Color3.new()
            }):Play();
        end },
    { 10, function(p3, p4) -- Line: 16
            -- upvalues: TweenService (copy), TweenInfo_new_ret3 (copy), Part_Icles (copy)
            TweenService:Create(p4.ZelkovaHighlight, TweenInfo_new_ret3, {
                FillColor = Color3.new(1, 1, 1)
            }):Play();
            Part_Icles:AbsoluteEmit(p4.HumanoidRootPart.ZelkovaVFX);
        end },
    { 60, function(p5, p6, p7) -- Line: 22
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p7.HumanoidRootPart.ZelkovaHit);
        end },
    { 112, function(p8, p9, p10) -- Line: 27
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p10.HumanoidRootPart.ZelkovaHit2);
        end },
    { 222, function(p11) -- Line: 32
            shared.vfx.emit(p11.VFXDASH);
            shared.vfx.emit(p11.DashF);
        end }
};