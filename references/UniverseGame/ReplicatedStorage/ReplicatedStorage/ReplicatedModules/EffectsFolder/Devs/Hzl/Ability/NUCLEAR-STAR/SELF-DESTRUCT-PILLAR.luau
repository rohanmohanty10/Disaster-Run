  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

return function(p1, p2, p3) -- Line: 19
    -- upvalues: Trove (copy), EffectsHandler (copy), AssetHandler (copy)
    if not (p1 and p2) then
        return;
    end;

    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v4 = Trove.new();
    v4:AttachToInstance(p2);
    local MoveData = p3.MoveData;
    local v5 = os.clock();
    local HSVData = p3.HSVData;
    local u6 = v5 + 1;
    local _ = v5 + 2;

    local function CleanupExplosion() -- Line: 34
        -- upvalues: EffectsHandler (ref), u6 (copy)
        EffectsHandler.CallEffects({
            {
                Name = "Enable Particles",
                Data = {
                    {
                        Enabled = false,
                        Id = u6
                    }
                }
            }
        });
    end;

    EffectsHandler.CallEffects({
        {
            Name = "Enable Particles",
            Data = {
                {
                    Enabled = true,
                    EnableAll = true,
                    Parent = HumanoidRootPart,
                    ReferencePart = AssetHandler.GetAsset("Particles/SELF-DESTRUCT/DestructionBeamNew", MoveData),
                    Offset = CFrame.new(0, -2.5 * p1:GetScale(), 0) * CFrame.Angles(0, 0, -1.5707963267948966),
                    Id = u6,
                    HSVShift = HSVData
                }
            }
        }
    });
    v4:Add(CleanupExplosion);
end;