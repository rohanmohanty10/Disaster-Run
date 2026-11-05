  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);

if require(ReplicatedStorage.ReplicatedRoot.Core).Flags.DisableRegionService or PathShortcuts.LinkedPlaces[game.GameId].GameModePlace == game.PlaceId then
    return {};
end;

local u1 = Knit.CreateController({
    Name = "MappedRegionsController",
    _Cooldown = false,
    _CurrentRegion = "None",
    _CurrentAmbientParticleObject = nil,
    _Lighting = {}
});
local MappedRegions = workspace:WaitForChild("MappedRegions");
local u2 = OverlapParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { MappedRegions };
local CurrentCamera = workspace.CurrentCamera;

function u1.GetRegionForCharacter(p3, p4) -- Line: 31
    -- upvalues: u2 (copy)
    local HumanoidRootPart = p4:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return nil;
    end;

    local v5, v6, v7;
    v5, v6, v7 = workspace:GetPartsInPart(HumanoidRootPart, u2), nil, nil;
    local v8, v9, v10;

    if type(v5) == "function" then
        v8, v9 = v5(v6, v10);
    else
        v8, v9 = next(v5, v10);
    end;

    v10 = v8;

    return v9;
end;

function u1.GetCurrentRegion(p11) -- Line: 40
    -- upvalues: u1 (copy)
    return u1._CurrentRegion;
end;

function u1.SetCurrentRegion(p12, p13) -- Line: 44
    -- upvalues: u1 (copy)
    u1._CurrentRegion = p13;
end;

function u1.GetCharacter(p14) -- Line: 48
    return game.Players.LocalPlayer.Character;
end;

function u1.SetAmbientParticleObject(p15, p16) -- Line: 52
    -- upvalues: u1 (copy), PathShortcuts (copy)
    if u1._CurrentAmbientParticleObject then
        local _CurrentAmbientParticleObject = u1._CurrentAmbientParticleObject;
        u1._CurrentAmbientParticleObject = nil;

        for _, descendant in _CurrentAmbientParticleObject:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        print("Destroying previous");
        task.delay(10, _CurrentAmbientParticleObject.Destroy, _CurrentAmbientParticleObject);
    end;

    local v17 = PathShortcuts.ClientAssets.AmbientParticles:FindFirstChild(p16 or "");

    if v17 then
        local v18 = v17:Clone();
        v18.Parent = workspace;
        v18.Name = "AmbientParticles";
        u1._CurrentAmbientParticleObject = v18;

        return v18;
    end;
end;

function u1.SetLightingSettings(p19, p20) -- Line: 80
    -- upvalues: u1 (copy)
    for _, v in u1._Lighting do
        v:Destroy();
    end;

    table.clear(u1._Lighting);

    if not p20 then
        return;
    end;

    for _, v in p20 do
        local v21 = v:Clone();
        v21.Parent = game:GetService("Lighting");
        table.insert(u1._Lighting, v21);
    end;
end;

function u1.UpdateAmbientParticleObject(p22) -- Line: 98
    -- upvalues: u1 (copy), CurrentCamera (copy)
    local _CurrentAmbientParticleObject = u1._CurrentAmbientParticleObject;

    if not _CurrentAmbientParticleObject then
        return;
    end;

    _CurrentAmbientParticleObject.CFrame = CFrame.new(CurrentCamera.CFrame.Position);
end;

local function GetTableFromInstance(p23) -- Line: 107
end;

function u1.GetBannerDataFromRegionObject(p24, p25) -- Line: 111
    -- upvalues: u1 (copy)
    local v26 = {};

    for _, child in p25:GetChildren() do
        local Name = child.Name;
        local v27 = child.ClassName:find("Value") and child.Value;
        local child;

        if v27 then
            child = v27;
        elseif child:IsA("Folder") then
            child = u1:GetBannerDataFromRegionObject(child) or child;
        end;

        v26[Name] = child;
    end;

    return v26;
end;

function u1.DisplayRegionBanner(p28, p29) -- Line: 125
    -- upvalues: u1 (copy)
    if u1:GetRegionBannerCooldown() then
        return;
    end;

    u1:SetRegionBannerCooldown(5);
    local v30 = u1:GetBannerDataFromRegionObject(p29);
    u1:PlayBannerSound();
    u1:ShowBanner(v30);
end;

function u1.PlayBannerSound(p31) -- Line: 138
    script.ug_newarea:Play();
end;

