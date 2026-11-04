 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), VfxManager (copy)
    local Character = p2.Character;
    local _ = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    SfxManager:playSound({
        Sound = "BulletPass",
        Parent = HumanoidRootPart
    });
    local u3 = script.VFX:Clone();
    u3.Parent = workspace.Debris;

    for _, child in u3.Welds:GetChildren() do
        if child:IsA("Weld") then
            child.Part0 = HumanoidRootPart;
            child.Part1 = u3:FindFirstChild(child.Name);
        end;
    end;

    task.delay(0.2, function() -- Line: 32
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Maincharge, true);
        VfxManager.Enable(u3.Sparks, true);
        task.wait(0.8);
        VfxManager.Enable(u3.Maincharge, false);
        VfxManager.Enable(u3.Sparks, false);
        task.wait(0.1);
        VfxManager.Emit(u3["Explosion/impact"]);
        task.wait(3);
        u3:Destroy();
    end);
end;