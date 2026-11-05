  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

local function RandomSign() -- Line: 10
    return math.random(1, 2) == 1 and -1 or 1;
end;

return function(u2, p3) -- Line: 14
    -- upvalues: AssetHandler (copy), u1 (copy)
    local Value = AssetHandler.GetAsset("Particles/Enciero/Trail", AssetHandler.GetAbilityData(u2)).Trail.Color.Keypoints[1].Value;
    local u4 = ColorSequence.new(Value);

    if p3:GetAttribute("MeterColor") then
        u4 = ColorSequence.new({ ColorSequenceKeypoint.new(0, p3:GetAttribute("MeterColor")), ColorSequenceKeypoint.new(0.5, Value), ColorSequenceKeypoint.new(1, Value) });
    end;

    local Torso = p3:FindFirstChild("Torso");

    if not Torso then
        return;
    end;

    local Torso2 = u2:FindFirstChild("Torso");

    if not Torso2 then
        return;
    end;

    repeat
        task.spawn(function() -- Line: 33
            -- upvalues: u1 (ref), AssetHandler (ref), u2 (copy), u4 (ref), Torso (copy), Torso2 (copy)
            local v5 = u1:NextNumber(0.22, 0.4);
            local v6 = AssetHandler.CloneAsset("Particles/Enciero/Trail", AssetHandler.GetAbilityData(u2));
            v6.Trail.Color = u4;
            v6.Parent = workspace.Effects;
            task.delay(5, v6.Destroy, v6);
            local Position = Torso.Position;
            local Position2 = Torso2.Position;
            local v7 = u1:NextNumber(5, 10) * (math.random(1, 2) == 1 and -1 or 1);
            local v8 = u1:NextNumber(5, 10) * (math.random(1, 2) == 1 and -1 or 1);
            local v9 = u1:NextNumber(5, 10);
            local v10 = math.random(1, 2) == 1 and -1 or 1;
            local v11 = (Position + Position2) / 2 + Vector3.new(v7, v8, v9 * v10);
            local v12 = math.ceil(v5 * 60);

            for i = 1, v12 do
                if not v6:IsDescendantOf(game) then
                    break;
                end;

                local v13 = i / v12;
                v6.Position = (1 - v13) ^ 2 * Position + 2 * (1 - v13) * v13 * v11 + v13 ^ 2 * Position2;
                task.wait();
            end;

            if not v6:IsDescendantOf(game) then
                return;
            end;

            for _, descendant in ipairs(v6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.wait(0.1);
    until not (u2:IsDescendantOf(game) and (p3:IsDescendantOf(game) and p3:GetAttribute("EncieroDrain")));
end;