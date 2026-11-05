  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
ReplicatedStorage:FindFirstChild("Client Assets");
local Part = Instance.new("Part");
Part.Anchored = false;
Part.CanCollide = true;
Part.Massless = true;
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Whitelist;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();

return function(p3) -- Line: 20
    -- upvalues: Part (copy), u1 (copy), u2 (copy), ParticleHandler (copy), TweenService (copy)
    if p3.Origin == nil then
        return;
    end;

    local v4 = typeof(p3.Origin) == "CFrame" and p3.Origin.Position or p3.Origin;
    local v5 = math.max(p3.Lifetime or 1, 0.5);
    local v6 = math.clamp(p3.TweenDelay or 0, 0, v5);
    local v7 = p3.Amount or 6;
    local _ = p3.Collision or false;
    local v8 = p3.Force or Vector3.new(25, 25, 25);
    local v9 = p3.Size and (typeof(p3.Size) == "number" and Vector3.new(1, 1, 1) * p3.Size or (p3.Size or Vector3.new(2.5, 2.5, 2.5))) or Vector3.new(2.5, 2.5, 2.5);
    local v10 = p3.Preset or Part;
    local v11 = p3.Inconsistent or false;
    local v12 = p3.UseRawForce or false;
    local v13 = {};
    local u14 = {};

    for _ = 1, v7 do
        local v15 = workspace:Raycast(v4, Vector3.new(0, -8.5, 0), u1);

        if v15 then
            table.insert(v13, v15);
        end;
    end;

    for i, v in v13 do
        local u16 = v10:Clone();
        u16.Size = v9 * (v11 and u2:NextNumber(0.75, 1.5) or 1);
        u16.Color = p3.Color or v.Instance.Color;
        u16.Material = p3.Material or v.Material;
        u16.TopSurface = Enum.SurfaceType.Smooth;
        u16.BottomSurface = Enum.SurfaceType.Smooth;
        u16.CanCollide = true;
        u16.CollisionGroup = p3.Collision == true and "Ghosted" or "NoCollision";
        local v17 = CFrame.new(v.Position);
        local Angles = CFrame.Angles;
        local v18 = math.random(-180, 180);
        local v19 = math.rad(v18);
        local v20 = math.random(-180, 180);
        local v21 = math.rad(v20);
        local v22 = math.random(-180, 180);
        u16.CFrame = v17 * Angles(v19, v21, (math.rad(v22)));

        if p3.HSVShift then
            ParticleHandler.HSVShiftParticles(u16, p3.HSVShift);
        end;

        u16.Parent = workspace.Effects;

        if not p3.NoTextures then
            local v23 = next;
            local v24, v25 = v.Instance:GetChildren();

            for _, v2 in v23, v24, v25 do
                if v2:IsA("Decal") then
                    Instance.fromExisting(v2).Parent = u16;
                end;
            end;
        end;

        if p3.Tween then
            local v26 = TweenService:Create(u16, TweenInfo.new(v5 - v6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), p3.Tween);
            task.delay(v6, v26.Play, v26);
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000);
        local v27;

        if v12 then
            v27 = Vector3.new(1, 1, 1);
        else
            local v28 = math.sin(i * 2 * 3.141592653589793 / v7);
            local v29 = math.cos(i * 2 * 3.141592653589793 / v7);
            v27 = Vector3.new(v28, 1, v29) or Vector3.new(1, 1, 1);
        end;

        BodyVelocity.Velocity = v8 * v27 * (v11 and u2:NextNumber(0.6, 1.5) or 1);
        BodyVelocity.Parent = u16;
        task.delay(0.15, BodyVelocity.Destroy, BodyVelocity);
        task.delay(v5 - (p3.TweenDelay or 0.5) / 2, function() -- Line: 84
            -- upvalues: u16 (copy)
            local v30 = next;
            local v31, v32 = u16:GetDescendants();

            for _, v2 in v30, v31, v32 do
                if v2:IsA("Beam") or (v2:IsA("Trail") or v2:IsA("ParticleEmitter")) then
                    v2.Enabled = false;
                end;
            end;
        end);
        table.insert(u14, u16);
    end;

    task.delay(v5, function() -- Line: 93
        -- upvalues: u14 (copy)
        for _, v in next, u14 do
            v:Destroy();
        end;
    end);
end;