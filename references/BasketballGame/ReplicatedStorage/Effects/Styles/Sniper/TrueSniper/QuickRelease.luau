 
 

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
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), VfxManager (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Value = ReplicatedStorage.Basketball.Value;
    SfxManager:playSound({
        Sound = "QuickRelease",
        Duration = 2,
        Parent = workspace
    });
    task.delay(0.3 - v3 / 1.25, function() -- Line: 23
        -- upvalues: HumanoidRootPart (copy), Value (copy), VfxManager (ref)
        local v4 = script.Attachs.Attachment:Clone();
        v4.Parent = HumanoidRootPart;
        task.delay(0.1, function() -- Line: 27
            -- upvalues: Value (ref), VfxManager (ref)
            if Value then
                for _, child in script["B-Ball"]:GetChildren() do
                    local u5 = child:Clone();
                    u5.Parent = Value;

                    if u5:IsA("ParticleEmitter") then
                        task.delay(1, function() -- Line: 34
                            -- upvalues: u5 (ref)
                            u5.Enabled = false;
                            task.wait(5);
                            u5:Destroy();
                        end);
                    elseif u5:IsA("Attachment") then
                        task.delay(1, function() -- Line: 40
                            -- upvalues: VfxManager (ref), u5 (ref)
                            VfxManager.Enable(u5, false);
                            task.wait(5);
                            u5:Destroy();
                        end);
                    end;
                end;
            end;
        end);
        VfxManager.Emit(v4);
        task.wait(3);
        v4:Destroy();
    end);
end;