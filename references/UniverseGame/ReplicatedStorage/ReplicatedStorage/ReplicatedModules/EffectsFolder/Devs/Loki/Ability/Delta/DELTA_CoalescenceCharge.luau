  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local New = Fusion.New;

return function(p1, p2) -- Line: 21
    -- upvalues: New (copy), Fusion (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local AbilityModel = p2.AbilityModel;

    if not AbilityModel then
        return;
    end;

    local DeltaControlBone = AbilityModel:FindFirstChild("DeltaControlBone", true);

    if not DeltaControlBone then
        return;
    end;

    local v3 = DeltaControlBone:FindFirstChild("DeltaArmBone.R"):FindFirstChild("DeltaTriangleBone.R.002", true);

    if not v3 then
        return;
    end;

    local u4 = New("Part")({
        Size = Vector3.new(1, 1, 1),
        Massless = true,
        CanCollide = false,
        Transparency = 1,
        Parent = workspace.Effects,
        Name = "BoneAttach",
        [Fusion.Children] = {
            Attachment = New("Attachment")({
                CFrame = CFrame.new(0, -1.4, 0)
            })
        }
    });
    local u5 = New("RigidConstraint")({
        Attachment0 = v3,
        Attachment1 = u4:FindFirstChildOfClass("Attachment"),
        Parent = u4
    });
    local v6 = AssetHandler.GetAbilityData(p1);
    local v7 = os.clock();
    local v8 = ParticleHandler.GetUnusualHSVData({
        Character = p1
    });
    EffectsHandler.CallEffect("Enable Particles", {
        Enabled = true,
        Scale = 1,
        Return = true,
        Parent = u4,
        ReferencePart = AssetHandler.GetAsset("Particles/Coalescence/Charge", v6),
        Id = v7,
        HSVShift = v8
    });

    while p2.Ref and p2.Ref.Parent do
        task.wait(0.03333333333333333);
    end;

    u5:Destroy();
    u4.Anchored = true;
    EffectsHandler.CallEffects({
        {
            Name = "Enable Particles",
            Data = {
                {
                    Enabled = false,
                    Id = v7
                }
            }
        }
    });
    task.delay(2, function() -- Line: 93
        -- upvalues: u4 (ref), u5 (ref)
        u4:Destroy();
        u4 = nil;
        u5 = nil;
    end);
end;