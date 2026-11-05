  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local XenoFunctions = require(ReplicatedStorage.ReplicatedModules.XenoFunctions);
local u1 = EffectsHandler.GetEffect("checkProperty");
local u2 = ReplicatedStorage["Client Assets"];

return function(u3, u4) -- Line: 10
    -- upvalues: u1 (copy), XenoFunctions (copy), u2 (copy), TweenService (copy)
    if pcall(function() -- Line: 12
        -- upvalues: u1 (ref), u4 (copy)
        u1(u4, "Position");
    end) then
        u4 = u4.Position;
    end;

    local u5 = {};
    local v6 = {
        DebrisPositions = { u4, math.random(11, 14), math.random(6, 9) }
    };
    local v7 = {
        Speed = 0.5,
        Range = math.random(1, 3),
        Duration = math.random(1, 4),
        origPos = u4
    };
    local v8 = math.random(30, 50) / 10;
    local v9 = math.random(30, 50) / 10;
    local v10 = math.random(30, 50) / 10;
    v7.newSize = Vector3.new(v8, v9, v10);
    v6.Properties = v7;
    u5.RoadRoller = v6;
    local v11 = {
        DebrisPositions = { u4, math.random(8, 11), math.random(3, 5) }
    };
    local v12 = {
        Speed = 0.75,
        Range = math.random(5, 15) / 10,
        Duration = math.random(1, 3),
        origPos = u4
    };
    local v13 = math.random(15, 20) / 10;
    local v14 = math.random(15, 20) / 10;
    local v15 = math.random(15, 20) / 10;
    v12.newSize = Vector3.new(v13, v14, v15);
    v11.Properties = v12;
    u5.GenericSlam = v11;
    local v16 = {
        DebrisPositions = { u4, math.random(19, 23), math.random(11, 14) }
    };
    local v17 = {
        Speed = 0.5,
        Range = math.random(1, 3),
        Duration = math.random(1, 2),
        origPos = u4
    };
    local v18 = math.random(15, 20) / 8;
    local v19 = math.random(15, 20) / 8;
    local v20 = math.random(15, 20) / 8;
    v17.newSize = Vector3.new(v18, v19, v20);
    v16.Properties = v17;
    u5.WideSlam = v16;
    local v21 = {
        DebrisPositions = { u4, math.random(23, 26), math.random(13, 15) }
    };
    local v22 = {
        Speed = 0.5,
        Range = math.random(2, 5),
        Duration = math.random(1, 4),
        origPos = u4
    };
    local v23 = math.random(30, 50) / 10;
    local v24 = math.random(30, 50) / 10;
    local v25 = math.random(30, 50) / 10;
    v22.newSize = Vector3.new(v23, v24, v25);
    v21.Properties = v22;
    u5.LargeSlam = v21;
    local v26 = {
        DebrisPositions = { u4, math.random(29, 32), math.random(20, 24) }
    };
    local v27 = {
        Speed = 0.5,
        Range = math.random(1, 3),
        Duration = math.random(2, 4),
        origPos = u4
    };
    local v28 = math.random(15, 20) / 3;
    local v29 = math.random(15, 20) / 3;
    local v30 = math.random(15, 20) / 3;
    v27.newSize = Vector3.new(v28, v29, v30);
    v26.Properties = v27;
    u5.BrolyExplosion = v26;
    local v31 = XenoFunctions.createCircle(unpack(u5[u3].DebrisPositions));

    for i = 1, #v31 do
        local v32 = XenoFunctions.RayCastOnMap(v31[i], Vector3.new(0, -15, 0), true);

        if v32 then
            XenoFunctions.spawnRubble(v32.Instance, v32.Position, u5[u3].Properties);
        end;
    end;

    coroutine.wrap(function() -- Line: 55
        -- upvalues: u2 (ref), XenoFunctions (ref), u4 (ref), u5 (copy), u3 (copy), TweenService (ref)
        local v33 = u2.Universal.CrackTexture:Clone();
        local v34 = XenoFunctions.RayCastOnMap(u4, Vector3.new(0, -15, 0));
        local v35 = u5[u3].DebrisPositions[3];
        local v36 = u5[u3].Properties.Speed + u5[u3].Properties.Duration;
        v33.Parent = workspace.Effects;
        v33.Position = v34 + Vector3.new(0, 0.05, 0);
        v33.Size = Vector3.new(v35, 0.05, v35) * 2;
        wait(v36);
        TweenService:Create(v33.Decal, TweenInfo.new(v36 / 2), {
            Transparency = 1
        }):Play();
        wait(v36 / 2);
        v33:Destroy();
    end)();
end;