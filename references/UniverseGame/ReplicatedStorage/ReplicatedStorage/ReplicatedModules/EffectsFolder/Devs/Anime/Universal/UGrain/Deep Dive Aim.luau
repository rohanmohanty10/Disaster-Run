  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local LocalPlayer = Players.LocalPlayer;
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

local function CreateAfterimage(p2) -- Line: 18
    p2.Archivable = true;
    local v3 = p2:Clone();
    v3.Name = p2.Name .. "_DeepDive";
    local v4 = { "LocalScript", "Script", "Sound", "Folder", "BillboardGui", "SurfaceGui", "ScreenGui", "BallSocketConstraint", "NoCollisionConstraint" };

    for _, descendant in v3:GetDescendants() do
        if table.find(v4, descendant.ClassName) then
            descendant:Destroy();
        end;
    end;

    local HumanoidRootPart = v3:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        for _, descendant in v3:GetDescendants() do
            if descendant:IsA("BasePart") then
                HumanoidRootPart = descendant;
                break;
            end;
        end;
    end;

    local v5 = v3:FindFirstChildOfClass("Humanoid");

    if v5 then
        v5.DisplayDistanceType = "None";
        v5.HealthDisplayType = "AlwaysOff";
        v5.BreakJointsOnDeath = false;
        v5.EvaluateStateMachine = false;
        v5.RequiresNeck = false;
        v5.AutomaticScalingEnabled = false;
    end;

    for _, descendant in v3:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = descendant == HumanoidRootPart;
            descendant.CollisionGroup = "Ghosted";
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
            descendant.CastShadow = false;
        end;
    end;

    v3.PrimaryPart = HumanoidRootPart;
    v3.Parent = workspace.Effects;
    v3:PivotTo(p2:GetPivot());

    return v3;
end;

return function(p6) -- Line: 72
    -- upvalues: ParticleHandler (copy), LocalPlayer (copy), AssetHandler (copy), CreateAfterimage (copy), EffectsHandler (copy), TweenService (copy), u1 (copy)
    local v7 = p6 or {};
    local v8 = v7.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = v7.Player or v7.AttackerPlayer,
        Character = v7.Character or v7.Attacker
    });
    local Player = v7.Player;
    local Character = v7.Character;

    if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Player == LocalPlayer;
    local Origin = v7.Origin;
    local v9 = v7.Attribute or "DeepDiveAiming";
    local Animation = v7.Animation;
    local v10 = AssetHandler.GetAbilityData(Character);
    local v11 = CreateAfterimage(Character);
    v11:PivotTo(Origin);
    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = Animation;
    Animation2.Parent = v11;
    local v12 = v11:FindFirstChildOfClass("Humanoid"):LoadAnimation(Animation2);
    v12.Looped = true;
    v12:Play(0);
    EffectsHandler.CallEffect("SK_VANISH", {
        Transparency = 1,
        AffectStands = true,
        Character = Character,
        TweenInfo = { 0 }
    });
    Character:SetAttribute("Vanished", true);
    local v13 = AssetHandler.CloneAsset("Particles/DeepDive/Indicator", v10);
    ParticleHandler.Unusualify(v13, {
        HSVData = v8
    });
    v13.CFrame = HumanoidRootPart.CFrame;
    v13.Parent = workspace.Effects;
    local Transparency = v13.Transparency;
    v13.Transparency = 1;
    TweenService:Create(v13, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Transparency = Transparency
    }):Play();

    while true do
        local v14 = task.wait();

        if v13 and (HumanoidRootPart and HumanoidRootPart.Parent) then
            local v15 = HumanoidRootPart.CFrame * CFrame.new(0, -HumanoidRootPart.Size.Y / 2, 0);
            local v16 = workspace:Raycast(HumanoidRootPart.Position + Vector3.new(0, 10, 0), Vector3.new(0, -100, 0), u1);

            if v16 then
                local Unit = HumanoidRootPart.CFrame.LookVector:Cross(v16.Normal).Unit;
                local Unit2 = Unit:Cross(v16.Normal).Unit;
                v15 = CFrame.fromMatrix(v16.Position, Unit, v16.Normal, Unit2) * CFrame.new(0, 0.1, 0);
            end;

            v13.CFrame = v13.CFrame:Lerp(v15, (math.min(v14 * 12, 1)));
        end;

        if not Character or (Character.Parent == nil or not Character:GetAttribute(v9)) then
            if v13 then
                TweenService:Create(v13, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                ParticleHandler.EnableAllParticles(v13, false);
                ParticleHandler.DestroyEmit(v13);
                task.delay(0.4, v13.Destroy, v13);
            end;

            if v11 and v11.Parent then
                v12:Stop();
                task.defer(v11.Destroy, v11);
            end;

            if Character and Character:IsDescendantOf(game) then
                EffectsHandler.CallEffect("SK_VANISH", {
                    Transparency = 0,
                    AffectStands = true,
                    Character = Character
                });
                Character:SetAttribute("Vanished", nil);
            end;

            return;
        end;
    end;
end;