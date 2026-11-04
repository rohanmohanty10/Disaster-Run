 

 

local v1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});

function v1.bind(u3, u4) -- Line: 5
    -- upvalues: u2 (copy)
    if not u2[u4] then
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = u3.Name .. "_" .. u4.Name .. "_Edges";
        ScreenGui.ResetOnSpawn = false;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.ScreenInsets = Enum.ScreenInsets.None;
        ScreenGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None;
        ScreenGui.ClipToDeviceSafeArea = false;
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ScreenGui.Enabled = false;
        local u5 = {};

        for _, v in { "Top", "Bottom", "Left", "Right" } do
            local Frame = Instance.new("Frame");
            Frame.Name = v;
            Frame.BorderSizePixel = 0;
            Frame.Active = false;
            Frame.Parent = ScreenGui;
            u5[v] = Frame;
        end;

        local u6 = {};
        local u7 = true;
        u2[u4] = ScreenGui;
        u3.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None;

        local function sync() -- Line: 24
            -- upvalues: u7 (ref), ScreenGui (copy), u3 (copy), u4 (copy), u5 (copy)
            if not u7 then
                return;
            end;

            if ScreenGui.Parent ~= u3.Parent then
                ScreenGui.Parent = u3.Parent;
            end;

            ScreenGui.DisplayOrder = u3.DisplayOrder - 1;
            local v8 = u3.Enabled and u4.Visible;
            local Parent = u4.Parent;

            while Parent and Parent ~= u3 do
                if Parent:IsA("GuiObject") and not Parent.Visible then
                    v8 = false;
                end;

                Parent = Parent.Parent;
            end;

            if v8 then
                v8 = Parent == u3;
            end;

            ScreenGui.Enabled = v8;
            local AbsoluteSize = ScreenGui.AbsoluteSize;
            local v9 = u4.AbsolutePosition - ScreenGui.AbsolutePosition;
            local math_clamp_ret = math.clamp(v9.X, 0, AbsoluteSize.X);
            local math_clamp_ret2 = math.clamp(v9.Y, 0, AbsoluteSize.Y);
            local math_clamp_ret3 = math.clamp(v9.X + u4.AbsoluteSize.X, math_clamp_ret, AbsoluteSize.X);
            local math_clamp_ret4 = math.clamp(v9.Y + u4.AbsoluteSize.Y, math_clamp_ret2, AbsoluteSize.Y);

            local function rect(p10, p11, p12, p13, p14) -- Line: 40
                -- upvalues: u4 (ref)
                p10.Position = UDim2.fromOffset(p11, p12);
                p10.Size = UDim2.fromOffset(p13, p14);
                p10.BackgroundColor3 = u4.BackgroundColor3;
                p10.BackgroundTransparency = u4.BackgroundTransparency;
            end;

            local Top = u5.Top;
            local X = AbsoluteSize.X;
            Top.Position = UDim2.fromOffset(0, 0);
            Top.Size = UDim2.fromOffset(X, math_clamp_ret2);
            Top.BackgroundColor3 = u4.BackgroundColor3;
            Top.BackgroundTransparency = u4.BackgroundTransparency;
            local Bottom = u5.Bottom;
            local X2 = AbsoluteSize.X;
            local v15 = AbsoluteSize.Y - math_clamp_ret4;
            Bottom.Position = UDim2.fromOffset(0, math_clamp_ret4);
            Bottom.Size = UDim2.fromOffset(X2, v15);
            Bottom.BackgroundColor3 = u4.BackgroundColor3;
            Bottom.BackgroundTransparency = u4.BackgroundTransparency;
            local Left = u5.Left;
            Left.Position = UDim2.fromOffset(0, math_clamp_ret2);
            Left.Size = UDim2.fromOffset(math_clamp_ret, math_clamp_ret4 - math_clamp_ret2);
            Left.BackgroundColor3 = u4.BackgroundColor3;
            Left.BackgroundTransparency = u4.BackgroundTransparency;
            local Right = u5.Right;
            local v16 = AbsoluteSize.X - math_clamp_ret3;
            Right.Position = UDim2.fromOffset(math_clamp_ret3, math_clamp_ret2);
            Right.Size = UDim2.fromOffset(v16, math_clamp_ret4 - math_clamp_ret2);
            Right.BackgroundColor3 = u4.BackgroundColor3;
            Right.BackgroundTransparency = u4.BackgroundTransparency;
        end;

        local function watch(p17, p18) -- Line: 49
            -- upvalues: u6 (copy), sync (copy)
            local PropertyChangedSignal = p17:GetPropertyChangedSignal(p18);
            table.insert(u6, PropertyChangedSignal:Connect(sync));
        end;

        for _, v in { "Visible", "AbsolutePosition", "AbsoluteSize", "BackgroundColor3", "BackgroundTransparency" } do
            local PropertyChangedSignal = u4:GetPropertyChangedSignal(v);
            table.insert(u6, PropertyChangedSignal:Connect(sync));
        end;

        for _, v in { "Enabled", "DisplayOrder", "AbsolutePosition", "AbsoluteSize" } do
            local PropertyChangedSignal = u3:GetPropertyChangedSignal(v);
            table.insert(u6, PropertyChangedSignal:Connect(sync));
        end;

        local PropertyChangedSignal = ScreenGui:GetPropertyChangedSignal("AbsoluteSize");
        table.insert(u6, PropertyChangedSignal:Connect(sync));
        local PropertyChangedSignal2 = ScreenGui:GetPropertyChangedSignal("AbsolutePosition");
        table.insert(u6, PropertyChangedSignal2:Connect(sync));
        table.insert(u6, u3.AncestryChanged:Connect(sync));
        local Parent = u4.Parent;

        while Parent and Parent ~= u3 do
            if Parent:IsA("GuiObject") then
                local PropertyChangedSignal3 = Parent:GetPropertyChangedSignal("Visible");
                table.insert(u6, PropertyChangedSignal3:Connect(sync));
            end;

            Parent = Parent.Parent;
        end;

        local function destroy() -- Line: 56
            -- upvalues: u7 (ref), u2 (ref), u4 (copy), u6 (copy), ScreenGui (copy)
            if not u7 then
                return;
            end;

            u7 = false;
            u2[u4] = nil;

            for _, v in u6 do
                v:Disconnect();
            end;

            ScreenGui:Destroy();
        end;

        table.insert(u6, u4.Destroying:Connect(destroy));
        table.insert(u6, u3.Destroying:Connect(destroy));
        sync();

        return ScreenGui;
    end;
end;

return v1;