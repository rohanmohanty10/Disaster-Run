  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 10
    -- upvalues: Essentials (copy), VfxManager (copy)
    local Char = p1.Char;
    local Football = Char:FindFirstChild("Football");
    local BALL = Char:FindFirstChild("BALL", true);
    local u2 = Essentials:CreateClone(Char, 1);
    task.delay(1, function() -- Line: 15
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    local u3 = script.flashstep:Clone();
    u3.Parent = workspace.Debris;
    u3.CFrame = Char:FindFirstChild("HumanoidRootPart").CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
    VfxManager.Enable(u3, true);
    task.delay(0.2, function() -- Line: 22
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3, false);
        task.wait(0.2);
        u3:Destroy();
    end);
    Essentials:HideCharacter(Char, { Football, BALL });
    task.delay(0.7, function() -- Line: 30
        -- upvalues: Char (copy), VfxManager (ref), Essentials (ref), Football (copy), BALL (copy)
        local u4 = script.flashstep:Clone();
        u4.Parent = workspace.Debris;
        u4.CFrame = Char:FindFirstChild("HumanoidRootPart").CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Enable(u4, true);
        task.delay(0.2, function() -- Line: 35
            -- upvalues: VfxManager (ref), u4 (copy)
            VfxManager.Enable(u4, false);
            task.wait(0.2);
            u4:Destroy();
        end);
        Essentials:UnhideCharacter(Char, { Football, BALL });
        task.wait(0.1);
        local u5 = Essentials:CreateClone(Char, 1);
        task.delay(1, function() -- Line: 44
            -- upvalues: u5 (copy)
            u5:Destroy();
        end);
    end);
end;