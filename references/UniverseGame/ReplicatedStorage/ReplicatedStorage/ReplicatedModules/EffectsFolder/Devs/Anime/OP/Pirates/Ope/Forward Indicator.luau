  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), TweenService (copy)
    local Part = p1.Part;

    if not Part then
        print(debug.traceback("No origin part"));

        return;
    end;

    local v2 = p1.Duration or 1;
    local v3 = p1.Distance or 36;
    local v4 = p1.Color or Color3.new(1, 1, 1);
    local v5 = p1.Offset or CFrame.identity;
    local Character = p1.Character;

    if Character then
        v4 = ParticleHandler.TryHSVShift(v4, ParticleHandler.GetUnusualHSVData({
            Character = Character
        }));
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.CFrame = v5 * CFrame.Angles(0, 0, 1.5707963267948966);
    Attachment.Parent = Part;
    task.delay(v2, Attachment.Destroy, Attachment);
    local v6 = Attachment:Clone();
    v6.Parent = Part;
    task.delay(v2, v6.Destroy, v6);
    local v7 = AssetHandler.GetAsset("Particles/Mes/Indicator", {
        AbilityName = "Ope"
    }):Clone();
    v7.Color = ColorSequence.new(v4);
    v7.Attachment0 = Attachment;
    v7.Attachment1 = v6;
    v7.Parent = workspace.Effects;
    task.delay(v2, v7.Destroy, v7);
    TweenService:Create(v6, TweenInfo.new(v2, Enum.EasingStyle.Linear), {
        Position = Vector3.new(0, -2.5, -v3)
    }):Play();
    local v8 = TweenService:Create(v7, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Width0 = 0,
        Width1 = 0
    });
    task.delay(v2 * 0.85, v8.Play, v8);
end;