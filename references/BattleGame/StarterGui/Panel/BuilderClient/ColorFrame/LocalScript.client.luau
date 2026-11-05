 
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Parent_0 = script.Parent;
local l_Wheel_0 = l_Parent_0.Wheel;
local l_Slider_0 = l_Parent_0.Slider;
local l_Cursor_0 = l_Wheel_0.Cursor;
local l_UserInputService_0 = game:GetService("UserInputService");
local v6 = false;
local v7 = false;
local _ = l_Parent_0:GetAttribute("Color");
local v9 = 0;
local v10 = Color3.new(1, 1, 1);
local v11 = 1;
local l_Preview_0 = l_Parent_0.Preview;
local v13 = {};
local function v18(v14) --[[ Line: 16 ]]
    local v15 = Vector2.new(l_Wheel_0.Cursor.AbsolutePosition.X + l_Wheel_0.Cursor.AbsoluteSize.X * 0.5, l_Wheel_0.Cursor.AbsolutePosition.Y + l_Wheel_0.Cursor.AbsoluteSize.Y * 0.5);
    local v16 = (3.141592653589793 - math.atan2(v15.Y - v14.Y, v15.X - v14.X)) / 6.283185307179586;
    local v17 = (v14 - v15).Magnitude / (l_Wheel_0.AbsoluteSize.X / 2);
    return (Color3.fromHSV(math.clamp(v16, 0, 1), math.clamp(v17, 0, 1), 1));
end;
local function _() --[[ Line: 29 ]]
    local l_v10_0 = v10;
    l_v10_0 = Color3.new(l_v10_0.R * v11, l_v10_0.G * v11, l_v10_0.B * v11);
    l_Preview_0.BackgroundColor3 = l_v10_0;
    return l_v10_0;
end;
l_Slider_0.MouseButton1Down:Connect(function() --[[ Line: 36 ]]
    if not v7 then
        v7 = true;
        shared.sfx({
            SoundId = "rbxassetid://6895079853", 
            Volume = 0.5, 
            Parent = l_LocalPlayer_0.PlayerGui
        }):Play();
    end;
end);
l_Wheel_0.MouseButton1Down:Connect(function() --[[ Line: 48 ]]
    if not v6 then
        v6 = true;
        shared.sfx({
            SoundId = "rbxassetid://6895079853", 
            Volume = 0.5, 
            Parent = l_LocalPlayer_0.PlayerGui
        }):Play();
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v21, _) --[[ Line: 60 ]]
    if v21.UserInputType ~= Enum.UserInputType.MouseButton1 and v21.UserInputType ~= Enum.UserInputType.Touch then
        return;
    else
        if v6 or v7 then
            v6 = false;
            v7 = false;
            shared.sfx({
                SoundId = "rbxassetid://6895079853", 
                Volume = 0.5, 
                Parent = l_LocalPlayer_0.PlayerGui
            }):Play();
        end;
        return;
    end;
end);
l_UserInputService_0.InputChanged:Connect(function(v23) --[[ Line: 74 ]]
    if v23.UserInputType ~= Enum.UserInputType.MouseMovement and v23.UserInputType ~= Enum.UserInputType.Touch and v23.UserInputType ~= Enum.UserInputType.MouseButton1 then
        return;
    elseif tick() - v9 < 0.06 then
        return;
    else
        v9 = tick();
        if v7 or v23.UserInputType == Enum.UserInputType.MouseButton1 then
            local v24 = (v23.Position.Y - l_Slider_0.AbsolutePosition.Y) / l_Slider_0.AbsoluteSize.Y;
            local v25 = math.clamp(v24, 0, 1);
            if v25 == v24 then
                shared.sfx({
                    SoundId = "rbxassetid://7198717057", 
                    Volume = 0.5, 
                    Parent = l_LocalPlayer_0.PlayerGui
                }):Play();
            end;
            l_Slider_0.TextButton:TweenPosition(UDim2.new(0, 0, v25, 0), nil, nil, 0.1, true);
            v11 = 1 - v25;
            v13.Slider = v25;
            local l_v10_1 = v10;
            l_Preview_0.BackgroundColor3 = Color3.new(l_v10_1.R * v11, l_v10_1.G * v11, l_v10_1.B * v11);
            return;
        else
            local v27 = l_UserInputService_0:GetMouseLocation() - Vector2.new(0, game:GetService("GuiService"):GetGuiInset().Y);
            local v28 = Vector2.new(l_Wheel_0.AbsolutePosition.X + l_Wheel_0.AbsoluteSize.X / 2, l_Wheel_0.AbsolutePosition.Y + l_Wheel_0.AbsoluteSize.Y / 2);
            local l_Magnitude_0 = (v27 - v28).Magnitude;
            local l_unit_0 = (v27 - v28).unit;
            if v6 or v23.UserInputType == Enum.UserInputType.MouseButton1 then
                local v31 = v27.X - l_Wheel_0.AbsolutePosition.X;
                local v32 = v27.Y - l_Wheel_0.AbsolutePosition.Y;
                local v33 = l_Wheel_0.AbsoluteSize.X / 2;
                shared.sfx({
                    SoundId = "rbxassetid://7198717057", 
                    Volume = 0.5, 
                    Parent = l_LocalPlayer_0.PlayerGui
                }):Play();
                if l_Magnitude_0 <= l_Wheel_0.AbsoluteSize.X * 0.5 then
                    l_Cursor_0:TweenPosition(UDim2.new(0, v31, 0, v32), nil, nil, 0.1, true);
                else
                    l_Cursor_0:TweenPosition(UDim2.new(0, v33 + l_unit_0.X * v33, 0, v33 + l_unit_0.Y * v33), nil, nil, 0.1, true);
                end;
                v13.Cursor = {
                    l_Cursor_0.Position.X.Offset, 
                    l_Cursor_0.Position.Y.Offset
                };
                v10 = v18(v28);
                local l_v10_2 = v10;
                l_Preview_0.BackgroundColor3 = Color3.new(l_v10_2.R * v11, l_v10_2.G * v11, l_v10_2.B * v11);
            end;
            return;
        end;
    end;
end);