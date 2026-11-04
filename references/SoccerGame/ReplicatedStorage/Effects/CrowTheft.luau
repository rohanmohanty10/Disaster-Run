  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 10
    -- upvalues: Essentials (copy), TweenService (copy), VfxManager (copy)
    local State = p1.State;
    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");

    if State ~= "Start" then
        local v2 = State == "Steal" and workspace:FindFirstChild("Football", true);

        if v2 then
            local u3 = script.StealingBallEmit:Clone();
            u3.Parent = workspace.Debris;
            u3.Position = v2.Position + Vector3.new(0, 3, 0);
            VfxManager.Emit(u3);
            task.delay(3.5, function() -- Line: 40
                -- upvalues: u3 (copy)
                u3:Destroy();
            end);
        end;

        return;
    end;

    local u4 = script.RunningFX:Clone();
    u4.Parent = workspace.Debris;
    u4.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(u4, HumanoidRootPart);
    task.delay(3, function() -- Line: 20
        -- upvalues: u4 (copy), TweenService (ref)
        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            elseif descendant:IsA("Trail") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Lifetime = 0
                }):Play();
            elseif descendant:IsA("Beam") then
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Width1 = 0,
                    Width0 = 0
                }):Play();
            end;
        end;

        task.wait(1);
        u4:Destroy();
    end);
end;