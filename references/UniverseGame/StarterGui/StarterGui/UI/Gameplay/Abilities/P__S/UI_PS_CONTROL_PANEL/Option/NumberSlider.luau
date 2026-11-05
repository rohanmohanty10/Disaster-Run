  

 

local UserInputService = game:GetService("UserInputService");
local u1 = {};
u1.__index = u1;
u1.Cloner = script:WaitForChild("Slider");

function u1.new(u2, p3, p4, p5, p6) -- Line: 19
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7.Value = 0;
    v7.Connections = {};
    v7.Destroy = {};
    v7.Bar = u1.Cloner:Clone();
    v7.Bar.Parent = p3;
    v7.Slider = v7.Bar.Slider;
    v7.Min = p4 or 0;
    v7.Max = p5 or 1;
    local _ = p6 == nil;
    v7.Round = p6;
    v7.Label = v7.Bar.Slider:FindFirstChild("Label");
    v7.Changed = Instance.new("BindableEvent");
    table.insert(v7.Destroy, v7.Changed);
    table.insert(v7.Destroy, v7.Bar);

    if u2 then
        table.insert(v7.Connections, v7.Changed.Event:Connect(function(p8, p9) -- Line: 39
            -- upvalues: u2 (copy)
            u2(p8, p9);
        end));
    end;

    v7:Reconnect();

    return v7, v7.Changed.Event;
end;

function u1.Set(p10, p11, p12) -- Line: 49
    local v13 = math.clamp(p11, p10.Min, p10.Max);
    p10.Value = v13;
    local v14 = (v13 - p10.Min) / (p10.Max - p10.Min);
    p10:Update(v14);

    if p12 then
        p10.Slider:TweenPosition(UDim2.new(v14, 0, 0.5, 0), "Out", "Sine", 0.2, true);

        return;
    end;

    p10.Slider.Position = UDim2.new(v14, 0, 0.5, 0);
end;

function u1.Update(p15, p16) -- Line: 65
    local Value = p15.Value;
    local v17 = p15.Min + (p15.Max - p15.Min) * p16;

    if p15.Round then
        v17 = math.floor(v17 + 0.5);
    end;

    p15.Value = v17;

    if p15.Label then
        p15.Label.Text = tostring(v17);
    end;

    if p15.Value ~= Value then
        p15.Changed:Fire(v17, Value);
    end;
end;

function u1.Reconnect(u18) -- Line: 80
    -- upvalues: UserInputService (copy)
    local Bar = u18.Bar;
    local Slider = u18.Slider;
    local AbsoluteSize = Bar.AbsoluteSize;
    Bar:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 84
        -- upvalues: AbsoluteSize (ref), Bar (copy)
        AbsoluteSize = Bar.AbsoluteSize;
    end);
    local v20 = Bar.InputBegan:Connect(function(p19) -- Line: 87
        -- upvalues: u18 (copy)
        if p19.UserInputType == Enum.UserInputType.MouseButton1 or p19.UserInputType == Enum.UserInputType.Touch then
            u18.Listening = true;
        end;
    end);
    local v22 = Slider.InputBegan:Connect(function(p21) -- Line: 92
        -- upvalues: u18 (copy)
        if p21.UserInputType == Enum.UserInputType.MouseButton1 or p21.UserInputType == Enum.UserInputType.Touch then
            u18.Listening = true;
        end;
    end);
    local v24 = UserInputService.InputEnded:Connect(function(p23) -- Line: 97
        -- upvalues: u18 (copy)
        if p23.UserInputType == Enum.UserInputType.MouseButton1 or p23.UserInputType == Enum.UserInputType.Touch then
            u18.Listening = nil;
        end;
    end);
    local v25 = Slider.SelectionGained:Connect(function() -- Line: 102
        -- upvalues: u18 (copy)
        u18.Listening = true;
    end);
    local v26 = Slider.SelectionLost:Connect(function() -- Line: 105
        -- upvalues: u18 (copy)
        u18.Listening = nil;
    end);
    local v30 = UserInputService.InputChanged:Connect(function(p27) -- Line: 108
        -- upvalues: u18 (copy), Slider (copy), Bar (copy), AbsoluteSize (ref)
        if u18.Listening == true then
            local v28 = nil;

            if p27.KeyCode == Enum.KeyCode.Thumbstick1 then
                local X = p27.Position.X;

                if math.abs(X) > 0.15 then
                    v28 = Slider.Position.X.Scale + (X > 0 and 0.01 or -0.01);
                end;
            elseif p27.UserInputType == Enum.UserInputType.MouseMovement or p27.UserInputType == Enum.UserInputType.Touch then
                local AbsolutePosition = Bar.AbsolutePosition;
                local _ = (Bar.AbsolutePosition + AbsoluteSize).X - AbsolutePosition.X;
                v28 = (p27.Position.X - AbsolutePosition.X) / AbsoluteSize.X;
            end;

            if v28 then
                local v29 = math.clamp(v28, 0, 1);
                Slider.Position = UDim2.new(v29, 0, 0.5, 0);
                u18:Update(v29);
            end;
        end;
    end);
    table.insert(u18.Connections, v22);
    table.insert(u18.Connections, v20);
    table.insert(u18.Connections, v25);
    table.insert(u18.Connections, v30);
    table.insert(u18.Connections, v24);
    table.insert(u18.Connections, v26);
end;

function u1.Disconnect(p31) -- Line: 138
    for i = 1, #p31.Connections do
        p31.Connections[i]:Disconnect();
    end;
end;

function u1.Remove(p32) -- Line: 145
    for i = 1, #p32.Destroy do
        p32.Destroy[i]:Destroy();
    end;

    p32.Destroy = {};
    p32:Disconnect();
end;

return u1;