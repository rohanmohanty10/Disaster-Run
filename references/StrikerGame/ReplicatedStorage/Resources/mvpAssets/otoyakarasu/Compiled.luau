 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2.Head.Sigh, p2.HumanoidRootPart.VFXHandler.Start, p1.Head.Sigh);
        end },
    { 143, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4.Head.Sigh, p4.HumanoidRootPart.VFXHandler.Start, p3.Head.Sigh);
        end },
    { 315, function(p5, p6, p7) -- Line: 13
            shared.vfx.emit(p7.CamPart.boii, p7.CamPart.P);
            shared.vfx.emit(p5, p6.Torso, p6["Right Leg"], p6["Right Arm"], p6["Left Leg"], p6["Left Arm"], p6.Head, p7.CamPart.FX["2"]);
        end }
};