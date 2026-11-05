  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();
local v2 = RaycastParams.new();
v2.FilterType = Enum.RaycastFilterType.Include;
v2.FilterDescendantsInstances = { workspace.Map };

return function(p3, p4, p5, p6) -- Line: 14
    -- upvalues: EffectsHandler (copy), u1 (copy), ParticleHandler (copy)
    local v7 = os.clock();
    local v8 = p3:FindFirstChild(p5 or "Golden Hook");

    if not v8 then
        return;
    end;

    local HumanoidRootPart = p3.HumanoidRootPart;
    local v9 = os.clock();
    local Dust = v8:FindFirstChild("Dust", true);
    local v10 = p6 or 1;

    while os.clock() - v7 < p4 and (v8:IsDescendantOf(game) and (v8.PrimaryPart and v8.PrimaryPart:IsDescendantOf(game))) do
        local v11 = workspace:Raycast(v8.PrimaryPart.Position, Vector3.new(0, -10, 0));

        if v11 then
            Dust.Color = ColorSequence.new(v11.Instance.Color);
            local v12 = CFrame.new(v11.Position, v11.Position + HumanoidRootPart.CFrame.LookVector);

            if os.clock() - v9 >= 0.018 then
                EffectsHandler.CallEffect("Rock Trail", {
                    Offset = 0.5,
                    Distance = 1,
                    Amount = 1,
                    Duration = 1.5,
                    DurationOffset = 0.1,
                    Down = true,
                    Origin = v12 * CFrame.new(0, 0.5, 0),
                    LookVector = v12.LookVector,
                    Size = u1:NextNumber(0.65, 0.87) * v10
                });
                v9 = os.clock();
            end;
        end;

        ParticleHandler.EnableParticles(v8, v11 ~= nil);
        task.wait(0.02);
    end;

    if v8:IsDescendantOf(game) then
        ParticleHandler.EnableParticles(v8, false);
    end;
end;