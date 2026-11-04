 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 19
    -- upvalues: SfxManager (copy), LocalPlayer (copy), DarkScreenEffect (copy), Debris (copy), VfxManager (copy), RunService (copy), workspace_CurrentCamera (copy), Essentials (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Counter Steal" then
        SfxManager:playSound({
            Sound = "BBZ Chrollo V2 Counter Steal",
            Parent = HumanoidRootPart
        });

        if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
            DarkScreenEffect();
        end;

        local v4 = script.Counter.Dash:Clone();
        v4.Parent = Debris;
        v4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v4, 2);
        shared.vfx.emit(v4);
        task.delay(0.35 - v3, function() -- Line: 43
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v5 = script.Counter.Bounce:Clone();
            v5.Parent = Debris;
            v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v5, 2);
            shared.vfx.emit(v5);
        end);

        return;
    end;

    if p2.Task == "Counter Block" then
        SfxManager:playSound({
            Sound = "BBZ Chrollo V2 Counter Block",
            Parent = HumanoidRootPart
        });
        task.delay(0.1 - v3, function() -- Line: 54
            -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            local v6 = script.Cloak.Bounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v6, 2);
            shared.vfx.emit(v6);
        end);
        task.delay(0.5666666666666667 - v3, function() -- Line: 63
            -- upvalues: SfxManager (ref), Debris (ref), VfxManager (ref), RunService (ref), workspace_CurrentCamera (ref)
            SfxManager:playSound({
                Sound = "BBZ Chrollo V2 Time Skip",
                Parent = workspace
            });
            local u7 = script.Parent.TimeErasure.Erasure.CameraVFX:Clone();
            u7.Parent = Debris;
            VfxManager.BetterEmit(u7);
            local u8 = RunService.RenderStepped:Connect(function() -- Line: 70
                -- upvalues: workspace_CurrentCamera (ref), u7 (copy)
                workspace_CurrentCamera.FieldOfView = 70;
                u7.PrimaryPart.CFrame = workspace_CurrentCamera.CFrame;
            end);
            task.delay(1, function() -- Line: 75
                -- upvalues: u8 (copy), u7 (copy)
                u8:Disconnect();
                u7:Destroy();
            end);
        end);
        task.delay(0.9 - v3, function() -- Line: 81
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v9 = script.Counter.Shoot:Clone();
            v9.Parent = Debris;
            v9:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v9, 2);
            shared.vfx.emit(v9);
        end);

        return;
    end;

    if p2.Task ~= "Counter Dunk" then
        if p2.Task == "Counter Dribble" then
            SfxManager:playSound({
                Sound = "BBZ Chrollo V2 Counter Dribble",
                Parent = HumanoidRootPart
            });
            local Model = Instance.new("Model");
            Model.Parent = Debris;

            for _, child in pairs(script.Counter.AuraBodyPartsToWeld:GetChildren()) do
                local v10 = Character:FindFirstChild(child.Name);

                if v10 then
                    local v11 = child:Clone();
                    v11.CFrame = v10.CFrame;
                    v11.Parent = Model;
                    Essentials:Weld(v11, v10);
                end;
            end;

            task.delay(0.2833333333333333 - v3, function() -- Line: 133
                -- upvalues: LocalPlayer (ref), Character (copy), Other (copy), DarkScreenEffect (ref), Debris (ref), VfxManager (ref), Model (copy), HumanoidRootPart (copy), Essentials (ref)
                if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                    DarkScreenEffect();
                    local v12 = script.Counter.CameraFX:Clone();
                    v12.Parent = Debris;
                    VfxManager.DestroyEffect(v12, 2);
                    shared.vfx.emit(v12);
                end;

                shared.vfx.emit(Model);
                local v13 = script.Counter.Throw:Clone();
                v13.Parent = Debris;
                v13:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.DestroyEffect(v13, 2);
                shared.vfx.emit(v13);
                local v14 = tick();

                repeat
                    task.wait(0.1);
                    local v15 = Essentials:CreateClone(Character);
                    VfxManager.DestroyEffect(v15, 1);
                until tick() - v14 > 0.6666666666666666;
            end);
            task.delay(0.95 - v3, function() -- Line: 160
                -- upvalues: VfxManager (ref), Model (copy), Debris (ref), HumanoidRootPart (copy)
                VfxManager.Enable(Model, false);
                VfxManager.DestroyEffect(Model, 2);
                local v16 = script.Counter.Catch:Clone();
                v16.Parent = Debris;
                v16:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.DestroyEffect(v16, 2);
                shared.vfx.emit(v16);
            end);
            local v17 = tick();

            repeat
                task.wait(0.1);
                local v18 = Essentials:CreateClone(Character);
                VfxManager.DestroyEffect(v18, 1);
            until tick() - v17 > 0.5;
        else
            if p2.Task == "Cloak" then
                SfxManager:playSound({
                    Sound = "BBZ Chrollo V2 Bandit Cloak",
                    Parent = HumanoidRootPart
                });
                Essentials:HideCharacter(Character, {});
                local u19 = script.Cloak.Aura:Clone();
                u19.Name = Character.Name .. script.Name .. "Aura";
                u19.Parent = Debris;
                u19.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(u19, HumanoidRootPart);
                u19:SetAttribute("Active", true);
                task.delay(1.5 - v3, function() -- Line: 189
                    -- upvalues: u19 (copy)
                    if not (u19 and u19:GetAttribute("Active")) then
                        return;
                    end;

                    u19:SetAttribute("Active", nil);
                end);
                local u20 = {};

                local function v21() -- Line: 196
                    -- upvalues: u20 (ref), u19 (copy), Essentials (ref), Character (copy), VfxManager (ref), TweenService (ref)
                    for _, v in pairs(u20) do
                        v:Disconnect();
                    end;

                    if u19 then
                        Essentials:UnhideCharacter(Character, {});
                        VfxManager.Enable(u19, false);
                        VfxManager.DestroyEffect(u19, 2);
                        TweenService:Create(u19, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Transparency = 1
                        }):Play();
                    end;

                    u20 = nil;
                end;

                table.insert(u20, u19.AttributeChanged:Connect(v21));
                table.insert(u20, u19.Destroying:Connect(v21));

                return;
            end;

            if p2.Task == "Snatchback" then
                SfxManager:playSound({
                    Sound = "BBZ Chrollo V2 Snatchback",
                    Parent = HumanoidRootPart
                });
                local v22 = Debris:FindFirstChild(Character.Name .. script.Name .. "Aura");

                if v22 then
                    v22:SetAttribute("Active", nil);
                end;

                local v23 = script.Snatchback.Dash:Clone();
                v23.Parent = Debris;
                v23:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.DestroyEffect(v23, 2);
                shared.vfx.emit(v23);
                local v24 = tick();

                repeat
                    task.wait(0.1);
                    local v25 = Essentials:CreateClone(Character);
                    VfxManager.DestroyEffect(v25, 1);
                until tick() - v24 > 0.25;
            else
                if p2.Task == "Floater" then
                    SfxManager:playSound({
                        Sound = "BBZ Chrollo V2 Delayed Floater",
                        Parent = HumanoidRootPart
                    });
                    local v26 = Debris:FindFirstChild(Character.Name .. script.Name .. "Aura");

                    if v26 then
                        v26:SetAttribute("Active", nil);
                    end;

                    task.delay(0.25 - v3, function() -- Line: 243
                        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                        local v27 = script.Floater.Jump:Clone();
                        v27.Parent = Debris;
                        v27:PivotTo(HumanoidRootPart.CFrame);
                        VfxManager.DestroyEffect(v27, 2);
                        shared.vfx.emit(v27);
                    end);
                    task.delay(0.8166666666666667 - v3, function() -- Line: 252
                        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                        local v28 = script.Floater.Shoot:Clone();
                        v28.Parent = Debris;
                        v28:PivotTo(HumanoidRootPart.CFrame);
                        VfxManager.DestroyEffect(v28, 2);
                        shared.vfx.emit(v28);
                    end);

                    return;
                end;

                if p2.Task == "Intercept" then
                    SfxManager:playSound({
                        Sound = "BBZ Chrollo V2 Phantom Intercept",
                        Parent = HumanoidRootPart
                    });
                    local v29 = script.Intercept.Rush:Clone();
                    v29.Parent = Debris;
                    v29:PivotTo(HumanoidRootPart.CFrame);
                    Essentials:Weld(v29.PrimaryPart, HumanoidRootPart);
                    VfxManager.DestroyEffect(v29, 2);
                    shared.vfx.emit(v29);
                    task.delay(0.5 - v3, function() -- Line: 271
                        -- upvalues: SfxManager (ref), HumanoidRootPart (copy), LocalPlayer (ref), Character (copy), Other (copy), DarkScreenEffect (ref), Debris (ref), BALL (copy), VfxManager (ref), Essentials (ref)
                        SfxManager:playSound({
                            Sound = "BBZ Chrollo V2 Phantom Intercept Grab",
                            Parent = HumanoidRootPart
                        });
                        SfxManager:playSound({
                            Sound = "BBZ Chrollo V2 Phantom Intercept Loop",
                            Parent = HumanoidRootPart
                        });

                        if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                            DarkScreenEffect();
                        end;

                        local v30 = script.Intercept.BounceSlash:Clone();
                        v30.Parent = Debris;
                        v30:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v30, 2);
                        local v31 = script.Intercept.Slash:Clone();
                        v31.Parent = Debris;
                        v31.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                        Essentials:Weld(v31, HumanoidRootPart);
                        VfxManager.DestroyEffect(v31, 2);
                        shared.vfx.emit(v30, v31);
                        local v32 = tick();

                        repeat
                            task.wait(0.1);
                            local v33 = Essentials:CreateClone(Character);
                            VfxManager.DestroyEffect(v33, 1);
                        until tick() - v32 > 2.0833333333333335;
                    end);
                    task.delay(0.9166666666666666 - v3, function() -- Line: 299
                        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                        local v34 = script.Intercept.Bounce:Clone();
                        v34.Parent = Debris;
                        v34:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v34, 2);
                        shared.vfx.emit(v34);
                    end);
                    task.delay(1.15 - v3, function() -- Line: 308
                        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                        local v35 = script.Intercept.Bounce:Clone();
                        v35.Parent = Debris;
                        v35:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v35, 2);
                        shared.vfx.emit(v35);
                    end);
                    task.delay(1.3 - v3, function() -- Line: 317
                        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                        local v36 = script.Intercept.Bounce:Clone();
                        v36.Parent = Debris;
                        v36:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v36, 2);
                        shared.vfx.emit(v36);
                    end);
                    task.delay(1.5333333333333334 - v3, function() -- Line: 326
                        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                        local v37 = script.Intercept.Bounce:Clone();
                        v37.Parent = Debris;
                        v37:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v37, 2);
                        shared.vfx.emit(v37);
                    end);
                    task.delay(1.6833333333333333 - v3, function() -- Line: 335
                        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                        local v38 = script.Intercept.Bounce:Clone();
                        v38.Parent = Debris;
                        v38:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v38, 2);
                        shared.vfx.emit(v38);
                    end);
                    task.delay(1.9 - v3, function() -- Line: 344
                        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                        local v39 = script.Intercept.Bounce:Clone();
                        v39.Parent = Debris;
                        v39:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v39, 2);
                        shared.vfx.emit(v39);
                    end);
                    task.delay(2.05 - v3, function() -- Line: 353
                        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                        local v40 = script.Intercept.Bounce:Clone();
                        v40.Parent = Debris;
                        v40:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v40, 2);
                        shared.vfx.emit(v40);
                    end);
                    task.delay(2.283333333333333 - v3, function() -- Line: 362
                        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                        local v41 = script.Intercept.Bounce:Clone();
                        v41.Parent = Debris;
                        v41:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v41, 2);
                        shared.vfx.emit(v41);
                    end);
                    task.delay(2.433333333333333 - v3, function() -- Line: 371
                        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                        local v42 = script.Intercept.Bounce:Clone();
                        v42.Parent = Debris;
                        v42:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                        VfxManager.DestroyEffect(v42, 2);
                        shared.vfx.emit(v42);
                    end);

                    return;
                end;

                local v43 = p2.Task == "Cleanup" and Debris:FindFirstChild(Character.Name .. script.Name .. "Aura");

                if v43 then
                    v43:SetAttribute("Active", nil);
                end;
            end;
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Chrollo V2 Time Skip",
        Parent = workspace
    });
    local u44 = script.Parent.TimeErasure.Erasure.CameraVFX:Clone();
    u44.Parent = Debris;
    VfxManager.BetterEmit(u44);
    local u45 = RunService.RenderStepped:Connect(function() -- Line: 96
        -- upvalues: workspace_CurrentCamera (ref), u44 (copy)
        workspace_CurrentCamera.FieldOfView = 70;
        u44.PrimaryPart.CFrame = workspace_CurrentCamera.CFrame;
    end);
    task.delay(1, function() -- Line: 101
        -- upvalues: u45 (copy), u44 (copy)
        u45:Disconnect();
        u44:Destroy();
    end);
    local u46 = script.Cloak.Aura:Clone();
    u46.Parent = Debris;
    u46.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(u46, HumanoidRootPart);
    shared.vfx.emit(u46);
    task.delay(1 - v3, function() -- Line: 113
        -- upvalues: VfxManager (ref), u46 (copy)
        VfxManager.Enable(u46, false);
        VfxManager.DestroyEffect(u46, 2);
    end);
end;