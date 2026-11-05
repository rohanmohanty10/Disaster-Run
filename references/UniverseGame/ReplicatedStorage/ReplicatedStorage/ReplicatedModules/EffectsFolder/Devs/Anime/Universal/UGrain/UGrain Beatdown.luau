  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 18
    -- upvalues: ParticleHandler (copy), Players (copy), LocalPlayer (copy), Trove (copy), EffectsHandler (copy)
    local v2 = p1 or {};
    local _ = v2.SkinName;

    if not v2.HSVData then
        ParticleHandler.GetUnusualHSVData({
            Player = v2.Player or v2.AttackerPlayer,
            Character = v2.Character or v2.Attacker
        });
    end;

    local Attacker = v2.Attacker;
    local Target = v2.Target;
    local v3 = Players:GetPlayerFromCharacter(Attacker);
    local v4 = Players:GetPlayerFromCharacter(Target);
    local v5;

    if LocalPlayer == v3 then
        v5 = false;
    else
        v5 = LocalPlayer ~= v4;
    end;

    local u6 = Trove.new();
    u6:AttachToInstance(Attacker);
    u6:AttachToInstance(Target);
    v2.AttackerPlayer = v3;
    v2.TargetPlayer = v4;
    v2.HSVData = ParticleHandler.GetUnusualHSVData({
        Player = v3
    });
    v2.Trove = u6;

    local function CloneChar(p7) -- Line: 43
        -- upvalues: u6 (copy)
        p7.Archivable = true;
        local v8 = u6:Clone(p7);
        local v9 = {
            Fire = true,
            Sparkles = true,
            Smoke = true,
            ParticleEmitter = true,
            Sound = true,
            Trail = true,
            Beam = true,
            BillboardGui = true,
            LocalScript = true,
            Script = true
        };

        for _, descendant in ipairs(v8:GetDescendants()) do
            if v9[descendant.ClassName] then
                descendant:Destroy();
            end;
        end;

        local v10 = v8:FindFirstChildOfClass("Humanoid");

        if v10 then
            v10.BreakJointsOnDeath = false;
            v10.RequiresNeck = true;
            v10.AutomaticScalingEnabled = false;
            v10.EvaluateStateMachine = false;
            v10.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            v10.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
        end;

        for _, descendant in ipairs(v8:GetDescendants()) do
            if descendant:IsA("Motor6D") then
                descendant.Enabled = true;
            end;
        end;

        local HumanoidRootPart = v8:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            HumanoidRootPart.Anchored = true;
            v8.PrimaryPart = HumanoidRootPart;
        end;

        for _, descendant in ipairs(v8:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CollisionGroup = "FX";
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.Massless = true;
            end;
        end;

        return v8;
    end;

    local v11 = CloneChar(Attacker);
    v11.Parent = workspace.Effects;
    v11:PivotTo(CFrame.new(Attacker.HumanoidRootPart.Position, Attacker.HumanoidRootPart.Position + Attacker.HumanoidRootPart.CFrame.LookVector));
    local v12 = CloneChar(Target);
    v12.Parent = workspace.Effects;
    v12:PivotTo(Attacker.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0));
    v2.AttackerClone = v11;
    v2.TargetClone = v12;
    Attacker:SetAttribute("Vanished", true);
    Target:SetAttribute("Vanished", true);
    EffectsHandler.CallEffect("SK_VANISH", {
        Transparency = 1,
        AffectStands = true,
        Character = Attacker
    });
    EffectsHandler.CallEffect("SK_VANISH", {
        Transparency = 1,
        AffectStands = true,
        Character = Target
    });
    u6:Add(function() -- Line: 128
        -- upvalues: Attacker (copy), Target (copy), EffectsHandler (ref)
        Attacker:SetAttribute("Vanished", nil);
        Target:SetAttribute("Vanished", nil);
        EffectsHandler.CallEffect("SK_VANISH", {
            Transparency = 0,
            AffectStands = true,
            Character = Attacker
        });
        EffectsHandler.CallEffect("SK_VANISH", {
            Transparency = 0,
            AffectStands = true,
            Character = Target
        });
    end);
    v2.CloneChar = CloneChar;
    require(script[v5 and "Spectator" or "Participant"])(v2);
    u6:Destroy();
end;