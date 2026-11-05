 
local v0 = {
    active = false
};
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_PlayerGui_0 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local v4 = script.BuildBoxSelection:Clone();
local l_Area_0 = v4.Area;
local v6 = nil;
v4.Parent = l_PlayerGui_0;
local function _(v7, v8, v9) --[[ Line: 18 ]] --[[ Name: coordIsInBox ]]
    local v10 = false;
    if v7.X > v8.X then
        v10 = false;
        if v7.X < v9.X then
            v10 = false;
            if v7.Y > v8.Y then
                v10 = v7.Y < v9.Y;
            end;
        end;
    end;
    return v10;
end;
local function v16() --[[ Line: 22 ]] --[[ Name: dragAreaUpdate ]]
    while true do
        task.wait();
        if l_Area_0.Visible then
            if not v0.active then
                v6 = nil;
                l_Area_0.Size = UDim2.new();
                l_Area_0.Visible = false;
                return;
            else
                local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
                local v13 = l_l_UserInputService_0_MouseLocation_0.X - v6.X;
                local v14 = l_l_UserInputService_0_MouseLocation_0.Y - v6.Y;
                local v15 = Vector2.new(v13 < 0 and v13 or 0, v14 < 0 and v14 or 0) + v6;
                l_Area_0.Size = UDim2.fromOffset(math.abs(v13), (math.abs(v14)));
                l_Area_0.Position = UDim2.fromOffset(v15.X, v15.Y);
            end;
        else
            return;
        end;
    end;
end;
local function v26() --[[ Line: 44 ]] --[[ Name: captureDragSelection ]]
    local v17 = require(script.Parent);
    local v18 = l_Area_0.AbsolutePosition + l_GuiService_0:GetGuiInset();
    local v19 = v18 + l_Area_0.AbsoluteSize;
    local l_Magnitude_0 = (v18 - v19).Magnitude;
    l_Area_0.Size = UDim2.new();
    l_Area_0.Visible = false;
    v6 = nil;
    if l_Magnitude_0 < 6 then
        return;
    else
        for _, v22 in v17.GetSelectable() do
            if v22.Parent and v22 ~= v17.base then
                local v23, v24 = workspace.CurrentCamera:WorldToViewportPoint(v22.Position);
                if v24 then
                    local v25 = false;
                    if v23.X > v18.X then
                        v25 = false;
                        if v23.X < v19.X then
                            v25 = false;
                            if v23.Y > v18.Y then
                                v25 = v23.Y < v19.Y;
                            end;
                        end;
                    end;
                    if v25 then
                        v17.AddSelection(v22);
                    end;
                end;
            end;
        end;
        return;
    end;
end;
v0.SetColor = function(v27) --[[ Line: 67 ]]
    l_Area_0.BackgroundColor3 = v27;
end;
l_UserInputService_0.InputBegan:Connect(function(v28, v29) --[[ Line: 71 ]]
    if v29 or not v0.active then
        return;
    else
        local _ = l_UserInputService_0:IsKeyDown(Enum.KeyCode.LeftShift);
        if v28.UserInputType == Enum.UserInputType.Touch or v28.UserInputType == Enum.UserInputType.MouseButton1 then
            v6 = l_UserInputService_0:GetMouseLocation();
            l_Area_0.Size = UDim2.new();
            l_Area_0.Position = UDim2.fromOffset(v6.X, v6.Y);
            l_Area_0.Visible = true;
            task.spawn(v16);
        end;
        return;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v31, _) --[[ Line: 83 ]]
    if (v31.UserInputType == Enum.UserInputType.MouseButton1 or v31.UserInputType == Enum.UserInputType.Touch) and l_Area_0.Visible then
        v26();
    end;
end);
l_UserInputService_0.WindowFocusReleased:Connect(function() --[[ Line: 90 ]]
    if l_Area_0.Visible then
        v26();
    end;
end);
return v0;