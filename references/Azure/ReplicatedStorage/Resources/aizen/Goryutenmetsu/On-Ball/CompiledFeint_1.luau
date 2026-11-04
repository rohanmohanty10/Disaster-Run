 
 

return {
    { 20, function(p1) -- Line: 3
            require(script.highlight_emit).tweenHighlight(p1.Torso, Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255), 0.35, Enum.HighlightDepthMode.Occluded, "In", 0);
            shared.vfx.emit(p1.Ball.Feint);
        end },
    { 40, function(p2) -- Line: 18
            require(script.highlight_emit).tweenHighlight(p2.Torso, Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255), 0.35, Enum.HighlightDepthMode.Occluded, "In", 0);
            shared.vfx.emit(p2.Ball.Feint);
        end },
    { 55, function(p3) -- Line: 33
            require(script.highlight_emit).tweenHighlight(p3.Torso, Color3.fromRGB(57, 30, 166), Color3.fromRGB(91, 58, 255), 0.25, Enum.HighlightDepthMode.Occluded, "In", -3);
            shared.vfx.emit(p3.Torso);
            require(script.colorcorrection_emit)(0.05, 0.25, 0.5, Color3.fromRGB(114, 110, 225), 0.4);
            local TweenService = game:GetService("TweenService");
            local v4 = {};

            for _, descendant in ipairs(game.StarterGui.LightingUI:GetDescendants()) do
                if descendant:IsA("ImageLabel") then
                    table.insert(v4, descendant);
                end;
            end;

            local Color3_fromRGB_ret = Color3.fromRGB(28, 12, 70);
            local v5 = 1;

            for _, v in ipairs(v4) do
                v.ImageColor3 = Color3_fromRGB_ret;
                v.ImageTransparency = v5;
                TweenService:Create(v, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageTransparency = 0.6
                }):Play();
            end;

            task.wait(0.1);

            for _, v in ipairs(v4) do
                TweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    ImageTransparency = 1
                }):Play();
            end;
        end }
};