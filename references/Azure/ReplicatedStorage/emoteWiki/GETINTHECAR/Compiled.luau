 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.CamPart["1"]);
        end },
    { 24, function(p4, p5, p6) -- Line: 8
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            require(ReplicatedStorage.mvputils.AtmosphereEffect)("instant", {
                Density = 0.9,
                Offset = 0.5,
                Haze = 1.8,
                Glare = 2.5,
                Color = Color3.fromRGB(55, 59, 79),
                Decay = Color3.fromRGB(40, 42, 47)
            }, 3);
        end },
    { 202, function(p7, p8, p9) -- Line: 28
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            require(ReplicatedStorage.mvputils.CCEffect)("emit", 0.2, -0.6, 0.6, Color3.fromRGB(129, 217, 255), 2);
            require(game.ReplicatedStorage.mvputils.highlight_emit).tweenHighlight(p8, Color3.fromRGB(49, 83, 112), Color3.fromRGB(107, 159, 255), 1.3, Enum.HighlightDepthMode.Occluded, "In", -3);
            shared.vfx.emit(p7.CamPart["2"]);
            require(game.ReplicatedStorage.mvputils:WaitForChild("blur_emit"))(11, 0.8);
        end },
    { 252, function(p10, p11, p12) -- Line: 58
            shared.vfx.emit(p11.HumanoidRootPart.mvp["Exucse me sir"]);
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            require(ReplicatedStorage.mvputils.CCEffect)("emit", 1, 0, 0, Color3.fromRGB(255, 255, 255), 0.2);
        end },
    { 318, function(p13, p14, p15) -- Line: 75
            shared.vfx.emit(p13.CamPart["3"]);
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            require(ReplicatedStorage.mvputils.CCEffect)("emit", -0.05, -0.3, 0.6, Color3.fromRGB(230, 216, 255), 2);
            require(game.ReplicatedStorage.mvputils:WaitForChild("blur_emit"))(11, 1.5);
        end },
    { 449, function(p16, p17, p18) -- Line: 95
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            require(ReplicatedStorage.mvputils.CCEffect)("emit", -0.2, -2, 0, Color3.fromRGB(255, 255, 255), 1.2);
        end },
    { 483, function(p19, p20, p21) -- Line: 110
            shared.vfx.emit(p20.HumanoidRootPart.mvp["Exucse me sir2"]);
            require(game.ReplicatedStorage.mvputils:WaitForChild("blur_emit"))(11, 0.5);
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            require(ReplicatedStorage.mvputils.CCEffect)("emit", 0.15, 0.3, 0.6, Color3.fromRGB(255, 255, 255), 2);
            shared.vfx.emit(p19.CamPart["5"]);
        end },
    { 607, function(p22, p23, p24) -- Line: 132
            shared.vfx.emit(p23["Right Arm"]);
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            require(ReplicatedStorage.mvputils.CCEffect)("emit", 0.3, 0.2, 0.5, Color3.fromRGB(255, 198, 149), 0.5);
            require(game.ReplicatedStorage.mvputils.highlight_emit).tweenHighlight(p23, Color3.fromRGB(218, 179, 73), Color3.fromRGB(255, 194, 88), 0.5, Enum.HighlightDepthMode.Occluded, "In", -2);
            shared.vfx.emit(p22.CamPart["6"]);
        end },
    { 837, function(p25, p26, p27) -- Line: 162
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            require(ReplicatedStorage.mvputils.CCEffect)("emit", 0.25, 0.3, 0.6, Color3.fromRGB(230, 216, 255), 2);
            shared.vfx.emit(p26.HumanoidRootPart.mvp.Vines);
            require(game.ReplicatedStorage.mvputils.highlight_emit).tweenHighlight(p26["Right Arm"], Color3.fromRGB(103, 74, 218), Color3.fromRGB(109, 99, 255), 1, Enum.HighlightDepthMode.Occluded, "In", -3);
        end }
};