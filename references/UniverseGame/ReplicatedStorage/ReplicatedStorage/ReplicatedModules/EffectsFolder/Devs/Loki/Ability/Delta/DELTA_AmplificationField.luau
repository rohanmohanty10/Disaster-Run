  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.New;
local u2 = Random.new();

local function Rng(p3, p4) -- Line: 41
    -- upvalues: u2 (copy)
    return u2:NextNumber(p3, p4);
end;

local function GetCurveSize(p5) -- Line: 45
    return p5 * 4 / 3;
end;

local _ = Players.LocalPlayer;
local u6 = {};
local u7 = false;

local function DestroyEntry(u8) -- Line: 53
    -- upvalues: u6 (copy), AssetHandler (copy), u7 (ref)
    if u8 and u6[u8] then
        task.spawn(AssetHandler.ScaleAsset, u6[u8].MainEffect, {
            Scale = 0.02,
            TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        });
        task.delay(0.5, function() -- Line: 56
            -- upvalues: u6 (ref), u8 (copy), u7 (ref)
            u6[u8].Trove:Destroy();
            u6[u8] = nil;

            if not next(u6) and u7 then
                u7 = false;
            end;
        end);
    end;
end;

local function ToggleEffects(p9, p10) -- Line: 67
    -- upvalues: ParticleHandler (copy)
    for _, child in p9:GetChildren() do
        ParticleHandler.EnableAllParticles(child, string.find(child.Name, (`Level{p10}`)) ~= nil);
    end;
end;

local function HydrateBeams(p11, p12, p13) -- Line: 73
    -- upvalues: Fusion (copy)
    local RadiusState = p12.RadiusState;
    local v14 = p11:FindFirstChild((`Beams_Level{p13}`));
    local v15 = Fusion.Computed(function() -- Line: 77
        -- upvalues: RadiusState (copy)
        return RadiusState:get() * 4 / 3;
    end);

    for _, child in p11:FindFirstChild("A_Attachs"):GetChildren() do
        child.Position = Vector3.new(0, 0, 1) * (child.Name == "A1" and -RadiusState:get() or RadiusState:get());
    end;

    for _, child in p11:FindFirstChild("B_Attachs"):GetChildren() do
        child.Position = Vector3.new(0, 0, 1) * (child.Name == "B1" and -RadiusState:get() or RadiusState:get());
    end;

    for _, child in v14:GetChildren() do
        child.CurveSize0 = string.find(child.Name, "01") and -v15:get() or v15:get();
        child.CurveSize1 = string.find(child.Name, "01") and v15:get() or -v15:get();
    end;
end;

return function(p16, p17, p18) -- Line: 123
    -- upvalues: DestroyEntry (copy), AssetHandler (copy), u6 (copy), Trove (copy), ParticleHandler (copy), Fusion (copy), ToggleEffects (copy), HydrateBeams (copy), u7 (ref)
    if not (p16 and p16.Parent) then
        DestroyEntry(p16);

        return;
    end;

    local v19 = AssetHandler.GetAbilityData(p16);

    if p17 == "Create" and not u6[p16] then
        local HumanoidRootPart = p16:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        if not (p18 and p18.Level) then
            return;
        end;

        local v20 = Trove.new();
        v20:AttachToInstance(p16);
        local v21 = AssetHandler.CloneAsset("Particles/Ultimate/AmplifyZone", v19);
        ParticleHandler.Unusualify(v21, {
            HSVData = p18.HSVData
        });

        if p18.HSVData and p18.HSVData.Chroma then
            ParticleHandler.Chromaify(v21, {
                Character = p16
            });
        end;

        v20:Add(v21);
        local u22 = Fusion.Value(p18.Radius or 20);
        v20:Add(function() -- Line: 153
            -- upvalues: u22 (ref)
            task.delay(0.03333333333333333, function() -- Line: 154
                -- upvalues: u22 (ref)
                u22 = nil;
            end);
        end);
        ToggleEffects(v21, p18.Level);
        v21.Position = HumanoidRootPart.Position;
        u6[p16] = {
            Trove = v20,
            MainEffect = v21,
            Root = HumanoidRootPart,
            RadiusState = u22
        };
        HydrateBeams(v21, u6[p16], p18.Level);
        ParticleHandler.ScaleParticle(v21, u22:get() / 20);
        v21.Parent = workspace.Effects;
        AssetHandler.ScaleAsset(v21, {
            Scale = 0.05
        });
        task.defer(AssetHandler.ScaleAsset, v21, {
            Scale = 20,
            TweenInfo = TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
        });
    elseif p17 == "Update" and u6[p16] then
        local v23 = u6[p16];
        ToggleEffects(v23.MainEffect, p18.Level or 1);
        HydrateBeams(v23.MainEffect, v23, p18.Level or 1);
    elseif p17 == "Destroy" and u6[p16] then
        DestroyEntry(p16);
    end;

    if not u7 and next(u6) then
        u7 = true;

        while u7 do
            local v24 = task.wait();

            for _, v in u6 do
                v.MainEffect.Position = v.MainEffect.Position:Lerp(v.Root.Position - Vector3.new(0, 2.8, 0), v24 * 35);
            end;
        end;
    end;
end;