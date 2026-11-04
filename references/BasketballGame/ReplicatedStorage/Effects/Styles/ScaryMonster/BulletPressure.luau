 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
local ScaryMonsterScreenEffect = require(script.Parent.Parent.ScreenEffects.ScaryMonsterScreenEffect);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 19
    -- upvalues: Knit (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy), ScaryMonsterScreenEffect (copy), RunService (copy), TweenService (copy)
    local Controller = Knit.GetController("BallController");
    local TimeSent = u2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = u2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local u4 = Character:FindFirstChild("Left Leg");
    Character:FindFirstChild("Right Leg");
    local u5 = Character:FindFirstChild(script.Name .. "Revolver");
    local BALL = Character:FindFirstChild("BALL", true);

    if u2.Task ~= "Dribble" then
        if u2.Task ~= "Pressure" then
            if u2.Task == "Bullet" then
                SfxManager:playSound({
                    Sound = "BBZ Scary Monster Time Skip",
                    Parent = HumanoidRootPart
                });
                ScaryMonsterScreenEffect(Character, HumanoidRootPart.CFrame);
                local v6 = script.Shoot:Clone();
                v6.Parent = Debris;
                v6.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v6, HumanoidRootPart);
                VfxManager.DestroyEffect(v6, 2);
                shared.vfx.emit(v6);

                if u5 then
                    local u7 = script.Bullet:Clone();
                    u7.Parent = workspace.Debris;
                    u7.CFrame = u5["Gun.002"].CFrame * CFrame.new(0, 0.21, 0);
                    SfxManager:playSound({
                        Sound = "BBZ Scary Monster Bullet Fly",
                        Parent = u7
                    });

                    if u2.Success then
                        local u8 = tick();
                        local u9 = nil;
                        u9 = RunService.Heartbeat:Connect(function() -- Line: 171
                            -- upvalues: u8 (copy), u7 (copy), u9 (ref), Controller (copy), VfxManager (ref), Debris (ref), SfxManager (ref), TweenService (ref)
                            if tick() - u8 > 1.5 or not (u7 and u7.Parent) then
                                u9:Disconnect();
                                u7:Destroy();

                                return;
                            end;

                            local ServerBallPosition = Controller:GetServerBallPosition();
                            local Magnitude = (u7.Position - ServerBallPosition).Magnitude;

                            if Magnitude > 1 then
                                TweenService:Create(u7, TweenInfo.new(Magnitude / 1000), {
                                    CFrame = CFrame.new(u7.Position, ServerBallPosition) * CFrame.new(0, 0, -Magnitude)
                                }):Play();

                                return;
                            end;

                            u9:Disconnect();
                            VfxManager.Enable(u7, false);
                            VfxManager.DestroyEffect(u7, 2);
                            local v10 = script.Impact:Clone();
                            v10.Parent = Debris;
                            v10:PivotTo(CFrame.new(ServerBallPosition));
                            VfxManager.DestroyEffect(v10, 5);
                            shared.vfx.emit(v10);
                            SfxManager:playSound({
                                Sound = "BBZ Scary Monster Bullet Hit",
                                Parent = v10
                            });
                        end);

                        return;
                    end;

                    local ServerBallPosition = Controller:GetServerBallPosition();
                    TweenService:Create(u7, TweenInfo.new(1), {
                        CFrame = CFrame.new(u7.Position, ServerBallPosition + Vector3.new(0, 1.5, 0)) * CFrame.new(0, 0, -1000)
                    }):Play();
                    task.delay(1, function() -- Line: 204
                        -- upvalues: VfxManager (ref), u7 (copy)
                        VfxManager.Enable(u7, false);
                        VfxManager.DestroyEffect(u7, 2);
                    end);
                end;
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Scary Monster Bullet Pressure",
            Parent = HumanoidRootPart
        });
        task.delay(0.16666666666666666 - v3, function() -- Line: 139
            -- upvalues: Debris (ref), u4 (copy), Essentials (ref), VfxManager (ref)
            local v11 = script.Step:Clone();
            v11.Parent = Debris;
            v11.CFrame = u4.CFrame * CFrame.new(0, -1, 0);
            Essentials:Weld(v11, u4);
            VfxManager.DestroyEffect(v11, 2);
            shared.vfx.emit(v11);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Scary Monster Leg Shot",
        Parent = HumanoidRootPart
    });
    task.delay(0.19999999999999998 - v3, function() -- Line: 36
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v12 = script.Roll:Clone();
        v12.Parent = Debris;
        v12:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v12, 2);
        shared.vfx.emit(v12);
    end);
    task.delay(0.41111111111111115 - v3, function() -- Line: 45
        -- upvalues: u5 (copy), Debris (ref), Essentials (ref), VfxManager (ref)
        if u5 then
            local v13 = script.GunSpin:Clone();
            v13.Parent = Debris;
            v13.CFrame = u5["Cube.005"].CFrame;
            Essentials:Weld(v13, u5["Cube.005"]);
            VfxManager.DestroyEffect(v13, 2);
            shared.vfx.emit(v13);
        end;
    end);
    task.delay(0.4888888888888889 - v3, function() -- Line: 57
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v14 = script.Bounce:Clone();
        v14.Parent = Debris;
        v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v14, 2);
        shared.vfx.emit(v14);
    end);
    task.delay(0.7222222222222222 - v3, function() -- Line: 66
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v15 = script.Bounce:Clone();
        v15.Parent = Debris;
        v15:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v15, 2);
        shared.vfx.emit(v15);
    end);
    task.delay(0.9333333333333332 - v3, function() -- Line: 75
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v16 = script.Bounce:Clone();
        v16.Parent = Debris;
        v16:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v16, 2);
        shared.vfx.emit(v16);
    end);
    task.delay(0.811111111111111 - v3, function() -- Line: 84
        -- upvalues: SfxManager (ref), HumanoidRootPart (copy), ScaryMonsterScreenEffect (ref), Character (copy), Debris (ref), Essentials (ref), VfxManager (ref), u5 (copy), RunService (ref), u2 (copy), TweenService (ref)
        SfxManager:playSound({
            Sound = "BBZ Scary Monster Time Skip",
            Parent = HumanoidRootPart
        });
        ScaryMonsterScreenEffect(Character, HumanoidRootPart.CFrame);
        local v17 = script.Shoot:Clone();
        v17.Parent = Debris;
        v17.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v17, HumanoidRootPart);
        VfxManager.DestroyEffect(v17, 2);
        shared.vfx.emit(v17);

        if u5 then
            local u18 = script.Bullet:Clone();
            u18.Parent = workspace.Debris;
            u18.CFrame = u5["Gun.002"].CFrame * CFrame.new(0, 0.21, 0);
            SfxManager:playSound({
                Sound = "BBZ Scary Monster Bullet Fly",
                Parent = u18
            });
            local u19 = tick();
            local u20 = nil;
            u20 = RunService.Heartbeat:Connect(function() -- Line: 106
                -- upvalues: u19 (copy), u2 (ref), u18 (copy), u20 (ref), VfxManager (ref), Debris (ref), SfxManager (ref), TweenService (ref)
                if tick() - u19 > 1.5 or not (u2.Leg and (u2.Leg.Parent and (u18 and u18.Parent))) then
                    u20:Disconnect();
                    u18:Destroy();

                    return;
                end;

                local Magnitude = (u18.Position - u2.Leg.Position).Magnitude;

                if Magnitude > 1 then
                    TweenService:Create(u18, TweenInfo.new(Magnitude / 1000), {
                        CFrame = CFrame.new(u18.Position, u2.Leg.Position) * CFrame.new(0, 0, -Magnitude)
                    }):Play();

                    return;
                end;

                u20:Disconnect();
                VfxManager.Enable(u18, false);
                VfxManager.DestroyEffect(u18, 2);
                local v21 = script.Impact:Clone();
                v21.Parent = Debris;
                v21:PivotTo(u2.Leg.CFrame);
                VfxManager.DestroyEffect(v21, 5);
                shared.vfx.emit(v21);
                SfxManager:playSound({
                    Sound = "BBZ Scary Monster Bullet Hit",
                    Parent = v21
                });
            end);
        end;
    end);
end;