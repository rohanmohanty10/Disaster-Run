  

 

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Drag = require(script.Drag);
local u1 = {};
u1.__index = u1;

function toPolar(p2)
    return math.atan2(p2.y, p2.x), p2.Magnitude;
end;

function radToDeg(p3)
    return (p3 + 3.141592653589793) / 6.283185307179586 * 360;
end;

function template(p4, p5)
    local v6 = (not p4 or (typeof(p4) ~= "table" or not p4)) and {} or p4;

    for i, v in pairs(p5) do
        if v6[i] == nil then
            v6[i] = v;
        end;
    end;

    return v6;
end;

function rotateVector(p7, p8)
    local v9 = math.rad(p8);
    local X = p7.X;
    local Y = p7.Y;

    return Vector2.new(X * math.cos(v9) - Y * math.sin(v9), X * math.sin(v9) + Y * math.cos(v9));
end;

function roundToHundredths(p10)
    return math.ceil(p10 * 100) / 100;
end;

function u1.New(p11, p12, p13) -- Line: 62
    -- upvalues: u1 (copy), RunService (copy), UserInputService (copy)
    local v14 = template(p13, {
        Draggable = true,
        RoundedCorners = true,
        Position = UDim2.fromOffset(p12.X + 16, p12.Y + 16),
        PrimaryColor = Color3.fromRGB(26, 26, 36),
        SecondaryColor = Color3.fromRGB(36, 36, 46),
        TopbarColor = Color3.fromRGB(21, 21, 31),
        TextColor = Color3.fromRGB(255, 255, 255)
    });
    local v15 = {
        Gui = p11,
        Mouse = p12,
        Color = Color3.fromRGB(255, 255, 255),
        Params = v14
    };
    local u16 = setmetatable(v15, u1);
    u16:Create();
    u16._wheelDownFunc = nil;
    u16._wheelUpFunc_uis = nil;

    local function _resetWheelFunc() -- Line: 88
        -- upvalues: u16 (copy)
        if u16._wheelDownFunc then
            u16._wheelDownFunc:Disconnect();
            u16._wheelDownFunc = nil;
        end;

        if u16._wheelUpFunc_uis then
            u16._wheelUpFunc_uis:Disconnect();
            u16._wheelUpFunc_uis = nil;
        end;
    end;

    u16.Instance.Wheel.Button.MouseButton1Down:Connect(function() -- Line: 100
        -- upvalues: u16 (copy), RunService (ref), UserInputService (ref)
        u16.Instance.Parent.Topbar.Button.Visible = false;

        if u16._wheelDownFunc then
            u16._wheelDownFunc:Disconnect();
            u16._wheelDownFunc = nil;
        end;

        if u16._wheelUpFunc_uis then
            u16._wheelUpFunc_uis:Disconnect();
            u16._wheelUpFunc_uis = nil;
        end;

        u16._wheelDownFunc = RunService.Heartbeat:Connect(function() -- Line: 104
            -- upvalues: u16 (ref)
            local v17 = u16:GetMouseToWheelPos();
            u16.Instance.Wheel.Image.Select.Position = UDim2.fromOffset(v17.X, v17.Y);
            u16:SetColorFromPos(v17);
        end);
        u16._wheelUpFunc_uis = UserInputService.InputEnded:Connect(function(p18, p19) -- Line: 111
            -- upvalues: u16 (ref)
            if p19 then
                return;
            end;

            if p18.UserInputType == Enum.UserInputType.MouseButton1 or p18.UserInputType == Enum.UserInputType.Touch then
                if u16._wheelDownFunc then
                    u16._wheelDownFunc:Disconnect();
                    u16._wheelDownFunc = nil;
                end;

                if u16._wheelUpFunc_uis then
                    u16._wheelUpFunc_uis:Disconnect();
                    u16._wheelUpFunc_uis = nil;
                end;
            end;
        end);
    end);
    u16.Instance.Wheel.Button.MouseButton1Up:Connect(function() -- Line: 120
        -- upvalues: u16 (copy)
        u16.Instance.Parent.Topbar.Button.Visible = true;

        if u16._wheelDownFunc then
            u16._wheelDownFunc:Disconnect();
            u16._wheelDownFunc = nil;
        end;

        if u16._wheelUpFunc_uis then
            u16._wheelUpFunc_uis:Disconnect();
            u16._wheelUpFunc_uis = nil;
        end;
    end);
    u16._valueDownFunc = nil;
    u16._valueUpFunc_uis = nil;

    local function _resetValueFunc() -- Line: 129
        -- upvalues: u16 (copy)
        if u16._valueDownFunc then
            u16._valueDownFunc:Disconnect();
            u16._valueDownFunc = nil;
        end;

        if u16._valueUpFunc_uis then
            u16._valueUpFunc_uis:Disconnect();
            u16._valueUpFunc_uis = nil;
        end;
    end;

    u16.Instance.Right.Value.Button.MouseButton1Down:Connect(function() -- Line: 141
        -- upvalues: u16 (copy), RunService (ref), UserInputService (ref)
        u16.Instance.Parent.Topbar.Button.Visible = false;

        if u16._valueDownFunc then
            u16._valueDownFunc:Disconnect();
            u16._valueDownFunc = nil;
        end;

        if u16._valueUpFunc_uis then
            u16._valueUpFunc_uis:Disconnect();
            u16._valueUpFunc_uis = nil;
        end;

        u16._valueDownFunc = RunService.Heartbeat:Connect(function() -- Line: 145
            -- upvalues: u16 (ref)
            local v20 = u16:GetMouseToValuePos();
            u16.Instance.Right.Value.Select.Position = UDim2.new(0, 0, v20, 0);
            local v21, v22, _ = u16.Color:ToHSV();
            u16.Color = Color3.fromHSV(u16.CurrentHue or v21, u16.CurrentSaturation or v22, 1 - v20);
            u16:UpdateColor();
        end);
        u16._valueUpFunc_uis = UserInputService.InputEnded:Connect(function(p23, p24) -- Line: 155
            -- upvalues: u16 (ref)
            if p24 then
                return;
            end;

            if p23.UserInputType == Enum.UserInputType.MouseButton1 or p23.UserInputType == Enum.UserInputType.Touch then
                if u16._valueDownFunc then
                    u16._valueDownFunc:Disconnect();
                    u16._valueDownFunc = nil;
                end;

                if u16._valueUpFunc_uis then
                    u16._valueUpFunc_uis:Disconnect();
                    u16._valueUpFunc_uis = nil;
                end;
            end;
        end);
    end);
    u16.Instance.Right.Value.Button.MouseButton1Up:Connect(function() -- Line: 164
        -- upvalues: u16 (copy)
        u16.Instance.Parent.Topbar.Button.Visible = true;

        if u16._valueDownFunc then
            u16._valueDownFunc:Disconnect();
            u16._valueDownFunc = nil;
        end;

        if u16._valueUpFunc_uis then
            u16._valueUpFunc_uis:Disconnect();
            u16._valueUpFunc_uis = nil;
        end;
    end);
    u16:UpdateColor();
    u16.Instance.Bottom.Buttons.Confirm.MouseButton1Down:Connect(function() -- Line: 173
        -- upvalues: u16 (copy)
        u16.Instance.Parent.FinishedEvent:Fire(u16.Color);
        u16:Destroy();
    end);
    u16.Instance.Bottom.Buttons.Cancel.MouseButton1Down:Connect(function() -- Line: 178
        -- upvalues: u16 (copy)
        u16.Instance.Parent.CanceledEvent:Fire();
        u16:Destroy();
    end);

    for _, child in pairs(u16.Instance.Parent.Properties.RGB:GetChildren()) do
        if child:IsA("Frame") then
            child.Frame.TextBox.FocusLost:Connect(function() -- Line: 186
                -- upvalues: child (copy), u16 (copy)
                if not tonumber(child.Frame.TextBox.Text) then
                    child.Frame.TextBox.Text = "0";
                end;

                local v25 = tonumber(u16.Instance.Parent.Properties.RGB.R.Frame.TextBox.Text) or 0;
                local v26 = tonumber(u16.Instance.Parent.Properties.RGB.G.Frame.TextBox.Text) or 0;
                local v27 = tonumber(u16.Instance.Parent.Properties.RGB.B.Frame.TextBox.Text) or 0;
                local v28 = math.clamp(v25, 0, 255);
                local v29 = math.clamp(v26, 0, 255);
                local v30 = math.clamp(v27, 0, 255);
                u16:SetColor(Color3.fromRGB(v28, v29, v30));
            end);
        end;
    end;

    for _, child in pairs(u16.Instance.Parent.Properties.HSV:GetChildren()) do
        if child:IsA("Frame") then
            child.Frame.TextBox.FocusLost:Connect(function() -- Line: 204
                -- upvalues: child (copy), u16 (copy)
                if not tonumber(child.Frame.TextBox.Text) then
                    child.Frame.TextBox.Text = "0";
                end;

                local v31 = tonumber(u16.Instance.Parent.Properties.HSV.H.Frame.TextBox.Text) or 0;
                local v32 = tonumber(u16.Instance.Parent.Properties.HSV.S.Frame.TextBox.Text) or 0;
                local v33 = tonumber(u16.Instance.Parent.Properties.HSV.V.Frame.TextBox.Text) or 0;
                local v34 = math.clamp(v31, 0, 360);
                local v35 = math.clamp(v32, 0, 1);
                local v36 = math.clamp(v33, 0, 1);
                u16:SetColor(Color3.fromHSV(v34 / 360, v35, v36));
            end);
        end;
    end;

    u16.Instance.Parent.Content.Bottom.Hex.Frame.TextBox.FocusLost:Connect(function() -- Line: 220
        -- upvalues: u16 (copy)
        local Text = u16.Instance.Parent.Content.Bottom.Hex.Frame.TextBox.Text;
        local success, _ = pcall(function() -- Line: 222
            -- upvalues: Text (ref)
            Text = Color3.fromHex(Text);
        end);

        if not success then
            Text = Color3.fromRGB(255, 255, 255);
        end;

        u16.Instance.Parent.Content.Bottom.Hex.Frame.TextBox.Text = Text:ToHex();
        u16:SetColor(Text);
    end);

    return u16;
