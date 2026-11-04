 
 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local FXLayer = LocalPlayer.PlayerGui:WaitForChild("InGame").BG:WaitForChild("FXLayer");
local u1 = {
    LAYER_Z = 50,
    SPARKLE_IMAGE = "rbxassetid://105875324111234",
    WHITE = Color3.fromRGB(255, 255, 255),
    FLOAT_HOLD = 0.75,
    TRAIL_RATE = 0.025,
    TRAIL_TRANSPARENCY = 0.55,
    PUNCH_UP_INFO = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    PUNCH_DOWN_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    RING_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    FLASH_INFO = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    SPARKLE_INFO = TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    SPARKLE_FADE_INFO = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    POP_INFO = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    RISE_INFO = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    FADE_INFO = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    BURST_INFO = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    TRAIL_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    SHINE_INFO = TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
};
local u11 = {
    Layer = FXLayer,

    Tween = function(p2: userdata, p3: userdata, p4: table) -- Line: 33, Name: Tween
        -- upvalues: TweenService (copy)
        local v5 = TweenService:Create(p2, p3, p4);
        v5:Play();

        return v5;
    end,

    Cleanup = function(p6: userdata, p7: number) -- Line: 40, Name: Cleanup
        task.delay(p7, p6.Destroy, p6);
    end,

    GetScale = function(p8: userdata) -- Line: 44, Name: GetScale
        local v9 = p8:FindFirstChildOfClass("UIScale");

        if not v9 then
            v9 = Instance.new("UIScale");
            v9.Parent = p8;
        end;

        return v9;
    end,

    Center = function(p10: userdata) -- Line: 55, Name: Center
        -- upvalues: FXLayer (copy)
        return p10.AbsolutePosition + p10.AbsoluteSize / 2 - FXLayer.AbsolutePosition;
    end
};

local function Bezier(p12, p13, p14, p15: number) -- Line: 59
    return p12:Lerp(p13, p15):Lerp(p13:Lerp(p14, p15), p15);
end;

function u11.Punch(p16: userdata, p17: number) -- Line: 63
    -- upvalues: u11 (copy), u1 (copy)
    local Scale = u11.GetScale(p16);
    u11.Tween(Scale, u1.PUNCH_UP_INFO, {
        Scale = p17
    });
    task.delay(u1.PUNCH_UP_INFO.Time, function() -- Line: 68
        -- upvalues: u11 (ref), Scale (copy), u1 (ref)
        u11.Tween(Scale, u1.PUNCH_DOWN_INFO, {
            Scale = 1
        });
    end);
end;

function u11.Wiggle(u18: userdata, u19: number, u20: number) -- Line: 73
    -- upvalues: RunService (copy)
    task.spawn(function() -- Line: 74
        -- upvalues: u20 (copy), u18 (copy), u19 (copy), RunService (ref)
        local os_clock_ret = os.clock();

        while true do
            local v21 = (os.clock() - os_clock_ret) / u20;

            if v21 >= 1 then
                break;
            end;

            u18.Rotation = math.sin(v21 * 3.141592653589793 * 6) * u19 * (1 - v21) ^ 2;
            RunService.RenderStepped:Wait();
        end;

        u18.Rotation = 0;
    end);
end;

function u11.Ring(p22: userdata, p23, p24: number, p25: number?) -- Line: 93
    -- upvalues: u11 (copy), u1 (copy), FXLayer (copy)
    local v26 = u11.Center(p22);
    local math_max_ret = math.max(p22.AbsoluteSize.X, p22.AbsoluteSize.Y);
    local Frame = Instance.new("Frame");
    Frame.Name = "Ring";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromOffset(v26.X, v26.Y);
    Frame.Size = UDim2.fromOffset(math_max_ret * 0.6, math_max_ret * 0.6);
    Frame.BackgroundTransparency = 1;
    Frame.ZIndex = u1.LAYER_Z + 1;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p23 or u1.WHITE;
    UIStroke.Thickness = p25 or 4;
    UIStroke.Parent = Frame;
    Frame.Parent = FXLayer;
    u11.Tween(Frame, u1.RING_INFO, {
        Size = UDim2.fromOffset(math_max_ret * p24, math_max_ret * p24)
    });
    u11.Tween(UIStroke, u1.RING_INFO, {
        Transparency = 1,
        Thickness = 0
    });
    u11.Cleanup(Frame, u1.RING_INFO.Time);
end;

