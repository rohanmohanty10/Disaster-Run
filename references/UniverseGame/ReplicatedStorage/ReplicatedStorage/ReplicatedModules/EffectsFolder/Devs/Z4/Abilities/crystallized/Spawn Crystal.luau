  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy)
    local Origin = p1.Origin;
    local Radius = p1.Radius;
    local Player = p1.Player;
    EffectsHandler.CallEffect("Q_RADIAL", {
        Distance = 50,
        Origin = Origin,
        Effect = {
            {
                Effect = "Camera Shake",
                Arguments = { { 5.5, 13, 0, 0.5, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1) } }
            },
            {
                Effect = "Vignette Gui",
                Arguments = {
                    {
                        TweenTime = 0.1,
                        Blur = 8,
                        StartingColor = Color3.fromRGB(220, 220, 220),
                        EndingColor = Color3.fromRGB(220, 220, 220)
                    }
                }
            }
        }
    });
    local v2 = AssetHandler.GetAsset("Particles/AxeReaver/Beam", AssetHandler.GetAbilityData(Player));
    EffectsHandler.CallEffect("Anubis_Slam", {
        Object = v2,
        Origin = Origin * CFrame.new(0, 0.15 + v2.Size.Y / 2, 0)
    });
    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 2,
        Size = Vector3.new(2, 2, 2),
        Amount = 15,
        Origin = Origin,
        Radius = Radius
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/AxeReaver/Slam",
        AutoSerialize = true,
        Origin = Origin * CFrame.new(0, 2.5, 0),
        Player = Player
    });
    local u3 = AssetHandler.CloneAsset("Models/Crystal", AssetHandler.GetAbilityData(Player));
    u3.CFrame = Origin * CFrame.new(0, -10, 0);
    u3.Parent = workspace.Effects;
    task.delay(3, function() -- Line: 75
        -- upvalues: TweenService (ref), u3 (copy)
        local v4 = TweenService:Create(u3, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            CFrame = u3.CFrame * CFrame.new(0, -12, 0)
        });
        v4.Completed:Connect(function() -- Line: 80
            -- upvalues: u3 (ref)
            u3:Destroy();
        end);
        v4:Play();
    end);
    TweenService:Create(u3, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        CFrame = Origin * CFrame.new(0, 3.5, 0)
    }):Play();
end;