end;

function u1.Create(u37) -- Line: 239
    -- upvalues: UserInputService (copy), Drag (copy)
    local v38 = script.ColorWindow:Clone();
    v38.Position = u37.Params.Position;
    v38.Parent = u37.Gui;
    v38.Visible = true;
    u37.Instance = v38.Content;

    for _, descendant in pairs(v38:GetDescendants()) do
        if not u37.Params.RoundedCorners and (descendant:IsA("UICorner") and descendant.Parent.Name ~= "Select") then
            descendant:Destroy();
        end;

        if descendant:IsA("TextLabel") or (descendant:IsA("TextBox") or descendant:IsA("ImageButton")) then
            descendant[(descendant:IsA("TextLabel") or descendant:IsA("TextBox")) and "TextColor3" or "ImageColor3"] = u37.Params.TextColor;
        end;
    end;

    v38.BackgroundColor3 = u37.Params.PrimaryColor;
    v38.Properties.BackgroundColor3 = u37.Params.PrimaryColor;
    v38.Properties.Line.BackgroundColor3 = u37.Params.SecondaryColor;
    v38.Content.Bottom.Hex.Frame.BackgroundColor3 = u37.Params.SecondaryColor;

    for _, v in pairs({ v38.Properties.HSV, v38.Properties.RGB }) do
        for _, child in pairs(v:GetChildren()) do
            if child:IsA("Frame") then
                child.Frame.BackgroundColor3 = u37.Params.SecondaryColor;
            end;
        end;
    end;

    v38.Topbar.BackgroundColor3 = u37.Params.TopbarColor;
    v38.Topbar.Frame.BackgroundColor3 = u37.Params.TopbarColor;
    u37.Finished = v38.FinishedEvent.Event;
    u37.Canceled = v38.CanceledEvent.Event;
    u37.Updated = v38.UpdateEvent.Event;

    if u37.Params.Draggable and not UserInputService.TouchEnabled then
        u37.Drag = Drag.New(u37.Instance.Parent);
        local Button = u37.Instance.Parent.Topbar.Button;
        Button.MouseButton1Down:Connect(function() -- Line: 284
            -- upvalues: u37 (copy)
            u37.Drag:Start();
        end);
        Button.MouseButton1Up:Connect(function() -- Line: 288
            -- upvalues: u37 (copy)
            u37.Drag:Stop();
        end);
        u37._dragStopFunc = UserInputService.InputEnded:Connect(function(p39, p40) -- Line: 292
            -- upvalues: u37 (copy)
            if p40 then
                return;
            end;

            if (p39.UserInputType == Enum.UserInputType.MouseButton1 or p39.UserInputType == Enum.UserInputType.Touch) and u37.Drag.Active then
                u37.Drag:Stop();
            end;
        end);
    end;
