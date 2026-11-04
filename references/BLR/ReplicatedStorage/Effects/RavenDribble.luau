  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 10
    -- upvalues: Essentials (copy), TweenService (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local State = p1.State;

    if State ~= "Start" then
        if State == "Clone" then
            local v2 = tick() + 0.1;

            repeat
                task.wait(0.03);
                local u3 = Essentials:CreateClone(Char);
                task.delay(0.5, function() -- Line: 40
                    -- upvalues: u3 (copy)
                    u3:Destroy();
                end);
            until v2 <= tick();
        end;

        return;
    end;

    local u4 = script.RootFX:Clone();
    u4.Parent = Char;
    u4.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(HumanoidRootPart, u4);
    task.delay(0.8, function() -- Line: 21
        -- upvalues: u4 (copy), TweenService (ref)
        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            elseif descendant:IsA("Trail") then
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    Lifetime = 0
                }):Play();
            elseif descendant:IsA("Beam") then
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    Width1 = 0,
                    Width0 = 0
                }):Play();
            end;
        end;

        task.wait(1);
        u4:Destroy();
    end);
end;