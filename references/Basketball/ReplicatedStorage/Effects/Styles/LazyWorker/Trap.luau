 
 

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
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Shoot" then
        SfxManager:playSound({
            Sound = "BBZ LazyWorker longshot",
            Parent = HumanoidRootPart
        });
        local v3 = script.throw:Clone();
        v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.14499664306640625, 2.0109992027282715, -4.488075256347656) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
        v3.Parent = Debris;
        VfxManager.Emit(v3);
        VfxManager.DestroyEffect(v3, 3);
    end;
end;