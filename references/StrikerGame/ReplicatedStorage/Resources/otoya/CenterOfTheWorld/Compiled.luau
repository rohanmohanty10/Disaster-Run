 

 

return {
    { 6, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.TuffCharacterRig0.HumanoidRootPart.Step);
        end },
    { 18, function(p3, p4) -- Line: 8
            shared.vfx.emit(p3.TuffCharacterRig0.HumanoidRootPart.Step2);
        end },
    { 34, function(p5, p6) -- Line: 13
            shared.vfx.emit(p5.TuffCharacterRig0.HumanoidRootPart.Step3);
        end },
    { 52, function(p7, p8) -- Line: 18
            shared.vfx.emit(p7.FlashyDomain2);

            if p8 then
                shared.vfx.emit(p8.camera.CamVFX.CamShot2.CamShade1);
            end;
        end },
    { 78, function(p9, p10) -- Line: 26
            shared.vfx.emit(p9.TuffCharacterRig0.HumanoidRootPart.AuraStart);
        end },
    { 130, function(p11, p12) -- Line: 31
            shared.vfx.emit(p11.TuffCharacterRig0.Ball.Hit);

            if p12 then
                shared.vfx.emit(p12.camera.CamVFX.CamShot1);
            end;
        end },
    { 147, function(p13, p14) -- Line: 39
            shared.vfx.emit(p13.Effects.Flares);
        end },
    { 170, function(p15, p16) -- Line: 44
            shared.vfx.emit(p15.Effects["Saved For Later"]);
        end }
};