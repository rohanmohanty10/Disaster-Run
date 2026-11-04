 
 

return {
    { 4, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p3);
            shared.vfx.emit(p1.HumanoidRootPart.fx.StepR);
            shared.vfx.emit(p2.Highlight);
            shared.vfx.emit(p1.Torso.Attachment);
        end },
    { 30, function(p4, p5, p6) -- Line: 14
            shared.vfx.emit(p6);
            shared.vfx.emit(p4.HumanoidRootPart.fx.Stepl);
        end }
};