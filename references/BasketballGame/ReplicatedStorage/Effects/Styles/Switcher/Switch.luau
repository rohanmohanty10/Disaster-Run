 
 

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
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Switch" then
        local YourPos = p2.YourPos;
        local TargetPos = p2.TargetPos;
        local v3 = script.clap:Clone();
        v3.CFrame = YourPos;
        v3.Parent = Debris;
        VfxManager.Emit(v3);
        VfxManager.DestroyEffect(v3, 3);
        local v4 = script.TP:Clone();
        v4.CFrame = TargetPos;
        v4.Parent = Debris;
        VfxManager.Emit(v4);
        VfxManager.DestroyEffect(v4, 3);
        SfxManager:playSound({
            Sound = "BBZ Switcher cursed energy hit",
            Parent = v4
        });
    end;
end;