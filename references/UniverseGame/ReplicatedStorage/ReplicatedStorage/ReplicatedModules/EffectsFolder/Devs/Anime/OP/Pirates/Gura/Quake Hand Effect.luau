  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p2) -- Line: 10
    -- upvalues: u1 (copy), ParticleHandler (copy), TweenService (copy)
    local Lifetime = p2.Lifetime;

    for _, v in p2.Limbs do
        local u3 = u1.Gura.HandEffect:Clone();
        u3.Parent = v;
        task.delay(Lifetime + 1.5, u3.Destroy, u3);
        ParticleHandler.AttachTo(u3, {
            Part = v,
            Offset = CFrame.new(0, 4.813, 0)
        });
        ParticleHandler.Emit(u3, ParticleHandler.GenerateEmitInfo(u3));
        ParticleHandler.EnableParticles(u3.EnabledParticles, true);
        TweenService:Create(u3, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play();
        task.delay(Lifetime, function() -- Line: 32
            -- upvalues: u3 (copy), TweenService (ref)
            if u3:IsDescendantOf(game) then
                for _, descendant in u3:GetDescendants() do
                    if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;

                TweenService:Create(u3, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end;
        end);
    end;
end;