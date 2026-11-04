  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 11
    -- upvalues: VfxManager (copy)
    local Char = p1.Char;
    local u2 = script.Blizzard:Clone();
    u2.Parent = workspace.Debris;
    VfxManager.Emit(u2);
    VfxManager.Enable(u2, true);
    local v3 = game["Run Service"].Heartbeat:Connect(function() -- Line: 22
        -- upvalues: u2 (copy), Char (copy)
        u2:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0));
    end);
    local os_clock_ret = os.clock();

    repeat
        task.wait();
    until Char and Char:GetAttribute("DomainEnd") or os.clock() - os_clock_ret > p1.Duration;

    VfxManager.Enable(u2, false);
    local TweenService = game:GetService("TweenService");
    (function(p4, p5) -- Line: 33, Name: TweenBeamsToZero
        -- upvalues: TweenService (copy)
        p4:GetDescendants();
        local TweenInfo_new_ret = TweenInfo.new(p5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);

        for _, descendant in p4:GetDescendants() do
            if descendant:IsA("Beam") then
                TweenService:Create(descendant, TweenInfo_new_ret, {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end)(u2, 1);
    task.wait(1);
    v3:Disconnect();
    u2:Destroy();
end;