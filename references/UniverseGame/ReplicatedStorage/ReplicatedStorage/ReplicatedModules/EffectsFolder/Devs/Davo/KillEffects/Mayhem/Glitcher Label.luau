  

 

local Petal = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
local u1 = Petal("New");
Petal("Util");

return function(p2) -- Line: 6
    -- upvalues: u1 (copy)
    local u3 = u1("BillboardGui")({
        Adornee = nil,
        Name = "ModeName",
        StudsOffset = Vector3.new(-8, 5.3333335, 0),
        Size = UDim2.new(4, 0, 1.2, 0),
        Parent = p2.Parent,
        Children = { u1("TextLabel")({
                Name = "CustomText",
                TextScaled = true,
                BackgroundTransparency = 1,
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                Size = UDim2.new(5, 0, 3.5, 0),
                FontSize = Enum.FontSize.Size8,
                Font = p2.Font,
                TextStrokeColor3 = p2.TextColor,
                TextColor3 = p2.StrokeColor,
                Text = p2.Text
            }) }
    });
    local u4 = u3:FindFirstChildOfClass("TextLabel");
    local u5 = nil;
    local u6 = false;
    u5 = u3.Destroying:Connect(function() -- Line: 32
        -- upvalues: u6 (ref), u5 (ref)
        u6 = true;

        if u5 then
            u5:Disconnect();
        end;
    end);
    local u7 = 0;
    task.spawn(function() -- Line: 40
        -- upvalues: u3 (copy), u7 (ref), u4 (copy), u6 (ref)
        repeat
            wait();
            local v8 = math.cos(u7 / 25) / 4.5 + -8;
            local v9 = math.cos(u7 / 75) / 5 + 5.333333333333333;
            u3.StudsOffset = Vector3.new(v8, v9, 0);
            u4.Rotation = math.cos(u7 / 32) * -5;
            u7 = u7 + 2;
        until u6;
    end);
end;