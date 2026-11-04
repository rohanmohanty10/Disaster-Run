 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Activate" then
        SfxManager:playSound({
            Sound = "sfx_shan_air_fire_shot01",
            Parent = HumanoidRootPart
        });
        SfxManager:playSound({
            Sound = "sfx_SC_burner_loop",
            Duration = 3,
            Parent = HumanoidRootPart
        });
        local v3 = script.StartUp:Clone();
        v3.CFrame = HumanoidRootPart.CFrame;
        v3.Parent = Debris;
        Essentials:Weld(v3, HumanoidRootPart);
        VfxManager.Emit(v3);
        VfxManager.DestroyEffect(v3, 1.5);
        local u4 = script.Root:Clone();
        u4:PivotTo(HumanoidRootPart.CFrame);
        u4.Parent = Debris;
        Essentials:Weld(u4.PrimaryPart, HumanoidRootPart);
        VfxManager.Enable(u4, true);
        TweenService:Create(u4.Shield, TweenInfo.new(0.15), {
            Transparency = 0.5
        }):Play();
        task.delay(3, function() -- Line: 46
            -- upvalues: HumanoidRootPart (copy), u4 (copy), VfxManager (ref), TweenService (ref)
            if not HumanoidRootPart then
                return;
            end;

            if not u4 then
                return;
            end;

            VfxManager.Enable(u4, false);
            VfxManager.DestroyEffect(u4, 2);
            TweenService:Create(u4.Shield, TweenInfo.new(0.15), {
                Transparency = 1
            }):Play();
        end);
    end;
end;