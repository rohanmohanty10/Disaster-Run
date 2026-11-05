  

 

return function(u1) -- Line: 1
    local Knit = u1.Knit;
    local Parent = script.Parent;
    local Player = u1.Player;
    local u2 = nil;
    task.spawn(function() -- Line: 7
        -- upvalues: u2 (ref), u1 (copy)
        u2 = u1.Player:WaitForChild("Settings");
    end);
    Knit.OnStart():await();
    local Order = u1.Util.Order;
    local Mapping = u1.Util.Mapping;
    Knit.GetService("MoveIndicatorService");
    local u3 = Knit.GetController("MoveIndicatorController").GetSingleton();
    local u4 = Knit.GetController("CombatController");
    local u5 = Knit.GetController("MoveInputController");
    local u6 = Knit.GetService("MoveService");
    local TweenService = game:GetService("TweenService");
    game:GetService("UserInputService");
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(PathShortcuts.StandsModule);
    require(PathShortcuts.ReplicatedModules.StatsHandler);
    local u7 = u6:GetKeybindsMap():expect();
    require(game.ReplicatedStorage.ReplicatedRoot.Services.Gameplay.AbilityService);
    local u8 = {};

    local function ResolveInput(p9) -- Line: 36
        -- upvalues: Mapping (copy)
        return Mapping[p9] or p9;
    end;

    local function SetVisible(p10, p11) -- Line: 40
        -- upvalues: u2 (ref)
        local v12;

        if p11.Visible == nil then
            v12 = p11.Group.Visible and p11.Move.Visible;
        else
            v12 = p11.Visible;
        end;

        if u2.MovesetIndicators.Value == 3 then
            if not p11.Cooldown then
                v12 = false;
            end;
        elseif u2.MovesetIndicators.Value == 4 and p11.Cooldown then
            v12 = false;
        end;

        p10.Visible = v12;
    end;

    local function CreateMoveset() -- Line: 55
        -- upvalues: u5 (copy), Player (copy), u3 (copy), Mapping (copy), u8 (copy), Order (copy), u7 (copy), u2 (ref), Parent (copy)
        local v13 = u5:GetEquippedMoves();
        local v14 = u5:GetMovesInfo((Player.Data.Ability:GetAttribute("AbilityName"))) and true or nil;

        if not u5:IsMovesetValid() then
            return;
        end;

        for i, v in pairs(u3:GetGroups()) do
            local v15 = v.Priority or 0;

            for i2, v2 in pairs(v.Moves) do
                local v16 = v2.Name or i2;
                local v17 = v13[v16];

                if not v14 or v17 then
                    local u18;

                    if v17 then
                        u18 = v17.Keybind;
                    else
                        u18 = v17;
                    end;

                    local v19, v20;

                    if v17 then
                        local Keybind = v17.Keybind;
                        v19 = Mapping[Keybind] or Keybind;

                        if not v19 then
                            if v2.Input then
                                v20 = v2.Input;
                                v19 = Mapping[v20] or v20 or "?";
                            else
                                v19 = "?";
                            end;
                        end;
                    elseif v2.Input then
                        v20 = v2.Input;
                        v19 = Mapping[v20] or v20 or "?";
                    else
                        v19 = "?";
                    end;

                    if v17.Held then
                        v19 = v19 .. "+";
                    end;

                    if v17.Airborne then
                        v19 = v19 .. "^";
                    end;

                    if u8[i2] then
                        u8[i2].Button.Key.Text = string.format(v2.InputText or "%s", v19 .. (v17.Held and "+" or ""));
                        u8[i2].Input = v19;
                        u8[i2].Button.LayoutOrder = (v2.LayoutOrder or table.find(Order, u18:upper()) or (u7[u18:upper()] or 0)) * 100 - v15;

                        if v2.IsSubPower then
                            u8[i2].Button.BackgroundColor3 = Color3.fromRGB(84, 20, 64);
                            local Button = u8[i2].Button;
                            Button.LayoutOrder = Button.LayoutOrder + 100000;
                        end;
                    else
                        local v21 = u2.MovesetIndicatorType.Value == 2 and Parent.Assets.Compact:Clone() or Parent.Assets.Button:Clone();
                        v21.Name = v16;
                        v21.Key.Text = string.format(v2.InputText or "%s", v19 .. (v17.Held and "+" or ""));
                        v21.Label.Text = v2.DisplayName or v16;
                        v21.LayoutOrder = (v2.LayoutOrder or table.find(Order, u18:upper()) or (u7[u18:upper()] or 0)) * 100 - v15;

                        if v2.IsSubPower then
                            v21.BackgroundColor3 = Color3.fromRGB(84, 20, 64);
                            v21.LayoutOrder = v21.LayoutOrder + 100000;
                        end;

                        local v22 = {
                            SizeTween = nil,
                            TransparencyTween = nil,
                            Button = v21,
                            GroupName = i,
                            Group = v,
                            MoveName = i2,
                            Move = v2,
                            Input = v19,
                            DPadDirection = v17.DPadDirection,
                            Held = v17.Held,
                            Airborne = v17.Airborne,
                            Priority = v15,
                            MovesInfoExist = v14
                        };
                        u8[i2] = v22;
                        local v23;

                        if v22.Visible == nil then
                            v23 = v22.Group.Visible and v22.Move.Visible;
                        else
                            v23 = v22.Visible;
                        end;

                        if u2.MovesetIndicators.Value == 3 then
                            if not v22.Cooldown then
                                v23 = false;
                            end;
                        elseif u2.MovesetIndicators.Value == 4 and v22.Cooldown then
                            v23 = false;
                        end;

                        v21.Visible = v23;
                        v21.MouseButton1Down:Connect(function() -- Line: 143
                            -- upvalues: u18 (copy), u5 (ref)
                            warn(u18);
                            u5:Input(u18, "Began");
                        end);
                        v21.MouseButton1Up:Connect(function() -- Line: 148
                            -- upvalues: u5 (ref), u18 (copy)
                            u5:Input(u18, "Ended");
                        end);
                        v21.Parent = Parent;
                    end;
                end;
            end;
        end;
    end;

    local function Update() -- Line: 157
        -- upvalues: u8 (copy), Parent (copy), CreateMoveset (copy)
        for i, v in u8 do
            v.Button:Destroy();
            u8[i] = nil;
        end;

        Parent.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
        CreateMoveset();
    end;

    local function UpdateVisibility() -- Line: 168
        -- upvalues: u8 (copy), u2 (ref)
        local u24 = {};
        task.defer(function() -- Line: 171
            -- upvalues: u8 (ref), u24 (copy), u2 (ref)
            for _, v in u8 do
                local Visible = v.Group.Visible;
                local Priority = v.Priority;
                local v25 = tostring(v.DPadDirection or 0) .. "-" .. (v.Input or "");
                local _ = v.MovesInfoExist;
                local v26 = u24[v25];

                if v26 then
                    if v26.Move.MoveVisible == nil then
                        if v26.Group.Visible == v.Group.Visible then
                            if v26.Group.Visible == v.Group.Visible then
                                v.Move.Visible = v26.Priority < Priority;
                                v26.Move.Visible = Priority < v26.Priority;
                                u24[v25] = v;
                            end;
                        else
                            v.Move.Visible = Visible;
                            v26.Move.Visible = v26.Group.Visible;
                            u24[v25] = v;
                        end;
                    else
                        v.Move.Visible = v26.Priority < Priority;
                    end;

                    local v27;

                    if v26.Visible == nil then
                        v27 = v26.Group.Visible and v26.Move.Visible;
                    else
                        v27 = v26.Visible;
                    end;

                    if u2.MovesetIndicators.Value == 3 then
                        if not v26.Cooldown then
                            v27 = false;
                        end;
                    elseif u2.MovesetIndicators.Value == 4 and v26.Cooldown then
                        v27 = false;
                    end;

                    v26.Button.Visible = v27;
                else
                    if v.MovesInfoExist then
                        v.Move.Visible = Visible;
                    end;

                    u24[v25] = v;
                end;

                if v.Move.MoveVisible ~= nil then
                    v.Move.Visible = v.Move.MoveVisible;
                    v.Visible = v.Move.MoveVisible;
                    u24[v25] = v;

                    if v26 then
                        v26.Move.Visible = Priority < v26.Priority;
                        local v28;

                        if v26.Visible == nil then
                            v28 = v26.Group.Visible and v26.Move.Visible;
                        else
                            v28 = v26.Visible;
                        end;

                        if u2.MovesetIndicators.Value == 3 then
                            if not v26.Cooldown then
                                v28 = false;
                            end;
                        elseif u2.MovesetIndicators.Value == 4 and v26.Cooldown then
                            v28 = false;
                        end;

                        v26.Button.Visible = v28;
                    end;
                end;

                local v29;

                if v.Visible == nil then
                    v29 = v.Group.Visible and v.Move.Visible;
                else
                    v29 = v.Visible;
                end;

                if u2.MovesetIndicators.Value == 3 then
                    if not v.Cooldown then
                        v29 = false;
                    end;
                elseif u2.MovesetIndicators.Value == 4 and v.Cooldown then
                    v29 = false;
                end;

                v.Button.Visible = v29;
            end;
        end);
    end;

    local function CooldownAdded(p30) -- Line: 222
        -- upvalues: u8 (copy), TweenService (copy), u2 (ref)
        for _, v in u8 do
            local Button = v.Button;

            if (v.Move.CooldownName or v.MoveName) == p30.Name then
                local v31 = p30:GetAttribute("Duration");

                if v31 then
                    v.Cooldown = true;

                    if v.SizeTween then
                        v.SizeTween:Cancel();
                    end;

                    if v.TransparencyTween then
                        v.TransparencyTween:Cancel();
                    end;

                    Button.Cooldown.Meter.Size = UDim2.new(1, 0, 1, 0);
                    v.SizeTween = TweenService:Create(Button.Cooldown.Meter, TweenInfo.new(v31, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, 0, 1, 0)
                    });
                    v.SizeTween:Play();
                    v.TransparencyTween = TweenService:Create(Button.Cooldown.Meter, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0.6
                    });
                    v.TransparencyTween:Play();
                end;
            end;
        end;

        local u32 = {};
        task.defer(function() -- Line: 171
            -- upvalues: u8 (ref), u32 (copy), u2 (ref)
            for _, v in u8 do
                local Visible = v.Group.Visible;
                local Priority = v.Priority;
                local v33 = tostring(v.DPadDirection or 0) .. "-" .. (v.Input or "");
                local _ = v.MovesInfoExist;
                local v34 = u32[v33];

                if v34 then
                    if v34.Move.MoveVisible == nil then
                        if v34.Group.Visible == v.Group.Visible then
                            if v34.Group.Visible == v.Group.Visible then
                                v.Move.Visible = v34.Priority < Priority;
                                v34.Move.Visible = Priority < v34.Priority;
                                u32[v33] = v;
                            end;
                        else
                            v.Move.Visible = Visible;
                            v34.Move.Visible = v34.Group.Visible;
                            u32[v33] = v;
                        end;
                    else
                        v.Move.Visible = v34.Priority < Priority;
                    end;

                    local v35;

                    if v34.Visible == nil then
                        v35 = v34.Group.Visible and v34.Move.Visible;
                    else
                        v35 = v34.Visible;
                    end;

                    if u2.MovesetIndicators.Value == 3 then
                        if not v34.Cooldown then
                            v35 = false;
                        end;
                    elseif u2.MovesetIndicators.Value == 4 and v34.Cooldown then
                        v35 = false;
                    end;

                    v34.Button.Visible = v35;
                else
                    if v.MovesInfoExist then
                        v.Move.Visible = Visible;
                    end;

                    u32[v33] = v;
                end;

                if v.Move.MoveVisible ~= nil then
                    v.Move.Visible = v.Move.MoveVisible;
                    v.Visible = v.Move.MoveVisible;
                    u32[v33] = v;

                    if v34 then
                        v34.Move.Visible = Priority < v34.Priority;
                        local v36;

                        if v34.Visible == nil then
                            v36 = v34.Group.Visible and v34.Move.Visible;
                        else
                            v36 = v34.Visible;
                        end;

                        if u2.MovesetIndicators.Value == 3 then
                            if not v34.Cooldown then
                                v36 = false;
                            end;
                        elseif u2.MovesetIndicators.Value == 4 and v34.Cooldown then
                            v36 = false;
                        end;

                        v34.Button.Visible = v36;
                    end;
                end;

                local v37;

                if v.Visible == nil then
                    v37 = v.Group.Visible and v.Move.Visible;
                else
                    v37 = v.Visible;
                end;

                if u2.MovesetIndicators.Value == 3 then
                    if not v.Cooldown then
                        v37 = false;
                    end;
                elseif u2.MovesetIndicators.Value == 4 and v.Cooldown then
                    v37 = false;
                end;

                v.Button.Visible = v37;
            end;
        end);
    end;

    local function CooldownRemoved(p38) -- Line: 262
        -- upvalues: u8 (copy), TweenService (copy), u2 (ref)
        for _, v in u8 do
            local Button = v.Button;

            if (v.Move.CooldownName or (v.Move.Name or v.MoveName)) == p38.Name then
                v.Cooldown = false;

                if v.SizeTween then
                    v.SizeTween:Cancel();
                end;

                if v.TransparencyTween then
                    v.TransparencyTween:Cancel();
                end;

                v.SizeTween = TweenService:Create(Button.Cooldown.Meter, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 0, 1, 0)
                });
                v.SizeTween:Play();
                v.TransparencyTween = TweenService:Create(Button.Cooldown.Meter, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                });
                v.TransparencyTween:Play();
            end;
        end;

        local u39 = {};
        task.defer(function() -- Line: 171
            -- upvalues: u8 (ref), u39 (copy), u2 (ref)
            for _, v in u8 do
                local Visible = v.Group.Visible;
                local Priority = v.Priority;
                local v40 = tostring(v.DPadDirection or 0) .. "-" .. (v.Input or "");
                local _ = v.MovesInfoExist;
                local v41 = u39[v40];

                if v41 then
                    if v41.Move.MoveVisible == nil then
                        if v41.Group.Visible == v.Group.Visible then
                            if v41.Group.Visible == v.Group.Visible then
                                v.Move.Visible = v41.Priority < Priority;
                                v41.Move.Visible = Priority < v41.Priority;
                                u39[v40] = v;
                            end;
                        else
                            v.Move.Visible = Visible;
                            v41.Move.Visible = v41.Group.Visible;
                            u39[v40] = v;
                        end;
                    else
                        v.Move.Visible = v41.Priority < Priority;
                    end;

                    local v42;

                    if v41.Visible == nil then
                        v42 = v41.Group.Visible and v41.Move.Visible;
                    else
                        v42 = v41.Visible;
                    end;

                    if u2.MovesetIndicators.Value == 3 then
                        if not v41.Cooldown then
                            v42 = false;
                        end;
                    elseif u2.MovesetIndicators.Value == 4 and v41.Cooldown then
                        v42 = false;
                    end;

                    v41.Button.Visible = v42;
                else
                    if v.MovesInfoExist then
                        v.Move.Visible = Visible;
                    end;

                    u39[v40] = v;
                end;

                if v.Move.MoveVisible ~= nil then
                    v.Move.Visible = v.Move.MoveVisible;
                    v.Visible = v.Move.MoveVisible;
                    u39[v40] = v;

                    if v41 then
                        v41.Move.Visible = Priority < v41.Priority;
                        local v43;

                        if v41.Visible == nil then
                            v43 = v41.Group.Visible and v41.Move.Visible;
                        else
                            v43 = v41.Visible;
                        end;

                        if u2.MovesetIndicators.Value == 3 then
                            if not v41.Cooldown then
                                v43 = false;
                            end;
                        elseif u2.MovesetIndicators.Value == 4 and v41.Cooldown then
                            v43 = false;
                        end;

                        v41.Button.Visible = v43;
                    end;
                end;

                local v44;

                if v.Visible == nil then
                    v44 = v.Group.Visible and v.Move.Visible;
                else
                    v44 = v.Visible;
                end;

                if u2.MovesetIndicators.Value == 3 then
                    if not v.Cooldown then
                        v44 = false;
                    end;
                elseif u2.MovesetIndicators.Value == 4 and v.Cooldown then
                    v44 = false;
                end;

                v.Button.Visible = v44;
            end;
        end);
    end;

    local function ActiveUpdated(p45, p46, p47) -- Line: 298
        -- upvalues: u1 (copy), u8 (copy), TweenService (copy), u2 (ref)
        if u1.Character == p45 then
            for _, v in u8 do
                local Button = v.Button;

                if (v.Move.ActiveName or (v.Move.Name or v.MoveName)) == p46 then
                    v.Active = p47 ~= nil;
                    TweenService:Create(Button.Action, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        BackgroundTransparency = p47 and 0.6 or 1
                    }):Play();
                end;
            end;
        end;

        local u48 = {};
        task.defer(function() -- Line: 171
            -- upvalues: u8 (ref), u48 (copy), u2 (ref)
            for _, v in u8 do
                local Visible = v.Group.Visible;
                local Priority = v.Priority;
                local v49 = tostring(v.DPadDirection or 0) .. "-" .. (v.Input or "");
                local _ = v.MovesInfoExist;
                local v50 = u48[v49];

                if v50 then
                    if v50.Move.MoveVisible == nil then
                        if v50.Group.Visible == v.Group.Visible then
                            if v50.Group.Visible == v.Group.Visible then
                                v.Move.Visible = v50.Priority < Priority;
                                v50.Move.Visible = Priority < v50.Priority;
                                u48[v49] = v;
                            end;
                        else
                            v.Move.Visible = Visible;
                            v50.Move.Visible = v50.Group.Visible;
                            u48[v49] = v;
                        end;
                    else
                        v.Move.Visible = v50.Priority < Priority;
                    end;

                    local v51;

                    if v50.Visible == nil then
                        v51 = v50.Group.Visible and v50.Move.Visible;
                    else
                        v51 = v50.Visible;
                    end;

                    if u2.MovesetIndicators.Value == 3 then
                        if not v50.Cooldown then
                            v51 = false;
                        end;
                    elseif u2.MovesetIndicators.Value == 4 and v50.Cooldown then
                        v51 = false;
                    end;

                    v50.Button.Visible = v51;
                else
                    if v.MovesInfoExist then
                        v.Move.Visible = Visible;
                    end;

                    u48[v49] = v;
                end;

                if v.Move.MoveVisible ~= nil then
                    v.Move.Visible = v.Move.MoveVisible;
                    v.Visible = v.Move.MoveVisible;
                    u48[v49] = v;

                    if v50 then
                        v50.Move.Visible = Priority < v50.Priority;
                        local v52;

                        if v50.Visible == nil then
                            v52 = v50.Group.Visible and v50.Move.Visible;
                        else
                            v52 = v50.Visible;
                        end;

                        if u2.MovesetIndicators.Value == 3 then
                            if not v50.Cooldown then
                                v52 = false;
                            end;
                        elseif u2.MovesetIndicators.Value == 4 and v50.Cooldown then
                            v52 = false;
                        end;

                        v50.Button.Visible = v52;
                    end;
                end;

                local v53;

                if v.Visible == nil then
                    v53 = v.Group.Visible and v.Move.Visible;
                else
                    v53 = v.Visible;
                end;

                if u2.MovesetIndicators.Value == 3 then
                    if not v.Cooldown then
                        v53 = false;
                    end;
                elseif u2.MovesetIndicators.Value == 4 and v.Cooldown then
                    v53 = false;
                end;

                v.Button.Visible = v53;
            end;
        end);
    end;

    local function SettingsUpdated() -- Line: 319
        -- upvalues: Parent (copy), u2 (ref), Update (copy)
        Parent.Visible = u2.MovesetIndicators.Value ~= 2;
        Update();
    end;

    function u1.SetMoveIndicatorVisible(p54) -- Line: 324
        -- upvalues: Parent (copy)
        Parent.Visible = p54;
    end;

    u1.InputTypeChanged:Connect(function(p55) -- Line: 328
        -- upvalues: u1 (copy)
        u1.SetMoveIndicatorVisible(p55 == "Keyboard");
    end);
    u1.SetMoveIndicatorVisible(u1.GetInputType() == "Keyboard");
    task.spawn(Update);
    u3.Updated:Connect(Update);
    u3.VisibilityUpdated:Connect(UpdateVisibility);
    task.spawn(function() -- Line: 336
        -- upvalues: u4 (copy), ActiveUpdated (copy)
        repeat
            task.wait();
        until u4.ActiveUpdated;

        u4.ActiveUpdated:Connect(ActiveUpdated);
    end);
    task.spawn(function() -- Line: 341
        -- upvalues: u1 (copy), CooldownAdded (copy), CooldownRemoved (copy)
        local Cooldowns = u1.Player:WaitForChild("Cooldowns");
        Cooldowns.ChildAdded:Connect(CooldownAdded);
        Cooldowns.ChildRemoved:Connect(CooldownRemoved);
    end);
    u2.MovesetIndicators.Changed:Connect(SettingsUpdated);
    u2.MovesetIndicatorType.Changed:Connect(SettingsUpdated);
    u6.MovesetUpdated:Connect(function() -- Line: 350
        -- upvalues: u3 (copy), CreateMoveset (copy)
        u3:Update();
        task.defer(CreateMoveset);
    end);
    u6.EquippedMove:Connect(CreateMoveset);
    u6.UnequippedMove:Connect(Update);
    u6.ReloadMoveUI:Connect(Update);
    u6.MoveLocked:Connect(function(p56) -- Line: 359
        -- upvalues: u8 (copy)
        if p56 == "Cleared" then
            for _, v in u8 do
                local Button = v.Button;
                Button.Key.TextColor3 = Color3.new(1, 1, 1);
                Button.Label.TextColor3 = Color3.new(1, 1, 1);
            end;

            return;
        end;

        for _, v in u8 do
            if v.MoveName == p56 then
                local Button = v.Button;
                Button.Key.TextColor3 = Color3.new(1, 0, 0);
                Button.Label.TextColor3 = Color3.new(1, 0, 0);
            end;
        end;
    end);
    local u57 = script.Parent.Assets.NextMove:Clone();
    u57.Visible = true;
    u57.Parent = script.Parent;
    local Ability = Player.Data.Ability;

    local function UpdateNextMove() -- Line: 382
        -- upvalues: Ability (copy), u6 (copy), u5 (copy), u57 (copy), TweenService (copy)
        local v58 = Ability:GetAttribute("AbilityLevel");
        local v59 = u6:GetMoveProgressionDataPacket():expect();
        local NextLevel = v59.NextLevel;
        local NextMove = v59.NextMove;
        local NextMoveKey = v59.NextMoveKey;

        if type(NextLevel) ~= "number" or type(v58) ~= "number" then
            return;
        end;

        if NextMoveKey == "?" or not u5:IsMovesetValid() then
            u57.Visible = false;

            return;
        end;

        u57.Visible = true;
        local _ = NextLevel - v58;
        u57.Move.Key.Text = NextMoveKey;
        u57.Move.Label.Text = NextMove;
        u57.Title.Text = `NEXT MOVE (LVL {NextLevel})`;
        TweenService:Create(u57.Progress.Frame, TweenInfo.new(0.35), {
            Size = UDim2.fromScale(v58 / NextLevel, 1)
        }):Play();
    end;

    Ability:GetAttributeChangedSignal("AbilityLevel"):Connect(function() -- Line: 410
        -- upvalues: UpdateNextMove (copy)
        UpdateNextMove();
    end);
    Ability.Changed:Connect(function() -- Line: 413
        -- upvalues: UpdateNextMove (copy)
        UpdateNextMove();
    end);
    UpdateNextMove();
end;