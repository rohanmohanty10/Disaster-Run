 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local UserInputService = game:GetService("UserInputService");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.UwUEffects);
local trove = require(ReplicatedStorage.forum.trove);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
require(ReplicatedStorage.client.replication.BezierCurve);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.MoonPropertyAnimator);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.VfxHandler);
local styles = require(ReplicatedStorage.wiki.styles);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
require(ReplicatedStorage.client.replication.BackgroundHighlight);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local v230 = {
    corvine_feint_stepovers = function(u1, u2, p3) -- Line: 35, Name: corvine_feint_stepovers
        -- upvalues: trove (copy), mainreplication (copy), ReplicatedStorage (copy), KatUtil (copy), vfxUtil (copy), RunService (copy), Lighting (copy), TweenService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Players (copy)
        local u4 = u1.HumanoidRootPart or u1.PrimaryPart;
        local u5 = trove.new();
        u5:AttachToInstance(p3);
        local u6, u7 = mainreplication.bodyVelocity(u4, 40, 1.5, nil, nil, true, TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 40));
        u5:Add(u6);
        u5:Add(task.spawn(function() -- Line: 46
            -- upvalues: u5 (copy), ReplicatedStorage (ref), u4 (copy), KatUtil (ref), vfxUtil (ref), RunService (ref), u6 (copy), u7 (copy), Lighting (ref), TweenService (ref), mainreplication (ref), u1 (copy), u2 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref), Players (ref)
            local u8 = u5:Add(ReplicatedStorage.Resources.karasu["Corvine Feint"].Stepovers.VFX:Clone());
            u8.Parent = u4;
            u8.VFX.Weld.Part0 = u4;
            KatUtil.forge_emit(u8.VFX.Dribble);
            KatUtil.forge_emit(u8.VFX.Grass);
            task.delay(0.26666666666666666, function() -- Line: 54
                -- upvalues: u8 (copy), KatUtil (ref)
                if not u8:FindFirstChild("VFX") then
                    return;
                end;

                KatUtil.forge_emit(u8.VFX.FX);
            end);
            task.delay(0.5666666666666667, function() -- Line: 59
                -- upvalues: u8 (copy), KatUtil (ref)
                if not u8:FindFirstChild("VFX") then
                    return;
                end;

                KatUtil.forge_emit(u8.VFX.FX);
            end);
            task.delay(0.8333333333333334, function() -- Line: 64
                -- upvalues: u8 (copy), KatUtil (ref)
                if not u8:FindFirstChild("VFX") then
                    return;
                end;

                KatUtil.forge_emit(u8.VFX.FX);
            end);
            task.delay(1.0833333333333333, function() -- Line: 69
                -- upvalues: u8 (copy), KatUtil (ref)
                if not u8:FindFirstChild("VFX") then
                    return;
                end;

                KatUtil.forge_emit(u8.VFX.FX);
            end);
            vfxUtil.disposal(u8, 6);
            local u9 = false;
            local u10 = nil;
            u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 79
                -- upvalues: u6 (ref), u10 (ref), u4 (ref), u7 (ref)
                if u6 and u6:IsDescendantOf(game) then
                    u6.Velocity = u4.CFrame.LookVector * u7.Value;

                    return;
                end;

                u10:Disconnect();
            end);
            local v12 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v12.Parent = Lighting;
            v12.TintColor = Color3.fromRGB(93, 104, 255);
            v12.Brightness = 0.3;
            v12.Contrast = 1;
            v12.Saturation = -0.4;
            TweenService:Create(v12, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v12, TweenInfo.new(0.65, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(1, v12.Destroy, v12);
            mainreplication.springcamerashake(35, 25);
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            task.delay(1, u10.Disconnect, u10);
            local u13 = nil;
            u13 = u1:GetAttributeChangedSignal("StepsLanded"):Connect(function() -- Line: 106
                -- upvalues: u2 (ref), u1 (ref), u13 (ref), u8 (copy), u9 (ref)
                if u2 ~= u1:GetAttribute("StepsLanded") then
                    if u13 then
                        u13:Disconnect();
                    end;

                    u8:Destroy();
                    u9 = true;
                    u13:Disconnect();
                end;
            end);
            task.delay(2, function() -- Line: 114
                -- upvalues: u13 (ref)
                u13:Disconnect();
                u13 = nil;
            end);
            u5:Add(task.delay(1.15, function() -- Line: 119
                -- upvalues: u9 (ref), mainreplication (ref), u4 (ref), ReplicatedStorage (ref), KatUtil (ref), vfxUtil (ref), u5 (ref), Util (ref), LocalPlayer (ref), u1 (ref), vfxUtil (ref), TweenService (ref), RunService (ref), u6 (ref), u7 (ref), Players (ref)
                if u9 then
                    return;
                end;

                mainreplication.bodyVelocity(u4, 140, 0.45, nil, nil, nil, TweenInfo.new(0.55, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
                local v14 = ReplicatedStorage.Resources.karasu["Corvine Feint"].Stepovers.Run:Clone();
                v14.Main.Weld.Part0 = u4;
                v14:PivotTo(u4.CFrame);
                v14.Parent = workspace.Effects;
                KatUtil.forge_emit(v14);
                vfxUtil.disposal(v14, 6);
                mainreplication.Emit(u4, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
                local u15 = ReplicatedStorage.Resources.rundasheff:Clone();
                u15.main.Weld.Part0 = u4;
                u15.Parent = workspace.Effects;
                u5:Add(u15);

                if Util.canshiftcolor(LocalPlayer, u1) then
                    vfxUtil.LeanTowardsColor(u15, u1:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u1:GetAttribute("CustomAlpha") or 0.985);
                end;

                u15.Air.Size = Vector3.new(4.998, 0.503, 4.998);
                u15.Air.Transparency = 0.8;
                local Air = u15.main.Air;
                Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
                TweenService:Create(u15.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    C0 = u15.main.Air.C0 * CFrame.new(0, 15, 0)
                }):Play();
                TweenService:Create(u15.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(17.136, 1.132, 16.878),
                    Transparency = 1
                }):Play();
                u15.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
                u15.Wind1.Transparency = 0.9;
                TweenService:Create(u15.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(19.108, 11.452, 11.292),
                    Transparency = 1
                }):Play();
                task.delay(0.15, function() -- Line: 160
                    -- upvalues: u15 (copy), TweenService (ref)
                    u15.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
                    u15.Wind1.Transparency = 0.9;
                    TweenService:Create(u15.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                        Size = Vector3.new(19.108, 11.452, 11.292),
                        Transparency = 1
                    }):Play();
                end);
                u15.End.Size = Vector3.new(5, 1, 5);
                u15.End.Transparency = 0.65;
                local End = u15.main.End;
                End.C0 = End.C0 * CFrame.new(0, 0, 0);
                TweenService:Create(u15.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    C0 = u15.main.End.C0 * CFrame.new(0, -15, 0)
                }):Play();
                TweenService:Create(u15.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(12.999, 2.766, 12.999),
                    Transparency = 1
                }):Play();
                task.delay(0.15, function() -- Line: 176
                    -- upvalues: u15 (copy), TweenService (ref)
                    u15.End.Size = Vector3.new(5, 1, 5);
                    u15.End.Transparency = 0.65;
                    local End2 = u15.main.End;
                    End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
                    TweenService:Create(u15.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                        C0 = u15.main.End.C0 * CFrame.new(0, -15, 0)
                    }):Play();
                    TweenService:Create(u15.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                        Size = Vector3.new(12.999, 2.766, 12.999),
                        Transparency = 1
                    }):Play();
                end);
                u15.A.Size = Vector3.new(14.29, 4.752, 5.444);
                u15.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
                u15.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
                u15.A.Decal.Transparency = 0.9;
                TweenService:Create(u15.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    C0 = u15.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
                }):Play();
                TweenService:Create(u15.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(33.166, 4.752, 5.443)
                }):Play();
                TweenService:Create(u15.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    Scale = Vector3.new(0.715, 0.303, 0.315)
                }):Play();
                TweenService:Create(u15.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                vfxUtil.disposal(u15, 2);
                local u16 = nil;
                u16 = RunService.RenderStepped:Connect(function(p17) -- Line: 201
                    -- upvalues: u6 (ref), u16 (ref), u4 (ref), u7 (ref)
                    if u6 and u6:IsDescendantOf(game) then
                        u6.Velocity = u4.CFrame.LookVector * u7.Value;

                        return;
                    end;

                    u16:Disconnect();
                end);

                if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u1) then
                    return;
                end;

                mainreplication.cameraShake(10, 0.4, 5);
                mainreplication.fov(false, 90);
                mainreplication.fov(true, 70, 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                u5:Add(task.delay(2, function() -- Line: 215
                    -- upvalues: u5 (ref)
                    u5:Destroy();
                end));
            end));

            if u9 then
                return;
            end;

            if Players:GetPlayerFromCharacter(u1) ~= Players.LocalPlayer then
                return;
            end;

            local u18, u19 = mainreplication.bodyVelocity(u4, 50, 1.5, nil, nil, true, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 40));
            u5:Add(u18);
            local u20 = nil;
            u20 = RunService.RenderStepped:Connect(function(p21) -- Line: 226
                -- upvalues: u18 (copy), u20 (ref), u4 (ref), u19 (copy)
                if u18 and u18:IsDescendantOf(game) then
                    u18.Velocity = u4.CFrame.LookVector * u19.Value;

                    return;
                end;

                u20:Disconnect();
            end);
            u5:Add(u20);
            task.delay(1, u20.Disconnect, u20);
        end));
    end,

    corvine_feint_land = function(u22: any, p23: userdata) -- Line: 239, Name: corvine_feint_land
        -- upvalues: mainreplication (copy), KatUtil (copy), ReplicatedStorage (copy), vfxUtil (copy), RunService (copy), Lighting (copy), TweenService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy)
        local u24 = u22.HumanoidRootPart or u22.PrimaryPart;
        task.delay(0.017, function() -- Line: 242
            -- upvalues: mainreplication (ref)
            mainreplication.cameraShake(20, 0.6, 5);
        end);
        local v25 = KatUtil.magnitude(u22);
        KatUtil.destroy_all_velocities(u22);
        mainreplication.bodyVelocity(u24, v25 / 1.8, 0.4, false);
        local v26 = ReplicatedStorage.Resources.karasu["Corvine Feint"].Stepovers.HitVFX:Clone();
        v26.Parent = u24;
        KatUtil.forge_emit(v26);
        vfxUtil.disposal(v26, 6);
        task.delay(0.4, function() -- Line: 257
            -- upvalues: mainreplication (ref), ReplicatedStorage (ref), u24 (copy), KatUtil (ref), vfxUtil (ref), RunService (ref), Lighting (ref), TweenService (ref), Util (ref), LocalPlayer (ref), u22 (copy), vfxUtil (ref)
            mainreplication.cameraShake(10, 0.3, 6);
            local v27 = ReplicatedStorage.Resources.karasu["Corvine Feint"].Stepovers.Run:Clone();
            v27.Main.Weld.Part0 = u24;
            v27:PivotTo(u24.CFrame);
            v27.Parent = workspace.Effects;
            KatUtil.forge_emit(v27);
            vfxUtil.disposal(v27, 6);
            local u28, u29 = mainreplication.bodyVelocity(u24, 102.66666666666666, 0.75, nil, nil, nil, TweenInfo.new(1.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0));
            mainreplication.fov(true, 60, 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut);
            local u30 = nil;
            u30 = RunService.RenderStepped:Connect(function(p31) -- Line: 273
                -- upvalues: u28 (copy), u30 (ref), u24 (ref), u29 (copy)
                if u28 and u28:IsDescendantOf(game) then
                    u28.Velocity = u24.CFrame.LookVector * u29.Value;

                    return;
                end;

                u30:Disconnect();
            end);
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 10;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v32 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v32.Parent = Lighting;
            v32.TintColor = Color3.fromRGB(106, 116, 255);
            v32.Brightness = 0.4;
            v32.Contrast = 1;
            v32.Saturation = -0.5;
            TweenService:Create(v32, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(v32, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v32.Destroy, v32);
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 0.85, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(30, 40);
            mainreplication.Emit(u24, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
            local u33 = ReplicatedStorage.Resources.rundasheff:Clone();
            u33.main.Weld.Part0 = u24;
            u33.Parent = workspace.Effects;

            if Util.canshiftcolor(LocalPlayer, u22) then
                vfxUtil.LeanTowardsColor(u33, u22:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u22:GetAttribute("CustomAlpha") or 0.985);
            end;

            u33.Air.Size = Vector3.new(4.998, 0.503, 4.998);
            u33.Air.Transparency = 0.8;
            local Air = u33.main.Air;
            Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
            TweenService:Create(u33.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                C0 = u33.main.Air.C0 * CFrame.new(0, 15, 0)
            }):Play();
            TweenService:Create(u33.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(17.136, 1.132, 16.878),
                Transparency = 1
            }):Play();
            u33.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
            u33.Wind1.Transparency = 0.9;
            TweenService:Create(u33.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(19.108, 11.452, 11.292),
                Transparency = 1
            }):Play();
            task.delay(0.15, function() -- Line: 327
                -- upvalues: u33 (copy), TweenService (ref)
                u33.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
                u33.Wind1.Transparency = 0.9;
                TweenService:Create(u33.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(19.108, 11.452, 11.292),
                    Transparency = 1
                }):Play();
            end);
            u33.End.Size = Vector3.new(5, 1, 5);
            u33.End.Transparency = 0.65;
            local End = u33.main.End;
            End.C0 = End.C0 * CFrame.new(0, 0, 0);
            TweenService:Create(u33.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                C0 = u33.main.End.C0 * CFrame.new(0, -15, 0)
            }):Play();
            TweenService:Create(u33.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                Size = Vector3.new(12.999, 2.766, 12.999),
                Transparency = 1
            }):Play();
            task.delay(0.15, function() -- Line: 343
                -- upvalues: u33 (copy), TweenService (ref)
                u33.End.Size = Vector3.new(5, 1, 5);
                u33.End.Transparency = 0.65;
                local End2 = u33.main.End;
                End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
                TweenService:Create(u33.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    C0 = u33.main.End.C0 * CFrame.new(0, -15, 0)
                }):Play();
                TweenService:Create(u33.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(12.999, 2.766, 12.999),
                    Transparency = 1
                }):Play();
            end);
            u33.A.Size = Vector3.new(14.29, 4.752, 5.444);
            u33.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
            u33.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
            u33.A.Decal.Transparency = 0.9;
            TweenService:Create(u33.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                C0 = u33.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
            }):Play();
            TweenService:Create(u33.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                Size = Vector3.new(33.166, 4.752, 5.443)
            }):Play();
            TweenService:Create(u33.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                Scale = Vector3.new(0.715, 0.303, 0.315)
            }):Play();
            TweenService:Create(u33.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            vfxUtil.disposal(u33, 2);
        end);
    end,

    corvine_feint_feint = function(u34) -- Line: 368, Name: corvine_feint_feint
        -- upvalues: ReplicatedStorage (copy), KatUtil (copy), vfxUtil (copy), Players (copy), RunService (copy), Lighting (copy), TweenService (copy), mainreplication (copy), Util (copy), LocalPlayer (copy)
        local u35 = u34.HumanoidRootPart or u34.PrimaryPart;
        local u36 = ReplicatedStorage.Resources.karasu["Corvine Feint"].Feint.FeintVFX:Clone();
        u36.Weld.Part0 = u35;
        u36:PivotTo(u35.CFrame);
        u36.Parent = workspace.Effects;
        KatUtil.forge_emit(u36.Throw);
        KatUtil.forge_emit(u36.Dribble);
        KatUtil.forge_emit(u36.Spin);
        vfxUtil.disposal(u36, 3.5);

        if Players:GetPlayerFromCharacter(u34) == Players.LocalPlayer then
            local u37 = ReplicatedStorage.Resources.karasu["Corvine Feint"].Feint.CameraVFX:Clone();
            u37.Parent = workspace.Effects;
            RunService.PreRender:Connect(function() -- Line: 386
                -- upvalues: u37 (copy)
                u37.CFrame = workspace.CurrentCamera.CFrame;
            end);
            vfxUtil.disposal(u37, 1);
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 10;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v38 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v38.Parent = Lighting;
            v38.TintColor = Color3.fromRGB(106, 116, 255);
            v38.Brightness = 0.4;
            v38.Contrast = 1;
            v38.Saturation = -0.5;
            TweenService:Create(v38, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(v38, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v38.Destroy, v38);
            mainreplication.fov(false, 40);
            mainreplication.fov(true, 70, 1.33, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(20, 35);
        end;

        task.delay(0.5333333333333333, function() -- Line: 417
            -- upvalues: KatUtil (ref), u36 (copy), Players (ref), u34 (copy), Lighting (ref), TweenService (ref), mainreplication (ref)
            KatUtil.forge_emit(u36.Sweat2);

            if Players:GetPlayerFromCharacter(u34) == Players.LocalPlayer then
                local BlurEffect = Instance.new("BlurEffect");
                BlurEffect.Size = 10;
                BlurEffect.Parent = Lighting;
                TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                task.delay(0.533, BlurEffect.Destroy, BlurEffect);
                mainreplication.fov(true, 50.5, 0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                mainreplication.cameraShake(20, 0.6, 6);
            end;
        end);
        task.delay(1.15, function() -- Line: 434
            -- upvalues: ReplicatedStorage (ref), u35 (copy), KatUtil (ref), Util (ref), LocalPlayer (ref), u34 (copy), vfxUtil (ref), TweenService (ref), mainreplication (ref), Lighting (ref), Players (ref), RunService (ref)
            local v39 = ReplicatedStorage.Resources.karasu["Corvine Feint"].Feint.FeintVFX:Clone();
            v39.Weld.Part0 = u35;
            v39:PivotTo(u35.CFrame);
            v39.Parent = workspace.Effects;
            KatUtil.forge_emit(v39.Throw);
            KatUtil.forge_emit(v39["Burst Mesh"]);
            local u40 = ReplicatedStorage.Resources.rundasheff:Clone();
            u40.main.Weld.Part0 = u35;
            u40.Parent = workspace.Effects;

            if Util.canshiftcolor(LocalPlayer, u34) then
                vfxUtil.LeanTowardsColor(u40, u34:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u34:GetAttribute("CustomAlpha") or 0.985);
            end;

            u40.Air.Size = Vector3.new(4.998, 0.503, 4.998);
            u40.Air.Transparency = 0.8;
            local Air = u40.main.Air;
            Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
            TweenService:Create(u40.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                C0 = u40.main.Air.C0 * CFrame.new(0, 15, 0)
            }):Play();
            TweenService:Create(u40.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(17.136, 1.132, 16.878),
                Transparency = 1
            }):Play();
            u40.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
            u40.Wind1.Transparency = 0.9;
            TweenService:Create(u40.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(19.108, 11.452, 11.292),
                Transparency = 1
            }):Play();
            task.delay(0.15, function() -- Line: 466
                -- upvalues: u40 (copy), TweenService (ref)
                u40.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
                u40.Wind1.Transparency = 0.9;
                TweenService:Create(u40.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(19.108, 11.452, 11.292),
                    Transparency = 1
                }):Play();
            end);
            u40.End.Size = Vector3.new(5, 1, 5);
            u40.End.Transparency = 0.65;
            local End = u40.main.End;
            End.C0 = End.C0 * CFrame.new(0, 0, 0);
            TweenService:Create(u40.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                C0 = u40.main.End.C0 * CFrame.new(0, -15, 0)
            }):Play();
            TweenService:Create(u40.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                Size = Vector3.new(12.999, 2.766, 12.999),
                Transparency = 1
            }):Play();
            task.delay(0.15, function() -- Line: 482
                -- upvalues: u40 (copy), TweenService (ref)
                u40.End.Size = Vector3.new(5, 1, 5);
                u40.End.Transparency = 0.65;
                local End2 = u40.main.End;
                End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
                TweenService:Create(u40.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    C0 = u40.main.End.C0 * CFrame.new(0, -15, 0)
                }):Play();
                TweenService:Create(u40.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(12.999, 2.766, 12.999),
                    Transparency = 1
                }):Play();
            end);
            u40.A.Size = Vector3.new(14.29, 4.752, 5.444);
            u40.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
            u40.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
            u40.A.Decal.Transparency = 0.9;
            TweenService:Create(u40.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                C0 = u40.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
            }):Play();
            TweenService:Create(u40.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                Size = Vector3.new(33.166, 4.752, 5.443)
            }):Play();
            TweenService:Create(u40.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                Scale = Vector3.new(0.715, 0.303, 0.315)
            }):Play();
            TweenService:Create(u40.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            vfxUtil.disposal(v39, 2);
            vfxUtil.disposal(u40, 2);
            mainreplication.characterImage({
                ImageTransparency = 0.8,
                Speed = 0.3,
                CFrames = true,
                Brightness = 1,
                countSpeed = 0.03,
                Count = 19,
                Whitelist = { u34 },
                Color = Color3.fromRGB(71, 102, 255),
                Color2 = Color3.fromRGB(71, 102, 255)
            });
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v41 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v41.Parent = Lighting;
            v41.TintColor = Color3.fromRGB(106, 116, 255);
            v41.Brightness = 0.4;
            v41.Contrast = 1;
            v41.Saturation = -0.5;
            TweenService:Create(v41, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(v41, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v41.Destroy, v41);
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(20, 1.5, 6);

            if Players:GetPlayerFromCharacter(u34) ~= Players.LocalPlayer then
                return;
            end;

            local u42, u43 = mainreplication.bodyVelocity(u35, 203.66666666666669, 0.75, nil, nil, true, TweenInfo.new(1.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
            mainreplication.rockFlakes(u35, 0.8);
            local u44 = nil;
            u44 = RunService.RenderStepped:Connect(function(p45) -- Line: 535
                -- upvalues: u42 (copy), u44 (ref), u35 (ref), u43 (copy)
                if u42 and u42:IsDescendantOf(game) then
                    u42.Velocity = u35.CFrame.LookVector * u43.Value;

                    return;
                end;

                u44:Disconnect();
            end);
            task.delay(1, u44.Disconnect, u44);
        end);
        task.delay(1.7666666666666666, function() -- Line: 546
            -- upvalues: mainreplication (ref), u34 (copy)
            mainreplication.highlight(u34, Color3.fromRGB(223, 223, 223), 0.5);
        end);
    end,

    corvine_feint_reuse_land = function(u46: any, p47: userdata) -- Line: 551, Name: corvine_feint_reuse_land
        -- upvalues: mainreplication (copy), KatUtil (copy), ReplicatedStorage (copy), vfxUtil (copy), RunService (copy), Lighting (copy), TweenService (copy), Players (copy)
        local u48 = u46.HumanoidRootPart or u46.PrimaryPart;
        task.delay(0.017, function() -- Line: 554
            -- upvalues: mainreplication (ref)
            mainreplication.cameraShake(10, 0.5, 4);
        end);
        local v49 = KatUtil.magnitude(u46);
        KatUtil.destroy_all_velocities(u46);
        mainreplication.bodyVelocity(u48, v49 / 2, 0.4, false);
        local v50 = ReplicatedStorage.Resources.karasu["Corvine Feint"].Stepovers.HitVFX:Clone();
        v50.Parent = u48;
        KatUtil.forge_emit(v50);
        vfxUtil.disposal(v50, 6);
        task.delay(0.1, function() -- Line: 569
            -- upvalues: mainreplication (ref), u48 (copy), RunService (ref), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), u46 (copy), Players (ref)
            mainreplication.cameraShake(10, 0.3, 6);
            local u51, u52 = mainreplication.bodyVelocity(u48, 221.5151515151515, 0.75, nil, nil, nil, TweenInfo.new(1.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0));
            local u53 = nil;
            u53 = RunService.RenderStepped:Connect(function(p54) -- Line: 574
                -- upvalues: u51 (copy), u53 (ref), u48 (ref), u52 (copy)
                if u51 and u51:IsDescendantOf(game) then
                    u51.Velocity = u48.CFrame.LookVector * u52.Value;

                    return;
                end;

                u53:Disconnect();
            end);
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 10;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v55 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v55.Parent = Lighting;
            v55.TintColor = Color3.fromRGB(106, 116, 255);
            v55.Brightness = 0.4;
            v55.Contrast = 1;
            v55.Saturation = -0.5;
            TweenService:Create(v55, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(v55, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v55.Destroy, v55);
            mainreplication.fov(false, 90);
            mainreplication.fov(true, 70, 0.85, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(35, 25);
            mainreplication.highlight(u46, Color3.fromRGB(48, 60, 120), 0.75);
            local _ = Players.LocalPlayer == Players:GetPlayerFromCharacter(u46);
            print("hi");
        end);
    end,

    corvine_feint_reuse_dash = function(p56: any, p57: userdata) -- Line: 614, Name: corvine_feint_reuse_dash
        -- upvalues: KatUtil (copy), ReplicatedStorage (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), vfxUtil (copy), Players (copy)
        local v58 = p56.HumanoidRootPart or p56.PrimaryPart;
        KatUtil.destroy_all_velocities(p56);
        local v59 = ReplicatedStorage.Resources.karasu["Corvine Feint"].Stepovers.Run:Clone();
        v59.Main.Weld.Part0 = v58;
        v59:PivotTo(v58.CFrame);
        v59.Parent = workspace.Effects;
        mainreplication.Emit(v58, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
        local u60 = ReplicatedStorage.Resources.rundasheff:Clone();
        u60.main.Weld.Part0 = v58;
        u60.Parent = workspace.Effects;

        if Util.canshiftcolor(LocalPlayer, p56) then
            vfxUtil.LeanTowardsColor(u60, p56:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p56:GetAttribute("CustomAlpha") or 0.985);
        end;

        mainreplication.rockFlakes(v58, 0.8);
        u60.Air.Size = Vector3.new(4.998, 0.503, 4.998);
        u60.Air.Transparency = 0.8;
        local Air = u60.main.Air;
        Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
        TweenService:Create(u60.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            C0 = u60.main.Air.C0 * CFrame.new(0, 15, 0)
        }):Play();
        TweenService:Create(u60.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(17.136, 1.132, 16.878),
            Transparency = 1
        }):Play();
        u60.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
        u60.Wind1.Transparency = 0.9;
        TweenService:Create(u60.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 650
            -- upvalues: u60 (copy), TweenService (ref)
            u60.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
            u60.Wind1.Transparency = 0.9;
            TweenService:Create(u60.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(19.108, 11.452, 11.292),
                Transparency = 1
            }):Play();
        end);
        u60.End.Size = Vector3.new(5, 1, 5);
        u60.End.Transparency = 0.65;
        local End = u60.main.End;
        End.C0 = End.C0 * CFrame.new(0, 0, 0);
        TweenService:Create(u60.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u60.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u60.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 666
            -- upvalues: u60 (copy), TweenService (ref)
            u60.End.Size = Vector3.new(5, 1, 5);
            u60.End.Transparency = 0.65;
            local End2 = u60.main.End;
            End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
            TweenService:Create(u60.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                C0 = u60.main.End.C0 * CFrame.new(0, -15, 0)
            }):Play();
            TweenService:Create(u60.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                Size = Vector3.new(12.999, 2.766, 12.999),
                Transparency = 1
            }):Play();
        end);
        u60.A.Size = Vector3.new(14.29, 4.752, 5.444);
        u60.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
        u60.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
        u60.A.Decal.Transparency = 0.9;
        TweenService:Create(u60.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            C0 = u60.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
        }):Play();
        TweenService:Create(u60.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Size = Vector3.new(33.166, 4.752, 5.443)
        }):Play();
        TweenService:Create(u60.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Scale = Vector3.new(0.715, 0.303, 0.315)
        }):Play();
        TweenService:Create(u60.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        KatUtil.forge_emit(v59);
        vfxUtil.disposal(v59, 6);
        vfxUtil.disposal(u60, 2);
        mainreplication.bodyVelocity(v58, 135, 1.15, nil, nil, nil, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
        mainreplication.fov(false, 55);
        mainreplication.fov(true, 70, 0.85, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        local _ = Players.LocalPlayer == Players:GetPlayerFromCharacter(p56);
    end,

    dive_bomb_assault = function(u61: any, p62: userdata) -- Line: 703, Name: dive_bomb_assault
        -- upvalues: vfxUtil (copy), Players (copy), mainreplication (copy), KatUtil (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
        local u63 = u61.HumanoidRootPart or u61.PrimaryPart;
        local u64 = vfxUtil.getResources().karasu["Crow Shot"];

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u61) then
            mainreplication.fov(true, 90, 0.42, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        end;

        local u65 = u64.LegFX:Clone();
        u65.Weld.Part0 = u61["Right Leg"];
        u65.Parent = u61;
        KatUtil.forge_emit(u65);
        vfxUtil.disposal(u65, 6);
        task.delay(0.43, function() -- Line: 719
            -- upvalues: KatUtil (ref), u64 (copy), u63 (copy), Util (ref), LocalPlayer (ref), u61 (copy), vfxUtil (ref), vfxUtil (ref), u65 (copy), Players (ref), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            local v66 = KatUtil.create_vfx_instance(u64.VFX, u63.CFrame, "offset");

            if Util.canshiftcolor(LocalPlayer, u61) then
                vfxUtil.LeanTowardsColor(v66, u61:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u61:GetAttribute("CustomAlpha") or 0.985);
            end;

            KatUtil.forge_emit(v66);
            vfxUtil.disposal(u65, 6);

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u61) then
                mainreplication.springcamerashake(40, 30);
                mainreplication.fov(false, 40);
                mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                local v67 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v67.Parent = Lighting;
                v67.TintColor = Color3.fromRGB(70, 89, 255);
                v67.Brightness = 0.4;
                v67.Contrast = 1;
                v67.Saturation = -0.4;
                TweenService:Create(v67, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v67, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
            end;
        end);
    end,

    karasutrapjump = function(u68) -- Line: 745, Name: karasutrapjump
        -- upvalues: vfxUtil (copy), trove (copy), KatUtil (copy), Players (copy)
        if u68:GetAttribute("frozen") then
            return;
        end;

        local v69 = u68.HumanoidRootPart or u68.PrimaryPart;
        local AerialCrowTrap = vfxUtil.getResources().karasu["Silent Steal"].AerialCrowTrap;
        local u70 = trove.new();
        u70:AttachToInstance(u68);
        u70:Add(u68:GetAttributeChangedSignal("frozen"):Connect(function() -- Line: 753
            -- upvalues: u68 (copy), u70 (copy)
            if u68:GetAttribute("frozen") then
                u70:Destroy();
            end;
        end));
        KatUtil.destroy_all_velocities(u68);
        local v71 = u70:Add(AerialCrowTrap.Land:Clone());
        v71.Parent = v69;
        local Jump = require(script.Compiled.Jump);
        local JumpMiss = require(script.Parsers.JumpMiss);

        for _, v in Jump do
            u70:Add(task.delay(v[1] / 60, v[2], JumpMiss, u68, v71));
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u68) then
            local u72 = u70:Add(Instance.new("BodyVelocity"));
            u72.Velocity = (v69.CFrame.LookVector * 10 + Vector3.new(0, 10, 0)) * 5;
            u72.P = 13500;
            u72.MaxForce = Vector3.new(135000, 135000, 135000);
            u72.Parent = v69;
            u70:Add(task.delay(0.2, function() -- Line: 776
                -- upvalues: u72 (copy)
                pcall(game.Destroy, u72);
            end));
        end;

        u70:Add(task.delay(4, function() -- Line: 781
            -- upvalues: u70 (copy)
            u70:Destroy();
        end));
    end,

    karasutraphit = function(p73) -- Line: 787, Name: karasutraphit
        -- upvalues: trove (copy), Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy)
        if not p73.HumanoidRootPart then
            local _ = p73.PrimaryPart;
        end;

        local u74 = trove.new();
        u74:AttachToInstance(p73);
        local Hit = require(script.Compiled.Hit);
        local JumpMiss = require(script.Parsers.JumpMiss);

        for _, v in Hit do
            u74:Add(task.delay(v[1] / 60, v[2], JumpMiss, p73));
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(p73) then
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 13;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v75 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v75.Parent = Lighting;
            v75.TintColor = Color3.fromRGB(112, 131, 255);
            v75.Brightness = 0.4;
            v75.Contrast = 1;
            v75.Saturation = -0.4;
            TweenService:Create(v75, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v75, TweenInfo.new(0.65, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(1, v75.Destroy, v75);
            mainreplication.cameraShake(10, 2, 6);
        end;

        u74:Add(task.delay(1, function() -- Line: 823
            -- upvalues: u74 (copy)
            u74:Destroy();
        end));
    end,

    karasu_pass_counter = function(u76, p77) -- Line: 828, Name: karasu_pass_counter
        -- upvalues: trove (copy), mainreplication (copy), Players (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy)
        if not u76.HumanoidRootPart then
            local _ = u76.PrimaryPart;
        end;

        local u78 = trove.new();
        u78:AttachToInstance(u76);
        local CounterPass = require(script.Compiled.CounterPass);
        local RavenRise = require(script.Parsers.RavenRise);

        for _, v in CounterPass do
            u78:Add(task.delay(v[1] / 60, v[2], RavenRise, u76));
        end;

        mainreplication.highlight(u76, Color3.fromRGB(42, 53, 255), 0.5);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u76) then
            mainreplication.fov(false, 30);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 12;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v79 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v79.Parent = Lighting;
            v79.TintColor = Color3.fromRGB(112, 131, 255);
            v79.Brightness = 0.4;
            v79.Contrast = 1;
            v79.Saturation = -0.4;
            TweenService:Create(v79, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v79, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(1, v79.Destroy, v79);
            mainreplication.cameraShake(10, 2, 6);
        end;

        task.delay(0.67, function() -- Line: 866
            -- upvalues: mainreplication (ref), u76 (copy), Players (ref), Lighting (ref), TweenService (ref), ReplicatedStorage (ref)
            mainreplication.highlight(u76, Color3.fromRGB(42, 53, 255), 0.5);

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u76) then
                mainreplication.fov(false, 100);
                mainreplication.fov(true, 70, 0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                local BlurEffect = Instance.new("BlurEffect");
                BlurEffect.Size = 12;
                BlurEffect.Parent = Lighting;
                TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                task.delay(0.533, BlurEffect.Destroy, BlurEffect);
                local v80 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v80.Parent = Lighting;
                v80.TintColor = Color3.fromRGB(112, 131, 255);
                v80.Brightness = 0.4;
                v80.Contrast = 1;
                v80.Saturation = -0.4;
                TweenService:Create(v80, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v80, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(1, v80.Destroy, v80);
                mainreplication.springcamerashake(35, 30);
            end;
        end);
        u78:Add(task.delay(5, function() -- Line: 894
            -- upvalues: u78 (copy)
            u78:Destroy();
        end));
    end,

    karasu_raven_relay = function(p81, p82, p83, p84, u85) -- Line: 899, Name: karasu_raven_relay
        -- upvalues: vfxUtil (copy), trove (copy), Players (copy), mainreplication (copy), RunService (copy)
        local v86 = vfxUtil.getResources().karasu["Raven Relay"];
        local v87 = p81.HumanoidRootPart or p81.PrimaryPart;

        if not p82.HumanoidRootPart then
            local _ = p82.PrimaryPart;
        end;

        local u88 = trove.new();
        u88:AttachToInstance(p81);
        local raven_relay = require(script.Compiled.raven_relay);
        local v89 = {};

        if Players:GetPlayerFromCharacter(p81) == Players.LocalPlayer then
            mainreplication.fov(false, 55);
            mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;

        local u90 = u88:Add(v86.Mark:Clone());
        local v91 = u88:Add(v86.VFX:Clone());
        v91.Parent = workspace.Effects;
        v91:PivotTo(v87.CFrame);
        v91.Weld.Part0 = v87;
        u90.Anchored = true;
        u90.Parent = workspace.Effects;
        v89.Mark = u90;
        v89.Meshes = v86.Meshes;
        v89.Hit = v91.Hit;
        v89.Shoot = v91.Shoot;

        for _, v in raven_relay do
            u88:Add(task.delay(v[1] / 60 * p84, v[2], v89, v87));
        end;

        if p83 then
            p83.Changed:Once(function() -- Line: 938
                -- upvalues: u88 (copy)
                u88:Destroy();
            end);
        end;

        u88:Add(task.delay(5, function() -- Line: 943
            -- upvalues: u88 (copy)
            u88:Destroy();
        end));
        u88:Connect(RunService.PreRender, function() -- Line: 947
            -- upvalues: u90 (copy), u85 (copy)
            u90.CFrame = u85.Value;
        end);
    end,

    karasu_raven_relay_shot = function(p92, p93, p94, p95) -- Line: 952, Name: karasu_raven_relay_shot
        -- upvalues: mainreplication (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy)
        mainreplication.fov(false, 55);
        mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v96 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v96.Parent = Lighting;
        v96.TintColor = Color3.fromRGB(112, 131, 255);
        v96.Brightness = 0.4;
        v96.Contrast = 1;
        v96.Saturation = -0.4;
        TweenService:Create(v96, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v96, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(1, v96.Destroy, v96);
        mainreplication.springcamerashake(30, 30);
    end,

    karasu_run = function(p97, p98) -- Line: 979, Name: karasu_run
        -- upvalues: vfxUtil (copy), trove (copy), TweenService (copy), KatUtil (copy), vfxUtil (copy), mainreplication (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), RunService (copy)
        local u99 = p97.HumanoidRootPart or p97.PrimaryPart;
        local v100 = vfxUtil.getResources().karasu["Silent Steal"];
        local u101 = trove.new();
        u101:AttachToInstance(p97);
        local v102 = u101:Add(Instance.new("NumberValue"));
        v102.Value = 20;
        TweenService:Create(v102, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Value = 65
        }):Play();
        KatUtil.destroy_all_velocities(p97);
        local u103 = v100.RunVFX:Clone();
        u103.Weld.Part0 = u99;
        u103:PivotTo(u99.CFrame);
        u103.Parent = workspace.Effects;
        KatUtil.Enable(u103, "ParticleEmitter", true);
        task.delay(1.25, function() -- Line: 1000
            -- upvalues: KatUtil (ref), u103 (copy)
            KatUtil.Enable(u103, "ParticleEmitter", false);
        end);
        local v104 = v100.TrailPart:Clone();
        v104.Weld.Part0 = p97["Left Arm"];
        v104.Parent = u103;
        local v105 = v100.TrailPart:Clone();
        v105.Weld.Part0 = p97["Right Arm"];
        v105.Parent = u103;
        vfxUtil.disposal({ v104, v105 }, 1.25);
        vfxUtil.disposal(u103, 1.5);
        local u106, u107 = mainreplication.bodyVelocity(u99, 130, 1.25, nil, nil, nil, TweenInfo.new(3.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0));

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(p97) then
            mainreplication.fov(false, 40);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(20, 40);
            local v108 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v108.Parent = Lighting;
            v108.TintColor = Color3.fromRGB(108, 123, 255);
            v108.Brightness = 0.4;
            v108.Contrast = 1;
            v108.Saturation = -0.4;
            TweenService:Create(v108, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v108, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v108.Destroy, v108);
        end;

        u101:Add(RunService.PreRender:Connect(function() -- Line: 1036
            -- upvalues: u107 (copy), u106 (copy), u99 (copy)
            if u107 then
                u106.Velocity = u99.CFrame.LookVector * u107.Value;
            end;
        end));

        if p98 then
            p98.Changed:Once(function() -- Line: 1043
                -- upvalues: u101 (copy), KatUtil (ref), u103 (copy)
                u101:Destroy();
                KatUtil.Enable(u103, "ParticleEmitter", false);
                u103:Destroy();
            end);
        end;

        u101:Add(task.delay(1.5, function() -- Line: 1050
            -- upvalues: u101 (copy)
            u101:Destroy();
        end));
    end,

    karasu_run_get = function(p109, p110) -- Line: 1056, Name: karasu_run_get
        -- upvalues: vfxUtil (copy), Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), trove (copy), KatUtil (copy), vfxUtil (copy), RunService (copy)
        local u111 = p109.HumanoidRootPart or p109.PrimaryPart;
        local v112 = vfxUtil.getResources().karasu["Silent Steal"];

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(p109) then
            mainreplication.springcamerashake(15, 40);
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v113 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v113.Parent = Lighting;
            v113.TintColor = Color3.fromRGB(120, 140, 255);
            v113.Brightness = 0.4;
            v113.Contrast = 1;
            v113.Saturation = -0.4;
            TweenService:Create(v113, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v113, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v113.Destroy, v113);
        end;

        local u114 = trove.new();
        u114:AttachToInstance(p109);
        local u115 = u114:Add(Instance.new("NumberValue"));
        u115.Value = 94.5;
        TweenService:Create(u115, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
        KatUtil.destroy_all_velocities(p109);
        local u116 = u114:Add(Instance.new("BodyVelocity"));
        u116.MaxForce = Vector3.new(350000, 0, 350000);
        u116.P = 13500;
        local u117 = v112.CatchVFX:Clone();
        u117.Weld.Part0 = u111;
        u117:PivotTo(u111.CFrame);
        u117.Parent = workspace.Effects;
        KatUtil.forge_emit(u117.Catch);
        task.delay(0.5833333333333334, function() -- Line: 1099
            -- upvalues: KatUtil (ref), u117 (copy)
            KatUtil.forge_emit(u117.Grass1);
        end);
        local v118 = v112.TrailPart:Clone();
        v118.Weld.Part0 = p109["Left Leg"];
        v118.Parent = u117;
        local v119 = v112.TrailPart:Clone();
        v119.Weld.Part0 = p109["Right Leg"];
        v119.Parent = u117;
        vfxUtil.disposal({ v118, v119 }, 0.7);
        vfxUtil.disposal(u117, 2);
        u114:Add(RunService.PreRender:Connect(function() -- Line: 1114
            -- upvalues: u116 (copy), u111 (copy), u115 (copy)
            u116.Velocity = u111.CFrame.LookVector * u115.Value;
        end));
        u116.Parent = u111;

        if p110 then
            p110.Changed:Once(function() -- Line: 1120
                -- upvalues: u114 (copy)
                u114:Destroy();
            end);
        end;

        u114:Add(task.delay(1, function() -- Line: 1125
            -- upvalues: u114 (copy)
            u114:Destroy();
        end));
    end,

    karasu_windup_tspecial = function(u120) -- Line: 1131, Name: karasu_windup_tspecial
        -- upvalues: vfxUtil (copy), trove (copy), Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy)
        if u120:GetAttribute("frozen") then
            return;
        end;

        local _ = vfxUtil.getResources().karasu["Wing-Arm-Block"];

        if not u120.HumanoidRootPart then
            local _ = u120.PrimaryPart;
        end;

        local u121 = trove.new();
        u121:AttachToInstance(u120);
        u121:Add(u120:GetAttributeChangedSignal("frozen"):Connect(function() -- Line: 1140
            -- upvalues: u120 (copy), u121 (copy)
            if u120:GetAttribute("frozen") then
                u121:Destroy();
            end;
        end));
        local startup = require(script.Compiled.wing.startup);
        local StartUp = require(script.Parsers.StartUp);

        for _, v in startup do
            u121:Add(task.delay(v[1] / 60, v[2], StartUp, u120));
        end;

        u121:Add(task.delay(0.28571428571428575, function() -- Line: 1153
            -- upvalues: Players (ref), u120 (copy), mainreplication (ref), u121 (copy), Lighting (ref), TweenService (ref)
            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u120) then
                mainreplication.fov(true, 75, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                mainreplication.cameraShake(15, 0.5, 4, nil);
                u121:Add(task.delay(0.3, function() -- Line: 1157
                    -- upvalues: mainreplication (ref)
                    mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                end));
            end;

            mainreplication.highlight(u120, Color3.fromRGB(42, 53, 255), 0.5);

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u120) then
                local BlurEffect = Instance.new("BlurEffect");
                BlurEffect.Size = 6;
                BlurEffect.Parent = Lighting;
                TweenService:Create(BlurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                task.delay(0.3, BlurEffect.Destroy, BlurEffect);
            end;
        end));
        u121:Add(task.delay(5, function() -- Line: 1174
            -- upvalues: u121 (copy)
            u121:Destroy();
        end));
    end,

    karasu_tspecial_single = function(u122: any, u123: boolean, p124: boolean?) -- Line: 1179, Name: karasu_tspecial_single
        -- upvalues: vfxUtil (copy), trove (copy), KatUtil (copy), mainreplication (copy), vfxUtil (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), TweenService (copy), Players (copy), Lighting (copy), soundUtil (copy)
        if u122:GetAttribute("frozen") then
            return;
        end;

        local u125 = vfxUtil.getResources().karasu["Wing-Arm-Block"];
        local u126 = u122.HumanoidRootPart or u122.PrimaryPart;
        local u127 = trove.new();
        u127:AttachToInstance(u122);
        u127:Add(u122:GetAttributeChangedSignal("frozen"):Connect(function() -- Line: 1188
            -- upvalues: u122 (copy), u127 (copy)
            if u122:GetAttribute("frozen") then
                u127:Destroy();
            end;
        end));
        local v128 = require(script.Compiled.wing["1person"]);
        local OneGuy = require(script.Parsers.OneGuy);
        KatUtil.destroy_all_velocities(u122);

        for _, v in v128 do
            u127:Add(task.delay(v[1] / 60, v[2], OneGuy, u122));
        end;

        u127:Add(task.delay(0.5, function() -- Line: 1203
            -- upvalues: u122 (copy), u126 (copy), u123 (copy), mainreplication (ref), u127 (copy), vfxUtil (ref), KatUtil (ref), ReplicatedStorage (ref), Util (ref), LocalPlayer (ref), vfxUtil (ref), TweenService (ref), Players (ref), Lighting (ref), soundUtil (ref), u125 (copy)
            if u122:GetAttribute("frozen") or u126.Anchored then
                return;
            end;

            if u123 then
                mainreplication.highlight(u122, Color3.fromRGB(255, 255, 255), 1.75, nil, 0);

                if Players.LocalPlayer == Players:GetPlayerFromCharacter(u122) then
                    mainreplication.springcamerashake(40, 30);
                    mainreplication.fov(false, 90);
                    mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                    local v129 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v129.Parent = Lighting;
                    v129.TintColor = Color3.fromRGB(255, 255, 255);
                    v129.Brightness = -0.175;
                    v129.Contrast = 0.1;
                    v129.Saturation = -0.4;
                    TweenService:Create(v129, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v129, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Contrast = 0,
                        Brightness = 0,
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                end;

                soundUtil:play(u125.Feint, u126);
            else
                local v130 = mainreplication.bodyVelocity(u126, 114.9, 0.8999999999999999, nil, nil, nil);

                if v130 then
                    u127:Add(v130);
                end;

                mainreplication.rockFlakes(u126, 0.8);
                local u131 = vfxUtil.getResources().karasu["Silent Steal"].RunVFX:Clone();
                u131.Weld.Part0 = u126;
                u131:PivotTo(u126.CFrame);
                u131.Parent = workspace.Effects;
                KatUtil.Enable(u131, "ParticleEmitter", true);
                task.delay(0.8, function() -- Line: 1217
                    -- upvalues: KatUtil (ref), u131 (copy)
                    KatUtil.Enable(u131, "ParticleEmitter", false);
                end);
                local v132 = vfxUtil.getResources().karasu["Silent Steal"].TrailPart:Clone();
                v132.Weld.Part0 = u122["Left Arm"];
                v132.Parent = u131;
                local v133 = vfxUtil.getResources().karasu["Silent Steal"].TrailPart:Clone();
                v133.Weld.Part0 = u122["Right Arm"];
                v133.Parent = u131;
                vfxUtil.disposal({ v132, v133 }, 1);
                vfxUtil.disposal(u131, 1.25);
                mainreplication.Emit(u126, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
                local u134 = ReplicatedStorage.Resources.rundasheff:Clone();
                u134.main.Weld.Part0 = u126;
                u134.Parent = workspace.Effects;
                u127:Add(u134);

                if Util.canshiftcolor(LocalPlayer, u122) then
                    vfxUtil.LeanTowardsColor(u134, u122:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u122:GetAttribute("CustomAlpha") or 0.985);
                end;

                u134.Air.Size = Vector3.new(4.998, 0.503, 4.998);
                u134.Air.Transparency = 0.8;
                local Air = u134.main.Air;
                Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
                TweenService:Create(u134.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    C0 = u134.main.Air.C0 * CFrame.new(0, 15, 0)
                }):Play();
                TweenService:Create(u134.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(17.136, 1.132, 16.878),
                    Transparency = 1
                }):Play();
                u134.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
                u134.Wind1.Transparency = 0.9;
                TweenService:Create(u134.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(19.108, 11.452, 11.292),
                    Transparency = 1
                }):Play();
                task.delay(0.15, function() -- Line: 1257
                    -- upvalues: u134 (copy), TweenService (ref)
                    u134.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
                    u134.Wind1.Transparency = 0.9;
                    TweenService:Create(u134.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                        Size = Vector3.new(19.108, 11.452, 11.292),
                        Transparency = 1
                    }):Play();
                end);
                u134.End.Size = Vector3.new(5, 1, 5);
                u134.End.Transparency = 0.65;
                local End = u134.main.End;
                End.C0 = End.C0 * CFrame.new(0, 0, 0);
                TweenService:Create(u134.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    C0 = u134.main.End.C0 * CFrame.new(0, -15, 0)
                }):Play();
                TweenService:Create(u134.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(12.999, 2.766, 12.999),
                    Transparency = 1
                }):Play();
                task.delay(0.15, function() -- Line: 1273
                    -- upvalues: u134 (copy), TweenService (ref)
                    u134.End.Size = Vector3.new(5, 1, 5);
                    u134.End.Transparency = 0.65;
                    local End2 = u134.main.End;
                    End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
                    TweenService:Create(u134.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                        C0 = u134.main.End.C0 * CFrame.new(0, -15, 0)
                    }):Play();
                    TweenService:Create(u134.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                        Size = Vector3.new(12.999, 2.766, 12.999),
                        Transparency = 1
                    }):Play();
                end);
                u134.A.Size = Vector3.new(14.29, 4.752, 5.444);
                u134.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
                u134.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
                u134.A.Decal.Transparency = 0.9;
                TweenService:Create(u134.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    C0 = u134.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
                }):Play();
                TweenService:Create(u134.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(33.166, 4.752, 5.443)
                }):Play();
                TweenService:Create(u134.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    Scale = Vector3.new(0.715, 0.303, 0.315)
                }):Play();
                TweenService:Create(u134.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                vfxUtil.disposal(u134, 2);

                if Players.LocalPlayer == Players:GetPlayerFromCharacter(u122) then
                    mainreplication.springcamerashake(40, 30);
                    mainreplication.fov(false, 90);
                    mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                    local v135 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v135.Parent = Lighting;
                    v135.TintColor = Color3.fromRGB(70, 89, 255);
                    v135.Brightness = 0.4;
                    v135.Contrast = 1;
                    v135.Saturation = -0.4;
                    TweenService:Create(v135, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v135, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Contrast = 0,
                        Brightness = 0,
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                end;
            end;
        end));
        u127:Add(task.delay(5, function() -- Line: 1337
            -- upvalues: u127 (copy)
            u127:Destroy();
        end));
    end,

    karasu_tspecial_dual = function(u136: any, u137: boolean, u138: boolean?) -- Line: 1342, Name: karasu_tspecial_dual
        -- upvalues: vfxUtil (copy), trove (copy), KatUtil (copy), Players (copy), mainreplication (copy), ReplicatedStorage (copy), vfxUtil (copy), Util (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), soundUtil (copy)
        if u136:GetAttribute("frozen") then
            return;
        end;

        local u139 = vfxUtil.getResources().karasu["Wing-Arm-Block"];
        local u140 = u136.HumanoidRootPart or u136.PrimaryPart;
        local u141 = trove.new();
        u141:AttachToInstance(u136);
        u141:Add(u136:GetAttributeChangedSignal("frozen"):Connect(function() -- Line: 1351
            -- upvalues: u136 (copy), u141 (copy)
            if u136:GetAttribute("frozen") then
                u141:Destroy();
            end;
        end));
        local v142 = require(script.Compiled.wing["2person"]);
        local TwoGuys = require(script.Parsers.TwoGuys);
        KatUtil.destroy_all_velocities(u136);

        for _, v in v142 do
            u141:Add(task.delay(v[1] / 60, v[2], TwoGuys, u136));
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u136) then
            mainreplication.fov(true, 60, 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end;

        u141:Add(task.delay(0.5, function() -- Line: 1370
            -- upvalues: u136 (copy), u140 (copy), u137 (copy), mainreplication (ref), u138 (copy), u141 (copy), ReplicatedStorage (ref), vfxUtil (ref), KatUtil (ref), Util (ref), LocalPlayer (ref), vfxUtil (ref), TweenService (ref), Players (ref), Lighting (ref), soundUtil (ref), u139 (copy)
            if u136:GetAttribute("frozen") or u140.Anchored then
                return;
            end;

            if u137 then
                mainreplication.highlight(u136, Color3.fromRGB(255, 255, 255), 1.75, nil, 0);

                if Players.LocalPlayer == Players:GetPlayerFromCharacter(u136) then
                    mainreplication.springcamerashake(40, 30);
                    mainreplication.fov(false, 100);
                    mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                    local v143 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v143.Parent = Lighting;
                    v143.TintColor = Color3.fromRGB(255, 255, 255);
                    v143.Brightness = -0.175;
                    v143.Contrast = 0.1;
                    v143.Saturation = -0.4;
                    TweenService:Create(v143, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v143, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Contrast = 0,
                        Brightness = 0,
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                end;

                soundUtil:play(u139.Feint, u140);
            else
                local v144 = mainreplication.bodyVelocity(u140, 184.44444444444443 * (u138 and 1.1 or 1.05), 0.8999999999999999, nil, nil, nil);

                if v144 then
                    u141:Add(v144);
                end;

                mainreplication.rockFlakes(u140, 0.8);
                mainreplication.Emit(u140, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
                local u145 = vfxUtil.getResources().karasu["Silent Steal"].RunVFX:Clone();
                u145.Weld.Part0 = u140;
                u145:PivotTo(u140.CFrame);
                u145.Parent = workspace.Effects;
                KatUtil.Enable(u145, "ParticleEmitter", true);
                task.delay(0.8, function() -- Line: 1386
                    -- upvalues: KatUtil (ref), u145 (copy)
                    KatUtil.Enable(u145, "ParticleEmitter", false);
                end);
                local v146 = vfxUtil.getResources().karasu["Silent Steal"].TrailPart:Clone();
                v146.Weld.Part0 = u136["Left Arm"];
                v146.Parent = u145;
                local v147 = vfxUtil.getResources().karasu["Silent Steal"].TrailPart:Clone();
                v147.Weld.Part0 = u136["Right Arm"];
                v147.Parent = u145;
                vfxUtil.disposal({ v146, v147 }, 1);
                vfxUtil.disposal(u145, 1.25);
                local u148 = ReplicatedStorage.Resources.rundasheff:Clone();
                u148.main.Weld.Part0 = u140;
                u148.Parent = workspace.Effects;
                u141:Add(u148);

                if Util.canshiftcolor(LocalPlayer, u136) then
                    vfxUtil.LeanTowardsColor(u148, u136:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u136:GetAttribute("CustomAlpha") or 0.985);
                end;

                u148.Air.Size = Vector3.new(4.998, 0.503, 4.998);
                u148.Air.Transparency = 0.8;
                local Air = u148.main.Air;
                Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
                TweenService:Create(u148.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    C0 = u148.main.Air.C0 * CFrame.new(0, 15, 0)
                }):Play();
                TweenService:Create(u148.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(17.136, 1.132, 16.878),
                    Transparency = 1
                }):Play();
                u148.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
                u148.Wind1.Transparency = 0.9;
                TweenService:Create(u148.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(19.108, 11.452, 11.292),
                    Transparency = 1
                }):Play();
                task.delay(0.15, function() -- Line: 1424
                    -- upvalues: u148 (copy), TweenService (ref)
                    u148.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
                    u148.Wind1.Transparency = 0.9;
                    TweenService:Create(u148.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                        Size = Vector3.new(19.108, 11.452, 11.292),
                        Transparency = 1
                    }):Play();
                end);
                u148.End.Size = Vector3.new(5, 1, 5);
                u148.End.Transparency = 0.65;
                local End = u148.main.End;
                End.C0 = End.C0 * CFrame.new(0, 0, 0);
                TweenService:Create(u148.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    C0 = u148.main.End.C0 * CFrame.new(0, -15, 0)
                }):Play();
                TweenService:Create(u148.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(12.999, 2.766, 12.999),
                    Transparency = 1
                }):Play();
                task.delay(0.15, function() -- Line: 1440
                    -- upvalues: u148 (copy), TweenService (ref)
                    u148.End.Size = Vector3.new(5, 1, 5);
                    u148.End.Transparency = 0.65;
                    local End2 = u148.main.End;
                    End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
                    TweenService:Create(u148.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                        C0 = u148.main.End.C0 * CFrame.new(0, -15, 0)
                    }):Play();
                    TweenService:Create(u148.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                        Size = Vector3.new(12.999, 2.766, 12.999),
                        Transparency = 1
                    }):Play();
                end);
                u148.A.Size = Vector3.new(14.29, 4.752, 5.444);
                u148.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
                u148.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
                u148.A.Decal.Transparency = 0.9;
                TweenService:Create(u148.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    C0 = u148.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
                }):Play();
                TweenService:Create(u148.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    Size = Vector3.new(33.166, 4.752, 5.443)
                }):Play();
                TweenService:Create(u148.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    Scale = Vector3.new(0.715, 0.303, 0.315)
                }):Play();
                TweenService:Create(u148.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                vfxUtil.disposal(u148, 2);
                mainreplication.highlight(u136, Color3.fromRGB(37, 59, 255), 0.5);

                if Players.LocalPlayer == Players:GetPlayerFromCharacter(u136) then
                    mainreplication.springcamerashake(40, 30);
                    mainreplication.fov(false, 100);
                    mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                    local v149 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                    v149.Parent = Lighting;
                    v149.TintColor = Color3.fromRGB(70, 89, 255);
                    v149.Brightness = 0.4;
                    v149.Contrast = 1;
                    v149.Saturation = -0.4;
                    TweenService:Create(v149, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Saturation = 0
                    }):Play();
                    TweenService:Create(v149, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Contrast = 0,
                        Brightness = 0,
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                end;
            end;
        end));
        u141:Add(task.delay(5, function() -- Line: 1505
            -- upvalues: u141 (copy)
            u141:Destroy();
        end));
    end,

    karasu_flow = function(u150) -- Line: 1512, Name: karasu_flow
        -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
        local karasu = vfxUtil.getResources().karasu;
        local Flow = karasu.Flow;
        local v151 = u150.HumanoidRootPart or u150.PrimaryPart;
        local u152 = trove.new();
        u152:AttachToInstance(u150);
        local Flow2 = require(script.Compiled.Flow);
        local v153 = u152:Add(Flow.VFX:Clone());
        v153.Parent = workspace.Effects;
        local v154 = u152:Construct(Flow.Aura);
        vfxUtil.setupAura(u150, v154, true);
        v154.Parent = workspace.Effects;
        v153:PivotTo(v151.CFrame);
        mainreplication.sceneEnabled(true);
        u152:Add(function() -- Line: 1533
            -- upvalues: mainreplication (ref)
            mainreplication.sceneEnabled(false);
        end);
        local u155 = soundUtil:play(Flow.OnBall, soundUtil, {
            Character = u150
        }).Name == "Dub";
        u152:Add(task.delay(0.412, function() -- Line: 1539
            -- upvalues: TekrinnDialogue (ref), u150 (copy)
            TekrinnDialogue.Speak(u150, {
                {
                    Text = "All righty, data entered.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 5,
                        Lifetime = 1
                    }
                }
            }, 3);
        end));
        u152:Add(task.delay(3.166, function() -- Line: 1565
            -- upvalues: TekrinnDialogue (ref), u150 (copy), u155 (copy)
            TekrinnDialogue.Speak(u150, {
                {
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.05,
                    Text = u155 and "Well," or "So now,",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 5,
                        Lifetime = 1
                    }
                },
                {
                    Text = " ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 1.118,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 5,
                        Lifetime = 1
                    }
                },
                {
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.05,
                    Text = u155 and "guess it\'s about time for some output." or "it\'s output time.",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 1
                    }
                }
            }, 3);
        end));
        local v156 = u152:Add(Flow.RootPart:Clone());
        v156.Parent = u150;
        v156.CFrame = u150:FindFirstChild("Torso").CFrame * CFrame.new(0, -3, 0);
        local v157 = u152:Add(Instance.new("Motor6D"));
        v157.Parent = v156;
        v157.Part1 = v156;
        v157.Part0 = u150:FindFirstChild("Torso");
        v157.C0 = CFrame.new(-0, -2.995, 0.001);
        local FeathersLeftArm = karasu.FeathersLeftArm;

        for _, child in karasu.FeathersRightArm:GetChildren() do
            local v158 = u152:Add(child:Clone());
            v158.CFrame = u150:FindFirstChild("Right Arm").CFrame * CFrame.new(0, -1, 0);
            v158.Parent = workspace.Effects;
            local Weld = Instance.new("Weld");
            Weld.Part0 = u150:FindFirstChild("Right Arm");
            Weld.Part1 = v158;
            Weld.Parent = Weld.Part0;
            Weld.C0 = v158:GetAttribute("motor");
        end;

        for _, child in FeathersLeftArm:GetChildren() do
            local v159 = u152:Add(child:Clone());
            v159.CFrame = u150:FindFirstChild("Left Arm").CFrame * CFrame.new(0, -1, 0);
            v159.Parent = workspace.Effects;
            local Weld = Instance.new("Weld");
            Weld.Part0 = u150:FindFirstChild("Left Arm");
            Weld.Part1 = v159;
            Weld.Parent = Weld.Part0;
            Weld.C0 = v159:GetAttribute("motor");
        end;

        local v160, _ = mainreplication.cutsceneBlender(v151, Flow.Camera, Flow.FOV, nil, nil, CFrame.new(0, -3, 0), Flow.Cam2);

        for _, v in Flow2 do
            u152:Add(task.delay(v[1] / 60, v[2], v153, u150, v154, v160));
        end;

        u152:Add(task.delay(6.07, function() -- Line: 1674
            -- upvalues: u152 (copy)
            u152:Destroy();
        end));
        local v161 = {
            Workspace = v153,
            Vignette = u152:Add(vfxUtil.getMoonEffects()).Vignette,
            Lighting = game:GetService("Lighting")
        };

        if Flow:FindFirstChild("Lighting") then
            vfxUtil.cutscene_lighting(u152, v161, Flow.Lighting, {
                Brightness = 3,
                EnvironmentDiffuseScale = 1,
                EnvironmentSpecularScale = 1,
                GlobalShadows = true,
                ShadowSoftness = 0.2,
                ExposureCompensation = 0,
                ClockTime = 14.5,
                GeographicLatitude = 0,
                Ambient = Color3.fromRGB(70, 70, 70),
                ColorShift_Top = Color3.new(0, 0, 0),
                ColorShift_Bottom = Color3.new(0, 0, 0),
                OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            });
        end;

        MoonPropertyAnimator.ConvertSave(Flow.Moon, v161);
        local v162 = u152:Construct(MoonPropertyAnimator);
        v162:LoadAndConvertSave(Flow.Moon, v161);
        v162:SetOriginalRoot(Flow.VFX.Core.CFrame);
        v162:SetRoot(v151);
        v162:PlayAll();
    end,

    karasu_talons_grasp = function(u163) -- Line: 1711, Name: karasu_talons_grasp
        -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
        local karasu = vfxUtil.getResources().karasu;
        local TalonsGrasp = karasu.TalonsGrasp;
        local v164 = u163.HumanoidRootPart or u163.PrimaryPart;
        local u165 = trove.new();
        u165:AttachToInstance(u163);
        local talonsgrasp = require(script.Compiled.talonsgrasp);
        local v166 = u165:Add(TalonsGrasp.VFX:Clone());
        v166.Parent = workspace.Effects;
        local v167 = u165:Construct(TalonsGrasp.Aura);
        vfxUtil.setupAura(u163, v167, true);
        v167.Parent = workspace.Effects;
        v166:PivotTo(v164.CFrame);
        mainreplication.sceneEnabled(true);
        u165:Add(function() -- Line: 1732
            -- upvalues: mainreplication (ref)
            mainreplication.sceneEnabled(false);
        end);
        local u168 = soundUtil:play(TalonsGrasp.SFX, soundUtil, {
            Character = u163
        }).Name == "Dub";
        u165:Add(task.delay(0.169, function() -- Line: 1738
            -- upvalues: TekrinnDialogue (ref), u163 (copy), u168 (copy)
            TekrinnDialogue.Speak(u163, {
                {
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.04,
                    Text = u168 and "Then, I\'ll have to deliver the punchline!" or "Allow me to deliver the punchline!",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            }, 4);
        end));
        local v169 = u165:Add(TalonsGrasp.RootPart:Clone());
        v169.Parent = u163;
        v169.CFrame = u163:FindFirstChild("Torso").CFrame * CFrame.new(0, -3, 0);
        local v170 = u165:Add(Instance.new("Motor6D"));
        v170.Parent = v169;
        v170.Part1 = v169;
        v170.Part0 = u163:FindFirstChild("Torso");
        v170.C0 = CFrame.new(-0, -2.995, 0.001);
        local FeathersLeftArm = karasu.FeathersLeftArm;

        for _, child in karasu.FeathersRightArm:GetChildren() do
            local v171 = u165:Add(child:Clone());
            v171.CFrame = u163:FindFirstChild("Right Arm").CFrame * CFrame.new(0, -1, 0);
            v171.Parent = workspace.Effects;
            local Weld = Instance.new("Weld");
            Weld.Part0 = u163:FindFirstChild("Right Arm");
            Weld.Part1 = v171;
            Weld.Parent = Weld.Part0;
            Weld.C0 = v171:GetAttribute("motor");
        end;

        for _, child in FeathersLeftArm:GetChildren() do
            local v172 = u165:Add(child:Clone());
            v172.CFrame = u163:FindFirstChild("Left Arm").CFrame * CFrame.new(0, -1, 0);
            v172.Parent = workspace.Effects;
            local Weld = Instance.new("Weld");
            Weld.Part0 = u163:FindFirstChild("Left Arm");
            Weld.Part1 = v172;
            Weld.Parent = Weld.Part0;
            Weld.C0 = v172:GetAttribute("motor");
        end;

        local v173, _ = mainreplication.cutsceneBlender(v164, TalonsGrasp.Camera, TalonsGrasp.FOV, nil, nil, CFrame.new(0, -3, 0), TalonsGrasp.Cam2);

        for _, v in talonsgrasp do
            u165:Add(task.delay(v[1] / 60, v[2], v166, u163, v167, v173));
        end;

        u165:Add(task.delay(4.87, function() -- Line: 1805
            -- upvalues: u165 (copy)
            u165:Destroy();
        end));
        local v174 = {
            Workspace = v166,
            Vignette = u165:Add(vfxUtil.getMoonEffects()).Vignette,
            Lighting = game:GetService("Lighting")
        };

        if TalonsGrasp:FindFirstChild("Lighting") then
            vfxUtil.cutscene_lighting(u165, v174, TalonsGrasp.Lighting, {
                Brightness = 3,
                EnvironmentDiffuseScale = 1,
                EnvironmentSpecularScale = 1,
                GlobalShadows = true,
                ShadowSoftness = 0.2,
                ExposureCompensation = 0,
                ClockTime = 14.5,
                GeographicLatitude = 0,
                Ambient = Color3.fromRGB(70, 70, 70),
                ColorShift_Top = Color3.new(0, 0, 0),
                ColorShift_Bottom = Color3.new(0, 0, 0),
                OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            });
        end;

        MoonPropertyAnimator.ConvertSave(TalonsGrasp.Moon, v174);
        local v175 = u165:Construct(MoonPropertyAnimator);
        v175:LoadAndConvertSave(TalonsGrasp.Moon, v174);
        v175:SetOriginalRoot(TalonsGrasp.VFX.Core.CFrame);
        v175:SetRoot(v164);
        v175:PlayAll();
    end,

    karasu_analytical_positioning = function(u176) -- Line: 1841, Name: karasu_analytical_positioning
        -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), mainreplication (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
        local AnalyticalPositioning = vfxUtil.getResources().karasu["Silent Steal"].AnalyticalPositioning;
        local v177 = u176.HumanoidRootPart or u176.PrimaryPart;
        local u178 = trove.new();
        u178:AttachToInstance(u176);
        local v179 = soundUtil:play(AnalyticalPositioning.SFX, soundUtil, {
            Character = u176
        });
        mainreplication.sceneEnabled(true);
        u178:Add(function() -- Line: 1853
            -- upvalues: mainreplication (ref)
            mainreplication.sceneEnabled(false);
        end);
        local u180 = v179.Name == "Dub";
        u178:Add(task.delay(2.213, function() -- Line: 1859
            -- upvalues: TekrinnDialogue (ref), u176 (copy), u180 (copy)
            TekrinnDialogue.Speak(u176, {
                {
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.05,
                    Text = u180 and "Dingus," or "Dum dum,",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 5,
                        Lifetime = 1
                    }
                },
                {
                    Text = " ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 1.2,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 5,
                        Lifetime = 1
                    }
                },
                {
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.05,
                    Text = u180 and "you\'re average at best." or "you\'re holding everyone back!",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 1
                    }
                }
            }, 7);
        end));
        local u181, u182 = mainreplication.cutsceneCamRigWithLetterBox(v177, AnalyticalPositioning.Cam, AnalyticalPositioning.FOV, nil, CFrame.new(0, -3, 0), AnalyticalPositioning.LetterBox);
        u178:Add(task.delay(5.33, function() -- Line: 1936
            -- upvalues: u178 (copy), u181 (copy), u182 (copy)
            u178:Destroy();

            if u181 then
                pcall(u182);
            end;
        end));
        local v183 = {
            Vignette = u178:Add(vfxUtil.getMoonEffects()).Vignette,
            Lighting = game:GetService("Lighting")
        };

        if AnalyticalPositioning:FindFirstChild("Lighting") then
            vfxUtil.cutscene_lighting(u178, v183, AnalyticalPositioning.Lighting, {
                Brightness = 3,
                EnvironmentDiffuseScale = 1,
                EnvironmentSpecularScale = 1,
                GlobalShadows = true,
                ShadowSoftness = 0.2,
                ExposureCompensation = 0,
                ClockTime = 14.5,
                GeographicLatitude = 0,
                Ambient = Color3.fromRGB(70, 70, 70),
                ColorShift_Top = Color3.new(0, 0, 0),
                ColorShift_Bottom = Color3.new(0, 0, 0),
                OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            });
        end;

        MoonPropertyAnimator.ConvertSave(AnalyticalPositioning.Moon, v183);
        local v184 = u178:Construct(MoonPropertyAnimator);
        v184:LoadAndConvertSave(AnalyticalPositioning.Moon, v183);
        v184:PlayAll();
        local Analytical = require(script.Compiled.Analytical);
        local KarasuAirTrap = require(script.Parsers.KarasuAirTrap);

        for _, v in Analytical do
            u178:Add(task.delay(v[1] / 60, v[2], KarasuAirTrap, u176, u181));
        end;
    end,

    karasu_world_cutting_slash = function(u185: any, u186: userdata, p187: userdata, p188: any, u189: userdata) -- Line: 1982, Name: karasu_world_cutting_slash
        -- upvalues: LocalPlayer (copy), actionUtil (copy), vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), RunService (copy), UserInputService (copy), styles (copy), TweenService (copy), Lighting (copy), MoonPropertyAnimator (copy)
        if LocalPlayer.Character ~= u185 and actionUtil.checkGK(LocalPlayer.Character) then
            return;
        end;

        local NewGoalMethod = vfxUtil.getResources().karasu.NewGoalMethod;
        local u190 = u185.HumanoidRootPart or u185.PrimaryPart;
        local Torso = u185:FindFirstChild("Torso");

        if not Torso then
            return;
        end;

        local u191 = trove.new();
        u191:AttachToInstance(u185);

        if not (u186 and u186:IsDescendantOf(workspace)) then
            u191:Destroy();

            return;
        end;

        mainreplication.sceneEnabled(true);
        u191:Add(function() -- Line: 2004
            -- upvalues: mainreplication (ref)
            mainreplication.sceneEnabled(false);
        end);
        soundUtil:play(NewGoalMethod.Active, SoundService);
        local u192 = u191:Add(NewGoalMethod.Model:Clone());
        u192.Parent = u185;
        u192:PivotTo(u190.CFrame);
        local v193 = u191:Add(Instance.new("Motor6D"));
        v193.Parent = Torso;
        v193.Part0 = Torso;
        v193.Part1 = u192.PrimaryPart;
        v193.C0 = CFrame.new(
            0.419987828,
            -2.7907598,
            -18.6507721,
            -1,
            -3.82137093e-15,
            0,
            -3.82136161e-15,
            1,
            4.37113883e-8,
            0,
            4.37113883e-8,
            -1
        );
        local u194 = u191:Add(NewGoalMethod.Effects.Dribble:Clone());
        u194.Parent = workspace.Effects;
        local v195 = u191:Add(NewGoalMethod.Effects.camEffectAwk:Clone());
        v195.Parent = workspace.Effects;
        local u196 = u191:Construct(NewGoalMethod.Aura);
        vfxUtil.setupAura(u185, u196, true);
        u196.Parent = workspace.Effects;
        u191:Add(RunService.RenderStepped:Connect(function(p197) -- Line: 2030
            -- upvalues: u194 (copy), u190 (copy)
            u194:PivotTo(u190.CFrame);
        end));
        local v198 = { u185, Vector2.new(0, 0), false };
        table.insert(p188, v198);
        local u199 = u191:Add(script.BillboardGui:Clone());
        local u200 = {};
        local u201 = {};

        for _, v in p188 do
            local v202 = v[1];
            local _ = v[2];
            local v203 = v[3];

            if not (v202 and (not v202 or v202:FindFirstChild("HumanoidRootPart"))) then
                return;
            end;

            local HumanoidRootPart = v202:FindFirstChild("HumanoidRootPart");
            local v204 = u191:Add(Instance.new("Part"));
            v204.Shape = Enum.PartType.Ball;
            v204.Size = Vector3.new(1, 1, 1) * (v202 == u185 and 1 or (v203 and 2 or 1.25));
            v204.Color = v203 and Color3.fromRGB(85, 170, 255) or Color3.fromRGB(255, 0, 0);

            if v202 == u185 then
                v204.Color = Color3.fromRGB(85, 255, 0);
            end;

            v204.Material = Enum.Material.Neon;
            v204.Name = "SelectionOrb";
            v204.Transparency = 0.3;
            v204.CastShadow = false;
            v204.CanCollide = false;
            v204.Massless = true;
            v204.Anchored = true;
            v204.CFrame = v193.Part1.CFrame;
            u200[v204] = v202;
            v204.Parent = u192;
            local v205 = (HumanoidRootPart.Position.Z - p187.Position.Z) / p187.Size.Z + 0.5;
            local math_lerp_ret = math.lerp(-u192.PrimaryPart.Size.X / 2, u192.PrimaryPart.Size.X / 2, (HumanoidRootPart.Position.X - p187.Position.X) / p187.Size.X + 0.5);
            local math_lerp_ret2 = math.lerp(-u192.PrimaryPart.Size.Z / 2, u192.PrimaryPart.Size.Z / 2, v205);

            if p187.Name == "aikusnakeB" then
                math_lerp_ret = math_lerp_ret * -1;
                math_lerp_ret2 = math_lerp_ret2 * -1;
            end;

            local v206 = { v204, CFrame.new(math_lerp_ret, 0, math_lerp_ret2) };
            table.insert(u201, v206);
        end;

        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
        RaycastParams_new_ret.FilterDescendantsInstances = { u192 };
        local u207 = nil;
        u191:Add(UserInputService.InputBegan:Connect(function(p208, p209) -- Line: 2093
            -- upvalues: u207 (ref), u189 (copy)
            if p209 then
                return;
            end;

            if table.find({ Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch }, p208.UserInputType) and u207 then
                u189:FireServer(u207);
            end;
        end));
        u191:Add(RunService.PreRender:Connect(function(p210) -- Line: 2102
            -- upvalues: u201 (copy), u192 (copy), UserInputService (ref), RaycastParams_new_ret (copy), u200 (copy), actionUtil (ref), u185 (copy), u207 (ref), u199 (copy), styles (ref)
            for _, v in u201 do
                v[1].CFrame = u192.PrimaryPart.CFrame * v[2];
            end;

            local v211 = {
                Target = nil
            };
            local MouseLocation = UserInputService:GetMouseLocation();
            local Direction = workspace.CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y, 1).Direction;
            local v212 = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, Direction * 1000, RaycastParams_new_ret);

            if v212 and v212.Instance then
                v211.Target = v212.Instance;
            end;

            if v211.Target and (v211.Target:IsDescendantOf(u192) and (v211.Target.Name == "SelectionOrb" and u200[v211.Target])) then
                local v213 = u200[v211.Target];
                local v214;

                if v213 then
                    v214 = v213:FindFirstChild("Humanoid");
                else
                    v214 = v213;
                end;

                if v214 then
                    if actionUtil.checksameTeam(u185, v213) then
                        u207 = v213;
                    end;

                    if u199:FindFirstChild("TextLabel") then
                        u199.TextLabel.Text = string.format("%s (@%s)", v214.DisplayName, v213.Name);
                        local v215 = actionUtil.checkStyle(v213);

                        if v215 and (styles[v215] and styles[v215].icon) then
                            u199.ImageLabel.Image = styles[v215].icon;
                        end;
                    end;

                    u199.Parent = v211.Target;
                end;
            else
                u199.Parent = nil;
                u207 = nil;
            end;
        end));
        local u216, v217, u218 = mainreplication.cutsceneBlender(u190, NewGoalMethod.Camera, NewGoalMethod.FOV, nil, nil, CFrame.new(0, -3, 0), NewGoalMethod.Cam3);

        for _, v in require(NewGoalMethod.Compiled) do
            u191:Add(task.delay(v[1] / 60, v[2], u196, u216, v195));
        end;

        if u216 then
            u191:Add(task.delay(3.2, function() -- Line: 2159
                -- upvalues: u191 (copy), RunService (ref), LocalPlayer (ref), TweenService (ref), u218 (copy), u186 (copy), soundUtil (ref), NewGoalMethod (copy), SoundService (ref), u216 (copy), u196 (copy), u194 (copy), Lighting (ref)
                local u219 = tick() + 5;
                local u220 = u191:Add(script.timer:Clone());
                local Position = u220.timar.Position;
                u191:Add(RunService.RenderStepped:Connect(function(p221) -- Line: 2167
                    -- upvalues: u219 (copy), u220 (copy)
                    local v222 = -(tick() - u219);
                    local math_clamp_ret = math.clamp(v222, 0, (1 / 0));
                    local math_floor_ret = math.floor(math_clamp_ret / 60);
                    u220.timar.Text = string.format("%01d:%02d", math_floor_ret, math_clamp_ret % 60);
                end));
                u220.timar.Position = UDim2.fromScale(Position.X.Scale, Position.Y.Scale + 0.5);
                u220.timar.TextTransparency = 1;
                u220.timar.TextStrokeTransparency = 1;
                u220.Parent = LocalPlayer.PlayerGui;
                TweenService:Create(u220.timar, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    TextStrokeTransparency = 0,
                    TextTransparency = 0,
                    Position = Position
                }):Play();
                u218:AdjustSpeed(0);

                repeat
                    task.wait();
                until u186 and u186.Value or not u186;

                pcall(function() -- Line: 2189
                    -- upvalues: TweenService (ref), u220 (copy)
                    TweenService:Create(u220.timar, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        TextStrokeTransparency = 1,
                        TextTransparency = 1
                    }):Play();
                end);
                soundUtil:play(NewGoalMethod.Shot, SoundService);
                u218.TimePosition = 5.1;
                u218:AdjustSpeed(1);
                u191:Add(task.delay(0.1800000000000006, function() -- Line: 2198
                    -- upvalues: u216 (ref)
                    if u216 then
                        shared.vfx.emit(u216.CamPart.CamVFX.Center);
                    end;
                end));
                u191:Add(task.delay(0.40000000000000036, function() -- Line: 2204
                    -- upvalues: u216 (ref), u196 (ref), u194 (ref), u191 (ref), Lighting (ref), TweenService (ref)
                    if u216 then
                        shared.vfx.emit(u196.HumanoidRootPart.Attachment);
                        shared.vfx.emit(u194);
                        local v223 = u191:Add(Instance.new("ColorCorrectionEffect"));
                        v223.Parent = Lighting;
                        v223.TintColor = Color3.fromRGB(23, 63, 255);
                        v223.Contrast = 5;
                        TweenService:Create(v223, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {
                            Contrast = 0,
                            TintColor = Color3.new(1, 1, 1)
                        }):Play();
                    end;
                end));
                u191:Add(task.delay(1.3000000000000007, function() -- Line: 2216
                    -- upvalues: u191 (ref)
                    u191:Destroy();
                end));
            end));
        end;

        local v224 = {
            Lighting = game:GetService("Lighting")
        };

        if NewGoalMethod:FindFirstChild("Lighting") then
            vfxUtil.cutscene_lighting(u191, v224, NewGoalMethod.Lighting, {
                Brightness = 3,
                EnvironmentDiffuseScale = 1,
                EnvironmentSpecularScale = 1,
                GlobalShadows = true,
                ShadowSoftness = 0.2,
                ExposureCompensation = 0,
                ClockTime = 14.5,
                GeographicLatitude = 0,
                Ambient = Color3.fromRGB(70, 70, 70),
                ColorShift_Top = Color3.new(0, 0, 0),
                ColorShift_Bottom = Color3.new(0, 0, 0),
                OutdoorAmbient = Color3.fromRGB(70, 70, 70)
            });
        end;

        MoonPropertyAnimator.ConvertSave(NewGoalMethod.Moon, v224);
        local v225 = u191:Construct(MoonPropertyAnimator);
        v225:LoadAndConvertSave(NewGoalMethod.Moon, v224);
        v225:PlayAll();
        u191:Add(v217);
    end,

    karasu_world_cutting_slash_parry = function(p226) -- Line: 2250, Name: karasu_world_cutting_slash_parry
        -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy)
        local NewGoalMethod = vfxUtil.getResources().karasu.NewGoalMethod;
        local v227 = p226.HumanoidRootPart or p226.PrimaryPart;
        local u228 = trove.new();
        u228:AttachToInstance(p226);
        mainreplication.sceneEnabled(true);
        u228:Add(function() -- Line: 2260
            -- upvalues: mainreplication (ref)
            mainreplication.sceneEnabled(false);
        end);
        soundUtil:play(NewGoalMethod.Receieve, SoundService);
        local _, v229, _ = mainreplication.cutsceneBlender(v227, NewGoalMethod.CatchCamera, NewGoalMethod.CatchFOV, nil, nil, CFrame.new(0, -3, 0), NewGoalMethod.Cam3);
        u228:Add(task.delay(1.3, function() -- Line: 2268
            -- upvalues: u228 (copy)
            u228:Destroy();
        end));
        u228:Add(v229);
    end
};
local u231 = {
    isagi = 3,
    yukimiya = 5,
    hiori = 5,
    kiyora = 5,
    donlorenzo = 5,
    masterylorenzo = 5,
    reo = 5,
    sae = 3,
    aiku = 5,
    barou = 4,
    kunigami = 5,
    kurona = 5,
    shidou = 5,
    bachira = 5,
    nagi = 5,
    chigiri = 5,
    nelisagi = 5,
    karasu = 3,
    rin = 4
};