function u1.ShowBanner(p32, u33) -- Line: 142
    -- upvalues: Trove (copy), TweenService (copy)
    local _ = u33.RegionName;
    local _ = u33.RegionDescription;
    local _ = u33.RegionLevelRecommendation;
    local MappedRegionsBanner = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UI"):WaitForChild("Gameplay"):WaitForChild("MappedRegionsBanner");
    local RegionAmbience = require(MappedRegionsBanner.Assets.RegionAmbience);
    local u34 = Trove.new();
    local u35 = MappedRegionsBanner.Assets.Banner:Clone();
    u35.Visible = true;
    u35.Parent = MappedRegionsBanner;
    u34:Add(u35);
    RegionAmbience:ChangeTo(u33.RegionName);
    task.spawn(function() -- Line: 160
        -- upvalues: u34 (copy), TweenService (ref), u35 (copy), u33 (copy)
        local v36 = u34:Add(TweenService:Create(u35, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0, 0)
        }));
        v36:Play();
        v36.Completed:Wait();
        u34:Add(TweenService:Create(u35.LeftChevron, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.367, 0.077)
        })):Play();
        u34:Add(TweenService:Create(u35.RightChevron, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.582, 0.077)
        })):Play();
        u34:Add(TweenService:Create(u35.LeftBlocker, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(0, 0)
        })):Play();
        local v37 = u34:Add(TweenService:Create(u35.RightBlocker, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(0, 0)
        }));
        v37:Play();
        u34:Add(TweenService:Create(u35.LeftBlocker.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            Transparency = 1
        })):Play();
        u34:Add(TweenService:Create(u35.RightBlocker.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            Transparency = 1
        })):Play();
        local Size = u35.RegionBanner.MiddleSplitter.Size;
        u35.RegionBanner.Size = UDim2.fromScale(0, 0);
        u35.RegionBanner.MiddleSplitter.Size = UDim2.new(0, 0, 0, 0);

        for i, v in u33 do
            local v38 = u35.RegionBanner:FindFirstChild(i);

            if v38 then
                v38.TextTransparency = 1;

                if i == "RegionLevelRecommendation" then
                    v38.Text = `Recommended Level: {v}`;
                elseif i == "RegionDescription" then
                    v38.Text = `"{v}"`;
                else
                    v38.Text = v;
                end;
            end;
        end;

        v37.Completed:Wait();
        local v39 = u34:Add(TweenService:Create(u35.RegionBanner, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(0.162, 0.065)
        }));
        v39:Play();
        v39.Completed:Wait();
        u34:Add(TweenService:Create(u35.RegionBanner.MiddleSplitter, TweenInfo.new(0.45, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            Size = Size
        })):Play();

        for i, _ in u33 do
            local u40 = u35.RegionBanner:FindFirstChild(i);

            if u40 then
                local Scale = u40.Position.Y.Scale;
                local Scale2 = u40.Position.X.Scale;
                u40.Position = UDim2.fromScale(Scale2, Scale + 0.05);
                local v41 = math.clamp(u40.Position.Y.Scale, 0, 1) / 2;
                task.delay(v41, function() -- Line: 245
                    -- upvalues: u34 (ref), TweenService (ref), u40 (copy), Scale2 (copy), Scale (copy)
                    u34:Add(TweenService:Create(u40, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        TextTransparency = 0,
                        MaxVisibleGraphemes = utf8.len(u40.Text),
                        Position = UDim2.fromScale(Scale2, Scale)
                    })):Play();
                end);
            end;
        end;

        task.wait(2.5);
        local v42 = u34:Add(TweenService:Create(u35, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(0, -0.2)
        }));
        v42:Play();
        v42.Completed:Wait();
        u34:Destroy();
    end);
end;

function u1.GetRegionBannerCooldown(p43) -- Line: 269
    -- upvalues: u1 (copy)
    return u1._Cooldown;
end;

function u1.SetRegionBannerCooldown(p44, p45) -- Line: 273
    -- upvalues: u1 (copy)
    u1._Cooldown = true;
    task.delay(p45, function() -- Line: 275
        -- upvalues: u1 (ref)
        u1._Cooldown = false;
    end);
end;

function u1.Stepped(p46, p47) -- Line: 280
    -- upvalues: u1 (copy), u2 (copy), MappedRegions (copy)
    local v48 = u1:GetCharacter();

    if not v48 then
        return;
    end;

    u1:UpdateAmbientParticleObject();
    u2.FilterDescendantsInstances = { MappedRegions };
    local v49 = u1:GetRegionForCharacter(v48);

    if not v49 then
        return;
    end;

    local v50 = u1:GetBannerDataFromRegionObject(v49);
    local RegionName = v50.RegionName;
    local _ = v50.RegionAmbientParticle;
    local Lighting = v50.Lighting;

    if not RegionName then
        return;
    end;

    if u1:GetRegionBannerCooldown() then
        return;
    end;

    if RegionName ~= u1:GetCurrentRegion() then
        u1:SetCurrentRegion(RegionName);
        u1:DisplayRegionBanner(v49);
        u1:SetLightingSettings(Lighting);
    end;
end;

function u1.KnitStart(p51) -- Line: 317
    -- upvalues: RunService (copy), u1 (copy)
    local u52 = 0;
    RunService.Heartbeat:Connect(function(p53) -- Line: 321
        -- upvalues: u52 (ref), u1 (ref)
        u52 = u52 + p53;

        if u52 < 0.6666666666666666 then
            return;
        end;

        u52 = 0;
        u1:Stepped(p53);
    end);
end;

return u1;