  

 

local CollectionService = game:GetService("CollectionService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();

return function(p1) -- Line: 11
    -- upvalues: CollectionService (copy), EffectsHandler (copy)
    local v2 = p1 or {};
    local Player = v2.Player;
    local v3 = v2.Character or Player.Character;
    local HumanoidRootPart = v3:FindFirstChild("HumanoidRootPart");

    if not Player and v3 then
        Player = game:GetService("Players"):GetPlayerFromCharacter(v3);
    end;

    ({
        AbilityName = "Cid Kagenou"
    }).SkinName = v2.SkinName;
    local _ = "Shadow_BarrageEffect" .. v3.Name;

    if CollectionService:HasTag(v3, "Barrage") then
        repeat
            EffectsHandler.CallEffect("Anubis_Slashes", v3, {
                Duration = 0.1,
                Size = v2.Size or Vector3.new(7.5, 20, 7.5),
                Color = v2.Color or {
                    Color3.fromRGB(0, 0, 0),
                    Color3.fromRGB(10, 10, 10),
                    Color3.fromRGB(25, 25, 25),
                    Color3.fromRGB(50, 50, 50),
                    Color3.fromRGB(75, 75, 75)
                }
            });

            if Player and Player.Settings.CameraShake.Value == true then
                EffectsHandler.CallEffect("Q_RADIAL", {
                    Distance = 35,
                    Origin = HumanoidRootPart.CFrame,
                    Effect = { {
                            Effect = "Camera Shake Preset",
                            Arguments = { "Ride" }
                        } }
                });
            end;

            task.wait(0.05);
        until not (CollectionService:HasTag(v3, "Barrage") and (v3 and v3.Parent));
    end;
end;