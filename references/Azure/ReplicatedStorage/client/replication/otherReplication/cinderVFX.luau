 

 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.util.Util);
local v1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
require(script.Parent.Parent.MeshEmitter);
local raycast = require(ReplicatedStorage2.util.raycast);
local animationUtil = require(ReplicatedStorage2.util.animationUtil);
local soundUtil = require(ReplicatedStorage2.util.soundUtil);
require(ReplicatedStorage2.util.actionUtil);
local vfxUtil = require(ReplicatedStorage2.util.vfxUtil);
local trove = require(ReplicatedStorage2.forum.trove);
local MoonPropertyAnimator = require(ReplicatedStorage2.util.MoonPropertyAnimator);
local mainreplication = require(ReplicatedStorage2.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage2.client.replication.TekrinnDialogue);
require(script.Parent.nelisagiVFX.MeshEmitModule);
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function v1.characterImage(p2) -- Line: 53
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p2);
end;

local function emitall(p3, p4) -- Line: 55
    if not p3 then
        return;
    end;

    for _, descendant in pairs(p3:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(p4 or descendant:GetAttribute("EmitCount"));
        end;
    end;
end;

local function enableall(u5, p6, p7) -- Line: 64
    if not u5 then
        return;
    end;

    for _, descendant in pairs(u5:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    if p6 then
        for _, descendant in pairs(u5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 74
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        return;
    end;

    task.delay(p7, function() -- Line: 80
        -- upvalues: u5 (copy)
        if not u5 then
            return;
        end;

        for _, descendant in pairs(u5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

local function makeweld(p8, p9, p10, p11) -- Line: 91
    local Weld = Instance.new("Weld");
    Weld.Parent = p8;
    Weld.Part0 = p9;
    Weld.Part1 = p10;

    if p11 then
        Weld.C0 = p11;
    end;
end;

local function trails(p12, p13) -- Line: 101
    -- upvalues: vfxUtil (copy), LocalPlayer (copy)
    local Jump = vfxUtil.getResources().cinder.Trap.VFX.Jump;

    for _, v in { "Left Arm", "Left Leg", "Right Arm", "Right Leg" } do
        local v14 = p12:FindFirstChild(v);

        if v14 then
            local v15 = p13:Clone(Jump.Trail);
            v15:FindFirstChildOfClass("Weld").Part0 = v14;
            v15.Name = `Trail_{v}`;
            v15.Parent = workspace.Effects;
            vfxUtil.EzLeanTowardsColor(LocalPlayer, p12, v15);
        end;
    end;
end;

local function flametrails(p16, p17, p18, p19) -- Line: 117
    -- upvalues: vfxUtil (copy), LocalPlayer (copy)
    local Trail = vfxUtil.getResources().cinder.Trail;

    for _, v in p18 do
        local v20 = p16:FindFirstChild(v);

        if v20 then
            local v21 = p17:Clone(Trail);
            v21:FindFirstChildOfClass("Weld").Part0 = v20;
            v21.Name = `Trail_{v}`;
            v21.Parent = workspace.Effects;

            if p19 then
                vfxUtil.LeanTowardsColor(v21, p16:GetAttribute("CustomColor") or Color3.fromRGB(85, 255, 0), p16:GetAttribute("CustomAlpha") or 0.985);
            else
                vfxUtil.EzLeanTowardsColor(LocalPlayer, p16, v21);
            end;
        end;
    end;
end;

function v1.cinderUlt(u22) -- Line: 139
    -- upvalues: ReplicatedStorage2 (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), PlayerGui (copy), TekrinnDialogue (copy)
    local v23 = u22.HumanoidRootPart or u22.PrimaryPart;
    local Resources = ReplicatedStorage2.Resources;
    local v24, u25 = mainreplication.cutsceneCamRigWithLetterBox(v23, Resources.cinder.canimation, Resources.cinder.ultimate.FOV, nil, CFrame.identity * CFrame.Angles(0, -3.141592653589793, 0));
    local u26 = Resources.cinder.ultimate.enable4:Clone();
    u26:FindFirstChildOfClass("Weld").Part0 = v24:FindFirstChild("camera");
    u26.Parent = workspace.Effects;
    soundUtil:play(Resources.cinder.ultimate.awk, SoundService);
    mainreplication.sceneEnabled(true);
    local u27 = Resources.cinder.ultimate.roler:Clone();
    u27.Motor6D.Part0 = v23;
    u27.Parent = v23;
    PlayerGui.vb.Enabled = true;
    local u28 = Resources.cinder.ultimate.enable3:Clone();
    u28:FindFirstChildOfClass("Weld").Part0 = u22.Head;
    u28.Parent = workspace.Effects;
    local u29 = {};
    task.spawn(function() -- Line: 164
        -- upvalues: u22 (copy), Resources (copy), u29 (copy)
        for _, descendant in ipairs(u22:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v30 = descendant;

                for _, descendant2 in ipairs(Resources.cinder.ultimate.aura:GetDescendants()) do
                    local v31 = descendant2:Clone();
                    v31.Parent = v30;
                    v31.Enabled = false;
                    table.insert(u29, v31);
                end;
            end;
        end;
    end);
    task.delay(1.3, function() -- Line: 179
        -- upvalues: u27 (copy)
        for _, descendant in ipairs(u27:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(1.4, function() -- Line: 184
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(7.1, function() -- Line: 189
        -- upvalues: u29 (copy)
        for _, v in ipairs(u29) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
                task.delay(7.38, function() -- Line: 193
                    -- upvalues: v (copy)
                    v.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(11.7, function() -- Line: 198
        -- upvalues: u26 (copy)
        for _, descendant in ipairs(u26:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Parent.Name ~= "Emit" then
                descendant.Enabled = true;
                task.delay(0.65, function() -- Line: 203
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(9.783333333333333, function() -- Line: 208
        -- upvalues: u28 (copy)
        for _, descendant in u28:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(12.983333333333333, function() -- Line: 217
        -- upvalues: u26 (copy)
        for _, descendant in ipairs(u26.Emit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 5, 5)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 40, 40)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 140)) });
    local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 0, 0)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(180, 15, 15)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 70, 70)) });
    local ColorSequence_new_ret3 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 8, 10)), ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 90, 90)) });
    task.delay(3.7, function() -- Line: 240
        -- upvalues: TekrinnDialogue (ref), u22 (copy), ColorSequence_new_ret2 (copy), ColorSequence_new_ret (copy)
        TekrinnDialogue.Speak(u22, {
            {
                Text = "OH FINALLY!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.025,
                Pause = 1.5,
                Color = ColorSequence_new_ret2,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Duration = 0.9
                }
            },
            {
                Text = " A Challenge...",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.045,
                Color = ColorSequence_new_ret,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Duration = 1.1
                }
            }
        }, 3.5);
    end);
    task.delay(10.7, function() -- Line: 272
        -- upvalues: TekrinnDialogue (ref), u22 (copy), ColorSequence_new_ret3 (copy), ColorSequence_new_ret2 (copy)
        TekrinnDialogue.Speak(u22, {
            {
                Text = "With that said..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Pause = 1.5,
                Color = ColorSequence_new_ret3,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Duration = 1
                }
            },
            {
                Text = " Let\'s Continue our bout!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence_new_ret2,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Duration = 1.2
                }
            }
        }, 4.5);
    end);
    task.delay(15, function() -- Line: 304
        -- upvalues: mainreplication (ref), PlayerGui (ref), u29 (copy), u26 (copy), u27 (copy), u25 (copy)
        mainreplication.ultFlash(1, 0.5);
        PlayerGui.vb.Enabled = false;

        for _, v in u29 do
            v:Destroy();
        end;

        mainreplication.sceneEnabled(false);
        u26:Destroy();
        u27:Destroy();
        u25();
    end);
    task.delay(60, function() -- Line: 316
        -- upvalues: u28 (copy)
        for _, descendant in u28:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.wait(3);
        u28:Destroy();
    end);
