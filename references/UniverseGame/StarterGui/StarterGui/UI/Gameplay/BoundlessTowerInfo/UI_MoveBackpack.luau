  

 

local u1 = {
    BUTTONA = "A",
    BUTTONB = "B",
    BUTTONX = "X",
    BUTTONY = "Y",
    BUTTONL1 = "LB",
    BUTTONR1 = "RB",
    BUTTONL2 = "LT",
    BUTTONR2 = "RT"
};

return function(u2) -- Line: 12
    -- upvalues: u1 (copy)
    local PathShortcuts = u2.PathShortcuts;
    local Knit = u2.Knit;
    local Order = u2.Util.Order;
    local Core = require(game:GetService("ReplicatedStorage").ReplicatedRoot:WaitForChild("Core"));
    Core.OnStart():await();
    local u3 = Core.GetClientService("ConfigurationService"):GetFFlags():expect();
    local v4 = Knit.GetService("MoveService");
    local u5 = Knit.GetController("MoveInputController");
    local u6 = Knit.GetController("MoveIndicatorController").GetSingleton();
    local StateHandler = require(PathShortcuts.ReplicatedModules:WaitForChild("StateHandler"));
    local u7 = v4:GetKeybindsMap():expect();
    local Parent = script.Parent;
    local MoveButton = Parent.Assets.MoveButton;
    local MoveList = Parent.MoveList;
    MoveList.Visible = true;
    local u8 = {};
    local u9 = {};

    function u2.SetMoveBackpackVisible(p10) -- Line: 47
        -- upvalues: Parent (copy)
        Parent.Visible = p10;
    end;

    local function UpdateVisibility() -- Line: 51
        -- upvalues: StateHandler (copy), u2 (copy), u8 (copy), u5 (copy)
        local v11 = StateHandler.GetStates(u2.Character);

        for _, v in u8 do
            local Visible = v.Group.Visible;

            if v11[v.GroupName] then
                Visible = v11[v.GroupName].Active;
            end;

            v.Button.Visible = Visible;

            if Visible == true then
                local v12 = u5:GetDPadDirectionByte();
                v.Button.BackgroundTransparency = v.EquipMoveInfo.DPadDirection == v12 and 0.25 or 0.6;
                v.Button.UIStroke.Transparency = v.EquipMoveInfo.DPadDirection == v12 and 0.125 or 0.35;
            end;
        end;
    end;

    local function LoadMoves() -- Line: 69
        -- upvalues: u9 (copy), u8 (copy), u5 (copy), u6 (copy), MoveButton (copy), u1 (ref), Order (copy), u7 (copy), MoveList (copy), u2 (copy), UpdateVisibility (copy)
        for _, v in u9 do
            v:Destroy();
        end;

        table.clear(u8);
        local v13 = u5:GetEquippedMoves();

        for i, v in pairs(u6:GetGroups()) do
            local v14 = v.Priority or 0;

            for i2, v2 in pairs(v.Moves) do
                local v15 = v2.Name or i2;
                local v16 = v13[v15];

                if v16 then
                    local u17;

                    if v16 then
                        u17 = v16.Keybind;
                    else
                        u17 = v16;
                    end;

                    local v18 = MoveButton:Clone();
                    v18.Name = v15;
                    v18.MoveName.Text = v2.DisplayName or v15;
                    v18.Input.Text = (u1[string.upper(v16.Keybind)] or string.upper(v16.Keybind)) .. (v16.Held and "+" or "");

                    if v16.DPadDirection ~= nil then
                        local v19 = { 2, 3, 0, 1 };
                        local v20 = "";
                        local v21 = { "U", "D", "L", "R" };

                        for i3 = 1, 4 do
                            if bit32.extract(v16.DPadDirection, v19[i3]) ~= 0 then
                                v20 = v20 .. v21[i3];
                            end;
                        end;

                        v18.DPadInput.Text = v20;
                    end;

                    v18.LayoutOrder = (v2.LayoutOrder or table.find(Order, u17:upper()) or (u7[u17:upper()] or 0)) * 100 - v14;
                    u8[i2] = {
                        Button = v18,
                        GroupName = i,
                        Group = v,
                        MoveName = i2,
                        Move = v2,
                        Priority = v14,
                        EquipMoveInfo = v16
                    };
                    table.insert(u9, v18);
                    v18.Visible = true;
                    v18.MouseButton1Down:Connect(function() -- Line: 125
                        -- upvalues: u17 (copy), u5 (ref)
                        warn(u17);
                        u5:Input(u17, "Began");
                    end);
                    v18.MouseButton1Up:Connect(function() -- Line: 131
                        -- upvalues: u5 (ref), u17 (copy)
                        u5:Input(u17, "Ended");
                    end);
                    v18.Parent = MoveList;
                end;
            end;
        end;

        if not next(u8) then
            local v22 = MoveButton:Clone();
            v22.Name = "BindSomeMoves";
            v22.MoveName.Text = "Bind some moves!";
            v22.Input.Text = "X";
            v22.Visible = true;
            v22.Parent = MoveList;
            v22.MouseButton1Click:Connect(function() -- Line: 150
                -- upvalues: u2 (ref)
                u2:SetMenu("Ability");
                u2.AbilityMenuSetTab("Moves");
            end);
            table.insert(u9, v22);
        end;

        UpdateVisibility();
    end;

    local function CooldownAdded(u23) -- Line: 161
        -- upvalues: u8 (copy)
        local v24 = u8[u23.Name];

        if not v24 then
            return;
        end;

        local Cooldown = v24.Button.Cooldown;
        Cooldown.Visible = true;
        Cooldown.Size = UDim2.fromScale(1, 1);
        Cooldown.Position = UDim2.fromScale(0, 0);
        local u25 = 0;
        local u26 = 0;
        local success, result = pcall(function() -- Line: 175
            -- upvalues: u26 (ref), u23 (copy), u25 (ref), Cooldown (copy)
            while u26 < 1 and u23:GetAttribute("Duration") do
                u25 = u25 + task.wait();
                u26 = u25 / u23:GetAttribute("Duration");

                if u26 > 1 then
                    u26 = 1;
                end;

                Cooldown.Size = UDim2.fromScale(1, 1 - u26);
                Cooldown.Position = UDim2.fromScale(0, u26);
            end;
        end);

        if not success then
            warn(result);
        end;
    end;

    local function CooldownRemoved(p27) -- Line: 192
        -- upvalues: u8 (copy)
        local v28 = u8[p27.Name];

        if not v28 then
            return;
        end;

        v28.Button.Cooldown.Visible = false;
    end;

    pcall(LoadMoves);
    v4.EquippedMove:Connect(LoadMoves);
    v4.UnequippedMove:Connect(LoadMoves);
    v4.ReloadMoveUI:Connect(LoadMoves);
    u2.Player.Data.Ability.Changed:Connect(function() -- Line: 205
        -- upvalues: LoadMoves (copy)
        task.delay(0.5, LoadMoves);
    end);
    u2.InputTypeChanged:Connect(function(p29) -- Line: 209
        -- upvalues: u2 (copy), LoadMoves (copy)
        u2.SetMoveBackpackVisible(p29 == "Controller");

        if p29 == "Controller" then
            LoadMoves();
        end;
    end);
    u2.SetMoveBackpackVisible(u2.GetInputType() == "Controller");
    u6.VisibilityUpdated:Connect(UpdateVisibility);
    u5.DPadDirectionChanged:Connect(UpdateVisibility);
    local StarterGui = game:GetService("StarterGui");
    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 221
        -- upvalues: u3 (copy), u2 (copy), Parent (copy), StarterGui (copy)
        if u3.new_backpack_enabled then
            u2:SetBackpackEnabled(not Parent.Visible);

            return;
        end;

        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not Parent.Visible);
    end);
    task.spawn(function() -- Line: 229
        -- upvalues: u2 (copy), CooldownAdded (copy), CooldownRemoved (copy)
        local Cooldowns = u2.Player:WaitForChild("Cooldowns");
        Cooldowns.ChildAdded:Connect(CooldownAdded);
        Cooldowns.ChildRemoved:Connect(CooldownRemoved);
    end);
end;