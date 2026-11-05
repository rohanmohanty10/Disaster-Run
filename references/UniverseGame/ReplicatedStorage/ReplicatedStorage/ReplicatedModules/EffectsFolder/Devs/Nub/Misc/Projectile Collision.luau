  

 

local _ = game.ReplicatedStorage["Client Assets"];
local u1 = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("debrisSlamFunction");
local Sound = Instance.new("Sound");

local function createsound(p2, p3) -- Line: 7
    -- upvalues: Sound (copy)
    local v4 = Sound:Clone();

    for i, v in pairs(p3) do
        v4[i] = v;
    end;

    v4.SoundId = "rbxassetid://" .. p2;

    return v4;
end;

return function(p5) -- Line: 16
    -- upvalues: u1 (copy), Sound (copy)
    if not p5.RaycastResult then
        return;
    end;

    local RaycastResult = p5.RaycastResult;
    local v6 = p5.Projectile:Clone();
    local v7 = CFrame.new(RaycastResult.Position, RaycastResult.Position + RaycastResult.Normal);

    if p5.ProjectileOffset then
        v7 = v7 * p5.ProjectileOffset;
    end;

    v6.CFrame = v7;
    v6.Parent = workspace.Effects;
    task.delay(3, v6.Destroy, v6);

    if RaycastResult.Instance.Name ~= "Windwall" then
        task.spawn(u1, p5.Character, v7, true);
    end;

    local v8 = p5.CollisionSounds and (p5.CollisionSounds[RaycastResult.Instance.Material.Name] or p5.CollisionSounds.Default);

    if v8 then
        local ID = v8.ID;
        local Props = v8.Props;
        local v9 = Sound:Clone();

        for i, v in pairs(Props) do
            v9[i] = v;
        end;

        v9.SoundId = "rbxassetid://" .. ID;
        v9.Parent = v6;
        v9:Play();
    end;
end;