function v230.karasu_grace_hint(p232: any, p233: string, p234: boolean) -- Line: 2297
    -- upvalues: LocalPlayer (copy), u231 (copy), styles (copy), mainreplication (copy)
    if p232 ~= LocalPlayer.Character then
        return;
    end;

    local v235 = u231[p233] or 5;

    if v235 <= #styles[p233].movesets then
        local v236 = styles[p233].movesets[v235];

        if styles[p233] then
            if p234 then
                if typeof(v236) == "table" then
                    v236 = v236[1] or v236;
                end;

                mainreplication.editMoveset({
                    [v235] = { v236, "USABLE" }
                });

                return;
            end;

            local v237;

            if typeof(v236) == "table" then
                v237 = v236[1] or v236;
            else
                v237 = v236;
            end;

            local v238;

            if typeof(v236) == "table" then
                v238 = v236[2] or nil;
            else
                v238 = nil;
            end;

            mainreplication.editMoveset({
                [v235] = v238 and ({ v237, v238 } or v237) or v237
            });
        end;
    end;
end;

function v230.karasu_offball_flow(u239) -- Line: 2324
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Lighting (copy), TweenService (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
    local v240 = vfxUtil.getResources().karasu.Flow["Off-ball"];
    local u241 = u239.HumanoidRootPart or u239.PrimaryPart;
    u241.Anchored = true;
    local u242 = trove.new();
    u242:AttachToInstance(u239);
    local Compiled = require(v240.Compiled);
    local v243 = u242:Add(v240.Effects:Clone());
    v243.Parent = workspace.Effects;
    local v244 = u242:Construct(v240.Aura);
    vfxUtil.setupAura(u239, v244, true);
    v244.Parent = workspace.Effects;
    v243:PivotTo(u241.CFrame);
    mainreplication.sceneEnabled(true);
    u242:Add(function() -- Line: 2347
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    local u245 = soundUtil:play(v240.OffBall, SoundService, {
        Character = u239
    });
    local _, _ = mainreplication.cutsceneBlender(u241, v240.Camera, v240.FOV, nil, nil, CFrame.new(0, -3, 0), v240.Cam);

    for _, v in Compiled do
        u242:Add(task.delay(v[1] / 60, v[2], v243, v244));
    end;

    u242:Add(task.delay(5.98, function() -- Line: 2360
        -- upvalues: Lighting (ref), TweenService (ref), mainreplication (ref)
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = Lighting;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {
            Brightness = -2,
            TintColor = Color3.new(0, 0, 0)
        }):Play();
        task.wait(0.25);
        mainreplication.fov(false, 10);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false), {
            Brightness = 0,
            TintColor = Color3.new(1, 1, 1)
        }):Play();
        mainreplication.ultFlash(nil, 1);
        pcall(game.Destroy, ColorCorrectionEffect);
    end));
    u242:Add(function() -- Line: 2372
        -- upvalues: u241 (copy)
        u241.Anchored = false;
    end);
    u242:Add(task.delay(6.48, function() -- Line: 2377
        -- upvalues: u242 (copy)
        u242:Destroy();
    end));
    u242:Add(task.delay(1.273, function() -- Line: 2381
        -- upvalues: TekrinnDialogue (ref), u239 (copy), u245 (copy)
        TekrinnDialogue.Speak(u239, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Text = u245.Name == "Dub" and "Targeting an opponent\'s weakness is not a strength." or "Individually, you\'re no more than average.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 3);
    end));
    u242:Add(task.delay(u245.name == "Dub" and 4 or 5.458, function() -- Line: 2407
        -- upvalues: TekrinnDialogue (ref), u239 (copy), u245 (copy)
        TekrinnDialogue.Speak(u239, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Text = u245.Name == "Dub" and "Take notes Mr. Average..." or "you\'re holding everyone back!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 3);
    end));
    local v246 = {
        Workspace = v243,
        Vignette = u242:Add(vfxUtil.getMoonEffects()).Vignette,
        Lighting = game:GetService("Lighting")
    };

    if v240:FindFirstChild("Lighting") then
        vfxUtil.cutscene_lighting(u242, v246, v240.Lighting, {
            Brightness = 3,
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            GlobalShadows = true,
            ShadowSoftness = 0.2,
            ExposureCompensation = 0,
            ClockTime = 12,
            GeographicLatitude = 23,
            Ambient = Color3.fromRGB(70, 70, 70),
            ColorShift_Top = Color3.new(0, 0, 0),
            ColorShift_Bottom = Color3.new(0, 0, 0),
            OutdoorAmbient = Color3.fromRGB(47, 47, 47)
        });
    end;

    MoonPropertyAnimator.ConvertSave(v240.Moon, v246);
    local v247 = u242:Construct(MoonPropertyAnimator);
    v247:LoadAndConvertSave(v240.Moon, v246);
    v247:SetRoot(u241);
    v247:PlayAll();
end;

function v230.karasu_flow_run(p248, p249) -- Line: 2465
    -- upvalues: vfxUtil (copy), trove (copy), TweenService (copy), RunService (copy), KatUtil (copy), mainreplication (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy)
    local u250 = p248.HumanoidRootPart or p248.PrimaryPart;
    local v251 = vfxUtil.getResources().karasu.Flow["Off-ball"];
    local TackleCompiled = require(v251.TackleCompiled);
    local u252 = trove.new();
    u252:AttachToInstance(p248);
    local u253 = u252:Add(Instance.new("NumberValue"));
    u253.Value = 20;
    TweenService:Create(u253, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Value = 130
    }):Play();
    local v254 = u252:Add(v251.TackleEffects.Kick:Clone());
    v254.Parent = workspace.Effects;
    local u255 = u252:Add(v251.TackleEffects.Run:Clone());
    u255.Parent = workspace.Effects;
    u252:Add(RunService.PreRender:Connect(function() -- Line: 2485
        -- upvalues: u255 (copy), u250 (copy)
        u255:PivotTo(u250.CFrame);
    end));

    for _, v in TackleCompiled do
        u252:Add(task.delay(v[1] / 60, v[2], v254, u255, u250));
    end;

    KatUtil.destroy_all_velocities(p248);
    local u256, u257 = mainreplication.bodyVelocity(u250, 130, 1.25, nil, nil, nil, TweenInfo.new(3.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0));

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p248) then
        mainreplication.fov(false, 40);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(20, 40);
        local v258 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v258.Parent = Lighting;
        v258.TintColor = Color3.fromRGB(108, 123, 255);
        v258.Brightness = 0.4;
        v258.Contrast = 1;
        v258.Saturation = -0.4;
        TweenService:Create(v258, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v258, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v258.Destroy, v258);
    end;

    u252:Add(RunService.PreRender:Connect(function() -- Line: 2516
        -- upvalues: u257 (copy), u256 (copy), u250 (copy), u253 (copy)
        if u257 then
            u256.Velocity = u250.CFrame.LookVector * u253.Value;
        end;
    end));

    if p249 then
        p249.Changed:Once(function() -- Line: 2523
            -- upvalues: u252 (copy)
            u252:Destroy();
        end);
    end;

    u252:Add(task.delay(0.5, function() -- Line: 2528
        -- upvalues: TweenService (ref), u253 (copy)
        TweenService:Create(u253, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Value = 0
        }):Play();
    end));
    u252:Add(task.delay(1.3, function() -- Line: 2532
        -- upvalues: u252 (copy)
        u252:Destroy();
    end));
