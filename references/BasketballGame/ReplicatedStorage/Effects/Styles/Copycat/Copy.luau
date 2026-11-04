 
 

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
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local _ = p2.speed;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local Head = Char:FindFirstChild("Head");
    local _ = Char.Name .. script.Parent.Name .. script.Name;
    SfxManager:playSound({
        Sound = "Copy",
        Parent = HumanoidRootPart
    });

    if p2.Task ~= "Copy" then
        if p2.Task == "AwakeningCopy" then
            local u3 = script.EyeFX:Clone();
            u3.CFrame = Head.CFrame;
            u3.Parent = Debris;
            Essentials:Weld(u3, Head);
            VfxManager.Emit(u3.Emit);
            VfxManager.Enable(u3.Enabling, true);
            task.delay(1, function() -- Line: 56
                -- upvalues: u3 (copy), VfxManager (ref)
                if u3 then
                    VfxManager.Enable(u3.Enabling, false);
                    VfxManager.DestroyEffect(u3, 2);
                end;
            end);
        end;

        return;
    end;

    local v4 = script.StartEmit:Clone();
    v4.CFrame = HumanoidRootPart.CFrame;
    v4.Parent = Debris;
    VfxManager.Emit(v4);
    VfxManager.DestroyEffect(v4, 3);
    local u5 = script.EyeFX:Clone();
    u5.CFrame = Head.CFrame;
    u5.Parent = Debris;
    Essentials:Weld(u5, Head);
    VfxManager.Emit(u5.Emit);
    VfxManager.Enable(u5.Enabling, true);
    task.delay(1, function() -- Line: 42
        -- upvalues: u5 (copy), VfxManager (ref)
        if u5 then
            VfxManager.Enable(u5.Enabling, false);
            VfxManager.DestroyEffect(u5, 2);
        end;
    end);
end;