  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();

return function(p1) -- Line: 11
    -- upvalues: ParticleHandler (copy), EffectsHandler (copy), AssetHandler (copy), TweenService (copy)
    local v2 = p1 or {};

    if not v2.HSVData then
        ParticleHandler.GetUnusualHSVData({
            Player = v2.Player or v2.AttackerPlayer,
            Character = v2.Character or v2.Attacker
        });
    end;

    local Character = v2.Character;
    local Start = v2.Start;
    local End = v2.End;
    local _ = v2.Midpoint;
    local v3 = End.Position - Start.Position;
    local Magnitude = v3.Magnitude;
    local v4 = Magnitude > 0 and v3.Unit or Start.LookVector;
    local PathData = v2.PathData;
    local v5;

    if PathData then
        v5 = PathData.AbilityName;
    else
        v5 = PathData;
    end;

    local v6;

    if v5 then
        v6 = nil;
    else
        v6 = Character;
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        VFXForgeEmit = true,
        Path = "Particles/General/Dash",
        Character = v6,
        Origin = Start:Lerp(End, 0.5),
        AbilityName = v5
    });
    EffectsHandler.CallEffect("Kars_Coil", {
        Amount = 3,
        Height = 2,
        Radius = 20,
        Duration = 0.4,
        Origin = Start * CFrame.Angles(-1.5707963267948966, 0, 0),
        Degree = Vector2.new(5, 7.25),
        Trail = AssetHandler.GetAsset("Particles/General/CoilTrail", PathData or AssetHandler.GetAbilityData(Character)),
        Character = v6
    });

    if Character and Character:GetAttribute("Awakened") then
        EffectsHandler.CallEffect("Rock Trail", {
            Offset = 6.5,
            Size = 2,
            Duration = 5,
            DurationOffset = 0.1,
            Down = true,
            Origin = Start,
            LookVector = v4,
            Distance = Magnitude,
            Amount = math.ceil(Magnitude / 2.35)
        });
    end;

    EffectsHandler.Wait(0.15);
    local CFrame2 = Character.HumanoidRootPart.CFrame;
    local v7 = v2.TweenDelay or 0;
    local v8 = v2.Lifetime or 0.18;
    local Model = Instance.new("Model");
    task.delay(v8 + v7, Model.Destroy, Model);
    local v9 = Instance.fromExisting(Character.HumanoidRootPart);
    v9.Anchored = true;
    v9.CFrame = CFrame2;
    v9.Parent = Model;
    Model.PrimaryPart = v9;
    local v10 = next;
    local v11, v12 = Character:GetChildren();

    for _, v in v10, v11, v12 do
        if not v:IsA("Model") and (not v:IsA("LuaSourceContainer") and (not v:IsA("Folder") and v.Archivable)) then
            local v13 = v:Clone();
            local v14 = next;
            local v15, v16 = v13:GetDescendants();

            for _, v17 in v14, v15, v16 do
                if v17:IsA("Sound") or (v17:IsA("ParticleEmitter") or (v17:IsA("Trail") or (v17:IsA("LuaSourceContainer") or (v17:IsA("Folder") or (v17:IsA("Motor6D") or v17:IsA("Weld") and v17.Name ~= "AfterimageWeld"))))) or v17:IsA("BillboardGui") then
                    v17:Destroy();
                end;
            end;

            if v13:IsA("Humanoid") then
                v13.DisplayDistanceType = "None";
                v13.HealthDisplayType = "AlwaysOff";
                v13.BreakJointsOnDeath = false;
                v13.EvaluateStateMachine = false;
                v13.RequiresNeck = false;
                v13.AutomaticScalingEnabled = false;
            end;

            if v13:IsA("Accessory") then
                v13 = v13:FindFirstChild("handle") or v13:FindFirstChild("Handle");
                local v = v:FindFirstChild("handle") or v:FindFirstChild("Handle");
            end;

            if v13:IsA("BasePart") and v13.Transparency < 1 then
                v13.CollisionGroup = "FX";
                v13.CanCollide = false;
                v13.CanQuery = false;
                v13.Anchored = false;
                v13.CastShadow = false;
                v13.CFrame = CFrame2 * CFrame2:ToObjectSpace(v.CFrame);
                local ManualWeld = Instance.new("ManualWeld");
                ManualWeld.Name = "AfterimageWeld";
                ManualWeld.Part0 = v13;
                ManualWeld.Part1 = v9;
                ManualWeld.C0 = ManualWeld.Part0.CFrame:ToObjectSpace(ManualWeld.Part1.CFrame);
                ManualWeld.Parent = v9;
                local v17 = TweenService:Create(v13, TweenInfo.new(v8 * 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, v8 * 0.75), {
                    Transparency = 1
                });
                task.delay(v7, v17.Play, v17);
            end;

            v13.Parent = Model;
        end;
    end;

    Model.Parent = workspace.Effects;
    Model.PrimaryPart.CFrame = Start;
    TweenService:Create(Model.PrimaryPart, TweenInfo.new(v8, Enum.EasingStyle.Linear), {
        CFrame = End
    }):Play();
end;