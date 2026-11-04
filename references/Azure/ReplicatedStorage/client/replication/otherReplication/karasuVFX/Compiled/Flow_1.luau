 
 

return {
    { 0, function(p1, p2, p3, p4) -- Line: 3
            game:GetService("Workspace");
            shared.vfx.emit(p3.Head.nagieyes2);
        end },
    { 90, function(p5, p6, p7, p8) -- Line: 10
            game:GetService("Workspace");
            shared.vfx.emit(p7.Torso, p7["Right Leg"], p7["Right Arm"], p7["Left Leg"], p7["Left Arm"], p7.Head);
        end },
    { 100, function(p9, p10, p11, p12) -- Line: 17
            game:GetService("Workspace");
            shared.vfx.emit(p9.Model.smog);
            shared.vfx.emit(p11.HumanoidRootPart.FX);
            shared.vfx.emit(p11["Left Leg"].Speedlines);

            if p12 then
                shared.vfx.emit(p12.CamPart.CamVFX.CamShot2);
            end;
        end },
    { 118, function(p13, p14, p15, p16) -- Line: 33
            game:GetService("Workspace");
            shared.vfx.emit(p15.HumanoidRootPart.nagiawkwindburst);
            shared.vfx.emit(p15["Left Leg"].Dirt);
        end }
};