end;

function v1.incendiaryDive(u32) -- Line: 328
    -- upvalues: vfxUtil (copy), soundUtil (copy), RunService (copy), Players (copy), mainreplication (copy)
    local OffBall = vfxUtil.getResources().cinder.Dribble.OffBall;
    local u33 = vfxUtil.character_trove(u32);
    local Root = vfxUtil.getRoot(u32);
    u33:Clone(OffBall.ChargeHighlight).Parent = u32;
    local u34 = u33:Clone(OffBall.Startup);
    u34.CFrame = Root.CFrame;
    u34.Parent = workspace.Effects;
    shared.vfx.emit(u32.ChargeHighlight);
    shared.vfx.emit(u34);
    soundUtil:play(OffBall.sfx, Root);
    u33:Add(task.delay(2, u33.Destroy, u33));
    u33:Add(task.delay(0.5, function() -- Line: 347
        -- upvalues: u33 (copy), OffBall (copy), Root (copy), RunService (ref), u34 (copy), Players (ref), u32 (copy), mainreplication (ref)
        local v35 = u33:Clone(OffBall.Impact);
        v35:PivotTo(Root.CFrame);
        v35.Parent = workspace.Effects;
        local u36 = u33:Clone(OffBall.Dash);
        u36:PivotTo(Root.CFrame);
        u33:Add(RunService.RenderStepped:Connect(function() -- Line: 354
            -- upvalues: u36 (copy), Root (ref)
            if u36.Parent then
                u36:PivotTo(Root.CFrame);
            end;
        end));
        u36.Parent = workspace.Effects;
        shared.vfx.emit(u36);
        shared.vfx.emit(v35);
        shared.vfx.emit(u34);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u32) then
            return;
        end;

        local u37 = mainreplication.bodyVelocity(Root, 1, 0.2, nil, nil, true);

        if not u37 then
            return;
        end;

        u37.MaxForce = Vector3.new(300000, 300000, 300000);
        local u38 = nil;
        u38 = RunService.RenderStepped:Connect(function() -- Line: 374
            -- upvalues: u37 (copy), u38 (ref), Root (ref)
            if u37 and u37:IsDescendantOf(game) then
                u37.Velocity = Root.CFrame.LookVector * 200 + Root.CFrame.UpVector * 8;

                return;
            end;

            u38:Disconnect();
        end);
        u33:Add(u38);
        task.delay(0.30000000000000004, u38.Disconnect, u38);
    end));
