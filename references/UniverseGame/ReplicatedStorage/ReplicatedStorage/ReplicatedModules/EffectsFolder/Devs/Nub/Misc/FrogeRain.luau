  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local Promise = require(PathShortcuts.KnitPath.Promise);
require(PathShortcuts.KnitPath.TableUtil);
local ParticleInfo = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleInfo);
local Particle = require(PathShortcuts.ReplicatedModules.Classes.Particle);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(u2) -- Line: 13
    -- upvalues: u1 (copy), SoundGroups (copy), Promise (copy), TweenService (copy), ParticleInfo (copy), Particle (copy), ParticleHandler (copy)
    if u2 == nil then
        return;
    end;

    local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart:IsDescendantOf(workspace)) then
        return;
    end;

    local Froge = u1.Assets.Abilities["Weather Report"].Froge;
    local _ = u1.Assets.Abilities["Weather Report"].SmokeHit;
    SoundGroups:AssignSoundTag(Froge.Sound);

    for _ = 1, 100 do
        Promise.try(function() -- Line: 20
            -- upvalues: Froge (copy), HumanoidRootPart (copy), TweenService (ref), ParticleInfo (ref), Particle (ref), ParticleHandler (ref), u2 (copy)
            local u3 = Froge:Clone();
            u3.Parent = workspace.Effects;
            u3.Transparency = 1;
            local v4 = HumanoidRootPart.CFrame * CFrame.new(math.random(-20, 20), 100, math.random(-20, 20));
            local Angles = CFrame.Angles;
            local v5 = math.random(-360, 360);
            u3.CFrame = v4 * Angles(0, math.rad(v5), 0);
            TweenService:Create(u3, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0
            }):Play();
            task.delay(1, u3.Sound.Play, u3.Sound);
            task.delay(1, function() -- Line: 28
                -- upvalues: ParticleInfo (ref), Particle (ref), ParticleHandler (ref), u2 (ref), u3 (copy)
                local v6 = ParticleInfo.GetParticleInfo("WRFrogLand");
                local v7 = Particle.new({
                    Particle = v6.Object:Clone(),
                    ParticleInfo = v6.ParticleInfo
                });
                ParticleHandler.Unusualify(v7.Particle, {
                    Character = u2
                });
                v7:Goto(u3.CFrame.Position);
                v7:Start();
                v7:Destroy();
            end);
            wait(2);
            local CFrame2 = u3.CFrame;
            u3:Destroy();
            local v8 = ParticleInfo.GetParticleInfo("WRFrogExplode");
            local v9 = Particle.new({
                Particle = v8.Object:Clone(),
                ParticleInfo = v8.ParticleInfo
            });
            ParticleHandler.Unusualify(v9.Particle, {
                Character = u2
            });
            v9:Goto(CFrame2.Position);
            v9:Start();
            v9:Destroy();
        end):catch(warn);
        wait();
    end;
end;