end;

function u1.Destroy(p41) -- Line: 305
    if p41.Instance and p41.Instance.Parent then
        p41.Instance.Parent:Destroy();
    end;

    if p41._dragStopFunc then
        p41._dragStopFunc:Disconnect();
        p41._dragStopFunc = nil;
    end;

    if p41._valueDownFunc then
        p41._valueDownFunc:Disconnect();
        p41._valueDownFunc = nil;
    end;

    if p41._valueUpFunc_uis then
        p41._valueUpFunc_uis:Disconnect();
        p41._valueUpFunc_uis = nil;
    end;
end;

function u1.GetMouseToWheelPos(p42) -- Line: 328
    local v43 = Vector2.new(p42.Mouse.X, p42.Mouse.Y);
    local AbsolutePosition = p42.Instance.Wheel.Image.AbsolutePosition;
    local AbsoluteSize = p42.Instance.Wheel.Image.AbsoluteSize;
    local v44 = AbsoluteSize.X / 2;
    local v45 = AbsolutePosition + AbsoluteSize / 2 - v43;

    if v44 < v45.Magnitude then
        return AbsoluteSize / 2 - v45.Unit * v44;
    end;

    return v43 - AbsolutePosition;
end;

function u1.GetMouseToValuePos(p46) -- Line: 346
    local v47 = Vector2.new(p46.Mouse.X, p46.Mouse.Y);

    return math.clamp((v47.Y - p46.Instance.Right.Value.AbsolutePosition.Y) / p46.Instance.Right.Value.AbsoluteSize.Y, 0, 1);