end;

function v1.sinisterFootwork(p39: userdata) -- Line: 387
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), RunService (copy), Players (copy), mainreplication (copy)
    local cinder = vfxUtil.getResources():WaitForChild("cinder");
    local Root = vfxUtil.getRoot(p39);
    local Dribble = cinder.Dribble;
    local _ = vfxUtil.forge;
    local u40 = trove.new();
    u40:AttachToInstance(p39);
    soundUtil:play(Dribble.sound, Root);
    local u41 = u40:Clone(Dribble.VFX);
    u41.Parent = workspace.Effects;
    local u42 = u40:Construct(Dribble.Aura);
    vfxUtil.setupAura(p39, u42, true);
    u42.Parent = workspace.Effects;
    u40:Add(task.spawn(function() -- Line: 407
        -- upvalues: u42 (copy)
        for _, descendant in u42:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    vfxUtil.execute_compiled(Dribble.Compiled, u40, u41);
    u40:Add(RunService.RenderStepped:Connect(function() -- Line: 419
        -- upvalues: u41 (copy), Root (copy)
        u41:PivotTo(CFrame.new(Root.Position, Root.Position + Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z)));
    end));
    local u43 = Players.LocalPlayer == Players:GetPlayerFromCharacter(p39);

    local function footworkBlink(p44) -- Line: 427
        -- upvalues: u43 (copy), Root (copy), mainreplication (ref)
        if not u43 then
            return;
        end;

        local v45 = Root;
        v45.CFrame = v45.CFrame * p44;
        local Magnitude = p44.Position.Magnitude;
        mainreplication.springcamerashake(Magnitude, 18);
        mainreplication.fov(false, 70 + Magnitude * 0.4);
        mainreplication.fov(true, 70, 0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
    end;

    if u43 then
        u40:Add(task.spawn(function() -- Line: 439
            -- upvalues: mainreplication (ref), Root (copy)
            mainreplication.bodyVelocity(Root, 85, 3, nil, nil, nil);
        end));
        u40:Add(task.delay(0.825, function() -- Line: 442
            -- upvalues: mainreplication (ref), Root (copy)
            mainreplication.bodyVelocity(Root, 85, 3, nil, nil, nil);
        end));
        u40:Add(task.delay(1.65, function() -- Line: 445
            -- upvalues: mainreplication (ref), Root (copy)
            mainreplication.bodyVelocity(Root, 85, 1.23, nil, nil, nil);
        end));
    end;

    u40:Add(task.delay(0.45, function() -- Line: 450
        -- upvalues: footworkBlink (copy)
        footworkBlink(CFrame.new(-11, 0, 0));
    end));
    u40:Add(task.delay(0.52, function() -- Line: 454
        -- upvalues: footworkBlink (copy)
        footworkBlink(CFrame.new(11, 0, 0));
    end));
    u40:Add(task.delay(2.53, function() -- Line: 458
        -- upvalues: u40 (copy)
        u40:Destroy();
    end));
end;

function v1.bloodShot(p46, p47) -- Line: 463
    -- upvalues: vfxUtil (copy), flametrails (copy), LocalPlayer (copy), soundUtil (copy), RunService (copy), Players (copy), raycast (copy), mainreplication (copy)
    local cinder = vfxUtil.getResources().cinder;
    local Root = vfxUtil.getRoot(p46);
    local v48 = vfxUtil.character_trove(p46);
    flametrails(p46, v48, { "Right Leg" }, p47);
    local u49 = v48:Clone(cinder.VFX);
    u49:PivotTo(Root.CFrame);
    u49.Parent = workspace.Effects;

    if p47 then
        vfxUtil.LeanTowardsColor(u49, p46:GetAttribute("CustomColor") or Color3.fromRGB(85, 255, 0), p46:GetAttribute("CustomAlpha") or 0.985);
    else
        vfxUtil.EzLeanTowardsColor(LocalPlayer, p46, u49);
    end;

    soundUtil:play(cinder.shot, Root);
    v48:Clone(cinder.Highlight).Parent = p46;
    v48:Add(RunService.RenderStepped:Connect(function() -- Line: 483
        -- upvalues: u49 (copy), Root (copy)
        if u49 then
            u49:PivotTo(Root.CFrame);
        end;
    end));
    vfxUtil.execute_compiled(cinder.Compiled, v48, u49, p46);
    v48:Add(task.delay(1.16, v48.Destroy, v48));

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p46) then
        return;
    end;

    if raycast(Root.Position, Vector3.new(0, -7, 0)) then
        return;
    end;

    local Magnitude = Vector3.new(Root.AssemblyLinearVelocity.X, 0, Root.AssemblyLinearVelocity.Z).Magnitude;
    local math_clamp_ret = math.clamp(Magnitude, 60, 160);
    local u50 = p46:GetAttribute("IncendiaryDiveMomentum") == true and true or Magnitude > 80;
    local u51 = mainreplication.bodyVelocity(Root, 1, 0.75, nil, nil, true);

    if not u51 then
        return;
    end;

    u51.MaxForce = Vector3.new(300000, 300000, 300000);
    local os_clock_ret = os.clock();
    v48:Add(RunService.RenderStepped:Connect(function() -- Line: 514
        -- upvalues: u51 (copy), math_clamp_ret (copy), u50 (copy), os_clock_ret (copy), Root (copy)
        if not (u51 and u51:IsDescendantOf(game)) then
            return;
        end;

        local v52 = math_clamp_ret;

        if u50 then
            local v53 = (os.clock() - os_clock_ret) / 0.75;
            local math_clamp_ret2 = math.clamp(v53, 0, 1);
            v52 = (math_clamp_ret - 60) * ((1 - math_clamp_ret2) * (1 - math_clamp_ret2)) + 60;
        end;

        u51.Velocity = Root.CFrame.LookVector * v52 + Root.CFrame.UpVector * 10;
    end));
end;

function v1.cinderSteal(u54, u55) -- Line: 530
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), TekrinnDialogue (copy)
    local Steal = vfxUtil.getResources().cinder.Steal;
    local Root = vfxUtil.getRoot(u54);
    local u56 = vfxUtil.character_trove(u54);
    local u57 = u56:Add(mainreplication.kuronaCamToAll(Root, Steal.Cam, Steal.FOV));
    soundUtil:play(Steal.sound, "default");
    mainreplication.sceneEnabled(true);
    u56:Add(function() -- Line: 540
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    u56:Add(task.spawn(function() -- Line: 544
        -- upvalues: Steal (copy), u54 (copy), u55 (copy), u57 (copy)
        require(Steal.Steal)(u54, u55, u57);
    end));
    local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 10, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 90, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 230, 200)) });
    local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 10, 8)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 140, 120)) });
    u56:Add(task.delay(4.2, function() -- Line: 558
        -- upvalues: u56 (copy), TekrinnDialogue (ref), u54 (copy), ColorSequence_new_ret (copy)
        u56:Add(TekrinnDialogue.Speak(u54, {
            {
                Text = "Hey.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.06,
                Color = ColorSequence_new_ret,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Duration = 1
                }
            }
        }, 2.8));
    end));
    u56:Add(task.delay(8.6, function() -- Line: 576
        -- upvalues: u56 (copy), TekrinnDialogue (ref), u54 (copy), ColorSequence_new_ret2 (copy)
        u56:Add(TekrinnDialogue.Speak(u54, {
            {
                Text = "How disappointing.",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.045,
                Color = ColorSequence_new_ret2,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Duration = 0.8
                }
            }
        }, 3.2));
    end));
    u56:Add(task.delay(12.39, u56.Destroy, u56));
