 
 

return {
    { 4, function(p1) -- Line: 3
            shared.vfx.emit(p1.GroundBallHit);
        end },
    { 40, function(p2) -- Line: 8
            shared.vfx.emit(p2.Stomp);
            shared.vfx.emit(p2.BallVFX.Spin);
        end },
    { 77, function(p3) -- Line: 14
            shared.vfx.emit(p3.BallVFX.Lines2, p3.BallVFX.Lines);
        end },
    { 100, function(p4) -- Line: 19
            shared.vfx.emit(p4.BallVFX.Hit);
            shared.vfx.emit(p4.CamVFX.smth.Beam1);
            shared.vfx.emit(p4.FakeHead.Eyes1);
            shared.vfx.emit(p4.PointLightsveryimportantbtwww.PointL1);
        end },
    { 173, function(p5) -- Line: 27
            shared.vfx.emit(p5.HandsonFire.RightArmFire.FirstFire);
        end },
    { 240, function(p6) -- Line: 32
            shared.vfx.emit(p6.HandsonFire.LeftArmFire.FirstFire);
        end },
    { 273, function(p7) -- Line: 37
            shared.vfx.emit(p7.HandsonFire.LeftArmFire.SecondFire);
            shared.vfx.emit(p7.HandsonFire.RightArmFire.SecondFire);
        end },
    { 284, function(p8) -- Line: 43
            shared.vfx.emit(p8.FakeHead.Eyes2);
            shared.vfx.emit(p8.EyeLightning2, p8.EyeLightning1);
            shared.vfx.emit(p8.CamVFX.smth.Beam3);
            shared.vfx.emit(p8.PointLightsveryimportantbtwww.PointL2);
        end },
    { 377, function(p9) -- Line: 51
            shared.vfx.emit(p9.Throw);
            shared.vfx.emit(p9.CamVFX.smth.ColorBeam);
            shared.vfx.emit(p9.PointLightsveryimportantbtwww.PointLFinal);
        end },
    { 519, function(p10) -- Line: 58
            shared.vfx.emit(p10.BallVFX.Spinning);
            shared.vfx.emit(p10.BallVFX.AURA);
        end },
    { 531, function(p11) -- Line: 64
            shared.vfx.emit(p11.Sshockwaves);

            for _, descendant in pairs(p11.BallVFX.Trail:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 689, function(p12) -- Line: 75
            for _, descendant in pairs(p12.BallVFX.Trail:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};