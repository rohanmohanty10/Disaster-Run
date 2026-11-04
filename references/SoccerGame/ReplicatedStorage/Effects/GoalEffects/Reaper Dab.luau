  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;
Random.new(os.clock());

return function(p2) -- Line: 14
    -- upvalues: u1 (copy), EmitModule (copy)
    local _ = game.Players.LocalPlayer;
    local u3 = script.GE:Clone();
    u3.Parent = u1;
    u3:PivotTo(p2.Pos);

    if u3:IsA("BasePart") then
        u3.Anchored = true;
        u3.CanCollide = false;
        u3.Transparency = 1;
    end;

    for _, child in u3:GetChildren() do
        if child:IsA("BasePart") then
            child.Anchored = true;
            child.CanCollide = false;
            child.Transparency = 1;
        end;
    end;

    EmitModule.emit(u3);
    local u4 = script.ReaperRig:Clone();
    u4.Parent = u1;
    u4:PivotTo(p2.Pos * CFrame.Angles(0, 1.5707963267948966, 0));

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Anchored = false;
            descendant.Massless = true;
        end;
    end;

    u4.RootPart.Anchored = true;
    local v5 = u4:FindFirstChildWhichIsA("AnimationController");

    if v5 then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://130396216359248";
        local v6 = v5:LoadAnimation(Animation);
        v6.Looped = false;
        v6:Play();
        v6.Stopped:Once(function() -- Line: 59
            -- upvalues: u4 (copy)
            u4:Destroy();
        end);
    else
        task.delay(8, function() -- Line: 63
            -- upvalues: u4 (copy)
            u4:Destroy();
        end);
    end;

    task.delay(8, function() -- Line: 68
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;