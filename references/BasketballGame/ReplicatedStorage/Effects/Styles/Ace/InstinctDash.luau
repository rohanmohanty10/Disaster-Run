 
 

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
    local BallController = p1.BallController;

    if p2.Task == "Activate" then
        local u4;

        if LocalPlayer.Character == Char then
            local FieldOfView = workspace.CurrentCamera.FieldOfView;
            u4 = RunService.Heartbeat:Connect(function(p5) -- Line: 37
                -- upvalues: FieldOfView (ref), Essentials (ref)
                FieldOfView = Essentials:Lerp(FieldOfView, 110, p5 * 5);
                workspace.CurrentCamera.FieldOfView = FieldOfView;
            end);
            task.delay(0.7903703703703703 - v3, function() -- Line: 44
                -- upvalues: u4 (ref)
                if u4 then
                    u4:Disconnect();
                end;
            end);
        else
            u4 = nil;
        end;

        local u6 = nil;
        task.delay(0.1237037037037037 - v3, function() -- Line: 53
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u6 (ref), Essentials (ref)
            if HumanoidRootPart then
                local v7 = script.Startup:Clone();
                v7.CFrame = HumanoidRootPart.CFrame;
                v7.Parent = Debris;
                VfxManager.Emit(v7);
                VfxManager.DestroyEffect(v7, 3);
                u6 = script.Enable:Clone();
                u6:PivotTo(HumanoidRootPart.CFrame);
                u6.Parent = Debris;
                VfxManager.Enable(u6, true);
                Essentials:Weld(u6.PrimaryPart, HumanoidRootPart);
            end;
        end);
        task.delay(0.7903703703703703 - v3, function() -- Line: 69
            -- upvalues: HumanoidRootPart (copy), u6 (ref), VfxManager (ref)
            if HumanoidRootPart and u6 then
                VfxManager.Enable(u6, false);
                VfxManager.DestroyEffect(u6, 3);
            end;
        end);
        local u8 = nil;
        u8 = RunService.RenderStepped:Connect(function() -- Line: 79
            -- upvalues: BallController (copy), Char (copy), u4 (ref), u8 (ref), u6 (ref), VfxManager (ref)
            if BallController:GetCharacterPossessingBall() ~= Char then
                return;
            end;

            if u4 then
                u4:Disconnect();
            end;

            u8:Disconnect();

            if u6 then
                VfxManager.Enable(u6, false);
                VfxManager.DestroyEffect(u6, 3);
            end;
        end);
        task.delay(0.7903703703703703 - v3, function() -- Line: 101
            -- upvalues: u8 (ref)
            u8:Disconnect();
        end);
    end;
end;