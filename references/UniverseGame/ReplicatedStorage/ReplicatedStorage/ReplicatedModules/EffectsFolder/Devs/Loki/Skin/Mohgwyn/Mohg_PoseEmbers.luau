  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(Knit.Util.Trove);
require(Knit.Util.Promise);
require(Knit.Util.TableUtil);
game:GetService("Players");
game:GetService("RunService");

local function Lerp(p1, p2, p3) -- Line: 15
    return p1 + (p2 - p1) * p3;
end;

local _ = CFrame.Angles;
local _ = math.rad;

return function(u4, p5) -- Line: 27
    -- upvalues: ParticleHandler (copy)
    if not u4.Parent then
        warn("No character");

        return;
    end;

    local v6 = p5.SpawnInterval or 0.25;
    local u7 = {};
    local v8 = 0;
    local u9 = Random.new();
    local TrailInstance = p5.TrailInstance;
    local Origin = p5.Origin;

    if typeof(Origin) == "CFrame" then
        Origin = Origin.Position or Origin;
    end;

    local u10 = Origin;

    local function CreateEmber() -- Line: 39
        -- upvalues: u4 (copy), TrailInstance (copy), ParticleHandler (ref), u9 (copy), u10 (ref), u7 (copy)
        if not u4.Parent then
            return;
        end;

        local v11 = TrailInstance:Clone();
        ParticleHandler.Unusualify(v11, {
            Character = u4
        });
        v11.Anchored = true;
        v11.Size = Vector3.new(1, 1, 1);
        local v12 = u9:NextNumber(-3.141592653589793, 3.141592653589793);
        local v13 = math.cos(v12) * 3;
        local v14 = math.sin(v12) * 3;
        local v15 = u10 + Vector3.new(v13, 0, v14);
        v11.Position = v15;
        v11.Parent = workspace.Effects;
        ParticleHandler.EnableAllParticles(v11, true);
        local v16 = {
            Elapsed = 0,
            Ember = v11,
            Speed = Random.new():NextNumber(0.5, 1.5),
            Direction = (v15 - u10).Unit,
            Offsets = { u9:NextNumber(0, 1000), u9:NextNumber(0, 1000), u9:NextNumber(0, 1000) },
            Lifetime = u9:NextNumber(0.8, 1.2)
        };
        table.insert(u7, v16);
    end;

    while u4.Parent and u4:GetAttribute("Posing") do
        local v17 = task.wait();
        v8 = v8 + v17;

        if v6 <= v8 then
            CreateEmber();
            v8 = 0;
        end;

        for i = #u7, 1, -1 do
            local v18 = u7[i];
            local Ember = v18.Ember;
            local Speed = v18.Speed;
            local _ = v18.Elapsed;
            v18.Elapsed = v18.Elapsed + v17;
            local v19 = os.clock();
            local v20 = math.noise(v19 * 3 + v18.Offsets[1], 0);
            local v21 = math.noise(v19 * 2 + v18.Offsets[2]);
            local v22 = math.noise(v19 * 3 + v18.Offsets[3], 0);
            Ember.Position = Ember.Position + (v18.Direction * Vector3.new(0.35, 0, 0.35) * 0.25 + Vector3.new(v20 * 0.35, 0.1 * Speed + v21 * 0.3, v22 * 0.35)) * v17 * 60;

            if v18.Elapsed >= v18.Lifetime then
                v18.Dead = true;
                ParticleHandler.EnableAllParticles(Ember, false);
                task.delay(2, Ember.Destroy, Ember);
                table.remove(u7, i);
            end;
        end;
    end;

    for i = #u7, 1, -1 do
        local v23 = u7[i];
        local Ember = v23.Ember;
        local _ = v23.Speed;
        local _ = v23.Elapsed;

        if not v23.Dead then
            ParticleHandler.EnableAllParticles(Ember, false);
            task.delay(2, Ember.Destroy, Ember);
            table.remove(u7, i);
        end;
    end;
end;