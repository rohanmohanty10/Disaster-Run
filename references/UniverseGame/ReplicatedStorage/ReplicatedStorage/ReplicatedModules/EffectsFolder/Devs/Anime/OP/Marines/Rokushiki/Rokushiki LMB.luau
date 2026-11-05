  

 

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
Random.new();

return function(p2) -- Line: 17
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy), u1 (ref)
    local u3 = p2 or {};
    local Character = u3.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Count = u3.Count;
    local u4 = u3.Speed or 1;
    local u5 = AssetHandler.GetAbilityData(u3.Player);
    local u6 = AssetHandler.CloneAsset("Particles/Misc/LMB " .. Count, u5);
    ParticleHandler.Unusualify(u6, u3);
    u6.Parent = Character;
    ParticleHandler.AttachTo(u6, {
        Part = Character.HumanoidRootPart
    });
    task.delay(({ 18, 17, 18, 15 })[Count] / 60, function() -- Line: 37
        -- upvalues: ParticleHandler (ref), u6 (copy), Count (copy), AssetHandler (ref), u5 (copy), HumanoidRootPart (copy), u3 (ref), TweenService (ref), u4 (copy), u1 (ref)
        ParticleHandler.DestroyEmit(u6);
        ParticleHandler.Emit(u6, ParticleHandler.GenerateEmitInfo(u6));

        if Count == 2 or Count == 4 then
            local v7 = Count == 2 and 0.1 or 0.15;
            local v8 = {
                [2] = CFrame.Angles(1.5707963267948966, 1.5707963267948966, 1.7453292519943295),
                [4] = CFrame.Angles(1.5707963267948966, 1.5707963267948966, 1.3962634015954636)
            };
            local v9 = AssetHandler.CloneAsset(`Particles/Misc/{Count == 2 and "Beam" or "Final"}Slash`, u5);
            v9.CFrame = HumanoidRootPart.CFrame * v8[Count];
            ParticleHandler.Unusualify(v9, u3);
            v9.Parent = workspace.Effects;
            TweenService:Create(v9, TweenInfo.new(v7 / u4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = v9.CFrame * CFrame.Angles(0, 2.9670597283903604, 0)
            }):Play();

            for _, descendant in v9:GetDescendants() do
                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo.new(v7 / u4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;

            u1.Wait(0.5 / u4);
            v9:Destroy();
        end;
    end);
end;