end;

function v1.emberOverdrive(u58: userdata) -- Line: 597
    -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), animationUtil (copy), PlayerGui (copy), Lighting (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u58);
    local EmberOverdrive = vfxUtil.getResources():WaitForChild("cinder").EmberOverdrive;
    local u59 = trove.new();
    u59:AttachToInstance(u58);
    local v60 = u59:Construct(EmberOverdrive.User);
    vfxUtil.setupAura(u58, v60, true);
    v60.Parent = workspace.Effects;
    mainreplication.sceneEnabled(true);
    soundUtil:play(EmberOverdrive.sound, SoundService);
    local u61 = u59:Clone(EmberOverdrive.VFX);
    u61:PivotTo(Root.CFrame);
    u61.Parent = workspace.Effects;

    for _, child in u61:GetChildren() do
        if child:IsA("BasePart") and (child:GetAttribute("WeldTo") and u58:FindFirstChild(child:GetAttribute("WeldTo"))) then
            local v62 = child:FindFirstChildOfClass("Weld");

            if v62 then
                print((`Welding {child.Name} to {child:GetAttribute("WeldTo")}`));
                v62.Part0 = u58:FindFirstChild(child:GetAttribute("WeldTo"));
            end;
        end;
    end;

    u59:Add(animationUtil:loadAnimation(u58, EmberOverdrive.Animation), "Stop"):Play();
    local u63 = u59:Add(mainreplication.kuronaCamToAll(Root, EmberOverdrive.Cam, EmberOverdrive.FOV));
    u59:Add(task.spawn(function() -- Line: 638
        -- upvalues: u61 (copy), u63 (copy), u58 (copy)
        u61:FindFirstChild("CamVFX"):FindFirstChildOfClass("Weld").Part0 = u63;
        u61.HandsonFire.LeftArmFire:FindFirstChildOfClass("Weld").Part0 = u58:FindFirstChild("Left Arm");
        u61.HandsonFire.RightArmFire:FindFirstChildOfClass("Weld").Part0 = u58:FindFirstChild("Right Arm");
    end));
    vfxUtil.execute_compiled(EmberOverdrive.Compiled, u59, u61);
    local v64 = u59:Clone(EmberOverdrive.Vignette);
    v64.Parent = PlayerGui;
    local v65 = {
        ultmove = u61,
        Lighting = Lighting,
        Main = v64.Frame.Main
    };
    vfxUtil.contain_lighting(u59, v65, EmberOverdrive.Lighting);
    local v66 = u59:Construct(MoonPropertyAnimator);
    v66:LoadSave(EmberOverdrive.Moon, MoonPropertyAnimator.ConvertSave(EmberOverdrive.Moon, v65));
    v66:SetRoot(Root);
    v66:PlayAll();
    local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 10, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 90, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 230, 200)) });
    local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 0, 0)), ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255, 40, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 60)) });
    local ColorSequence_new_ret3 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 15, 10)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 140)) });
    u59:Add(task.delay(0.3, function() -- Line: 677
        -- upvalues: u59 (copy), TekrinnDialogue (ref), u58 (copy), ColorSequence_new_ret2 (copy)
        u59:Add(TekrinnDialogue.Speak(u58, {
            {
                Text = "HAHAHAHAHAHA!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence_new_ret2,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 6,
                    Duration = 1.1
                }
            }
        }, 2.2));
    end));
    u59:Add(task.delay(2.3, function() -- Line: 695
        -- upvalues: u59 (copy), TekrinnDialogue (ref), u58 (copy), ColorSequence_new_ret (copy)
        u59:Add(TekrinnDialogue.Speak(u58, {
            {
                Text = "This Feeling..!",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence_new_ret,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Duration = 0.8
                }
            }
        }, 2.4));
    end));
    u59:Add(task.delay(4.1, function() -- Line: 713
        -- upvalues: u59 (copy), TekrinnDialogue (ref), u58 (copy), ColorSequence_new_ret (copy), ColorSequence_new_ret2 (copy)
        u59:Add(TekrinnDialogue.Speak(u58, {
            {
                Text = "The inspiration is ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence_new_ret,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Duration = 1
                }
            },
            {
                Text = "OVERWHELMING!!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence_new_ret2,
                TextStrokeColor = Color3.fromRGB(40, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 8,
                    Duration = 1.4
                }
            }
        }, 3.2));
    end));
    u59:Add(task.delay(10.5, function() -- Line: 744
        -- upvalues: u59 (copy), TekrinnDialogue (ref), u58 (copy), ColorSequence_new_ret3 (copy)
        u59:Add(TekrinnDialogue.Speak(u58, {
            {
                Text = "Ahh..",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.1,
                Color = ColorSequence_new_ret3,
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Duration = 1
                }
            }
        }, 2.5));
    end));
    u59:Add(function() -- Line: 762
        -- upvalues: mainreplication (ref), vfxUtil (ref)
        mainreplication.sceneEnabled(false);
        vfxUtil.restore_lighting();
        vfxUtil.restore_lighting_properties();
    end);
    u59:Add(task.delay(12, function() -- Line: 768
        -- upvalues: u59 (copy), mainreplication (ref)
        u59:Destroy();
        mainreplication.ultFlash(1, 1);
    end));
