  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
game:GetService("Lighting");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 22
    -- upvalues: AssetHandler (copy), u1 (copy), TweenService (copy), EffectsHandler (copy), ParticleHandler (copy)
    local v3 = p2 or {};
    local v4 = v3.Speed or 1;
    local RangeGrowthRate = v3.RangeGrowthRate;
    local StartRange = v3.StartRange;
    local MaxRange = v3.MaxRange;
    local Animation = v3.Animation;
    local Character = v3.Player.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local v5 = AssetHandler.GetAbilityData(Character);
    local v6 = HumanoidRootPart.CFrame * CFrame.new(0, -2.75, 0);
    local v7 = workspace:Raycast(v6.Position, Vector3.new(0, -20, 0), u1);

    if v7 then
        v6 = CFrame.new(v7.Position, v7.Position + v7.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.2, 0);
    end;

    local function Convert(p8) -- Line: 115
    end;

    local v9 = AssetHandler.CloneAsset("Particles/DeadCalm/Puddle", v5);
    v9.Parent = workspace.Effects;
    v9:ScaleTo(StartRange / 20);
    v9:PivotTo(v6);

    for _, descendant in v9:GetDescendants() do
        if descendant:IsA("BasePart") then
            local v10 = 0.1;

            if descendant.Name ~= "Cylinder.002" then
                v10 = v10 * 4;
            end;

            local Transparency = descendant.Transparency;
            descendant.Transparency = 1;
            TweenService:Create(descendant, TweenInfo.new(v10, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = Transparency
            }):Play();
        elseif descendant:IsA("Decal") then
            descendant.Transparency = 0.87;
            TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end;

    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = Animation;
    Animation2.Parent = v9;
    local v11 = v9.AnimationController.Animator:LoadAnimation(Animation2);
    v11:Play(0);
    local Animation3 = Instance.new("Animation");
    Animation3.AnimationId = Animation;
    Animation3.Parent = v9;
    local v12 = v9.AnimationController.Animator:LoadAnimation(Animation3);
    local v13 = MaxRange / 20;
    local v14 = 0;
    local v15 = false;
    local v16 = 0;

    while Character and (Character:IsDescendantOf(game) and Character:GetAttribute("DeadCalm")) do
        local v17 = task.wait();
        v16 = v16 + v17;
        local v18 = math.clamp(RangeGrowthRate * v16 * v4 + StartRange, StartRange, MaxRange);
        local v19 = v6 * CFrame.new(0, v18 / MaxRange * 0.5, 0);

        if v9:FindFirstChild("OutwardWind") then
            v14 = v14 + 3.490658503988659 * v17;
            v9.OutwardWind.CFrame = v19 * CFrame.Angles(0, v14, 0);
        end;

        local v20 = v18 / 20;

        if v20 == v13 then
            v15 = v15 or true;
        else
            v9:ScaleTo(v20);
            v9:PivotTo(v19);
        end;
    end;

    v12:Play();
    v11:Stop();
    EffectsHandler.Wait(0.5);

    if Character and Character.Parent then
        repeat
            task.wait(0.1);
        until not Character:GetAttribute("MoveActive");
    end;

    ParticleHandler.EnableAllParticles(v9, false);
    task.delay(0.7, v9.Destroy, v9);

    for _, descendant in v9:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            TweenService:Create(descendant, TweenInfo.new(0.7), {
                Transparency = 1
            }):Play();
        end;
    end;

    local v21 = v9:GetScale();

    for i = 1, 70 do
        v9:ScaleTo((math.lerp(v21, 0.01, i / 70)));
        task.wait(0.01);
    end;
end;