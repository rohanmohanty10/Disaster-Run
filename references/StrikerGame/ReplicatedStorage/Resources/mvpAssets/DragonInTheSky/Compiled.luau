 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return {
    { 0, function(p1, p2, p3) -- Line: 5
            shared.vfx.emit(p1.HumanoidRootPart.Clouds);

            if p2 then
                shared.vfx.emit(p2.CamPart.Cam1);
            end;
        end },
    { 33, function(p4, p5, p6) -- Line: 13
            -- upvalues: ReplicatedStorage (copy)
            require(ReplicatedStorage.mvputils.colorcorrection_emit)(0.05, 0.2, 0.5, Color3.fromRGB(157, 178, 255), 1.7);
        end },
    { 203, function(p7, p8, p9) -- Line: 19
            -- upvalues: ReplicatedStorage (copy)
            if p8 then
                shared.vfx.emit(p8.CamPart.Cam2);
            end;

            require(ReplicatedStorage.mvputils.colorcorrection_emit)(0.05, 0.1, 0.5, Color3.fromRGB(194, 198, 211), 1.7);
        end },
    { 374, function(p10, p11, p12) -- Line: 29
            -- upvalues: ReplicatedStorage (copy)
            shared.vfx.emit(p12.ScreenEffect1);
            require(ReplicatedStorage.mvputils.colorcorrection_emit)(0.5, 0.1, 0.5, Color3.fromRGB(255, 255, 255), 0.3);
        end },
    { 718, function(p13, p14, p15) -- Line: 37
            shared.vfx.emit(p15.Transition);
        end },
    { 792, function(p16, p17, p18) -- Line: 42
            shared.vfx.emit(p18.ScreenEffect2);

            if p17 then
                shared.vfx.emit(p17.CamPart.BG);
            end;
        end },
    { 848, function(p19, p20, p21) -- Line: 51
            shared.vfx.emit(p21.Transition);
        end },
    { 1096, function(p22, p23, p24) -- Line: 56
            shared.vfx.emit(p24.ScreenEffect3);
        end }
};