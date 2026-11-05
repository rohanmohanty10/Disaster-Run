  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Pirates = ReplicatedStorage:FindFirstChild("Client Assets").Pirates;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

return function(p2) -- Line: 12
    -- upvalues: Pirates (copy), TweenService (copy), u1 (copy), EffectsHandler (copy)
    local Character = p2.Character;
    local Start = p2.Start;
    local _ = Start.LookVector;
    local Distance = p2.Distance;
    local _ = p2.Size;
    local u3 = Start * CFrame.new(0, 0, -Distance);
    local NoSmoke = p2.NoSmoke;
    task.spawn(function() -- Line: 23
        -- upvalues: Pirates (ref), Start (copy), u3 (copy), TweenService (ref), u1 (ref)
        for i = 0, 2 do
            local v4 = Pirates.Cutlass.PierceMeshes.Shockwave:Clone();
            v4.Size = v4.Size - Vector3.new(3, 0.1, 3) * i;
            v4.CFrame = Start:Lerp(u3, (i + 0.5) / 3) * CFrame.Angles(1.5707963267948966, 0, 0);
            v4.Parent = workspace.Effects;
            task.delay(0.65, v4.Destroy, v4);
            TweenService:Create(v4, TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = v4.Size * 1.3,
                CFrame = v4.CFrame * CFrame.Angles(0, u1:NextNumber(0, 6.283185307179586), 0)
            }):Play();
            task.wait(0.025);
        end;
    end);
    local v5 = math.random(5, 7);

    for i = 1, v5 do
        local v6 = Pirates.Cutlass.PierceMeshes.SpeedLine:Clone();
        v6.Size = v6.Size * u1:NextNumber(1.25, 1.5);
        v6.CFrame = Start:Lerp(u3, i / (v5 + 1) + u1:NextNumber(-0.125, 0.075)) * CFrame.new(math.random(-4, 4), math.random(-2, 4), 0) * CFrame.Angles(0, -1.5707963267948966, 0);
        v6.Parent = workspace.Effects;

        if i % 2 == 0 then
            v6.Color = Color3.fromRGB(0, 0, 0);
        end;

        task.delay(0.35, v6.Destroy, v6);
        TweenService:Create(v6, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = Vector3.new(v6.Size.X, 0, 0)
        }):Play();
    end;

    local v7 = Pirates.Cutlass.PierceMeshes.Forward:Clone();
    v7.CFrame = Start * CFrame.Angles(0, -1.5707963267948966, 0);
    v7.Parent = workspace.Effects;
    task.delay(0.5, v7.Destroy, v7);
    TweenService:Create(v7, TweenInfo.new(0.425, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = Vector3.new(Distance, 0, 0),
        CFrame = v7.CFrame * CFrame.new(-Distance / 2, 0, 0)
    }):Play();
    local v8 = Pirates.Cutlass.PierceMeshes.BlackCoil:Clone();
    v8.CFrame = Start * CFrame.Angles(1.5707963267948966, 0, 0);
    v8.Parent = workspace.Effects;
    task.delay(0.65, v8.Destroy, v8);
    TweenService:Create(v8, TweenInfo.new(0.33, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = v8.Size * 1.25 + Vector3.new(0, Distance, 0)
    }):Play();
    TweenService:Create(v8, TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Transparency = 1,
        CFrame = v8.CFrame * CFrame.new(0, -Distance / 2, 0) * CFrame.Angles(0, u1:NextNumber(0, 6.283185307179586), 0)
    }):Play();
    local v9 = Pirates.Cutlass.PierceMeshes.WhiteCoil:Clone();
    v9.CFrame = v7.CFrame;
    v9.Parent = workspace.Effects;
    task.delay(0.4, v9.Destroy, v9);
    local v10 = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    local v11 = {
        Size = Vector3.new(Distance, 0, 0)
    };
    local v12 = v9.CFrame * CFrame.new(-Distance / 2, 0, 0);
    local Angles = CFrame.Angles;
    local v13 = u1:NextNumber(45, 180);
    v11.CFrame = v12 * Angles(math.rad(v13), 0, 0);
    TweenService:Create(v9, v10, v11):Play();
    EffectsHandler.CallEffect("Emit Particle V3", {
        Character = Character,
        Origin = Start,
        Particle = Pirates.Cutlass[NoSmoke and "PierceFollowThroughNoSmoke" or "PierceFollowThrough"]
    });
    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 0.5,
        Size = Vector3.new(1.75, 1.75, 1.75),
        Radius = 7.5,
        Amount = 9,
        Origin = Start
    });
    task.spawn(function() -- Line: 118
        -- upvalues: Start (copy), u3 (copy), EffectsHandler (ref), Distance (copy), u1 (ref)
        for i = 0, 8 do
            local v14 = Start:Lerp(u3, i / 9.5);
            EffectsHandler.CallEffect("Rock Trail", {
                Amount = 2,
                Duration = 1,
                Down = true,
                Origin = v14,
                LookVector = v14.LookVector,
                Offset = 5 - i / 2.15,
                Distance = Distance / 8,
                Size = u1:NextNumber(2, 2.2) - i / 12
            });
            task.wait(0.005);
        end;
    end);
    local v15 = Pirates.Cutlass.PierceMeshes.Release:Clone();
    v15.CFrame = Start * CFrame.Angles(0, u1:NextNumber(0, 6.283185307179586), 0);
    v15.Parent = workspace.Effects;
    task.delay(0.65, v15.Destroy, v15);
    local v16 = v15.Size * 1.5;
    local v17 = v16.Y - v15.Size.Y;
    TweenService:Create(v15, TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = v16,
        CFrame = v15.CFrame * CFrame.Angles(0, u1:NextNumber(0, 6.283185307179586), 0) * CFrame.new(0, v17 / 2, 0)
    }):Play();
end;