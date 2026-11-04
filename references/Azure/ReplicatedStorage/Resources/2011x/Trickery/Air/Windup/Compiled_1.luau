 
 

local Part_Icles = require(game:GetService("ReplicatedStorage").Part_Icles);

return {
    { 0, function(p1, p2, p3) -- Line: 5
            -- upvalues: Part_Icles (copy)
            shared.vfx.emit(p2.Head, p2["Left Arm"], p2["Left Leg"], p2["Right Arm"], p2["Right Leg"], p2.Torso);
            Part_Icles:AbsoluteEmit(p3);
        end },
    { 31, function(p4, p5, p6) -- Line: 11
            -- upvalues: Part_Icles (copy)
            p4.FlashSteps2.CFrame = p5.HumanoidRootPart.CFrame * CFrame.new(0.00034332275390625, 0, -0.00006818771362304688);
            shared.vfx.emit(p4.FlashSteps2);
            Part_Icles:AbsoluteEmit(p6);
        end }
};