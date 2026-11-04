 
 

local Part_Icles = require(game.ReplicatedStorage:WaitForChild("Part_Icles"));

return {
    { 0, function(p1, p2, p3, p4) -- Line: 6
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p4.CamPart.CamVFX.Speedlines);
            Part_Icles:AbsoluteEmit(p3.Head);
        end },
    { 71, function(p5, p6, p7, p8) -- Line: 18
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p5.Grab);
        end },
    { 232, function(p9, p10, p11, p12) -- Line: 26
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p9.SlideSmoke);
        end },
    { 339, function(p13, p14, p15, p16) -- Line: 33
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p13.SmokeImpact);
        end },
    { 383, function(p17, p18, p19, p20) -- Line: 41
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p17.Sweat);
            Part_Icles:AbsoluteEmit(p17.QuestionMark);
        end },
    { 613, function(p21, p22, p23, p24) -- Line: 52
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p24.CamPart.VFX);
            Part_Icles:AbsoluteEmit(p21.ExplanationPoint);
        end },
    { 642, function(p25, p26, p27, p28) -- Line: 64
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p25.Speedlines);
        end },
    { 768, function(p29, p30, p31, p32) -- Line: 72
            -- upvalues: Part_Icles (copy)
            Part_Icles:AbsoluteEmit(p29.LightningEyes);
            Part_Icles:AbsoluteEmit(p30.Head);
        end }
};