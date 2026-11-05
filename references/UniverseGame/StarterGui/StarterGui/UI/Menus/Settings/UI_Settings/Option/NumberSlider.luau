  

 

local UserInputService = game:GetService("UserInputService");

function Round(p1, p2)
    return tonumber(string.format("%." .. (p2 or 0) .. "f", p1));
end;

local function Snap(p3, p4) -- Line: 17
    if p4 == 0 then
        return math.floor(p3 + 0.5);
    end;

    return Round(math.floor(p3 / p4 + 0.5) * p4, #tostring(p4 - 2));
end;

local u5 = {};
u5.__index = u5;
u5.Cloner = script:WaitForChild("Slider");

function u5.new(u6, p7, p8, p9, p10, p11) -- Line: 30
    -- upvalues: u5 (copy)
    local v12 = setmetatable({}, u5);
    v12.Value = 0;
    v12.Connections = {};
    v12.Destroy = {};
    v12.Bar = u5.Cloner:Clone();
    v12.Bar.Parent = p7;
    v12.Slider = v12.Bar.Slider;
    v12.Min = p8 or 0;
    v12.Max = p9 or 1;
    local _ = p10 == nil;
    v12.Round = p10;
    v12.Steps = p11 or 0;
    v12.Label = v12.Bar.Slider:FindFirstChild("Label");
    v12.Changed = Instance.new("BindableEvent");
    table.insert(v12.Destroy, v12.Changed);
    table.insert(v12.Destroy, v12.Bar);

    if u6 then
        table.insert(v12.Connections, v12.Changed.Event:Connect(function(p13, p14) -- Line: 51
            -- upvalues: u6 (copy)
            u6(p13, p14);
        end));
    end;

    v12:Reconnect();

    return v12, v12.Changed.Event;
end;

function u5.Set(p15, p16, p17) -- Line: 61
    local v18 = math.clamp(p16, p15.Min, p15.Max);
    p15.Value = v18;
    local v19 = (v18 - p15.Min) / (p15.Max - p15.Min);
    p15:Update(v19);

    if p17 then
        p15.Slider:TweenPosition(UDim2.new(v19, 0, 0.5, 0), "Out", "Sine", 0.2, true);

        return;
    end;

    p15.Slider.Position = UDim2.new(v19, 0, 0.5, 0);
end;

function u5.Update(p20, p21) -- Line: 76
    local Value = p20.Value;
    local v22 = p20.Min + (p20.Max - p20.Min) * p21;
    local v23;

    if p20.Round then
        local Steps = p20.Steps;

        if Steps == 0 then
            v23 = math.floor(v22 + 0.5);
        else
            v23 = Round(math.floor(v22 / Steps + 0.5) * Steps, #tostring(Steps - 2));
        end;
    else
        v23 = Round(v22, 1);
    end;

    p20.Value = v23;

    if p20.Label then
        p20.Label.Text = tostring(v23);
    end;

    if p20.Value ~= Value then
        p20.Changed:Fire(v23, Value);
    end;
end;

function u5.Reconnect(u24) -- Line: 93
    -- upvalues: UserInputService (copy)
    local Bar = u24.Bar;
    local Slider = u24.Slider;
    local AbsoluteSize = Bar.AbsoluteSize;
    Bar:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 97
        -- upvalues: AbsoluteSize (ref), Bar (copy)
        AbsoluteSize = Bar.AbsoluteSize;
    end);
    local v26 = Bar.InputBegan:Connect(function(p25) -- Line: 100
        -- upvalues: u24 (copy)
        if p25.UserInputType == Enum.UserInputType.MouseButton1 or p25.UserInputType == Enum.UserInputType.Touch then
            u24.Listening = true;
        end;
    end);
    local v28 = Slider.InputBegan:Connect(function(p27) -- Line: 105
        -- upvalues: u24 (copy)
        if p27.UserInputType == Enum.UserInputType.MouseButton1 or p27.UserInputType == Enum.UserInputType.Touch then
            u24.Listening = true;
        end;
    end);
    local v30 = UserInputService.InputEnded:Connect(function(p29) -- Line: 110
        -- upvalues: u24 (copy)
        if p29.UserInputType == Enum.UserInputType.MouseButton1 or p29.UserInputType == Enum.UserInputType.Touch then
            u24.Listening = nil;
        end;
    end);
    local v31 = Slider.SelectionGained:Connect(function() -- Line: 115
        -- upvalues: u24 (copy)
        u24.Listening = true;
    end);
    local v32 = Slider.SelectionLost:Connect(function() -- Line: 118
        -- upvalues: u24 (copy)
        u24.Listening = nil;
    end);
    local v36 = UserInputService.InputChanged:Connect(function(p33) -- Line: 121
        -- upvalues: u24 (copy), Slider (copy), Bar (copy), AbsoluteSize (ref)
        if u24.Listening == true then
            local v34 = nil;

            if p33.KeyCode == Enum.KeyCode.Thumbstick1 then
                local X = p33.Position.X;

                if math.abs(X) > 0.15 then
                    v34 = Slider.Position.X.Scale + (X > 0 and 0.01 or -0.01);
                end;
            elseif p33.UserInputType == Enum.UserInputType.MouseMovement or p33.UserInputType == Enum.UserInputType.Touch then
                local AbsolutePosition = Bar.AbsolutePosition;
                local _ = (Bar.AbsolutePosition + AbsoluteSize).X - AbsolutePosition.X;
                v34 = (p33.Position.X - AbsolutePosition.X) / AbsoluteSize.X;
            end;

            if v34 then
                local v35 = math.clamp(v34, 0, 1);
                Slider.Position = UDim2.new(v35, 0, 0.5, 0);
                u24:Update(v35);
            end;
        end;
    end);
    table.insert(u24.Connections, v28);
    table.insert(u24.Connections, v26);
    table.insert(u24.Connections, v31);
    table.insert(u24.Connections, v36);
    table.insert(u24.Connections, v30);
    table.insert(u24.Connections, v32);
end;

function u5.Disconnect(p37) -- Line: 151
    for i = 1, #p37.Connections do
        p37.Connections[i]:Disconnect();
    end;
end;

function u5.Remove(p38) -- Line: 158
    for i = 1, #p38.Destroy do
        p38.Destroy[i]:Destroy();
    end;

    p38.Destroy = {};
    p38:Disconnect();
end;

return u5;