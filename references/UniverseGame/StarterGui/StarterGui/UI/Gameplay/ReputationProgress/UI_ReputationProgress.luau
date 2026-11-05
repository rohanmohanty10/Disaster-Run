  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");

function InvLerp(p1, p2, p3)
    return (p3 - p1) / (p2 - p1);
end;

local function TweenCallback(p4, p5, u6, p7, p8, p9, p10, p11, p12) -- Line: 14
    -- upvalues: TweenService (copy)
    local v13 = TweenService:Create(p4, TweenInfo.new(p7 or 0.5, p8 or Enum.EasingStyle.Quad, p9 or Enum.EasingDirection.Out, p10 or 0, p11 or false, p12 or 0), p5);
    v13.Completed:Connect(function() -- Line: 24
        -- upvalues: u6 (copy)
        if u6 then
            u6();
        end;
    end);
    v13:Play();
end;

local u14 = UDim2.new(0.5, 0, 1.2, 0);
local u15 = UDim2.new(0.5, 0, 0.9, 0);

return function(u16) -- Line: 33
    -- upvalues: ReplicatedStorage (copy), u15 (copy), u14 (copy), TweenCallback (copy)
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);

    if Core.Flags.DisableLab then
        return;
    end;

    Core.OnStart():await();
    u16.Knit.GetService("InventoryService");
    u16.Knit.GetService("ShopService");
    local v17 = Core.GetClientService("LabService");
    local Parent = script.Parent;
    local RankUpGlow = Parent.RankUpGlow;
    local Progress = Parent.Progress;
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    require(PathShortcuts.KnitPath.Trove);
    require(ReplicatedStorage.ReplicatedModules.Types);
    local ReputationInfo = require(ReplicatedStorage.ReplicatedModules.PVEPackage.LabData.ReputationInfo);
    local ClientUIOutput = ReplicatedStorage.Remotes.ClientUIOutput;
    local u18 = nil;
    local u19 = Fusion.Value(false);
    local u20 = Fusion.Value(1);
    local u21 = Fusion.Value(0);
    local u22 = Fusion.Spring(Fusion.Computed(function() -- Line: 60
        -- upvalues: u19 (copy), u15 (ref), u14 (ref)
        return u19:get() and u15 or u14;
    end), 20, 0.65);
    local u23 = 0;

    local function Show(p24) -- Line: 66
        -- upvalues: u18 (ref), u23 (ref), u19 (copy)
        if u18 then
            task.cancel(u18);
            u18 = nil;
        end;

        if p24 then
            u23 = u23 + p24;
        end;

        local _ = p24 and u23 > 0;
        u19:set(true);

        if u23 == 0 then
            u18 = task.delay(p24 and 0.5 or 3, function() -- Line: 79
                -- upvalues: u19 (ref), u18 (ref)
                u19:set(false);
                u18 = nil;
            end);
        end;
    end;

    local function UpdateInfo(p25) -- Line: 86
        -- upvalues: u20 (copy), u21 (copy)
        if typeof(p25) == "table" then
            u20:set(p25.Rank);
            u21:set(p25.Amount);
        end;
    end;

    local function GetProgress(p26, p27) -- Line: 93
        -- upvalues: ReputationInfo (copy)
        if not p26 then
            return 0;
        end;

        local v28 = ReputationInfo.Requirements[p26];
        local v29 = ReputationInfo.Requirements[p26 + 1];

        if not v28 then
            return 0;
        end;

        if not v29 then
            return 1;
        end;

        local v30 = InvLerp(v28, v29, p27);

        return math.clamp(v30, 0, 1);
    end;

    Fusion.Hydrate(Parent)({
        Position = u22,
        Visible = Fusion.Computed(function() -- Line: 110
            -- upvalues: u19 (copy), u22 (copy), u14 (ref)
            return u19:get() and true or u22:get() ~= u14;
        end)
    });
    Fusion.Hydrate(Progress.Rep)({
        Text = Fusion.Computed(function() -- Line: 122
            -- upvalues: u21 (copy)
            return u21:get() or "-";
        end)
    });
    Fusion.Hydrate(Progress.Bar)({
        Size = Fusion.Tween(Fusion.Computed(function() -- Line: 129
            -- upvalues: u21 (copy), u20 (copy), ReputationInfo (copy)
            local v31 = u21:get();
            local v32 = u20:get();
            local v33;

            if v32 then
                local v34 = ReputationInfo.Requirements[v32];
                local v35 = ReputationInfo.Requirements[v32 + 1];

                if v34 then
                    if v35 then
                        local v36 = InvLerp(v34, v35, v31);
                        v33 = math.clamp(v36, 0, 1);
                    else
                        v33 = 1;
                    end;
                else
                    v33 = 0;
                end;
            else
                v33 = 0;
            end;

            return UDim2.fromScale(v33, 1);
        end), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0.1))
    });
    Fusion.Hydrate(Progress.Bar.Gradient)({
        Offset = Fusion.Spring(Fusion.Computed(function() -- Line: 138
            -- upvalues: u21 (copy), u20 (copy), ReputationInfo (copy)
            local v37 = u21:get();
            local v38 = u20:get();
            local v39;

            if v38 then
                local v40 = ReputationInfo.Requirements[v38];
                local v41 = ReputationInfo.Requirements[v38 + 1];

                if v40 then
                    if v41 then
                        local v42 = InvLerp(v40, v41, v37);
                        v39 = math.clamp(v42, 0, 1);
                    else
                        v39 = 1;
                    end;
                else
                    v39 = 0;
                end;
            else
                v39 = 0;
            end;

            return Vector2.new(1 - v39, 0);
        end), 15, 0.95)
    });
    Fusion.Hydrate(Progress.Current.Rank)({
        Text = Fusion.Computed(function() -- Line: 148
            -- upvalues: u20 (copy), ReputationInfo (copy)
            local v43 = u20:get();

            return ReputationInfo.Ranks[v43] or "-";
        end)
    });
    Fusion.Hydrate(Progress.Current.Rep)({
        Text = Fusion.Computed(function() -- Line: 155
            -- upvalues: u20 (copy), ReputationInfo (copy)
            local v44 = u20:get();

            return ReputationInfo.Requirements[v44] or "-";
        end)
    });
    Fusion.Hydrate(Progress.Next.Rank)({
        Text = Fusion.Computed(function() -- Line: 163
            -- upvalues: u20 (copy), ReputationInfo (copy)
            local v45 = u20:get() + 1;

            return ReputationInfo.Ranks[v45] or "-";
        end)
    });
    Fusion.Hydrate(Progress.Next.Rep)({
        Text = Fusion.Computed(function() -- Line: 170
            -- upvalues: u20 (copy), ReputationInfo (copy)
            local v46 = u20:get() + 1;

            return ReputationInfo.Requirements[v46] or "-";
        end)
    });
    v17.ReputationUpdated:Connect(function(p47, p48) -- Line: 177
        -- upvalues: ClientUIOutput (copy), u20 (copy), u16 (copy), RankUpGlow (copy), TweenCallback (ref), u21 (copy), Show (copy)
        if p48 > 0 then
            ClientUIOutput:Fire("CreateMiddleNotification", {
                NumericalSuffix = "REP",
                Verb = "",
                Subject = "REPUTATION ADDED",
                NumericalContent = p48,
                SubjectColor = Color3.fromRGB(255, 216, 138),
                NumericalContentColor = Color3.fromRGB(255, 184, 97)
            });
        end;

        if u20:get() < p47.Rank then
            u16:PlaySound("Lab/RepRankUp");
            RankUpGlow.ImageTransparency = 1;
            RankUpGlow.Size = UDim2.fromScale(1, 1);
            TweenCallback(RankUpGlow, {
                ImageTransparency = 0
            }, function() -- Line: 199
                -- upvalues: TweenCallback (ref), RankUpGlow (ref)
                TweenCallback(RankUpGlow, {
                    ImageTransparency = 1,
                    Size = UDim2.fromScale(1.25, 1.25)
                }, function() -- Line: 203
                    -- upvalues: RankUpGlow (ref)
                    RankUpGlow.Size = UDim2.fromScale(1, 1);
                end, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            end, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end;

        u16:PlaySound("Lab/RepUp");

        if typeof(p47) == "table" then
            u20:set(p47.Rank);
            u21:set(p47.Amount);
        end;

        Show();
    end);

    function u16.ShowReputationProgress(p49, p50) -- Line: 223
        -- upvalues: Show (copy)
        Show(p50);
    end;

    local v51 = v17:GetReputationInfo():expect();

    if typeof(v51) == "table" then
        u20:set(v51.Rank);
        u21:set(v51.Amount);
    end;
end;