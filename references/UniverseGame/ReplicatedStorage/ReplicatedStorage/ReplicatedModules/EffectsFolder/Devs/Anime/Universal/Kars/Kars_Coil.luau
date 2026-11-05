  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
require(ReplicatedModules.PathShortcuts);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
ReplicatedStorage:FindFirstChild("Client Assets");
local u1 = Random.new();

return function(p2) -- Line: 14
    -- upvalues: u1 (copy), ParticleHandler (copy)
    local u3 = p2 or {};
    local Origin = u3.Origin;
    local u4 = u3.Amount or 3;
    local u5 = u3.Offset or CFrame.identity;
    local v6 = u3.TrailDelay or 0;
    local Trail = u3.Trail;
    local u7 = u3.BothSides or false;
    local u8 = u3.Enable or false;
    local u9 = u3.Uniform or false;

    if not (Trail and Origin) then
        return;
    end;

    for i = 1, u4 do
        task.spawn(function() -- Line: 31
            -- upvalues: u3 (ref), u1 (ref), u7 (copy), u9 (copy), u4 (copy), i (copy), Trail (copy), ParticleHandler (ref), u8 (copy), Origin (copy), u5 (copy)
            local v10 = u3.Height or math.random(200, 500) / 1000;
            local v11 = u3.Degree or math.random(100, 200) / 10;

            if typeof(v11) == "Vector2" then
                v11 = u1:NextNumber(v11.X, v11.Y);
            end;

            local v12 = v11 * (u7 and (math.random(1, 2) == 1 and -1 or 1) or 1);
            local v13 = u3.Radius or math.random(0, 500) / 100;
            local v14 = u3.Duration or math.random(150, 500) / 1000;
            local v15 = os.clock();
            local v16 = not u9 and math.random(-360, 360) or 360 / u4 * (i - 1);
            local v17 = 0;
            local v18 = Trail:Clone();

            if u3.HSVShift then
                ParticleHandler.HSVShiftParticles(v18, u3.HSVShift);
            end;

            if u3.Player or u3.Character then
                ParticleHandler.Unusualify(v18, {
                    Character = u3.Character,
                    Player = u3.Player
                });
            end;

            if u8 then
                ParticleHandler.EnableAllParticles(v18, true);
            end;

            v18.Parent = workspace.Effects;
            task.delay(v14 + 1, v18.Destroy, v18);

            while v18:IsDescendantOf(game) and os.clock() - v15 <= v14 do
                local v19 = typeof(Origin) == "Vector3" and CFrame.new(Origin) or Origin;

                if typeof(v19) == "Instance" then
                    v19 = v19.CFrame;
                end;

                local new = CFrame.new;
                local v20 = math.rad(v16);
                local v21 = math.cos(v20) * v13;
                local v22 = math.rad(v16);
                v18.CFrame = v19 * u5 * new(v21, v17, -math.sin(v22) * v13);
                local v23 = task.wait() * 60;
                v16 = v16 + v12 * v23;
                v17 = v17 + v10 * v23;
            end;

            if not v18:IsDescendantOf(game) then
                return;
            end;

            for _, descendant in ipairs(v18:GetDescendants()) do
                if descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter")) then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.wait(v6);
    end;
end;