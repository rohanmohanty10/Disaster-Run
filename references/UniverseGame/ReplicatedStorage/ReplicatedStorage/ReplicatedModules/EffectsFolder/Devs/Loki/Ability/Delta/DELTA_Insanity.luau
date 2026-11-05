  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local ReplicatedRoot = ReplicatedStorage.ReplicatedRoot;
require(ReplicatedStorage.ReplicatedModules.Types);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.StatsHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
task.wait(0.25);
local CombatService = require(ReplicatedRoot.Services.CombatService);
Knit.GetService("MoveService");
local LocalPlayer = Players.LocalPlayer;

local function _(p1, p2) -- Line: 34
    return Random.new():NextNumber(p1, p2);
end;

local u3 = _G.Petal("Util");

return function(u4, p5) -- Line: 41
    -- upvalues: LocalPlayer (copy), Trove (copy), Fusion (copy), AssetHandler (copy), ParticleHandler (copy), RunService (copy), CombatService (copy), Lighting (copy), u3 (copy)
    local Character = LocalPlayer.Character;

    if not (Character and Character.Parent) then
        return;
    end;

    local Ref = p5.Ref;

    if not (Ref and Ref.Parent) then
        return;
    end;

    local v6 = Trove.new();
    v6:AttachToInstance(Ref);
    v6:AttachToInstance(Character);
    local u7 = v6:Extend();
    local CurrentCamera = workspace.CurrentCamera;
    local u8 = Fusion.Value(Ref:GetAttribute("Stage") or 1);
    local v9 = AssetHandler.GetAbilityData(u4);
    local u10 = AssetHandler.CloneAsset("Particles/Insanity/InsanityOverlay", v9);
    u10.Parent = workspace.Effects;
    ParticleHandler.Unusualify(u10, {
        Character = u4
    });
    v6:Add(function() -- Line: 69
        -- upvalues: ParticleHandler (ref), u10 (copy), RunService (ref)
        local v11 = ParticleHandler.GetMaxLifetime(u10);
        ParticleHandler.EnableAllParticles(u10, false);
        task.delay(v11, function() -- Line: 74
            -- upvalues: u10 (ref), RunService (ref)
            u10:Destroy();
            RunService:UnbindFromRenderStep("InsanityVFX");
        end);
    end);

    local function ComputeFrustum(p12) -- Line: 80
        -- upvalues: CurrentCamera (copy)
        local v13 = math.rad(CurrentCamera.FieldOfView);
        local v14 = CurrentCamera.ViewportSize.X / CurrentCamera.ViewportSize.Y;
        local v15 = p12 * 2 * math.tan(v13 / 2);

        return v15 * v14, v15;
    end;

    local function UpdateSounds() -- Line: 90
        -- upvalues: u7 (copy), u8 (copy), CombatService (ref), u4 (copy), Character (copy)
        u7:Clean();
        local v16 = u8:get();
        local v17 = CombatService.FetchSound(u4, (`Insanity {v16}`));

        if typeof(v17) == "Instance" then
            local v18 = u7:Clone(v17);
            v18.Parent = Character;
            CombatService.SoftPlaySound(v18, nil, 0.35);
        end;
    end;

    RunService:BindToRenderStep("InsanityVFX", Enum.RenderPriority.Camera.Value + 6, function(p19) -- Line: 104
        -- upvalues: CurrentCamera (copy), u10 (copy)
        local v20 = math.rad(CurrentCamera.FieldOfView);
        local v21 = CurrentCamera.ViewportSize.X / CurrentCamera.ViewportSize.Y;
        local v22 = math.tan(v20 / 2) * 10;
        u10.Size = Vector3.new(v22 * v21, v22, 0.1);
        u10.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, -5);
    end);

    for _, descendant in u10:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            local u23 = descendant:GetAttribute("Stage");

            if u23 then
                Fusion.Hydrate(descendant)({
                    Enabled = Fusion.Computed(function() -- Line: 117
                        -- upvalues: descendant (copy), u8 (copy), u23 (copy)
                        if descendant:GetAttribute("Explicit") then
                            return u8:get() == u23;
                        end;

                        return u23 <= u8:get();
                    end)
                });
            end;
        end;
    end;

    local u26 = Fusion.New("ColorCorrectionEffect")({
        Parent = Lighting,
        Contrast = Fusion.Spring(Fusion.Computed(function() -- Line: 129
            -- upvalues: u8 (copy)
            local v24 = u8:get();

            return v24 == 1 and 0.1 or (v24 == 2 and 0.2 or (v24 == 3 and 0.4 or 0.1));
        end), 10, 0.9),
        Brightness = Fusion.Spring(Fusion.Computed(function() -- Line: 133
            -- upvalues: u8 (copy)
            local v25 = u8:get();

            return v25 == 1 and -0.05 or (v25 == 2 and -0.1 or (v25 == 3 and -0.2 or 0));
        end), 10, 0.9)
    });
    v6:Add(function() -- Line: 139
        -- upvalues: u3 (ref), u26 (copy)
        u3.Tween(u26, 1, "Quad", "InOut", {
            Contrast = 0,
            Brightness = 0
        });
        task.delay(1, function() -- Line: 141
            -- upvalues: u26 (ref)
            u26:Destroy();
        end);
    end);
    UpdateSounds();
    v6:Connect(Ref:GetAttributeChangedSignal("Stage"), function() -- Line: 147
        -- upvalues: u8 (copy), Ref (copy), UpdateSounds (copy)
        u8:set(Ref:GetAttribute("Stage"));
        UpdateSounds();
    end);
end;