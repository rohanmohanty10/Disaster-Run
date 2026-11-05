  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local BoatTween = require(game.ReplicatedStorage.ClientLibrary.BoatTween);
require(ReplicatedStorage.ReplicatedModules.Types);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.New;
local u2 = Random.new();

local function Rng(p3, p4) -- Line: 30
    -- upvalues: u2 (copy)
    return u2:NextNumber(p3, p4);
end;

local _ = Players.LocalPlayer;

return function(u5, p6) -- Line: 36
    -- upvalues: AssetHandler (copy), BoatTween (copy), ParticleHandler (copy), u2 (copy)
    if not u5.Parent then
        return;
    end;

    local u7 = AssetHandler.GetAbilityData(u5);
    local HumanoidRootPart = u5:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Origin = p6.Origin;
    local Goal = p6.Goal;

    local function Tween(p8, p9) -- Line: 46
        -- upvalues: BoatTween (ref)
        local u10 = BoatTween:Create(p8, p9);
        u10.Completed:Once(function() -- Line: 49
            -- upvalues: u10 (copy)
            u10:Destroy();
        end);
        u10:Play();
    end;

    local function MakeClone(p11) -- Line: 56
        -- upvalues: AssetHandler (ref), u7 (copy), u5 (copy), ParticleHandler (ref)
        local v12 = AssetHandler.CloneAsset("Models/CharClone", u7);

        for _, child in v12.PrimaryPart:GetChildren() do
            if child:IsA("Motor6D") and child.Part1 then
                local v13 = u5:FindFirstChild(child.Name, true);

                if v13 then
                    child.C0 = v13.C0;
                    child.C1 = v13.C1;
                    child.Transform = v13.Transform;
                end;
            end;
        end;

        ParticleHandler.Unusualify(v12, {
            IncludeParts = true,
            Character = u5
        });

        return v12;
    end;

    local Magnitude = (Goal - Origin).Magnitude;
    local v14 = math.ceil(Magnitude / 4);

    for i = 1, v14 do
        local v15 = CFrame.lookAt(Origin:Lerp(Goal, i / (v14 + 1)), Goal);
        local v16 = MakeClone(u5);
        v16.PrimaryPart.CFrame = v15;
        v16.Parent = workspace.Effects;
        local v17 = i * 0.075 + 0.1;
        local u18 = BoatTween:Create(v16.PrimaryPart, {
            EasingStyle = "Quad",
            EasingDirection = "Out",
            StepType = "Heartbeat",
            Time = v17,
            Goal = {
                CFrame = v15 * CFrame.new(u2:NextNumber(-1.5, 1.5), u2:NextNumber(-1, 1), -(Magnitude / 10 + (HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude / 3))
            }
        });
        u18.Completed:Once(function() -- Line: 49
            -- upvalues: u18 (copy)
            u18:Destroy();
        end);
        u18:Play();

        for _, child in v16:GetChildren() do
            if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                local u19 = BoatTween:Create(child, {
                    EasingStyle = "Sine",
                    EasingDirection = "InOut",
                    StepType = "Heartbeat",
                    Time = v17,
                    Goal = {
                        Transparency = 1
                    }
                });
                u19.Completed:Once(function() -- Line: 49
                    -- upvalues: u19 (copy)
                    u19:Destroy();
                end);
                u19:Play();
            end;
        end;

        task.delay(v17 + 1, v16.Destroy, v16);
    end;
end;