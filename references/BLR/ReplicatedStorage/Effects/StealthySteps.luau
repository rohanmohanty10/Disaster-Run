  

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

    if Char.Values.HasBall.Value then
        return;
    end;

    task.delay(1, function() -- Line: 18
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    local u3 = script.flashstep:Clone();
    u3.Parent = workspace.Debris;
    u3.CFrame = Char:FindFirstChild("HumanoidRootPart").CFrame;
    VfxManager.Enable(u3, true);
    task.delay(0.2, function() -- Line: 25
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3, false);
        task.wait(0.2);
        u3:Destroy();
    end);
    local u4 = Essentials:HideCosmetics(Char);
    Essentials:HideCharacter(Char, { Football, BALL });
    task.delay(3.5, function() -- Line: 34
        -- upvalues: Char (copy), VfxManager (ref), Essentials (ref), Football (copy), BALL (copy), u4 (copy)
        local u5 = script.flashstep:Clone();
        u5.Parent = workspace.Debris;
        u5.CFrame = Char:FindFirstChild("HumanoidRootPart").CFrame;
        VfxManager.Enable(u5, true);
        task.delay(0.2, function() -- Line: 39
            -- upvalues: VfxManager (ref), u5 (copy)
            VfxManager.Enable(u5, false);
            task.wait(0.2);
            u5:Destroy();
        end);
        Essentials:UnhideCharacter(Char, { Football, BALL });
        Essentials:UnhideCosmetics(u4);
        task.wait(0.1);
        local u6 = Essentials:CreateClone(Char, 1);
        task.delay(1, function() -- Line: 48
            -- upvalues: u6 (copy)
            u6:Destroy();
        end);
    end);
end;