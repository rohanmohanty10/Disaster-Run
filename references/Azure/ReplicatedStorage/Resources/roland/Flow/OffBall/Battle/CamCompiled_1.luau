 
 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 0, function(p1) -- Line: 5
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p1.Bone.BEAMMSSSStart);
        end },
    { 72, function(p2) -- Line: 10
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p2.Bone.BEAMMSSSwipe);
        end },
    { 135, function(p3) -- Line: 15
            shared.vfx.emit(p3["Bone.002"].Attachment);
        end },
    { 246, function(p4) -- Line: 20
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p4.Bone.CAMERASWIPE1);
        end },
    { 320, function(p5) -- Line: 25
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p5.Bone.BEAMMSSSFight);
        end },
    { 739, function(p6) -- Line: 30
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p6.Bone.CAMERASWIPE2);
        end }
};