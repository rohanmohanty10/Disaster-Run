  

 

require(game.ReplicatedStorage.ReplicatedRoot.Services.InputService);

return function(u1) -- Line: 4
    local PathShortcuts = u1.PathShortcuts;
    local Knit = u1.Knit;
    local Player = u1.Player;
    Knit.OnStart():await();
    Player:WaitForChild("Data"):WaitForChild("Ability");
    local Trove = require(Knit.Util.Trove);
    require(Knit.Util.TableUtil);
    local StateHandler = require(PathShortcuts.ReplicatedModules:WaitForChild("StateHandler"));
    local Parent = script.Parent;
    local PlayerGui = u1.Player:WaitForChild("PlayerGui");
    local JumpButton = PlayerGui:WaitForChild("TouchGui", (1 / 0)):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton");
    local u2 = Knit.GetController("MoveIndicatorController").GetSingleton();
    local u3 = Knit.GetController("MoveInputController");
    local u4 = Knit.GetService("LayoutService");
    local UserInputService = game:GetService("UserInputService");
    game:GetService("TweenService");
    local v5 = Knit.GetService("MoveService");
    require(PathShortcuts.StandsModule);
    require(PathShortcuts.ReplicatedModules.StatsHandler);
    v5:GetKeybindsMap():expect();
    local Defaults = require(script:WaitForChild("Defaults"));
    local Constants = require(script:WaitForChild("Constants"));
    local MobileButtonNameScheme = Player:WaitForChild("Settings"):WaitForChild("MobileButtonNameScheme");
    local u6 = {};
    u1.Mobile = {
        Edit = false,
        Panning = false,
        Pinching = false
    };
    local Mapping = u1.Util.Mapping;

    local function ResolveInput(p7) -- Line: 53
        -- upvalues: Mapping (copy)
        return Mapping[p7] or p7;
    end;

    local function DoButtonsOverlap(p8, p9, p10, p11) -- Line: 57
        return p8.X.Scale + p9.X.Scale > p10.X.Scale and (p8.X.Scale < p10.X.Scale + p11.X.Scale and p8.Y.Scale + p9.Y.Scale > p10.Y.Scale) and p8.Y.Scale < p10.Y.Scale + p11.Y.Scale;
    end;

    local function FindNonOverlappingPosition(p12, p13, p14) -- Line: 73
        -- upvalues: u6 (copy), DoButtonsOverlap (copy)
        local v15 = p14 or UDim2.fromScale(0.55, 0.55);
        local v16 = p13;
        local v17 = 0;

        while true do
            if v17 >= 100 then
                return v16;
            end;

            local v18 = false;

            for i, v in u6 do
                if i ~= p12 and (v.Button and DoButtonsOverlap(p13, v15, v.Button.Position, v.Button.Size)) then
                    v18 = true;
                    break;
                end;
            end;

            if not v18 then
                return p13;
            end;

            local v19 = v17 * 0.5 % 6.283185307179586;
            local v20 = (math.floor(v17 / 8) + 1) * 0.1;
            p13 = UDim2.fromScale(v16.X.Scale + math.cos(v19) * v20, v16.Y.Scale + math.sin(v19) * v20);
            v17 = v17 + 1;
        end;
    end;

    local u21 = nil;

    function u1.ToggleMobileEdit(p22) -- Line: 118
        -- upvalues: u1 (copy), Parent (copy), u21 (ref)
        u1.Mobile.Edit = p22;
        Parent.Edit.Visible = p22;
        u21();
    end;

    local function GetJumpPosition() -- Line: 124
        -- upvalues: JumpButton (copy)
        return JumpButton.AbsolutePosition;
    end;

    local function GetJumpSize() -- Line: 128
        -- upvalues: JumpButton (copy)
        return JumpButton.AbsoluteSize;
    end;

    function u1.SerializeMobileLayout(p23) -- Line: 132
        -- upvalues: u6 (copy)
        local v24 = {};

        for i, v in u6 do
            if v.Button then
                local Position = v.Button.Position;
                v24[i] = {
                    X = Position.X.Scale,
                    Y = Position.Y.Scale,
                    Size = v.Button.Size.X.Scale
                };
            end;
        end;

        return v24;
    end;

    local u25 = UDim2.fromScale(0.55, 0.55);

    function u1.LoadLayout() -- Line: 151
        -- upvalues: u4 (copy), u6 (copy), Defaults (copy), u25 (copy), FindNonOverlappingPosition (copy)
        local v26 = u4:Load():expect() or {};
        local _, v27 = next(v26);

        if v27 and v27.X then
            v26 = {};

            for i, v in v26 do
                v26[i] = {
                    Position = { v.X, v.Y },
                    Size = { v.Size, v.Size }
                };
            end;
        end;

        local v28 = {};
        local v29 = 0;

        for i, v in u6 do
            table.insert(v28, { i, v });
        end;

        table.sort(v28, function(p30, p31) -- Line: 168
            return p30[1] < p31[1];
        end);

        for _, v in v28 do
            local v32 = v[1];
            local v33 = v[2];
            local v34 = v26[v32];
            local v35 = not v34;

            if v35 then
                local v36;

                if Defaults[v32] then
                    v36 = Defaults[v32];
                else
                    v29 = v29 + 1;
                    v36 = Defaults.PresetPositions[v29];

                    if v35 and #Defaults.PresetPositions < v29 then
                        local v37 = Defaults.PresetPositions[#Defaults.PresetPositions];
                        local v38 = v29 - #Defaults.PresetPositions;
                        v36 = {
                            Position = UDim2.fromScale(v37.Position.X.Scale - (u25.X.Scale - v38 * 0.15), v37.Position.Y.Scale - (u25.Y.Scale - v38 * 0.15))
                        };
                    end;
                end;

                local v39 = UDim2.fromScale(v36.Position.X.Scale + -0.5, v36.Position.Y.Scale);
                local v40 = v36.Size or u25;
                local v41 = FindNonOverlappingPosition(v32, v39, v40);
                v33.Button.Position = v41;
                v33.Button.Size = v40;
            else
                v34.Position = UDim2.fromScale(v34.Position[1], v34.Position[2]);
                v34.Size = UDim2.fromScale(v34.Size[1], v34.Size[2]);
                v33.Button.Position = v34.Position;
                v33.Button.Size = v34.Size or u25;
            end;
        end;
    end;

    local function ResetPositions() -- Line: 207
        -- upvalues: u6 (copy), Defaults (copy), u25 (copy), FindNonOverlappingPosition (copy)
        local v42 = {};
        local v43 = 0;
        local v44 = {};

        for i, v in u6 do
            table.insert(v42, { i, v });
        end;

        table.sort(v42, function(p45, p46) -- Line: 216
            return p45[1] < p46[1];
        end);

        for _, v in v42 do
            local v47 = v[1];
            local v48 = v[2];
            local v49;

            if Defaults[v47] then
                v49 = Defaults[v47];
            else
                v43 = v43 + 1;
                v49 = Defaults.PresetPositions[v43];

                if not v49 and #Defaults.PresetPositions < v43 then
                    local v50 = Defaults.PresetPositions[#Defaults.PresetPositions];
                    local v51 = v43 - #Defaults.PresetPositions;
                    v49 = {
                        Position = UDim2.fromScale(v50.Position.X.Scale - (u25.X.Scale - v51 * 0.15), v50.Position.Y.Scale - (u25.Y.Scale - v51 * 0.15))
                    };
                end;
            end;

            v44[v47] = {
                Position = UDim2.fromScale(v49.Position.X.Scale + -0.5, v49.Position.Y.Scale),
                Size = v49.Size or u25,
                ButtonInfo = v48
            };
        end;

        local v52 = {};

        for i, v in v44 do
            table.insert(v52, {
                Name = i,
                Data = v
            });
        end;

        table.sort(v52, function(p53, p54) -- Line: 252
            local v55 = p53.Data.ButtonInfo.Priority or 0;
            local v56 = p54.Data.ButtonInfo.Priority or 0;

            if v55 == v56 then
                return p53.Name < p54.Name;
            end;

            return v56 < v55;
        end);

        for _ = 1, 5 do
            local v57 = false;

            for _, v in ipairs(v52) do
                local Data = v.Data;
                local Position = Data.ButtonInfo.Button.Position;
                local v58 = FindNonOverlappingPosition(v.Name, Data.Position, Data.Size);
                v57 = math.abs(v58.X.Scale - Position.X.Scale) + math.abs(v58.Y.Scale - Position.Y.Scale) > 0.01 and true or v57;
                Data.ButtonInfo.Button.Position = v58;
                Data.ButtonInfo.Button.Size = Data.Size;
                Data.Position = v58;
            end;

            if not v57 then
                break;
            end;
        end;
    end;

    local function CooldownAdded(u59) -- Line: 288
        -- upvalues: u6 (copy)
        local v60 = u6[u59.Name];

        if not v60 then
            return;
        end;

        local Cooldown = v60.Button.Cooldown;
        Cooldown.Visible = true;
        local u61 = 0;
        local u62 = 0;
        local success, result = pcall(function() -- Line: 299
            -- upvalues: u62 (ref), u59 (copy), u61 (ref), Cooldown (copy)
            while u62 < 1 and u59:GetAttribute("Duration") do
                u61 = u61 + task.wait();
                u62 = u61 / u59:GetAttribute("Duration");

                if u62 > 1 then
                    u62 = 1;
                end;

                Cooldown.Size = UDim2.fromScale(1, 1 - u62);
                Cooldown.Position = UDim2.fromScale(0, u62);
            end;
        end);

        if not success then
            warn(result);
        end;

        Cooldown.Size = UDim2.fromScale(1, 1);
        Cooldown.Position = UDim2.fromScale(0, 0);
    end;

    local function CooldownRemoved(p63) -- Line: 319
        -- upvalues: u6 (copy)
        local v64 = u6[p63.Name];

        if not v64 then
            return;
        end;

        v64.Button.Cooldown.Visible = false;
    end;

    u21 = function() -- Line: 326, Name: UpdateVisibility
        -- upvalues: StateHandler (copy), u1 (copy), u6 (copy), Player (copy)
        local v65 = StateHandler.GetStates(u1.Character);

        for i, v in u6 do
            local Group = v.Group;

            if Group then
                local PersonalUnlocker = Player:FindFirstChild("PersonalUnlocker");
                local _ = v.GroupName;
                local v66;

                if u1.Mobile.Edit and (Group.Show ~= false or PersonalUnlocker ~= nil) then
                    v66 = true;
                elseif v65 and v65[v.GroupName] then
                    v66 = v65[v.GroupName].Active;
                else
                    v66 = Group.Visible;
                end;

                local v67 = `{i}_Move`;

                if v66 and ((u1.Mobile.Edit and (Group.Show ~= false or PersonalUnlocker ~= nil) or not (v65 and v65[v67])) and true or v65[v67].Active) then
                    v.Button.Visible = true;
                else
                    v.Button.Visible = false;
                end;

                if v.Button.Visible == false and v.Down == true then
                    v.Down = false;
                end;
            end;
        end;
    end;

    local function Update() -- Line: 370
        -- upvalues: u6 (copy), u3 (copy), Player (copy), Parent (copy), JumpButton (copy), Mapping (copy), MobileButtonNameScheme (copy), u1 (copy), UserInputService (copy), u2 (copy), Trove (copy), Defaults (copy), Knit (copy), u21 (ref)
        for i, v in u6 do
            v.Trove:Destroy();
            v.Button:Destroy();
            u6[i] = nil;
        end;

        local v68 = u3:GetEquippedMoves();
        local u69 = u3:GetMovesInfo((Player.Data.Ability:GetAttribute("AbilityName"))) and true or nil;
        Parent.Main.Position = UDim2.new(0, JumpButton.AbsolutePosition.X, 0, JumpButton.AbsolutePosition.Y) + UDim2.new(0, 0, 0, 36);
        Parent.Main.Size = UDim2.new(0, JumpButton.AbsoluteSize.X, 0, JumpButton.AbsoluteSize.Y);

        local function CreateButton(p70, p71, p72, p73) -- Line: 391
            -- upvalues: Mapping (ref), Parent (ref), MobileButtonNameScheme (ref)
            if p72 == nil then
                p72 = p71 or p70;
            end;

            local v74 = (Mapping[p72] or p72) .. (p73 and "+" or "");
            local v75 = Parent.Assets.Button:Clone();
            v75.Name = p70;

            if MobileButtonNameScheme.Value == 2 then
                v74 = p71 or (p70 or v74);
            end;

            v75.Label.Text = v74;

            return v75;
        end;

        local function BindInputs(u76, p77, p78) -- Line: 400
            -- upvalues: u1 (ref), Parent (ref), u3 (ref), UserInputService (ref)
            local u79 = p77 or {};
            local Button = u76.Button;
            local Input = u76.Input;
            local Held = u76.Held;
            p78:Connect(Button.InputBegan, function(u80) -- Line: 407
                -- upvalues: Button (copy), u1 (ref), Parent (ref), u76 (copy), u3 (ref), Held (copy), Input (copy), u79 (ref)
                if u80.UserInputType ~= Enum.UserInputType.Touch then
                    return;
                end;

                if u80.UserInputState == Enum.UserInputState.Change then
                    return;
                end;

                Button.Tap.Visible = true;

                if u1.Mobile.Edit then
                    u1.Mobile.Selected = Button;
                    u1.Mobile.Editing = u1.Mobile.Selected;
                    u1.Mobile.BasePosition = u1.Mobile.Editing.Position;
                    u1.Mobile.StartTranslation = Vector2.zero;
                    u1.Mobile.Panning = true;
                    u1.Mobile.LastSelected = Button;
                    Parent.Edit.SizeSlider.Visible = false;

                    return;
                end;

                if u76.Down == true then
                    return;
                end;

                u76.Down = true;
                local v81;

                if Held then
                    v81 = Input .. "+";
                else
                    v81 = Input;
                end;

                u3:Input(v81, "Began");

                if u79.Callbacks and u79.Callbacks.Activated then
                    u79.Callbacks.Activated(u1, u76);
                end;

                local u82 = nil;
                u82 = u80:GetPropertyChangedSignal("UserInputState"):Connect(function() -- Line: 431
                    -- upvalues: u80 (copy), u82 (ref), u76 (ref), u3 (ref), Held (ref), Input (ref), u79 (ref), u1 (ref)
                    local UserInputState = u80.UserInputState;

                    if UserInputState == Enum.UserInputState.End or UserInputState == Enum.UserInputState.Cancel then
                        u82:Disconnect();
                        u82 = nil;
                        u76.Down = false;
                        local v83;

                        if Held then
                            v83 = Input .. "+";
                        else
                            v83 = Input;
                        end;

                        u3:Input(v83, "Ended");

                        if u79.Callbacks and u79.Callbacks.Deactivated then
                            u79.Callbacks.Deactivated(u1, u76);
                        end;
                    end;
                end);
            end);
            p78:Connect(UserInputService.TouchEnded, function() -- Line: 444
                -- upvalues: Button (copy), u1 (ref), Parent (ref)
                Button.Tap.Visible = false;

                if not u1.Mobile.Edit then
                    return;
                end;

                u1.Mobile.Selected = nil;
                u1.Mobile.Editing = nil;
                Parent.Edit.SizeSlider.Visible = true;
            end);
        end;

        local function SetupButtonData(p84, p85, p86, p87, p88) -- Line: 464
            -- upvalues: u69 (ref), u6 (ref), Parent (ref), BindInputs (copy)
            local v89 = {
                Dragging = false,
                Scaling = false,
                Button = p84,
                Input = p85,
                Trove = p86,
                MovesInfoExist = u69
            };

            for i, v in p88 do
                v89[i] = v;
            end;

            p84.Visible = true;
            u6[p84.Name] = v89;
            p84.Parent = Parent.Main;
            BindInputs(v89, p87, p86);

            return v89;
        end;

        for i, v in u2:GetGroups() do
            local v90 = v.Priority or 0;

            for i2, v2 in v.Moves do
                local v91 = v2.Name or i2;
                local v92 = v68[v91];
                local v93;

                if v92 then
                    v93 = v92.Keybind;
                else
                    v93 = v92;
                end;

                if v93 then
                    local DisplayName = v2.DisplayName;
                    local v94;

                    if v93 == nil then
                        v94 = DisplayName or v91;
                    else
                        v94 = v93;
                    end;

                    local v95 = (Mapping[v94] or v94) .. (v92.Held and "+" or "");
                    local v96 = Parent.Assets.Button:Clone();
                    v96.Name = v91;

                    if MobileButtonNameScheme.Value == 2 then
                        v95 = DisplayName or (v91 or v95);
                    end;

                    v96.Label.Text = v95;
                    SetupButtonData(v96, v93, Trove.new(), nil, {
                        Down = false,
                        GroupName = i,
                        Group = v,
                        MoveName = i2,
                        Move = v2,
                        Priority = v90,
                        Held = v92.Held
                    });
                end;
            end;
        end;

        for _, v in { "Run", "Shift Lock", "Lock" } do
            local v97 = Defaults[v];

            if v97 then
                local v98 = nil;

                if v98 == nil then
                    v98 = v;
                end;

                local v99 = (Mapping[v98] or v98) .. "";
                local v100 = Parent.Assets.Button:Clone();
                v100.Name = v;
                v100.Label.Text = MobileButtonNameScheme.Value == 2 and v and v or v99;
                SetupButtonData(v100, v, Trove.new(), v97, {
                    Priority = 0,
                    MoveName = v,
                    Knit = Knit
                });
            end;
        end;

        u21();
        u1.LoadLayout();
    end;

    task.spawn(Update);
    u2.VisibilityUpdated:Connect(u21);
    u2.Updated:Connect(function() -- Line: 580
        -- upvalues: Update (copy)
        task.defer(Update);
    end);
    UserInputService.TouchPan:Connect(function(p101, p102, p103, p104) -- Line: 530, Name: TouchPan
        -- upvalues: u1 (copy)
        local Mobile = u1.Mobile;

        if Mobile.Edit then
            if p104 == Enum.UserInputState.Begin and (Mobile.Selected and not (Mobile.Editing or Mobile.Pinching)) then
                return;
            end;

            if p104 == Enum.UserInputState.Change and (Mobile.Editing and (Mobile.Panning and not Mobile.Pinching)) then
                local v105 = Mobile.BasePosition + UDim2.fromScale((p102.X - Mobile.StartTranslation.X) / Mobile.Editing.AbsoluteSize.X / 5, (p102.Y - Mobile.StartTranslation.Y) / Mobile.Editing.AbsoluteSize.Y / 5);
                Mobile.Editing.Position = v105;
                Mobile.BasePosition = v105;
                Mobile.StartTranslation = p102;
            end;

            return;
        end;

        Mobile.Editing = nil;
        Mobile.Panning = false;
    end);
    UserInputService.TouchPinch:Connect(function(p106, p107, p108, p109, p110) -- Line: 552, Name: TouchPinch
        -- upvalues: u1 (copy), Constants (copy)
        local Mobile = u1.Mobile;

        if not Mobile.Edit then
            Mobile.Editing = nil;
            Mobile.Pinching = false;

            return;
        end;

        if p109 == Enum.UserInputState.Begin and Mobile.Selected then
            Mobile.BaseScale = Mobile.Editing.Size.X.Scale;
            Mobile.Pinching = true;

            return;
        end;

        if p109 ~= Enum.UserInputState.Change or not (Mobile.Editing and Mobile.Pinching) then
            if p109 == Enum.UserInputState.End then
                Mobile.Pinching = false;
            end;

            return;
        end;

        local v111 = math.clamp(Mobile.BaseScale * p107, Constants.MIN_SIZE, Constants.MAX_SIZE);
        Mobile.Editing.Size = UDim2.fromScale(v111, v111);
    end);
    v5.EquippedMove:Connect(Update);
    v5.UnequippedMove:Connect(Update);
    v5.ReloadMoveUI:Connect(Update);
    MobileButtonNameScheme.Changed:Connect(Update);
    v5.MovesetUpdated:Connect(function() -- Line: 590
        -- upvalues: Update (copy)
        task.defer(Update);
    end);
    Parent.Edit.Holder.Cancel.MouseButton1Down:Connect(function() -- Line: 595
        -- upvalues: u1 (copy)
        u1.ToggleMobileEdit(false);
    end);
    Parent.Edit.SizeSlider.InputBegan:Connect(function(p112) -- Line: 599
        -- upvalues: u1 (copy), PlayerGui (copy), Constants (copy)
        if p112.UserInputType ~= Enum.UserInputType.Touch or p112.UserInputState ~= Enum.UserInputState.Begin then
            return;
        end;

        if u1.Mobile.LastSelected == nil or u1.Mobile.LastSelected:IsDescendantOf(PlayerGui) ~= true then
            return;
        end;

        local Position = p112.Position;
        local Scale = u1.Mobile.LastSelected.Size.X.Scale;

        while p112.UserInputState ~= Enum.UserInputState.End and p112.UserInputState ~= Enum.UserInputState.Cancel do
            local v113 = math.clamp(Scale + (p112.Position - Position).Y / -200, Constants.MIN_SIZE, Constants.MAX_SIZE);
            u1.Mobile.LastSelected.Size = UDim2.fromScale(v113, v113);
            task.wait();
        end;
    end);
    Parent.Edit.Holder.Reset.MouseButton1Click:Connect(function() -- Line: 612
        -- upvalues: ResetPositions (copy)
        ResetPositions();
    end);
    Parent.Edit.Holder.Finish.MouseButton1Down:Connect(function() -- Line: 616
        -- upvalues: u1 (copy), u4 (copy)
        local v114 = u1.SerializeMobileLayout();

        if v114 then
            if u4:Save(v114):expect() then
                u1.NewPrompt({
                    Title = "Save Successful",
                    Text = "Ability Layout saved"
                });
            else
                u1.NewPrompt({
                    Title = "Save Failed",
                    Text = "Failed to save Ability Layout"
                });
            end;
        end;

        u1.ToggleMobileEdit(false);
    end);
    u1.InputTypeChanged:Connect(function(p115) -- Line: 636
        -- upvalues: Parent (copy)
        Parent.Visible = p115 == "Mobile";
    end);
    Parent.Visible = u1.GetInputType() == "Mobile";
    task.spawn(function() -- Line: 641
        -- upvalues: u1 (copy), CooldownAdded (copy), CooldownRemoved (copy)
        local Cooldowns = u1.Player:WaitForChild("Cooldowns");
        Cooldowns.ChildAdded:Connect(CooldownAdded);
        Cooldowns.ChildRemoved:Connect(CooldownRemoved);
    end);

    if UserInputService.TouchEnabled then
        local JumpButton2 = Player:WaitForChild("PlayerGui"):WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):FindFirstChild("JumpButton");
        game:GetService("RunService").RenderStepped:Connect(function() -- Line: 651
            -- upvalues: JumpButton2 (copy)
            if not JumpButton2.Visible then
                JumpButton2.Visible = true;
            end;
        end);
    end;
end;