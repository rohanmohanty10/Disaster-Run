 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: Debris (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");

    if p2.Task ~= "Bounce" then
        if p2.Task == "Pass" then
            local BALL = Char:FindFirstChild("BALL", true);
            local v4 = script.Weld:Clone();
            v4.CFrame = BALL.CFrame;
            v4.Parent = Debris;
            Essentials.Weld(v4, BALL);
            VfxManager.Enable(v4, true);
            VfxManager.DestroyEffect(v4, 2);
            SfxManager:playSound({
                Sound = "BBZ Gambler Roundabout Pass",
                Parent = HumanoidRootPart
            });
            task.wait(0.233 - v3);

            if not HumanoidRootPart then
                return;
            end;

            local v5 = script.Release:Clone();
            v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.8080291748046875, 1.2548866271972656, -1.7247085571289062) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v5.Parent = Debris;
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 3);
            VfxManager.Enable(v4, false);
        end;

        return;
    end;

    local BALL = Char:FindFirstChild("BALL", true);
    local v6 = script.Weld:Clone();
    v6.CFrame = BALL.CFrame;
    v6.Parent = Debris;
    Essentials.Weld(v6, BALL);
    VfxManager.Enable(v6, true);
    VfxManager.DestroyEffect(v6, 4);
    SfxManager:playSound({
        Sound = "BBZ Gambler Dribble",
        Parent = HumanoidRootPart
    });
    task.wait(0.233 - v3);

    if not HumanoidRootPart then
        return;
    end;

    local v7 = script.Release:Clone();
    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.8080291748046875, 1.2548866271972656, -1.7247085571289062) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    v7.Parent = Debris;
    VfxManager.Emit(v7);
    VfxManager.DestroyEffect(v7, 3);
    task.wait(0.067);

    if not HumanoidRootPart then
        return;
    end;

    local v8 = script.Impact1:Clone();
    v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(6.462909698486328, -3.246119499206543, -6.182899475097656) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
    v8.Parent = Debris;
    VfxManager.Emit(v8);
    VfxManager.DestroyEffect(v8, 3);
    task.wait(0.483);

    if not HumanoidRootPart then
        return;
    end;

    local v9 = script.Ball_Emit:Clone();
    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.3008155822753906, 0.5380284786224365, -1.469329833984375) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    v9.Parent = Debris;
    VfxManager.Emit(v9);
    VfxManager.DestroyEffect(v9, 3);
    VfxManager.Enable(v6, false);
end;