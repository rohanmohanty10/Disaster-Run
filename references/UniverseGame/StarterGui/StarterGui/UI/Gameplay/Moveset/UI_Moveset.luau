  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local Fusion = require(ReplicatedRoot.Libraries.Interface.Fusion);
require(ReplicatedRoot.Libraries.Classes.Trove);
local WorldService = require(ReplicatedRoot.Services.Gameplay.WorldService);
local MoveService = require(ReplicatedRoot.Services.Gameplay.MoveService);
require(ReplicatedRoot.Services.MoveInputController);
require(ReplicatedRoot.Services.CombatService);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local InputUtil = require(ReplicatedRoot.Libraries.Utility.InputUtil);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local IndicatorTips = require(ReplicatedRoot.Libraries.Interface.IndicatorTips);
local UserInputService = game:GetService("UserInputService");
local Assets = script.Parent.Assets;

return function(p1) -- Line: 47
    -- upvalues: Fusion (copy), UserInputService (copy), Assets (copy), InputUtil (copy), MoveService (copy), TableUtil (copy), IndicatorTips (copy), Core (copy), WorldService (copy)
    local LocalPlayer = game.Players.LocalPlayer;
    local u2 = nil;
    local u3 = nil;
    local Settings = LocalPlayer:WaitForChild("Settings");
    local u4 = Fusion.Value(Settings.MovesetIndicatorTips.Value);
    Settings.MovesetIndicatorTips:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 54
        -- upvalues: u4 (copy), Settings (copy)
        u4:set(Settings.MovesetIndicatorTips.value);
    end);
    local u5 = Fusion.Value(UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 59
        -- upvalues: u5 (copy), UserInputService (ref)
        u5:set(UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse);
    end);
    local u6 = {};
    local u7 = {};
    Fusion.Hydrate(script.Parent)({
        Visible = u5
    });

    local function UpdateHover() -- Line: 75
        -- upvalues: u7 (copy)
        local v8 = {};

        for i, v in pairs(u7) do
            table.insert(v8, {
                Move = i,
                Indicator = v,
                Order = v.Button.LayoutOrder
            });
        end;

        table.sort(v8, function(p9, p10) -- Line: 90
            return p9.Order < p10.Order;
        end);

        for _, v in pairs(v8) do
            if v == v8[1] then
                v.Indicator.Hovering:set(true);
            else
                v.Indicator.Hovering:set(false);
            end;
        end;
    end;

    local function CreateMoveIndicator(p11) -- Line: 103
        -- upvalues: Fusion (ref), u4 (copy), Assets (ref), InputUtil (ref), u7 (copy), UpdateHover (copy)
        local u12 = p11 or {};
        local Move = u12.Move;

        if not Move then
            return nil;
        end;

        u12.DisplayName = u12.DisplayName or Fusion.Value("Display Name");
        u12.Input = u12.Input or Fusion.Value(nil);
        u12.IsHeld = u12.IsHeld or Fusion.Value(false);
        u12.Order = u12.Order or Fusion.Value(0);
        u12.Enabled = u12.Enabled or Fusion.Value(true);
        u12.First = u12.First or Fusion.Value(true);
        u12.Meter = u12.Meter or Fusion.Value(0);
        u12.MaxMeter = u12.MaxMeter or Fusion.Value(0);
        u12.Tooltip = u12.Tooltip or Fusion.Value("Unknown");
        u12.Hovering = u12.Hovering or Fusion.Value(false);
        u12.Active = u12.Active or Fusion.Value(false);
        u12.Cooldown = u12.Cooldown or Fusion.Value(0);
        u12.MaxCooldown = u12.MaxCooldown or Fusion.Value(1);
        u12.BackgroundColor = u12.BackgroundColor or Fusion.Value(nil);
        local u13 = Fusion.Computed(function() -- Line: 130
            -- upvalues: u4 (ref), u12 (copy)
            if u4:get() == 1 then
                return u12.Hovering:get() == true;
            end;

            return u4:get() == 2;
        end);
        local v15 = Fusion.Computed(function() -- Line: 139
            -- upvalues: u12 (copy)
            local v14;

            if u12.Enabled:get() == true and u12.First:get() == true then
                v14 = u12.Input:get() ~= nil;
            else
                v14 = false;
            end;

            return v14;
        end);
        local v16 = Assets.Button:Clone();
        Fusion.Hydrate(v16)({
            Name = u12.DisplayName,
            Visible = v15,
            Size = Fusion.Computed(function() -- Line: 149
                -- upvalues: u13 (copy)
                if u13:get() == true then
                    return UDim2.new(1, 100, 0, 0);
                end;

                return UDim2.new(1, 0, 0, 0);
            end),
            LayoutOrder = Fusion.Computed(function() -- Line: 155
                -- upvalues: u12 (copy), InputUtil (ref)
                local v17 = u12.Order:get();
                local v18 = u12.Input:get() and (table.find(InputUtil.Order, string.upper(u12.Input:get().Name)) or 0) or 0;

                if u12.IsHeld:get() then
                    v17 = v17 - 1;
                end;

                return v18 * 100 - v17;
            end)
        });
        local BackgroundColor3 = v16.Move.Items.BackgroundColor3;
        Fusion.Hydrate(v16.Move.Items)({
            BackgroundColor3 = Fusion.Computed(function() -- Line: 171
                -- upvalues: u12 (copy), BackgroundColor3 (copy)
                return u12.BackgroundColor:get() or BackgroundColor3;
            end)
        });
        Fusion.Hydrate(v16.Move.Items.DisplayName.Label)({
            Text = u12.DisplayName
        });
        Fusion.Hydrate(v16.Move.Items.Input.Label)({
            Text = Fusion.Computed(function() -- Line: 183
                -- upvalues: u12 (copy), InputUtil (ref)
                return not u12.Input:get() and "?" or InputUtil.FormatIndicatorString({
                    Input = u12.Input:get(),
                    IsHeld = u12.IsHeld:get()
                });
            end),
            Visible = Fusion.Computed(function() -- Line: 192
                -- upvalues: u12 (copy)
                return u12.Cooldown:get() <= 0;
            end),
            TextTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 195
                -- upvalues: u12 (copy)
                return u12.Cooldown:get() <= 0 and 0 or 1;
            end), 48)
        });
        Fusion.Hydrate(v16.Move.Items.Input.Label.UIStroke)({
            Transparency = Fusion.Spring(Fusion.Computed(function() -- Line: 204
                -- upvalues: u12 (copy)
                return u12.Cooldown:get() <= 0 and 0.6 or 1;
            end), 48)
        });
        local v21 = {
            Text = Fusion.Computed(function() -- Line: 214
                -- upvalues: u12 (copy)
                local v19 = u12.Meter:get();
                local v20 = u12.MaxMeter:get();

                if v20 and v19 < v20 then
                    return `{string.format("%.0f", v19)}-{string.format("%.0f", v20)}`;
                end;

                return `{string.format("%.0f", v19)}`;
            end),
            Visible = Fusion.Computed(function() -- Line: 222
                -- upvalues: u12 (copy)
                return u12.Meter:get() > 0;
            end)
        };
        Fusion.Hydrate(v16.Tooltip.Meter.Label)(v21);
        Fusion.Hydrate(v16.Info.Meter.Label)(v21);
        Fusion.Hydrate(v16.Tooltip.Label)({
            Text = u12.Tooltip
        });
        Fusion.Hydrate(v16.Tooltip)({
            Visible = u13
        });
        Fusion.Hydrate(v16.Info)({
            Visible = Fusion.Computed(function() -- Line: 239
                -- upvalues: u13 (copy)
                return not u13:get();
            end)
        });
        Fusion.Hydrate(v16.Move.IsActive)({
            Visible = true,
            BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 246
                -- upvalues: u12 (copy)
                return u12.Active:get() and 0.9 or 1;
            end), 48)
        });
        Fusion.Hydrate(v16.Move.IsActive.UIStroke)({
            Transparency = Fusion.Spring(Fusion.Computed(function() -- Line: 256
                -- upvalues: u12 (copy)
                return u12.Active:get() and 0.2 or 1;
            end), 48)
        });
        Fusion.Hydrate(v16.Move.Cooldown)({
            Visible = true
        });
        local u22 = Fusion.Value(v16.Move.Cooldown.AbsoluteSize);
        Fusion.Hydrate(v16.Move.Cooldown)({
            [Fusion.OnChange("AbsoluteSize")] = function(p23) -- Line: 274
                -- upvalues: u22 (copy)
                u22:set(p23);
            end
        });
        local v26 = Fusion.Spring(Fusion.Computed(function() -- Line: 279
            -- upvalues: u12 (copy)
            local v24 = u12.Cooldown:get() / u12.MaxCooldown:get();
            local v25 = math.clamp(v24, 0, 1);

            return UDim2.new(v25, 0, 1, 0);
        end), 48);
        Fusion.Hydrate(v16.Move.Cooldown.Meter)({
            Size = v26
        });
        u12.CooldownSpring = v26;
        local v27 = Fusion.Spring(Fusion.Computed(function() -- Line: 288
            -- upvalues: u22 (copy)
            return UDim2.new(0, u22:get().X, 1, 0);
        end), 48);
        Fusion.Hydrate(v16.Move.Cooldown.Meter.Bar)({
            Size = v27
        });
        Fusion.Hydrate(v16.Move.Cooldown.Time.Label)({
            Text = Fusion.Computed(function() -- Line: 297
                -- upvalues: u12 (copy)
                if u12.Cooldown:get() >= 10 then
                    return string.format("%.0f", u12.Cooldown:get());
                end;

                return (u12.Cooldown:get() <= 0 or u12.Cooldown:get() >= 10) and "" or string.format("%.1f", u12.Cooldown:get());
            end)
        });

        local function HydrateCooldownTransparency(p28) -- Line: 307
            -- upvalues: Fusion (ref), u12 (copy)
            if p28:IsA("Frame") then
                local BackgroundTransparency = p28.BackgroundTransparency;
                Fusion.Hydrate(p28)({
                    BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 311
                        -- upvalues: u12 (ref), BackgroundTransparency (copy)
                        return u12.Cooldown:get() <= 0 and 1 or BackgroundTransparency;
                    end), 48)
                });

                return;
            end;

            if not p28:IsA("UIStroke") then
                if p28:IsA("TextLabel") then
                    local TextTransparency = p28.TextTransparency;
                    Fusion.Hydrate(p28)({
                        TextTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 331
                            -- upvalues: u12 (ref), TextTransparency (copy)
                            return u12.Cooldown:get() <= 0 and 1 or TextTransparency;
                        end), 48)
                    });
                end;

                return;
            end;

            local Transparency = p28.Transparency;
            Fusion.Hydrate(p28)({
                Transparency = Fusion.Spring(Fusion.Computed(function() -- Line: 321
                    -- upvalues: u12 (ref), Transparency (copy)
                    return u12.Cooldown:get() <= 0 and 1 or Transparency;
                end), 48)
            });
        end;

        HydrateCooldownTransparency(v16.Move.Cooldown.Meter.Bar.Background);
        HydrateCooldownTransparency(v16.Move.Cooldown.Meter.Bar.Outline.UIStroke);
        HydrateCooldownTransparency(v16.Move.Cooldown.Time.Label);
        HydrateCooldownTransparency(v16.Move.Cooldown.Time.Label.UIStroke);
        HydrateCooldownTransparency(v16.Move.Cooldown.Meter.Bar.Stroke.Middle.Container.UIStroke);
        Fusion.Hydrate(v16.Hover)({
            [Fusion.OnEvent("MouseEnter")] = function() -- Line: 350
                -- upvalues: u7 (ref), Move (copy), u12 (copy), UpdateHover (ref)
                u7[Move] = u12;
                UpdateHover();
            end,

            [Fusion.OnEvent("MouseLeave")] = function() -- Line: 354
                -- upvalues: u7 (ref), Move (copy), u12 (copy), UpdateHover (ref)
                u7[Move] = nil;
                u12.Hovering:set(false);
                UpdateHover();
            end
        });
        u12.Button = v16;
        v16.Parent = script.Parent;

        function u12.Destroy(p29) -- Line: 365
            -- upvalues: u12 (copy)
            u12.Button:Destroy();
        end;

        return u12;
    end;

    local function UpdateFlag(p30) -- Line: 372
        -- upvalues: u6 (copy), MoveService (ref), u2 (ref)
        local v31 = u6[p30];

        if not v31 then
            return;
        end;

        if table.isfrozen(p30) then
            return;
        end;

        local v32 = {};

        for _, v in pairs(p30:GetBinds()) do
            if v.Flag then
                v32[v.Flag] = true;
            end;
        end;

        if next(v32) then
            for i, _ in pairs(v32) do
                if MoveService.FindFirstMove(u2, {
                    Debug = true,
                    Bound = true,
                    IncludeFlags = {
                        [i] = true
                    }
                }) == p30 then
                    v31.First:set(true);
                else
                    v31.First:set(false);
                end;
            end;
        end;
    end;

    local function UpdateFlags() -- Line: 407
        -- upvalues: u6 (copy), UpdateFlag (copy)
        for i, _ in pairs(u6) do
            UpdateFlag(i);
        end;
    end;

    local function AddMove(u33) -- Line: 413
        -- upvalues: u6 (copy), CreateMoveIndicator (copy), Fusion (ref), UpdateFlag (copy), TableUtil (ref), IndicatorTips (ref)
        if u6[u33] then
            return;
        end;

        if u33.Data.Indicator and u33.Data.Indicator.Enabled == false then
            return;
        end;

        local u34 = CreateMoveIndicator({
            Move = u33,
            DisplayName = u33.Data.DisplayName or u33.Data.Name,
            Enabled = Fusion.Value(u33:IsEnabled()),
            Order = Fusion.Value(u33.Data.Order or 0 + (u33.Data.IsSubpower == true and 100000 or 0)),
            BackgroundColor = u33.Data.IsSubpower and Fusion.Value(Color3.fromRGB(50, 25, 75)) or nil
        });

        if u34 == nil then
            return;
        end;

        u6[u33] = u34;
        local v35 = u33:GetBinds();
        local u36 = nil;

        local function UpdateBind(p37) -- Line: 437
            -- upvalues: u36 (ref), u34 (copy), UpdateFlag (ref), u33 (copy)
            if u36 ~= p37 then
                u36 = p37;
                u34.Input:set(p37.Input);
                u34.IsHeld:set(p37.IsHeld);
                UpdateFlag(u33);
            end;
        end;

        local function ClearBind() -- Line: 446
            -- upvalues: u36 (ref), u34 (copy), UpdateFlag (ref), u33 (copy)
            if u36 then
                u36 = nil;
                u34.Input:set(nil);
                u34.IsHeld:set(false);
                UpdateFlag(u33);
            end;
        end;

        if v35[1] then
            local v38 = v35[1];

            if u36 ~= v38 then
                u36 = v38;
                u34.Input:set(v38.Input);
                u34.IsHeld:set(v38.IsHeld);
                UpdateFlag(u33);
            end;
        end;

        local function UpdateTooltip() -- Line: 459
            -- upvalues: u33 (copy), TableUtil (ref), IndicatorTips (ref), u34 (copy)
            local v39 = u33.Metadata.MeterCost or 0;
            local v40 = u33.Metadata.MaxMeterCost or v39;
            local v41 = {};

            for _, v in pairs(TableUtil.Reconcile(u33.Data.Indicator and u33.Data.Indicator.Tips or {}, IndicatorTips)) do
                if v.Enabled ~= false and (not v.Check or v.Check(u33)) then
                    local v42 = v.Text or "";

                    if v.Transformer then
                        v42 = v.Transformer(u33, v42);
                    end;

                    if v42 ~= nil and v42 ~= "" then
                        table.insert(v41, {
                            Priority = v.Priority or 0,
                            Text = v42
                        });
                    end;
                end;
            end;

            table.sort(v41, function(p43, p44) -- Line: 490
                return p43.Priority < p44.Priority;
            end);
            local v45 = {};

            for _, v in pairs(v41) do
                table.insert(v45, v.Text);
            end;

            u34.Meter:set(v39);
            u34.MaxMeter:set(v40);
            u34.Tooltip:set(table.concat(v45, " | "));
        end;

        u33.Collector:Connect(u33.Fired, function() -- Line: 504
            -- upvalues: u33 (copy), u34 (copy)
            if u33:IsRunning() then
                u34.Active:set(true);
            end;
        end);
        u33.Collector:Connect(u33.Ended, function() -- Line: 510
            -- upvalues: u33 (copy), u34 (copy)
            if not u33:IsRunning() then
                u34.Active:set(false);
            end;
        end);
        u33.Collector:Connect(u33.OnEnabled, function() -- Line: 516
            -- upvalues: u34 (copy)
            u34.Enabled:set(true);
        end);
        u33.Collector:Connect(u33.OnDisabled, function() -- Line: 520
            -- upvalues: u34 (copy)
            u34.Enabled:set(false);
        end);
        u33.Collector:Connect(u33.Initialized, function() -- Line: 524
            -- upvalues: UpdateTooltip (copy), u6 (ref), UpdateFlag (ref)
            UpdateTooltip();

            for i, _ in pairs(u6) do
                UpdateFlag(i);
            end;
        end);
        u33.Collector:Connect(u33.OnBind, function(p46) -- Line: 529
            -- upvalues: u36 (ref), u34 (copy), UpdateFlag (ref), u33 (copy)
            if p46.Index == 1 and u36 ~= p46 then
                u36 = p46;
                u34.Input:set(p46.Input);
                u34.IsHeld:set(p46.IsHeld);
                UpdateFlag(u33);
            end;
        end);
        u33.Collector:Connect(u33.OnUnbind, function(p47) -- Line: 535
            -- upvalues: u36 (ref), u34 (copy), UpdateFlag (ref), u33 (copy)
            if p47.Index == 1 and (u36 == p47 and u36) then
                u36 = nil;
                u34.Input:set(nil);
                u34.IsHeld:set(false);
                UpdateFlag(u33);
            end;
        end);
        UpdateTooltip();
    end;

    local function RemoveMove(p48) -- Line: 544
        -- upvalues: u6 (copy)
        local v49 = u6[p48];

        if v49 then
            v49:Destroy();
            u6[p48] = nil;
        end;
    end;

    local function CharacterAdded(p50) -- Line: 552
        -- upvalues: Core (ref), u2 (ref), u3 (ref), WorldService (ref), AddMove (copy), u6 (copy), UpdateFlag (copy)
        if Core.Flags.UseNewMovesetUI == false then
            return;
        end;

        u2 = p50;
        u3 = WorldService.AwaitCharacterEntity(u2, 5);

        for _, v in pairs(u3.Moves) do
            AddMove(v);
        end;

        u3.Collector:Connect(u3.MoveAdded, function(p51) -- Line: 563
            -- upvalues: AddMove (ref)
            AddMove(p51);
        end);
        u3.Collector:Connect(u3.MoveRemoved, function(p52) -- Line: 566
            -- upvalues: u6 (ref)
            local v53 = u6[p52];

            if v53 then
                v53:Destroy();
                u6[p52] = nil;
            end;
        end);
        u3.Collector:Connect(u3.MoveFlagChanged, function(p54) -- Line: 569
            -- upvalues: u6 (ref), UpdateFlag (ref)
            for i, _ in pairs(u6) do
                UpdateFlag(i);
            end;
        end);
        u3.Collector:Connect(u3.CooldownAdded, function(p55) -- Line: 573
            -- upvalues: u6 (ref)
            for i, v in pairs(u6) do
                if i.Data.Cooldown and i.Data.Cooldown.Name == p55.Name then
                    v.CurrentCooldown = p55;
                    v.Cooldown:set(v.CurrentCooldown.Time);
                    v.MaxCooldown:set(v.CurrentCooldown.Length);
                    v.CooldownSpring:setPosition(UDim2.new(math.clamp(v.CurrentCooldown.Time / v.CurrentCooldown.Length, 0, 1), 0, 1, 0));
                end;
            end;
        end);
        u3.Collector:Connect(u3.CooldownRemoved, function(p56) -- Line: 584
            -- upvalues: u6 (ref)
            for i, v in pairs(u6) do
                if i.Data.Cooldown and i.Data.Cooldown.Name == p56.Name then
                    v.CurrentCooldown = nil;
                    v.Cooldown:set(0);
                end;
            end;
        end);
        u3.Collector:Connect(u3.CooldownsUpdated, function(p57) -- Line: 593
            -- upvalues: u6 (ref)
            for _, v in pairs(u6) do
                if v.CurrentCooldown then
                    v.Cooldown:set(v.CurrentCooldown.Time);
                else
                    v.Cooldown:set(0);
                    v.MaxCooldown:set(1);
                end;
            end;
        end);

        for i, _ in pairs(u6) do
            UpdateFlag(i);
        end;
    end;

    local function CharacterRemoving(p58) -- Line: 607
        -- upvalues: u6 (copy)
        for i, _ in pairs(u6) do
            if i.Character == p58 or i.Character == nil then
                local v59 = u6[i];

                if v59 then
                    v59:Destroy();
                    u6[i] = nil;
                end;
            end;
        end;
    end;

    if LocalPlayer.Character then
        task.spawn(CharacterAdded, LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(CharacterAdded);
    LocalPlayer.CharacterRemoving:Connect(CharacterRemoving);
end;