  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 19
    -- upvalues: u1 (copy), AssetHandler (copy), u2 (copy), ParticleHandler (copy)
    local Part = p3.Part;
    local Origin = p3.Origin;
    local v4 = p3.TrailRange and math.random(p3.TrailRange.Min, p3.TrailRange.Max) or math.random(3, 7);
    local v5 = p3.Interval or 0.015;
    local v6 = p3.Offset or CFrame.identity;
    local v7 = p3.DirectionOffset or Vector3.new(0, 0, 0);
    local v8 = p3.Trail or "Particles/Mes/BloodRay";
    local u9 = p3.Slam or "Particles/Mes/BloodSplatter";
    local u10 = p3.Path or {
        AbilityName = "Ope",
        SkinName = p3.SkinName
    };
    local v11 = p3.SpeedScale or 1;

    if not (Part or Origin) then
        return;
    end;

    if typeof(Part) == "Instance" and Part:IsA("Model") then
        if p3.SearchPart then
            Part = Part:FindFirstChild(p3.SearchPart);
        else
            Part = Part.PrimaryPart;
        end;
    end;

    if Part then
        Origin = Part.CFrame or Origin;
    end;

    if Origin == nil then
        return;
    end;

    for _ = 1, v4 do
        local Angles = CFrame.Angles;
        local v12 = u1:NextNumber(45, 90);
        local u13 = (Origin * Angles(math.rad(v12), u1:NextNumber(0, 6.283185307179586), 0)).LookVector * u1:NextNumber(12, 17) + v7 * v11;
        local u14 = AssetHandler.GetAsset(v8, u10):Clone();
        u14.Position = (Origin * v6).Position;
        u14.Parent = workspace.Effects;
        task.spawn(function() -- Line: 55
            -- upvalues: u14 (copy), u13 (ref), u2 (ref), AssetHandler (ref), u9 (copy), u10 (copy), ParticleHandler (ref)
            for _ = 1, 100 do
                local v15 = task.wait() * 2;
                local v16 = workspace:Raycast(u14.Position, u13 * v15, u2);

                if v16 then
                    u14.Position = v16.Position;
                    local v17 = AssetHandler.GetAsset(u9, u10):Clone();
                    v17.CFrame = CFrame.new(v16.Position, v16.Position + v16.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
                    v17.Parent = workspace.Effects;
                    ParticleHandler.DestroyEmit(v17);
                    ParticleHandler.Emit(v17, ParticleHandler.GenerateEmitInfo(v17));
                    break;
                end;

                u13 = u13 - Vector3.new(0, 45, 0) * v15;
                local v18 = u14;
                v18.Position = v18.Position + u13 * v15;
            end;

            for _, descendant in u14:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(4, u14.Destroy, u14);
        end);
        task.wait(v5);
    end;
end;