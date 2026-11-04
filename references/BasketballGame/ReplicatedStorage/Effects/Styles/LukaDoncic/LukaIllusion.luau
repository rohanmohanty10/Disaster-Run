 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: Debris (copy), Lighting (copy), SfxManager (copy), TweenService (copy), VfxManager (copy), ReplicatedStorage (copy), Players (copy), LocalPlayer (copy), Essentials (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Humanoid = Character:FindFirstChild("Humanoid");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Illusion" then
        if p2.Task == "Bounce" then
            SfxManager:playSound({
                Sound = "BBZ LukaDoncic Magic Bounce Pass",
                Parent = HumanoidRootPart
            });
            local u5 = script.Charge:Clone();
            u5.Parent = Debris;
            u5.CFrame = BALL.CFrame;
            Essentials:Weld(u5, BALL);
            task.delay(0.5166666666666667 - v3, function() -- Line: 261
                -- upvalues: VfxManager (ref), u5 (copy), Debris (ref), HumanoidRootPart (copy)
                VfxManager.Enable(u5, false);
                VfxManager.DestroyEffect(u5, 2);
                local v6 = script.BouncePass:Clone();
                v6.Parent = Debris;
                v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.985, -0.898, -1.494) * CFrame.Angles(0, 1.5707963267948966, -1.8325957145940461);
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 2);
            end);
            task.delay(0.5666666666666667 - v3, function() -- Line: 272
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v7 = script.Bounce:Clone();
                v7.Parent = Debris;
                v7.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
                VfxManager.Emit(v7);
                VfxManager.DestroyEffect(v7, 2);
            end);
            local v8 = Debris:FindFirstChild(v4);

            if v8 then
                v8:SetAttribute("Active", nil);

                return;
            end;
        elseif p2.Task == "Full" then
            SfxManager:playSound({
                Sound = "BBZ LukaDoncic Magic Full Pass",
                Parent = HumanoidRootPart
            });
            local PassingTo = p2.PassingTo;
            local u9 = script.Charge:Clone();
            u9.Parent = Debris;
            u9.CFrame = BALL.CFrame;
            Essentials:Weld(u9, BALL);
            task.delay(0.6333333333333333 - v3, function() -- Line: 294
                -- upvalues: VfxManager (ref), u9 (copy), Debris (ref), PassingTo (copy), BALL (copy), HumanoidRootPart (copy)
                VfxManager.Enable(u9, false);
                VfxManager.DestroyEffect(u9, 2);
                local v10 = script.FullPass:Clone();
                v10.Parent = Debris;

                if PassingTo and PassingTo:FindFirstChild("HumanoidRootPart") then
                    v10.CFrame = CFrame.new(BALL.Position, PassingTo.HumanoidRootPart.Position) * CFrame.Angles(-1.2217304763960306, 3.141592653589793, 0);
                else
                    v10.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(1.2217304763960306, 3.141592653589793, 0);
                end;

                VfxManager.Emit(v10);
                VfxManager.DestroyEffect(v10, 2);
            end);
            local v11 = Debris:FindFirstChild(v4);

            if v11 then
                v11:SetAttribute("Active", nil);

                return;
            end;
        elseif p2.Task == "Sneak" then
            SfxManager:playSound({
                Sound = "BBZ LukaDoncic Magic Sneak Pass",
                Parent = HumanoidRootPart
            });
            local PassingTo = p2.PassingTo;
            local v12 = script.Bounce:Clone();
            v12.Parent = Debris;
            v12.CFrame = CFrame.new(HumanoidRootPart.Position.X, math.clamp(HumanoidRootPart.Position.Y - 2.95, 1.05, 1.5), HumanoidRootPart.Position.Z);
            VfxManager.Emit(v12);
            VfxManager.DestroyEffect(v12, 2);
            task.delay(0.43333333333333335 - v3, function() -- Line: 326
                -- upvalues: Debris (ref), PassingTo (copy), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v13 = script.FullPass:Clone();
                v13.Parent = Debris;

                if PassingTo and PassingTo:FindFirstChild("HumanoidRootPart") then
                    v13.CFrame = CFrame.new(BALL.Position, PassingTo.HumanoidRootPart.Position) * CFrame.Angles(-1.2217304763960306, 3.141592653589793, 0);
                else
                    v13.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(-1.2217304763960306, 3.141592653589793, 0);
                end;

                VfxManager.Emit(v13);
                VfxManager.DestroyEffect(v13, 2);
            end);
            local v14 = Debris:FindFirstChild(v4);

            if v14 then
                v14:SetAttribute("Active", nil);

                return;
            end;
        elseif p2.Task == "Magic Drive" then
            local Torso = Character:FindFirstChild("Torso");

            if not Torso then
                return;
            end;

            SfxManager:playSound({
                Sound = "BBZ LukaDoncic Magic Drive",
                Parent = HumanoidRootPart
            });
            local u15 = script.Ball:Clone();
            u15.Parent = Debris;
            u15.CFrame = BALL.CFrame;
            Essentials:Weld(u15, BALL);
            local u16 = script.Torso:Clone();
            u16.Parent = Debris;
            u16.CFrame = Torso.CFrame;
            Essentials:Weld(u16, Torso);
            task.delay(0.25 - v3, function() -- Line: 360
                -- upvalues: VfxManager (ref), u15 (copy), u16 (copy), Debris (ref), BALL (copy), Essentials (ref), Character (copy)
                VfxManager.Enable(u15, true);
                VfxManager.Enable(u16, true);
                local v17 = script.Bounce:Clone();
                v17.Parent = Debris;
                v17.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
                VfxManager.Emit(v17);
                VfxManager.DestroyEffect(v17, 2);
                local v18 = tick();

                repeat
                    task.wait(0.1);
                    local v19 = Essentials:CreateClone(Character);
                    VfxManager.DestroyEffect(v19, 1);
                until tick() - v18 > 0.5;
            end);
            task.delay(0.6833333333333333 - v3, function() -- Line: 377
                -- upvalues: VfxManager (ref), u15 (copy), u16 (copy), Debris (ref), BALL (copy)
                VfxManager.Enable(u15, false);
                VfxManager.Enable(u16, false);
                VfxManager.DestroyEffect(u15, 2);
                VfxManager.DestroyEffect(u16, 2);
                local v20 = script.Bounce:Clone();
                v20.Parent = Debris;
                v20.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
                VfxManager.Emit(v20);
                VfxManager.DestroyEffect(v20, 2);
            end);
        end;

        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(3 - v3, function() -- Line: 34
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u21 = ColorCorrection:Clone();
    u21.Name = "CC";
    u21.Parent = Lighting;
    u21.Enabled = true;
    task.delay(3.85 - v3, function() -- Line: 48
        -- upvalues: u21 (copy), Lighting (ref), ColorCorrection (copy)
        u21:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    SfxManager:playSound({
        Sound = "BBZ LukaDoncic Luka Illusion Spawn",
        Parent = HumanoidRootPart
    });
    task.spawn(function() -- Line: 57
        -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u21 (copy)
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        TweenService:Create(u21, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
    end);
    Character.Archivable = true;
    local u22 = Character:Clone();
    Character.Archivable = false;
    u22.Name = Character.Name .. script.Name;
    u22.Parent = Folder;
    local HumanoidRootPart2 = u22.HumanoidRootPart;
    HumanoidRootPart2.CFrame = HumanoidRootPart.CFrame;

    for _, v in ipairs(Humanoid.Animator:GetPlayingAnimationTracks()) do
        if not v.Looped then
            local v23 = u22.Humanoid:LoadAnimation(v.Animation);
            v23:Play(0);
            v23:AdjustSpeed(v.Speed);
            v23.TimePosition = v.TimePosition;
        end;
    end;

    local u24 = u22.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Movement[`RunB{p2.Right and "R" or "L"}`]);
    u24.Priority = Enum.AnimationPriority.Action;
    u24:Play();
    local u25;

    if Character:FindFirstChild("PlrBall") and u22:FindFirstChild("PlrBall") then
        for _, v in ipairs(Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks()) do
            if not v.Looped then
                local v26 = u22.PlrBall.Anims.AnimationController.Animator:LoadAnimation(v.Animation);
                v26:Play(0);
                v26:AdjustSpeed(v.Speed);
                v26.TimePosition = v.TimePosition;
            end;
        end;

        u25 = u22.PlrBall.Anims.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.BallAnimations.Movement[`Run{p2.Right and "R" or "L"}`]);
        u25.Priority = Enum.AnimationPriority.Action;
        u25:Play();
    else
        u25 = nil;
    end;

    for _, descendant in pairs(u22:GetDescendants()) do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Sound") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("BodyVelocity") or (descendant:IsA("LinearVelocity") or descendant:IsA("BodyGyro")))))))) then
            descendant:Destroy();
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        end;
    end;

    local Ring = workspace:FindFirstChild("Ring");
    local u27;

    if Ring then
        u27 = Ring:Clone();
        u27.Parent = Folder;
    else
        u27 = nil;
    end;

    u22.Humanoid.WalkSpeed = p2.WalkSpeed or 23;
    u22.Humanoid:MoveTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -1000).Position);
    local u28 = {};
    local u29 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and v.Character ~= Character)) then
            if LocalPlayer == v then
                u29 = v.Character.HumanoidRootPart.CFrame;
            end;

            v.Character.Archivable = true;
            local v30 = v.Character:Clone();
            v.Character.Archivable = false;
            v30.Parent = Folder;
            local v31 = v;

            for _, descendant in v30:GetDescendants() do
                if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Sound") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail"))))) then
                    descendant:Destroy();
                elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                    descendant.Anchored = true;
                    descendant.CanCollide = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                elseif descendant:IsA("Humanoid") then
                    descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                end;
            end;

            Essentials:HideCharacter(v31.Character, {}, 0.7);
            table.insert(u28, v31.Character);
        end;
    end;

    if LocalPlayer.Character ~= Character and LocalPlayer.Team ~= game.Teams.Visitor then
        workspace:SetAttribute("LukaIllusion", true);
    end;

    Essentials:HideCharacter(Character, {}, 0.7);
    table.insert(u28, Character);
    local u32 = {};
    table.insert(u32, RunService.Heartbeat:Connect(function(p33) -- Line: 172
        -- upvalues: Essentials (ref), u22 (copy), u24 (copy), u25 (ref)
        local v34 = Essentials:Lerp(u22.Humanoid.WalkSpeed, 4.6000000000000005, p33 * 5);
        u22.Humanoid.WalkSpeed = v34;

        if u24 then
            u24:AdjustSpeed(v34 / 24);
        end;

        if u25 then
            u25.TimePosition = u24.TimePosition;
            u25:AdjustSpeed(v34 / 24);
        end;
    end));
    table.insert(u32, RunService.RenderStepped:Connect(function() -- Line: 186
        -- upvalues: u27 (ref), Ring (copy), HumanoidRootPart (copy), HumanoidRootPart2 (copy)
        if not (u27 and Ring) then
            return;
        end;

        local math_rad_ret = math.rad(HumanoidRootPart.Orientation.Y);
        u27.CFrame = CFrame.new(HumanoidRootPart2.Position.X, 1, HumanoidRootPart2.Position.Z) * Ring.CFrame.Rotation * CFrame.fromOrientation(0, math_rad_ret, 0);
    end));

    local function v36() -- Line: 192
        -- upvalues: u32 (ref), u28 (copy), Essentials (ref), LocalPlayer (ref), u29 (ref), Folder (copy), Debris (ref), HumanoidRootPart2 (copy), VfxManager (ref), SfxManager (ref), u21 (copy), Lighting (ref), TweenService (ref), ColorCorrection (copy)
        for _, v in pairs(u32) do
            v:Disconnect();
        end;

        for _, v in pairs(u28) do
            if v and v:IsDescendantOf(workspace) then
                Essentials:UnhideCharacter(v, {});
            end;
        end;

        if LocalPlayer.Team ~= game.Teams.Visitor and (u29 and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))) then
            LocalPlayer.Character.HumanoidRootPart.CFrame = u29;
        end;

        if Folder then
            local v35 = script.Despawn:Clone();
            v35.Parent = Debris;
            v35.CFrame = HumanoidRootPart2.CFrame;
            VfxManager.Emit(v35);
            VfxManager.DestroyEffect(v35, 6);
            SfxManager:playSound({
                Sound = "BBZ LukaDoncic Luka Illusion Despawn",
                Parent = v35
            });
            Folder:Destroy();
        end;

        if u21 then
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 15;
            TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.25);
            u21.Brightness = 0.65;
            u21.TintColor = Color3.fromRGB(255, 180, 55);
            TweenService:Create(u21, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                Brightness = ColorCorrection.Brightness,
                Saturation = ColorCorrection.Saturation,
                TintColor = ColorCorrection.TintColor
            }):Play();
        end;

        workspace:SetAttribute("LukaIllusion", nil);
        u32 = nil;
    end;

    task.spawn(function() -- Line: 234
        -- upvalues: u32 (ref), Essentials (ref), Character (copy), VfxManager (ref)
        while u32 do
            task.wait(0.1);
            local v37 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v37, 1);
            local Highlight = Instance.new("Highlight");
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(255, 240, 31);
            Highlight.FillTransparency = 0.5;
            Highlight.OutlineColor = Color3.fromRGB(255, 240, 31);
            Highlight.OutlineTransparency = 0;
            Highlight.Parent = v37;
            Highlight.Enabled = true;
        end;
    end);
    table.insert(u32, Folder.AttributeChanged:Connect(v36));
    table.insert(u32, Folder.Destroying:Connect(v36));
end;