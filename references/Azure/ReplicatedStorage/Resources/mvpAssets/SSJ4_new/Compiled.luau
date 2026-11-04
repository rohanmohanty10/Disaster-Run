 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p2.Cam3.CamPart.Cam1);
            shared.vfx.emit(p1.CC1);
        end },
    { 109, function(p4, p5, p6) -- Line: 9
            shared.vfx.emit(p5.R6.HumanoidRootPart.VFX.Jump);
            shared.vfx.emit(p4.CC1);
            shared.vfx.emit(p5.R6.Torso.Fly);
        end },
    { 149, function(p7, p8, p9) -- Line: 16
            shared.vfx.emit(p8.R6["Left Arm"].LeftGripAttachment.Fist);
        end },
    { 162, function(p10, p11, p12) -- Line: 21
            shared.vfx.emit(p12["12_rig"].Shenlong_Body.Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"]["Bone.005"]["Bone.006"]["Bone.007"]["Bone.008"]["Bone.009"]["Bone.010"]["Bone.011"]["Bone.012"]["Bone.013"]["Bone.014"]["Bone.015"]["Bone.016"]["Bone.017"]["Bone.018"]["Bone.020"].DragonFly);
        end },
    { 332, function(p13, p14, p15) -- Line: 26
            shared.vfx.emit(p14.R6.HumanoidRootPart.VFX.Explode);
            shared.vfx.emit(p13.Explode);
        end },
    { 351, function(p16, p17, p18) -- Line: 32
            shared.vfx.emit(p18["12_rig"].Shenlong_Body.Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"]["Bone.005"]["Bone.006"]["Bone.007"]["Bone.008"]["Bone.009"]["Bone.010"]["Bone.011"]["Bone.012"]["Bone.013"]["Bone.014"]["Bone.015"]["Bone.016"]["Bone.017"]["Bone.018"]["Bone.020"].DragonFly2);
            shared.vfx.emit(p16.Roar);
        end },
    { 414, function(p19, p20, p21) -- Line: 38
            shared.vfx.emit(p20.Cam3.CamPart.Cam2);
        end },
    { 433, function(p22, p23, p24) -- Line: 43
            shared.vfx.emit(p23.BG);
        end },
    { 509, function(p25, p26, p27) -- Line: 48
            shared.vfx.emit(p27["12_rig"].Shenlong_Body.Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"]["Bone.005"]["Bone.006"]["Bone.007"]["Bone.008"]["Bone.009"]["Bone.010"]["Bone.011"]["Bone.012"]["Bone.013"]["Bone.014"]["Bone.015"]["Bone.016"]["Bone.017"]["Bone.018"]["Bone.020"].DragonFly3);
            shared.vfx.emit(p25.Roar2);
        end },
    { 551, function(p28, p29, p30) -- Line: 54
            shared.vfx.emit(p29.TemplateR6.Torso.Fly);
            shared.vfx.emit(p29.TemplateR6.Torso.Aura);
        end },
    { 605, function(p31, p32, p33) -- Line: 60
            shared.vfx.emit(p32.TemplateR6.Torso.Flip);
        end },
    { 654, function(p34, p35, p36) -- Line: 65
            shared.vfx.emit(p35.R6.Torso.Auraman);
        end },
    { 661, function(p37, p38, p39) -- Line: 70
            shared.vfx.emit(p38.R6.HumanoidRootPart.VFX.Land);
            shared.vfx.emit(p37.Land);
        end },
    { 765, function(p40, p41, p42) -- Line: 76
            shared.vfx.emit(p40.Goal);
            shared.vfx.emit(p41.Cam3.CamPart.Cam3);
        end }
};