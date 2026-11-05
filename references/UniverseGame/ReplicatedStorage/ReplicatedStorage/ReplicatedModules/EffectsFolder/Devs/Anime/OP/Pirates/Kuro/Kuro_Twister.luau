  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local ClientAssets = PathShortcuts.ClientAssets;

return function(p1) -- Line: 11
    -- upvalues: ParticleHandler (copy), ClientAssets (copy), TweenService (copy)
    if not p1 then
        return;
    end;

    local HumanoidRootPart = p1.HumanoidRootPart;
    local Model = Instance.new("Model");
    Model.Name = "Kuro Twister Effect";
    Model.Parent = workspace.Effects;
    task.delay(0.3, function() -- Line: 22
        -- upvalues: ParticleHandler (ref), Model (copy)
        task.delay(ParticleHandler.EnableAllParticles(Model, false), Model.Destroy, Model);
    end);

    for i = 1, 2 do
        local v2 = ClientAssets.Kuro.Slash:Clone();
        v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1, 0) * CFrame.Angles(1.5707963267948966 * (i == 1 and -1 or 1), 0, 0);
        v2.Parent = Model;
        TweenService:Create(v2, TweenInfo.new(0.5, Enum.EasingStyle.Circular), {
            Orientation = Vector3.new(0, 5000, 0)
        }):Play();
    end;

    local v3 = ClientAssets.Kuro.SpinningSlash:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0.5, 0);
    v3.Parent = Model;
end;