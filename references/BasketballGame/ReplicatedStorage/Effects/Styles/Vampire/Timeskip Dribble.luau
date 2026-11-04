 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), Debris (copy), VfxManager (copy), SfxManager (copy)
    local _ = p2.TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);
    local _ = workspace:GetServerTimeNow() - p2.previousTime + p2.passedTime;

    if p2.Task == "Activate" then
        local v3 = script.TP1:Clone();
        v3.CFrame = HumanoidRootPart.CFrame;
        v3.Parent = Debris;
        VfxManager.Emit(v3);
        VfxManager.DestroyEffect(v3, 3);
        SfxManager:playSound({
            Sound = script.firstTp,
            Parent = HumanoidRootPart
        });
        task.delay(0.4166666666666667, function() -- Line: 39
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            local v4 = script.TP1:Clone();
            v4.CFrame = HumanoidRootPart.CFrame;
            v4.Parent = Debris;
            VfxManager.Emit(v4);
            VfxManager.DestroyEffect(v4, 3);
        end);

        return;
    end;

    if p2.Task ~= "Dash" then
        if p2.Task == "back" then
            local v5 = script.TP1:Clone();
            v5.CFrame = HumanoidRootPart.CFrame;
            v5.Parent = Debris;
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 3);
            SfxManager:playSound({
                Sound = "DioTimeskip",
                Parent = HumanoidRootPart
            });
        end;

        return;
    end;

    local v6 = script.TP1:Clone();
    v6.CFrame = HumanoidRootPart.CFrame;
    v6.Parent = Debris;
    VfxManager.Emit(v6);
    VfxManager.DestroyEffect(v6, 3);
    SfxManager:playSound({
        Sound = "DioTimeskip",
        Parent = HumanoidRootPart
    });
end;