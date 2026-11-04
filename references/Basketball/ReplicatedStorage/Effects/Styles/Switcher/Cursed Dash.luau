 
 

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

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Activate" then
        if p2.Task == "Blackflash" then
            local Target = p2.Target;
            local v3 = script.BlackFlash:Clone();
            v3.CFrame = Target:FindFirstChild("HumanoidRootPart").CFrame;
            v3.Parent = Debris;
            VfxManager.Emit(v3);
            VfxManager.DestroyEffect(v3, 3);
            SfxManager:playSound({
                Sound = "BBZ Switcher blackflash",
                Parent = v3
            });
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Switcher dash",
        Parent = HumanoidRootPart
    });
    local v4 = script.EnableSlide:Clone();
    v4.CFrame = HumanoidRootPart.CFrame;
    v4.Parent = Debris;
    VfxManager.Enable(v4, true);
    Essentials:Weld(v4, HumanoidRootPart);
    task.wait(1);
    VfxManager.Enable(v4, false);
    VfxManager.DestroyEffect(v4, 3);
end;