end;

function v230.hiori_karasu(u259, u260) -- Line: 2538
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), mainreplication (copy), MoonPropertyAnimator (copy)
    local KarasuChemicals = vfxUtil.getResources().hiori.KarasuChemicals;
    local HumanoidRootPart = u259.HumanoidRootPart;
    HumanoidRootPart.Anchored = true;
    local u261 = trove.new();
    u261:AttachToInstance(u259);
    local Compiled = require(KarasuChemicals.Compiled);
    local v262 = u261:Add(KarasuChemicals.VFX:Clone());
    u261:Add(Instance.new("CFrameValue")).Value = v262.PrimaryPart.CFrame;
    v262.Parent = workspace.Effects;
    local u263 = soundUtil:play(KarasuChemicals.SFX, SoundService, {
        Character = u259
    });
    soundUtil:play(KarasuChemicals.Music, SoundService);
    local v264 = u261:Construct(KarasuChemicals.Hiori);
    vfxUtil.setupAura(u259, v264, true);
    v264.Parent = workspace.Effects;
    local v265 = u261:Construct(KarasuChemicals.Karasu);
    vfxUtil.setupAura(u260, v265, true);
    v265.Parent = workspace.Effects;
    local v266 = u261:Construct(KarasuChemicals.Clash);
    v266.Parent = workspace.Effects;
    v266.CFrame = HumanoidRootPart.CFrame;
    local v267 = u261:Add(Instance.new("Weld"));
    v267.Parent = HumanoidRootPart;
    v267.Part0 = v267.Parent;
    v267.Part1 = v266;
    v267.C0 = CFrame.new(1.85064673, -0.944000006, -11.467, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    u261:Add(task.delay(0.76, function() -- Line: 2579
        -- upvalues: TekrinnDialogue (ref), u260 (copy)
        TekrinnDialogue.Speak(u260, {
            {
                Text = "Heh.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 3);
    end));
    u261:Add(task.delay(u263.Name == "Dub" and 2.3 or 3.25, function() -- Line: 2605
        -- upvalues: TekrinnDialogue (ref), u260 (copy), u263 (copy)
        TekrinnDialogue.Speak(u260, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Text = u263.Name == "Dub" and "Prove it already, that you ain\'t mediocre!" or "You know what\'s up, dumdum.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 3);
    end));
    u261:Add(task.delay(5.297, function() -- Line: 2631
        -- upvalues: u263 (copy), TekrinnDialogue (ref), u259 (copy)
        if u263.Name == "Dub" then
            TekrinnDialogue.Speak(u259, {
                {
                    Text = "Caw caw",
                    Bold = true,
                    TypeSpeed = 0.045,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.137255, 0.756863)), ColorSequenceKeypoint.new(1, Color3.new(0.25098, 0.00392157, 0.619608)) })
                },
                {
                    Text = " what a noisy crow.",
                    Italic = true,
                    TypeSpeed = 0.045,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.333333, 0.666667, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            });

            return;
        end;

        TekrinnDialogue.Speak(u259, {
            {
                Text = "Yer one loud crow, ain\'t ya?",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 170, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 3);
    end));
    v262:PivotTo(HumanoidRootPart.CFrame);
    mainreplication.sceneEnabled(true);
    u261:Add(function() -- Line: 2685
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    local v268 = {};

    for _, child in KarasuChemicals.Hiori.HumanoidRootPart:GetChildren() do
        local v269 = u261:Add(child:Clone());
        v269.Parent = HumanoidRootPart;
        v268[v269.Name] = v269;
    end;

    local v270, v271 = mainreplication.cutsceneHumanoidCameraWithoutRootTerms(HumanoidRootPart, KarasuChemicals.Animations.Cam, KarasuChemicals.FOV, KarasuChemicals.CamTemplate, CFrame.new(0, -2.609, 0));

    if v271 then
        u261:Add(v271);
    end;

    for _, v in Compiled do
        u261:Add(task.delay(v[1] / 60, v[2], v262, v265, v264, v270, v266, v268));
    end;

    u261:Add(function() -- Line: 2716
        -- upvalues: HumanoidRootPart (copy)
        HumanoidRootPart.Anchored = false;
    end);
    u261:Add(task.delay(9.39, function() -- Line: 2721
        -- upvalues: u261 (copy)
        u261:Destroy();
    end));
    local v272 = u261:Add(vfxUtil.getMoonEffects());
    local v273 = {
        Workspace = v262,
        superstardomain2 = v262.superstardomain2,
        Vignette = v272.Vignette,
        Lighting = game:GetService("Lighting")
    };

    if KarasuChemicals:FindFirstChild("Lighting") then
        vfxUtil.cutscene_lighting(u261, v273, KarasuChemicals.Lighting);
    end;

    MoonPropertyAnimator.ConvertSave(KarasuChemicals.Moon, v273);
    local v274 = u261:Construct(MoonPropertyAnimator);
    v274:LoadAndConvertSave(KarasuChemicals.Moon, v273);
    v274:SetRoot(HumanoidRootPart);
    v274:PlayAll();
end;

return v230;