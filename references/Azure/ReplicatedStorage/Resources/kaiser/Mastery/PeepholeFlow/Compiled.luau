 
 

return {
    { 3, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.HumanoidRootPart.Steps);
        end },
    { 16, function(p3, p4) -- Line: 8
            shared.vfx.emit(p3.HumanoidRootPart.Steps["2"]);
        end },
    { 25, function(p5, p6) -- Line: 13
            shared.vfx.emit(p5.HumanoidRootPart.Steps["3"]);
        end },
    { 51, function(p7, p8) -- Line: 18
            shared.vfx.emit(p7.HumanoidRootPart.trap);
            shared.vfx.emit(p7.Ball.Right.huh, p7.Ball.Right);
        end },
    { 183, function(p9, p10) -- Line: 24
            shared.vfx.emit(p9.Head.Eyes);
            shared.vfx.emit(p10.camera.Cut3);
            shared.vfx.emit(p9.HumanoidRootPart.huh);
        end },
    { 398, function(p11, p12) -- Line: 31
            shared.vfx.emit(p11.HumanoidRootPart.Shot);
        end }
};