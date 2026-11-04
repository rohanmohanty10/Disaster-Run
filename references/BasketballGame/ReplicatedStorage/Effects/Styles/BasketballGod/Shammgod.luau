 
 

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
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), RunService (copy), Essentials (copy), SfxManager (copy), Debris (copy), TweenService (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Activate" then
        if LocalPlayer.Character == Char then
            local FieldOfView = workspace.CurrentCamera.FieldOfView;
            local u5 = RunService.Heartbeat:Connect(function(p4) -- Line: 32
                -- upvalues: FieldOfView (ref), Essentials (ref)
                FieldOfView = Essentials:Lerp(FieldOfView, 40, p4 * 5);
                workspace.CurrentCamera.FieldOfView = FieldOfView;
            end);
            task.delay(0.65 - u3, function() -- Line: 39
                -- upvalues: u5 (copy)
                if u5 then
                    u5:Disconnect();
                end;
            end);
        end;

        SfxManager:playSound({
            Sound = "BBZ BasketballGod Shammgod",
            Parent = HumanoidRootPart
        });
        local u6 = script.Aura:Clone();
        u6.CFrame = HumanoidRootPart.CFrame;
        u6.Parent = Debris;
        Essentials:Weld(u6, HumanoidRootPart);
        local Humanoid = Char:FindFirstChild("Humanoid");

        if Humanoid then
            TweenService:Create(Humanoid, TweenInfo.new(0.467 - u3, Enum.EasingStyle.Quad), {
                CameraOffset = Vector3.new(3, 0, 0)
            }):Play();
            task.delay(0.467 - u3, function() -- Line: 59
                -- upvalues: Humanoid (copy), TweenService (ref), u3 (copy)
                if Humanoid ~= nil then
                    TweenService:Create(Humanoid, TweenInfo.new(0.467 - u3, Enum.EasingStyle.Quad), {
                        CameraOffset = Vector3.new(0, 0, 0)
                    }):Play();
                end;
            end);
        end;

        task.delay(0.167 - u3, function() -- Line: 66
            -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u6 (copy), Debris (ref), TweenService (ref)
            if HumanoidRootPart then
                VfxManager.Enable(u6, true);
                local v7 = script.Dribble0:Clone();
                v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.7037388682365417, -2.772651195526123, -0.0402679443359375) * CFrame.fromEulerAnglesYXZ(-0, 3.141591787338257, 0);
                v7.Parent = Debris;
                v7.Light.PointLight.Brightness = 4;
                TweenService:Create(v7.Light.PointLight, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                    Brightness = 0
                }):Play();
                VfxManager.Emit(v7);
                VfxManager.DestroyEffect(v7, 3);
            end;
        end);
        task.delay(0.467 - u3, function() -- Line: 81
            -- upvalues: HumanoidRootPart (copy), Debris (ref), TweenService (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v8 = script.Dribble1:Clone();
                v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.824263095855713, -2.772651195526123, -2.193267822265625) * CFrame.fromEulerAnglesYXZ(-0, 3.141591787338257, 0);
                v8.Parent = Debris;
                v8.Light.PointLight.Brightness = 4;
                TweenService:Create(v8.Light.PointLight, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                    Brightness = 0
                }):Play();
                VfxManager.Emit(v8);
                VfxManager.DestroyEffect(v8, 3);
            end;
        end);
        task.delay(0.65 - u3, function() -- Line: 95
            -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u6 (copy), Debris (ref), TweenService (ref)
            if HumanoidRootPart then
                VfxManager.Enable(u6, false);
                VfxManager.DestroyEffect(u6, 3);
                local v9 = script.Dribble2:Clone();
                v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.3882635831832886, -2.772651195526123, -2.7672576904296875) * CFrame.fromEulerAnglesYXZ(-0, 3.141591787338257, 0);
                v9.Parent = Debris;
                v9.Light.PointLight.Brightness = 4;
                TweenService:Create(v9.Light.PointLight, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                    Brightness = 0
                }):Play();
                VfxManager.Emit(v9);
                VfxManager.DestroyEffect(v9, 3);
            end;
        end);
    end;
end;