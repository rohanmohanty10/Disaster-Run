  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game.Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, u2, u3, u4, p5, p6) -- Line: 7
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), ParticleHandler (copy)
    if LocalPlayer.Settings.EffectsQuality.Value == 1 then
        u3 = math.clamp(u3, 1, 5);
    end;

    local function checkPosition(p7) -- Line: 12
        return p7.Position;
    end;

    local v8 = {
        Smoke = {
            Model = ReplicatedStorage["Client Assets"].Universal.GrabParticles
        },
        Smoke2 = {
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].STWR.Smoke
        },
        ["TWOH Particles"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.JebusParticles
        },
        ["TWOH Energy"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.JebusParticles
        },
        ["Lightning Debris"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.JebusParticles
        },
        ["STWR Summon"] = {
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].STWR.Summon
        },
        ["Nocturnus Summon"] = {
            Model = ReplicatedStorage["Client Assets"].Nocturnus.Summon
        },
        Vortex = {
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].STWR.Vortex
        },
        Debris = {
            Model = ReplicatedStorage["Client Assets"].Universal.DefaultDebris
        },
        GunShot = {
            Model = ReplicatedStorage["Client Assets"].Kur.Gun
        },
        GunShotVFX = {
            Model = ReplicatedStorage["Client Assets"].Universal.GunShotVFX
        },
        GunShot2 = {
            Model = ReplicatedStorage["Client Assets"].Universal.GunShot
        },
        Explosion = {
            Model = ReplicatedStorage["Client Assets"].Universal.Explosion
        },
        ["Sand Particles"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.SandParticles
        },
        ["Success Particles"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.SuccessParticles
        },
        ["Jebus Particles"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.JebusParticles
        },
        ["Heavy Impact"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.HeavyImpact
        },
        ["Summon Knife"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.SummonKnife
        },
        ["Lightning Dash"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.LightningDash
        },
        ["Lightning Dash2"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.LightningDash2
        },
        ["Lightning Spark"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.LightningSpark
        },
        ["Lightning Spark2"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.LightningSpark2
        },
        ["Flash Step"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.FlashStep
        },
        LightningA = {
            Model = ReplicatedStorage["Client Assets"].Universal.LightningA
        },
        LightningB = {
            Model = ReplicatedStorage["Client Assets"].Universal.LightningB
        },
        ["Clone Summon"] = {
            Model = ReplicatedStorage["Client Assets"].Universal.CloneSummon
        },
        ["Godspeed Particles"] = {
            Model = ReplicatedStorage["Client Assets"].Killua.Godspeed
        },
        Snas = {
            Model = ReplicatedStorage["Client Assets"]["SANS AAAAAAAA"].kureffect
        },
        ["Eraser Discharge"] = {
            Model = ReplicatedStorage["Client Assets"].Broly.EraserDischarge
        },
        ["Eraser Discharge2"] = {
            Model = ReplicatedStorage["Client Assets"].Broly.EraserDischarge2
        },
        ["Broly Strike"] = {
            Model = ReplicatedStorage["Client Assets"].Broly.StrikeEffect
        },
        ["Broly Explosion"] = {
            Model = ReplicatedStorage["Client Assets"].Broly.BrolyExplosion
        },
        ["Chariot Armor1"] = {
            Model = ReplicatedStorage["Client Assets"]["Silver Chariot"].Smoke1
        },
        ["Chariot Armor2"] = {
            Model = ReplicatedStorage["Client Assets"]["Silver Chariot"].Smoke2
        },
        ["Broly Debris"] = {
            Model = ReplicatedStorage["Client Assets"].Broly.BrolyDebris
        },
        ["Anshen Hit"] = {
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].Anshen.AnshenHit
        },
        ["Anshen Pierce"] = {
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].Anshen.AnshenPierce
        },
        ["Anshen Heavy"] = {
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].Anshen.AnshenHeavy
        },
        ["Anshen Slam"] = {
            Unusual = true,
            Model = ReplicatedStorage["Client Assets"].Anshen.AnshenSmash
        },
        ["Anshen Summon"] = {
            Model = ReplicatedStorage["Client Assets"].Anshen.AnshenSummon
        },
        ["Goku Shockwave"] = {
            Model = ReplicatedStorage["Client Assets"]["Goku Rewrite"].Shockwave
        },
        ["Goku Explosion"] = {
            Model = ReplicatedStorage["Client Assets"]["Goku Rewrite"].Explosion
        },
        ["Goku Light"] = {
            Model = ReplicatedStorage["Client Assets"]["Goku Rewrite"].Light
        },
        ["Goku Medium"] = {
            Model = ReplicatedStorage["Client Assets"]["Goku Rewrite"].Medium
        },
        ["Goku Heavy"] = {
            Model = ReplicatedStorage["Client Assets"]["Goku Rewrite"].Heavy
        },
        ["Goku God Hit"] = {
            Model = ReplicatedStorage["Client Assets"]["Goku Rewrite"].SSGHit
        },
        Kiai = {
            Model = ReplicatedStorage["Client Assets"]["Goku Rewrite"].Kiai
        },
        Godbind = {
            Model = ReplicatedStorage["Client Assets"]["Goku Rewrite"].Godbind
        }
    };

    if typeof(u2) ~= "Vector3" and not p5 then
        if u2:IsA("Model") and u2:FindFirstChild("HumanoidRootPart") then
            u2 = u2:FindFirstChild("HumanoidRootPart").Position;
        elseif pcall(function() -- Line: 78
            -- upvalues: u2 (ref)
            local _ = u2.Position;
        end) then
            u2 = u2.Position;
        end;
    end;

    local v9 = v8[p1];

    if v9 == nil then
        warn((`EmitParticles: Could not find table index "{p1}"!`));

        return;
    end;

    local u10 = v9.Model:Clone();

    if p5 then
        u10.CFrame = u2;
    else
        u10.Position = u2;
    end;

    task.spawn(function() -- Line: 93
        -- upvalues: u10 (copy), u4 (copy), u3 (ref)
        for _, descendant in pairs(u10:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if u4 then
                    for i, v in pairs(u4) do
                        descendant[i] = v;
                    end;
                end;

                descendant:Emit(u3 or 15);
            end;
        end;

        wait(3);
        u10:Destroy();
    end);

    if v9.Unusual == true and p6 ~= nil then
        local v11 = ParticleHandler.GetUnusualHSVData({
            Character = p6.Character
        });

        if v11 ~= nil then
            if u10:IsA("BasePart") then
                u10.Color = ParticleHandler.HSVShift(u10.Color, v11);
            end;

            ParticleHandler.Unusualify(u10, {
                HSVData = v11
            });
        end;
    end;

    u10.Parent = workspace.Effects;
end;