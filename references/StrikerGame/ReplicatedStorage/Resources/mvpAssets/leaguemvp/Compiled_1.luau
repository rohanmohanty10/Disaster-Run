 
 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p1.ScreenEffect);
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(0.5, 0.5, 1, Color3.fromRGB(3, 6, 25), 2.5);
        end },
    { 215, function(p4, p5, p6) -- Line: 12
            shared.vfx.emit(p4.Smokeback);
            require(game.ReplicatedStorage.mvputils.colorcorrection_emit)(0.5, 0.5, 1, Color3.fromRGB(3, 6, 25), 1.5);
            local TweenService = game:GetService("TweenService");
            local LeagueMVPHighlight = p5:FindFirstChild("LeagueMVPHighlight");

            if LeagueMVPHighlight then
                LeagueMVPHighlight:Destroy();
            end;

            local Highlight = Instance.new("Highlight");
            Highlight.Name = "LeagueMVPHighlight";
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(7, 9, 30);
            Highlight.OutlineColor = Color3.fromRGB(18, 24, 80);
            Highlight.FillTransparency = 0;
            Highlight.OutlineTransparency = 0;
            Highlight.Adornee = p5;
            Highlight.Parent = p5;
            TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                OutlineTransparency = 1
            }):Play();
            task.delay(0.45, function() -- Line: 33
                -- upvalues: Highlight (copy), TweenService (copy)
                if Highlight.Parent then
                    TweenService:Create(Highlight, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        FillTransparency = 1
                    }):Play();
                end;
            end);
            game:GetService("Debris"):AddItem(Highlight, 1.05);
        end },
    { 348, function(p7, p8, p9) -- Line: 43
            local Head = p8:FindFirstChild("Head");

            if Head then
                Head = Head:FindFirstChild("Breath");
            end;

            if Head then
                shared.vfx.emit(Head);
            end;
        end }
};