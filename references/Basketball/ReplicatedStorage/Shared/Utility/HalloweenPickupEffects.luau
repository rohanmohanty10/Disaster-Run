 
 

return function(p1) -- Line: 1
    local TweenService = game:GetService("TweenService");
    local RunService = game:GetService("RunService");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local TweenInfo_new_ret = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    local TweenInfo_new_ret3 = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local TweenInfo_new_ret4 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local TweenInfo_new_ret5 = TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local TweenInfo_new_ret6 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local TweenInfo_new_ret7 = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    local TweenInfo_new_ret8 = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local TweenInfo_new_ret9 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local TweenInfo_new_ret10 = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    local TweenInfo_new_ret11 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local TweenInfo_new_ret12 = TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    local u2 = p1:FindFirstChild("FXLayer") or Instance.new("Frame");
    u2.Name = "FXLayer";
    u2.BackgroundTransparency = 1;
    u2.AnchorPoint = Vector2.new(0, 0);
    u2.Position = UDim2.fromScale(0, 0);
    u2.Size = UDim2.fromScale(1, 1);
    u2.ZIndex = 50;
    u2.Parent = p1;
    local u12 = {
        Layer = u2,

        Tween = function(p3, p4, p5) -- Line: 46, Name: Tween
            -- upvalues: TweenService (copy)
            local v6 = TweenService:Create(p3, p4, p5);
            v6:Play();

            return v6;
        end,

        Cleanup = function(u7, p8) -- Line: 52, Name: Cleanup
            task.delay(p8, function() -- Line: 53
                -- upvalues: u7 (copy)
                u7:Destroy();
            end);
        end,

        GetScale = function(p9) -- Line: 58, Name: GetScale
            local v10 = p9:FindFirstChildOfClass("UIScale");

            if not v10 then
                v10 = Instance.new("UIScale");
                v10.Parent = p9;
            end;

            return v10;
        end,

        Center = function(p11) -- Line: 67, Name: Center
            -- upvalues: u2 (copy)
            return p11.AbsolutePosition + p11.AbsoluteSize / 2 - u2.AbsolutePosition;
        end
    };

    local function Bezier(p13, p14, p15, p16) -- Line: 71
        return p13:Lerp(p14, p16):Lerp(p14:Lerp(p15, p16), p16);
    end;

    function u12.Punch(p17, p18) -- Line: 76
        -- upvalues: u12 (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
        local Scale = u12.GetScale(p17);
        u12.Tween(Scale, TweenInfo_new_ret, {
            Scale = p18
        });
        task.delay(TweenInfo_new_ret.Time, function() -- Line: 79
            -- upvalues: u12 (ref), Scale (copy), TweenInfo_new_ret2 (ref)
            u12.Tween(Scale, TweenInfo_new_ret2, {
                Scale = 1
            });
        end);
    end;

    function u12.Wiggle(u19, u20, u21) -- Line: 84
        -- upvalues: RunService (copy)
        task.spawn(function() -- Line: 85
            -- upvalues: u21 (copy), u19 (copy), u20 (copy), RunService (ref)
            local os_clock_ret = os.clock();

            while true do
                local v22 = (os.clock() - os_clock_ret) / u21;

                if v22 >= 1 then
                    break;
                end;

                u19.Rotation = math.sin(v22 * 3.141592653589793 * 6) * u20 * (1 - v22) ^ 2;
                RunService.RenderStepped:Wait();
            end;

            u19.Rotation = 0;
        end);
    end;

    function u12.Ring(p23, p24, p25, p26) -- Line: 98
        -- upvalues: u12 (copy), Color3_fromRGB_ret (copy), u2 (copy), TweenInfo_new_ret3 (copy)
        local v27 = u12.Center(p23);
        local math_max_ret = math.max(p23.AbsoluteSize.X, p23.AbsoluteSize.Y);
        local Frame = Instance.new("Frame");
        Frame.Name = "Ring";
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Position = UDim2.fromOffset(v27.X, v27.Y);
        Frame.Size = UDim2.fromOffset(math_max_ret * 0.6, math_max_ret * 0.6);
        Frame.BackgroundTransparency = 1;
        Frame.ZIndex = 51;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = p24 or Color3_fromRGB_ret;
        UIStroke.Thickness = p26 or 4;
        UIStroke.Parent = Frame;
        Frame.Parent = u2;
        u12.Tween(Frame, TweenInfo_new_ret3, {
            Size = UDim2.fromOffset(math_max_ret * p25, math_max_ret * p25)
        });
        u12.Tween(UIStroke, TweenInfo_new_ret3, {
            Transparency = 1,
            Thickness = 0
        });
        u12.Cleanup(Frame, TweenInfo_new_ret3.Time);
    end;

    function u12.Sparkles(p28, p29, p30, p31, p32, p33) -- Line: 125
        -- upvalues: u12 (copy), Color3_fromRGB_ret (copy), u2 (copy), TweenInfo_new_ret5 (copy), TweenInfo_new_ret6 (copy)
        local v34 = u12.Center(p28);
        local v35 = p33 or math.max(p28.AbsoluteSize.X, p28.AbsoluteSize.Y) * 0.35;

        for i = 1, p29 do
            local v36 = i / p29 * 3.141592653589793 * 2 + math.random() * 0.6;
            local v37 = p31 * (0.6 + math.random() * 0.5);
            local v38 = v34 + Vector2.new(math.cos(v36), (math.sin(v36))) * v37;
            local v39 = v35 * (0.6 + math.random() * 0.6);
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Sparkle";
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.Image = p32 or "rbxassetid://105875324111234";
            ImageLabel.ImageColor3 = p30 or Color3_fromRGB_ret;
            ImageLabel.Position = UDim2.fromOffset(v34.X, v34.Y);
            ImageLabel.Size = UDim2.fromOffset(v39, v39);
            ImageLabel.Rotation = math.random(0, 360);
            ImageLabel.ZIndex = 52;
            ImageLabel.Parent = u2;
            u12.Tween(ImageLabel, TweenInfo_new_ret5, {
                Position = UDim2.fromOffset(v38.X, v38.Y),
                Rotation = ImageLabel.Rotation + math.random(-180, 180)
            });
            task.delay(TweenInfo_new_ret5.Time - TweenInfo_new_ret6.Time, function() -- Line: 151
                -- upvalues: u12 (ref), ImageLabel (copy), TweenInfo_new_ret6 (ref)
                u12.Tween(ImageLabel, TweenInfo_new_ret6, {
                    ImageTransparency = 1,
                    Size = UDim2.fromOffset(0, 0)
                });
            end);
            u12.Cleanup(ImageLabel, TweenInfo_new_ret5.Time + 0.05);
            local _ = i;
        end;
    end;

    function u12.Flash(p40, p41, p42) -- Line: 158
        -- upvalues: Color3_fromRGB_ret (copy), u12 (copy), TweenInfo_new_ret4 (copy)
        local Frame = Instance.new("Frame");
        Frame.Name = "Flash";
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Position = UDim2.fromScale(0.5, 0.5);
        Frame.Size = UDim2.fromScale(1, 1);
        Frame.BackgroundColor3 = p41 or Color3_fromRGB_ret;
        Frame.BackgroundTransparency = p42 or 0.3;
        Frame.BorderSizePixel = 0;
        Frame.ZIndex = 10;
        local v43 = p40:FindFirstChildOfClass("UICorner");

        if v43 then
            v43:Clone().Parent = Frame;
        end;

        Frame.Parent = p40;
        u12.Tween(Frame, TweenInfo_new_ret4, {
            BackgroundTransparency = 1
        });
        u12.Cleanup(Frame, TweenInfo_new_ret4.Time);
    end;

    function u12.Shine(p44, p45, p46) -- Line: 179
        -- upvalues: Color3_fromRGB_ret (copy), u12 (copy), TweenInfo_new_ret12 (copy)
        local Frame = Instance.new("Frame");
        Frame.Name = "Shine";
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Position = UDim2.fromScale(0.5, 0.5);
        Frame.Size = UDim2.fromScale(1, 1);
        Frame.BackgroundColor3 = Color3_fromRGB_ret;
        Frame.BorderSizePixel = 0;
        Frame.ZIndex = 9;
        local v47 = p44:FindFirstChildOfClass("UICorner");

        if v47 then
            v47:Clone().Parent = Frame;
        end;

        local UIGradient = Instance.new("UIGradient");
        UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.4, 1),
            NumberSequenceKeypoint.new(0.5, 1 - (p45 or 0.8)),
            NumberSequenceKeypoint.new(0.6, 1),
            NumberSequenceKeypoint.new(1, 1)
        });
        UIGradient.Rotation = p46 or 0;
        UIGradient.Offset = Vector2.new(-1, 0);
        UIGradient.Parent = Frame;
        Frame.Parent = p44;
        u12.Tween(UIGradient, TweenInfo_new_ret12, {
            Offset = Vector2.new(1, 0)
        });
        u12.Cleanup(Frame, TweenInfo_new_ret12.Time);
    end;

    function u12.FloatText(p48, p49, p50, p51, p52) -- Line: 212
        -- upvalues: u12 (copy), u2 (copy), TweenInfo_new_ret7 (copy), TweenInfo_new_ret8 (copy), TweenInfo_new_ret9 (copy)
        local v53 = u12.Center(p48);
        local v54 = p49.AbsoluteSize.Y * (p52 or 1);
        local math_max_ret = math.max(p49.AbsoluteSize.X * (p52 or 1), v54 * #p50 * 0.6);
        local u55 = p49:Clone();

        for _, child in u55:GetChildren() do
            if child:IsA("UIScale") or (child:IsA("UIAspectRatioConstraint") or child:IsA("UISizeConstraint")) then
                child:Destroy();
            end;
        end;

        u55.Name = "FloatText";
        u55.Text = p50;
        u55.TextScaled = true;
        u55.TextTransparency = 0;
        u55.Visible = true;
        u55.AnchorPoint = Vector2.new(0.5, 0.5);
        u55.Position = UDim2.fromOffset(v53.X, v53.Y);
        u55.Size = UDim2.fromOffset(math_max_ret, v54);
        u55.Rotation = math.random(-10, 10);
        u55.ZIndex = 55;
        local UIScale = Instance.new("UIScale");
        UIScale.Scale = 0;
        UIScale.Parent = u55;
        u55.Parent = u2;
        u12.Tween(UIScale, TweenInfo_new_ret7, {
            Scale = 1
        });
        u12.Tween(u55, TweenInfo_new_ret8, {
            Rotation = 0,
            Position = UDim2.fromOffset(v53.X, v53.Y - p51)
        });
        task.delay(0.75, function() -- Line: 243
            -- upvalues: u12 (ref), u55 (copy), TweenInfo_new_ret9 (ref), UIScale (copy)
            u12.Tween(u55, TweenInfo_new_ret9, {
                TextTransparency = 1
            });
            u12.Tween(UIScale, TweenInfo_new_ret9, {
                Scale = 0.6
            });
            local v56 = u55:FindFirstChildOfClass("UIStroke");

            if v56 then
                u12.Tween(v56, TweenInfo_new_ret9, {
                    Transparency = 1
                });
            end;
        end);
        u12.Cleanup(u55, 0.75 + TweenInfo_new_ret9.Time);
    end;

    function u12.Fly(p57, p58, p59, p60) -- Line: 254
        -- upvalues: u12 (copy)
        p60.StartSize = p60.StartSize or p58.AbsoluteSize.X;
        u12.FlyFromPoint(p57, u12.Center(p58), p59, p60);
    end;

    function u12.FlyFromPoint(p61, p62, p63, p64) -- Line: 259
        -- upvalues: u2 (copy), u12 (copy), TweenInfo_new_ret7 (copy), TweenInfo_new_ret10 (copy), TweenService (copy), TweenInfo_new_ret11 (copy), RunService (copy)
        local v65 = p64.StartSize or 40;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Flyer";
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = p61;
        ImageLabel.Position = UDim2.fromOffset(p62.X, p62.Y);
        ImageLabel.Size = UDim2.fromOffset(v65, v65);
        ImageLabel.ZIndex = 53;
        local UIScale = Instance.new("UIScale");
        UIScale.Scale = 0;
        UIScale.Parent = ImageLabel;
        ImageLabel.Parent = u2;
        local v66 = math.random() * 3.141592653589793 * 2;
        local v67 = p64.Scatter * (0.5 + math.random() * 0.5);
        local v68 = p62 + Vector2.new(math.cos(v66), (math.sin(v66))) * v67;
        u12.Tween(UIScale, TweenInfo_new_ret7, {
            Scale = 1
        });
        u12.Tween(ImageLabel, TweenInfo_new_ret10, {
            Position = UDim2.fromOffset(v68.X, v68.Y),
            Rotation = math.random(-35, 35)
        });
        task.wait(TweenInfo_new_ret10.Time + (p64.Delay or 0));
        local v69 = (math.random() * 2 - 1) * 0.35;
        local Rotation = ImageLabel.Rotation;
        local v70 = p64.Duration or 0.6;
        local os_clock_ret = os.clock();
        local v71 = 0;

        while true do
            local v72 = (os.clock() - os_clock_ret) / v70;
            local math_min_ret = math.min(v72, 1);
            local Value = TweenService:GetValue(math_min_ret, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
            local v73 = u12.Center(p63);
            local v74 = v73 - v68;
            local Vector2_new_ret = Vector2.new(-v74.Y, v74.X);
            local v75 = v68 + v74 * 0.35 + Vector2_new_ret * v69;
            local v76 = v68:Lerp(v75, Value):Lerp(v75:Lerp(v73, Value), Value);
            local v77 = v65 + (p63.AbsoluteSize.X * 0.8 - v65) * Value;
            ImageLabel.Position = UDim2.fromOffset(v76.X, v76.Y);
            ImageLabel.Size = UDim2.fromOffset(v77, v77);
            ImageLabel.Rotation = Rotation * (1 - Value);

            if os.clock() - v71 >= 0.025 then
                v71 = os.clock();
                local ImageLabel2 = Instance.new("ImageLabel");
                ImageLabel2.Name = "Trail";
                ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
                ImageLabel2.BackgroundTransparency = 1;
                ImageLabel2.Image = p61;
                ImageLabel2.ImageTransparency = 0.55;
                ImageLabel2.Position = ImageLabel.Position;
                ImageLabel2.Size = UDim2.fromOffset(v77 * 0.85, v77 * 0.85);
                ImageLabel2.Rotation = ImageLabel.Rotation;
                ImageLabel2.ZIndex = 52;
                ImageLabel2.Parent = u2;
                u12.Tween(ImageLabel2, TweenInfo_new_ret11, {
                    ImageTransparency = 1,
                    Size = UDim2.fromOffset(0, 0)
                });
                u12.Cleanup(ImageLabel2, TweenInfo_new_ret11.Time);
            end;

            if math_min_ret >= 1 then
                ImageLabel:Destroy();

                if p64.OnArrive then
                    p64.OnArrive();
                end;

                return;
            end;

            RunService.RenderStepped:Wait();
        end;
    end;

    return u12;
end;