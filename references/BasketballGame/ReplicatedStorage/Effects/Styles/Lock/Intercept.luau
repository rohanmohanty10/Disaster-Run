 
 

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
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Activate" then
        SfxManager:playSound({
            Sound = "ineterception grab or catch",
            Parent = HumanoidRootPart
        });
        local v3 = script.StartUp:Clone();
        v3.CFrame = HumanoidRootPart.CFrame;
        v3.Parent = Debris;
        Essentials:Weld(v3, HumanoidRootPart);
        VfxManager.Emit(v3);
        VfxManager.DestroyEffect(v3, 1.5);
        task.wait(0.333);

        if not HumanoidRootPart then
            return;
        end;

        local v4 = script.Catch:Clone();
        v4.CFrame = HumanoidRootPart.CFrame;
        v4.Parent = Debris;
        Essentials:Weld(v4, HumanoidRootPart);
        VfxManager.Emit(v4);
        VfxManager.DestroyEffect(v4, 1.5);
    end;
end;