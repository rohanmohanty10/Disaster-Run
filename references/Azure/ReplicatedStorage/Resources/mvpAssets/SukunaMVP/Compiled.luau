 
 

return {
    { 17, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.HumanoidRootPart.mvp["1"]);
        end },
    { 62, function(p3, p4) -- Line: 8
            shared.vfx.emit(p3.HumanoidRootPart.mvp["2"]);
            require(script.Utility:WaitForChild("blur_emit"))(13, 0.73);
            shared.vfx.emit(p4.CamPart["2"]);
            require(script.Utility.CCEffect)("emit", 0.1, 0.4, 0.7, Color3.fromRGB(255, 255, 255), 1.5);
        end },
    { 178, function(p5, p6, p7) -- Line: 30
            shared.vfx.emit(p7.kamutoke_rig);
            require(script.Utility.highlight_emit).tweenHighlight(p7.kamutoke_rig, Color3.fromRGB(255, 205, 79), Color3.fromRGB(152, 87, 61), 0.7, Enum.HighlightDepthMode.Occluded, "In", -2);
        end },
    { 371, function(p8, p9) -- Line: 46
            shared.vfx.emit(p9.CamPart.Up);
            require(script.Utility.CCEffect)("emit", 0.1, 0.2, 0.6, Color3.fromRGB(255, 255, 255), 1);
        end },
    { 450, function(p10, p11, p12) -- Line: 61
            shared.vfx.emit(p10.HumanoidRootPart.mvp.kamutoke);
            require(script.Utility.CCEffect)("emit", 0.1, 0.2, 0.7, Color3.fromRGB(255, 255, 255), 1);
            require(script.Utility.highlight_emit).tweenHighlight(p12, Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 184, 78), 1.2, Enum.HighlightDepthMode.AlwaysOnTop, "Out", 0.8, wait(0.1));
        end },
    { 527, function(p13, p14) -- Line: 90
            shared.vfx.emit(p14.CamPart["5"]);
        end },
    { 611, function(p15, p16) -- Line: 95
            shared.vfx.emit(p16.CamPart["3"]);
            require(script.Utility.CCEffect)("emit", 0.15, 0.4, 0.7, Color3.fromRGB(255, 255, 255), 0.5);
        end }
};