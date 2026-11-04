 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 14
    -- upvalues: SfxManager (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    SfxManager:playSound({
        Sound = "ChargeGiant",
        Parent = HumanoidRootPart
    });
    local v3 = script.Impact:Clone();
    v3.Parent = workspace.Debris;
    v3:PivotTo(HumanoidRootPart.CFrame);
    VfxManager.Emit(v3);
    TweenService:Create(v3.Root.Lights.PointLight, TweenInfo.new(0.4), {
        Brightness = 0
    }):Play();
    task.delay(3, v3.Destroy, v3);
end;