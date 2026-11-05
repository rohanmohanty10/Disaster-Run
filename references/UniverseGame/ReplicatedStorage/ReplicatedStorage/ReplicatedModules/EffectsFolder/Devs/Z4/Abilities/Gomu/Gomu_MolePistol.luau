  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1, p2, p3) -- Line: 7
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), TweenService (copy)
    if not p1 or typeof(p1) ~= "CFrame" then
        return;
    end;

    local u4 = AssetHandler.CloneAsset("Models/Mole", {
        AbilityName = "Gomu"
    });
    u4.Parent = workspace.Effects;

    if typeof(p1) == "Vector3" then
        p1 = CFrame.new(p1) or p1;
    end;

    u4.CFrame = p1;
    u4.Color = p2;
    local CallEffect = EffectsHandler.CallEffect;
    local v5 = {
        AbilityName = "Hito Model: Nika",
        Path = "Particles/Gear5/MolePistol/MoleUp",
        PlaySounds = true,
        AutoSerialize = true,
        Origin = u4.CFrame * CFrame.new(0, -1, 0)
    };
    local v6;

    if p3 == nil then
        v6 = nil;
    else
        v6 = p3.HSVData;
    end;

    v5.HSVShift = v6;
    CallEffect("Emit Particle V3", v5);
    local v7 = TweenService:Create(u4, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, true), {
        Size = u4.Size + Vector3.new(0, 30, 0)
    });
    v7:Play();
    v7.Completed:Once(function() -- Line: 37
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;