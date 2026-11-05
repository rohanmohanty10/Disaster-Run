  

 

return function(p1) -- Line: 1
    local _ = game:GetService("Players").LocalPlayer;
    p1.Knit.OnStart():await();
    require(script.RewardsUI).new(script.Parent, p1):Load();
    local Buttons = script.Parent:FindFirstChild("Buttons");
    local Tabs = script.Parent:FindFirstChild("Tabs");
    local u2 = "Playtime";

    local function ToggleTab(p3, p4) -- Line: 17
        -- upvalues: Tabs (copy)
        local v5 = Tabs:FindFirstChild(p3);

        if not v5 then
            return;
        end;

        v5.Visible = p4;
    end;

    local function SetTab(p6) -- Line: 24
        -- upvalues: u2 (ref), Tabs (copy), Buttons (copy)
        if p6 == u2 then
            return;
        end;

        if not Tabs:FindFirstChild(p6) then
            return;
        end;

        local v7 = Tabs:FindFirstChild(u2);

        if v7 then
            v7.Visible = false;
        end;

        local v8 = Tabs:FindFirstChild(p6);

        if v8 then
            v8.Visible = true;
        end;

        local v9 = Buttons:FindFirstChild(p6);
        local v10 = Buttons:FindFirstChild(u2);

        if v9 then
            v9.BackgroundTransparency = 0.1;
            v9.TextColor3 = Color3.fromRGB(55, 255, 0);
            v10.BackgroundTransparency = 0.5;
            v10.TextColor3 = Color3.fromRGB(255, 255, 255);
        end;

        u2 = p6;
    end;

    for _, child in Buttons:GetChildren() do
        if child:IsA("TextButton") then
            child.MouseButton1Click:Connect(function() -- Line: 45
                -- upvalues: SetTab (copy), child (copy)
                SetTab(child.Name);
            end);
        end;
    end;
end;