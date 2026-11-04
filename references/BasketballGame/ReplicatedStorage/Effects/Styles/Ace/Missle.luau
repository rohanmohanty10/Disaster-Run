 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), RunService (copy), Essentials (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Activate" then
        if LocalPlayer.Character == Char then
            local FieldOfView = workspace.CurrentCamera.FieldOfView;
            local u5 = RunService.Heartbeat:Connect(function(p4) -- Line: 35
                -- upvalues: FieldOfView (ref), Essentials (ref)
                FieldOfView = Essentials:Lerp(FieldOfView, 50, p4 * 5);
                workspace.CurrentCamera.FieldOfView = FieldOfView;
            end);
            task.delay(1.317 - v3, function() -- Line: 42
                -- upvalues: u5 (ref)
                if u5 then
                    u5:Disconnect();
                end;
            end);
        end;

        task.delay(0.217 - v3, function() -- Line: 49
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v6 = script.Startup:Clone();
                v6.CFrame = HumanoidRootPart.CFrame;
                v6.Parent = Debris;
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 3);
            end;
        end);
        task.delay(0.817 - v3, function() -- Line: 60
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v7 = script.Shoot:Clone();
                v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.23112060129642487, 3.373049259185791, -2.256103515625) * CFrame.fromEulerAnglesYXZ(1.134293794631958, 3.059861898422241, 3.138363838195801);
                v7.Parent = Debris;
                VfxManager.Emit(v7);
                VfxManager.DestroyEffect(v7, 3);
            end;
        end);
    end;
end;