  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local LocalPlayer = Players.LocalPlayer;
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = 0;

return function(p2, p3, p4, p5) -- Line: 18
    -- upvalues: ParticleHandler (copy), LocalPlayer (copy), Lighting (copy), AssetHandler (copy), u1 (ref), EffectsHandler (copy)
    if not (p2 and p2:IsDescendantOf(game)) then
        return;
    end;

    local v6 = ParticleHandler.GetUnusualHSVData({
        Player = LocalPlayer,
        Character = p2
    });

    if p5 then
        local Settings = LocalPlayer:FindFirstChild("Settings");

        if Settings and (Settings.ImpactFrame.Value and (p4 and LocalPlayer.Character == p4)) then
            local u7 = {};

            for _, child in Lighting:GetChildren() do
                if child:IsA("ColorCorrectionEffect") then
                    u7[child] = child.Enabled;
                    child.Enabled = false;
                end;
            end;

            local u8 = AssetHandler.GetAsset("Particles/Mes/Invert", {
                AbilityName = "Ope"
            }):Clone();
            ParticleHandler.Unusualify(u8, {
                HSVData = v6
            });
            u8.Parent = Lighting;
            task.delay(0.08, function() -- Line: 42
                -- upvalues: u8 (copy), u7 (copy)
                u8:Destroy();

                for i, v in u7 do
                    if i:IsDescendantOf(game) and i.Enabled ~= v then
                        i.Enabled = v;
                    end;
                end;
            end);
        end;
    end;

    if u1 >= 20 then
        return;
    end;

    u1 = u1 + 1;
    task.delay(0.15, function() -- Line: 59
        -- upvalues: u1 (ref)
        u1 = u1 - 1;
    end);
    local _ = p2.HumanoidRootPart;

    for _ = 1, p5 and 8 or 3 do
        if not p2:IsDescendantOf(game) then
            break;
        end;

        for _ = 1, math.random(1, 2) do
            EffectsHandler.CallEffect("Generate Quasiduck Lightning", p2, {
                Length = 0.85,
                PartCount = 3,
                Color = ParticleHandler.TryHSVShift(ColorSequence.new(p3), v6),
                Speed = 1 / (math.random(5, 15) / 100),
                CFrames = { p2.Torso.CFrame * CFrame.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2)), p2.Torso.CFrame * CFrame.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5)) },
                Size = math.random(15, 30) / 100
            });
        end;

        task.wait(math.random(1, 3) / 10);
    end;
end;