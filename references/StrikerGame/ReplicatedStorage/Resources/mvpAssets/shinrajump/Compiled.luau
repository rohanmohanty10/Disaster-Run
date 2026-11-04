 

 

return {
    { 1, function(p1, p2, p3) -- Line: 5
            shared.vfx.emit(p2.HumanoidRootPart.windy.maflares);
        end },
    { 2, function(p4, p5, p6) -- Line: 12
            shared.vfx.emit(p6.CamPart.start);
        end },
    { 245, function(p7, p8, p9) -- Line: 19
            shared.vfx.emit(p7["Right Arm"]);
        end },
    { 294, function(p10, p11, p12) -- Line: 26
            shared.vfx.emit(p12.CamPart:FindFirstChild("face"));
        end },
    { 295, function(p13, p14, p15) -- Line: 33
            shared.vfx.emit(p15.CamPart:FindFirstChild("face"));
        end },
    { 354, function(p16, p17, p18) -- Line: 40
            shared.vfx.emit(p16["Left Leg"], p16["Right Leg"]);
        end },
    { 552, function(p19, p20, p21) -- Line: 46
            shared.vfx.emit(p19.Torso.BOMBOO);
        end }
};