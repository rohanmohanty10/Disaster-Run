 

 

game:GetService("Lighting");

return {
    { 20, function(p1, p2, p3) -- Line: 5
            if p2 then
                shared.vfx.emit(p2.CamPart.AikuShine);
            end;

            shared.vfx.emit(p3["Left Leg"].Step);
            shared.vfx.emit(p3.HumanoidRootPart.aikugridball);
        end },
    { 174, function(p4) -- Line: 14
            shared.vfx.emit(p4.SideDash);
        end },
    { 295, function(p5, p6, p7) -- Line: 19
            shared.vfx.emit(p7.HumanoidRootPart.dust);
            shared.vfx.emit(p7.HumanoidRootPart.MainFlareAiku);
        end },
    { 659, function(p8, p9, p10) -- Line: 25
            shared.vfx.emit(p10.Head.Eyes.EyesEmit);

            if p9 then
                shared.vfx.emit(p9.CamPart.CameraWind);
                shared.vfx.emit(p9.CamPart.AikuShine);
            end;
        end },
    { 724, function(p11, p12, p13, p14) -- Line: 34
            shared.vfx.emit(p14.Torso.StruggleHit);
            shared.vfx.emit(p13["Right Arm"]);

            if p12 then
                shared.vfx.emit(p12.CamPart["2740speedlines"], p12.CamPart.lungespeedline);
                shared.vfx.emit(p12.CamPart.CameraWind);
                shared.vfx.emit(p12.CamPart.AikuShine);
            end;
        end },
    { 853, function(p15, p16) -- Line: 45
            if p16 then
                shared.vfx.emit(p16.CamPart["2740speedlines"]);
            end;
        end }
};