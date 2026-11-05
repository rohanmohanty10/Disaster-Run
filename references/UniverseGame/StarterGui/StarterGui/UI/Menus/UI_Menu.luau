  

 

return function(u1) -- Line: 1
    local _ = u1.Xtal;
    u1.Locked = false;
    local MenuBlur = game.Lighting:FindFirstChild("MenuBlur");

    if not MenuBlur then
        MenuBlur = Instance.new("BlurEffect");
        MenuBlur.Name = "MenuBlur";
        MenuBlur.Size = 24;
        MenuBlur.Enabled = false;
        MenuBlur.Parent = game.Lighting;
    end;

    u1.MenuBlur = MenuBlur;

    function u1.ToggleMenu(p2, p3, p4) -- Line: 15
        local v5 = p4 or {};

        if p3 then
            p2:SetMenuOptionVisibility();
            p2.UI.Buttons.Gameplay.Visible = false;
            p2.UI.Gameplay.Visible = false;
        else
            p2.__MockInventory = nil;
            p2.UI.Buttons.Gameplay.Visible = true;
            p2.UI.Gameplay.Visible = true;
        end;

        p2.UI.Menus.Visible = p3;

        if not v5.DisableBlur then
            p2.MenuBlur.Enabled = p3;
        end;

        if not v5.EnableChat then
            game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not p3);
        end;

        if not v5.EnablePlayerList then
            game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, not p3);
        end;
    end;

    function u1.Lock(p6, p7) -- Line: 43
        p6.Locked = p7;
        p6.UI:SetAttribute("Locked", p7);

        if p6.Locked then
            p6.UI.Buttons.Visible = false;

            return;
        end;

        p6.UI.Buttons.Visible = true;
    end;

    function u1.ResolveLock(p8) -- Line: 54
        local v9 = false;
        local v10 = false;

        for _, child in script.Locks:GetChildren() do
            v9 = child:GetAttribute("Absolute") and true or v9;

            if child.Value then
                v10 = true;
                break;
            end;
        end;

        p8.ResolveLocked = v10;
        p8.AbsoluteResolveLocked = v9;
    end;

    function u1.MakeLockInstance(p11, p12) -- Line: 72
        local BoolValue = Instance.new("BoolValue");
        BoolValue.Value = true;
        BoolValue.Parent = script.Locks;

        for i, v in p12 or {} do
            pcall(function() -- Line: 80
                -- upvalues: BoolValue (copy), i (copy), v (copy)
                BoolValue:SetAttribute(i, v);
            end);
        end;

        p11:ResolveLock();

        return BoolValue;
    end;

    local u13 = { "CodeRedemption" };

    function u1.SetMenu(p14, p15, p16) -- Line: 94
        -- upvalues: u13 (copy)
        if p15 == false then
            p15 = nil;
        end;

        p14.Knit.GetController("MoveInputController").Active = p15 == nil;
        local v17 = p16 or {};

        if p14.ResolveLocked then
            p15 = nil;
        end;

        if p14.IsAbsoluteLocked then
            return;
        end;

        if p15 ~= "Draft" and (p15 ~= "Gamemode" and v17.Manual) then
            if p14.UI:GetAttribute("AfkWorldEnabled") then
                return;
            end;

            if p14.UI:GetAttribute("DraftEnabled") then
                return;
            end;

            if p14.UI:GetAttribute("MapPickEnabled") then
                return;
            end;
        end;

        for _, child in pairs(p14.UI.Menus:GetChildren()) do
            if child:IsA("Frame") and (not v17.Overlap or child.Name == p15) then
                local v18;

                if child.Name == p15 then
                    v18 = true;
                elseif p15 == "Menu" then
                    v18 = table.find(u13, child.Name);
                else
                    v18 = false;
                end;

                child.Visible = v18;
            end;
        end;

        if p15 and not p14.UI.Menus.Visible then
            p14:ToggleMenu(true, v17);
        elseif not p15 and p14.UI.Menus.Visible then
            p14:ToggleMenu(false, v17);
        end;

        if p15 == "PartyManagement" then
            pcall(function() -- Line: 134
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
            end);
        end;

        p14.MenuSignal:Fire("MenuUpdated", p15);
    end;

    local u19 = {
        Default = {
            T_Offers = false,
            T_Trade = false
        },
        Competitive = {
            Bank = false,
            Customization = false,
            Products = false,
            Quest = false,
            Trade = false,
            Reroll = false
        },
        Trading = {
            Quest = false,
            T_Offers = true,
            T_Trade = true
        }
    };

    function u1.SetMenuOptionVisibility(p20) -- Line: 163
        -- upvalues: u19 (copy)
        local v21 = p20:GetGamemode();
        local v22 = {};

        for i, v in pairs(u19.Default) do
            v22[i] = v;
        end;

        if u19[v21] then
            for i, v in pairs(u19[v21]) do
                v22[i] = v;
            end;
        end;

        for i, v in pairs(v22) do
            local v23 = p20.UI.Menus.Menu:FindFirstChild(i);

            if v23 then
                v23.Visible = v;
            end;
        end;
    end;

    local u24 = u1.Util.Tooltip.GetFromParent(u1.UI:FindFirstChild("Screen"));
    game:GetService("UserInputService").InputBegan:Connect(function(p25, p26) -- Line: 184
        -- upvalues: u1 (copy), u24 (copy)
        if u1.Locked then
            return;
        end;

        if u1.ResolveLocked then
            return;
        end;

        if (not p26 or u1.UI.Menus.Visible and not game:GetService("UserInputService"):GetFocusedTextBox()) and p25.KeyCode == Enum.KeyCode.M then
            if u1.UI.Menus.Visible then
                u1:SetMenu(false, {
                    Manual = true
                });
            else
                u1:SetMenu("Menu", {
                    Manual = true
                });
            end;

            u24:Hide();
        end;
    end);
    u1.UI.Buttons.MenuButton.MouseButton1Down:Connect(function() -- Line: 208
        -- upvalues: u1 (copy)
        if u1.Locked then
            return;
        end;

        if u1.ResolveLocked then
            return;
        end;

        u1:PlaySound("Click");

        if u1.UI.Menus.Visible then
            u1:SetMenu(false, {
                Manual = true
            });

            return;
        end;

        u1:SetMenu("Menu", {
            Manual = true
        });
    end);
    u1.UI.Menus:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 227
        -- upvalues: u1 (copy)
        u1.MenuBlur.Enabled = u1.UI.Menus.Visible;
    end);
end;