  

 

game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = Players.LocalPlayer;
local u2 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

return function(p3, p4, p5) -- Line: 22
    -- upvalues: ParticleHandler (copy), u1 (copy), u2 (copy), EffectsHandler (copy)
    local v6 = p5 or {};
    local v7 = v6.HSVData or ParticleHandler.GetUnusualHSVData({
        Character = p3
    });
    local v8 = v6.Attribute or "BeamAura";

    if p4 then
        if p3:GetAttribute(v8) then
            return;
        end;

        p3:SetAttribute(v8, true);
        local HumanoidRootPart = p3.HumanoidRootPart;
        local v9 = ParticleHandler.TryHSVShift(v6.Color or ColorSequence.new(Color3.fromRGB(66, 138, 255)), v7);
        local v10 = v6.Radius or 4;
        local v11 = v6.Cooldown or 0.12;
        local v12 = os.clock();

        while p3 and (p3.Parent and p3:GetAttribute(v8)) do
            task.wait();
            local v13 = p3 and p3:GetAttribute("Flashtime") and 5 or 1;

            if os.clock() - v12 >= v11 * v13 then
                v12 = os.clock();
                local Position = HumanoidRootPart.Position;

                for _ = 1, u1:NextInteger(1, 2) do
                    local v14 = u1:NextNumber(-1, 1);
                    local v15 = u1:NextNumber(-1, 1);
                    local v16 = Position + Vector3.new(v14, v15, u1:NextNumber(-1, 1)).Unit * v10 * u1:NextNumber(0.75, 1.1);
                    local v17 = u1:NextNumber(-1, 1);
                    local v18 = u1:NextNumber(-1, 1);
                    local v19 = Position + Vector3.new(v17, v18, u1:NextNumber(-1, 1)).Unit * v10 * u1:NextNumber(0.75, 1.1);

                    if u1:NextNumber() < 0.2 then
                        local v20 = p3:FindFirstChild(u2[u1:NextInteger(1, #u2)]);

                        if v20 then
                            v16 = v20.Position;
                        end;
                    end;

                    EffectsHandler.CallEffect("Lightning Beam", {
                        Start = v16,
                        End = v19,
                        Color = v9,
                        Amount = u1:NextInteger(3, 5),
                        CurveSize = u1:NextNumber(1.7, 2),
                        Range = u1:NextNumber(15, 30),
                        Thickness = u1:NextNumber(0.3, 0.4),
                        Life = u1:NextNumber(1, 2) * v13
                    });
                end;
            end;
        end;
    else
        if not p3:GetAttribute(v8) then
            return;
        end;

        p3:SetAttribute(v8, nil);
    end;
end;