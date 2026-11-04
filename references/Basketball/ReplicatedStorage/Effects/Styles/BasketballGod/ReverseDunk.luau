 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), LocalPlayer (copy), RunService (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Dribble" then
        if p2.Task == "Dunk" then
            SfxManager:playSound({
                Sound = "BBZ BasketballGod Dunk2",
                Parent = HumanoidRootPart
            });
            local u4 = script.Aura:Clone();
            u4.CFrame = HumanoidRootPart.CFrame;
            u4.Parent = Debris;
            Essentials:Weld(u4, HumanoidRootPart);
            VfxManager.Enable(u4, true);
            local v5 = script.JumpForDunk:Clone();
            v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-4.4020998757332563e-7, -2.3926916122436523, 0.5039215087890625) * CFrame.fromEulerAnglesYXZ(-0, -8.735765391065797e-7, 0);
            v5.Parent = Debris;
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 3);
            task.delay(0.8 - v3, function() -- Line: 125
                -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u4 (copy)
                if HumanoidRootPart then
                    VfxManager.Enable(u4, false);
                    VfxManager.DestroyEffect(u4, 3);
                end;
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ BasketballGod Size Up",
        Parent = HumanoidRootPart
    });
    local u6 = script.Aura:Clone();
    u6.CFrame = HumanoidRootPart.CFrame;
    u6.Parent = Debris;
    Essentials:Weld(u6, HumanoidRootPart);

    if LocalPlayer.Character == Char then
        local FieldOfView = workspace.CurrentCamera.FieldOfView;
        local u8 = RunService.Heartbeat:Connect(function(p7) -- Line: 40
            -- upvalues: FieldOfView (ref), Essentials (ref)
            FieldOfView = Essentials:Lerp(FieldOfView, 40, p7 * 5);
            workspace.CurrentCamera.FieldOfView = FieldOfView;
        end);
        task.delay(1.117 - v3, function() -- Line: 47
            -- upvalues: u8 (copy)
            if u8 then
                u8:Disconnect();
            end;
        end);
    end;

    task.delay(0.233 - v3, function() -- Line: 54
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u6 (copy), Debris (ref), TweenService (ref)
        if HumanoidRootPart then
            VfxManager.Enable(u6, true);
            local v9 = script.Dribble0:Clone();
            v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.254738450050354, -2.772651195526123, -0.49127197265625) * CFrame.fromEulerAnglesYXZ(-0, 3.141591787338257, 0);
            v9.Parent = Debris;
            v9.Light.PointLight.Brightness = 4;
            TweenService:Create(v9.Light.PointLight, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 3);
        end;
    end);
    task.delay(0.483 - v3, function() -- Line: 69
        -- upvalues: HumanoidRootPart (copy), Debris (ref), TweenService (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v10 = script.Dribble0:Clone();
            v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.254738450050354, -2.772651195526123, -0.49127197265625) * CFrame.fromEulerAnglesYXZ(-0, 3.141591787338257, 0);
            v10.Parent = Debris;
            v10.Light.PointLight.Brightness = 4;
            TweenService:Create(v10.Light.PointLight, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 3);
        end;
    end);
    task.delay(0.833 - v3, function() -- Line: 81
        -- upvalues: HumanoidRootPart (copy), Debris (ref), TweenService (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v11 = script.Dribble0:Clone();
            v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.254738450050354, -2.772651195526123, -0.49127197265625) * CFrame.fromEulerAnglesYXZ(-0, 3.141591787338257, 0);
            v11.Parent = Debris;
            v11.Light.PointLight.Brightness = 4;
            TweenService:Create(v11.Light.PointLight, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
            VfxManager.Emit(v11);
            VfxManager.DestroyEffect(v11, 3);
        end;
    end);
    task.delay(1.117 - v3, function() -- Line: 93
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u6 (copy), Debris (ref), TweenService (ref)
        if HumanoidRootPart then
            VfxManager.Enable(u6, false);
            VfxManager.DestroyEffect(u6, 3);
            local v12 = script.Dribble0:Clone();
            v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.254738450050354, -2.772651195526123, -0.49127197265625) * CFrame.fromEulerAnglesYXZ(-0, 3.141591787338257, 0);
            v12.Parent = Debris;
            v12.Light.PointLight.Brightness = 4;
            TweenService:Create(v12.Light.PointLight, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
            VfxManager.Emit(v12);
            VfxManager.DestroyEffect(v12, 3);
        end;
    end);
end;