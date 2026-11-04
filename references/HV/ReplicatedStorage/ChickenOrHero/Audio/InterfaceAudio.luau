 

 

local u1 = {};
u1.__index = u1;

function u1.new(u2, p3) -- Line: 3
    -- upvalues: u1 (copy)
    local u4 = setmetatable({
        buttons = {},
        panels = {},
        connections = {}
    }, u1);

    local function belongs(p5) -- Line: 5
        local v6 = p5:FindFirstAncestorWhichIsA("LayerCollector");

        if v6 then
            v6 = (v6.Name == "Notifications" or v6.Name == "HUD") and true or v6:GetAttribute("UseGameAudio") == true;
        end;

        return v6;
    end;

    local function add(u7) -- Line: 9
        -- upvalues: u4 (copy), u2 (copy)
        if u7:IsA("GuiButton") then
            local v8 = u7:FindFirstAncestorWhichIsA("LayerCollector");
            local v9 = v8 and ((v8.Name == "Notifications" or v8.Name == "HUD") and true or v8:GetAttribute("UseGameAudio") == true);

            if v9 and not u4.buttons[u7] then
                u4.buttons[u7] = { u7.MouseEnter:Connect(function() -- Line: 12
                        -- upvalues: u7 (copy), u2 (ref)
                        if u7.Visible then
                            u2:one("Hover");
                        end;
                    end), u7.SelectionGained:Connect(function() -- Line: 13
                        -- upvalues: u7 (copy), u2 (ref)
                        if u7.Visible then
                            u2:one("Hover");
                        end;
                    end), u7.Activated:Connect(function() -- Line: 14
                        -- upvalues: u2 (ref), u7 (copy)
                        u2:one("Click");

                        if u7.Parent and u7.Parent.Name == "Options" then
                            u2:one("ChoiceSubmitted");
                        end;
                    end) };

                return;
            end;
        end;

        if u7:IsA("Frame") and u7.Name == "Choices" then
            local v10 = u7:FindFirstAncestorWhichIsA("LayerCollector");
            local v11 = v10 and ((v10.Name == "Notifications" or v10.Name == "HUD") and true or v10:GetAttribute("UseGameAudio") == true);

            if v11 and not u4.panels[u7] then
                local Visible = u7.Visible;
                u4.panels[u7] = u7:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 21
                    -- upvalues: u7 (copy), Visible (ref), u2 (ref)
                    if u7.Visible ~= Visible then
                        Visible = u7.Visible;
                        u2:one(Visible and "PanelOpen" or "PanelClose");
                    end;
                end);
            end;
        end;
    end;

    local function remove(p12) -- Line: 26
        -- upvalues: u4 (copy)
        if u4.buttons[p12] then
            for _, v in u4.buttons[p12] do
                v:Disconnect();
            end;

            u4.buttons[p12] = nil;
        end;

        if u4.panels[p12] then
            u4.panels[p12]:Disconnect();
            u4.panels[p12] = nil;
        end;
    end;

    u4.remove = remove;
    table.insert(u4.connections, p3.DescendantAdded:Connect(add));
    table.insert(u4.connections, p3.DescendantRemoving:Connect(remove));

    for _, descendant in p3:GetDescendants() do
        add(descendant);
    end;

    return u4;
end;

function u1.destroy(p13) -- Line: 36
    for _, v in p13.connections do
        v:Disconnect();
    end;

    for i in p13.buttons do
        p13.remove(i);
    end;

    for i in p13.panels do
        p13.remove(i);
    end;
end;

return u1;