end;

function v1.flameSnareCast(u67) -- Line: 774
    -- upvalues: vfxUtil (copy), soundUtil (copy)
    local Root = vfxUtil.getRoot(u67);
    local Cast = vfxUtil.getResources():WaitForChild("cinder").Trap.VFX.Cast;
    local u68 = vfxUtil.character_trove(u67);
    local v69 = u68:Clone(Cast.VFX);
    v69:PivotTo(Root.CFrame);
    v69.Parent = workspace.Effects;
    soundUtil:play(vfxUtil.getResources().cinder.Trap.Sounds.Snare, Root);
    u68:Add(task.spawn(function() -- Line: 785
        -- upvalues: u68 (copy), Cast (copy), u67 (copy)
        u68:Clone(Cast.Highlight).Parent = u67;
        u68:Clone(Cast.flash).Parent = u67:FindFirstChild("Right Arm");
    end));
    vfxUtil.execute_compiled(Cast.Compiled, u68, v69, u67);
    u68:Add(task.delay(1.5, u68.Destroy, u68));
end;

function v1.flameSnareJump(u70, p71) -- Line: 794
    -- upvalues: vfxUtil (copy), flametrails (copy), soundUtil (copy), Players (copy), mainreplication (copy), RunService (copy), ReplicatedStorage2 (copy)
    local Root = vfxUtil.getRoot(u70);
    local v72 = vfxUtil.character_trove(u70);
    local u73 = p71 or "seek";
    local v74 = u73 == "air" and 0.55 or 1.1;
    flametrails(u70, v72, { "Left Arm", "Right Arm" });
    soundUtil:play(vfxUtil.getResources().cinder.Trap.Sounds.Leap, Root);
    v72:Add(task.delay(v74 + 0.15, v72.Destroy, v72));

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u70) then
        return;
    end;

    local AssemblyLinearVelocity = Root.AssemblyLinearVelocity;
    local Magnitude = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude;
    local u75 = u70:GetAttribute("IncendiaryDiveMomentum") == true;
    local u76 = u75 or Magnitude > 40;
    local u77 = math.clamp(Magnitude * 0.4, 0, 100) + 120;

    if u75 then
        u77 = u77 + 55;
    end;

    local u78 = 55 + (u75 and 12 or 0);

    if u73 == "air" and not (u70:GetAttribute("RinNoPlay") or u70:GetAttribute("SillySong")) then
        local v79 = u75 and 0.5 or 0.72;
        u77 = u77 * v79;
        u78 = u78 * v79;
    end;

    local TweenInfo_new_ret = TweenInfo.new(v74, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    if u73 == "air" then
        TweenInfo_new_ret = nil;
    end;

    local u80, u81 = mainreplication.bodyVelocity(Root, 1, v74, nil, nil, true, TweenInfo_new_ret);

    if not u80 then
        return;
    end;

    u80.MaxForce = Vector3.new(300000, 300000, 300000);
    v72:Add(RunService.RenderStepped:Connect(function() -- Line: 835
        -- upvalues: u80 (copy), u73 (copy), u76 (copy), u81 (copy), Root (copy), ReplicatedStorage2 (ref), Magnitude (copy), u75 (copy), u70 (copy), u77 (ref), u78 (ref)
        if not (u80 and u80:IsDescendantOf(game)) then
            return;
        end;

        local v82 = (u73 == "air" or not u76) and 1 or (not u81 and 0 or math.clamp(u81.Value, 0, 1));

        if u73 ~= "seek" then
            local v83 = u70:FindFirstChildOfClass("Humanoid");
            local v84 = v83 and v83.MoveDirection or Vector3.new(0, 0, 0);
            local LookVector = Root.CFrame.LookVector;

            if v84.Magnitude > 0 then
                LookVector = (LookVector * 0.7 + v84.Unit * 0.5).Unit;
            end;

            u80.Velocity = LookVector * u77 + Root.CFrame.UpVector * u78;

            return;
        end;

        local v85 = Root.Position + Root.CFrame.LookVector * 20 + Vector3.new(0, 15, 0);
        local CFBall = ReplicatedStorage2:FindFirstChild("CFBall");

        if CFBall and CFBall:IsA("CFrameValue") then
            v85 = CFBall.Value.Position;
        end;

        local v86 = v85 - Root.Position;

        if v86.Magnitude < 0.1 then
            return;
        end;

        local v87 = math.clamp(Magnitude * 0.25, 0, 70) + 95;
        u80.Velocity = (v86.Unit * (v87 + (u75 and 40 or 0)) + Vector3.new(0, 35, 0)) * v82;
    end));
end;

function v1.flameSnareTrap(p88) -- Line: 876
    -- upvalues: vfxUtil (copy), soundUtil (copy), RunService (copy), Players (copy), mainreplication (copy)
    local Root = vfxUtil.getRoot(p88);
    local v89 = vfxUtil.character_trove(p88);
    local u90 = v89:Clone(vfxUtil.getResources().cinder.Trap.VFX.Trap.VFX);
    u90:PivotTo(Root.CFrame);
    u90.Parent = workspace.Effects;
    soundUtil:play(vfxUtil.getResources().cinder.Trap.Sounds.Trap, Root);
    v89:Add(RunService.RenderStepped:Connect(function() -- Line: 887
        -- upvalues: u90 (copy), Root (copy)
        if u90 then
            u90:PivotTo(Root.CFrame);
        end;
    end));
    v89:Add(task.delay(0.16666666666666666, function() -- Line: 893
        -- upvalues: u90 (copy)
        shared.vfx.emit(u90.FirstEmit);
    end));
    v89:Add(task.delay(1.4, v89.Destroy, v89));

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p88) then
        return;
    end;

    local u91, u92 = mainreplication.bodyVelocity(Root, 60, 1.27, nil, nil, true, TweenInfo.new(1.27, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));

    if not u91 then
        return;
    end;

    u91.MaxForce = Vector3.new(300000, 300000, 300000);
    v89:Add(RunService.RenderStepped:Connect(function() -- Line: 909
        -- upvalues: u91 (copy), Root (copy), u92 (copy)
        if not (u91 and u91:IsDescendantOf(game)) then
            return;
        end;

        u91.Velocity = Root.CFrame.LookVector * 20 + Root.CFrame.UpVector * u92.Value;
    end));
