  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);
local u2 = Random.new();

return function(p3) -- Line: 17
    -- upvalues: AssetHandler (copy), TweenService (copy), u1 (ref), u2 (copy), ParticleHandler (copy)
    local v4 = p3 or {};
    local Character = v4.Character;
    local Player = v4.Player;
    local Velocity = v4.Velocity;

    if not (Character and Velocity) then
        return;
    end;

    local HumanoidRootPart = Character.HumanoidRootPart;
    local v5 = AssetHandler.GetAbilityData(Player);
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineTransparency = 1;
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = Character;
    local v6 = TweenService:Create(Highlight, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        FillTransparency = 1
    });
    v6.Completed:Connect(function() -- Line: 40
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);
    v6:Play();
    local v7 = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Velocity.Unit);
    u1.CallEffect("Emit Particle V3", {
        Path = "Particles/Geppo/Launch",
        AutoSerialize = true,
        Origin = v7 * CFrame.Angles(-1.5707963267948966, 0, 0),
        Player = Player
    });

    if game.Players.LocalPlayer == Player then
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, true), {
            FieldOfView = 75
        }):Play();
    end;

    for _ = 6, math.random(8, 10) do
        local v8 = u2:NextNumber(-1.5, 1.5);
        local v9 = u2:NextNumber(-1.5, 1.5);
        local u10 = AssetHandler.CloneAsset("Particles/Geppo/Puff", v5);
        local v11 = u2:NextNumber(0.5, 1.1);
        local v12 = u2:NextNumber(0.5, 1.1);
        u10.Size = Vector3.new(v11, v12, u2:NextNumber(0.5, 1.1));
        local v13 = v7 * CFrame.new(v8, v9, u2:NextNumber(-0.5, 0.5));
        local Angles = CFrame.Angles;
        local v14 = math.random(-180, 180);
        local v15 = math.rad(v14);
        local v16 = math.random(-180, 180);
        local v17 = math.rad(v16);
        local v18 = math.random(-180, 180);
        u10.CFrame = v13 * Angles(v15, v17, (math.rad(v18)));
        u10.Parent = workspace.Effects;
        local v19 = TweenInfo.new(u2:NextNumber(0.45, 0.85), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        local v20 = {
            Transparency = 1
        };
        local v21 = v7 * CFrame.new(v8 * u2:NextNumber(1.5, 2), v9 * u2:NextNumber(1.5, 2), u2:NextNumber(2, 10));
        local Angles2 = CFrame.Angles;
        local v22 = math.random(-180, 180);
        local v23 = math.rad(v22);
        local v24 = math.random(-180, 180);
        local v25 = math.rad(v24);
        local v26 = math.random(-180, 180);
        v20.CFrame = v21 * Angles2(v23, v25, (math.rad(v26)));
        local v27 = TweenService:Create(u10, v19, v20);
        v27:Play();
        v27.Completed:Connect(function() -- Line: 74
            -- upvalues: u10 (copy)
            u10:Destroy();
        end);
    end;

    local u28 = {};

    for _, v in { "Right Arm", "Right Leg", "Left Arm", "Left Leg" } do
        local v29 = Character[v];
        local v30 = AssetHandler.CloneAsset("Particles/Geppo/WindTrail", v5);
        v30.Parent = Character;
        ParticleHandler.AttachTo(v30, {
            Part = v29
        });
        table.insert(u28, v30);
    end;

    task.delay(0.3, function() -- Line: 94
        -- upvalues: u28 (copy), ParticleHandler (ref)
        for _, v in u28 do
            task.delay(1, v.Destroy, v);
            ParticleHandler.EnableAllParticles(v, false);
        end;
    end);
end;