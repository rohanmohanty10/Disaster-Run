 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Tables.Customization);
local Trove2 = require(ReplicatedStorage.Shared.Utility.Trove);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
task.spawn(function() -- Line: 22
    -- upvalues: ReplicatedStorage (copy)
    local AnimationController = Instance.new("AnimationController");
    AnimationController.Parent = workspace.CurrentCamera;

    for _, descendant in ReplicatedStorage.Assets.VFX.Emotes:GetDescendants() do
        if descendant:IsA("Animation") then
            AnimationController:LoadAnimation(descendant);
        end;
    end;

    AnimationController:Destroy();
end);

local function SetupRankedBadge(p2: userdata, p3: userdata, p4: any) -- Line: 35
    -- upvalues: TweenService (copy), RunService (copy)
    local Humanoid = p2:FindFirstChild("Humanoid");
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");
    local u5 = Humanoid:LoadAnimation(p3.Animation);
    u5.Priority = Enum.AnimationPriority.Action3;
    u5:Play();
    u5:GetMarkerReachedSignal("Loop Back"):Connect(function() -- Line: 43
        -- upvalues: u5 (copy)
        u5.TimePosition = 2.5833333333333335;
    end);
    local u6 = p4:Add(p3.Part:Clone());
    u6.Parent = workspace.Debris;
    local u7 = p4:Add(p3.Badge:Clone());
    u7.Parent = workspace.Debris;
    local u8 = p4:Add(Instance.new("CFrameValue"));
    u8.Value = CFrame.new(6, 0, 0);
    local u9 = 0;
    local u10 = 0;
    TweenService:Create(u8, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Value = CFrame.new(3, 8, 0)
    }):Play();
    p4:Add(task.delay(2, function() -- Line: 61
        -- upvalues: TweenService (ref), u8 (copy)
        TweenService:Create(u8, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = CFrame.new(0, 7, 0)
        }):Play();
    end));
    p4:Add(RunService.RenderStepped:Connect(function(p11) -- Line: 65
        -- upvalues: u9 (ref), u8 (copy), u10 (ref), u6 (copy), HumanoidRootPart (copy), u7 (copy)
        u9 = u9 + 360 * (u8.Value.Position.X / 3) * p11;
        u10 = u10 + 180 * p11;
        u6.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(u9), 0) * u8.Value;
        u7.CFrame = u6.CFrame * CFrame.Angles(0, math.rad(u10), 0);
    end));
    p4:Add(function() -- Line: 73
        -- upvalues: u5 (copy)
        u5:Stop(0);
        u5:Destroy();
    end);
end;