end;

function v1.flameSnareShot(u93) -- Line: 917
    -- upvalues: vfxUtil (copy), soundUtil (copy), trails (copy), Players (copy), mainreplication (copy), RunService (copy)
    local Root = vfxUtil.getRoot(u93);
    local u94 = u93:FindFirstChildOfClass("Humanoid");
    local Shot = vfxUtil.getResources().cinder.Trap.VFX.Shot;
    local u95 = vfxUtil.character_trove(u93);
    local u96 = u95:Clone(Shot.Spin);
    u96.Parent = u93.Torso;
    soundUtil:play(vfxUtil.getResources().cinder.Trap.Sounds.TrapShot, Root);
    u95:Add(task.delay(0.21666666666666667, function() -- Line: 928
        -- upvalues: u96 (copy)
        shared.vfx.emit(u96);
    end));
    u95:Add(task.delay(1.2333333333333334, function() -- Line: 932
        -- upvalues: u95 (copy), Shot (copy), Root (copy)
        local v97 = u95:Clone(Shot.VFX);
        v97:PivotTo(Root.CFrame);
        v97.Parent = workspace.Effects;
        shared.vfx.emit(v97);
    end));
    trails(u93, u95);
    u95:Add(task.delay(1.54, u95.Destroy, u95));

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u93) then
        return;
    end;

    local u98 = true;
    local u99 = false;

    local function releaseAimLock() -- Line: 949
        -- upvalues: u99 (ref), u98 (ref), u93 (copy), u94 (copy), Root (copy)
        if u99 then
            return;
        end;

        u99 = true;
        u98 = false;
        u93:SetAttribute("disableRotate", nil);

        if u94 then
            u94.PlatformStand = false;
            u94.AutoRotate = true;
        end;

        local Vector3_new_ret = Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z);

        if Vector3_new_ret.Magnitude > 0.05 then
            Root.CFrame = CFrame.lookAt(Root.Position, Root.Position + Vector3_new_ret.Unit);
        end;
    end;

    u93:SetAttribute("disableRotate", true);

    if u94 then
        u94.AutoRotate = false;
        u94.PlatformStand = true;
    end;

    u95:Add(releaseAimLock);
    local u100, u101 = mainreplication.bodyVelocity(Root, 60, 1.25, nil, nil, true, TweenInfo.new(1.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));

    if not u100 then
        return;
    end;

    u100.MaxForce = Vector3.new(300000, 300000, 300000);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    u95:Add(RunService.RenderStepped:Connect(function(p102) -- Line: 980
        -- upvalues: u98 (ref), u100 (copy), workspace_CurrentCamera (copy), Root (copy), u101 (copy)
        if not (u98 and (u100 and u100:IsDescendantOf(game))) then
            return;
        end;

        local v103 = workspace_CurrentCamera and workspace_CurrentCamera.CFrame or Root.CFrame;
        local LookVector = v103.LookVector;
        local v104 = CFrame.new(Root.Position) * v103.Rotation;
        Root.CFrame = Root.CFrame:Lerp(v104, 1 - math.exp(-14 * p102));
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

        if Vector3_new_ret.Magnitude < 0.05 then
            Vector3_new_ret = Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z);
        end;

        u100.Velocity = (Vector3_new_ret.Magnitude <= 0.05 and Vector3.new(0, 0, 0) or Vector3_new_ret.Unit) * 12 + Vector3.new(0, u101.Value, 0);
    end));
    u95:Add(task.delay(1.14, releaseAimLock));