end;

function u1.UpdateColor(p48) -- Line: 355
    p48.Instance.Parent.UpdateEvent:Fire(p48.Color);
    p48.Instance.Bottom.Color.Frame.BackgroundColor3 = p48.Color;
    p48.Instance.Parent.Properties.RGB.R.Frame.TextBox.Text = math.floor(p48.Color.R * 255 + 0.5);
    p48.Instance.Parent.Properties.RGB.G.Frame.TextBox.Text = math.floor(p48.Color.G * 255 + 0.5);
    p48.Instance.Parent.Properties.RGB.B.Frame.TextBox.Text = math.floor(p48.Color.B * 255 + 0.5);
    local v49, v50, v51 = p48.Color:ToHSV();
    p48.Instance.Parent.Properties.HSV.H.Frame.TextBox.Text = math.floor(v49 * 360 + 0.5);
    p48.Instance.Parent.Properties.HSV.S.Frame.TextBox.Text = roundToHundredths(v50);
    p48.Instance.Parent.Properties.HSV.V.Frame.TextBox.Text = roundToHundredths(v51);
    local v52 = (p48.Color.R ~= p48.Color.R or (p48.Color.G ~= p48.Color.G or p48.Color.B ~= p48.Color.B)) and "000000" or p48.Color:ToHex();
    p48.Instance.Parent.Content.Bottom.Hex.Frame.TextBox.Text = string.format("#%s", string.lower(v52));
end;

function u1.SetColorFromPos(p53, p54) -- Line: 373
    local AbsoluteSize = p53.Instance.Wheel.Image.AbsoluteSize;
    local v55 = AbsoluteSize / 2 - p54;
    local v56 = AbsoluteSize.X / 2;
    math.min(v55.Magnitude, v56);
    local v57, v58 = toPolar(v55 * Vector2.new(-1, 1));
    local v59 = radToDeg(v57) / 360;
    local v60 = math.clamp(v59, 0, 1);
    local v61 = math.clamp(v58 / v56, 0, 1);
    local _, _, v62 = p53.Color:ToHSV();
    p53.Color = Color3.fromHSV(v60, v61, v62);
    p53:UpdateColor();
    p53:SetValueGradient(v60, v61);
end;

function u1.SetValueGradient(p63, p64, p65) -- Line: 395
    p63.CurrentSaturation = p65;
    p63.CurrentHue = p64;
    local v66 = Color3.fromHSV(p64, p65, 1);
    p63.Instance.Right.Value.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v66), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) });
end;

function u1.SetColor(p67, p68) -- Line: 407
    local v69, v70, v71 = p68:ToHSV();
    p67.Color = p68;
    local AbsoluteSize = p67.Instance.Wheel.Image.AbsoluteSize;
    local _ = AbsoluteSize / 2;
    local _ = AbsoluteSize.X / 2;
    local v72 = Vector2.new(0.5, 0.5);
    local v73 = Vector2.new(-1, 0);
    local v74 = rotateVector(v73, v69 * -360);
    local v75 = v72 - rotateVector(v74, 180) * v70 * 0.5;
    p67.Instance.Wheel.Image.Select.Position = UDim2.fromScale(v75.X, v75.Y);
    p67.Instance.Right.Value.Select.Position = UDim2.new(0, 0, 1 - v71, 0);
    p67:UpdateColor();
    p67:SetValueGradient(v69, v70);
end;

return u1;