 
 

return {
    { 13, function(p1, p2, p3, p4) -- Line: 4
            p3(p2, p4, {
                images_per_second = 25,
                lifetime = 1,
                emit_duration = 0.15,
                initial_transparency = 0.85,
                fade_time = 1,
                body_only = true,
                color_over_emit = true,
                start_color = Color3.fromRGB(22, 40, 99),
                end_color = Color3.fromRGB(47, 96, 255)
            });
        end },
    { 17, function(p5, p6, p7, p8) -- Line: 20
            p7(p6, p8, {
                images_per_second = 50,
                lifetime = 0.1,
                emit_duration = 0.07,
                initial_transparency = 0.25,
                fade_time = 0.1,
                body_only = true,
                color_over_emit = true,
                start_color = Color3.fromRGB(56, 92, 255),
                end_color = Color3.fromRGB(47, 96, 255)
            });
        end },
    { 18, function(p9, p10) -- Line: 36
            shared.vfx.emit(p9.RINGS);
        end },
    { 18, function(p11, p12, p13, p14, p15) -- Line: 42
            shared.vfx.emit(p15["Right Arm"].TRAIL.A1.Trail:FindFirstChild("Enabled"));
        end },
    { 18, function(p16, p17, p18, p19, p20) -- Line: 48
            shared.vfx.emit(p20["Left Arm"].TRAIL.A1.Trail:FindFirstChild("Enabled"));
        end },
    { 19, function(p21, p22) -- Line: 54
            shared.vfx.emit(p21.BolaSubindo);
        end },
    { 21, function(p23, p24) -- Line: 60
            shared.vfx.emit(p24.Ball.SpinBALL);
        end },
    { 45, function(p25, p26, p27, p28, p29) -- Line: 66
            shared.vfx.emit(p29.HumanoidRootPart);
        end },
    { 46, function(p30, p31, p32, p33) -- Line: 72
            p32(p31, p33, {
                images_per_second = 33.333333333333336,
                lifetime = 0.25,
                emit_duration = 0.3,
                initial_transparency = 0.25,
                fade_time = 0.25,
                body_only = true,
                color_over_emit = true,
                start_color = Color3.fromRGB(56, 92, 255),
                end_color = Color3.fromRGB(47, 96, 255)
            });
        end },
    { 46, function(p34, p35, p36, p37, p38) -- Line: 90
            shared.vfx.emit(p38["Left Leg"].TRAIL.A1.Trail:FindFirstChild("Enabled"));
        end },
    { 46, function(p39, p40, p41, p42, p43) -- Line: 96
            shared.vfx.emit(p43["Right Leg"].TRAIL.A1.Trail:FindFirstChild("Enabled"));
        end },
    { 49, function(p44, p45, p46, p47) -- Line: 102
            p46(p45, p47, {
                images_per_second = 25,
                lifetime = 1,
                emit_duration = 0.3,
                initial_transparency = 0.85,
                fade_time = 1,
                body_only = true,
                color_over_emit = true,
                start_color = Color3.fromRGB(22, 40, 99),
                end_color = Color3.fromRGB(47, 96, 255)
            });
        end },
    { 76, function(p48, p49) -- Line: 119
            shared.vfx.emit(p48.SHOT);
        end },
    { 76, function(p50, p51) -- Line: 125
            shared.vfx.emit(p50.ChutePoeira);
        end },
    { 102, function(p52, p53) -- Line: 131
            shared.vfx.emit(p52.Caida);
        end }
};