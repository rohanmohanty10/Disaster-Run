  

 

local v1 = script:FindFirstAncestor("ReplicatedModules");
require(v1.EffectsHandler);
local ParticleHandler = require(v1.ReplicatedLibrary.ParticleHandler);
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");

return function(p2, p3, p4) -- Line: 8
    -- upvalues: ParticleHandler (copy), RunService (copy), TweenService (copy)
    local v5 = p4 or {};
    local v6 = v5.Parent or workspace.Effects;
    local v7 = v6:FindFirstChild(p2, true);

    if not v7 then
        local v8 = os.clock() + 5;

        repeat
            v7 = v6.DescendantAdded:Wait();
        until v7.Name == p2 or v8 <= os.clock();

        if not v7 or v7.Name ~= p2 then
            return;
        end;
    end;

    if v5.Serialize or not p3 then
        p3 = ParticleHandler.GenerateEmitInfo(v7);
    end;

    RunService.Heartbeat:Wait();
    ParticleHandler.Emit(v7, p3);

    if v5.Lifetime then
        for _, descendant in ipairs(v7:GetDescendants()) do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(v5.Lifetime), {
                    Transparency = v5.Transparency or 1
                }):Play();
            end;
        end;
    end;
end;