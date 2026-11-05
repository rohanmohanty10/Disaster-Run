  

 

local _ = game.ReplicatedStorage["Client Assets"];
game:GetService("TweenService");
local _ = task.wait;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3) -- Line: 13
    -- upvalues: u1 (copy), ParticleHandler (copy)
    if not (p2 and p2:IsDescendantOf(workspace)) then
        return;
    end;

    if not (p3 and p3:IsDescendantOf(workspace)) then
        return;
    end;

    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u4 = p2:Clone();
    local StandHumanoidRootPart = u4:WaitForChild("StandHumanoidRootPart");
    StandHumanoidRootPart:WaitForChild("Stand2Human"):Destroy();
    StandHumanoidRootPart.Anchored = true;

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("Sound") then
            descendant:Destroy();
        end;

        if descendant:IsA("BasePart") then
            if descendant.Name == "StandHumanoidRootPart" then
                descendant.Size = Vector3.new(0, 0, 0);
            end;

            descendant.Material = "Neon";
            descendant.Transparency = 0.5;
        end;
    end;

    local v5 = Random.new();
    local v6 = v5:NextInteger(0, 360);
    local v7 = math.rad(v6);
    StandHumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(math.sin(v7) * 5, 0, math.cos(v7) * 5);
    StandHumanoidRootPart.CFrame = CFrame.lookAt(StandHumanoidRootPart.Position, HumanoidRootPart.Position);
    local AnimationController = Instance.new("AnimationController");
    AnimationController.Parent = u4;
    local Animator = Instance.new("Animator");
    Animator.Parent = AnimationController;
    local v8 = ({
        ["LMB-1"] = { 14874406116, NumberRange.new(10, 20) },
        ["LMB-2"] = { 14874408628, NumberRange.new(10, 20) },
        ["LMB-3"] = { 14874410243, NumberRange.new(15, 20) },
        ["LMB-4"] = { 14874411954, NumberRange.new(15, 25) }
    })[`LMB-{v5:NextInteger(1, 4)}`];
    local Animation = Instance.new("Animation");
    Animation.AnimationId = `rbxassetid://{v8[1]}`;
    local SummonParticle = u4:FindFirstChild("SummonParticle", true);
    u4.Parent = workspace.Effects;
    local v9 = Animator:LoadAnimation(Animation);
    v9:Play();
    v9:AdjustSpeed(0);
    v9.TimePosition = v5:NextInteger(v8[2].Min, v8[2].Max) / 60;

    if SummonParticle then
        u1({
            Clone = false,
            Destroy = false,
            Parent = false,
            Particle = SummonParticle
        });
    end;

    task.delay(2, function() -- Line: 75
        -- upvalues: SummonParticle (copy), u1 (ref), u4 (copy), ParticleHandler (ref)
        if not SummonParticle then
            u4:Destroy();

            return;
        end;

        u1({
            Clone = false,
            Destroy = false,
            Parent = false,
            Particle = SummonParticle
        });

        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 1;
            end;
        end;

        task.delay(ParticleHandler.GetMaxLifetime(SummonParticle), u4.Destroy, u4);
    end);
end;