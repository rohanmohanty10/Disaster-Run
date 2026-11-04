 
 

return {
    { 0, function(p1, p2, p3, p4) -- Line: 3
            game:GetService("Workspace");

            if p4 then
                shared.vfx.emit(p4.CamPart.nagiliness);
            end;
        end },
    { 40, function(p5, p6, p7, p8) -- Line: 11
            game:GetService("Workspace");
            shared.vfx.emit(p7.HumanoidRootPart.FX2);
        end },
    { 91, function(p9, p10, p11, p12) -- Line: 18
            game:GetService("Workspace");
            shared.vfx.emit(p11.HumanoidRootPart.FX3);
        end },
    { 130, function(p13, p14, p15, p16) -- Line: 25
            shared.vfx.emit(p15.HumanoidRootPart["Grass Step"]);
        end },
    { 190, function(p17, p18, p19, p20) -- Line: 30
            game:GetService("Workspace");
        end },
    { 212, function(p21, p22, p23, p24) -- Line: 35
            game:GetService("Workspace");
            shared.vfx.emit(p23.Ball.BallSpin, p23.Ball.BallWindup);
        end },
    { 244, function(p25, p26, p27, p28) -- Line: 42
            game:GetService("Workspace");
            shared.vfx.emit(p27.HumanoidRootPart.FX4);
        end }
};