return {
    ["You Ladies Alright?_LimitedShop"] = function(p12: userdata, p13: any) -- Line: 80
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p12.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouLadiesAlright) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["You Ladies Alright?"] = function(u14: userdata) -- Line: 91
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local v15 = ReplicatedStorage.Assets.VFX.Emotes["YouLadiesAlright?"];
        local Character = u14.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v16 = v15.CamRig:Clone();
            v16.Name = "CamRig";
            v16.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            v16.Parent = workspace;
            local v17 = v15.ChatBubble:Clone();
            v17.Name = "YouLadiesAlright?ChatBubble";
            v17.Parent = Character;
            v17.Handle.Part0 = Character:FindFirstChild("Head");
            local v18 = v15.Whistle:Clone();
            v18.Name = "YouLadiesAlright?Whistle";
            v18.Parent = Character;
            v18.Handle.Part0 = Character:FindFirstChild("Right Arm");
            local v19 = v15.WhistleTorso:Clone();
            v19.Parent = Character;
            v19.Handle.Part0 = Character:FindFirstChild("Torso");
            local v20 = v15.PropBall:Clone();
            v20.Name = "YouLadiesAlright?Ball";
            v20.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
            v20.Parent = workspace;
            v20.Handle.Part0 = HumanoidRootPart;
            local v21 = { v16.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouLadiesAlright), u14.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouLadiesAlright), v20.Anims.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouLadiesAlrightBall) };
            workspace:GetServerTimeNow();

            while v21[1].Length < 1 do
                task.wait();
            end;

            for _, v in v21 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes["YouLadiesAlright?"]), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            local v22 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(4, nil, v22);
            task.wait(v21[1].Length);
            task.spawn(require(ReplicatedStorage.Effects.Emotes["YouLadiesAlright?"]), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            v22:Destroy();
            v16:Destroy();
            v20:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(4);
        Service2:ChangeValue(Character, "DribblingTick", tick() + 4);

        for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u23 = v15.CamRig:Clone();
        u23.Name = "CamRig";
        u23.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
        u23.Parent = workspace;
        local v24 = v15.ChatBubble:Clone();
        v24.Name = "YouLadiesAlright?ChatBubble";
        v24.Parent = Character;
        v24.Handle.Part0 = Character:FindFirstChild("Head");
        local v25 = v15.Whistle:Clone();
        v25.Name = "YouLadiesAlright?Whistle";
        v25.Parent = Character;
        v25.Handle.Part0 = Character:FindFirstChild("Right Arm");
        local v26 = v15.WhistleTorso:Clone();
        v26.Parent = Character;
        v26.Handle.Part0 = Character:FindFirstChild("Torso");
        local u27 = v15.PropBall:Clone();
        u27.Name = "YouLadiesAlright?Ball";
        u27.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
        u27.Parent = workspace;
        u27.Handle.Part0 = HumanoidRootPart;
        task.spawn(function() -- Line: 138
            -- upvalues: u23 (copy), HumanoidRootPart (copy)
            for i = 1, 100 do
                u23.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v28 = { u23.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouLadiesAlright), u14.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouLadiesAlright), u27.Anims.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouLadiesAlrightBall) };
        workspace:GetServerTimeNow();

        while v28[1].Length < 1 do
            task.wait();
        end;

        for _, v in v28 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["YouLadiesAlright?"], {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        Service.Client.Cutscene:FireAll(u14, 4);
        task.delay(v28[1].Length, function() -- Line: 170
            -- upvalues: u23 (copy), u27 (copy), ReplicatedStorage (ref), Character (copy), u14 (copy)
            u23:Destroy();
            u27:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["YouLadiesAlright?"], {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            u14:SetAttribute("PlayingEmote", nil);
        end);
    end,

    VAMPIRE_LimitedShop = function(p29: userdata, p30: any) -- Line: 249
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p29.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.DioPlayer) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    VAMPIRE = function(u31: userdata) -- Line: 260
        -- upvalues: RunService (copy), Knit (copy), ReplicatedStorage (copy), Trove2 (copy)
        local HumanoidRootPart = u31.Character.HumanoidRootPart;

        for _, v in u31.Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v32 = ReplicatedStorage.Assets.Misc.CamRig:Clone();
            v32.Name = "CamRig";
            v32.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
            v32.Parent = workspace;
            local v33 = { u31.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.DioPlayer), v32.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.DioCamera) };

            for _, v in v33 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            local _ = v32.PrimaryPart.Position;
            local ServerTimeNow = workspace:GetServerTimeNow();

            while v33[2].Length < 1 do
                task.wait();
            end;

            task.wait(0.1);
            local v34 = workspace:GetServerTimeNow() - ServerTimeNow;

            for _, v in v33 do
                v.TimePosition = v34;
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes.VAMPIRE), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                passedTime = v34,
                previousTime = workspace:GetServerTimeNow(),
                TimeSent = v34,
                Char = u31.Character
            });
            local v35 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(3.33 - v34, nil, v35);
            task.wait(v33[2].Length - v34);
            task.spawn(require(ReplicatedStorage.Effects.Emotes.VAMPIRE), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = v34,
                Char = u31.Character
            });
            v35:Destroy();
            v32:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(3.33);
        Service2:ChangeValue(u31.Character, "DribblingTick", tick() + 3.33);

        for _, v in u31.Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u36 = ReplicatedStorage.Assets.Misc.CamRig:Clone();
        u36.Name = "CamRig";
        u36.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        u36.Parent = workspace;
        task.spawn(function() -- Line: 288
            -- upvalues: u36 (copy), HumanoidRootPart (copy)
            for i = 1, 150 do
                u36.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v37 = { u31.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.DioPlayer), u36.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.DioCamera) };

        for _, v in v37 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        local _ = u36.PrimaryPart.Position;
        local ServerTimeNow = workspace:GetServerTimeNow();

        while v37[2].Length < 1 do
            task.wait();
        end;

        task.wait(0.1);
        local u38 = workspace:GetServerTimeNow() - ServerTimeNow;

        for _, v in v37 do
            v.TimePosition = u38;
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.VAMPIRE, {
            Task = "Cutscene",
            previousTime = workspace:GetServerTimeNow(),
            passedTime = workspace:GetServerTimeNow() - ServerTimeNow + u38,
            Char = u31.Character
        });
        Service.Client.Cutscene:FireAll(u31, 3.33 - u38);
        task.delay(v37[2].Length - u38, function() -- Line: 331
            -- upvalues: u36 (copy), ReplicatedStorage (ref), ServerTimeNow (copy), u38 (copy), u31 (copy)
            u36:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.VAMPIRE, {
                Task = "Cleanup",
                previousTime = workspace:GetServerTimeNow(),
                passedTime = workspace:GetServerTimeNow() - ServerTimeNow + u38,
                Char = u31.Character
            });
            u31:SetAttribute("PlayingEmote", nil);
        end);
    end,

    ["The Dance_LimitedShop"] = function(p39: userdata, p40: any) -- Line: 401
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v41 = { p39.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.TheDancePlayer) };
        local v42 = p40:Add(ReplicatedStorage.Assets.Cosmetics.Tentacles:Clone());
        v42.Parent = p39.Character;

        for i = 1, 4 do
            local v43 = v42:FindFirstChild((`tentacle{i}`));
            v43.Cylinder.CFrame = p39.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0);
            Essentials:Weld(p39.Character.HumanoidRootPart, v43.Cylinder).Parent = v42;
            local AnimationController = v43.AnimationController;
            local v44 = ReplicatedStorage.Assets.EmoteAnimations[`TheDanceTentacle{i}`];
            table.insert(v41, AnimationController:LoadAnimation(v44));
            local _ = i;
        end;

        for _, v in v41 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["The Dance"] = function(u45: userdata) -- Line: 426
        -- upvalues: RunService (copy), Knit (copy), ReplicatedStorage (copy), Essentials (copy), Trove2 (copy)
        local HumanoidRootPart = u45.Character.HumanoidRootPart;

        for _, v in u45.Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v46 = ReplicatedStorage.Assets.Misc.CamRig:Clone();
            v46.Name = "CamRig";
            v46.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
            v46.Parent = workspace;
            local v47 = { u45.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.TheDancePlayer), v46.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.TheDanceCamera) };
            local v48 = ReplicatedStorage.Assets.Cosmetics.Tentacles:Clone();
            v48.Parent = workspace.Debris;

            for i = 1, 4 do
                local v49 = v48:FindFirstChild((`tentacle{i}`));
                v49.Cylinder.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0);
                Essentials:Weld(HumanoidRootPart, v49.Cylinder).Parent = v48;
                local Animator = v49.AnimationController.Animator;
                local v50 = ReplicatedStorage.Assets.EmoteAnimations[`TheDanceTentacle{i}`];
                table.insert(v47, Animator:LoadAnimation(v50));
                local _ = i;
            end;

            for _, v in v47 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            local _ = v46.PrimaryPart.Position;
            local ServerTimeNow = workspace:GetServerTimeNow();

            while v47[2].Length < 1 do
                task.wait();
            end;

            task.wait(0.1);
            local v51 = workspace:GetServerTimeNow() - ServerTimeNow;

            for _, v in v47 do
                v.TimePosition = v51;
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes.TheDance), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                passedTime = v51,
                previousTime = workspace:GetServerTimeNow(),
                TimeSent = v51,
                Char = u45.Character
            });
            local v52 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(5.8 - v51, nil, v52);
            task.wait(v47[2].Length - v51);
            task.spawn(require(ReplicatedStorage.Effects.Emotes.TheDance), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = v51,
                Char = u45.Character
            });
            v52:Destroy();
            v46:Destroy();
            v48:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(5.8);
        Service2:ChangeValue(u45.Character, "DribblingTick", tick() + 5.8);

        for _, v in u45.Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u53 = ReplicatedStorage.Assets.Misc.CamRig:Clone();
        u53.Name = "CamRig";
        u53.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        u53.Parent = workspace;
        task.spawn(function() -- Line: 454
            -- upvalues: u53 (copy), HumanoidRootPart (copy)
            for i = 1, 150 do
                u53.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v54 = { u45.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.TheDancePlayer), u53.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.TheDanceCamera) };
        local u55 = ReplicatedStorage.Assets.Cosmetics.Tentacles:Clone();
        u55.Parent = workspace.Debris;

        for i = 1, 4 do
            local v56 = u55:FindFirstChild((`tentacle{i}`));
            v56.Cylinder.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0);
            Essentials:Weld(HumanoidRootPart, v56.Cylinder).Parent = u55;
            local Animator = v56.AnimationController.Animator;
            local v57 = ReplicatedStorage.Assets.EmoteAnimations[`TheDanceTentacle{i}`];
            table.insert(v54, Animator:LoadAnimation(v57));
            local _ = i;
        end;

        for _, v in v54 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        local _ = u53.PrimaryPart.Position;
        local ServerTimeNow = workspace:GetServerTimeNow();

        while v54[2].Length < 1 do
            task.wait();
        end;

        task.wait(0.1);
        local u58 = workspace:GetServerTimeNow() - ServerTimeNow;

        for _, v in v54 do
            v.TimePosition = u58;
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.TheDance, {
            Task = "Cutscene",
            previousTime = workspace:GetServerTimeNow(),
            passedTime = workspace:GetServerTimeNow() - ServerTimeNow + u58,
            Char = u45.Character
        });
        Service.Client.Cutscene:FireAll(u45, 5.8 - u58);
        task.delay(v54[2].Length - u58, function() -- Line: 511
            -- upvalues: u53 (copy), u55 (copy), ReplicatedStorage (ref), ServerTimeNow (copy), u58 (copy), u45 (copy)
            u53:Destroy();
            u55:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.TheDance, {
                Task = "Cleanup",
                previousTime = workspace:GetServerTimeNow(),
                passedTime = workspace:GetServerTimeNow() - ServerTimeNow + u58,
                Char = u45.Character
            });
            u45:SetAttribute("PlayingEmote", nil);
        end);
    end,

    ["Hey!_LimitedShop"] = function(p59: userdata, p60: any) -- Line: 598
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p59.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.HeyPlayer) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["Hey!"] = function(u61: userdata) -- Line: 609
        -- upvalues: RunService (copy), Knit (copy), ReplicatedStorage (copy), Trove2 (copy)
        local HumanoidRootPart = u61.Character.HumanoidRootPart;

        for _, v in u61.Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v62 = ReplicatedStorage.Assets.Misc.CamRigAlt:Clone();
            v62.Name = "CamRig";
            v62.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
            v62.Parent = workspace;
            local v63 = { u61.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.HeyPlayer), v62.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.HeyCamera) };

            for _, v in v63 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            local _ = v62.PrimaryPart.Position;
            local ServerTimeNow = workspace:GetServerTimeNow();

            while v63[2].Length < 1 do
                task.wait();
            end;

            task.wait(0.1);
            local v64 = workspace:GetServerTimeNow() - ServerTimeNow;

            for _, v in v63 do
                v.TimePosition = v64;
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes["Hey!"]), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                passedTime = v64,
                previousTime = workspace:GetServerTimeNow(),
                TimeSent = v64,
                Char = u61.Character
            });
            local v65 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(2.75 - v64, nil, v65);
            task.wait(v63[2].Length - v64);
            task.spawn(require(ReplicatedStorage.Effects.Emotes["Hey!"]), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = v64,
                Char = u61.Character
            });
            v65:Destroy();
            v62:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(2.75);
        Service2:ChangeValue(u61.Character, "DribblingTick", tick() + 2.75);

        for _, v in u61.Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u66 = ReplicatedStorage.Assets.Misc.CamRigAlt:Clone();
        u66.Name = "CamRig";
        u66.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
        u66.Parent = workspace;
        task.spawn(function() -- Line: 637
            -- upvalues: u66 (copy), HumanoidRootPart (copy)
            for i = 1, 150 do
                u66.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local u67 = ReplicatedStorage.Assets.VFX.Emotes["Rubber man"]:Clone();
        u67.Arm.Color = u61.Character["Right Arm"].Color;
        u67.Parent = u61.Character;
        u67.AnimationController:Destroy();
        local Motor6D = Instance.new("Motor6D");
        Motor6D.Name = "Arm";
        Motor6D.Part0 = u61.Character["Right Arm"];
        Motor6D.Part1 = u67.Arm;
        Motor6D.C0 = CFrame.new(
            1.43051147e-6,
            0,
            -5.96046448e-8,
            -1,
            1.22464685e-16,
            -1.22464685e-16,
            1.22464685e-16,
            1,
            1.22464685e-16,
            1.22464685e-16,
            1.22464685e-16,
            -1
        );
        Motor6D.C1 = CFrame.new(
            -9.53674316e-7,
            0,
            -1.1920929e-7,
            -1,
            2.44929371e-16,
            0,
            2.44929371e-16,
            1,
            2.44929371e-16,
            0,
            2.44929371e-16,
            -1
        );
        Motor6D.Parent = u61.Character["Right Arm"];
        local v68 = { u61.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.HeyPlayer), u66.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.HeyCamera) };

        for _, v in v68 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        local _ = u66.PrimaryPart.Position;
        local ServerTimeNow = workspace:GetServerTimeNow();

        while v68[2].Length < 1 do
            task.wait();
        end;

        task.wait(0.1);
        local u69 = workspace:GetServerTimeNow() - ServerTimeNow;

        for _, v in v68 do
            v.TimePosition = u69;
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Hey!"], {
            Task = "Cutscene",
            previousTime = workspace:GetServerTimeNow(),
            passedTime = workspace:GetServerTimeNow() - ServerTimeNow + u69,
            Char = u61.Character
        });
        Service.Client.Cutscene:FireAll(u61, 2.75 - u69);
        task.delay(v68[2].Length - u69, function() -- Line: 693
            -- upvalues: u66 (copy), u67 (copy), Motor6D (copy), ReplicatedStorage (ref), ServerTimeNow (copy), u69 (copy), u61 (copy)
            u66:Destroy();
            u67:Destroy();
            Motor6D:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Hey!"], {
                Task = "Cleanup",
                previousTime = workspace:GetServerTimeNow(),
                passedTime = workspace:GetServerTimeNow() - ServerTimeNow + u69,
                Char = u61.Character
            });
            u61:SetAttribute("PlayingEmote", nil);
        end);
    end,

    ["YOU CAN\'T RUN_LimitedShop"] = function(p70: userdata, p71: any) -- Line: 766
        -- upvalues: ReplicatedStorage (copy)
        local v72 = p71:Add(ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone());
        v72.HumanoidRootPart.Anchored = true;
        v72.HumanoidRootPart.CFrame = p70.Character.HumanoidRootPart.CFrame;
        v72.Parent = workspace.Debris;

        for _, v in { p70.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouCantRunPlayer1), v72.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouCantRunPlayer2) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["YOU CAN\'T RUN"] = function(u73: userdata) -- Line: 783
        -- upvalues: RunService (copy), Knit (copy), ReplicatedStorage (copy), Trove2 (copy)
        local HumanoidRootPart = u73.Character.HumanoidRootPart;

        for _, v in u73.Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if RunService:IsServer() then
            local Service = Knit.GetService("AbilityService");
            local Service2 = Knit.GetService("StatsService");
            Knit.GetService("BallService"):ActivateBallIFrame(7.5);
            Service2:ChangeValue(u73.Character, "DribblingTick", tick() + 7.5);
            local Players2 = u73.Team:GetPlayers();
            table.remove(Players2, table.find(Players2, u73));
            local u74;

            if #Players2 > 0 then
                u74 = Players2[Random.new():NextInteger(1, #Players2)].Character;

                for _, v in u74.Humanoid.Animator:GetPlayingAnimationTracks() do
                    v:Stop(0);
                end;

                for _, v in u74.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                    v:Stop(0);
                end;
            else
                u74 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
                u74.HumanoidRootPart.Anchored = true;
                u74.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                u74.Parent = workspace.Debris;
                task.delay(7.5, function() -- Line: 821
                    -- upvalues: u74 (ref)
                    u74:Destroy();
                end);
            end;

            for _, v in u73.Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            local u75 = ReplicatedStorage.Assets.Misc.CamRigAlt:Clone();
            u75.Name = "CamRig";
            u75.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
            u75.Parent = workspace;
            task.spawn(function() -- Line: 836
                -- upvalues: u75 (copy), HumanoidRootPart (copy), u74 (ref)
                for i = 1, 150 do
                    u75.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
                    u74.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                    task.wait(0.01);
                    local _ = i;
                end;
            end);
            local u76 = { u73.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouCantRunPlayer1), u74.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouCantRunPlayer2), u75.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouCantRunCamera) };

            for _, v in u76 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            local _ = u75.PrimaryPart.Position;
            local ServerTimeNow = workspace:GetServerTimeNow();

            while u76[3].Length < 1 do
                task.wait();
            end;

            task.wait(0.1);
            local u77 = workspace:GetServerTimeNow() - ServerTimeNow;

            for _, v in u76 do
                v.TimePosition = u77;
            end;

            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.YouCantRun, {
                Task = "Cutscene",
                passedTime = u77,
                previousTime = workspace:GetServerTimeNow(),
                Char = u73.Character,
                Char2 = u74
            });
            Service.Client.Cutscene:FireAll(u73, 7.5 - u77);
            task.delay(u76[3].Length - u77, function() -- Line: 882
                -- upvalues: u75 (copy), ReplicatedStorage (ref), u77 (copy), u73 (copy), u74 (ref), u76 (copy)
                u75:Destroy();
                ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.YouCantRun, {
                    Task = "Cleanup",
                    TimeSent = u77,
                    Char = u73.Character,
                    Char2 = u74
                });
                u73:SetAttribute("PlayingEmote", nil);

                for _, v in u76 do
                    v:Stop();
                end;
            end);

            return;
        end;

        local v78 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
        v78.HumanoidRootPart.Anchored = true;
        v78.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
        v78.Parent = workspace.Debris;
        local v79 = ReplicatedStorage.Assets.Misc.CamRigAlt:Clone();
        v79.Name = "CamRig";
        v79.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
        v79.Parent = workspace;
        local v80 = { u73.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouCantRunPlayer1), v78.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouCantRunPlayer2), v79.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.YouCantRunCamera) };

        for _, v in v80 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        local _ = v79.PrimaryPart.Position;
        local ServerTimeNow = workspace:GetServerTimeNow();

        while v80[3].Length < 1 do
            task.wait();
        end;

        task.wait(0.1);
        local v81 = workspace:GetServerTimeNow() - ServerTimeNow;

        for _, v in v80 do
            v.TimePosition = v81;
        end;

        task.spawn(require(ReplicatedStorage.Effects.Emotes.YouCantRun), Knit.GetController("EffectController"), {
            Task = "Cutscene",
            passedTime = v81,
            previousTime = workspace:GetServerTimeNow(),
            TimeSent = v81,
            Char = u73.Character,
            Char2 = v78
        });
        local v82 = Trove2.new();
        Knit.GetController("CameraController"):PlayCutscene(7.5 - v81, nil, v82);
        task.wait(v80[3].Length - v81);
        task.spawn(require(ReplicatedStorage.Effects.Emotes.YouCantRun), Knit.GetController("EffectController"), {
            Task = "Cleanup",
            TimeSent = v81,
            Char = u73.Character,
            Char2 = v78
        });
        v82:Destroy();
        v79:Destroy();
        v78:Destroy();

        for _, v in v80 do
            v:Stop();
        end;
    end,

    ["WE DID IT!_LimitedShop"] = function(p83: userdata, p84: any) -- Line: 971
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p83.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.WeDidItPlayer1) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["WE DID IT!"] = function(u85: userdata) -- Line: 988
        -- upvalues: RunService (copy), Knit (copy), ReplicatedStorage (copy), Trove2 (copy)
        local HumanoidRootPart = u85.Character.HumanoidRootPart;

        for _, v in u85.Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if RunService:IsServer() then
            local Service = Knit.GetService("AbilityService");
            local Service2 = Knit.GetService("StatsService");
            Knit.GetService("BallService"):ActivateBallIFrame(5);
            Service2:ChangeValue(u85.Character, "DribblingTick", tick() + 5);
            local Players2 = u85.Team:GetPlayers();
            table.remove(Players2, table.find(Players2, u85));
            local u86;

            if #Players2 > 0 then
                u86 = Players2[Random.new():NextInteger(1, #Players2)].Character;

                for _, v in u86.Humanoid.Animator:GetPlayingAnimationTracks() do
                    v:Stop(0);
                end;

                for _, v in u86.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                    v:Stop(0);
                end;
            else
                u86 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
                u86.HumanoidRootPart.Anchored = true;
                u86.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                u86.Parent = workspace.Debris;
                task.delay(5, function() -- Line: 1029
                    -- upvalues: u86 (ref)
                    u86:Destroy();
                end);
            end;

            for _, v in u85.Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            local u87 = game:GetService("ServerStorage").Assets.CamRig:Clone();
            u87.Name = "CamRig";
            u87.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
            u87.Parent = workspace;
            task.spawn(function() -- Line: 1044
                -- upvalues: u87 (copy), HumanoidRootPart (copy), u86 (ref)
                for i = 1, 150 do
                    u87.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
                    u86.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                    task.wait(0.01);
                    local _ = i;
                end;
            end);
            local v88 = { u85.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.WeDidItPlayer1), u86.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.WeDidItPlayer2), u87.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.WeDidItCamera) };

            for _, v in v88 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            local _ = u87.PrimaryPart.Position;
            local ServerTimeNow = workspace:GetServerTimeNow();

            while v88[3].Length < 1 do
                task.wait();
            end;

            task.wait(0.1);
            local u89 = workspace:GetServerTimeNow() - ServerTimeNow;

            for _, v in v88 do
                v.TimePosition = u89;
            end;

            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.WeDidIt, {
                Task = "Cutscene",
                TimeSent = u89,
                Char = u85.Character,
                Char2 = u86
            });
            Service.Client.Cutscene:FireAll(u85, 5 - u89);
            task.delay(v88[3].Length - u89, function() -- Line: 1089
                -- upvalues: u87 (copy), ReplicatedStorage (ref), u89 (copy), u85 (copy), u86 (ref)
                u87:Destroy();
                ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.WeDidIt, {
                    Task = "Cleanup",
                    TimeSent = u89,
                    Char = u85.Character,
                    Char2 = u86
                });
                u85:SetAttribute("PlayingEmote", nil);
            end);

            return;
        end;

        local v90 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
        v90.HumanoidRootPart.Anchored = true;
        v90.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
        v90.Parent = workspace.Debris;
        local v91 = ReplicatedStorage.Assets.Misc.CamRig:Clone();
        v91.Name = "CamRig";
        v91.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        v91.Parent = workspace;
        local v92 = { u85.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.WeDidItPlayer1), v90.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.WeDidItPlayer2), v91.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.WeDidItCamera) };

        for _, v in v92 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        local _ = v91.PrimaryPart.Position;
        local ServerTimeNow = workspace:GetServerTimeNow();

        while v92[3].Length < 1 do
            task.wait();
        end;

        task.wait(0.1);
        local v93 = workspace:GetServerTimeNow() - ServerTimeNow;

        for _, v in v92 do
            v.TimePosition = v93;
        end;

        task.spawn(require(ReplicatedStorage.Effects.Emotes.WeDidIt), Knit.GetController("EffectController"), {
            Task = "Cutscene",
            TimeSent = v93,
            Char = u85.Character,
            Char2 = v90
        });
        local v94 = Trove2.new();
        Knit.GetController("CameraController"):PlayCutscene(5 - v93, nil, v94);
        task.wait(v92[3].Length - v93);
        task.spawn(require(ReplicatedStorage.Effects.Emotes.WeDidIt), Knit.GetController("EffectController"), {
            Task = "Cleanup",
            TimeSent = v93,
            Char = u85.Character,
            Char2 = v90
        });
        v94:Destroy();
        v91:Destroy();
        v90:Destroy();
    end,

    VALENTINE_LimitedShop = function(p95: userdata, p96: any) -- Line: 1167
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p95.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINEPlayer) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    VALENTINE = function(u97: userdata) -- Line: 1178
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local VALENTINE = ReplicatedStorage.Assets.VFX.Emotes.VALENTINE;
        local Character = u97.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v98 = VALENTINE.CamRig:Clone();
            v98.Name = "CamRig";
            v98.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.747, 0);
            v98.Parent = workspace;
            local v99 = VALENTINE.D4C:Clone();
            v99.Name = Character.Name .. "D4C";
            v99.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            v99.Parent = workspace;
            local v100 = { v98.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINECamera), u97.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINEPlayer), v99.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINEStand) };
            workspace:GetServerTimeNow();

            while v100[1].Length < 1 do
                task.wait();
            end;

            for _, v in v100 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes.VALENTINE), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            local v101 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(4.883, nil, v101);
            task.wait(v100[1].Length);
            task.spawn(require(ReplicatedStorage.Effects.Emotes.VALENTINE), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            v101:Destroy();
            v98:Destroy();
            v99:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(4.883);
        Service2:ChangeValue(Character, "DribblingTick", tick() + 4.883);

        for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u102 = VALENTINE.CamRig:Clone();
        u102.Name = "CamRig";
        u102.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.747, 0);
        u102.Parent = workspace;
        local u103 = VALENTINE.D4C:Clone();
        u103.Name = Character.Name .. "D4C";
        u103.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
        u103.Parent = workspace;
        task.spawn(function() -- Line: 1210
            -- upvalues: u102 (copy), HumanoidRootPart (copy), u103 (copy)
            for i = 1, 100 do
                u102.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.747, 0);
                u103.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v104 = { u102.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINECamera), u97.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINEPlayer), u103.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINEStand) };
        workspace:GetServerTimeNow();

        while v104[1].Length < 1 do
            task.wait();
        end;

        for _, v in v104 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.VALENTINE, {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        Service.Client.Cutscene:FireAll(u97, 4.883);
        task.delay(v104[1].Length, function() -- Line: 1243
            -- upvalues: u102 (copy), u103 (copy), ReplicatedStorage (ref), Character (copy), u97 (copy)
            u102:Destroy();
            u103:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.VALENTINE, {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            u97:SetAttribute("PlayingEmote", nil);
        end);
    end,

    ["Run That Back_LimitedShop"] = function(p105: userdata, p106: any) -- Line: 1307
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p105.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunThatBackPreview) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["Run That Back"] = function(u107: userdata) -- Line: 1318
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local v108 = ReplicatedStorage.Assets.VFX.Emotes["Run That Back"];
        local Character = u107.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v109 = v108.CamRig:Clone();
            v109.Name = "CamRig";
            v109.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.747, 0);
            v109.Parent = workspace;
            local v110 = { v109.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunThatBackCamera), u107.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunThatBackPlayer) };
            workspace:GetServerTimeNow();

            while v110[1].Length < 1 do
                task.wait();
            end;

            for _, v in v110 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes["Run That Back"]), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            local v111 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(6.35, nil, v111);
            task.wait(v110[1].Length);
            task.spawn(require(ReplicatedStorage.Effects.Emotes["Run That Back"]), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            v111:Destroy();
            v109:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(6.35);
        Service2:ChangeValue(Character, "DribblingTick", tick() + 6.35);

        for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u112 = v108.CamRig:Clone();
        u112.Name = "CamRig";
        u112.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.747, 0);
        u112.Parent = workspace;
        task.spawn(function() -- Line: 1345
            -- upvalues: u112 (copy), HumanoidRootPart (copy)
            for i = 1, 100 do
                u112.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.747, 0);
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v113 = { u112.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunThatBackCamera), u107.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunThatBackPlayer) };
        workspace:GetServerTimeNow();

        while v113[1].Length < 1 do
            task.wait();
        end;

        for _, v in v113 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Run That Back"], {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        Service.Client.Cutscene:FireAll(u107, 6.35);
        task.delay(v113[1].Length, function() -- Line: 1376
            -- upvalues: u112 (copy), ReplicatedStorage (ref), Character (copy), u107 (copy)
            u112:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Run That Back"], {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            u107:SetAttribute("PlayingEmote", nil);
        end);
    end,

    Champion_LimitedShop = function(p114: userdata, p115: any) -- Line: 1432
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p114.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionPlayer0) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    Champion = function(u116: userdata) -- Line: 1443
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local Champion = ReplicatedStorage.Assets.VFX.Emotes.Champion;
        local Character = u116.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if RunService:IsServer() then
            local Service = Knit.GetService("AbilityService");
            local Service2 = Knit.GetService("StatsService");
            Knit.GetService("BallService"):ActivateBallIFrame(6.35);
            Service2:ChangeValue(Character, "DribblingTick", tick() + 6.35);
            local Players2 = u116.Team:GetPlayers();
            table.remove(Players2, table.find(Players2, u116));
            local u117 = {};

            for i = 1, 2 do
                local v118;

                if #Players2 > 0 then
                    local v119 = Players2[Random.new():NextInteger(1, #Players2)];
                    table.remove(Players2, table.find(Players2, u117[i]));
                    u117[i] = v119.Character;
                    v118 = i;

                    for _, v in u117[i].Humanoid.Animator:GetPlayingAnimationTracks() do
                        v:Stop(0);
                    end;

                    for _, v in u117[v118].PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                        v:Stop(0);
                    end;
                else
                    u117[i] = ReplicatedStorage.Assets.Misc[i == 1 and "TemplateRigTatlis" or "TemplateRigChrollo"]:Clone();
                    u117[i].HumanoidRootPart.Anchored = true;
                    u117[i].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                    u117[i].Parent = workspace.Debris;
                    task.delay(6.35, function() -- Line: 1485
                        -- upvalues: u117 (copy), i (copy)
                        u117[i]:Destroy();
                    end);
                    v118 = i;
                end;
            end;

            for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            local u120 = Champion.CamRig:Clone();
            u120.Name = "CamRig";
            u120.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
            u120.Parent = workspace;
            local u121 = Champion.Trophy:Clone();
            u121.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            u121.Parent = workspace.Debris;
            local u122 = Champion.Mic:Clone();
            u122.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            u122.Parent = workspace.Debris;
            local u123 = Champion.InterviewCamera:Clone();
            u123.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            u123.Parent = workspace.Debris;
            task.spawn(function() -- Line: 1512
                -- upvalues: u120 (copy), HumanoidRootPart (copy), u121 (copy), u122 (copy), u123 (copy), u117 (copy)
                for i = 1, 100 do
                    u120.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                    u121.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
                    u122.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
                    u123.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
                    u117[1].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                    u117[2].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                    task.wait(0.01);
                    local _ = i;
                end;
            end);
            local v124 = {
                u120.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionCamera),
                u121.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionTrophy),
                u122.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionMic),
                u123.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionInterviewCamera),
                u116.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionPlayer0),
                u117[1].Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionPlayer1),
                u117[2].Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionPlayer2)
            };
            workspace:GetServerTimeNow();

            while v124[1].Length < 1 do
                task.wait();
            end;

            for _, v in v124 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.Champion, {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character,
                Other = u117[1]
            });
            Service.Client.Cutscene:FireAll(u116, 6.35);
            task.delay(v124[1].Length, function() -- Line: 1554
                -- upvalues: u120 (copy), u121 (copy), u122 (copy), u123 (copy), ReplicatedStorage (ref), Character (copy), u116 (copy)
                u120:Destroy();
                u121:Destroy();
                u122:Destroy();
                u123:Destroy();
                ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.Champion, {
                    Task = "Cleanup",
                    TimeSent = workspace:GetServerTimeNow(),
                    Character = Character
                });
                u116:SetAttribute("PlayingEmote", nil);
            end);

            return;
        end;

        local v125 = ReplicatedStorage.Assets.Misc.TemplateRigTatlis:Clone();
        v125.HumanoidRootPart.Anchored = true;
        v125.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
        v125.Parent = workspace.Debris;
        local v126 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
        v126.HumanoidRootPart.Anchored = true;
        v126.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
        v126.Parent = workspace.Debris;
        local v127 = Champion.CamRig:Clone();
        v127.Name = "CamRig";
        v127.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
        v127.Parent = workspace;
        local v128 = Champion.Trophy:Clone();
        v128.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
        v128.Parent = workspace.Debris;
        local v129 = Champion.Mic:Clone();
        v129.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
        v129.Parent = workspace.Debris;
        local v130 = Champion.InterviewCamera:Clone();
        v130.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
        v130.Parent = workspace.Debris;
        local v131 = {
            v127.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionCamera),
            v128.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionTrophy),
            v129.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionMic),
            v130.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionInterviewCamera),
            u116.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionPlayer0),
            v125.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionPlayer1),
            v126.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ChampionPlayer2)
        };
        workspace:GetServerTimeNow();

        while v131[1].Length < 1 do
            task.wait();
        end;

        for _, v in v131 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        task.spawn(require(ReplicatedStorage.Effects.Emotes.Champion), Knit.GetController("EffectController"), {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character,
            Other = v125
        });
        local v132 = Trove2.new();
        Knit.GetController("CameraController"):PlayCutscene(6.35, nil, v132);
        task.wait(v131[1].Length);
        task.spawn(require(ReplicatedStorage.Effects.Emotes.Champion), Knit.GetController("EffectController"), {
            Task = "Cleanup",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        v132:Destroy();
        v127:Destroy();
        v128:Destroy();
        v129:Destroy();
        v130:Destroy();
        v125:Destroy();
        v126:Destroy();
    end,

    ["Eye Battle_LimitedShop"] = function(p133: userdata, p134: any) -- Line: 1646
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p133.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattlePlayer0) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["Eye Battle"] = function(u135: userdata) -- Line: 1657
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Essentials (copy), Trove2 (copy)
        local v136 = ReplicatedStorage.Assets.VFX.Emotes["Eye Battle"];
        local Character = u135.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v137 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
            v137.HumanoidRootPart.Anchored = true;
            v137.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
            v137.Parent = workspace.Debris;
            local v138 = v136.CamRig:Clone();
            v138.Name = "CamRig";
            v138.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
            v138.Parent = workspace;
            local v139 = { v138.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattleCamera), u135.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattlePlayer0), v137.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattlePlayer1) };
            workspace:GetServerTimeNow();

            while v139[1].Length < 1 do
                task.wait();
            end;

            for _, v in v139 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes["Eye Battle"]), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            local v140 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(5, nil, v140);
            task.wait(v139[1].Length);
            task.spawn(require(ReplicatedStorage.Effects.Emotes["Eye Battle"]), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            v140:Destroy();
            v138:Destroy();
            v137:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(5);
        Service2:ChangeValue(Character, "DribblingTick", tick() + 5);
        local v141 = nil;
        local u142 = nil;

        for _, v in game.Teams[Essentials:ActualTeam(u135.Team.Name)]:GetPlayers() do
            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and v ~= u135) then
                local Magnitude = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

                if not v141 or Magnitude < v141 then
                    u142 = v.Character;
                    v141 = Magnitude;
                end;
            end;
        end;

        if u142 then
            for _, v in u142.Humanoid.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            for _, v in u142.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;
        end;

        if not u142 then
            u142 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
            u142.HumanoidRootPart.Anchored = true;
            u142.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
            u142.Parent = workspace.Debris;
            task.delay(5, function() -- Line: 1705
                -- upvalues: u142 (ref)
                u142:Destroy();
            end);
        end;

        for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u143 = v136.CamRig:Clone();
        u143.Name = "CamRig";
        u143.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
        u143.Parent = workspace;
        task.spawn(function() -- Line: 1719
            -- upvalues: u143 (copy), HumanoidRootPart (copy), u142 (ref)
            for i = 1, 100 do
                u143.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                u142.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v144 = { u143.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattleCamera), u135.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattlePlayer0), u142.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattlePlayer1) };
        workspace:GetServerTimeNow();

        while v144[1].Length < 1 do
            task.wait();
        end;

        for _, v in v144 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Eye Battle"], {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        Service.Client.Cutscene:FireAll(u135, 5);
        task.delay(v144[1].Length, function() -- Line: 1752
            -- upvalues: u143 (copy), ReplicatedStorage (ref), Character (copy), u135 (copy)
            u143:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Eye Battle"], {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            u135:SetAttribute("PlayingEmote", nil);
        end);
    end,

    Requiem_LimitedShop = function(p145: userdata, p146: any) -- Line: 1815
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p145.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemPlayer) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    Requiem = function(u147: userdata) -- Line: 1826
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local Requiem = ReplicatedStorage.Assets.VFX.Emotes.Requiem;
        local Character = u147.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if RunService:IsServer() then
            local Service = Knit.GetService("AbilityService");
            local Service2 = Knit.GetService("StatsService");
            Knit.GetService("BallService"):ActivateBallIFrame(6.35);
            Service2:ChangeValue(Character, "DribblingTick", tick() + 6.35);

            for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            local u148 = Requiem.CamRig:Clone();
            u148.Name = "CamRig";
            u148.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.823, 0);
            u148.Parent = workspace;
            local u149 = Requiem.Fish1:Clone();
            u149.Name = "RequiemFish1";
            u149.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.138, -2.814, -1.56) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
            u149.Parent = workspace;
            local u150 = Requiem.Fish2:Clone();
            u150.Name = "RequiemFish2";
            u150.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.138, -2.717, -1.56) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
            u150.Parent = workspace;
            local u151 = Requiem.Fish3:Clone();
            u151.Name = "RequiemFish3";
            u151.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.138, -2.814, -1.56) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
            u151.Parent = workspace;
            task.spawn(function() -- Line: 1868
                -- upvalues: u148 (copy), HumanoidRootPart (copy), u149 (copy), u150 (copy), u151 (copy)
                for i = 1, 100 do
                    u148.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.823, 0);
                    u149.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.138, -2.814, -1.56) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
                    u150.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.138, -2.717, -1.56) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
                    u151.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.138, -2.814, -1.56) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
                    task.wait(0.01);
                    local _ = i;
                end;
            end);
            local v152 = {
                u148.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemCamera),
                u149.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemFish1),
                u150.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemFish2),
                u151.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemFish3),
                u147.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemPlayer)
            };
            workspace:GetServerTimeNow();

            while v152[1].Length < 1 do
                task.wait();
            end;

            for _, v in v152 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.Requiem, {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            Service.Client.Cutscene:FireAll(u147, 6.35);
            task.delay(v152[1].Length, function() -- Line: 1905
                -- upvalues: u148 (copy), u149 (copy), u150 (copy), u151 (copy), ReplicatedStorage (ref), Character (copy), u147 (copy)
                u148:Destroy();
                u149:Destroy();
                u150:Destroy();
                u151:Destroy();
                ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.Requiem, {
                    Task = "Cleanup",
                    TimeSent = workspace:GetServerTimeNow(),
                    Character = Character
                });
                u147:SetAttribute("PlayingEmote", nil);
            end);

            return;
        end;

        local v153 = Requiem.CamRig:Clone();
        v153.Name = "CamRig";
        v153.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.823, 0);
        v153.Parent = workspace;
        local v154 = Requiem.Fish1:Clone();
        v154.Name = "RequiemFish1";
        v154.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.138, -2.814, -1.56) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        v154.Parent = workspace;
        local v155 = Requiem.Fish2:Clone();
        v155.Name = "RequiemFish2";
        v155.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.138, -2.717, -1.56) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        v155.Parent = workspace;
        local v156 = Requiem.Fish3:Clone();
        v156.Name = "RequiemFish3";
        v156.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.138, -2.814, -1.56) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        v156.Parent = workspace;
        local v157 = {
            v153.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemCamera),
            v154.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemFish1),
            v155.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemFish2),
            v156.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemFish3),
            u147.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RequiemPlayer)
        };
        workspace:GetServerTimeNow();

        while v157[1].Length < 1 do
            task.wait();
        end;

        for _, v in v157 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        task.spawn(require(ReplicatedStorage.Effects.Emotes.Requiem), Knit.GetController("EffectController"), {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        local v158 = Trove2.new();
        Knit.GetController("CameraController"):PlayCutscene(6.35, nil, v158);
        task.wait(v157[1].Length);
        task.spawn(require(ReplicatedStorage.Effects.Emotes.Requiem), Knit.GetController("EffectController"), {
            Task = "Cleanup",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        v158:Destroy();
        v153:Destroy();
        v154:Destroy();
        v155:Destroy();
        v156:Destroy();
    end,

    ["Kneel For Vampire_LimitedShop"] = function(p159: userdata, p160: any) -- Line: 1985
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p159.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.KneelForVampirePlayer0) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["Kneel For Vampire"] = function(u161: userdata) -- Line: 1996
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Essentials (copy), Trove2 (copy)
        local v162 = ReplicatedStorage.Assets.VFX.Emotes["Kneel For Vampire"];
        local Character = u161.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if RunService:IsServer() then
            local Service = Knit.GetService("AbilityService");
            local Service2 = Knit.GetService("StatsService");
            Knit.GetService("BallService"):ActivateBallIFrame(6.35);
            Service2:ChangeValue(Character, "DribblingTick", tick() + 6.35);
            local Players2 = game.Teams[Essentials:ActualTeam(u161.Team.Name)]:GetPlayers();
            table.remove(Players2, table.find(Players2, u161));
            local u163 = {};

            for i = 1, 2 do
                local v164;

                if #Players2 > 0 then
                    local v165 = Players2[Random.new():NextInteger(1, #Players2)];
                    table.remove(Players2, table.find(Players2, u163[i]));
                    u163[i] = v165.Character;
                    v164 = i;

                    for _, v in u163[i].Humanoid.Animator:GetPlayingAnimationTracks() do
                        v:Stop(0);
                    end;

                    for _, v in u163[v164].PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                        v:Stop(0);
                    end;
                else
                    u163[i] = ReplicatedStorage.Assets.Misc[i == 1 and "TemplateRigTatlis" or "TemplateRigChrollo"]:Clone();
                    u163[i].HumanoidRootPart.Anchored = true;
                    u163[i].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                    u163[i].Parent = workspace.Debris;
                    task.delay(6.35, function() -- Line: 2038
                        -- upvalues: u163 (copy), i (copy)
                        u163[i]:Destroy();
                    end);
                    v164 = i;
                end;
            end;

            for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            local u166 = v162.CamRig:Clone();
            u166.Name = "CamRig";
            u166.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.02, 1.74, 0.188) * CFrame.fromEulerAnglesXYZ(-0.021362830044410593, 0.0012740903539558606, 0.0003141592653589793);
            u166.Parent = workspace;
            task.spawn(function() -- Line: 2053
                -- upvalues: u166 (copy), HumanoidRootPart (copy), u163 (copy)
                for i = 1, 100 do
                    u166.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.02, 1.74, 0.188) * CFrame.fromEulerAnglesXYZ(-0.021362830044410593, 0.0012740903539558606, 0.0003141592653589793);
                    u163[1].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                    u163[2].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                    task.wait(0.01);
                    local _ = i;
                end;
            end);
            local v167 = {
                u166.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.KneelForVampireCamera),
                u161.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.KneelForVampirePlayer0),
                u163[1].Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.KneelForVampirePlayer1),
                u163[2].Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.KneelForVampirePlayer2)
            };
            workspace:GetServerTimeNow();

            while v167[1].Length < 1 do
                task.wait();
            end;

            for _, v in v167 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Kneel For Vampire"], {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            Service.Client.Cutscene:FireAll(u161, 6.35);
            task.delay(v167[1].Length, function() -- Line: 2088
                -- upvalues: u166 (copy), ReplicatedStorage (ref), Character (copy), u161 (copy)
                u166:Destroy();
                ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Kneel For Vampire"], {
                    Task = "Cleanup",
                    TimeSent = workspace:GetServerTimeNow(),
                    Character = Character
                });
                u161:SetAttribute("PlayingEmote", nil);
            end);

            return;
        end;

        local v168 = ReplicatedStorage.Assets.Misc.TemplateRigTatlis:Clone();
        v168.HumanoidRootPart.Anchored = true;
        v168.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
        v168.Parent = workspace.Debris;
        local v169 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
        v169.HumanoidRootPart.Anchored = true;
        v169.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
        v169.Parent = workspace.Debris;
        local v170 = v162.CamRig:Clone();
        v170.Name = "CamRig";
        v170.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.02, 1.74, 0.188) * CFrame.fromEulerAnglesXYZ(-0.021362830044410593, 0.0012740903539558606, 0.0003141592653589793);
        v170.Parent = workspace;
        local v171 = {
            v170.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.KneelForVampireCamera),
            u161.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.KneelForVampirePlayer0),
            v168.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.KneelForVampirePlayer1),
            v169.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.KneelForVampirePlayer2)
        };
        workspace:GetServerTimeNow();

        while v171[1].Length < 1 do
            task.wait();
        end;

        for _, v in v171 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        task.spawn(require(ReplicatedStorage.Effects.Emotes["Kneel For Vampire"]), Knit.GetController("EffectController"), {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character,
            Other = v168
        });
        local v172 = Trove2.new();
        Knit.GetController("CameraController"):PlayCutscene(6.35, nil, v172);
        task.wait(v171[1].Length);
        task.spawn(require(ReplicatedStorage.Effects.Emotes["Kneel For Vampire"]), Knit.GetController("EffectController"), {
            Task = "Cleanup",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        v172:Destroy();
        v170:Destroy();
        v168:Destroy();
        v169:Destroy();
    end,

    SCARYMONSTER_LimitedShop = function(p173: userdata, p174: any) -- Line: 2159
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p173.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.SCARYMONSTERPlayer) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["SCARY MONSTER"] = function(u175: userdata) -- Line: 2170
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local v176 = ReplicatedStorage.Assets.VFX.Emotes["SCARY MONSTER"];
        local Character = u175.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v177 = v176.CamRig:Clone();
            v177.Name = "CamRig";
            v177.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, 0);
            v177.Parent = workspace;
            local v178 = v176.Tail:Clone();
            v178.Parent = Character;
            v178.Handle.Part0 = HumanoidRootPart;
            local v179 = { v177.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.SCARYMONSTERCamera), u175.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.SCARYMONSTERTail), u175.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.SCARYMONSTERPlayer) };
            workspace:GetServerTimeNow();

            while v179[1].Length < 1 do
                task.wait();
            end;

            for _, v in v179 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes["SCARY MONSTER"]), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            local v180 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(6.05, nil, v180);
            task.wait(v179[1].Length);
            task.spawn(require(ReplicatedStorage.Effects.Emotes["SCARY MONSTER"]), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            v180:Destroy();
            v177:Destroy();
            v178:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(6.05);
        Service2:ChangeValue(Character, "DribblingTick", tick() + 6.05);

        for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u181 = v176.CamRig:Clone();
        u181.Name = "CamRig";
        u181.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, 0);
        u181.Parent = workspace;
        local u182 = v176.Tail:Clone();
        u182.Parent = Character;
        u182.Handle.Part0 = HumanoidRootPart;
        task.spawn(function() -- Line: 2201
            -- upvalues: u181 (copy), HumanoidRootPart (copy)
            for i = 1, 100 do
                u181.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, 0);
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v183 = { u181.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.SCARYMONSTERCamera), u175.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.SCARYMONSTERTail), u175.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.SCARYMONSTERPlayer) };
        workspace:GetServerTimeNow();

        while v183[1].Length < 1 do
            task.wait();
        end;

        for _, v in v183 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["SCARY MONSTER"], {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        Service.Client.Cutscene:FireAll(u175, 6.05);
        task.delay(v183[1].Length, function() -- Line: 2233
            -- upvalues: u181 (copy), u182 (copy), ReplicatedStorage (ref), Character (copy), u175 (copy)
            u181:Destroy();
            u182:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["SCARY MONSTER"], {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            u175:SetAttribute("PlayingEmote", nil);
        end);
    end,

    ["Run Away_LimitedShop"] = function(p184: userdata, p185: any) -- Line: 2296
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p184.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunAwayPlayer0) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["Run Away"] = function(u186: userdata) -- Line: 2307
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local v187 = ReplicatedStorage.Assets.VFX.Emotes["Run Away"];
        local Character = u186.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v188 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
            v188.HumanoidRootPart.Anchored = true;
            v188.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
            v188.Parent = workspace.Debris;
            local v189 = v187.CamRig:Clone();
            v189.Name = "CamRig";
            v189.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
            v189.Parent = workspace;
            local v190 = { v189.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunAwayCamera), u186.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunAwayPlayer0), v188.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunAwayPlayer1) };
            workspace:GetServerTimeNow();

            while v190[1].Length < 1 do
                task.wait();
            end;

            for _, v in v190 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes["Run Away"]), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character,
                Other = v188
            });
            local v191 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(7.117, nil, v191);
            task.wait(v190[1].Length);
            task.spawn(require(ReplicatedStorage.Effects.Emotes["Run Away"]), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            v191:Destroy();
            v189:Destroy();
            v188:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(7.117);
        Service2:ChangeValue(Character, "DribblingTick", tick() + 7.117);
        local v192 = nil;
        local u193 = nil;

        for _, v in u186.Team:GetPlayers() do
            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and v ~= u186) then
                local Magnitude = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

                if not v192 or Magnitude < v192 then
                    u193 = v.Character;
                    v192 = Magnitude;
                end;
            end;
        end;

        if u193 then
            for _, v in u193.Humanoid.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            for _, v in u193.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;
        end;

        if not u193 then
            u193 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
            u193.HumanoidRootPart.Anchored = true;
            u193.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
            u193.Parent = workspace.Debris;
            task.delay(7.117, function() -- Line: 2355
                -- upvalues: u193 (ref)
                u193:Destroy();
            end);
        end;

        for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u194 = v187.CamRig:Clone();
        u194.Name = "CamRig";
        u194.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
        u194.Parent = workspace;
        task.spawn(function() -- Line: 2369
            -- upvalues: u194 (copy), HumanoidRootPart (copy), u193 (ref)
            for i = 1, 100 do
                u194.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                u193.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v195 = { u194.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunAwayCamera), u186.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunAwayPlayer0), u193.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.RunAwayPlayer1) };
        workspace:GetServerTimeNow();

        while v195[1].Length < 1 do
            task.wait();
        end;

        for _, v in v195 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Run Away"], {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character,
            Other = u193
        });
        Service.Client.Cutscene:FireAll(u186, 7.117);
        task.delay(v195[1].Length, function() -- Line: 2403
            -- upvalues: u194 (copy), ReplicatedStorage (ref), Character (copy), u186 (copy)
            u194:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Run Away"], {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            u186:SetAttribute("PlayingEmote", nil);
        end);
    end,

    ["Paper Gun_LimitedShop"] = function(p196: userdata, p197: any) -- Line: 2467
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p196.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.PaperGunPlayer) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["Paper Gun"] = function(u198: userdata) -- Line: 2478
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local v199 = ReplicatedStorage.Assets.VFX.Emotes["Paper Gun"];
        local Character = u198.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if RunService:IsServer() then
            local Service = Knit.GetService("AbilityService");
            local Service2 = Knit.GetService("StatsService");
            Knit.GetService("BallService"):ActivateBallIFrame(3.683);
            Service2:ChangeValue(Character, "DribblingTick", tick() + 3.683);

            for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            local u200 = v199.CamRig:Clone();
            u200.Name = "CamRig";
            u200.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
            u200.Parent = workspace;
            local u201 = v199.Paper:Clone();
            u201.Name = "Paper GunPaper";
            u201.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            u201.Parent = workspace;
            local u202 = v199.Gun:Clone();
            u202.Name = "Paper GunGun";
            u202.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            u202.Parent = workspace;
            task.spawn(function() -- Line: 2515
                -- upvalues: u200 (copy), HumanoidRootPart (copy), u201 (copy), u202 (copy)
                for i = 1, 100 do
                    u200.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                    u201.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
                    u202.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
                    task.wait(0.01);
                    local _ = i;
                end;
            end);
            local v203 = {
                u200.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.PaperGunCamera),
                u201.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.PaperGunPaper),
                u202.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.PaperGunGun),
                u198.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.PaperGunPlayer)
            };
            workspace:GetServerTimeNow();

            while v203[1].Length < 1 do
                task.wait();
            end;

            for _, v in v203 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Paper Gun"], {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            Service.Client.Cutscene:FireAll(u198, 3.683);
            task.delay(v203[1].Length, function() -- Line: 2550
                -- upvalues: u200 (copy), u201 (copy), u202 (copy), ReplicatedStorage (ref), Character (copy), u198 (copy)
                u200:Destroy();
                u201:Destroy();
                u202:Destroy();
                ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Paper Gun"], {
                    Task = "Cleanup",
                    TimeSent = workspace:GetServerTimeNow(),
                    Character = Character
                });
                u198:SetAttribute("PlayingEmote", nil);
            end);

            return;
        end;

        local v204 = v199.CamRig:Clone();
        v204.Name = "CamRig";
        v204.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
        v204.Parent = workspace;
        local v205 = v199.Paper:Clone();
        v205.Name = "Paper GunPaper";
        v205.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
        v205.Parent = workspace;
        local v206 = v199.Gun:Clone();
        v206.Name = "Paper GunGun";
        v206.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
        v206.Parent = workspace;
        local v207 = {
            v204.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.PaperGunCamera),
            v205.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.PaperGunPaper),
            v206.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.PaperGunGun),
            u198.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.PaperGunPlayer)
        };
        workspace:GetServerTimeNow();

        while v207[1].Length < 1 do
            task.wait();
        end;

        for _, v in v207 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        task.spawn(require(ReplicatedStorage.Effects.Emotes["Paper Gun"]), Knit.GetController("EffectController"), {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        local v208 = Trove2.new();
        Knit.GetController("CameraController"):PlayCutscene(3.683, nil, v208);
        task.wait(v207[1].Length);
        task.spawn(require(ReplicatedStorage.Effects.Emotes["Paper Gun"]), Knit.GetController("EffectController"), {
            Task = "Cleanup",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        v208:Destroy();
        v204:Destroy();
        v205:Destroy();
        v206:Destroy();
    end,

    ["Ascended Vampire_LimitedShop"] = function(p209: userdata, p210: any) -- Line: 2622
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p209.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.AscendedVampirePlayer) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    ["Ascended Vampire"] = function(u211: userdata) -- Line: 2633
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local v212 = ReplicatedStorage.Assets.VFX.Emotes["Ascended Vampire"];
        local Character = u211.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v213 = v212.CamRig:Clone();
            v213.Name = "CamRig";
            v213.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
            v213.Parent = workspace;
            local v214 = { v213.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.AscendedVampireCamera), u211.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.AscendedVampirePlayer) };
            workspace:GetServerTimeNow();

            while v214[1].Length < 1 do
                task.wait();
            end;

            for _, v in v214 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes["Ascended Vampire"]), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            local v215 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(4.967, nil, v215);
            task.wait(v214[1].Length);
            task.spawn(require(ReplicatedStorage.Effects.Emotes["Ascended Vampire"]), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            v215:Destroy();
            v213:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(4.967);
        Service2:ChangeValue(Character, "DribblingTick", tick() + 4.967);

        for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u216 = v212.CamRig:Clone();
        u216.Name = "CamRig";
        u216.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
        u216.Parent = workspace;
        task.spawn(function() -- Line: 2660
            -- upvalues: u216 (copy), HumanoidRootPart (copy)
            for i = 1, 100 do
                u216.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v217 = { u216.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.AscendedVampireCamera), u211.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.AscendedVampirePlayer) };
        workspace:GetServerTimeNow();

        while v217[1].Length < 1 do
            task.wait();
        end;

        for _, v in v217 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Ascended Vampire"], {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        Service.Client.Cutscene:FireAll(u211, 4.967);
        task.delay(v217[1].Length, function() -- Line: 2691
            -- upvalues: u216 (copy), ReplicatedStorage (ref), Character (copy), u211 (copy)
            u216:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Ascended Vampire"], {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            u211:SetAttribute("PlayingEmote", nil);
        end);
    end,

    Thriller_LimitedShop = function(p218: userdata, p219: any) -- Line: 2747
        -- upvalues: ReplicatedStorage (copy)
        for _, v in { p218.Character.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer) } do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = true;
            v:Play(0);
        end;
    end,

    Thriller = function(u220: userdata) -- Line: 2758
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local Thriller = ReplicatedStorage.Assets.VFX.Emotes.Thriller;
        local Character = u220.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if RunService:IsServer() then
            local Service = Knit.GetService("AbilityService");
            local Service2 = Knit.GetService("StatsService");
            Knit.GetService("BallService"):ActivateBallIFrame(9);
            Service2:ChangeValue(Character, "DribblingTick", tick() + 9);
            local Players2 = u220.Team:GetPlayers();
            table.remove(Players2, table.find(Players2, u220));
            local u221 = {};

            for i = 1, 4 do
                local v222;

                if #Players2 > 0 then
                    local v223 = Players2[Random.new():NextInteger(1, #Players2)];
                    table.remove(Players2, table.find(Players2, u221[i]));
                    u221[i] = v223.Character;
                    v222 = i;

                    for _, v in u221[i].Humanoid.Animator:GetPlayingAnimationTracks() do
                        v:Stop(0);
                    end;

                    for _, v in u221[v222].PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                        v:Stop(0);
                    end;
                else
                    u221[i] = ReplicatedStorage.Assets.Misc[i % 2 == 0 and "TemplateRigTatlis" or "TemplateRigChrollo"]:Clone();
                    u221[i].HumanoidRootPart.Anchored = true;
                    u221[i].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * (i == 1 and CFrame.new(-4.1, 0, 3.6) or i == 2 and CFrame.new(3.7, 0, 3.1) or (i == 3 and CFrame.new(-7.9, 0, 8.1) or CFrame.new(7.6, 0, 7.8)));
                    u221[i].Parent = workspace.Debris;
                    task.delay(9, function() -- Line: 2800
                        -- upvalues: u221 (copy), i (copy)
                        u221[i]:Destroy();
                    end);
                    v222 = i;
                end;
            end;

            for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            local u224 = Thriller.CamRig:Clone();
            u224.Name = "CamRig";
            u224.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2.5, 0);
            u224.Parent = workspace;
            task.spawn(function() -- Line: 2815
                -- upvalues: u224 (copy), HumanoidRootPart (copy), u221 (copy)
                for i = 1, 100 do
                    u224.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
                    u221[1].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-4.1, 0, 3.6);
                    u221[2].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(3.7, 0, 3.1);
                    u221[3].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-7.9, 0, 8.1);
                    u221[4].HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(7.6, 0, 7.8);
                    task.wait(0.01);
                    local _ = i;
                end;
            end);
            local v225 = {
                u224.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerCamera),
                u220.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer),
                u221[1].Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer),
                u221[2].Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer),
                u221[3].Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer),
                u221[4].Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer)
            };
            workspace:GetServerTimeNow();

            while v225[1].Length < 1 do
                task.wait();
            end;

            for _, v in v225 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.Thriller, {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character,
                Other1 = u221[1],
                Other2 = u221[2],
                Other3 = u221[3],
                Other4 = u221[4]
            });
            Service.Client.Cutscene:FireAll(u220, 9);
            task.delay(v225[1].Length, function() -- Line: 2858
                -- upvalues: u224 (copy), ReplicatedStorage (ref), Character (copy), u220 (copy)
                u224:Destroy();
                ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes.Thriller, {
                    Task = "Cleanup",
                    TimeSent = workspace:GetServerTimeNow(),
                    Character = Character
                });
                u220:SetAttribute("PlayingEmote", nil);
            end);

            return;
        end;

        local v226 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
        v226.HumanoidRootPart.Anchored = true;
        v226.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-4.1, 0, 3.6);
        v226.Parent = workspace.Debris;
        local v227 = ReplicatedStorage.Assets.Misc.TemplateRigTatlis:Clone();
        v227.HumanoidRootPart.Anchored = true;
        v227.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(3.7, 0, 3.1);
        v227.Parent = workspace.Debris;
        local v228 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
        v228.HumanoidRootPart.Anchored = true;
        v228.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-7.9, 0, 8.1);
        v228.Parent = workspace.Debris;
        local v229 = ReplicatedStorage.Assets.Misc.TemplateRigTatlis:Clone();
        v229.HumanoidRootPart.Anchored = true;
        v229.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(7.6, 0, 7.8);
        v229.Parent = workspace.Debris;
        local v230 = Thriller.CamRig:Clone();
        v230.Name = "CamRig";
        v230.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
        v230.Parent = workspace;
        local v231 = {
            v230.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerCamera),
            u220.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer),
            v226.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer),
            v227.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer),
            v228.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer),
            v229.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.ThrillerPlayer)
        };
        workspace:GetServerTimeNow();

        while v231[1].Length < 1 do
            task.wait();
        end;

        for _, v in v231 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        task.spawn(require(ReplicatedStorage.Effects.Emotes.Thriller), Knit.GetController("EffectController"), {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character,
            Other = v226,
            Other2 = v227,
            Other3 = v228,
            Other4 = v229
        });
        local v232 = Trove2.new();
        Knit.GetController("CameraController"):PlayCutscene(9, nil, v232);
        task.wait(v231[1].Length);
        task.spawn(require(ReplicatedStorage.Effects.Emotes.Thriller), Knit.GetController("EffectController"), {
            Task = "Cleanup",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        v232:Destroy();
        v230:Destroy();
        v226:Destroy();
        v227:Destroy();
        v228:Destroy();
        v229:Destroy();
    end,

    ["Ice Cream Truck"] = function(u233: userdata, p234: any) -- Line: 2946
        -- upvalues: LocalPlayer (copy), Knit (copy), ReplicatedStorage (copy), Essentials (copy)
        if LocalPlayer == u233 then
            local u235 = Knit.GetController("AnimationController"):PlayChar("Emotes", "IceCreamTruckGiverLoop", Enum.AnimationPriority.Action2, true);
            p234:Add(function() -- Line: 2951
                -- upvalues: u235 (copy)
                u235:Stop(0);
            end);
        else
            local v236 = p234:Add(Instance.new("ProximityPrompt"));
            v236.ActionText = "Get In";
            v236.MaxActivationDistance = 20;
            v236.RequiresLineOfSight = false;
            v236.Parent = u233.Character.HumanoidRootPart;
            v236.Triggered:Once(function() -- Line: 2973
                -- upvalues: Knit (ref), u233 (copy)
                Knit.GetService("CustomizationService"):StartDuoEmote(u233.Character);
            end);
        end;

        local v237 = p234:Add(ReplicatedStorage.Assets.VFX.Emotes.IceCreamTruck:Clone());
        v237:PivotTo(u233.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesYXZ(1.5707963267948966, 3.141592653589793, 0));
        v237.Parent = u233.Character;
        p234:Add(Essentials:Weld(u233.Character.HumanoidRootPart, v237.PrimaryPart));
        v237.AnimationController:LoadAnimation(v237.Loop):Play(0);
    end,

    ["Ice Cream Truck Duo"] = function(u238: userdata, u239: userdata, u240: any) -- Line: 2988
        -- upvalues: RunService (copy), Knit (copy), ReplicatedStorage (copy), Essentials (copy), LocalPlayer (copy)
        local u241;

        if RunService:IsServer() then
            u241 = Knit.GetService("BallService");
        else
            u241 = Knit.GetController("BallController");
        end;

        u240:Add(RunService.Heartbeat:Connect(function() -- Line: 2991
            -- upvalues: u241 (copy), u238 (copy), u239 (copy), u240 (copy)
            local CharacterPossessingBall = u241:GetCharacterPossessingBall();

            if CharacterPossessingBall == u238.Character or CharacterPossessingBall == u239.Character then
                u240:Clean();
            end;
        end));

        if u238.Character:IsDescendantOf(workspace.Lobby.Limiteds) then
            local v242 = u240:Add(ReplicatedStorage.Assets.VFX.Emotes.IceCreamTruck:Clone());
            v242:PivotTo(u238.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesYXZ(1.5707963267948966, 3.141592653589793, 0));
            v242.Parent = u238.Character;
            v242:PivotTo(v242.PrimaryPart:GetPivot());
            u240:Add(Essentials:Weld(u238.Character.HumanoidRootPart, v242.PrimaryPart));
            u239.Character.HumanoidRootPart.CFrame = u238.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);
            local Billboard = u238.Character.Parent.Billboard;
            Billboard.Parent = workspace;
            u238.Character.Parent:ScaleTo(0.33);
            Billboard.Parent = u238.Character.Parent;

            for _, v in { u238.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("IceCreamTruckGiverLoop")), u239.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("IceCreamTruckReceiverLoop")), v242.AnimationController:LoadAnimation(v242.Loop) } do
                v:Play();
            end;

            return;
        end;

        if not RunService:IsServer() then
            if LocalPlayer ~= u238 then
                if LocalPlayer == u239 then
                    local u243 = Knit.GetController("AnimationController"):PlayChar("Emotes", "IceCreamTruckReceiverLoop", Enum.AnimationPriority.Action2, true);
                    u240:Add(function() -- Line: 3074
                        -- upvalues: u243 (copy)
                        u243:Stop(0);
                    end);
                    u239.Character.Humanoid.PlatformStand = true;
                    u240:Add(function() -- Line: 3079
                        -- upvalues: u239 (copy)
                        u239.Character.Humanoid.PlatformStand = false;
                    end);
                end;

                return;
            end;

            local u244 = Knit.GetController("AnimationController"):PlayChar("Emotes", "IceCreamTruckGiverLoop", Enum.AnimationPriority.Action2, true);
            u240:Add(function() -- Line: 3067
                -- upvalues: u244 (copy)
                u244:Stop(0);
            end);

            return;
        end;

        local v245 = u240:Add(ReplicatedStorage.Assets.VFX.Emotes.IceCreamTruck:Clone());
        v245:PivotTo(u238.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesYXZ(1.5707963267948966, 3.141592653589793, 0));
        v245.Parent = u238.Character;
        u240:Add(Essentials:Weld(u238.Character.HumanoidRootPart, v245.PrimaryPart));
        v245.AnimationController:LoadAnimation(v245.Loop):Play(0);

        for _, descendant in u239.Character:GetDescendants() do
            if descendant:IsA("BasePart") and not descendant.Massless then
                descendant.Massless = true;
                u240:Add(function() -- Line: 3044
                    -- upvalues: descendant (copy)
                    descendant.Massless = false;
                end);
            end;
        end;

        u239.Character.Humanoid.PlatformStand = true;
        u240:Add(function() -- Line: 3051
            -- upvalues: u239 (copy)
            u239.Character.Humanoid.PlatformStand = false;
        end);
        u239.Character.HumanoidRootPart.CFrame = u238.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);
        u240:Add(Essentials:Weld(u238.Character.HumanoidRootPart, u239.Character.HumanoidRootPart));
        u240:Add(function() -- Line: 3059
            -- upvalues: u239 (copy), u238 (copy)
            u239.Character.HumanoidRootPart.CFrame = u238.Character.HumanoidRootPart.CFrame;
        end);
    end,

    Rollerskates = function(p246: userdata, p247: any) -- Line: 3086
        -- upvalues: ReplicatedStorage (copy)
        local v248 = p247:Add(ReplicatedStorage.Assets.VFX.Emotes.Rollerskates.L:Clone());
        local v249 = p247:Add(ReplicatedStorage.Assets.VFX.Emotes.Rollerskates.R:Clone());
        local Character = p246.Character;
        v248.Parent = p246.Character;
        v249.Parent = Character;
        local Rollerskates = v248.Rollerskates;
        local Rollerskates2 = v249.Rollerskates;
        local v250 = p246.Character:FindFirstChild("Left Leg");
        local v251 = p246.Character:FindFirstChild("Right Leg");
        Rollerskates.Part0 = v250;
        Rollerskates2.Part0 = v251;
    end,

    ["Sunscreen Slap"] = function(u252: userdata, p253: any) -- Line: 3092
        -- upvalues: LocalPlayer (copy), Knit (copy)
        if u252 == LocalPlayer then
            return;
        end;

        local v254 = p253:Add(Instance.new("ProximityPrompt"));
        v254.ActionText = "Get Slapped";
        v254.RequiresLineOfSight = false;
        v254.Parent = u252.Character.HumanoidRootPart;
        v254.Triggered:Once(function() -- Line: 3102
            -- upvalues: Knit (ref), u252 (copy)
            Knit.GetService("CustomizationService"):StartDuoEmote(u252.Character);
        end);
    end,

    ["Sunscreen Slap Duo"] = function(p255: userdata, p256: userdata, u257: any) -- Line: 3107
        -- upvalues: ReplicatedStorage (copy), RunService (copy), LocalPlayer (copy), Knit (copy)
        if p255.Character:IsDescendantOf(workspace.Lobby.Limiteds) then
            p256.Character.HumanoidRootPart.CFrame = p255.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);
            local u258 = { p255.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("SunscreenSlapGiver")), p256.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("SunscreenSlapReceiver")) };
            u257:Add(task.spawn(function() -- Line: 3116
                -- upvalues: u258 (copy)
                while true do
                    for _, v in u258 do
                        v:Play();
                    end;

                    task.wait(5);
                end;
            end));

            return;
        end;

        if RunService:IsServer() then
            local v259 = u257:Add(ReplicatedStorage.Assets.VFX.Emotes.Sunscreen:Clone());
            v259.Parent = p255.Character;
            v259.Sunscreen.Part0 = p255.Character:FindFirstChild("Right Arm");
            p256.Character.HumanoidRootPart.CFrame = p255.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);

            return;
        end;

        if LocalPlayer ~= p255 then
            if LocalPlayer == p256 then
                local u260 = Knit.GetController("AnimationController"):PlayChar("Emotes", "SunscreenSlapReceiver", Enum.AnimationPriority.Action2, true);
                u257:Add(function() -- Line: 3157
                    -- upvalues: u260 (copy)
                    u260:Stop(0);
                end);
            end;

            return;
        end;

        local u261 = Knit.GetController("AnimationController"):PlayChar("Emotes", "SunscreenSlapGiver", Enum.AnimationPriority.Action2, true);
        u257:Add(function() -- Line: 3140
            -- upvalues: u261 (copy)
            u261:Stop(0);
        end);
        u257:Add(u261.Ended:Once(function() -- Line: 3143
            -- upvalues: u257 (copy)
            u257:Clean();
        end));
        u257:Add(p255.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Once(function() -- Line: 3147
            -- upvalues: u257 (copy)
            u257:Clean();
        end));
        u257:Add(p256.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Once(function() -- Line: 3150
            -- upvalues: u257 (copy)
            u257:Clean();
        end));
    end,

    Grill = function(u262: userdata, u263: any) -- Line: 3164
        -- upvalues: ReplicatedStorage (copy)
        local u264 = u263:Add(ReplicatedStorage.Assets.VFX.Emotes.Grill:Clone());
        u264.Parent = u262.Character;
        u264.Grillbase.Grillbase.Part0 = u262.Character.HumanoidRootPart;
        u264.Spatula.Spatula.Part0 = u262.Character.HumanoidRootPart;
        u263:Add(task.delay(2, function() -- Line: 3172
            -- upvalues: u262 (copy), u264 (copy), u263 (copy)
            local u265 = u262.Character.Humanoid.Animator:LoadAnimation(u264.Loop);
            u265:Play(0);
            u263:Add(function() -- Line: 3176
                -- upvalues: u265 (copy)
                u265:Stop(0);
            end);
        end));
    end,

    Surfboard = function(u266: userdata, u267: any) -- Line: 3182
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local u268 = u267:Add(ReplicatedStorage.Assets.VFX.Emotes.Surfboard:Clone());
        u268.Parent = u266.Character;
        u268.Surfboard.Part0 = u266.Character.HumanoidRootPart;
        local v269 = u267:Add(ReplicatedStorage.Assets.VFX.Emotes.SurfboardVFX:Clone());
        v269.Parent = u266.Character;
        v269:PivotTo(u266.Character.HumanoidRootPart.CFrame);
        u267:Add(Essentials:Weld(u266.Character.HumanoidRootPart, v269));
        u267:Add(task.delay(1.3333333333333333, function() -- Line: 3193
            -- upvalues: u266 (copy), u268 (copy), u267 (copy)
            local u270 = u266.Character.Humanoid.Animator:LoadAnimation(u268.SurfLoop);
            u270:Play(0);
            u267:Add(function() -- Line: 3197
                -- upvalues: u270 (copy)
                u270:Stop(0);
            end);
        end));
    end,

    ["Water Balloon"] = function(u271: userdata, u272: any) -- Line: 3203
        -- upvalues: ReplicatedStorage (copy), RunService (copy), VfxManager (copy)
        local u273 = u272:Add(ReplicatedStorage.Assets.VFX.Emotes.WaterBalloon:Clone());
        u273.Parent = u271.Character;
        local u274 = u272:Add(Instance.new("Motor6D"));
        u274.Parent = u271.Character:FindFirstChild("Right Arm");
        u274.Part0 = u274.Parent;
        u274.Part1 = u273;
        u274.C0 = CFrame.new(-0.009, -1.273, 0.009);
        u272:Add(task.delay(0.75, function() -- Line: 3216
            -- upvalues: ReplicatedStorage (ref), u273 (copy), u271 (copy), RunService (ref), VfxManager (ref), u274 (copy)
            local u275 = ReplicatedStorage.Assets.VFX.Emotes.WaterBalloonPhysics:Clone();
            u275.Parent = workspace.Debris;
            u275.CFrame = u273.CFrame;
            u275.AssemblyLinearVelocity = u271.Character.HumanoidRootPart.CFrame.LookVector * 100 + Vector3.new(0, 15, 0);
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
            RaycastParams_new_ret:AddToFilter({ u271.Character, u275 });
            local u276 = nil;
            u276 = RunService.PostSimulation:Connect(function(p277: number) -- Line: 3227
                -- upvalues: u275 (copy), RaycastParams_new_ret (copy), ReplicatedStorage (ref), VfxManager (ref), u276 (ref)
                local v278 = u275.AssemblyLinearVelocity.Magnitude > 0 and u275.AssemblyLinearVelocity or Vector3.new(-0, -10, -0);

                if workspace:Raycast(u275.Position - v278.Unit * 2, v278 * p277 + v278.Unit * 4, RaycastParams_new_ret) ~= nil then
                    local v279 = ReplicatedStorage.Assets.VFX.Emotes.WaterBalloonHit:Clone();
                    v279.Position = u275.Position - v278.Unit * 1;
                    v279.Parent = workspace.Debris;
                    VfxManager.Emit(v279);
                    VfxManager.DestroyEffect(v279, 5);
                    u276:Disconnect();
                    u275:Destroy();
                end;
            end);
            task.delay(5, function() -- Line: 3244
                -- upvalues: u276 (ref), u275 (copy)
                u276:Disconnect();
                u275:Destroy();
            end);
            u273:Destroy();
            u274:Destroy();
        end));
        u272:Add(task.delay(1.5, function() -- Line: 3253
            -- upvalues: u272 (copy)
            u272:Clean();
        end));
    end,

    ["Beach Ball"] = function(u280: userdata, u281: any) -- Line: 3258
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), u1 (copy), TweenService (copy)
        local u282 = u281:Add(ReplicatedStorage.Assets.VFX.Emotes.BeachBall:Clone());
        u282.Parent = workspace.Debris;
        u282.PrimaryPart.CFrame = u280.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.719, 0);
        local u283 = u281:Add(Essentials:Weld(u280.Character.HumanoidRootPart, u282.PrimaryPart));
        local v284 = u282.AnimationController:LoadAnimation(u282.Animation);
        v284:Play(0);

        if u280.Character:IsDescendantOf(workspace.Lobby.Limiteds) then
            v284.Looped = true;

            return;
        end;

        u281:Add(task.delay(1.1833333333333333, function() -- Line: 3274
            -- upvalues: u1 (ref), u280 (copy), TweenService (ref), ReplicatedStorage (ref), u282 (copy), u283 (copy)
            if u1[u280] and not u1[u280]:GetAttribute("Destroyed") then
                local u285 = u1[u280];
                u285.VectorForce:Destroy();
                u285:SetAttribute("Destroyed", true);
                u1[u280] = nil;
                TweenService:Create(u285, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Size = Vector3.new(0, 0, 0)
                }):Play();
                task.delay(1, function() -- Line: 3286
                    -- upvalues: u285 (copy)
                    u285:Destroy();
                end);
            end;

            local u286 = ReplicatedStorage.Assets.VFX.Emotes.BeachballPhysics:Clone();
            u286.CFrame = u282.BEACHBALL.CFrame;
            u286.AssemblyLinearVelocity = Vector3.new(0, 25, 0);
            u286.AssemblyAngularVelocity = Random.new():NextUnitVector() * 15;
            u286.Parent = workspace.Debris;
            u1[u280] = u286;
            task.delay(20, function() -- Line: 3299
                -- upvalues: u286 (copy), u1 (ref), u280 (ref), TweenService (ref)
                if u286:GetAttribute("Destroyed") then
                    return;
                end;

                u286.VectorForce:Destroy();
                u286:SetAttribute("Destroyed", true);
                u1[u280] = nil;
                TweenService:Create(u286, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Size = Vector3.new(0, 0, 0)
                }):Play();
                task.delay(1, function() -- Line: 3313
                    -- upvalues: u286 (ref)
                    u286:Destroy();
                end);
            end);
            u282:Destroy();
            u283:Destroy();
        end));
        u281:Add(task.delay(v284.Length, function() -- Line: 3322
            -- upvalues: u281 (copy)
            u281:Clean();
        end));
    end,

    ["Slip \'n Slide"] = function(p287: userdata, p288: any) -- Line: 3328
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v289 = p288:Add(ReplicatedStorage.Assets.VFX.Emotes.SlipNSlide:Clone());
        v289.Parent = workspace.Debris;
        v289.CFrame = p287.Character.HumanoidRootPart.CFrame * v289.Offset.Value;
        p288:Add(Essentials:Weld(p287.Character.HumanoidRootPart, v289));
    end,

    Motorcycle = function(p290: userdata, p291: any) -- Line: 3336
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v292 = p291:Add(ReplicatedStorage.Assets.VFX.Emotes.Motorcycle:Clone());
        v292.PrimaryPart.CFrame = p290.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.342320680618286, 0.6559554934501648) * CFrame.Angles(0, 3.141592653589793, 0);
        v292.Parent = p290.Character;
        p291:Add(Essentials:Weld(p290.Character.HumanoidRootPart, v292.PrimaryPart));
        v292.AnimationController:LoadAnimation(v292.Animation):Play();
    end,

    ["Meteor Joyride"] = function(p293: userdata, p294: any) -- Line: 3349
        -- upvalues: ReplicatedStorage (copy)
        local v295 = p294:Add(ReplicatedStorage.Assets.VFX.Emotes.MeteorJoyride:Clone());
        v295.Name = "meteor";
        v295.Parent = p293.Character;
        local v296 = p294:Add(Instance.new("Motor6D"));
        v296.Name = "Handle";
        v296.C0 = CFrame.new(-0.032, -2.323, -0.147);
        v296.Part0 = p293.Character.HumanoidRootPart;
        v296.Part1 = v295.Meteor.Handle;
        v296.Parent = p293.Character.HumanoidRootPart;
    end,

    ["BASKETBALL GOD\'S CAR"] = function(p297: userdata, p298: any) -- Line: 3362
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local HumanoidRootPart = p297.Character:FindFirstChild("HumanoidRootPart");
        local v299 = p298:Add(ReplicatedStorage.Assets.VFX.Emotes["BASKETBALL GOD\'S CAR"]:Clone());
        v299.Parent = p297.Character;
        VfxManager.Enable(v299, true);
        local v300 = p298:Add(Instance.new("Motor6D"));
        v300.Name = "Handle";
        v300.C0 = CFrame.new(-3.8743019104003906e-7, 0.653475284576416, 0.00006103515625) * CFrame.fromEulerAnglesYXZ(-4.440892098500626e-15, 3.1415927410125732, -5.181765082986565e-17);
        v300.Part0 = p297.Character.HumanoidRootPart;
        v300.Part1 = v299["Plane.005"];
        v300.Parent = p297.Character.HumanoidRootPart;
        v299.AnimationController:LoadAnimation(v299.Animation):Play();
        local v301 = p298:Add(ReplicatedStorage.Assets.SFX.Emotes.BasketballGodCar:Clone());
        v301.Parent = HumanoidRootPart;
        v301:Play();
    end,

    Dog = function(p302: userdata, p303: any) -- Line: 3387
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        p302.Character:FindFirstChild("HumanoidRootPart");
        local v304 = p303:Add(ReplicatedStorage.Assets.VFX.Emotes.DogEmoteVFX:Clone());
        v304.Parent = p302.Character;
        VfxManager.Enable(v304, true);
        local v305 = p303:Add(Instance.new("Motor6D"));
        v305.Name = "Handle";
        v305.Part0 = p302.Character.HumanoidRootPart;
        v305.Part1 = v304;
        v305.Parent = p302.Character.HumanoidRootPart;
    end,

    ["Emperor\'s Rage"] = function(p306: userdata, p307: any) -- Line: 3405
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), Essentials (copy), LocalPlayer (copy), TweenService (copy), Knit (copy)
        local Character = p306.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local Head = Character:FindFirstChild("Head");
        local v308 = p307:Add(ReplicatedStorage.Assets.VFX.Emotes["EMPEROR\'S RAGE AURA"]:Clone());
        v308:PivotTo(HumanoidRootPart.CFrame);
        v308.Parent = workspace.Debris;
        v308.Root["EMP EVIL WALK"]:Play();
        VfxManager.Enable(v308, true);
        Essentials:Weld(v308.PrimaryPart, HumanoidRootPart);
        local HeadFX = v308.HeadFX;
        HeadFX.CFrame = Head.CFrame;
        Essentials:Weld(HeadFX, Head);

        if LocalPlayer.Character == Character then
            local ColorCorrection = game:GetService("Lighting"):FindFirstChild("ColorCorrection");
            local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
            local u309 = TweenService:Create(ColorCorrection, TweenInfo.new(0.2), {
                Brightness = -0.1,
                Contrast = 1.2,
                Saturation = -1
            });
            p307:Add(function() -- Line: 3449
                -- upvalues: u309 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
                u309:Cancel();
                ColorCorrection.TintColor = Color3_fromRGB_ret;
                ColorCorrection.Contrast = 0.2;
                ColorCorrection.Saturation = 0.3;
                ColorCorrection.Brightness = -0.015;
            end);
            u309:Play();
            local PlayerGui = p306:FindFirstChild("PlayerGui");
            local v310 = p307:Add(ReplicatedStorage.Assets.VFX.Emotes.Vignette:Clone());
            v310.Parent = PlayerGui;
            v310.Enabled = true;
            local Vignette = v310.Vignette;
            local Vignette1 = v310.Vignette1;
            Vignette.ImageTransparency = 0;
            Vignette.ImageColor3 = Color3.fromRGB(0, 0, 0);
            Vignette1.ImageTransparency = 0;
            Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
            local u311 = p307:Add(Instance.new("ScreenGui"));
            u311.Parent = p306.PlayerGui;
            u311.IgnoreGuiInset = true;
            local u312 = p307:Add(ReplicatedStorage.Assets.UI.ImageFrame:Clone());
            u312.Parent = u311;
            u312.ImageTransparency = 0.85;
            local Controller = Knit.GetController("UIController");
            p307:Add(task.spawn(function() -- Line: 3488
                -- upvalues: u311 (copy), HumanoidRootPart (copy), Controller (copy), u312 (copy)
                while u311.Parent ~= nil and HumanoidRootPart ~= nil do
                    Controller:PlayFlipbook(u312, "EmperorScreenLines", 0.03333333333333333);
                end;
            end));
        end;
    end,

    ["Final Boss"] = function(p313: userdata, p314: any) -- Line: 3496
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u315 = p314:Add(ReplicatedStorage.Assets.VFX.Emotes.Hopscotch:Clone());
        u315.Parent = p313.Character;
        u315.CFrame = p313.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
        local v316 = p314:Add(Instance.new("Sound"));
        v316.SoundId = "rbxassetid://112848553223606";
        v316.RollOffMaxDistance = 50;
        v316.RollOffMinDistance = 10;
        v316.RollOffMode = Enum.RollOffMode.InverseTapered;
        v316.Volume = 0.5;
        v316.Looped = true;
        v316.SoundGroup = game.SoundService.EmoteMusicSounds;
        v316.Parent = p313.Character.HumanoidRootPart;
        v316:Play();
        p314:Add(Essentials:Weld(p313.Character.HumanoidRootPart, u315));
        p314:Add(task.spawn(function() -- Line: 3515
            -- upvalues: u315 (copy), VfxManager (ref)
            while u315.Parent do
                VfxManager.Emit(u315);
                task.wait(0.4816666666666667);
            end;
        end));
    end,

    Skateboard = function(p317: userdata, p318: any) -- Line: 3524
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u319 = p318:Add(ReplicatedStorage.Assets.VFX.Emotes.Skateboard:Clone());
        u319.Parent = p317.Character;
        u319.Handle.Handle.Part0 = p317.Character.HumanoidRootPart;
        local v320 = p318:Add(Instance.new("Animation"));
        v320.AnimationId = "rbxassetid://105095216216740";
        v320.Parent = workspace;
        local u321 = p317.Character.Humanoid.Animator:LoadAnimation(v320);
        u321.Priority = Enum.AnimationPriority.Action2;
        p318:Add(function() -- Line: 3537
            -- upvalues: u321 (copy)
            u321:Stop(0);
            u321:Destroy();
        end);
        local u322 = p318:Add(ReplicatedStorage.Assets.VFX.Emotes["Skateboard fx"]:Clone());
        u322:PivotTo(p317.Character.HumanoidRootPart.CFrame);
        u322.Parent = workspace.Debris;
        Essentials:Weld(u322.Root, p317.Character.HumanoidRootPart);
        VfxManager.DestroyEffect(u322, 2);
        VfxManager.Emit(u322.AppearEffect);
        local EQUIPPED_COSMETIC = p317.Character:FindFirstChild("EQUIPPED_COSMETIC");

        if EQUIPPED_COSMETIC and EQUIPPED_COSMETIC:GetAttribute("IsSkateboard") then
            EQUIPPED_COSMETIC.Handle.Transparency = 1;
            p318:Add(function() -- Line: 3554
                -- upvalues: EQUIPPED_COSMETIC (copy)
                EQUIPPED_COSMETIC.Handle.Transparency = 0;
            end);
        end;

        task.delay(0.783, function() -- Line: 3559
            -- upvalues: u322 (copy), VfxManager (ref), u319 (copy)
            if u322.Parent ~= nil then
                VfxManager.Emit(u322.LandSkateBoard);
            end;

            if u319.Parent ~= nil then
                VfxManager.Enable(u319, true);
            end;
        end);
        p318:Add(task.delay(2, function() -- Line: 3569
            -- upvalues: u321 (copy)
            u321:Play();
        end));
    end,

    ["Perfect Mind"] = function(p323: userdata, p324: any) -- Line: 3574
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u325 = p324:Add(ReplicatedStorage.Assets.VFX.Emotes.PerfectMind:Clone());
        u325.CFrame = p323.Character.HumanoidRootPart.CFrame;
        u325.Parent = workspace.Debris;
        p324:Add(Essentials:Weld(p323.Character.HumanoidRootPart, u325));
        p324:Add(task.delay(0.4666666666666667, function() -- Line: 3581
            -- upvalues: VfxManager (ref), u325 (copy)
            VfxManager.Emit(u325);
        end));
        p324:Add(task.delay(0.8666666666666667, function() -- Line: 3585
            -- upvalues: VfxManager (ref), u325 (copy)
            VfxManager.Emit(u325);
        end));
        p324:Add(task.delay(1.4333333333333333, function() -- Line: 3589
            -- upvalues: VfxManager (ref), u325 (copy)
            VfxManager.Emit(u325);
        end));
    end,

    Carry = function(u326: userdata, p327: any) -- Line: 3594
        -- upvalues: Knit (copy)
        if u326 == game:GetService("Players").LocalPlayer then
            return;
        end;

        local v328 = p327:Add(Instance.new("ProximityPrompt"));
        v328.ActionText = "Be Carried";
        v328.RequiresLineOfSight = false;
        v328.Parent = u326.Character.HumanoidRootPart;
        v328.Triggered:Once(function() -- Line: 3604
            -- upvalues: Knit (ref), u326 (copy)
            Knit.GetService("CustomizationService"):StartDuoEmote(u326.Character);
        end);
    end,

    ["Carry Duo"] = function(u329: userdata, u330: userdata, u331: any) -- Line: 3609
        -- upvalues: RunService (copy), Knit (copy), ReplicatedStorage (copy), Essentials (copy), LocalPlayer (copy)
        local u332;

        if RunService:IsServer() then
            u332 = Knit.GetService("BallService");
        else
            u332 = Knit.GetController("BallController");
        end;

        u331:Add(RunService.Heartbeat:Connect(function() -- Line: 3612
            -- upvalues: u332 (copy), u329 (copy), u330 (copy), u331 (copy)
            local CharacterPossessingBall = u332:GetCharacterPossessingBall();

            if CharacterPossessingBall == u329.Character or CharacterPossessingBall == u330.Character then
                u331:Clean();
            end;
        end));

        if u329.Character:IsDescendantOf(workspace.Lobby.Limiteds) then
            u330.Character.HumanoidRootPart.CFrame = u329.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);

            for _, v in { u329.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("CarryGiver")), u330.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("CarryReceiver")) } do
                v:Play();
            end;

            return;
        end;

        if RunService:IsServer() then
            for _, descendant in u330.Character:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant.Massless then
                    descendant.Massless = true;
                    u331:Add(function() -- Line: 3639
                        -- upvalues: descendant (copy)
                        descendant.Massless = false;
                    end);
                end;
            end;

            u330.Character.Humanoid.PlatformStand = true;
            u331:Add(function() -- Line: 3646
                -- upvalues: u330 (copy)
                u330.Character.Humanoid.PlatformStand = false;
            end);
            u330.Character.HumanoidRootPart.CFrame = u329.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);
            u331:Add(Essentials:Weld(u329.Character.HumanoidRootPart, u330.Character.HumanoidRootPart));

            return;
        end;

        if LocalPlayer ~= u329 then
            if LocalPlayer == u330 then
                local u333 = Knit.GetController("AnimationController"):PlayChar("Emotes", "CarryReceiver", Enum.AnimationPriority.Action2, true);
                u331:Add(function() -- Line: 3673
                    -- upvalues: u333 (copy)
                    u333:Stop(0);
                end);
                u330.Character.Humanoid.PlatformStand = true;
                u331:Add(function() -- Line: 3678
                    -- upvalues: u330 (copy)
                    u330.Character.Humanoid.PlatformStand = false;
                end);
            end;

            return;
        end;

        local u334 = Knit.GetController("AnimationController"):PlayChar("Emotes", "CarryGiver", Enum.AnimationPriority.Action2, true);
        u331:Add(function() -- Line: 3658
            -- upvalues: u334 (copy)
            u334:Stop(0);
        end);
        local CFrame2 = u329.Character.HumanoidRootPart.CFrame;
        u331:Add(u329.Character.HumanoidRootPart:GetPropertyChangedSignal("CFrame"):Once(function() -- Line: 3663
            -- upvalues: u329 (copy), CFrame2 (copy), u331 (copy)
            if (u329.Character.HumanoidRootPart.CFrame.Position - CFrame2.Position).Magnitude > 1 then
                u331:Clean();
            end;
        end));
    end,

    Handshake = function(u335: userdata, p336: any) -- Line: 3685
        -- upvalues: Knit (copy)
        if u335 == game:GetService("Players").LocalPlayer then
            return;
        end;

        local v337 = p336:Add(Instance.new("ProximityPrompt"));
        v337.ActionText = "Do Epic Handshake";
        v337.RequiresLineOfSight = false;
        v337.Parent = u335.Character.HumanoidRootPart;
        v337.Triggered:Once(function() -- Line: 3695
            -- upvalues: Knit (ref), u335 (copy)
            Knit.GetService("CustomizationService"):StartDuoEmote(u335.Character);
        end);
    end,

    ["Handshake Duo"] = function(p338: userdata, p339: userdata, u340: any) -- Line: 3700
        -- upvalues: ReplicatedStorage (copy), RunService (copy), LocalPlayer (copy), Knit (copy)
        if p338.Character:IsDescendantOf(workspace.Lobby.Limiteds) then
            p339.Character.HumanoidRootPart.CFrame = p338.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);
            local u341 = { p338.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("HandshakeGiver")), p339.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("HandshakeReceiver")) };
            u340:Add(task.spawn(function() -- Line: 3709
                -- upvalues: u341 (copy)
                while true do
                    for _, v in u341 do
                        v:Play();
                    end;

                    task.wait(5);
                end;
            end));

            return;
        end;

        if RunService:IsServer() then
            p339.Character.HumanoidRootPart.CFrame = p338.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);

            return;
        end;

        if LocalPlayer ~= p338 then
            if LocalPlayer == p339 then
                local u342 = Knit.GetController("AnimationController"):PlayChar("Emotes", "HandshakeReceiver", Enum.AnimationPriority.Action2, true);
                u340:Add(function() -- Line: 3743
                    -- upvalues: u342 (copy)
                    u342:Stop(0);
                end);
            end;

            return;
        end;

        local u343 = Knit.GetController("AnimationController"):PlayChar("Emotes", "HandshakeGiver", Enum.AnimationPriority.Action2, true);
        u340:Add(function() -- Line: 3729
            -- upvalues: u343 (copy)
            u343:Stop(0);
        end);
        u340:Add(p338.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Once(function() -- Line: 3733
            -- upvalues: u340 (copy)
            u340:Clean();
        end));
        u340:Add(p339.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Once(function() -- Line: 3736
            -- upvalues: u340 (copy)
            u340:Clean();
        end));
    end,

    ["Jackpot!"] = function(p344: userdata, p345: any, p346: any) -- Line: 3755
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy), VfxManager (copy), Essentials (copy)
        local HumanoidRootPart = p344.Character:FindFirstChild("HumanoidRootPart");
        local Jackpot = ReplicatedStorage.Assets.VFX.Emotes.Jackpot;

        if (p346 or 1) ~= 2 then
            local u347 = p345:Add(Jackpot.FX:Clone());
            u347.Parent = workspace.Debris;
            u347:PivotTo(HumanoidRootPart.CFrame);
            SfxManager:playSound({
                Sound = "EmoteJackpotWin",
                Parent = u347.Root
            });
            VfxManager.Emit(u347.AppearEffect);
            local u348 = p345:Add(Jackpot.SLOT:Clone());
            u348.Parent = workspace.Debris;
            u348:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(0, -3.141592653589793, 0));
            p345:Add(Essentials:Weld(HumanoidRootPart, u348["Plane.005"]));
            u348.AnimationController.Animator:LoadAnimation(u348.WinSlot):Play();
            local u349 = p345:Add(Jackpot.MONEY:Clone());
            u349.Parent = workspace.Debris;
            u349:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
            p345:Add(Essentials:Weld(HumanoidRootPart, u349.Cash));
            u349.AnimationController.Animator:LoadAnimation(u349.WinMoney):Play();
            task.delay(1.583, function() -- Line: 3871
                -- upvalues: u347 (copy), HumanoidRootPart (copy), VfxManager (ref), u349 (copy)
                if not u347.Parent then
                    return;
                end;

                u347:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.Emit(u347.WCashEmit);
                VfxManager.Emit(u347.EnablingDollars);
                u349.Cash.Transparency = 0;
            end);
            task.delay(4.433, function() -- Line: 3879
                -- upvalues: u347 (copy), HumanoidRootPart (copy), VfxManager (ref), u348 (copy), u349 (copy)
                if not u347.Parent then
                    return;
                end;

                u347:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.Emit(u347.DisappearEffect);
                u348:Destroy();
                task.wait(0.5);

                if u349.Parent then
                    u349:Destroy();
                end;
            end);

            return;
        end;

        local u350 = p345:Add(Jackpot.LosingFX:Clone());
        u350.Parent = workspace.Debris;
        u350:PivotTo(HumanoidRootPart.CFrame);
        SfxManager:playSound({
            Sound = "EmoteJackpotFailed",
            Parent = u350.Root
        });
        VfxManager.Emit(u350.AppearEffect);
        local u351 = p345:Add(Jackpot.SLOT:Clone());
        u351.Parent = workspace.Debris;
        u351:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(0, -3.141592653589793, 0));
        p345:Add(Essentials:Weld(HumanoidRootPart, u351["Plane.005"]));
        u351.AnimationController.Animator:LoadAnimation(u351.LoseSlot):Play();
        local u352 = p345:Add(Jackpot.Bomb:Clone());
        u352.Parent = workspace.Debris;
        u352:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2, 0));
        p345:Add(Essentials:Weld(HumanoidRootPart, u352.RootPart));
        u352.AnimationController.Animator:LoadAnimation(u352.LoseBomb):Play();
        local v353 = u350["Left Arm"];
        local v354 = u350["Right Arm"];
        local u355 = p344.Character:FindFirstChild("Left Arm");
        local u356 = p344.Character:FindFirstChild("Right Arm");

        if u355 then
            for _, child in v353:GetChildren() do
                child.Parent = u355;
                p345:Add(child);
            end;
        end;

        if u356 then
            for _, child in v354:GetChildren() do
                child.Parent = u356;
                p345:Add(child);
            end;
        end;

        v353:Destroy();
        v354:Destroy();
        task.delay(1.71, function() -- Line: 3817
            -- upvalues: u350 (copy), HumanoidRootPart (copy), VfxManager (ref)
            if not u350.Parent then
                return;
            end;

            u350:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.Emit(u350.LoserEmit);
        end);
        task.delay(2.05, function() -- Line: 3823
            -- upvalues: u350 (copy), HumanoidRootPart (copy), u352 (copy), VfxManager (ref)
            if not u350.Parent then
                return;
            end;

            u350:PivotTo(HumanoidRootPart.CFrame);
            u352.Bomb.Transparency = 0;
            VfxManager.Emit(u350.BombAppearEffect);
            VfxManager.Emit(u350.QuestionMark);
        end);
        task.delay(3.217, function() -- Line: 3832
            -- upvalues: u350 (copy), HumanoidRootPart (copy), u352 (copy), VfxManager (ref), u355 (copy), u356 (copy)
            if not u350.Parent then
                return;
            end;

            u350:PivotTo(HumanoidRootPart.CFrame);
            u352.Bomb.Transparency = 1;
            VfxManager.Emit(u350.Explosion);
            VfxManager.Emit(u355);
            VfxManager.Emit(u356);
        end);
        task.delay(4.967, function() -- Line: 3842
            -- upvalues: u350 (copy), HumanoidRootPart (copy), VfxManager (ref), u351 (copy), u352 (copy)
            if not u350.Parent then
                return;
            end;

            u350:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.Emit(u350.DisappearEffect);
            u351:Destroy();
            u352:Destroy();
        end);
    end,

    ["Chalk Toss"] = function(p357: userdata, p358: any) -- Line: 3893
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local HumanoidRootPart = p357.Character:FindFirstChild("HumanoidRootPart");
        local v359 = p357.Character:FindFirstChild("Left Arm");
        local v360 = ReplicatedStorage.Assets.VFX.Emotes["Chalk Toss"];
        local v361 = p358:Add(v360.Chalk:Clone());
        v361.CFrame = v359.CFrame * CFrame.new(0.0265350341796875, -1.0574283599853516, -0.3278617858886719) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
        v361.Parent = workspace.Debris;
        Essentials:Weld(v361, v359);
        task.wait(0.233);

        if v361.Parent == nil then
            return;
        end;

        VfxManager.Emit(v361);
        task.wait(1.767);

        if v361.Parent == nil then
            return;
        end;

        v361.Transparency = 1;
        task.wait(1.15);

        if v361.Parent == nil then
            return;
        end;

        v361:Destroy();
        local v362 = p358:Add(v360.PowderThrow:Clone());
        v362.CFrame = HumanoidRootPart.CFrame;
        v362.Parent = workspace.Debris;
        VfxManager.Emit(v362);
        task.wait(1.85);

        if v362.Parent == nil then
            return;
        end;

        v362:Destroy();
        local v363 = p358:Add(v360.Clap:Clone());
        v363.CFrame = HumanoidRootPart.CFrame;
        v363.Parent = workspace.Debris;
        VfxManager.Emit(v363);
        task.wait(0.367);

        if v363.Parent == nil then
            return;
        end;

        VfxManager.Emit(v363);
        task.wait(0.316);

        if v363.Parent == nil then
            return;
        end;

        VfxManager.Emit(v363);
        VfxManager.DestroyEffect(v363, 2);
    end,

    Pose = function(p364: userdata, p365: any) -- Line: 3947
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), Essentials (copy)
        local HumanoidRootPart = p364.Character:FindFirstChild("HumanoidRootPart");
        p364.Character:FindFirstChild("Left Arm");
        local v366 = p365:Add(ReplicatedStorage.Assets.VFX.Emotes.PoseLoopVFX:Clone());
        v366.CFrame = HumanoidRootPart.CFrame;
        v366.Parent = workspace.Debris;
        VfxManager.Enable(v366, true);
        Essentials:Weld(v366, HumanoidRootPart);
    end,

    ["Fancy Walk"] = function(p367: userdata, p368: any) -- Line: 3961
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), Essentials (copy)
        local HumanoidRootPart = p367.Character:FindFirstChild("HumanoidRootPart");
        p367.Character:FindFirstChild("Left Arm");
        local v369 = p368:Add(ReplicatedStorage.Assets.VFX.Emotes.WalkRootFX:Clone());
        v369.CFrame = HumanoidRootPart.CFrame;
        v369.Parent = workspace.Debris;
        VfxManager.Enable(v369, true);
        Essentials:Weld(v369, HumanoidRootPart);
    end,

    ["Hero Landing"] = function(p370: userdata, p371: any, p372: any) -- Line: 3975
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy), VfxManager (copy)
        if (p372 or 1) == 2 then
            local u373 = p371:Add(ReplicatedStorage.Assets.VFX.Emotes.FailedHero:Clone());
            u373.Parent = workspace.Debris;
            u373:PivotTo(p370.Character.HumanoidRootPart.CFrame);
            SfxManager:playSound({
                Sound = "HeroFail",
                Parent = u373.Root
            });
            task.delay(1, function() -- Line: 3982
                -- upvalues: u373 (copy), VfxManager (ref)
                if u373.Parent then
                    VfxManager.Emit(u373);
                end;
            end);

            return;
        end;

        local u374 = p371:Add(ReplicatedStorage.Assets.VFX.Emotes.CorrectHero:Clone());
        u374.Parent = workspace.Debris;
        u374:PivotTo(p370.Character.HumanoidRootPart.CFrame);
        SfxManager:playSound({
            Sound = "HeroLand",
            Parent = u374.Root
        });
        task.delay(1, function() -- Line: 3992
            -- upvalues: u374 (copy), VfxManager (ref)
            if u374.Parent then
                VfxManager.Emit(u374);
            end;
        end);
    end,

    Shiawase = function(p375: userdata, p376: any) -- Line: 4000
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v377 = p376:Add(ReplicatedStorage.Assets.VFX.Emotes.Shiawase:Clone());
        v377.CFrame = p375.Character.HumanoidRootPart.CFrame;
        Essentials:Weld(v377, p375.Character.HumanoidRootPart);
        v377.Parent = workspace.Debris;
        v377.Sound:Play();
    end,

    ["The Power"] = function(p378: userdata, p379: any) -- Line: 4008
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), RunService (copy)
        for _, child in ReplicatedStorage.Assets.VFX.Emotes.ThePower:GetChildren() do
            local u380 = p378.Character:FindFirstChild(child.Name);
            local v381 = p379:Add(child:Clone());
            v381.Parent = workspace.Debris;
            v381.CFrame = u380.CFrame;
            p379:Add(Essentials:Weld(u380, v381));

            if child.Name == "HumanoidRootPart" then
                local FX = v381.FX;
                p379:Add(RunService.PostSimulation:Connect(function(p382: number) -- Line: 4023
                    -- upvalues: FX (copy), u380 (copy)
                    FX.Position = u380.Position;
                    local v383 = FX;
                    v383.CFrame = v383.CFrame * CFrame.Angles(0, 4.83321946706122 * p382 * 0.5, 0);
                end));
            end;
        end;

        local v384 = p379:Add(Instance.new("Sound"));
        v384.SoundId = "rbxassetid://133357008016968";
        v384.RollOffMaxDistance = 50;
        v384.RollOffMinDistance = 10;
        v384.RollOffMode = Enum.RollOffMode.InverseTapered;
        v384.Volume = 0.5;
        v384.Looped = true;
        v384.SoundGroup = game.SoundService.EmoteMusicSounds;
        v384.Parent = p378.Character.HumanoidRootPart;
        v384:Play();
    end,

    ["Crab Rave"] = function(p385: userdata, p386: any) -- Line: 4043
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        for _, child in ReplicatedStorage.Assets.VFX.Emotes.CrabRave:GetChildren() do
            local v387 = p385.Character:FindFirstChild(child.Name);
            local v388 = p386:Add(child:Clone());
            v388.Parent = workspace.Debris;
            v388.CFrame = v387.CFrame;
            p386:Add(Essentials:Weld(v387, v388));
        end;

        local v389 = p386:Add(ReplicatedStorage.Assets.SFX.Emotes.CrabRave:Clone());
        v389.Parent = p385.Character.HumanoidRootPart;
        v389:Play();
    end,

    ["Life Force"] = function(p390: userdata, p391: any) -- Line: 4061
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        for _, child in ReplicatedStorage.Assets.VFX.Emotes.LifeForce.VFX:GetChildren() do
            local v392 = p390.Character:FindFirstChild(child.Name);
            local v393 = p391:Add(child:Clone());
            v393.Parent = workspace.Debris;
            v393.CFrame = v392.CFrame;
            p391:Add(Essentials:Weld(v392, v393));
        end;

        local v394 = p391:Add(ReplicatedStorage.Assets.VFX.Emotes.LifeForce.Guitar:Clone());
        v394.Parent = p390.Character;
        v394.GuitarAttach.Part0 = p390.Character.HumanoidRootPart;
        p391:Add(v394.GuitarAttach);
        v394.GuitarAttach.Parent = p390.Character.HumanoidRootPart;
        local v395 = p391:Add(ReplicatedStorage.Assets.SFX.Emotes.LifeForce:Clone());
        v395.Parent = p390.Character.HumanoidRootPart;
        v395:Play();
    end,

    Next = function(p396: userdata, p397: any) -- Line: 4086
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v398 = p397:Add(ReplicatedStorage.Assets.VFX.Emotes.Next:Clone());
        v398.CFrame = p396.Character.HumanoidRootPart.CFrame;
        v398.Parent = p396.Character;
        Essentials:Weld(v398, p396.Character.HumanoidRootPart);
        local v399 = p397:Add(ReplicatedStorage.Assets.SFX.Emotes.Next:Clone());
        v399.Parent = p396.Character.HumanoidRootPart;
        v399:Play();
    end,

    ["The Banana Song"] = function(p400: userdata, p401: any) -- Line: 4098
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v402 = p401:Add(ReplicatedStorage.Assets.VFX.Emotes.TheBananaSong:Clone());
        v402.CFrame = p400.Character.HumanoidRootPart.CFrame;
        v402.Parent = p400.Character;
        Essentials:Weld(v402, p400.Character.HumanoidRootPart);
        local v403 = p401:Add(ReplicatedStorage.Assets.SFX.Emotes.TheBananaSong:Clone());
        v403.Parent = p400.Character.HumanoidRootPart;
        v403:Play();
    end,

    ["Passo Bem Solto"] = function(p404: userdata, p405: any) -- Line: 4110
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v406 = p405:Add(ReplicatedStorage.Assets.VFX.Emotes.PassoBemSolto:Clone());
        v406.CFrame = p404.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.55, 0);
        v406.Parent = p404.Character;
        Essentials:Weld(v406, p404.Character.HumanoidRootPart);
        local v407 = p405:Add(ReplicatedStorage.Assets.SFX.Emotes.PassoBemSolto:Clone());
        v407.Parent = p404.Character.HumanoidRootPart;
        v407:Play();
    end,

    Sugarphonk = function(p408: userdata, p409: any) -- Line: 4122
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v410 = p409:Add(ReplicatedStorage.Assets.VFX.Emotes.Sugarphonk:Clone());
        v410.CFrame = p408.Character.HumanoidRootPart.CFrame;
        v410.Parent = p408.Character;
        Essentials:Weld(v410, p408.Character.HumanoidRootPart);
        local v411 = p409:Add(ReplicatedStorage.Assets.SFX.Emotes.Sugarphonk:Clone());
        v411.Parent = p408.Character.HumanoidRootPart;
        v411:Play();
    end,

    ["Luna Bala"] = function(p412: userdata, p413: any) -- Line: 4134
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v414 = p413:Add(ReplicatedStorage.Assets.VFX.Emotes.LunaBala:Clone());
        v414.CFrame = p412.Character.HumanoidRootPart.CFrame;
        v414.Parent = p412.Character;
        Essentials:Weld(v414, p412.Character.HumanoidRootPart);
        local v415 = p413:Add(ReplicatedStorage.Assets.SFX.Emotes.LunaBala:Clone());
        v415.Parent = p412.Character.HumanoidRootPart;
        v415:Play();
    end,

    ["Spinning Cat"] = function(p416: userdata, p417: any) -- Line: 4146
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        for _, child in ReplicatedStorage.Assets.VFX.Emotes.SpinningCat.VFX:GetChildren() do
            local v418 = p416.Character:FindFirstChild(child.Name);
            local v419 = p417:Add(child:Clone());
            v419.Parent = workspace.Debris;
            v419.CFrame = v418.CFrame;
            p417:Add(Essentials:Weld(v418, v419));
        end;

        local v420 = p417:Add(ReplicatedStorage.Assets.SFX.Emotes.SpinningCat:Clone());
        v420.Parent = p416.Character.HumanoidRootPart;
        v420:Play();
    end,

    ["Montagem Miau"] = function(p421: userdata, p422: any) -- Line: 4164
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v423 = p422:Add(ReplicatedStorage.Assets.VFX.Emotes.MontagemMiau:Clone());
        v423.CFrame = p421.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.4, 0);
        v423.Parent = p421.Character;
        Essentials:Weld(v423, p421.Character.HumanoidRootPart);
        local v424 = p422:Add(ReplicatedStorage.Assets.SFX.Emotes.MontagemMiau:Clone());
        v424.Parent = p421.Character.HumanoidRootPart;
        v424:Play();
    end,

    ["Mande Mande"] = function(p425: userdata, p426: any) -- Line: 4176
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v427 = p426:Add(ReplicatedStorage.Assets.VFX.Emotes.MandeMande:Clone());
        v427.CFrame = p425.Character.HumanoidRootPart.CFrame;
        v427.Parent = p425.Character;
        Essentials:Weld(v427, p425.Character.HumanoidRootPart);
        local v428 = p426:Add(ReplicatedStorage.Assets.SFX.Emotes.MandeMande:Clone());
        v428.Parent = p425.Character.HumanoidRootPart;
        v428:Play();
    end,

    ["Volkswagen Funk"] = function(p429: userdata, p430: any) -- Line: 4188
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v431 = p430:Add(ReplicatedStorage.Assets.VFX.Emotes.VolkswagenFunk:Clone());
        v431.CFrame = p429.Character.HumanoidRootPart.CFrame;
        v431.Parent = p429.Character;
        Essentials:Weld(v431, p429.Character.HumanoidRootPart);
        local v432 = p430:Add(ReplicatedStorage.Assets.SFX.Emotes.VolkswagenFunk:Clone());
        v432.Parent = p429.Character.HumanoidRootPart;
        v432:Play();
    end,

    Escape = function(p433: userdata, p434: any) -- Line: 4200
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v435 = p434:Add(ReplicatedStorage.Assets.VFX.Emotes.Escape:Clone());
        v435.CFrame = p433.Character.HumanoidRootPart.CFrame;
        v435.Parent = p433.Character;
        Essentials:Weld(v435, p433.Character.HumanoidRootPart);
        local v436 = p434:Add(ReplicatedStorage.Assets.SFX.Emotes.Escape:Clone());
        v436.Parent = p433.Character.HumanoidRootPart;
        v436:Play();
    end,

    ["Sweet Rally"] = function(p437: userdata, p438: any) -- Line: 4212
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v439 = p438:Add(ReplicatedStorage.Assets.VFX.Emotes.SweetRally:Clone());
        v439.CFrame = p437.Character.HumanoidRootPart.CFrame;
        v439.Parent = p437.Character;
        Essentials:Weld(v439, p437.Character.HumanoidRootPart);
        local v440 = p438:Add(ReplicatedStorage.Assets.SFX.Emotes.SweetRally:Clone());
        v440.Parent = p437.Character.HumanoidRootPart;
        v440:Play();
    end,

    Doodle = function(p441: userdata, p442: any) -- Line: 4224
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v443 = p442:Add(ReplicatedStorage.Assets.VFX.Emotes.Doodle:Clone());
        v443.CFrame = p441.Character.HumanoidRootPart.CFrame;
        v443.Parent = p441.Character;
        Essentials:Weld(v443, p441.Character.HumanoidRootPart);
        local v444 = p442:Add(ReplicatedStorage.Assets.SFX.Emotes.Doodle:Clone());
        v444.Parent = p441.Character.HumanoidRootPart;
        v444:Play();
    end,

    Agonize = function(p445: userdata, p446: any) -- Line: 4236
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v447 = p446:Add(ReplicatedStorage.Assets.VFX.Emotes.Agonize:Clone());
        v447.CFrame = p445.Character.HumanoidRootPart.CFrame;
        v447.Parent = p445.Character;
        Essentials:Weld(v447, p445.Character.HumanoidRootPart);
        local v448 = p446:Add(ReplicatedStorage.Assets.SFX.Emotes.Agonize:Clone());
        v448.Parent = p445.Character.HumanoidRootPart;
        v448:Play();
    end,

    ["Yes!"] = function(p449: userdata, p450: any) -- Line: 4248
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local u451 = p450:Add(ReplicatedStorage.Assets.VFX.Emotes["Yes!"]:Clone());
        u451.Parent = workspace.Debris;
        u451.CFrame = p449.Character.HumanoidRootPart.CFrame;
        p450:Add(task.delay(0.45, function() -- Line: 4253
            -- upvalues: u451 (copy), VfxManager (ref)
            if u451.Parent then
                VfxManager.Emit(u451);
            end;
        end));
    end,

    Greet = function(p452: userdata, p453: any) -- Line: 4260
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local u454 = p453:Add(ReplicatedStorage.Assets.VFX.Emotes.Pray:Clone());
        u454.Parent = workspace.Debris;
        u454.CFrame = p452.Character.HumanoidRootPart.CFrame;
        VfxManager.Enable(u454.Pray.Enabled, true);
        VfxManager.Emit(u454.Pray.Emit);
        p453:Add(task.delay(0.817, function() -- Line: 4268
            -- upvalues: u454 (copy), VfxManager (ref)
            if u454.Parent then
                VfxManager.Enable(u454, false);
            end;
        end));
    end,

    ["What did u say?"] = function(p455: userdata, p456: any) -- Line: 4275
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local u457 = p456:Add(ReplicatedStorage.Assets.VFX.Emotes["What Did you say?"]:Clone());
        u457.Parent = workspace.Debris;
        u457.CFrame = p455.Character.HumanoidRootPart.CFrame;
        p456:Add(task.delay(0.283, function() -- Line: 4280
            -- upvalues: u457 (copy), VfxManager (ref)
            if u457.Parent then
                VfxManager.Emit(u457);
            end;
        end));
    end,

    Cold = function(p458: userdata, p459: any) -- Line: 4287
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local v460 = p459:Add(ReplicatedStorage.Assets.VFX.Emotes.ColdEmote:Clone());
        v460.Parent = workspace.Debris;
        v460.CFrame = p458.Character.HumanoidRootPart.CFrame * CFrame.new(-0.094, 7.426, 0.525);
        VfxManager.Emit(v460);
    end,

    IDK = function(p461: userdata, p462: any) -- Line: 4294
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local v463 = p462:Add(ReplicatedStorage.Assets.VFX.Emotes.IDK:Clone());
        v463.Parent = workspace.Debris;
        v463.CFrame = p461.Character.HumanoidRootPart.CFrame;
        VfxManager.Emit(v463);
    end,

    Sleeping = function(p464: userdata, p465: any) -- Line: 4301
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local v466 = p465:Add(ReplicatedStorage.Assets.VFX.Emotes.Sleeping:Clone());
        v466.Parent = workspace.Debris;
        v466.CFrame = p464.Character.HumanoidRootPart.CFrame;
        VfxManager.Emit(v466);
    end,

    Stretch = function(p467: userdata, u468: any) -- Line: 4308
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u469 = u468:Add(ReplicatedStorage.Assets.VFX.Emotes.Stretch:Clone());
        u469.Parent = workspace.Debris;
        u469.Anchored = false;
        u469.CFrame = p467.Character.HumanoidRootPart.CFrame * CFrame.new(0.002, -0.066, 0.345) * CFrame.Angles(0.47123889803846897, -0.02757620218151041, -0.013439035240356337);
        u468:Add(Essentials:Weld(p467.Character.HumanoidRootPart, u469));
        u468:Add(task.delay(0.1, function() -- Line: 4315
            -- upvalues: VfxManager (ref), u469 (copy), u468 (copy)
            VfxManager.Enable(u469.Arm, true);
            u468:Add(task.delay(1.3, function() -- Line: 4318
                -- upvalues: VfxManager (ref), u469 (ref)
                VfxManager.Enable(u469.Arm, false);
            end));
        end));
        u468:Add(task.delay(2.5, function() -- Line: 4323
            -- upvalues: VfxManager (ref), u469 (copy), u468 (copy)
            VfxManager.Enable(u469.Leg, true);
            VfxManager.Enable(u469.Arm1, true);
            u468:Add(task.delay(0.8, function() -- Line: 4327
                -- upvalues: VfxManager (ref), u469 (ref)
                VfxManager.Enable(u469.Leg, false);
                VfxManager.Enable(u469.Arm1, false);
            end));
        end));
        u468:Add(task.delay(3.7, function() -- Line: 4333
            -- upvalues: VfxManager (ref), u469 (copy), u468 (copy)
            VfxManager.Enable(u469.Back, true);
            u468:Add(task.delay(1, function() -- Line: 4336
                -- upvalues: VfxManager (ref), u469 (ref)
                VfxManager.Enable(u469.Back, false);
            end));
        end));
    end,

    Clap = function(p470: userdata, p471: any) -- Line: 4342
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u472 = p471:Add(ReplicatedStorage.Assets.VFX.Emotes.Clapping:Clone());
        u472.Parent = workspace.Debris;
        u472.CFrame = p470.Character.HumanoidRootPart.CFrame;
        u472.Anchored = false;
        p471:Add(Essentials:Weld(p470.Character.HumanoidRootPart, u472));
        p471:Add(task.delay(0.4, function() -- Line: 4349
            -- upvalues: u472 (copy), VfxManager (ref)
            for i = 1, 5 do
                if not u472.Parent then
                    break;
                end;

                VfxManager.Emit(u472);
                task.wait(0.333);
                local _ = i;
            end;
        end));
    end,

    L = function(p473: userdata, p474: any) -- Line: 4362
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local v475 = p474:Add(ReplicatedStorage.Assets.VFX.Emotes.L:Clone());
        v475.Parent = workspace.Debris;
        v475.CFrame = p473.Character.HumanoidRootPart.CFrame;
        v475.Anchored = false;
        p474:Add(Essentials:Weld(p473.Character.HumanoidRootPart, v475));
        VfxManager.Enable(v475, true);
    end,

    Scared = function(p476: userdata, p477: any) -- Line: 4372
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local Character = p476.Character;

        for _, child in ReplicatedStorage.Assets.VFX.Emotes.Scared:GetChildren() do
            local v478 = Character:FindFirstChild(child.Name);

            if v478 then
                local v479 = p477:Add(child:Clone());
                v479.Parent = workspace.Debris;
                v479.CFrame = v478.CFrame;
                p477:Add(Essentials:Weld(v478, v479));
            end;
        end;
    end,

    ["Super Bow"] = function(u480: userdata, p481: any) -- Line: 4387
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local u482 = p481:Add(ReplicatedStorage.Assets.VFX.Emotes.SuperBow:Clone());
        u482.Parent = workspace.Debris;
        local u483 = CFrame.new(0.044, -2.95, -2.591) * CFrame.Angles(0, -3.141592653589793, 0);
        u482.CFrame = u480.Character.HumanoidRootPart.CFrame * u483;
        p481:Add(task.delay(0.317, function() -- Line: 4393
            -- upvalues: u482 (copy), u480 (copy), u483 (copy), VfxManager (ref)
            if not u482.Parent then
                return;
            end;

            u482.CFrame = u480.Character.HumanoidRootPart.CFrame * u483;
            VfxManager.Emit(u482);
        end));
    end,

    ["Abnormal Run"] = function(p484: userdata, p485: any) -- Line: 4401
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u486 = p485:Add(ReplicatedStorage.Assets.VFX.Emotes.Running:Clone());
        u486.Parent = workspace.Debris;
        u486.Anchored = false;
        u486.CFrame = p484.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, -3.141592653589793, 0);
        p485:Add(Essentials:Weld(p484.Character.HumanoidRootPart, u486));
        p485:Add(task.delay(0.083, function() -- Line: 4408
            -- upvalues: u486 (copy), VfxManager (ref)
            if not u486.Parent then
                return;
            end;

            repeat
                VfxManager.Emit(u486);
                task.wait(0.334);
            until not u486.Parent;
        end));
    end,

    ["Touch Glasses"] = function(p487: userdata, p488: any) -- Line: 4418
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u489 = p488:Add(ReplicatedStorage.Assets.VFX.Emotes.Glasses:Clone());
        u489.Parent = workspace.Debris;
        u489.CFrame = p487.Character.Head.CFrame;
        u489.Anchored = false;
        p488:Add(Essentials:Weld(p487.Character.Head, u489));
        p488:Add(task.delay(0.85, function() -- Line: 4425
            -- upvalues: u489 (copy), VfxManager (ref)
            if u489.Parent then
                VfxManager.Emit(u489);
            end;
        end));
    end,

    ["Green!"] = function(p490: userdata, p491: any) -- Line: 4432
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local u492 = p491:Add(ReplicatedStorage.Assets.VFX.Emotes.GreenEmote:Clone());
        u492.Parent = workspace.Debris;
        u492.CFrame = p490.Character.HumanoidRootPart.CFrame;
        p491:Add(task.delay(0.85, function() -- Line: 4437
            -- upvalues: u492 (copy), VfxManager (ref)
            if u492.Parent then
                VfxManager.Emit(u492);
            end;
        end));
    end,

    Gambler = function(p493: userdata, p494: any) -- Line: 4444
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local v495 = p494:Add(ReplicatedStorage.Assets.VFX.Emotes.Gambler:Clone());
        v495.Parent = workspace.Debris;
        v495.CFrame = p493.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
        VfxManager.Enable(v495, true);
    end,

    Head = function(p496: userdata, p497: any) -- Line: 4452
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u498 = p497:Add(ReplicatedStorage.Assets.VFX.Emotes.DizzyEmote:Clone());
        u498.Parent = workspace.Debris;
        u498.CFrame = p496.Character.HumanoidRootPart.CFrame * CFrame.new(1.074, 0.195, -1.195) * CFrame.Angles(0, -3.141592653589793, 0);
        u498.Anchored = false;
        p497:Add(Essentials:Weld(p496.Character.HumanoidRootPart, u498));
        p497:Add(task.delay(2.2, function() -- Line: 4459
            -- upvalues: u498 (copy), VfxManager (ref)
            if u498.Parent then
                VfxManager.Enable(u498, true);
            end;
        end));
        p497:Add(task.delay(3.9, function() -- Line: 4465
            -- upvalues: u498 (copy), VfxManager (ref)
            if u498.Parent then
                VfxManager.Enable(u498, false);
            end;
        end));
    end,

    ["The Honored One"] = function(p499: userdata, p500: any) -- Line: 4473
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), TweenService (copy), VfxManager (copy)
        local v501 = p500:Add(ReplicatedStorage.Assets.VFX.Emotes.HonoredOne:Clone());
        v501.Parent = workspace.Debris;
        v501.Root.Anchored = false;
        v501:PivotTo(p499.Character.HumanoidRootPart.CFrame);
        p500:Add(Essentials:Weld(p499.Character.HumanoidRootPart, v501.Root));

        for _, descendant in v501["HonoredBeams/Star"]:GetDescendants() do
            if descendant:IsA("Beam") then
                local Width1 = descendant.Width1;
                descendant.Width1 = 0;
                TweenService:Create(descendant, TweenInfo.new(1), {
                    Width1 = Width1
                }):Play();
            end;
        end;

        VfxManager.Enable(v501, true);
    end,

    ["Referee\'s Cart"] = function(p502, u503) -- Line: 4493
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
        local v504 = ReplicatedStorage.Assets.VFX.Emotes["Referee\'s Cart"];
        local Character = p502.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v505 = Character:FindFirstChild("Left Arm");
        local u506 = u503:Add(v504.Cart:Clone());
        u506.Parent = Character;
        u506.Handle.Part0 = HumanoidRootPart;
        local v507 = u503:Add(v504.Book:Clone());
        v507.Parent = Character;
        v507.Handle.Part0 = v505;
        local u508 = Humanoid:LoadAnimation(v504.Animation);
        u508.Priority = Enum.AnimationPriority.Action2;
        u503:Add(function() -- Line: 4512
            -- upvalues: u508 (copy)
            u508:Stop(0);
            u508:Destroy();
        end);
        u503:Add(task.delay(1, function() -- Line: 4517
            -- upvalues: VfxManager (ref), u506 (copy), u503 (copy), TweenService (ref)
            VfxManager.Enable(u506, true);
            local u509 = {};
            local u510 = {};

            for _, descendant in pairs(u506:GetDescendants()) do
                if descendant:IsA("Beam") then
                    table.insert(u509, descendant);
                    u510[descendant] = {};
                    local v511 = descendant;

                    for i, v in ipairs(descendant.Transparency.Keypoints) do
                        u510[v511][i] = {
                            Start = v.Value,
                            Needed = 1 - v.Value
                        };
                    end;
                end;
            end;

            local u512 = u503:Add(Instance.new("NumberValue"));
            u512.Changed:Connect(function() -- Line: 4538
                -- upvalues: u509 (copy), u510 (copy), u512 (copy)
                for _, v in u509 do
                    local v513 = v;
                    local v514 = {};

                    for i, v2 in ipairs(v.Transparency.Keypoints) do
                        table.insert(v514, NumberSequenceKeypoint.new(v2.Time, u510[v513][i].Start + u510[v513][i].Needed * u512.Value));
                    end;

                    v513.Transparency = NumberSequence.new(v514);
                end;
            end);
            u512.Value = 1;
            TweenService:Create(u512, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
        end));
        u503:Add(task.delay(1.8333333333333333, function() -- Line: 4554
            -- upvalues: u508 (copy)
            u508:Play();
        end));
    end,

    Lowrider = function(p515, p516) -- Line: 4559
        -- upvalues: ReplicatedStorage (copy)
        local Lowrider = ReplicatedStorage.Assets.VFX.Emotes.Lowrider;
        local Character = p515.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v517 = p516:Add(Lowrider.Lowrider:Clone());
        v517.Parent = Character;
        v517.Handle.Part0 = HumanoidRootPart;
        local u518 = Humanoid:LoadAnimation(Lowrider.CharacterAnimation);
        u518.Priority = Enum.AnimationPriority.Action3;
        u518:Play();
        local u519 = v517.AnimationController.Animator:LoadAnimation(Lowrider.LowriderAnimation);
        u519.Priority = Enum.AnimationPriority.Action3;
        u519:Play();
        p516:Add(function() -- Line: 4578
            -- upvalues: u518 (copy), u519 (copy)
            u518:Stop(0);
            u518:Destroy();
            u519:Stop(0);
            u519:Destroy();
        end);
    end,

    ["Unc Walk"] = function(p520, p521) -- Line: 4586
        -- upvalues: ReplicatedStorage (copy)
        local Character = p520.Character;
        local v522 = Character:FindFirstChild("Right Arm");
        local v523 = p521:Add(ReplicatedStorage.Assets.VFX.Emotes["Unc Walk"]:Clone());
        v523.Parent = Character;
        v523.Handle.Part0 = v522;
    end,

    ["Jack In The Box"] = function(p524, p525) -- Line: 4595
        -- upvalues: ReplicatedStorage (copy)
        local v526 = ReplicatedStorage.Assets.VFX.Emotes["Jack In The Box"];
        local Character = p524.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local Torso = Character:FindFirstChild("Torso");
        local v527 = p525:Add(v526.Box:Clone());
        v527.Parent = Character;
        v527.Handle.Part0 = HumanoidRootPart;
        local u528 = Humanoid:LoadAnimation(v526.CharacterAnimation);
        u528.Priority = Enum.AnimationPriority.Action4;
        u528:Play();
        local u529 = v527.AnimationController.Animator:LoadAnimation(v526.BoxAnimation);
        u529.Priority = Enum.AnimationPriority.Action4;
        u529:Play();
        p525:Add(task.delay(2.6666666666666665, function() -- Line: 4615
            -- upvalues: u528 (copy), u529 (copy)
            u528:AdjustSpeed(0);
            u529:AdjustSpeed(0);
        end));

        if Torso then
            Torso.CanCollide = false;
        end;

        p525:Add(function() -- Line: 4624
            -- upvalues: Torso (copy), u528 (copy), u529 (copy)
            if Torso then
                Torso.CanCollide = true;
            end;

            u528:Stop(0);
            u528:Destroy();
            u529:Stop(0);
            u529:Destroy();
        end);
    end,

    ["Floating Balloon"] = function(p530, p531) -- Line: 4636
        -- upvalues: ReplicatedStorage (copy)
        local Character = p530.Character;
        local v532 = Character:FindFirstChild("Right Arm");
        local v533 = p531:Add(ReplicatedStorage.Assets.VFX.Emotes["Floating Balloon"]:Clone());
        v533.Parent = Character;
        v533.Handle.Part0 = v532;
    end,

    BANG = function(p534, u535) -- Line: 4645
        -- upvalues: ReplicatedStorage (copy)
        local Character = p534.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v536 = u535:Add(ReplicatedStorage.Assets.VFX.Emotes.BANG:Clone());
        v536.Parent = Character;
        v536.Handle.Part0 = HumanoidRootPart;
        u535:Add(task.delay(3.1666666666666665, function() -- Line: 4653
            -- upvalues: u535 (copy)
            u535:Clean();
        end));
    end,

    Ringing = function(p537, u538) -- Line: 4658
        -- upvalues: ReplicatedStorage (copy), TweenService (copy)
        local Character = p537.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u539 = u538:Add(ReplicatedStorage.Assets.VFX.Emotes.Ringing:Clone());
        u539.Parent = Character;
        u539.Handle.Part0 = HumanoidRootPart;
        u538:Add(task.delay(4.383333333333334, function() -- Line: 4666
            -- upvalues: u538 (copy), u539 (copy), TweenService (ref)
            local u540 = u538:Add(Instance.new("NumberValue", u539));
            u540.Value = 1;
            u540.Changed:Connect(function() -- Line: 4669
                -- upvalues: u540 (copy), u539 (ref)
                if u540.Value > 0 then
                    u539:ScaleTo(u540.Value);
                end;
            end);
            TweenService:Create(u540, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Value = 0
            }):Play();
            task.wait(0.25);
            u538:Clean();
        end));
    end,

    ["Wazzup!"] = function(p541, u542) -- Line: 4682
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy)
        local v543 = ReplicatedStorage.Assets.VFX.Emotes["Wazzup!"];
        local Character = p541.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        SfxManager:playSound({
            Sound = "Wazzup!",
            Parent = HumanoidRootPart
        });
        local v544 = u542:Add(v543.Phone:Clone());
        v544.Parent = Character;
        v544.Handle.Part0 = HumanoidRootPart;
        local v545 = u542:Add(v543.Mask:Clone());
        v545.Parent = Character;
        v545.Handle.Part0 = HumanoidRootPart;
        u542:Add(task.delay(4.25, function() -- Line: 4698
            -- upvalues: u542 (copy)
            u542:Clean();
        end));
    end,

    Killer = function(p546, u547) -- Line: 4703
        -- upvalues: ReplicatedStorage (copy)
        local Killer = ReplicatedStorage.Assets.VFX.Emotes.Killer;
        local Character = p546.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v548 = u547:Add(Killer.Knife:Clone());
        v548.Parent = Character;
        v548.Handle.Part0 = HumanoidRootPart;
        local v549 = u547:Add(Killer.Mask:Clone());
        v549.Parent = Character;
        v549.Handle.Part0 = HumanoidRootPart;
        u547:Add(task.delay(4.516666666666667, function() -- Line: 4717
            -- upvalues: u547 (copy)
            u547:Clean();
        end));
    end,

    ["Hot Chocolate"] = function(p550, p551) -- Line: 4722
        -- upvalues: ReplicatedStorage (copy)
        local Character = p550.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v552 = p551:Add(ReplicatedStorage.Assets.VFX.Emotes["Hot Chocolate"]:Clone());
        v552.Parent = Character;
        v552.Handle.Part0 = HumanoidRootPart;
    end,

    ["Candle Meditation"] = function(p553, p554) -- Line: 4731
        -- upvalues: ReplicatedStorage (copy)
        local v555 = ReplicatedStorage.Assets.VFX.Emotes["Candle Meditation"];
        local Character = p553.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v556 = p554:Add(v555.Candles:Clone());
        v556.Parent = Character;
        v556.Handle.Part0 = HumanoidRootPart;
        local u557 = Humanoid:LoadAnimation(v555.Animation);
        u557:Play();
        p554:Add(task.delay(3.816666666666667, function() -- Line: 4745
            -- upvalues: u557 (copy)
            u557:AdjustSpeed(0);
            u557:AdjustSpeed(0);
        end));
        p554:Add(function() -- Line: 4750
            -- upvalues: u557 (copy)
            u557:Stop(0);
            u557:Destroy();
        end);
    end,

    ["Leaves Jump"] = function(p558, u559) -- Line: 4756
        -- upvalues: ReplicatedStorage (copy), TweenService (copy)
        local Character = p558.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u560 = u559:Add(ReplicatedStorage.Assets.VFX.Emotes["Leaves Jump"]:Clone());
        u560.Parent = Character;
        u560.Handle.Part0 = HumanoidRootPart;
        u559:Add(task.delay(3.25, function() -- Line: 4764
            -- upvalues: TweenService (ref), u560 (copy), u559 (copy)
            TweenService:Create(u560.PrimaryPart, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            task.wait(0.25);
            u559:Clean();
        end));
    end,

    ["Pumpkin Head"] = function(p561, u562) -- Line: 4773
        -- upvalues: ReplicatedStorage (copy)
        local Character = p561.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v563 = u562:Add(ReplicatedStorage.Assets.VFX.Emotes["Pumpkin Head"]:Clone());
        v563.Parent = Character;
        v563.Handle.Part0 = HumanoidRootPart;
        u562:Add(task.delay(7, function() -- Line: 4781
            -- upvalues: u562 (copy)
            u562:Clean();
        end));
    end,

    Lantern = function(p564, p565) -- Line: 4786
        -- upvalues: ReplicatedStorage (copy)
        local Character = p564.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v566 = p565:Add(ReplicatedStorage.Assets.VFX.Emotes.Lantern:Clone());
        v566.Parent = Character;
        v566.Handle.Part0 = HumanoidRootPart;
    end,

    ["Turkey Leg"] = function(p567, u568) -- Line: 4795
        -- upvalues: ReplicatedStorage (copy)
        local Character = p567.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v569 = u568:Add(ReplicatedStorage.Assets.VFX.Emotes["Turkey Leg"]:Clone());
        v569.Parent = Character;
        v569.Handle.Part0 = HumanoidRootPart;
        u568:Add(task.delay(3.5, function() -- Line: 4803
            -- upvalues: u568 (copy)
            u568:Clean();
        end));
    end,

    ["Chainsaw Maniac"] = function(p570, u571) -- Line: 4808
        -- upvalues: ReplicatedStorage (copy)
        local Character = p570.Character;
        local v572 = u571:Add(ReplicatedStorage.Assets.VFX.Emotes["Chainsaw Maniac"]:Clone());
        v572.Parent = Character;
        v572.Handle.Part0 = Character:FindFirstChild("Right Arm");
        u571:Add(task.delay(2.6666666666666665, function() -- Line: 4815
            -- upvalues: u571 (copy)
            u571:Clean();
        end));
    end,

    ["Tentacle Walk"] = function(p573, p574) -- Line: 4820
        -- upvalues: ReplicatedStorage (copy), RunService (copy)
        local v575 = ReplicatedStorage.Assets.VFX.Emotes["Tentacle Walk"];
        local Character = p573.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v576 = p574:Add(v575.Tentacles:Clone());
        v576.Parent = Character;
        v576.Handle.Part0 = Character:FindFirstChild("Torso");
        local u577 = Humanoid:LoadAnimation(v575.Animation);
        u577.Priority = Enum.AnimationPriority.Action3;
        u577:Play();
        p574:Add(RunService.Heartbeat:Connect(function() -- Line: 4835
            -- upvalues: HumanoidRootPart (copy), u577 (copy)
            if math.floor((HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude) > 0 then
                if u577.IsPlaying then
                    return;
                end;

                u577:Play();

                return;
            end;

            if not u577.IsPlaying then
                return;
            end;

            u577:Stop();
        end));
        p574:Add(function() -- Line: 4845
            -- upvalues: u577 (copy)
            u577:Stop(0);
            u577:Destroy();
        end);
    end,

    ["Cyber Hoverboard"] = function(p578, u579) -- Line: 4851
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
        local v580 = ReplicatedStorage.Assets.VFX.Emotes["Cyber Hoverboard"];
        local Character = p578.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u581 = u579:Add(v580.Hoverboard:Clone());
        u581.Parent = Character;
        u581.Handle.Part0 = HumanoidRootPart;
        local u582 = Humanoid:LoadAnimation(v580.Animation);
        u582.Priority = Enum.AnimationPriority.Action2;
        u579:Add(function() -- Line: 4865
            -- upvalues: u582 (copy)
            u582:Stop(0);
            u582:Destroy();
        end);
        u579:Add(task.delay(1, function() -- Line: 4870
            -- upvalues: VfxManager (ref), u581 (copy), u579 (copy), TweenService (ref)
            VfxManager.Enable(u581, true);
            local u583 = {};
            local u584 = {};

            for _, descendant in pairs(u581:GetDescendants()) do
                if descendant:IsA("Beam") then
                    table.insert(u583, descendant);
                    u584[descendant] = {};
                    local v585 = descendant;

                    for i, v in ipairs(descendant.Transparency.Keypoints) do
                        u584[v585][i] = {
                            Start = v.Value,
                            Needed = 1 - v.Value
                        };
                    end;
                end;
            end;

            local u586 = u579:Add(Instance.new("NumberValue"));
            u586.Changed:Connect(function() -- Line: 4891
                -- upvalues: u583 (copy), u584 (copy), u586 (copy)
                for _, v in u583 do
                    local v587 = v;
                    local v588 = {};

                    for i, v2 in ipairs(v.Transparency.Keypoints) do
                        table.insert(v588, NumberSequenceKeypoint.new(v2.Time, u584[v587][i].Start + u584[v587][i].Needed * u586.Value));
                    end;

                    v587.Transparency = NumberSequence.new(v588);
                end;
            end);
            u586.Value = 1;
            TweenService:Create(u586, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
        end));
        u579:Add(task.delay(1.8333333333333333, function() -- Line: 4907
            -- upvalues: u582 (copy)
            u582:Play();
        end));
    end,

    ["Turret Jump"] = function(p589, u590) -- Line: 4912
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local Character = p589.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u591 = u590:Add(ReplicatedStorage.Assets.VFX.Emotes["Turret Jump"]:Clone());
        u591.Parent = Character;
        u591.Handle.Part0 = HumanoidRootPart;
        u590:Add(task.delay(0.4166666666666667, function() -- Line: 4920
            -- upvalues: u591 (copy)
            u591.PrimaryPart.Transparency = 0;
        end));
        u590:Add(task.delay(0.65, function() -- Line: 4924
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(1.05, function() -- Line: 4928
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(1.6666666666666667, function() -- Line: 4932
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(1.9833333333333334, function() -- Line: 4936
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(2.3333333333333335, function() -- Line: 4940
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(2.6666666666666665, function() -- Line: 4944
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(3, function() -- Line: 4948
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(3.316666666666667, function() -- Line: 4952
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(3.6666666666666665, function() -- Line: 4956
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(4.083333333333333, function() -- Line: 4960
            -- upvalues: VfxManager (ref), u591 (copy)
            VfxManager.Emit(u591);
        end));
        u590:Add(task.delay(4.833333333333333, function() -- Line: 4964
            -- upvalues: u590 (copy)
            u590:Clean();
        end));
    end,

    ["Cyber Car"] = function(p592, u593) -- Line: 4969
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
        local v594 = ReplicatedStorage.Assets.VFX.Emotes["Cyber Car"];
        local Character = p592.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u595 = u593:Add(v594.Car:Clone());
        u595.Parent = Character;
        u595.Handle.Part0 = HumanoidRootPart;
        local u596 = Humanoid:LoadAnimation(v594.Animation);
        u596.Priority = Enum.AnimationPriority.Action2;
        u593:Add(function() -- Line: 4983
            -- upvalues: u596 (copy)
            u596:Stop(0);
            u596:Destroy();
        end);
        u593:Add(task.delay(0.6666666666666666, function() -- Line: 4988
            -- upvalues: VfxManager (ref), u595 (copy), u593 (copy), TweenService (ref)
            VfxManager.Enable(u595, true);
            local u597 = {};
            local u598 = {};

            for _, descendant in pairs(u595:GetDescendants()) do
                if descendant:IsA("Beam") then
                    table.insert(u597, descendant);
                    u598[descendant] = {};
                    local v599 = descendant;

                    for i, v in ipairs(descendant.Transparency.Keypoints) do
                        u598[v599][i] = {
                            Start = v.Value,
                            Needed = 1 - v.Value
                        };
                    end;
                end;
            end;

            local u600 = u593:Add(Instance.new("NumberValue"));
            u600.Changed:Connect(function() -- Line: 5009
                -- upvalues: u597 (copy), u598 (copy), u600 (copy)
                for _, v in u597 do
                    local v601 = v;
                    local v602 = {};

                    for i, v2 in ipairs(v.Transparency.Keypoints) do
                        table.insert(v602, NumberSequenceKeypoint.new(v2.Time, u598[v601][i].Start + u598[v601][i].Needed * u600.Value));
                    end;

                    v601.Transparency = NumberSequence.new(v602);
                end;
            end);
            u600.Value = 1;
            TweenService:Create(u600, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
        end));
        u593:Add(task.delay(1.95, function() -- Line: 5025
            -- upvalues: u596 (copy)
            u596:Play();
        end));
    end,

    ["Dino Ride"] = function(p603, p604) -- Line: 5030
        -- upvalues: ReplicatedStorage (copy)
        local Character = p603.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v605 = p604:Add(ReplicatedStorage.Assets.VFX.Emotes["Dino Ride"]:Clone());
        v605.Parent = Character;
        v605.Handle.Part0 = HumanoidRootPart;
    end,

    ["Drum Set"] = function(p606, p607) -- Line: 5039
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy)
        local Character = p606.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v608 = p607:Add(ReplicatedStorage.Assets.VFX.Emotes.Drums:Clone());
        v608.Parent = Character;
        v608.Handle.Part0 = HumanoidRootPart;
        SfxManager:playSound({
            Sound = "Drum Set",
            Parent = v608.PrimaryPart
        });
    end,

    ["Mic Drop"] = function(p609, u610) -- Line: 5050
        -- upvalues: ReplicatedStorage (copy)
        local Character = p609.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v611 = u610:Add(ReplicatedStorage.Assets.VFX.Emotes["Mic Drop"]:Clone());
        v611.Parent = Character;
        v611.Handle.Part0 = HumanoidRootPart;
        u610:Add(task.delay(3.216666666666667, function() -- Line: 5058
            -- upvalues: u610 (copy)
            u610:Clean();
        end));
    end,

    ["Popstar Keytar"] = function(p612, p613) -- Line: 5063
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy)
        local Character = p612.Character;
        local Torso = Character:FindFirstChild("Torso");
        local v614 = p613:Add(ReplicatedStorage.Assets.VFX.Emotes["Popstar Keytar"]:Clone());
        v614.Parent = Character;
        v614.Handle.Part0 = Torso;
        SfxManager:playSound({
            Sound = "Popstar Keytar",
            Parent = v614.PrimaryPart
        });
    end,

    ["King\'s Throne"] = function(p615, u616) -- Line: 5074
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
        local v617 = ReplicatedStorage.Assets.VFX.Emotes["King\'s Throne"];
        local Character = p615.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u618 = u616:Add(v617.Throne:Clone());
        u618.Parent = Character;
        u618.Handle.Part0 = HumanoidRootPart;
        local u619 = Humanoid:LoadAnimation(v617.Animation);
        u619.Priority = Enum.AnimationPriority.Action2;
        u616:Add(function() -- Line: 5088
            -- upvalues: u619 (copy)
            u619:Stop(0);
            u619:Destroy();
        end);
        u616:Add(task.delay(1.95, function() -- Line: 5093
            -- upvalues: u619 (copy), VfxManager (ref), u618 (copy), u616 (copy), TweenService (ref)
            u619:Play();
            VfxManager.Enable(u618, true);
            local u620 = {};
            local u621 = {};

            for _, descendant in pairs(u618:GetDescendants()) do
                if descendant:IsA("Beam") then
                    table.insert(u620, descendant);
                    u621[descendant] = {};
                    local v622 = descendant;

                    for i, v in ipairs(descendant.Transparency.Keypoints) do
                        u621[v622][i] = {
                            Start = v.Value,
                            Needed = 1 - v.Value
                        };
                    end;
                end;
            end;

            local u623 = u616:Add(Instance.new("NumberValue"));
            u623.Changed:Connect(function() -- Line: 5115
                -- upvalues: u620 (copy), u621 (copy), u623 (copy)
                for _, v in u620 do
                    local v624 = v;
                    local v625 = {};

                    for i, v2 in ipairs(v.Transparency.Keypoints) do
                        table.insert(v625, NumberSequenceKeypoint.new(v2.Time, u621[v624][i].Start + u621[v624][i].Needed * u623.Value));
                    end;

                    v624.Transparency = NumberSequence.new(v625);
                end;
            end);
            u623.Value = 1;
            TweenService:Create(u623, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
        end));
    end,

    ["Trophy Lift"] = function(p626, u627) -- Line: 5132
        -- upvalues: ReplicatedStorage (copy), RunService (copy), VfxManager (copy), TweenService (copy)
        local v628 = ReplicatedStorage.Assets.VFX.Emotes["Trophy Lift"];
        local Character = p626.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local u629 = u627:Add(v628.Trophy:Clone());
        u629.Parent = Character;
        u629.Handle.Part0 = Character:FindFirstChild("Right Arm");
        local u630 = Humanoid:LoadAnimation(v628.Animation);
        u630.Priority = Enum.AnimationPriority.Action2;
        u627:Add(function() -- Line: 5145
            -- upvalues: u630 (copy)
            u630:Stop(0);
            u630:Destroy();
        end);
        u627:Add(RunService.RenderStepped:Connect(function() -- Line: 5150
            -- upvalues: u629 (copy)
            if not (u629 and u629:FindFirstChild("Cylinder0011")) then
                return;
            end;

            u629.Trophy.CFrame = u629.Cylinder0011.Bone.Connector.WorldCFrame;
        end));
        u627:Add(task.delay(1.4666666666666666, function() -- Line: 5155
            -- upvalues: u630 (copy), VfxManager (ref), u629 (copy), u627 (copy), TweenService (ref)
            u630:Play();
            VfxManager.Enable(u629, true);
            local u631 = {};
            local u632 = {};

            for _, descendant in pairs(u629:GetDescendants()) do
                if descendant:IsA("Beam") then
                    table.insert(u631, descendant);
                    u632[descendant] = {};
                    local v633 = descendant;

                    for i, v in ipairs(descendant.Transparency.Keypoints) do
                        u632[v633][i] = {
                            Start = v.Value,
                            Needed = 1 - v.Value
                        };
                    end;
                end;
            end;

            local u634 = u627:Add(Instance.new("NumberValue"));
            u634.Changed:Connect(function() -- Line: 5177
                -- upvalues: u631 (copy), u632 (copy), u634 (copy)
                for _, v in u631 do
                    local v635 = v;
                    local v636 = {};

                    for i, v2 in ipairs(v.Transparency.Keypoints) do
                        table.insert(v636, NumberSequenceKeypoint.new(v2.Time, u632[v635][i].Start + u632[v635][i].Needed * u634.Value));
                    end;

                    v635.Transparency = NumberSequence.new(v636);
                end;
            end);
            u634.Value = 1;
            TweenService:Create(u634, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
        end));
    end,

    ["Eclipse Meditation"] = function(p637, p638) -- Line: 5194
        -- upvalues: ReplicatedStorage (copy), RunService (copy)
        local v639 = ReplicatedStorage.Assets.VFX.Emotes["Eclipse Meditation"];
        local Character = p637.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u640 = p638:Add(v639.Part:Clone());
        u640.Parent = workspace.Debris;
        local u641 = Humanoid:LoadAnimation(v639.Animation);
        u641.Priority = Enum.AnimationPriority.Action2;
        local u642 = 0;
        local u643 = 0;
        local u644 = 1;
        local CFrame2 = HumanoidRootPart.CFrame;
        p638:Add(RunService.RenderStepped:Connect(function(p645) -- Line: 5212
            -- upvalues: u642 (ref), u644 (ref), u643 (ref), u640 (copy), CFrame2 (copy)
            u642 = u642 + u644 * 4 * p645;
            u643 = u643 + 360 * p645;

            if math.abs(u642) >= 2 then
                u644 = u644 * -1;
            end;

            u640.CFrame = CFrame2 * CFrame.new(0, u642, 0) * CFrame.Angles(0, math.rad(u643), 0);
        end));
        p638:Add(function() -- Line: 5223
            -- upvalues: u641 (copy)
            u641:Stop(0);
            u641:Destroy();
        end);
        p638:Add(task.delay(1.85, function() -- Line: 5228
            -- upvalues: u641 (copy)
            u641:Play();
        end));
    end,

    ["Dragon Ride"] = function(p646, p647) -- Line: 5233
        -- upvalues: ReplicatedStorage (copy)
        local v648 = ReplicatedStorage.Assets.VFX.Emotes["Dragon Ride"];
        local Character = p646.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v649 = p647:Add(v648.Dragon:Clone());
        v649.Parent = Character;
        v649.Handle.Part0 = HumanoidRootPart;
        local u650 = Humanoid:LoadAnimation(v648.Animation);
        u650.Priority = Enum.AnimationPriority.Action2;
        p647:Add(function() -- Line: 5247
            -- upvalues: u650 (copy)
            u650:Stop(0);
            u650:Destroy();
        end);
        p647:Add(task.delay(1.85, function() -- Line: 5252
            -- upvalues: u650 (copy)
            u650:Play();
        end));
    end,

    ["Cup of Coffee"] = function(p651: userdata, u652: any) -- Line: 5257
        -- upvalues: ReplicatedStorage (copy)
        local v653 = ReplicatedStorage.Assets.VFX.Emotes["Cup of Coffee"];
        local Character = p651.Character;
        local v654 = Character:FindFirstChildWhichIsA("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if not (HumanoidRootPart and v654) then
            return;
        end;

        local u655 = v653.Chair_Rig:Clone();
        local u656 = v653.Coffee_Rig:Clone();
        local u657 = v653.CoffeeMotor:Clone();
        local u658 = v653.ChairMotor:Clone();
        local u659 = v654:LoadAnimation(v653:FindFirstChild("Animation"));
        u659.Priority = Enum.AnimationPriority.Action2;
        u655.Parent = Character;
        u656.Parent = Character;
        u657.Name = "Coffe1";
        u657.Part0 = Character:FindFirstChild("Right Arm");
        u657.Part1 = u656.Coffe1;
        u657.Parent = Character:FindFirstChild("Right Arm");
        u658.Name = "Chair";
        u658.Part0 = HumanoidRootPart;
        u658.Part1 = u655.Chair;
        u658.Parent = u655.Chair;
        u652:Add(function() -- Line: 5286
            -- upvalues: u655 (copy), u656 (copy), u658 (copy), u657 (copy)
            pcall(game.Destroy, u655);
            pcall(game.Destroy, u656);
            pcall(game.Destroy, u658);
            pcall(game.Destroy, u657);
        end);
        u652:Add(function() -- Line: 5293
            -- upvalues: u659 (copy)
            u659:Stop();
        end);
        u652:Add(u659.Ended:Once(function() -- Line: 5297
            -- upvalues: u652 (copy)
            u652:Clean();
        end));
        u659:Play();
    end,

    Viki = function(p660: userdata, p661: any) -- Line: 5304
        -- upvalues: ReplicatedStorage (copy)
        local Viki = ReplicatedStorage.Assets.VFX.Emotes.Viki;
        local Character = p660.Character;
        local v662 = Character:FindFirstChildWhichIsA("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if not (HumanoidRootPart and v662) then
            return;
        end;

        local u663 = Viki.Dog:Clone();
        local Weld = Instance.new("Weld");
        Weld.Part0 = HumanoidRootPart;
        Weld.Part1 = u663.RootPart;
        Weld.C0 = CFrame.new();
        Weld.Parent = u663;
        u663.Parent = Character;
        local u664 = Viki.Ball:Clone();
        local Weld2 = Instance.new("Weld");
        Weld2.Part0 = HumanoidRootPart;
        Weld2.Part1 = u664.RootPart;
        Weld2.C0 = CFrame.new(0, -3, 0);
        Weld2.Parent = u664;
        u664.Parent = Character;
        p661:Add(function() -- Line: 5329
            -- upvalues: u663 (copy), u664 (copy)
            pcall(game.Destroy, u663);
            pcall(game.Destroy, u664);
        end);
        local u665 = v662:LoadAnimation(Viki.RigAnimation);
        u665.Priority = Enum.AnimationPriority.Action2;
        u665.Looped = true;
        local u666 = u663.AnimationController:LoadAnimation(Viki.DogAnimation);
        u666.Priority = Enum.AnimationPriority.Action2;
        u666.Looped = true;
        local u667 = u664.AnimationController:LoadAnimation(Viki.BallAnimation);
        u667.Priority = Enum.AnimationPriority.Action2;
        u667.Looped = true;
        p661:Add(function() -- Line: 5347
            -- upvalues: u665 (copy), u666 (copy), u667 (copy)
            u665:Stop();
            u666:Stop();
            u667:Stop();
        end);
        u665:Play();
        u667:Play();
        u666:Play();
    end,

    ["Cup of Tea"] = function(p668: userdata, u669: any) -- Line: 5362
        -- upvalues: ReplicatedStorage (copy)
        local v670 = ReplicatedStorage.Assets.VFX.Emotes["Cup of Tea"];
        local Character = p668.Character;
        local v671 = Character:FindFirstChildWhichIsA("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if not (HumanoidRootPart and v671) then
            return;
        end;

        local u672 = v670.Chair_Rig:Clone();
        local u673 = v670.Cup:Clone();
        local u674 = v670.ball:Clone();
        local v675 = v670.CupWeld:Clone();
        local v676 = v670.ChairWeld:Clone();
        local v677 = v670.BallWeld:Clone();
        v676.Part0 = HumanoidRootPart;
        v676.Part1 = u672.Chair;
        v676.Parent = u672;
        v675.Part0 = HumanoidRootPart;
        v675.Part1 = u673.RootPart;
        v675.Parent = u673;
        v677.Part0 = HumanoidRootPart;
        v677.Part1 = u674.RootPart;
        v677.Parent = u674;
        u672.Parent = Character;
        u673.Parent = Character;
        u674.Parent = Character;
        local u678 = v671:LoadAnimation(v670:FindFirstChild("RigAnimation"));
        u678.Priority = Enum.AnimationPriority.Action2;
        local v679 = u672.AnimationController:LoadAnimation(v670:FindFirstChild("ChairAnimation"));
        v679.Priority = Enum.AnimationPriority.Action2;
        local v680 = u673.AnimationController:LoadAnimation(v670:FindFirstChild("CupAnimation"));
        v680.Priority = Enum.AnimationPriority.Action2;
        local v681 = u674.AnimationController:LoadAnimation(v670:FindFirstChild("BallAnimation"));
        v681.Priority = Enum.AnimationPriority.Action2;
        u669:Add(function() -- Line: 5412
            -- upvalues: u672 (copy), u673 (copy), u674 (copy)
            pcall(game.Destroy, u672);
            pcall(game.Destroy, u673);
            pcall(game.Destroy, u674);
        end);
        u669:Add(function() -- Line: 5418
            -- upvalues: u678 (copy)
            u678:Stop();
        end);
        u669:Add(u678.Stopped:Once(function() -- Line: 5422
            -- upvalues: u669 (copy)
            u669:Clean();
        end));
        u669:Add(v679.Stopped:Once(function() -- Line: 5426
            -- upvalues: u672 (copy)
            print("Chair anim ended");
            pcall(game.Destroy, u672);
        end));
        u669:Add(v680.Stopped:Once(function() -- Line: 5431
            -- upvalues: u673 (copy)
            print("Cup anim ended");
            pcall(game.Destroy, u673);
        end));
        u669:Add(v681.Stopped:Once(function() -- Line: 5436
            -- upvalues: u674 (copy)
            print("Ball anim ended");
            pcall(game.Destroy, u674);
        end));
        u678:Play();
        v679:Play();
        v680:Play();
        v681:Play();
    end,

    ["Santa and Reindeers"] = function(p682, p683) -- Line: 5448
        -- upvalues: ReplicatedStorage (copy)
        local v684 = ReplicatedStorage.Assets.VFX.Emotes["Santa and Reindeers"];
        local Character = p682.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v685 = p683:Add(v684.Reindeers:Clone());
        v685.Parent = Character;
        v685.Handle.Part0 = HumanoidRootPart;
        local u686 = Humanoid:LoadAnimation(v684.CharacterAnimation);
        u686.Priority = Enum.AnimationPriority.Action3;
        u686:Play();
        local u687 = v685.AnimationController.Animator:LoadAnimation(v684.ReindeersAnimation);
        u687.Priority = Enum.AnimationPriority.Action3;
        u687:Play();
        p683:Add(function() -- Line: 5467
            -- upvalues: u686 (copy), u687 (copy)
            u686:Stop(0);
            u686:Destroy();
            u687:Stop(0);
            u687:Destroy();
        end);
    end,

    ["Card Flip"] = function(p688, u689) -- Line: 5475
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local Character = p688.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local Torso = Character:FindFirstChild("Torso");
        local u690 = u689:Add(ReplicatedStorage.Assets.VFX.Emotes["Card Flip"]:Clone());
        u690.Parent = Character;
        u690.Card.Handle.Part0 = HumanoidRootPart;
        u690.HugeCard.Handle.Part0 = HumanoidRootPart;
        u690.TorsoCard.Handle.Part0 = Torso;
        VfxManager.Enable(u690.ActualCard, true);
        u689:Add(task.delay(0.7666666666666667, function() -- Line: 5488
            -- upvalues: VfxManager (ref), u690 (copy)
            VfxManager.Emit(u690.ActualCard.Emit);
            VfxManager.Enable(u690.ActualCard, false);
            VfxManager.Enable(u690.HugeCard, true);
            u690.ActualCard.Transparency = 1;
            u690.HugeCard.Transparency = 0;
        end));
        u689:Add(task.delay(1.1833333333333333, function() -- Line: 5497
            -- upvalues: VfxManager (ref), u690 (copy)
            VfxManager.Enable(u690.HugeCard, false);
            VfxManager.Enable(u690.TorsoCard, true);
            u690.HugeCard.Transparency = 1;
            u690.TorsoCard.Transparency = 0;
        end));
        u689:Add(task.delay(3.1, function() -- Line: 5505
            -- upvalues: VfxManager (ref), u690 (copy)
            VfxManager.Enable(u690.HugeCard, true);
            VfxManager.Enable(u690.TorsoCard, false);
            u690.HugeCard.Transparency = 0;
            u690.TorsoCard.Transparency = 1;
        end));
        u689:Add(task.delay(3.433333333333333, function() -- Line: 5513
            -- upvalues: VfxManager (ref), u690 (copy)
            VfxManager.Emit(u690.HugeCard.Emit);
            VfxManager.Enable(u690.ActualCard, true);
            VfxManager.Enable(u690.HugeCard, false);
            u690.ActualCard.Transparency = 0;
            u690.HugeCard.Transparency = 1;
        end));
        u689:Add(task.delay(4.683333333333334, function() -- Line: 5522
            -- upvalues: VfxManager (ref), u690 (copy)
            VfxManager.Enable(u690.ActualCard, false);
            u690.ActualCard.Transparency = 1;
        end));
        u689:Add(task.delay(6.683333333333334, function() -- Line: 5528
            -- upvalues: u689 (copy)
            u689:Clean();
        end));
    end,

    ["Deck Of Cards"] = function(p691, u692) -- Line: 5533
        -- upvalues: ReplicatedStorage (copy)
        local Character = p691.Character;
        local v693 = Character:FindFirstChild("Right Arm");
        local v694 = u692:Add(ReplicatedStorage.Assets.VFX.Emotes["Deck Of Cards"]:Clone());
        v694.Parent = Character;
        v694.Handle.Part0 = v693;
        u692:Add(task.delay(9.833333333333334, function() -- Line: 5541
            -- upvalues: u692 (copy)
            u692:Clean();
        end));
    end,

    ["Chrollo Vs Tatlis"] = function(p695, p696) -- Line: 5546
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
        local v697 = ReplicatedStorage.Assets.VFX.Emotes["Chrollo Vs Tatlis"];
        local Character = p695.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v698 = p696:Add(v697["1320031"]:Clone());
        v698.Parent = Character;
        v698.Handle.Part0 = HumanoidRootPart;
        local v699 = p696:Add(v697["34341"]:Clone());
        v699.Parent = Character;
        v699.Handle.Part0 = HumanoidRootPart;
        local v700 = p696:Add(v697.Smoke1:Clone());
        v700.Parent = Character;
        v700.Weld.Part0 = HumanoidRootPart;
        local u701 = p696:Add(v697.Smoke2:Clone());
        u701.Parent = Character;
        u701.Weld.Part0 = HumanoidRootPart;
        VfxManager.Emit(v700);
        p696:Add(task.delay(5.283333333333333, function() -- Line: 5570
            -- upvalues: VfxManager (ref), u701 (copy)
            VfxManager.Emit(u701);
        end));
    end,

    ["Long Tongue"] = function(p702, p703) -- Line: 5575
        -- upvalues: ReplicatedStorage (copy)
        local Character = p702.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local Head = Character:FindFirstChild("Head");
        local v704 = p703:Add(ReplicatedStorage.Assets.VFX.Emotes["Long Tongue"]:Clone());
        v704.Parent = Character;
        v704.Handle.Part0 = HumanoidRootPart;
        p703:Add(v704.Attachment).Parent = Head;
    end,

    ["Toy Jet"] = function(p705, p706) -- Line: 5588
        -- upvalues: ReplicatedStorage (copy), RunService (copy), SfxManager (copy), VfxManager (copy)
        local Character = p705.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u707 = p706:Add(ReplicatedStorage.Assets.VFX.Emotes["Toy Jet"]:Clone());
        u707.Parent = Character;
        u707.Handle.Part0 = HumanoidRootPart;
        local u708 = nil;
        p706:Connect(RunService.Heartbeat, function() -- Line: 5597
            -- upvalues: u708 (ref), SfxManager (ref), u707 (copy), VfxManager (ref)
            if u708 and u708 - tick() >= 0 then
                return;
            end;

            u708 = tick() + 2.966666666666667;
            SfxManager:playSound({
                Sound = "Toy Jet",
                Parent = u707.PrimaryPart
            });
            task.wait(1.5);
            VfxManager.BetterEmit(u707);
        end);
    end,

    ["Playing Piano"] = function(p709, p710) -- Line: 5609
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), SfxManager (copy)
        local v711 = ReplicatedStorage.Assets.VFX.Emotes["Playing Piano"];
        local Character = p709.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v712 = p710:Add(v711.Piano:Clone());
        v712.Parent = Character;
        v712.Handle.Part0 = HumanoidRootPart;
        local v713 = p710:Add(v711.Aura:Clone());
        v713.Parent = Character;
        v713.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, -3.5);
        Essentials:Weld(v713, p709.Character.HumanoidRootPart);
        SfxManager:playSound({
            Sound = "Playing Piano",
            Parent = v712.PrimaryPart
        });
    end,

    ["Playing Guitar"] = function(p714, p715) -- Line: 5627
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), SfxManager (copy)
        local v716 = ReplicatedStorage.Assets.VFX.Emotes["Playing Guitar"];
        local Character = p714.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v717 = Character:FindFirstChild("Right Arm");
        local v718 = p715:Add(v716.Guitar:Clone());
        v718.Parent = Character;
        v718.Handle.Part0 = v717;
        local v719 = p715:Add(v716.Aura:Clone());
        v719.Parent = Character;
        v719.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v719, p714.Character.HumanoidRootPart);
        SfxManager:playSound({
            Sound = "Playing Guitar",
            Parent = v718.PrimaryPart
        });
    end,

    ["Playing Violin"] = function(p720, p721) -- Line: 5646
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), SfxManager (copy)
        local v722 = ReplicatedStorage.Assets.VFX.Emotes["Playing Violin"];
        local Character = p720.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v723 = Character:FindFirstChild("Right Arm");
        local v724 = Character:FindFirstChild("Left Arm");
        local v725 = p721:Add(v722.Violin:Clone());
        v725.Parent = Character;
        v725.Right.Part0 = v723;
        v725.Left.Part0 = v724;
        local v726 = p721:Add(v722.Aura:Clone());
        v726.Parent = Character;
        v726.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3.25, -0.5);
        Essentials:Weld(v726, p720.Character.HumanoidRootPart);
        SfxManager:playSound({
            Sound = "Playing Violin",
            Parent = v725.PrimaryPart
        });
    end,

    Sleepy = function(p727, u728) -- Line: 5667
        -- upvalues: ReplicatedStorage (copy)
        local Character = p727.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u729 = u728:Add(ReplicatedStorage.Assets.VFX.Emotes.Sleepy:Clone());
        u729.Parent = Character;
        u729.BlanketMotor6D.Part0 = HumanoidRootPart;
        u729.PillowMotor6D.Part0 = HumanoidRootPart;
        u729.HandMotor6D.Part0 = HumanoidRootPart;

        for _, child in u729:GetChildren() do
            if child:IsA("BasePart") then
                child.Transparency = 1;
            end;
        end;

        u728:Add(task.delay(0.25, function() -- Line: 5683
            -- upvalues: u729 (copy)
            for _, child in u729:GetChildren() do
                if child:IsA("BasePart") then
                    child.Transparency = 0;
                end;
            end;
        end));
        u728:Add(task.delay(15, function() -- Line: 5691
            -- upvalues: u728 (copy)
            u728:Clean();
        end));
    end,

    ["Whale Ride"] = function(p730, p731) -- Line: 5696
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy)
        local Character = p730.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v732 = p731:Add(ReplicatedStorage.Assets.VFX.Emotes["Whale Ride"]:Clone());
        v732.Parent = Character;
        v732.Handle.Part0 = HumanoidRootPart;
        SfxManager:playSound({
            Sound = "Whale Ride",
            Parent = v732.PrimaryPart
        });
    end,

    ["Rainbow Barf"] = function(p733, p734) -- Line: 5707
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
        local Character = p733.Character;
        local Head = Character:FindFirstChild("Head");
        local u735 = p734:Add(ReplicatedStorage.Assets.VFX.Emotes.RainbowBarf:Clone());
        u735.Parent = Character;
        u735:PivotTo(Head.CFrame);
        Essentials:Weld(u735, Head);
        p734:Add(task.delay(0.6, function() -- Line: 5716
            -- upvalues: VfxManager (ref), u735 (copy)
            VfxManager.Enable(u735, true);
        end));
        p734:Add(task.delay(2.933333333333333, function() -- Line: 5720
            -- upvalues: VfxManager (ref), u735 (copy)
            VfxManager.Enable(u735, false);
            VfxManager.DestroyEffect(u735, 4);
        end));
        SfxManager:playSound({
            Sound = "Rainbow Barf",
            Parent = u735
        });
    end,

    Ascend = function(p736, p737) -- Line: 5728
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
        local Character = p736.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u738 = p737:Add(ReplicatedStorage.Assets.VFX.Emotes.Ascend:Clone());
        u738.Parent = Character;
        u738.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
        Essentials:Weld(u738, HumanoidRootPart);
        VfxManager.BetterEmit(u738);
        p737:Add(task.delay(5.433333333333334, function() -- Line: 5739
            -- upvalues: VfxManager (ref), u738 (copy)
            VfxManager.Enable(u738, false);
            VfxManager.DestroyEffect(u738, 4);
        end));
        SfxManager:playSound({
            Sound = "Ascend",
            Parent = u738
        });
    end,

    ["Taking A Knee"] = function(p739, p740) -- Line: 5747
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
        local Character = p739.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u741 = p740:Add(ReplicatedStorage.Assets.VFX.Emotes["Taking A Kneel"]:Clone());
        u741.Parent = Character;
        u741.CFrame = HumanoidRootPart.CFrame * CFrame.new(-3, 3.75, -5) * CFrame.Angles(0, -1.5707963267948966, 0);
        Essentials:Weld(u741, HumanoidRootPart);
        p740:Add(task.delay(3.683333333333333, function() -- Line: 5756
            -- upvalues: VfxManager (ref), u741 (copy)
            VfxManager.Enable(u741, false);
            VfxManager.DestroyEffect(u741, 6);
        end));
        SfxManager:playSound({
            Sound = "Taking A Knee",
            Parent = u741
        });
    end,

    REF = function(u742: userdata, p743: any) -- Line: 5764
        -- upvalues: LocalPlayer (copy), Knit (copy)
        if u742 == LocalPlayer then
            return;
        end;

        local v744 = p743:Add(Instance.new("ProximityPrompt"));
        v744.ActionText = "Give Penalty";
        v744.RequiresLineOfSight = false;
        v744.Parent = u742.Character.HumanoidRootPart;
        v744.Triggered:Once(function() -- Line: 5774
            -- upvalues: Knit (ref), u742 (copy)
            Knit.GetService("CustomizationService"):StartDuoEmote(u742.Character);
        end);
    end,

    ["REF Duo"] = function(p745: userdata, p746: userdata, u747: any) -- Line: 5780
        -- upvalues: RunService (copy), LocalPlayer (copy), Knit (copy)
        if RunService:IsServer() then
            p746.Character.HumanoidRootPart.CFrame = p745.Character.HumanoidRootPart.CFrame;

            return;
        end;

        if LocalPlayer ~= p745 then
            if LocalPlayer == p746 then
                local u748 = Knit.GetController("AnimationController"):PlayChar("Emotes", "REFReceiver", Enum.AnimationPriority.Action2, true);
                u747:Add(function() -- Line: 5805
                    -- upvalues: u748 (copy)
                    u748:Stop(0);
                end);
            end;

            return;
        end;

        local u749 = Knit.GetController("AnimationController"):PlayChar("Emotes", "REFGiver", Enum.AnimationPriority.Action2, true);
        u747:Add(function() -- Line: 5788
            -- upvalues: u749 (copy)
            u749:Stop(0);
        end);
        u747:Add(u749.Ended:Once(function() -- Line: 5791
            -- upvalues: u747 (copy)
            u747:Clean();
        end));
        u747:Add(p745.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Once(function() -- Line: 5795
            -- upvalues: u747 (copy)
            u747:Clean();
        end));
        u747:Add(p746.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Once(function() -- Line: 5798
            -- upvalues: u747 (copy)
            u747:Clean();
        end));
    end,

    ["Romantic Dance"] = function(u750: userdata, p751: any) -- Line: 5812
        -- upvalues: LocalPlayer (copy), Knit (copy)
        if u750 == LocalPlayer then
            return;
        end;

        local v752 = p751:Add(Instance.new("ProximityPrompt"));
        v752.ActionText = "Dance with " .. u750.DisplayName;
        v752.RequiresLineOfSight = false;
        v752.Parent = u750.Character.HumanoidRootPart;
        v752.Triggered:Once(function() -- Line: 5822
            -- upvalues: Knit (ref), u750 (copy)
            Knit.GetService("CustomizationService"):StartDuoEmote(u750.Character);
        end);
    end,

    ["Romantic Dance Duo"] = function(u753: userdata, u754: userdata, u755: any) -- Line: 5828
        -- upvalues: RunService (copy), Knit (copy), ReplicatedStorage (copy), Essentials (copy), LocalPlayer (copy)
        local u756;

        if RunService:IsServer() then
            u756 = Knit.GetService("BallService");
        else
            u756 = Knit.GetController("BallController");
        end;

        u755:Add(RunService.Heartbeat:Connect(function() -- Line: 5831
            -- upvalues: u756 (copy), u753 (copy), u754 (copy), u755 (copy)
            local CharacterPossessingBall = u756:GetCharacterPossessingBall();

            if CharacterPossessingBall == u753.Character or CharacterPossessingBall == u754.Character then
                u755:Clean();
            end;
        end));

        if u753.Character:IsDescendantOf(workspace.Lobby.Limiteds) then
            u754.Character.HumanoidRootPart.CFrame = u753.Character.HumanoidRootPart.CFrame;

            for _, v in { u753.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("DuoDanceGiver")), u754.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild("DuoDanceReceiver")) } do
                v:Play();
            end;

            return;
        end;

        if RunService:IsServer() then
            for _, descendant in u754.Character:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant.Massless then
                    descendant.Massless = true;
                    u755:Add(function() -- Line: 5858
                        -- upvalues: descendant (copy)
                        descendant.Massless = false;
                    end);
                end;
            end;

            u754.Character.Humanoid.PlatformStand = true;
            u755:Add(function() -- Line: 5865
                -- upvalues: u754 (copy)
                u754.Character.Humanoid.PlatformStand = false;
            end);
            u754.Character.HumanoidRootPart.CFrame = u753.Character.HumanoidRootPart.CFrame;
            u755:Add(Essentials:Weld(u753.Character.HumanoidRootPart, u754.Character.HumanoidRootPart));

            return;
        end;

        if LocalPlayer ~= u753 then
            if LocalPlayer == u754 then
                local u757 = Knit.GetController("AnimationController"):PlayChar("Emotes", "DuoDanceReceiver", Enum.AnimationPriority.Action2, true);
                u755:Add(function() -- Line: 5892
                    -- upvalues: u757 (copy)
                    u757:Stop(0);
                end);
                u754.Character.Humanoid.PlatformStand = true;
                u755:Add(function() -- Line: 5897
                    -- upvalues: u754 (copy)
                    u754.Character.Humanoid.PlatformStand = false;
                end);
            end;

            return;
        end;

        local u758 = Knit.GetController("AnimationController"):PlayChar("Emotes", "DuoDanceGiver", Enum.AnimationPriority.Action2, true);
        u755:Add(function() -- Line: 5877
            -- upvalues: u758 (copy)
            u758:Stop(0);
        end);
        local CFrame2 = u753.Character.HumanoidRootPart.CFrame;
        u755:Add(u753.Character.HumanoidRootPart:GetPropertyChangedSignal("CFrame"):Once(function() -- Line: 5882
            -- upvalues: u753 (copy), CFrame2 (copy), u755 (copy)
            if (u753.Character.HumanoidRootPart.CFrame.Position - CFrame2.Position).Magnitude > 1 then
                u755:Clean();
            end;
        end));
    end,

    ["Horse Ride"] = function(p759, p760) -- Line: 5904
        -- upvalues: ReplicatedStorage (copy), RunService (copy)
        local v761 = ReplicatedStorage.Assets.VFX.Emotes["Horse Ride"];
        local Character = p759.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v762 = p760:Add(v761.Horse:Clone());
        v762.Parent = Character;
        v762.Handle.Part0 = HumanoidRootPart;
        local u763 = Humanoid:LoadAnimation(v761.Animation);
        u763.Priority = Enum.AnimationPriority.Action3;
        u763:Play();
        p760:Add(RunService.Heartbeat:Connect(function() -- Line: 5919
            -- upvalues: HumanoidRootPart (copy), u763 (copy)
            if math.floor((HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude) > 0 then
                if u763.IsPlaying then
                    return;
                end;

                u763:Play();

                return;
            end;

            if not u763.IsPlaying then
                return;
            end;

            u763:Stop();
        end));
        p760:Add(function() -- Line: 5929
            -- upvalues: u763 (copy)
            u763:Stop(0);
            u763:Destroy();
        end);
    end,

    ["Goat Aura"] = function(p764, p765) -- Line: 5935
        -- upvalues: ReplicatedStorage (copy)
        local Character = p764.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v766 = p765:Add(ReplicatedStorage.Assets.VFX.Emotes["Goat Aura"]:Clone());
        v766.Parent = Character;
        v766.Handle.Part0 = HumanoidRootPart;
    end,

    ["Bull Ride"] = function(p767, p768) -- Line: 5944
        -- upvalues: ReplicatedStorage (copy), RunService (copy)
        local v769 = ReplicatedStorage.Assets.VFX.Emotes["Bull Ride"];
        local Character = p767.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v770 = p768:Add(v769.Bull:Clone());
        v770.Parent = Character;
        v770.Handle.Part0 = HumanoidRootPart;
        local u771 = Humanoid:LoadAnimation(v769.Animation);
        u771.Priority = Enum.AnimationPriority.Action3;
        u771:Play();
        p768:Add(RunService.Heartbeat:Connect(function() -- Line: 5959
            -- upvalues: HumanoidRootPart (copy), u771 (copy)
            if math.floor((HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude) > 0 then
                if u771.IsPlaying then
                    return;
                end;

                u771:Play();

                return;
            end;

            if not u771.IsPlaying then
                return;
            end;

            u771:Stop();
        end));
        p768:Add(function() -- Line: 5969
            -- upvalues: u771 (copy)
            u771:Stop(0);
            u771:Destroy();
        end);
    end,

    ["Hawk Pal"] = function(p772, p773) -- Line: 5975
        -- upvalues: ReplicatedStorage (copy), RunService (copy)
        local v774 = ReplicatedStorage.Assets.VFX.Emotes["Hawk Pal"];
        local Character = p772.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local BALL = Character:FindFirstChild("BALL", true);
        local v775 = p773:Add(v774.Hawk:Clone());
        v775.Parent = Character;
        v775.Handle.Part0 = HumanoidRootPart;
        v775.AnimationController:LoadAnimation(v774.HawkAnimation):Play();
        local u776 = Humanoid:LoadAnimation(v774.CharacterAnimation);
        u776.Priority = Enum.AnimationPriority.Action3;
        u776:Play();
        p773:Add(RunService.Heartbeat:Connect(function() -- Line: 5992
            -- upvalues: BALL (copy), HumanoidRootPart (copy), u776 (copy)
            if BALL and BALL.Transparency == 0 or math.floor((HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude) > 0 then
                if not u776.IsPlaying then
                    return;
                end;

                u776:Stop(0.25);

                return;
            end;

            if u776.IsPlaying then
                return;
            end;

            u776:Play(0.25);
        end));
        p773:Add(function() -- Line: 6002
            -- upvalues: u776 (copy)
            u776:Stop(0);
            u776:Destroy();
        end);
    end,

    Lean = function(p777, p778) -- Line: 6008
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), SfxManager (copy)
        local Character = p777.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v779 = p778:Add(ReplicatedStorage.Assets.VFX.Emotes.Lean:Clone());
        v779.Parent = Character;
        v779.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0.5, 0);
        Essentials:Weld(v779, HumanoidRootPart);
        p778:Add(SfxManager:playSound({
            Sound = "Lean",
            Parent = HumanoidRootPart
        }));
    end,

    ["Hee Hee"] = function(p780, p781) -- Line: 6020
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), SfxManager (copy)
        local Character = p780.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u782 = Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations["Hee Hee"]);
        u782.Priority = Enum.AnimationPriority.Action3;
        u782.Looped = true;
        u782:Play();
        p781:Add(function() -- Line: 6030
            -- upvalues: u782 (copy)
            u782:Stop();
        end);
        p781:Connect(u782:GetMarkerReachedSignal("Emit"), function() -- Line: 6034
            -- upvalues: ReplicatedStorage (ref), Character (copy), HumanoidRootPart (copy), VfxManager (ref), SfxManager (ref)
            local v783 = ReplicatedStorage.Assets.VFX.Emotes.HeeHee:Clone();
            v783.Parent = Character;
            v783.Weld.Part0 = HumanoidRootPart;
            VfxManager.Emit(v783);
            VfxManager.DestroyEffect(v783, 4);
            SfxManager:playSound({
                Sound = "Hee Hee Emote",
                Parent = v783
            });
        end);
    end,

    Moonwalk = function(p784, p785) -- Line: 6045
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), SfxManager (copy)
        local Character = p784.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v786 = Character:FindFirstChild("Right Leg");
        local v787 = Character:FindFirstChild("Left Leg");
        local v788 = p785:Add(ReplicatedStorage.Assets.VFX.Emotes.Moonwalk:Clone());
        v788.Parent = v786;
        v788.CFrame = v786.CFrame * CFrame.new(0, -1, 0);
        Essentials:Weld(v788, v786);
        local v789 = p785:Add(ReplicatedStorage.Assets.VFX.Emotes.Moonwalk:Clone());
        v789.Parent = v787;
        v789.CFrame = v787.CFrame * CFrame.new(0, -1, 0);
        Essentials:Weld(v789, v787);
        p785:Add(SfxManager:playSound({
            Sound = "Moonwalk",
            Parent = HumanoidRootPart
        }));
    end,

    ["Happy Birthday"] = function(p790, u791) -- Line: 6064
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy)
        local v792 = ReplicatedStorage.Assets.VFX.Emotes["Happy Birthday"];
        local Character = p790.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u793 = u791:Add(v792.Table:Clone());
        u793.Parent = Character;
        u793.Handle.Part0 = HumanoidRootPart;
        u793.AnimationController.Animator:LoadAnimation(v792.TableAnimation):Play();
        local u794 = u791:Add(v792.Cake:Clone());
        u794.Parent = Character;
        u794.Handle.Part0 = HumanoidRootPart;
        local v795 = u794.AnimationController.Animator:LoadAnimation(v792.CakeAnimation);
        v795:Play();
        u791:Connect(v795:GetMarkerReachedSignal("Start"), function() -- Line: 6082
            -- upvalues: u794 (copy), u793 (copy), u791 (copy), SfxManager (ref), HumanoidRootPart (copy)
            for _, child in u794:GetChildren() do
                if child:IsA("MeshPart") then
                    child.Transparency = 0;
                end;
            end;

            for _, child in u793:GetChildren() do
                if child:IsA("MeshPart") then
                    child.Transparency = 0;
                end;
            end;

            u791:Add(task.delay(10.933333333333334, function() -- Line: 6095
                -- upvalues: u794 (ref), u793 (ref)
                for _, child in u794:GetChildren() do
                    if child:IsA("MeshPart") then
                        child.Transparency = 1;
                    end;
                end;

                for _, child in u793:GetChildren() do
                    if child:IsA("MeshPart") then
                        child.Transparency = 1;
                    end;
                end;
            end));
            u791:Add(SfxManager:playSound({
                Sound = "Happy Birthday",
                Parent = HumanoidRootPart
            }));
        end);
    end,

    ["Alien Invasion"] = function(p796, u797) -- Line: 6113
        -- upvalues: ReplicatedStorage (copy), Part_Icles (copy), SfxManager (copy)
        local v798 = ReplicatedStorage.Assets.VFX.Emotes["Alien Invasion"];
        local Character = p796.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u799 = u797:Add(v798.UFO:Clone());
        u799.Handle.Part0 = HumanoidRootPart;
        u799.Parent = Character;
        local v800 = u799.AnimationController.Animator:LoadAnimation(v798.Animation);
        v800:Play();
        u797:Connect(v800:GetMarkerReachedSignal("Start"), function() -- Line: 6126
            -- upvalues: u797 (copy), Part_Icles (ref), u799 (copy), SfxManager (ref), HumanoidRootPart (copy)
            u797:Add(task.delay(2.75, function() -- Line: 6127
                -- upvalues: Part_Icles (ref), u799 (ref)
                Part_Icles:AbsoluteEmit(u799);
            end));
            u797:Add(SfxManager:playSound({
                Sound = "Alien Invasion",
                Parent = HumanoidRootPart
            }));
        end);
    end,

    Sunshine = function(p801, p802) -- Line: 6135
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
        local Sunshine = ReplicatedStorage.Assets.VFX.Emotes.Sunshine;
        local Character = p801.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v803 = p802:Add(Sunshine.Root:Clone());
        v803.Parent = workspace.Debris;
        v803.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v803, HumanoidRootPart);
        VfxManager.Enable(v803, true);
        local u804 = Humanoid:LoadAnimation(Sunshine.Animation);
        u804.Priority = Enum.AnimationPriority.Action3;
        u804:Play();
        p802:Add(function() -- Line: 6152
            -- upvalues: u804 (copy)
            u804:Stop();
        end);
        p802:Connect(u804:GetMarkerReachedSignal("Stop"), function() -- Line: 6156
            -- upvalues: u804 (copy)
            u804:AdjustSpeed(0);
        end);
        SfxManager:playSound({
            Sound = "Sunshine",
            Parent = v803
        });
    end,

    Fem = function(p805, u806) -- Line: 6163
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
        local Fem = ReplicatedStorage.Assets.VFX.Emotes.Fem;
        local Character = p805.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v807 = u806:Add(Fem.Enable:Clone());
        v807.Parent = workspace.Debris;
        v807.Root.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v807.Root, HumanoidRootPart);
        VfxManager.Enable(v807, true);
        local u808 = u806:Add(Fem.Emit:Clone());
        u808.Parent = workspace.Debris;
        u808.Root.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(u808.Root, HumanoidRootPart);
        local u809 = Humanoid:LoadAnimation(Fem.Animation);
        u809.Priority = Enum.AnimationPriority.Action2;
        u809:Play();
        u806:Add(function() -- Line: 6185
            -- upvalues: u809 (copy)
            u809:Stop();
        end);
        u806:Connect(u809:GetMarkerReachedSignal("Start"), function() -- Line: 6189
            -- upvalues: VfxManager (ref), u808 (copy), u806 (copy)
            VfxManager.BetterEmit(u808);
            u806:Add(task.delay(0.38333333333333336, function() -- Line: 6192
                -- upvalues: VfxManager (ref), u808 (ref)
                VfxManager.BetterEmit(u808);
            end));
            u806:Add(task.delay(0.7833333333333333, function() -- Line: 6196
                -- upvalues: VfxManager (ref), u808 (ref)
                VfxManager.BetterEmit(u808);
            end));
            u806:Add(task.delay(1.2333333333333334, function() -- Line: 6200
                -- upvalues: VfxManager (ref), u808 (ref)
                VfxManager.BetterEmit(u808);
            end));
            u806:Add(task.delay(1.6333333333333333, function() -- Line: 6204
                -- upvalues: VfxManager (ref), u808 (ref)
                VfxManager.BetterEmit(u808);
            end));
        end);
        u806:Add(SfxManager:playSound({
            Sound = "Fem",
            Parent = HumanoidRootPart
        }));
    end,

    ["Can\'t Laugh"] = function(p810, p811) -- Line: 6212
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
        local HumanoidRootPart = p810.Character:FindFirstChild("HumanoidRootPart");
        local v812 = p811:Add(ReplicatedStorage.Assets.VFX.Emotes["Can\'t Laugh"]:Clone());
        v812.Parent = workspace.Debris;
        v812.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v812, HumanoidRootPart);
        VfxManager.Enable(v812, true);
        SfxManager:playSound({
            Sound = "Can\'t Laugh",
            Parent = v812
        });
    end,

    ["Glitchy Moves"] = function(p813, p814) -- Line: 6225
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local HumanoidRootPart = p813.Character:FindFirstChild("HumanoidRootPart");
        local v815 = p814:Add(ReplicatedStorage.Assets.VFX.Emotes["Glitchy Moves"]:Clone());
        v815.Parent = workspace.Debris;
        v815.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v815, HumanoidRootPart);
    end,

    ["Death Book"] = function(p816, p817) -- Line: 6235
        -- upvalues: ReplicatedStorage (copy)
        local DeathBook = ReplicatedStorage.Assets.VFX.Emotes.DeathBook;
        local Character = p816.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v818 = p817:Add(DeathBook.Book:Clone());
        v818.Parent = Character;
        v818.Handle.Part0 = HumanoidRootPart;
        local v819 = p817:Add(DeathBook.Pen:Clone());
        v819.Parent = Character;
        v819.Handle.Part0 = HumanoidRootPart;
        local u820 = Humanoid:LoadAnimation(DeathBook.RigAnimation);
        u820.Priority = Enum.AnimationPriority.Action2;
        local u821 = Humanoid:LoadAnimation(DeathBook.BookAnimation);
        u821.Priority = Enum.AnimationPriority.Action2;
        local u822 = Humanoid:LoadAnimation(DeathBook.PenAnimation);
        u822.Priority = Enum.AnimationPriority.Action2;
        p817:Add(function() -- Line: 6259
            -- upvalues: u820 (copy), u821 (copy), u822 (copy)
            u820:Stop();
            u821:Stop();
            u822:Stop();
        end);
        u820:Play();
        u821:Play();
        u822:Play();
    end,

    ["Power Up"] = function(p823, p824) -- Line: 6270
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), SfxManager (copy), TweenService (copy)
        local Character = p823.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if workspace.Debris:FindFirstChild(Character.Name .. "Power Up Aura") then
            workspace.Debris:FindFirstChild(Character.Name .. "Power Up Aura"):Destroy();
        end;

        local u825 = ReplicatedStorage.Assets.VFX.Emotes.PowerUp:Clone();
        u825.Name = Character.Name .. "Power Up Aura";
        u825.Parent = workspace.Debris;
        u825.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(u825, HumanoidRootPart);
        VfxManager.DestroyEffect(u825, 12);
        shared.vfx.emit(u825);
        local u826 = nil;
        p824:Add(function() -- Line: 6288
            -- upvalues: u826 (ref), u825 (copy)
            if not u826 then
                u825:Destroy();
            end;
        end);
        SfxManager:playSound({
            Sound = "Power Up",
            Parent = u825
        });
        local u827 = p824:Add(Instance.new("Highlight", Character));
        u827.DepthMode = Enum.HighlightDepthMode.Occluded;
        u827.FillColor = Color3.fromRGB(0, 0, 0);
        u827.OutlineColor = Color3.fromRGB(255, 255, 255);
        u827.OutlineTransparency = 0.3;
        u827.FillTransparency = 1;
        TweenService:Create(u827, TweenInfo.new(0.8333333333333334), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
        p824:Add(task.delay(0.9833333333333333, function() -- Line: 6304
            -- upvalues: u826 (ref), u827 (copy), TweenService (ref)
            u826 = true;
            u827.OutlineColor = Color3.fromRGB(255, 255, 255);
            u827.FillTransparency = 0;
            TweenService:Create(u827, TweenInfo.new(1), {
                FillTransparency = 1,
                OutlineColor = Color3.fromRGB(0, 0, 0)
            }):Play();
        end));
    end,

    ["Horse Relaxing"] = function(p828, p829) -- Line: 6313
        -- upvalues: ReplicatedStorage (copy)
        local v830 = ReplicatedStorage.Assets.VFX.Emotes["Horse Relaxing"];
        local Character = p828.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v831 = p829:Add(v830.Horse:Clone());
        v831.Parent = Character;
        v831.Handle.Part0 = HumanoidRootPart;
    end,

    Arrow = function(p832: userdata, p833: any) -- Line: 6324
        -- upvalues: ReplicatedStorage (copy)
        local v834 = p833:Add(ReplicatedStorage.Assets.VFX.Emotes.Arrow:Clone());
        v834.Parent = p832.Character;
        v834.Handle.Part0 = p832.Character.HumanoidRootPart;
        local v835 = p833:Add(Instance.new("Animation"));
        v835.AnimationId = "rbxassetid://74183459816799";
        v835.Parent = workspace;
        local u836 = p832.Character.Humanoid.Animator:LoadAnimation(v835);
        u836.Priority = Enum.AnimationPriority.Action2;
        p833:Add(function() -- Line: 6336
            -- upvalues: u836 (copy)
            u836:Stop(0);
            u836:Destroy();
        end);
        local EQUIPPED_COSMETIC = p832.Character:FindFirstChild("EQUIPPED_COSMETIC");

        if EQUIPPED_COSMETIC and EQUIPPED_COSMETIC:GetAttribute("IsArrow") then
            EQUIPPED_COSMETIC.Handle.Transparency = 1;
            p833:Add(function() -- Line: 6346
                -- upvalues: EQUIPPED_COSMETIC (copy)
                EQUIPPED_COSMETIC.Handle.Transparency = 0;
            end);
        end;

        p833:Add(task.delay(0.85, function() -- Line: 6351
            -- upvalues: u836 (copy)
            u836:Play();
        end));
    end,

    ["Moon Pose"] = function(p837, p838) -- Line: 6356
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local v839 = ReplicatedStorage.Assets.VFX.Emotes["Moon Pose"];
        local v840 = p838:Add(Instance.new("Model"));
        v840.Parent = workspace.Debris;

        for _, child in v839:GetChildren() do
            local v841 = p837.Character:FindFirstChild(child.Name);

            if v841 then
                local v842 = child:Clone();
                v842.Parent = v840;
                v842.CFrame = v841.CFrame;
                Essentials:Weld(v842, v841);
            end;
        end;
    end,

    ["Frog Ride"] = function(p843, p844) -- Line: 6373
        -- upvalues: ReplicatedStorage (copy), RunService (copy), TweenService (copy), SfxManager (copy)
        local v845 = ReplicatedStorage.Assets.VFX.Emotes["Frog Ride"];
        local u846 = {};
        local Character = p843.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u847 = p844:Add(v845.Frog:Clone());
        u847.Parent = Character;
        u847.Handle.Part0 = HumanoidRootPart;
        local u848 = Humanoid:LoadAnimation(v845.Animation);
        u848.Priority = Enum.AnimationPriority.Action3;
        u848:Play();
        p844:Add(RunService.Heartbeat:Connect(function() -- Line: 6390
            -- upvalues: HumanoidRootPart (copy), u848 (copy), u846 (copy), TweenService (ref)
            if math.floor((HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude) > 0 then
                if u848.IsPlaying then
                    return;
                end;

                u848:Play();

                return;
            end;

            if not u848.IsPlaying then
                return;
            end;

            u848:Stop();

            for _, v in u846 do
                TweenService:Create(v, TweenInfo.new(0.1), {
                    Volume = 0
                }):Play();
            end;
        end));
        p844:Connect(u848:GetMarkerReachedSignal("Start"), function() -- Line: 6404
            -- upvalues: SfxManager (ref), u847 (copy), u846 (copy)
            local v849 = SfxManager:playSound({
                Sound = "Frog Ride",
                Parent = u847.PrimaryPart
            });
            table.insert(u846, v849);
        end);
        p844:Add(function() -- Line: 6409
            -- upvalues: u848 (copy)
            u848:Stop(0);
            u848:Destroy();
        end);
    end,

    ["Chakra Sphere"] = function(p850, p851) -- Line: 6415
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local Character = p850.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u852 = p851:Add(ReplicatedStorage.Assets.VFX.Emotes["Chakra Sphere"]:Clone());
        u852.Parent = workspace.Debris;
        u852.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.05, 1.15, -1.825);
        Essentials:Weld(u852, HumanoidRootPart);
        p851:Add(task.delay(0.36666666666666664, function() -- Line: 6425
            -- upvalues: u852 (copy), VfxManager (ref)
            shared.vfx.emit(u852);
            VfxManager.Enable(u852, true);
            VfxManager.Enable(u852.Bottom, false);
        end));
        local u853 = Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations["Chakra Sphere"]);
        u853.Priority = Enum.AnimationPriority.Action3;
        u853:Play();
        p851:Add(task.delay(1.0166666666666666, function() -- Line: 6436
            -- upvalues: u853 (copy)
            u853.TimePosition = 1.0166666666666666;
            u853:AdjustSpeed(0);
        end));
        p851:Add(function() -- Line: 6441
            -- upvalues: u853 (copy)
            u853:Stop(0);
            u853:Destroy();
        end);
    end,

    ["Zombie Walk"] = function(p854, p855) -- Line: 6447
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), SfxManager (copy)
        local v856 = ReplicatedStorage.Assets.VFX.Emotes["Zombie Walk"];
        local Character = p854.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        for _, child in v856:GetChildren() do
            local v857 = Character:FindFirstChild(child.Name);

            if v857 then
                local v858 = p855:Add(child:Clone());
                v858.Parent = workspace.Debris;
                v858.CFrame = v857.CFrame;
                Essentials:Weld(v858, v857);
            end;
        end;

        local v859 = p855:Add(v856.Bites:Clone());
        v859.Parent = workspace.Debris;
        v859.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
        Essentials:Weld(v859, HumanoidRootPart);
        p855:Add(SfxManager:playSound({
            Sound = "Zombie Walk",
            Parent = HumanoidRootPart
        }));
    end,

    ["Bat Aura"] = function(p860, p861) -- Line: 6471
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local HumanoidRootPart = p860.Character:FindFirstChild("HumanoidRootPart");
        local v862 = p861:Add(ReplicatedStorage.Assets.VFX.Emotes["Bat Aura"]:Clone());
        v862.Parent = workspace.Debris;
        v862.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v862, HumanoidRootPart);
    end,

    ["Bat Wings"] = function(p863, p864) -- Line: 6481
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy)
        local v865 = ReplicatedStorage.Assets.VFX.Emotes["Bat Wings"]:Clone();
        local Torso = p863.Character:FindFirstChild("Torso");
        local v866 = p864:Add(v865["Bat Wings"]:Clone());
        v866.Parent = workspace.Debris;
        v866.Handle.Part0 = Torso;
        v866.AnimationController.Animator:LoadAnimation(v865.Animation):Play();
        p864:Add(SfxManager:playSound({
            Sound = "Bat Wings",
            Parent = v866
        }));
    end,

    ["Werewolf Howl"] = function(p867, p868) -- Line: 6495
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
        local Head = p867.Character:FindFirstChild("Head");
        local u869 = ReplicatedStorage.Assets.VFX.Emotes["Werewolf Howl"]:Clone();
        p868:Add(function() -- Line: 6501
            -- upvalues: u869 (ref)
            if u869 then
                u869:Destroy();
            end;
        end);
        u869.Parent = workspace.Debris;
        u869.CFrame = Head.CFrame;
        Essentials:Weld(u869, Head);
        p868:Add(task.delay(0.48333333333333334, function() -- Line: 6511
            -- upvalues: VfxManager (ref), u869 (ref)
            VfxManager.Enable(u869, true);
        end));
        p868:Add(task.delay(1.3166666666666667, function() -- Line: 6515
            -- upvalues: VfxManager (ref), u869 (ref)
            VfxManager.Enable(u869, false);
            VfxManager.DestroyEffect(u869, 2);
            u869 = nil;
        end));
        SfxManager:playSound({
            Sound = "Werewolf Howl",
            Parent = u869
        });
    end,

    Coffin = function(p870, u871) -- Line: 6524
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), SfxManager (copy)
        local Character = p870.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u872 = u871:Add(ReplicatedStorage.Assets.VFX.Emotes.Coffin:Clone());
        u872.Parent = Character;
        u872.Handle.Part0 = HumanoidRootPart;
        u871:Add(task.delay(0.45, function() -- Line: 6532
            -- upvalues: VfxManager (ref), u872 (copy)
            VfxManager.Emit(u872.Slam);
        end));
        u871:Add(task.delay(1.7833333333333334, function() -- Line: 6536
            -- upvalues: VfxManager (ref), u872 (copy)
            VfxManager.Emit(u872.Enter);
        end));
        u871:Add(task.delay(2.35, function() -- Line: 6540
            -- upvalues: VfxManager (ref), u872 (copy)
            VfxManager.Emit(u872.Close);
        end));
        u871:Add(task.delay(4.666666666666667, function() -- Line: 6544
            -- upvalues: u871 (copy)
            u871:Clean();
        end));
        SfxManager:playSound({
            Sound = "Coffin",
            Parent = u872
        });
    end,

    ["Witch\'s Broom"] = function(p873, p874) -- Line: 6551
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy)
        local v875 = p873.Character:FindFirstChild("Right Arm");
        local v876 = p874:Add(ReplicatedStorage.Assets.VFX.Emotes["Witch\'s Broom"]:Clone());
        v876.Parent = workspace.Debris;
        v876.Handle.Part0 = v875;
        SfxManager:playSound({
            Sound = "Witch\'s Broom",
            Parent = v876
        });
    end,

    ["S6 Iron Badge"] = function(p877, p878) -- Line: 6563
        -- upvalues: ReplicatedStorage (copy), SetupRankedBadge (copy)
        SetupRankedBadge(p877.Character, ReplicatedStorage.Assets.VFX.Emotes["S6 Iron Badge"], p878);
    end,

    ["S6 Bronze Badge"] = function(p879, p880) -- Line: 6568
        -- upvalues: ReplicatedStorage (copy), SetupRankedBadge (copy)
        SetupRankedBadge(p879.Character, ReplicatedStorage.Assets.VFX.Emotes["S6 Bronze Badge"], p880);
    end,

    ["S6 Silver Badge"] = function(p881, p882) -- Line: 6573
        -- upvalues: ReplicatedStorage (copy), SetupRankedBadge (copy)
        SetupRankedBadge(p881.Character, ReplicatedStorage.Assets.VFX.Emotes["S6 Silver Badge"], p882);
    end,

    ["S6 Gold Badge"] = function(p883, p884) -- Line: 6578
        -- upvalues: ReplicatedStorage (copy), SetupRankedBadge (copy)
        SetupRankedBadge(p883.Character, ReplicatedStorage.Assets.VFX.Emotes["S6 Gold Badge"], p884);
    end,

    ["S6 Platinum Badge"] = function(p885, p886) -- Line: 6583
        -- upvalues: ReplicatedStorage (copy), SetupRankedBadge (copy)
        SetupRankedBadge(p885.Character, ReplicatedStorage.Assets.VFX.Emotes["S6 Platinum Badge"], p886);
    end,

    ["S6 Diamond Badge"] = function(p887, p888) -- Line: 6588
        -- upvalues: ReplicatedStorage (copy), SetupRankedBadge (copy)
        SetupRankedBadge(p887.Character, ReplicatedStorage.Assets.VFX.Emotes["S6 Diamond Badge"], p888);
    end,

    ["S6 Master Badge"] = function(p889, p890) -- Line: 6593
        -- upvalues: ReplicatedStorage (copy), SetupRankedBadge (copy)
        SetupRankedBadge(p889.Character, ReplicatedStorage.Assets.VFX.Emotes["S6 Master Badge"], p890);
    end,

    ["S6 Champion Badge"] = function(p891, p892) -- Line: 6598
        -- upvalues: ReplicatedStorage (copy), SetupRankedBadge (copy)
        SetupRankedBadge(p891.Character, ReplicatedStorage.Assets.VFX.Emotes["S6 Champion Badge"], p892);
    end,

    ["S6 Legend Badge"] = function(p893, p894) -- Line: 6603
        -- upvalues: ReplicatedStorage (copy), SetupRankedBadge (copy)
        SetupRankedBadge(p893.Character, ReplicatedStorage.Assets.VFX.Emotes["S6 Legend Badge"], p894);
    end,

    ["Cursed Valentine"] = function(u895: userdata) -- Line: 6609
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Trove2 (copy)
        local v896 = ReplicatedStorage.Assets.VFX.Emotes["Cursed Valentine"];
        local Character = u895.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v897 = v896.CamRig:Clone();
            v897.Name = "CamRig";
            v897.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.747, 0);
            v897.Parent = workspace;
            local v898 = v896.D4C:Clone();
            v898.Name = Character.Name .. "D4C";
            v898.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
            v898.Parent = workspace;
            local v899 = { v897.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINECamera), u895.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINEPlayer), v898.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINEStand) };
            workspace:GetServerTimeNow();

            while v899[1].Length < 1 do
                task.wait();
            end;

            for _, v in v899 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes["Cursed Valentine"]), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            local v900 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(4.883, nil, v900);
            task.wait(v899[1].Length);
            task.spawn(require(ReplicatedStorage.Effects.Emotes["Cursed Valentine"]), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            v900:Destroy();
            v897:Destroy();
            v898:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(4.883);
        Service2:ChangeValue(Character, "DribblingTick", tick() + 4.883);

        for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u901 = v896.CamRig:Clone();
        u901.Name = "CamRig";
        u901.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.747, 0);
        u901.Parent = workspace;
        local u902 = v896.D4C:Clone();
        u902.Name = Character.Name .. "D4C";
        u902.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
        u902.Parent = workspace;
        task.spawn(function() -- Line: 6641
            -- upvalues: u901 (copy), HumanoidRootPart (copy), u902 (copy)
            for i = 1, 100 do
                u901.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.747, 0);
                u902.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v903 = { u901.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINECamera), u895.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINEPlayer), u902.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.VALENTINEStand) };
        workspace:GetServerTimeNow();

        while v903[1].Length < 1 do
            task.wait();
        end;

        for _, v in v903 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Cursed Valentine"], {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        Service.Client.Cutscene:FireAll(u895, 4.883);
        task.delay(v903[1].Length, function() -- Line: 6674
            -- upvalues: u901 (copy), u902 (copy), ReplicatedStorage (ref), Character (copy), u895 (copy)
            u901:Destroy();
            u902:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Cursed Valentine"], {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            u895:SetAttribute("PlayingEmote", nil);
        end);
    end,

    ["Shadow Eye Battle"] = function(u904: userdata) -- Line: 6738
        -- upvalues: ReplicatedStorage (copy), RunService (copy), Knit (copy), Essentials (copy), Trove2 (copy)
        local v905 = ReplicatedStorage.Assets.VFX.Emotes["Shadow Eye Battle"];
        local Character = u904.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;

        for _, v in Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        if not RunService:IsServer() then
            local v906 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
            v906.HumanoidRootPart.Anchored = true;
            v906.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
            v906.Parent = workspace.Debris;
            local v907 = v905.CamRig:Clone();
            v907.Name = "CamRig";
            v907.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
            v907.Parent = workspace;
            local v908 = { v907.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattleCamera), u904.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattlePlayer0), v906.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattlePlayer1) };
            workspace:GetServerTimeNow();

            while v908[1].Length < 1 do
                task.wait();
            end;

            for _, v in v908 do
                v.Priority = Enum.AnimationPriority.Action4;
                v.Looped = false;
                v:Play(0);
            end;

            task.spawn(require(ReplicatedStorage.Effects.Emotes["Shadow Eye Battle"]), Knit.GetController("EffectController"), {
                Task = "Cutscene",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            local v909 = Trove2.new();
            Knit.GetController("CameraController"):PlayCutscene(5, nil, v909);
            task.wait(v908[1].Length);
            task.spawn(require(ReplicatedStorage.Effects.Emotes["Shadow Eye Battle"]), Knit.GetController("EffectController"), {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            v909:Destroy();
            v907:Destroy();
            v906:Destroy();

            return;
        end;

        local Service = Knit.GetService("AbilityService");
        local Service2 = Knit.GetService("StatsService");
        Knit.GetService("BallService"):ActivateBallIFrame(5);
        Service2:ChangeValue(Character, "DribblingTick", tick() + 5);
        local v910 = nil;
        local u911 = nil;

        for _, v in game.Teams[Essentials:ActualTeam(u904.Team.Name)]:GetPlayers() do
            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and v ~= u904) then
                local Magnitude = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

                if not v910 or Magnitude < v910 then
                    u911 = v.Character;
                    v910 = Magnitude;
                end;
            end;
        end;

        if u911 then
            for _, v in u911.Humanoid.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            for _, v in u911.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;
        end;

        if not u911 then
            u911 = ReplicatedStorage.Assets.Misc.TemplateRigChrollo:Clone();
            u911.HumanoidRootPart.Anchored = true;
            u911.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
            u911.Parent = workspace.Debris;
            task.delay(5, function() -- Line: 6786
                -- upvalues: u911 (ref)
                u911:Destroy();
            end);
        end;

        for _, v in Character.PlrBall.Anims.AnimationController.Animator:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local u912 = v905.CamRig:Clone();
        u912.Name = "CamRig";
        u912.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
        u912.Parent = workspace;
        task.spawn(function() -- Line: 6800
            -- upvalues: u912 (copy), HumanoidRootPart (copy), u911 (ref)
            for i = 1, 100 do
                u912.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                u911.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
                task.wait(0.01);
                local _ = i;
            end;
        end);
        local v913 = { u912.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattleCamera), u904.Character.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattlePlayer0), u911.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations.EyeBattlePlayer1) };
        workspace:GetServerTimeNow();

        while v913[1].Length < 1 do
            task.wait();
        end;

        for _, v in v913 do
            v.Priority = Enum.AnimationPriority.Action4;
            v.Looped = false;
            v:Play(0);
        end;

        ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Shadow Eye Battle"], {
            Task = "Cutscene",
            TimeSent = workspace:GetServerTimeNow(),
            Character = Character
        });
        Service.Client.Cutscene:FireAll(u904, 5);
        task.delay(v913[1].Length, function() -- Line: 6833
            -- upvalues: u912 (copy), ReplicatedStorage (ref), Character (copy), u904 (copy)
            u912:Destroy();
            ReplicatedStorage.Remotes.VFX:FireAllClients(ReplicatedStorage.Effects.Emotes["Shadow Eye Battle"], {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow(),
                Character = Character
            });
            u904:SetAttribute("PlayingEmote", nil);
        end);
    end,

    ["Low Cortisol"] = function(p914, p915) -- Line: 6896
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy)
        local v916 = ReplicatedStorage.Assets.VFX.Emotes["Low Cortisol"];
        p915:Add(SfxManager:playSound({
            Sound = "Low Cortisol",
            Parent = p914.Character:FindFirstChild("HumanoidRootPart")
        }));
        p915:Add(v916.Overhead:Clone()).Parent = p914.Character.Head;
    end,

    Looping = function(p917, p918) -- Line: 6908
        -- upvalues: Essentials (copy), VfxManager (copy), SfxManager (copy)
        local Character = p917.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u919 = true;
        p918:Add(function() -- Line: 6913
            -- upvalues: u919 (ref)
            u919 = nil;
        end);
        task.spawn(function() -- Line: 6917
            -- upvalues: Essentials (ref), Character (copy), VfxManager (ref), u919 (ref)
            repeat
                task.wait(0.1);
                local v920 = Essentials:CreateClone(Character);
                VfxManager.DestroyEffect(v920, 1);
            until not (u919 and Character.Parent);
        end);
        p918:Add(SfxManager:playSound({
            Sound = "Looping",
            Parent = HumanoidRootPart
        }));
    end,

    Floating = function(p921, p922) -- Line: 6927
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
        local HumanoidRootPart = p921.Character:FindFirstChild("HumanoidRootPart");
        local v923 = p922:Add(ReplicatedStorage.Assets.VFX.Emotes.Floating:Clone());
        v923.Parent = workspace.Debris;
        v923.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v923, HumanoidRootPart);
        VfxManager.Enable(v923, true);
        SfxManager:playSound({
            Sound = "Floating",
            Parent = v923
        });
    end,

    ["Dark Horse Ride"] = function(p924, p925) -- Line: 6940
        -- upvalues: ReplicatedStorage (copy), RunService (copy)
        local v926 = ReplicatedStorage.Assets.VFX.Emotes["Dark Horse Ride"];
        local Character = p924.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v927 = p925:Add(v926.Horse:Clone());
        v927.Parent = Character;
        v927.Handle.Part0 = HumanoidRootPart;
        local u928 = Humanoid:LoadAnimation(v926.Animation);
        u928.Priority = Enum.AnimationPriority.Action3;
        u928:Play();
        p925:Add(RunService.Heartbeat:Connect(function() -- Line: 6955
            -- upvalues: HumanoidRootPart (copy), u928 (copy)
            if math.floor((HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude) > 0 then
                if u928.IsPlaying then
                    return;
                end;

                u928:Play();

                return;
            end;

            if not u928.IsPlaying then
                return;
            end;

            u928:Stop();
        end));
        p925:Add(function() -- Line: 6965
            -- upvalues: u928 (copy)
            u928:Stop(0);
            u928:Destroy();
        end);
    end,

    ["Aura Monster"] = function(p929, u930) -- Line: 6971
        -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Players (copy), Essentials (copy), VfxManager (copy)
        local u931 = ReplicatedStorage.Assets.VFX.Emotes["Aura Monster"];
        local Character = p929.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local u932 = Character:FindFirstChild("Right Leg");
        local u933 = Character:FindFirstChild("Left Leg");
        u930:Add(SfxManager:playSound({
            Sound = "Aura Monster",
            Parent = HumanoidRootPart
        }));
        local v934 = u930:Add(u931.Part:Clone());
        v934.Parent = workspace.Debris;
        v934.Handle.Part0 = HumanoidRootPart;
        local v935 = u930:Add(u931.SurfaceGui:Clone());
        v935.Parent = Players.LocalPlayer:FindFirstChild("PlayerGui");
        v935.Adornee = v934;
        local v936 = u930:Add(Instance.new("Camera"));
        v936.CameraType = Enum.CameraType.Scriptable;
        v936.CFrame = CFrame.lookAt(Vector3.new(1, 0.5, -5), Vector3.new(0, 0, 0));
        v935.ViewportFrame.CurrentCamera = v936;
        Character.Archivable = true;
        local v937 = Character:Clone();
        Character.Archivable = false;
        v937.Parent = v935.ViewportFrame.WorldModel;
        v937.HumanoidRootPart.CFrame = CFrame.identity;

        for _, descendant in v937:GetDescendants() do
            if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or (descendant:IsA("Sound") or (descendant:IsA("SurfaceGui") or (descendant:IsA("BillboardGui") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail"))))))))) then
                descendant:Destroy();
            elseif descendant:IsA("Humanoid") then
                descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            end;
        end;

        local v938 = v937.Humanoid:LoadAnimation(u931.BackgroundAnimation);
        v938:Play();
        u930:Connect(v938:GetMarkerReachedSignal("Right Foot"), function() -- Line: 7013
            -- upvalues: u930 (copy), u931 (copy), u932 (copy), Essentials (ref), VfxManager (ref)
            local v939 = u930:Add(u931.Step:Clone());
            v939.Parent = workspace.Debris;
            v939.CFrame = CFrame.new((u932.CFrame * CFrame.new(0, -0.9, 0)).Position);
            Essentials:Weld(v939, u932);
            VfxManager.Emit(v939);
            VfxManager.DestroyEffect(v939, 2);
        end);
        u930:Connect(v938:GetMarkerReachedSignal("Left Foot"), function() -- Line: 7022
            -- upvalues: u930 (copy), u931 (copy), u933 (copy), Essentials (ref), VfxManager (ref)
            local v940 = u930:Add(u931.Step:Clone());
            v940.Parent = workspace.Debris;
            v940.CFrame = CFrame.new((u933.CFrame * CFrame.new(0, -0.9, 0)).Position);
            Essentials:Weld(v940, u933);
            VfxManager.Emit(v940);
            VfxManager.DestroyEffect(v940, 2);
        end);

        for i = 1, 3 do
            local v941 = u930:Add(u931[`Stair{i}`]:Clone());
            v941.Parent = Character;
            v941.Handle.Part0 = HumanoidRootPart;
            v941.AnimationController.Animator:LoadAnimation(u931[`Stair{i}Animation`]):Play();
            local _ = i;
        end;

        local v942 = u930:Add(u931.Aura:Clone());
        v942.Parent = workspace.Debris;
        v942.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -1);
        Essentials:Weld(v942, HumanoidRootPart);
    end,

    Limousine = function(p943, p944) -- Line: 7044
        -- upvalues: ReplicatedStorage (copy)
        local Limousine = ReplicatedStorage.Assets.VFX.Emotes.Limousine;
        local Character = p943.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v945 = p944:Add(Limousine.Lowrider:Clone());
        v945.Parent = Character;
        v945.Handle.Part0 = HumanoidRootPart;
        local u946 = Humanoid:LoadAnimation(Limousine.CharacterAnimation);
        u946.Priority = Enum.AnimationPriority.Action3;
        u946:Play();
        local u947 = v945.AnimationController.Animator:LoadAnimation(Limousine.LowriderAnimation);
        u947.Priority = Enum.AnimationPriority.Action3;
        u947:Play();
        p944:Add(function() -- Line: 7063
            -- upvalues: u946 (copy), u947 (copy)
            u946:Stop(0);
            u946:Destroy();
            u947:Stop(0);
            u947:Destroy();
        end);
    end,

    ["Sneaky Block"] = function(p948, u949) -- Line: 7071
        -- upvalues: ReplicatedStorage (copy), RunService (copy)
        local Character = p948.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local v950 = Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.Animations.Blocks.Blocked);
        v950.Priority = Enum.AnimationPriority.Action3;
        v950:Play();
        u949:Add(task.delay(0.2, function() -- Line: 7080
            -- upvalues: u949 (copy), HumanoidRootPart (copy), RunService (ref)
            local u951 = u949:Add(Instance.new("LinearVelocity"));
            u951.Name = "LinearVelocityBasketball";
            u951.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            u951.MaxAxesForce = Vector3.new(0, inf, 0);
            u951.Attachment0 = HumanoidRootPart.RootAttachment;
            u951.Parent = HumanoidRootPart;
            local math_sqrt_ret = math.sqrt(2 * workspace.Gravity * 7.2);
            u951.VectorVelocity = Vector3.new(0, math_sqrt_ret, 0);
            u949:Connect(RunService.Heartbeat, function(p952) -- Line: 7091
                -- upvalues: math_sqrt_ret (ref), u951 (ref)
                math_sqrt_ret = math_sqrt_ret - workspace.Gravity * p952;

                if math_sqrt_ret <= 0 then
                    if u951 then
                        u951:Destroy();
                        u951 = nil;
                    end;
                else
                    u951.VectorVelocity = Vector3.new(0, math_sqrt_ret, 0);
                end;
            end);
        end));
    end,

    ["Sneaky Shot"] = function(u953, p954) -- Line: 7106
        -- upvalues: SfxManager (copy), ReplicatedStorage (copy), RunService (copy), Players (copy), Knit (copy)
        local Character = u953.Character;
        local Humanoid = Character:FindFirstChild("Humanoid");
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        SfxManager:playSound({
            Sound = "Shoot",
            Parent = HumanoidRootPart
        });
        local v955 = Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.Animations.Shots.ShootF);
        local v956 = Character.PlrBall.Anims.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.BallAnimations.Shots.ShootF);
        v955.Priority = Enum.AnimationPriority.Action3;
        v956.Priority = Enum.AnimationPriority.Action3;
        v955:Play();
        v956:Play();
        local u957 = p954:Add(Instance.new("LinearVelocity"));
        u957.Name = "LinearVelocityBasketball";
        u957.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        u957.MaxAxesForce = Vector3.new(0, inf, 0);
        u957.Attachment0 = HumanoidRootPart.RootAttachment;
        u957.Parent = HumanoidRootPart;
        local math_sqrt_ret = math.sqrt(2 * workspace.Gravity * 7.2);
        u957.VectorVelocity = Vector3.new(0, math_sqrt_ret, 0);
        p954:Connect(RunService.Heartbeat, function(p958) -- Line: 7130
            -- upvalues: math_sqrt_ret (ref), u957 (ref)
            math_sqrt_ret = math_sqrt_ret - workspace.Gravity * p958;

            if math_sqrt_ret <= 0 then
                if u957 then
                    u957:Destroy();
                    u957 = nil;
                end;
            else
                u957.VectorVelocity = Vector3.new(0, math_sqrt_ret, 0);
            end;
        end);
        p954:Add(task.delay(0.2, function() -- Line: 7143
            -- upvalues: u953 (copy), Players (ref), Knit (ref)
            if u953 == Players.LocalPlayer then
                local Controller = Knit.GetController("MovementController");
                Controller.States.Shooting = true;
                task.wait(0.3);
                Controller.States.Shooting = false;
            end;
        end));
    end,

    ["Sneaky Ragdoll"] = function(p959, p960) -- Line: 7155
        -- upvalues: RunService (copy)
        if RunService:IsServer() then
            local Character = p959.Character;
            Character.IsRagdoll.Value = true;

            while Character.IsRagdoll.Value and p959:GetAttribute("PlayingEmote") do
                task.wait();
            end;

            Character.IsRagdoll.Value = false;
        end;
    end,

    ["Love Skateboard"] = function(p961: userdata, p962: any) -- Line: 7169
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u963 = p962:Add(ReplicatedStorage.Assets.VFX.Emotes["Love Skateboard"]:Clone());
        u963.Parent = p961.Character;
        u963.Handle.Handle.Part0 = p961.Character.HumanoidRootPart;
        local v964 = p962:Add(Instance.new("Animation"));
        v964.AnimationId = "rbxassetid://105095216216740";
        v964.Parent = workspace;
        local u965 = p961.Character.Humanoid.Animator:LoadAnimation(v964);
        u965.Priority = Enum.AnimationPriority.Action2;
        p962:Add(function() -- Line: 7182
            -- upvalues: u965 (copy)
            u965:Stop(0);
            u965:Destroy();
        end);
        local u966 = p962:Add(ReplicatedStorage.Assets.VFX.Emotes["Love Skateboard fx"]:Clone());
        u966:PivotTo(p961.Character.HumanoidRootPart.CFrame);
        u966.Parent = workspace.Debris;
        Essentials:Weld(u966.Root, p961.Character.HumanoidRootPart);
        VfxManager.DestroyEffect(u966, 2);
        VfxManager.Emit(u966.AppearEffect);
        local EQUIPPED_COSMETIC = p961.Character:FindFirstChild("EQUIPPED_COSMETIC");

        if EQUIPPED_COSMETIC and EQUIPPED_COSMETIC:GetAttribute("IsSkateboard") then
            EQUIPPED_COSMETIC.Handle.Transparency = 1;
            p962:Add(function() -- Line: 7199
                -- upvalues: EQUIPPED_COSMETIC (copy)
                EQUIPPED_COSMETIC.Handle.Transparency = 0;
            end);
        end;

        task.delay(0.783, function() -- Line: 7204
            -- upvalues: u966 (copy), VfxManager (ref), u963 (copy)
            if u966.Parent ~= nil then
                VfxManager.Emit(u966.LandSkateBoard);
            end;

            if u963.Parent ~= nil then
                VfxManager.Enable(u963, true);
            end;
        end);
        p962:Add(task.delay(2, function() -- Line: 7214
            -- upvalues: u965 (copy)
            u965:Play();
        end));
    end,

    ["Papaya Surfboard"] = function(u967: userdata, u968: any) -- Line: 7219
        -- upvalues: ReplicatedStorage (copy), Essentials (copy)
        local u969 = u968:Add(ReplicatedStorage.Assets.VFX.Emotes.PapayaSurfboard:Clone());
        u969.Parent = u967.Character;
        u969.Name = "Surfboard";
        u969.Surfboard.Part0 = u967.Character.HumanoidRootPart;
        local v970 = u968:Add(ReplicatedStorage.Assets.VFX.Emotes.PapayaSurfboardVFX:Clone());
        v970.Parent = u967.Character;
        v970:PivotTo(u967.Character.HumanoidRootPart.CFrame);
        u968:Add(Essentials:Weld(u967.Character.HumanoidRootPart, v970));
        u968:Add(task.delay(1.3333333333333333, function() -- Line: 7231
            -- upvalues: u967 (copy), u969 (copy), u968 (copy)
            local u971 = u967.Character.Humanoid.Animator:LoadAnimation(u969.SurfLoop);
            u971:Play(0);
            u968:Add(function() -- Line: 7235
                -- upvalues: u971 (copy)
                u971:Stop(0);
            end);
        end));
    end,

    ["AMG Skateboard"] = function(p972: userdata, p973: any) -- Line: 7241
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u974 = p973:Add(ReplicatedStorage.Assets.VFX.Emotes["AMG Skateboard"]:Clone());
        u974.Parent = p972.Character;
        u974.Handle.Handle.Part0 = p972.Character.HumanoidRootPart;
        local v975 = p973:Add(Instance.new("Animation"));
        v975.AnimationId = "rbxassetid://105095216216740";
        v975.Parent = workspace;
        local u976 = p972.Character.Humanoid.Animator:LoadAnimation(v975);
        u976.Priority = Enum.AnimationPriority.Action2;
        p973:Add(function() -- Line: 7254
            -- upvalues: u976 (copy)
            u976:Stop(0);
            u976:Destroy();
        end);
        local u977 = p973:Add(ReplicatedStorage.Assets.VFX.Emotes["AMG Skateboard fx"]:Clone());
        u977:PivotTo(p972.Character.HumanoidRootPart.CFrame);
        u977.Parent = workspace.Debris;
        Essentials:Weld(u977.Root, p972.Character.HumanoidRootPart);
        VfxManager.DestroyEffect(u977, 2);
        VfxManager.Emit(u977.AppearEffect);
        local EQUIPPED_COSMETIC = p972.Character:FindFirstChild("EQUIPPED_COSMETIC");

        if EQUIPPED_COSMETIC and EQUIPPED_COSMETIC:GetAttribute("IsSkateboard") then
            EQUIPPED_COSMETIC.Handle.Transparency = 1;
            p973:Add(function() -- Line: 7271
                -- upvalues: EQUIPPED_COSMETIC (copy)
                EQUIPPED_COSMETIC.Handle.Transparency = 0;
            end);
        end;

        task.delay(0.783, function() -- Line: 7276
            -- upvalues: u977 (copy), VfxManager (ref), u974 (copy)
            if u977.Parent ~= nil then
                VfxManager.Emit(u977.LandSkateBoard);
            end;

            if u974.Parent ~= nil then
                VfxManager.Enable(u974, true);
            end;
        end);
        p973:Add(task.delay(2, function() -- Line: 7286
            -- upvalues: u976 (copy)
            u976:Play();
        end));
    end,

    ["Cursed Skateboard"] = function(p978: userdata, p979: any) -- Line: 7291
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u980 = p979:Add(ReplicatedStorage.Assets.VFX.Emotes["Cursed Skateboard"]:Clone());
        u980.Parent = p978.Character;
        u980.Handle.Handle.Part0 = p978.Character.HumanoidRootPart;
        local v981 = p979:Add(Instance.new("Animation"));
        v981.AnimationId = "rbxassetid://105095216216740";
        v981.Parent = workspace;
        local u982 = p978.Character.Humanoid.Animator:LoadAnimation(v981);
        u982.Priority = Enum.AnimationPriority.Action2;
        p979:Add(function() -- Line: 7304
            -- upvalues: u982 (copy)
            u982:Stop(0);
            u982:Destroy();
        end);
        local u983 = p979:Add(ReplicatedStorage.Assets.VFX.Emotes["Cursed Skateboard fx"]:Clone());
        u983:PivotTo(p978.Character.HumanoidRootPart.CFrame);
        u983.Parent = workspace.Debris;
        Essentials:Weld(u983.Root, p978.Character.HumanoidRootPart);
        VfxManager.DestroyEffect(u983, 2);
        VfxManager.Emit(u983.AppearEffect);
        local EQUIPPED_COSMETIC = p978.Character:FindFirstChild("EQUIPPED_COSMETIC");

        if EQUIPPED_COSMETIC and EQUIPPED_COSMETIC:GetAttribute("IsSkateboard") then
            EQUIPPED_COSMETIC.Handle.Transparency = 1;
            p979:Add(function() -- Line: 7321
                -- upvalues: EQUIPPED_COSMETIC (copy)
                EQUIPPED_COSMETIC.Handle.Transparency = 0;
            end);
        end;

        task.delay(0.783, function() -- Line: 7326
            -- upvalues: u983 (copy), VfxManager (ref), u980 (copy)
            if u983.Parent ~= nil then
                VfxManager.Emit(u983.LandSkateBoard);
            end;

            if u980.Parent ~= nil then
                VfxManager.Enable(u980, true);
            end;
        end);
        p979:Add(task.delay(2, function() -- Line: 7336
            -- upvalues: u982 (copy)
            u982:Play();
        end));
    end,

    ["Cursed Arrow"] = function(p984: userdata, p985: any) -- Line: 7341
        -- upvalues: ReplicatedStorage (copy)
        local v986 = p985:Add(ReplicatedStorage.Assets.VFX.Emotes["Cursed Arrow"]:Clone());
        v986.Parent = p984.Character;
        v986.Handle.Part0 = p984.Character.HumanoidRootPart;
        local v987 = p985:Add(Instance.new("Animation"));
        v987.AnimationId = "rbxassetid://74183459816799";
        v987.Parent = workspace;
        local u988 = p984.Character.Humanoid.Animator:LoadAnimation(v987);
        u988.Priority = Enum.AnimationPriority.Action2;
        p985:Add(function() -- Line: 7353
            -- upvalues: u988 (copy)
            u988:Stop(0);
            u988:Destroy();
        end);
        local EQUIPPED_COSMETIC = p984.Character:FindFirstChild("EQUIPPED_COSMETIC");

        if EQUIPPED_COSMETIC and EQUIPPED_COSMETIC:GetAttribute("IsArrow") then
            EQUIPPED_COSMETIC.Handle.Transparency = 1;
            p985:Add(function() -- Line: 7363
                -- upvalues: EQUIPPED_COSMETIC (copy)
                EQUIPPED_COSMETIC.Handle.Transparency = 0;
            end);
        end;

        p985:Add(task.delay(0.85, function() -- Line: 7368
            -- upvalues: u988 (copy)
            u988:Play();
        end));
    end,

    ["Emr4n\'s Car"] = function(p989: userdata, p990: any) -- Line: 7373
        -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local u991 = p990:Add(ReplicatedStorage.Assets.VFX.Emotes["Emr4n\'s Car"]:Clone());
        u991.Parent = p989.Character;
        u991.Handle.Handle.Part0 = p989.Character.HumanoidRootPart;
        local v992 = p990:Add(Instance.new("Animation"));
        v992.AnimationId = "rbxassetid://105095216216740";
        v992.Parent = workspace;
        local u993 = p989.Character.Humanoid.Animator:LoadAnimation(v992);
        u993.Priority = Enum.AnimationPriority.Action2;
        p990:Add(function() -- Line: 7386
            -- upvalues: u993 (copy)
            u993:Stop(0);
            u993:Destroy();
        end);
        local u994 = p990:Add(ReplicatedStorage.Assets.VFX.Emotes["Emr4n\'s Car fx"]:Clone());
        u994:PivotTo(p989.Character.HumanoidRootPart.CFrame);
        u994.Parent = workspace.Debris;
        Essentials:Weld(u994.Root, p989.Character.HumanoidRootPart);
        VfxManager.DestroyEffect(u994, 2);
        VfxManager.Emit(u994.AppearEffect);
        local EQUIPPED_COSMETIC = p989.Character:FindFirstChild("EQUIPPED_COSMETIC");

        if EQUIPPED_COSMETIC and EQUIPPED_COSMETIC:GetAttribute("IsSkateboard") then
            EQUIPPED_COSMETIC.Handle.Transparency = 1;
            p990:Add(function() -- Line: 7403
                -- upvalues: EQUIPPED_COSMETIC (copy)
                EQUIPPED_COSMETIC.Handle.Transparency = 0;
            end);
        end;

        task.delay(0.783, function() -- Line: 7408
            -- upvalues: u994 (copy), VfxManager (ref), u991 (copy)
            if u994.Parent ~= nil then
                VfxManager.Emit(u994.LandSkateBoard);
            end;

            if u991.Parent ~= nil then
                VfxManager.Enable(u991, true);
            end;
        end);
        p990:Add(task.delay(2, function() -- Line: 7418
            -- upvalues: u993 (copy)
            u993:Play();
        end));
    end,

    ["Skarp\'s Rage"] = function(p995: userdata, p996: any) -- Line: 7423
        -- upvalues: ReplicatedStorage (copy), VfxManager (copy), Essentials (copy), Knit (copy), Lighting (copy), Trove (copy), RunService (copy), Players (copy)
        local Character = p995.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local Head = Character:FindFirstChild("Head");
        local v997 = p996:Add(ReplicatedStorage.Assets.VFX.Emotes["Skarp\'s Rage Aura"]:Clone());
        v997:PivotTo(HumanoidRootPart.CFrame);
        v997.Parent = workspace.Debris;
        v997.Root["EMP EVIL WALK"]:Play();
        VfxManager.Enable(v997, true);
        Essentials:Weld(v997.PrimaryPart, HumanoidRootPart);
        local HeadFX = v997.HeadFX;
        HeadFX.CFrame = Head.CFrame;
        Essentials:Weld(HeadFX, Head);
        local Controller = Knit.GetController("UIController");
        local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
        local u998 = ColorCorrection:Clone();
        u998.Name = "CC";
        u998.Parent = Lighting;
        u998.Brightness = -0.1;
        u998.Contrast = 1.2;
        u998.Saturation = -1;
        u998.Enabled = false;
        local u999 = p996:Add(Trove.new());

        local function EvaluateColorSequence(p1000, p1001) -- Line: 7454
            local math_clamp_ret = math.clamp(p1001, 0, 1);
            local Keypoints = p1000.Keypoints;

            for i = 1, #Keypoints - 1 do
                local v1002 = Keypoints[i];
                local v1003 = Keypoints[i + 1];

                if v1002.Time <= math_clamp_ret and math_clamp_ret <= v1003.Time then
                    return v1002.Value:Lerp(v1003.Value, (math_clamp_ret - v1002.Time) / (v1003.Time - v1002.Time));
                end;

                local _ = i;
            end;

            return Keypoints[#Keypoints].Value;
        end;

        local u1004 = tick();
        p996:Connect(RunService.Heartbeat, function(p1005) -- Line: 7474
            -- upvalues: u1004 (copy), EvaluateColorSequence (copy), u998 (copy)
            local v1006 = (tick() - u1004) % 3;
            local v1007;

            if v1006 <= 1.5 then
                v1007 = v1006 / 1.5;
            else
                v1007 = 1 - (v1006 - 1.5) / 1.5;
            end;

            u998.TintColor = EvaluateColorSequence(ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 171, 238)), ColorSequenceKeypoint.new(1, Color3.fromRGB(248, 176, 206)) }), v1007);
        end);

        local function Removecc() -- Line: 7492
            -- upvalues: u999 (copy)
            u999:Clean();
        end;

        local function Applycc() -- Line: 7496
            -- upvalues: ColorCorrection (copy), u998 (copy), u999 (copy), Players (ref), ReplicatedStorage (ref), HumanoidRootPart (copy), Controller (copy)
            ColorCorrection.Enabled = false;
            u998.Enabled = true;
            u999:Add(function() -- Line: 7500
                -- upvalues: ColorCorrection (ref), u998 (ref)
                ColorCorrection.Enabled = true;
                u998.Enabled = false;
            end);
            local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");
            local v1008 = u999:Add(ReplicatedStorage.Assets.VFX.Emotes.Vignette:Clone());
            v1008.Parent = PlayerGui;
            v1008.Enabled = true;
            local Vignette = v1008.Vignette;
            local Vignette1 = v1008.Vignette1;
            Vignette.ImageTransparency = 0;
            Vignette.ImageColor3 = Color3.fromRGB(0, 0, 0);
            Vignette1.ImageTransparency = 0;
            Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
            local u1009 = u999:Add(Instance.new("ScreenGui"));
            u1009.Parent = PlayerGui;
            u1009.IgnoreGuiInset = true;
            local u1010 = u999:Add(ReplicatedStorage.Assets.UI.ImageFrame:Clone());
            u1010.Parent = u1009;
            u1010.ImageTransparency = 0.85;
            u999:Add(task.spawn(function() -- Line: 7524
                -- upvalues: u1009 (copy), HumanoidRootPart (ref), Controller (ref), u1010 (copy)
                while u1009.Parent ~= nil and HumanoidRootPart ~= nil do
                    Controller:PlayFlipbook(u1010, "EmperorScreenLines", 0.03333333333333333);
                end;
            end));
        end;

        local u1011 = false;
        p996:Add((RunService.Heartbeat:Connect(function() -- Line: 7532
            -- upvalues: Players (ref), HumanoidRootPart (copy), u1011 (ref), Applycc (copy), u999 (copy)
            local v1012 = u1011;
            u1011 = (Players.LocalPlayer.Character and (Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (Players.LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude) or 25) < 25;

            if v1012 == u1011 then
                return;
            end;

            if u1011 then
                Applycc();

                return;
            end;

            u999:Clean();
        end)));
        p996:Add(function() -- Line: 7551
            -- upvalues: u999 (copy), u998 (copy), Lighting (ref), ColorCorrection (copy)
            u999:Clean();

            if u998 then
                u998:Destroy();

                if not Lighting:FindFirstChild("CC") then
                    ColorCorrection.Enabled = true;
                end;
            end;
        end);
    end
};