function u11.Sparkles(p27: userdata, p28: number, p29, p30: number, p31: string?, p32: number?) -- Line: 121
    -- upvalues: u11 (copy), u1 (copy), FXLayer (copy)
    local v33 = u11.Center(p27);
    local v34 = p32 or math.max(p27.AbsoluteSize.X, p27.AbsoluteSize.Y) * 0.35;

    for i = 1, p28 do
        local v35 = i / p28 * 3.141592653589793 * 2 + math.random() * 0.6;
        local v36 = p30 * (0.6 + math.random() * 0.5);
        local v37 = v33 + Vector2.new(math.cos(v35), (math.sin(v35))) * v36;
        local v38 = v34 * (0.6 + math.random() * 0.6);
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "Sparkle";
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = p31 or u1.SPARKLE_IMAGE;
        ImageLabel.ImageColor3 = p29 or u1.WHITE;
        ImageLabel.Position = UDim2.fromOffset(v33.X, v33.Y);
        ImageLabel.Size = UDim2.fromOffset(v38, v38);
        ImageLabel.Rotation = math.random(0, 360);
        ImageLabel.ZIndex = u1.LAYER_Z + 2;
        ImageLabel.Parent = FXLayer;
        u11.Tween(ImageLabel, u1.SPARKLE_INFO, {
            Position = UDim2.fromOffset(v37.X, v37.Y),
            Rotation = ImageLabel.Rotation + math.random(-180, 180)
        });
        task.delay(u1.SPARKLE_INFO.Time - u1.SPARKLE_FADE_INFO.Time, function() -- Line: 148
            -- upvalues: u11 (ref), ImageLabel (copy), u1 (ref)
            u11.Tween(ImageLabel, u1.SPARKLE_FADE_INFO, {
                ImageTransparency = 1,
                Size = UDim2.fromOffset(0, 0)
            });
        end);
        u11.Cleanup(ImageLabel, u1.SPARKLE_INFO.Time + 0.05);
        local _ = i;
    end;
end;

function u11.Flash(p39: userdata, p40, p41: number?) -- Line: 156
    -- upvalues: u1 (copy), u11 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Flash";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = p40 or u1.WHITE;
    Frame.BackgroundTransparency = p41 or 0.3;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 10;
    local v42 = p39:FindFirstChildOfClass("UICorner");

    if v42 then
        v42:Clone().Parent = Frame;
    end;

    Frame.Parent = p39;
    u11.Tween(Frame, u1.FLASH_INFO, {
        BackgroundTransparency = 1
    });
    u11.Cleanup(Frame, u1.FLASH_INFO.Time);
end;

function u11.Shine(p43: userdata, p44: number?, p45: number?) -- Line: 179
    -- upvalues: u1 (copy), u11 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Shine";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = u1.WHITE;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 9;
    local v46 = p43:FindFirstChildOfClass("UICorner");

    if v46 then
        v46:Clone().Parent = Frame;
    end;

    local UIGradient = Instance.new("UIGradient");
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.4, 1),
        NumberSequenceKeypoint.new(0.5, 1 - (p44 or 0.8)),
        NumberSequenceKeypoint.new(0.6, 1),
        NumberSequenceKeypoint.new(1, 1)
    });
    UIGradient.Rotation = p45 or 0;
    UIGradient.Offset = Vector2.new(-1, 0);
    UIGradient.Parent = Frame;
    Frame.Parent = p43;
    u11.Tween(UIGradient, u1.SHINE_INFO, {
        Offset = Vector2.new(1, 0)
    });
    u11.Cleanup(Frame, u1.SHINE_INFO.Time);
end;

