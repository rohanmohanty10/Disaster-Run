 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), LocalPlayer (copy), RunService (copy), Essentials (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Dash" then
        local u4 = SfxManager:playSound({
            Sound = "BBZ Quick Speed Blitz",
            Parent = HumanoidRootPart
        });

        if LocalPlayer.Character == Char then
            local FieldOfView = workspace.CurrentCamera.FieldOfView;
            local u6 = RunService.Heartbeat:Connect(function(p5) -- Line: 34
                -- upvalues: FieldOfView (ref), Essentials (ref)
                FieldOfView = Essentials:Lerp(FieldOfView, 100, p5 * 5);
                workspace.CurrentCamera.FieldOfView = FieldOfView;
            end);
            task.delay(1.25 - v3, function() -- Line: 41
                -- upvalues: u6 (copy)
                if u6 then
                    u6:Disconnect();
                end;
            end);
        end;

        local u7 = script.Dash:Clone();
        u7:PivotTo(HumanoidRootPart.CFrame);
        u7.Parent = Debris;
        VfxManager.Enable(u7, true);
        Essentials:Weld(u7.PrimaryPart, HumanoidRootPart);
        task.delay(1.25, function() -- Line: 54
            -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u7 (copy), u4 (copy)
            if HumanoidRootPart then
                VfxManager.Enable(u7, false);
                VfxManager.DestroyEffect(u7, 3);
            end;

            if u4 then
                u4:Destroy();
            end;
        end);
    end;
end;