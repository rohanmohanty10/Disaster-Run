  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;

local function toMS(p1) -- Line: 13
    if p1 >= 60 then
        return `{string.format("%02i", p1 / 60 % 60)}m`;
    end;

    return `{string.format("%02i", p1 % 60)}s`;
end;

local function toRoman(p2) -- Line: 18
    local v3 = "";

    for _, v in ipairs({ { 10, "X" }, { 9, "IX" }, { 5, "V" }, { 4, "IV" }, { 1, "I" } }) do
        while v[1] <= p2 do
            v3 = v3 .. v[2];
            p2 = p2 - v[1];
        end;
    end;

    return v3;
end;

return function(p4) -- Line: 38
    -- upvalues: ReplicatedStorage (copy), toRoman (copy), LocalPlayer (copy), Players (copy)
    local Parent = script.Parent;
    local ReplicatedRoot = ReplicatedStorage.ReplicatedRoot;
    local Core = require(ReplicatedRoot:WaitForChild("Core"));
    require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
    require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
    local StatusIndicatorData = require(ReplicatedStorage.ReplicatedModules.StatusIndicators.StatusIndicatorData);
    Core.OnStart():await();
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    local Trove = require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
    require(ReplicatedStorage.ReplicatedModules.Types);
    local CombatService = require(ReplicatedRoot.Services.CombatService);
    local u5 = p4.Util.Tooltip.GetFromParent(p4.UI:FindFirstChild("Screen"));
    local Effect = script.Effect;
    local u6 = Fusion.Value({});
    local u7 = Fusion.Value(0);
    local u8 = nil;

    local function AddEffect(p9, p10) -- Line: 66
        -- upvalues: u6 (copy), StatusIndicatorData (copy), u7 (copy)
        if not (p9 and p10) then
            return;
        end;

        local v11 = u6:get();
        local v12 = v11[p9] == nil;
        local v13 = StatusIndicatorData[p9] and StatusIndicatorData[p9].Priority;
        local v14 = {
            Name = p9,
            Duration = p10.Duration
        };

        if p10.CustomPriority then
            v13 = p10.CustomPriority;
        elseif not v13 or v13 == 0 then
            v13 = u7:get();
        end;

        v14.Priority = v13;
        v14.Metadata = p10.Metadata or {};
        v11[p9] = v14;
        u6:set(v11);

        if v12 then
            u7:set(u7:get() + 1);
        end;
    end;

    local function UpdateEffect(p15, p16) -- Line: 90
        -- upvalues: u6 (copy), AddEffect (copy)
        if p16.Explicit and not u6:get()[p15] then
            return;
        end;

        AddEffect(p15, p16);
    end;

    local function RemoveEffect(p17, p18) -- Line: 117
        -- upvalues: u6 (copy), u7 (copy)
        local v19 = u6:get();

        if not v19[p17] then
            return;
        end;

        v19[p17] = nil;
        u6:set(v19);
        u7:set(u7:get() - 1);
    end;

    Fusion.Hydrate(Parent)({
        [Fusion.Children] = Fusion.ForPairs(u6, function(u20, u21) -- Line: 131
            -- upvalues: Effect (copy), Trove (copy), Fusion (copy), u8 (ref), u5 (copy), StatusIndicatorData (copy), toRoman (ref)
            local u22 = Effect:Clone();
            u22.LayoutOrder = u21.Priority;
            u22.Name = u20;
            local u23 = true;

            if u21.Duration then
                task.spawn(function() -- Line: 139
                    -- upvalues: u21 (copy), u22 (copy)
                    if u21.Duration >= 100000 then
                        u22.Time.Text = "--:--";

                        return;
                    end;

                    local Time = u22.Time;
                    local Duration = u21.Duration;
                    local v24;

                    if Duration >= 60 then
                        v24 = `{string.format("%02i", Duration / 60 % 60)}m`;
                    else
                        v24 = `{string.format("%02i", Duration % 60)}s`;
                    end;

                    Time.Text = v24;
                    local v25 = os.clock();

                    while os.clock() - v25 < u21.Duration do
                        local v26 = os.clock();
                        local v27 = math.max(u21.Duration - (v26 - v25), 0);

                        if u22.Parent then
                            local Time2 = u22.Time;
                            local v28 = v27 + 1;
                            local v29;

                            if v28 >= 60 then
                                v29 = `{string.format("%02i", v28 / 60 % 60)}m`;
                            else
                                v29 = `{string.format("%02i", v28 % 60)}s`;
                            end;

                            Time2.Text = v29;

                            if v27 < 2 then
                                local v30 = 2 - v27;
                                local v31 = math.clamp(v30 / 2, 0, 1);
                                local v32 = math.lerp(0.8, 1.75, v31);
                                local Icon = u22.Icon;
                                local v33 = math.sin(v30 * 3.141592653589793 * v32);
                                Icon.ImageTransparency = math.abs(v33) * 0.65 + 0;
                            end;
                        end;

                        task.wait();
                    end;
                end);
            end;

            local u34 = Trove.new();
            Fusion.Hydrate(u22)({
                [Fusion.Cleanup] = function() -- Line: 169
                    -- upvalues: u23 (ref), u34 (copy), u8 (ref), u22 (copy), u5 (ref)
                    u23 = false;
                    u34:Destroy();

                    if u8 == u22 then
                        u5:Hide();
                        u8 = nil;
                    end;
                end
            });
            local v35 = Fusion.Spring(Fusion.Value(1), 25, 0.8);
            Fusion.Hydrate(u22.Icon.UIScale)({
                Scale = v35
            });
            v35:addVelocity(1.25);
            local v36 = StatusIndicatorData[u20];

            if u21.Metadata and u21.Metadata.Stacks then
                u22.Meta.Visible = true;
                u22.Meta.Stacks.Visible = true;
                u22.Meta.Stacks.Text = toRoman(u21.Metadata.Stacks);
            end;

            if v36 then
                if v36.Icon then
                    u22.Icon.Image = v36.Icon;
                end;

                if v36.Type then
                    local UIGradient = u22.Icon.UIStroke.UIGradient;
                    local new = ColorSequence.new;
                    local v37;

                    if v36.Type == "Positive" then
                        v37 = Color3.new(0.572549, 1, 0.54902);
                    else
                        v37 = Color3.fromRGB(255, 90, 90);
                    end;

                    UIGradient.Color = new(v37);
                end;
            end;

            local u38 = v36 or {};
            u34:Connect(u22.Register.MouseEnter, function(p39, p40) -- Line: 210
                -- upvalues: u5 (ref), u38 (ref), u20 (copy), u21 (copy), u8 (ref), u22 (copy)
                u5:SetTitle(u38.DisplayName or u20);
                local v41 = u38.Description or "...";

                if typeof(v41) == "function" then
                    v41 = v41(u21);
                end;

                u5:SetText(v41);
                u5:Show();
                u8 = u22;
            end);
            u34:Connect(u22.Register.MouseLeave, function(p42, p43) -- Line: 223
                -- upvalues: u5 (ref), u8 (ref)
                u5:Hide();
                u8 = nil;
            end);
            u22.Visible = true;

            return u20, u22;
        end, Fusion.cleanup),
        Visible = Fusion.Computed(function() -- Line: 234
            -- upvalues: u7 (copy)
            return u7:get() > 0;
        end)
    });
    CombatService.Remotes.StatusEffect:Connect(function(p44) -- Line: 240
        -- upvalues: LocalPlayer (ref), Players (ref), AddEffect (copy), u6 (copy), u7 (copy)
        local v45 = p44[1];
        local v46 = p44[2];

        if v46.Player then
            if v46.Player and v46.Player ~= LocalPlayer then
                return;
            end;
        elseif Players:GetPlayerFromCharacter(v46.Character) ~= LocalPlayer then
            return;
        end;

        if v45 == "Added" then
            AddEffect(v46.Name, {
                Duration = v46.Duration,
                CustomPriority = v46.Priority,
                Metadata = v46.Metadata
            });

            return;
        end;

        if v45 ~= "Stacked" then
            if v45 == "Removed" then
                local Name = v46.Name;
                local v47 = u6:get();

                if not v47[Name] then
                    return;
                end;

                v47[Name] = nil;
                u6:set(v47);
                u7:set(u7:get() - 1);
            end;

            return;
        end;

        local Name = v46.Name;
        local v48 = {
            Duration = v46.Duration,
            CustomPriority = v46.Priority,
            Metadata = v46.Metadata
        };

        if v48.Explicit and not u6:get()[Name] then
            return;
        end;

        AddEffect(Name, v48);
    end);

    function p4.EmitStatusIndicatorEvent(p49, p50, p51) -- Line: 272
        -- upvalues: AddEffect (copy), u6 (copy), u7 (copy)
        local _ = p51.Character;

        if p50 == "Add" then
            AddEffect(p51.Name, {
                Duration = p51.Duration,
                CustomPriority = p51.Priority,
                Metadata = p51.Metadata
            });

            return;
        end;

        if p50 ~= "Update" then
            if p50 == "Remove" then
                local Name = p51.Name;
                local v52 = u6:get();

                if not v52[Name] then
                    return;
                end;

                v52[Name] = nil;
                u6:set(v52);
                u7:set(u7:get() - 1);
            end;

            return;
        end;

        local Name = p51.Name;
        local v53 = {
            Explicit = p51.Explicit,
            Duration = p51.Duration,
            CustomPriority = p51.Priority,
            Metadata = p51.Metadata
        };

        if v53.Explicit and not u6:get()[Name] then
            return;
        end;

        AddEffect(Name, v53);
    end;
end;