end;

function v1.ReaderSlide(p105, p106) -- Line: 1005
    -- upvalues: ReplicatedStorage2 (copy), mainreplication (copy)
    local v107 = p105.HumanoidRootPart or p105.PrimaryPart;
    local _ = ReplicatedStorage2.Resources;
    mainreplication.cameraShake(12, 3, 6);
    mainreplication.bodyVelocity(v107, 250, 2, nil, nil, nil, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
end;

function v1.otCutIn_cinder(p108) -- Line: 1017
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p108);
    local cinder = vfxUtil.getResources().OvertimeCutIn.Styles.cinder;
    local v109 = vfxUtil.character_trove(p108);
    v109:Add(function() -- Line: 1022
        -- upvalues: vfxUtil (ref)
        vfxUtil.restore_lighting_properties();
        vfxUtil.restore_lighting();
    end);
    local u110 = v109:Clone(cinder.VFX);
    u110:PivotTo(Root.CFrame);
    u110.Parent = workspace.Effects;
    local u111, v112 = mainreplication.cutsceneCamRigWithLetterBox(Root, cinder.Cam, cinder.FOV, nil, CFrame.new(0, 0, 0) * CFrame.Angles(0, 3.141592653589793, 0), cinder.CamRigWithLetterBox, "camera");
    v109:Add(v112);

    for _, child in u110:GetChildren() do
        if child:IsA("BasePart") and (child:GetAttribute("WeldTo") and p108:FindFirstChild(child:GetAttribute("WeldTo"))) then
            local v113 = child:FindFirstChildOfClass("Weld");

            if v113 then
                print((`Welding {child.Name} to {child:GetAttribute("WeldTo")}`));
                v113.Part0 = p108:FindFirstChild(child:GetAttribute("WeldTo"));
            end;
        end;
    end;

    v109:Add(task.spawn(function() -- Line: 1056
        -- upvalues: u110 (copy), u111 (copy)
        u110:FindFirstChild("CamVFX"):FindFirstChildOfClass("Weld").Part0 = u111.camera;
    end));
    vfxUtil.execute_compiled(cinder.Compiled, v109, u110);
    v109:Add(task.delay(3.9333333333333336, v109.Destroy, v109));
    soundUtil:play(cinder.sound, "default");
    local v114 = {
        Lighting = Lighting,
        Main = v109:Add(vfxUtil.getMoonEffects()).Vignette
    };
    vfxUtil.contain_lighting(v109, v114, cinder.Lighting);
    local v115 = v109:Construct(MoonPropertyAnimator);
    v115:LoadSave(cinder.Moon, MoonPropertyAnimator.ConvertSave(cinder.Moon, v114));
    v115:SetRoot(Root);
    v115:PlayAll();
end;

return v1;