function u11.FloatText(p47: userdata, p48: userdata, p49: string, p50: number, p51: number?) -- Line: 215
    -- upvalues: u11 (copy), u1 (copy), FXLayer (copy)
    local v52 = u11.Center(p47);
    local v53 = p48.AbsoluteSize.Y * (p51 or 1);
    local math_max_ret = math.max(p48.AbsoluteSize.X * (p51 or 1), v53 * #p49 * 0.6);
    local u54 = p48:Clone();

    for _, child in u54:GetChildren() do
        if child:IsA("UIScale") or (child:IsA("UIAspectRatioConstraint") or child:IsA("UISizeConstraint")) then
            child:Destroy();
        end;
    end;

    u54.Name = "FloatText";
    u54.Text = p49;
    u54.TextScaled = true;
    u54.TextTransparency = 0;
    u54.Visible = true;
    u54.AnchorPoint = Vector2.new(0.5, 0.5);
    u54.Position = UDim2.fromOffset(v52.X, v52.Y);
    u54.Size = UDim2.fromOffset(math_max_ret, v53);
    u54.Rotation = math.random(-10, 10);
    u54.ZIndex = u1.LAYER_Z + 5;
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 0;
    UIScale.Parent = u54;
    u54.Parent = FXLayer;
    u11.Tween(UIScale, u1.POP_INFO, {
        Scale = 1
    });
    u11.Tween(u54, u1.RISE_INFO, {
        Rotation = 0,
        Position = UDim2.fromOffset(v52.X, v52.Y - p50)
    });
    task.delay(u1.FLOAT_HOLD, function() -- Line: 248
        -- upvalues: u11 (ref), u54 (copy), u1 (ref), UIScale (copy)
        u11.Tween(u54, u1.FADE_INFO, {
            TextTransparency = 1
        });
        u11.Tween(UIScale, u1.FADE_INFO, {
            Scale = 0.6
        });
        local v55 = u54:FindFirstChildOfClass("UIStroke");

        if v55 then
            u11.Tween(v55, u1.FADE_INFO, {
                Transparency = 1
            });
        end;
    end);
    u11.Cleanup(u54, u1.FLOAT_HOLD + u1.FADE_INFO.Time);
end;

function u11.Fly(p56: string, p57: userdata, p58: userdata, p59: table) -- Line: 262
    -- upvalues: u11 (copy), u1 (copy), FXLayer (copy), TweenService (copy), RunService (copy)
    local v60 = u11.Center(p57);
    local v61 = p59.StartSize or p57.AbsoluteSize.X;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Flyer";
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = p56;
    ImageLabel.Position = UDim2.fromOffset(v60.X, v60.Y);
    ImageLabel.Size = UDim2.fromOffset(v61, v61);
    ImageLabel.ZIndex = u1.LAYER_Z + 3;
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 0;
    UIScale.Parent = ImageLabel;
    ImageLabel.Parent = FXLayer;
    local v62 = math.random() * 3.141592653589793 * 2;
    local v63 = p59.Scatter * (0.5 + math.random() * 0.5);
    local v64 = v60 + Vector2.new(math.cos(v62), (math.sin(v62))) * v63;
    u11.Tween(UIScale, u1.POP_INFO, {
        Scale = 1
    });
    u11.Tween(ImageLabel, u1.BURST_INFO, {
        Position = UDim2.fromOffset(v64.X, v64.Y),
        Rotation = math.random(-35, 35)
    });
    task.wait(u1.BURST_INFO.Time + (p59.Delay or 0));
    local v65 = (math.random() * 2 - 1) * 0.35;
    local Rotation = ImageLabel.Rotation;
    local v66 = p59.Duration or 0.6;
    local os_clock_ret = os.clock();
    local v67 = 0;

    while true do
        local v68 = (os.clock() - os_clock_ret) / v66;
        local math_min_ret = math.min(v68, 1);
        local Value = TweenService:GetValue(math_min_ret, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local v69 = u11.Center(p58);
        local v70 = v69 - v64;
        local Vector2_new_ret = Vector2.new(-v70.Y, v70.X);
        local v71 = v64 + v70 * 0.35 + Vector2_new_ret * v65;
        local v72 = v64:Lerp(v71, Value):Lerp(v71:Lerp(v69, Value), Value);
        local v73 = v61 + (p58.AbsoluteSize.X * 0.8 - v61) * Value;
        ImageLabel.Position = UDim2.fromOffset(v72.X, v72.Y);
        ImageLabel.Size = UDim2.fromOffset(v73, v73);
        ImageLabel.Rotation = Rotation * (1 - Value);

        if os.clock() - v67 >= u1.TRAIL_RATE then
            v67 = os.clock();
            local ImageLabel2 = Instance.new("ImageLabel");
            ImageLabel2.Name = "Trail";
            ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel2.BackgroundTransparency = 1;
            ImageLabel2.Image = p56;
            ImageLabel2.ImageTransparency = u1.TRAIL_TRANSPARENCY;
            ImageLabel2.Position = ImageLabel.Position;
            ImageLabel2.Size = UDim2.fromOffset(v73 * 0.85, v73 * 0.85);
            ImageLabel2.Rotation = ImageLabel.Rotation;
            ImageLabel2.ZIndex = u1.LAYER_Z + 2;
            ImageLabel2.Parent = FXLayer;
            u11.Tween(ImageLabel2, u1.TRAIL_INFO, {
                ImageTransparency = 1,
                Size = UDim2.fromOffset(0, 0)
            });
            u11.Cleanup(ImageLabel2, u1.TRAIL_INFO.Time);
        end;

        if math_min_ret >= 1 then
            ImageLabel:Destroy();

            if p59.OnArrive then
                p59.OnArrive();
            end;

            return;
        end;

        RunService.RenderStepped:Wait();
    end;
end;

return u11;