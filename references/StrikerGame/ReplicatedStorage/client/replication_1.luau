 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local u1 = {};
local u2 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local Mouse = LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.Bloom.Threshold;
require(script.BezierCurve);
local raycast = require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local TekrinnDialogue = require(script:WaitForChild("TekrinnDialogue"));
local mainreplication = require(script:WaitForChild("mainreplication"));
local Invisible = require(script:WaitForChild("Invisible"));
local MeshEmitter = require(script:WaitForChild("MeshEmitter"));
local UwUEffects = require(ReplicatedStorage.util.UwUEffects);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.util.EasingFunctions);
local trove = require(ReplicatedStorage2.forum.trove);
local script_KurisVFXHandler = require(script.KurisVFXHandler);
local script_KurisMeshEmitUtility = require(script.KurisMeshEmitUtility);
local script_Colorcorrectionzstr = require(script.Colorcorrectionzstr);
local BoatTween = require(ReplicatedStorage2.forum.BoatTween);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
script:WaitForChild("otherReplication");

local function check_bool_setting(p3) -- Line: 62
    -- upvalues: LocalPlayer (copy)
    local setting2 = LocalPlayer:FindFirstChild("setting");

    if setting2 and setting2:FindFirstChild(p3) then
        return true, setting2:FindFirstChild(p3).Value;
    end;

    return false;
end;

local u4 = {
    aiku2 = BrickColor.new("Lime green"),
    roland = BrickColor.new("Institutional white")
};

local function DrawLine(p5: vector, p6: vector, p7: userdata?) -- Line: 78
    -- upvalues: actionUtil (copy), LocalPlayer (copy), u4 (copy), trove (copy), TweenService (copy)
    local v8 = actionUtil.checkStyle(LocalPlayer.Character);
    local BrickColor_new_ret = BrickColor.new("Electric blue");

    if v8 then
        BrickColor_new_ret = u4[v8] or BrickColor_new_ret;
    end;

    local v9 = p6 - p5;
    local u10 = trove.new();

    if p7 then
        u10:AttachToInstance(p7);
    end;

    local u11 = u10:Construct(Instance, "Part");
    u11.BrickColor = BrickColor_new_ret;
    u11.Transparency = 0.5;
    u11.Material = Enum.Material.Neon;
    u11.Anchored = true;
    u11.CanCollide = false;
    u11.Position = p5;
    u11.Parent = workspace.Effects;
    u11.Size = Vector3.new(0.25, 0.25, v9.Magnitude);
    u11.CFrame = CFrame.lookAt(p5, p6) + v9 / 2;
    u10:Add(task.delay(3, function() -- Line: 103
        -- upvalues: TweenService (ref), u11 (copy), u10 (copy)
        TweenService:Create(u11, TweenInfo.new(1), {
            Transparency = 1
        }):Play();
        u10:Add(task.delay(1, u10.Destroy, u10));
    end));
end;

function u1.recieveMeta(p12, p13, p14) -- Line: 109
    -- upvalues: DrawLine (copy)
    DrawLine(p12, p13, p14);
end;

u1.cutsceneohiocamera = mainreplication.cutsceneohiocamera;
u1.cutscene = mainreplication.cutscene;
u1.cutsceneLeftright = mainreplication.cutsceneLeftright;
u1.cutscene_JxBEj_0 = mainreplication.cutscene_JxBEj_0;
u1.cutsceneBlender = mainreplication.cutsceneBlender;
u1.cutsceneCamRigWithLetterBox = mainreplication.cutsceneCamRigWithLetterBox;
u1.sceneEnabled = mainreplication.sceneEnabled;
u1.updateGoalTeamIndicator = mainreplication.updateGoalTeamIndicator;
u1.ultFlash = mainreplication.ultFlash;
u1.bright = mainreplication.bright;
u1.cameraShake = mainreplication.cameraShake;
u1.flowCrowd = mainreplication.flowCrowd;
u1.radial_progress_text = mainreplication.radial_progress_text;
u1.radial_progress = mainreplication.radial_progress;
u1.radial_progress_tween = mainreplication.radial_progress_tween;
u1.fov = mainreplication.fov;
u1.bodyVelocity = mainreplication.bodyVelocity;
u1.customBodyVelocity = mainreplication.customBodyVelocity;
u1.destroyVelocity = mainreplication.destroyVelocity;
u1.eradicateVelocity = mainreplication.eradicateVelocity;
u1.Emit = mainreplication.Emit;
u1.PlaySound = mainreplication.PlaySound;
u1.impactFrame = mainreplication.impactFrame;
u1.highlight = mainreplication.highlight;
u1.team_highlight = mainreplication.team_highlight;
u1.newWeld = mainreplication.newWeld;
u1.blackscene = mainreplication.blackscene;
u1.newblackscene = mainreplication.newblackscene;
u1.gklerpclientside = mainreplication.gklerpclientside;
u1.EmitAttachmentIn = mainreplication.EmitAttachmentIn;
u1.EmitAttach = mainreplication.EmitAttach;
u1.WeldTrail = mainreplication.WeldTrail;
u1.DestroyTagged = mainreplication.DestroyTagged;
u1.EmitInBall = mainreplication.EmitInBall;
u1.BallBrickFinder = mainreplication.BallBrickFinder;
u1.editMoveset = mainreplication.editMoveset;
u1.applyPendingMoveset = mainreplication.applyPendingMoveset;
u1.isHoldSpecial = mainreplication.isHoldSpecial;
u1.bindHoldButton = mainreplication.bindHoldButton;
u1.chargeCooldown = mainreplication.chargeCooldown;
u1.LoadMoveset = mainreplication.LoadMoveset;
u1.recolorMoveset = mainreplication.recolorMoveset;
u1.localvoice = mainreplication.localvoice;
u1.destroyPosition = mainreplication.destroyPosition;
u1.raycastEffect = mainreplication.raycastEffect;
u1.commentatorLine = mainreplication.commentatorLine;
u1.soundUtil = mainreplication.soundUtil;

function u1.gubbyShot(p15, p16, p17) -- Line: 164
    -- upvalues: ReplicatedStorage (copy)
    require(ReplicatedStorage.client.gubbyClient).shot(p15, p16, p17);
end;

function u1.fov2(p18) -- Line: 168
    -- upvalues: mainreplication (copy)
    for i = 1, #p18 do
        mainreplication.fov(table.unpack(p18[i]));
        local _ = i;
    end;
end;

function u1.ballControl(p19: boolean) -- Line: 174
    -- upvalues: ReplicatedStorage2 (copy), LocalPlayer (copy)
    if p19 then
        return;
    end;

    require(ReplicatedStorage2.client.BallControlClient).stop();
    local BallControl = LocalPlayer.PlayerGui:FindFirstChild("BallControl");

    if BallControl then
        BallControl:Destroy();
    end;
end;

function u1.mindControl(p20: any, p21: number?) -- Line: 188
    -- upvalues: ReplicatedStorage2 (copy), LocalPlayer (copy)
    local MindControlClient = require(ReplicatedStorage2.client.MindControlClient);

    if p20 == true and p21 then
        if LocalPlayer:GetAttribute("ControllingUserId") ~= p21 then
            return;
        end;

        MindControlClient.start(p21);

        return;
    end;

    if p20 == "locked" then
        MindControlClient.setLocked(true);

        return;
    end;

    if p20 == "released" then
        MindControlClient.setLocked(false);

        return;
    end;

    MindControlClient.stop();
end;

local u22 = {};

function u1.mindControlBubble(p23: number, p24: string, u25: string?) -- Line: 208
    -- upvalues: u22 (copy), Players (copy)
    if u25 then
        if u22[u25] then
            return;
        end;

        u22[u25] = true;
        task.delay(10, function() -- Line: 214
            -- upvalues: u22 (ref), u25 (copy)
            u22[u25] = nil;
        end);
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p23);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    if not PlayerByUserId or p24 == "" then
        return;
    end;

    game:GetService("TextChatService"):DisplayBubble(PlayerByUserId, p24);
end;

function u1.updateCframe(p26, p27) -- Line: 228
    if p26 then
        p26 = p26:FindFirstChild("HumanoidRootPart");
    end;

    if not p26 then
        return;
    end;

    p26.CFrame = p27;
end;

local function enableall(u28, p29, p30) -- Line: 237
    if not u28 then
        return;
    end;

    for _, descendant in pairs(u28:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    if p29 then
        for _, descendant in pairs(u28:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 249
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        return;
    end;

    task.delay(p30, function() -- Line: 255
        -- upvalues: u28 (copy)
        if not u28 then
            return;
        end;

        for _, descendant in pairs(u28:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

local function createData(u31, p32) -- Line: 268
    -- upvalues: u2 (copy)
    if not u2[u31] then
        u2[u31] = {};
        u31.AncestryChanged:Once(function() -- Line: 271
            -- upvalues: u2 (ref), u31 (copy)
            for _, v in u2[u31] do
                for _, v2 in v do
                    if typeof(v2) == "table" and v2.Destroy then
                        v2:Destroy();
                    end;
                end;
            end;

            table.clear(u2[u31]);
            u2[u31] = nil;
        end);
    end;

    if not u2[u31][p32] then
        u2[u31][p32] = {};
    end;

    return u2[u31][p32];
end;

function u1.dragondrivenewchem(u33: userdata) -- Line: 291
    -- upvalues: ReplicatedStorage (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), script_KurisVFXHandler (copy), script_KurisMeshEmitUtility (copy), script_Colorcorrectionzstr (copy), TweenService (copy), BoatTween (copy), TekrinnDialogue (copy)
    local newddchem = ReplicatedStorage.Resources.shidou.newddchem;
    local HumanoidRootPart = u33:FindFirstChild("HumanoidRootPart");
    local u34 = trove.new();

    local function syncedDelay(p35: number, p36: function, ...) -- Line: 296
        -- upvalues: u34 (copy)
        return u34:Add(task.delay(math.max(0, p35 / 60), p36, ...));
    end;

    mainreplication.sceneEnabled(true);
    local Attribute = u33:GetAttribute("femlock");
    local u37 = Attribute or soundUtil:play(Attribute and ReplicatedStorage.Resources.shidou.Femvoicelines.chemicalsae or ReplicatedStorage.Resources.shidou.newddchem.sfx, SoundService, {
        Character = u33
    }).Name == "Dub";
    local u38, u39 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, newddchem.Cam, newddchem.FOV, u33, CFrame.new(
        -7.87275048e-26,
        -3.14368033,
        -6.92494456e-13,
        -1,
        2.50431013e-26,
        -8.74228903e-8,
        -1.92576161e-20,
        1,
        2.20281448e-13,
        8.74228903e-8,
        2.20281448e-13,
        -1
    ));
    local u40 = nil;
    local u41 = nil;
    local u42, u43;

    if u38 and u39 then
        u34:Add(u39);
        u40 = u34:Clone(newddchem.WindBeams);
        u40.Join.Part0 = u38.camera;
        u40.Parent = u38.camera;
        mainreplication.BetterEnable(u40, true);
        u42 = u34:Clone(newddchem.CamLight);
        u42.Parent = u38.camera;
        mainreplication.BetterEnable(u42, false);
        u43 = u34:Clone(newddchem.CameraEffectAir);
        u43.Join.Part0 = u38.camera;
        u43.Parent = u38.camera;
        mainreplication.BetterEnable(u43, false);
    else
        u42 = nil;
        u43 = nil;
    end;

    u34:Add(function() -- Line: 330
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(2, 0.75);
        mainreplication.sceneEnabled(false);
    end);
    local u44 = u34:Clone(newddchem.BallTrail);
    u44.Parent = u33:FindFirstChild("Ball");
    mainreplication.BetterEnable(u44, true);
    local u45 = u34:Clone(newddchem.ballflare);
    u45.Parent = u33:FindFirstChild("Ball");
    mainreplication.BetterEnable(u45, false);
    local u46 = u34:Clone(newddchem.ballaura);
    u46.Parent = u33:FindFirstChild("Ball");
    mainreplication.BetterEnable(u46, false);
    local u47 = u34:Clone(newddchem.Wings);
    u47.Join.Part0 = u33:FindFirstChild("Torso");
    u47.Parent = workspace.Effects;
    mainreplication.BetterEnable(u47, false);
    local u48 = u34:Clone(newddchem.AuraINAir);
    u48.Join.Part0 = HumanoidRootPart;
    u48.Parent = workspace.Effects;
    mainreplication.BetterEnable(u48, false);
    local u49 = u34:Clone(newddchem.Domain);
    u49.Join.Part0 = HumanoidRootPart;
    syncedDelay(25, function() -- Line: 360
        -- upvalues: u34 (copy), newddchem (copy), HumanoidRootPart (copy), script_KurisVFXHandler (ref), script_KurisMeshEmitUtility (ref)
        local v50 = u34:Clone(newddchem.WindBeams3);
        v50.Join.Part0 = HumanoidRootPart;
        v50.Parent = workspace.Effects;
        local u51 = u34:Clone(newddchem.WindBeams2);
        u51.Parent = v50;
        u51.CFrame = CFrame.new(0.066, 7.556, -11.992) * CFrame.Angles(2.0943951023931953, 0, 0);
        script_KurisVFXHandler(u51, {
            RotationSpeed = 1,
            Rotation = true,
            Duration = 0.867,
            Easing = "Sine",
            EasingDirection = "InOut",
            Properties = {
                Brightness = 0,
                LightEmission = 1,
                TextureSpeed = 0,
                Width0 = 0,
                Width1 = 0
            },
            Offset = CFrame.new(0, 0, -7)
        });
        u34:Add(task.delay(3, function() -- Line: 386
            -- upvalues: u51 (copy)
            u51:Destroy();
        end));
        script_KurisMeshEmitUtility.new(newddchem.WindShockwave):Emit(HumanoidRootPart.CFrame * CFrame.new(
            0.064000003,
            -0.903000116,
            -10.3500004,
            1,
            -6.9388939e-16,
            1.13861381e-13,
            -6.9388939e-16,
            1,
            -2.20281448e-13,
            -1.13512302e-13,
            2.20281448e-13,
            1
        ));
    end);
    syncedDelay(45, function() -- Line: 394
        -- upvalues: u38 (copy), u39 (copy), u41 (ref), u34 (copy), newddchem (copy), mainreplication (ref), u45 (copy), u33 (copy)
        if u38 and u39 then
            u41 = u34:Clone(newddchem.CamFX);
            u41.Join.Part0 = u38.camera;
            u41.Parent = workspace.Effects;
            mainreplication.BetterEnable(u41, true);
        end;

        mainreplication.BetterEnable(u45, true);

        if u33:FindFirstChild("Ball") then
            mainreplication.EmitAttachmentIn({
                Effect = newddchem.ballshine,
                Parent = u33:FindFirstChild("Ball")
            });
        end;
    end);
    syncedDelay(72, function() -- Line: 413
        -- upvalues: mainreplication (ref), u44 (copy)
        mainreplication.BetterEnable(u44, false);
    end);
    syncedDelay(107, function() -- Line: 417
        -- upvalues: u38 (copy), u39 (copy), mainreplication (ref), u41 (ref), u40 (ref), u45 (copy)
        if u38 and u39 then
            mainreplication.BetterEnable(u41, false);
            mainreplication.BetterEnable(u40, false);
        end;

        mainreplication.BetterEnable(u45, false);
    end);
    syncedDelay(180, function() -- Line: 426
        -- upvalues: mainreplication (ref), newddchem (copy), u33 (copy)
        mainreplication.EmitAttachmentIn({
            Effect = newddchem.breath,
            Parent = u33:FindFirstChild("Head")
        });
    end);
    syncedDelay(224, function() -- Line: 433
        -- upvalues: script_Colorcorrectionzstr (ref), u34 (copy), newddchem (copy), HumanoidRootPart (copy), mainreplication (ref), script_KurisMeshEmitUtility (ref)
        script_Colorcorrectionzstr(0.1, 0.5, 0.9, Color3.fromRGB(255, 84, 172), 0.5);
        local v52 = u34:Clone(newddchem.StepFinal);
        v52.Join.Part0 = HumanoidRootPart;
        v52.Parent = workspace.Effects;
        mainreplication.BetterEmit(v52);
        script_KurisMeshEmitUtility.new(newddchem.WindCrescMesh):Emit(v52.CFrame);
        script_KurisMeshEmitUtility.new(newddchem.DragonStart):Emit(v52.CFrame * CFrame.new(0, 0.5, 0));
    end);
    syncedDelay(290, function() -- Line: 446
        -- upvalues: u38 (copy), u39 (copy), u34 (copy), newddchem (copy), mainreplication (ref), u49 (copy), TweenService (ref)
        if u38 and u39 then
            local v53 = u34:Clone(newddchem.Transition);
            v53.Join.Part0 = u38.camera;
            v53.Parent = workspace.Effects;
            mainreplication.BetterEmit(v53);
        end;

        u49.Parent = workspace.Effects;
        TweenService:Create(u49.BroWhat, TweenInfo.new(0.16666666666666666), {
            Transparency = 0
        }):Play();
        TweenService:Create(u49.Sphere, TweenInfo.new(0.16666666666666666), {
            Transparency = 0
        }):Play();
    end);
    syncedDelay(310, function() -- Line: 465
        -- upvalues: mainreplication (ref), u47 (copy), u46 (copy), u48 (copy), u38 (copy), u39 (copy), u42 (ref), u40 (ref), u43 (ref)
        mainreplication.BetterEnable(u47, true);
        mainreplication.BetterEnable(u46, true);
        mainreplication.BetterEnable(u48, true);

        if u38 and u39 then
            mainreplication.BetterEnable(u42, true);
            mainreplication.BetterEnable(u40, true);
            mainreplication.BetterEnable(u43, true);
        end;
    end);
    syncedDelay(354, function() -- Line: 477
        -- upvalues: mainreplication (ref), newddchem (copy), u33 (copy)
        mainreplication.EmitAttachmentIn({
            Effect = newddchem.Eyes,
            Parent = u33:FindFirstChild("Head")
        });
    end);
    syncedDelay(629, function() -- Line: 484
        -- upvalues: mainreplication (ref), u48 (copy), u46 (copy)
        mainreplication.BetterEnable(u48, false);
        mainreplication.BetterEnable(u46, false);
    end);
    syncedDelay(638, function() -- Line: 489
        -- upvalues: u34 (copy), newddchem (copy), HumanoidRootPart (copy), mainreplication (ref), u47 (copy), TweenService (ref), BoatTween (ref)
        local v54 = u34:Clone(newddchem.Shoot);
        v54.Join.Part0 = HumanoidRootPart;
        v54.Parent = workspace.Effects;
        mainreplication.BetterEmit(v54);
        mainreplication.BetterEnable(u47, false);
        task.spawn(function() -- Line: 497
            -- upvalues: u34 (ref), newddchem (ref), HumanoidRootPart (ref), TweenService (ref), BoatTween (ref)
            local u55 = u34:Clone(newddchem.Dragon2);
            u55.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                -3.10399914,
                -0.791682959,
                -1.05189085,
                0.771821022,
                0.396369219,
                0.497178048,
                -0.328808188,
                0.918061972,
                -0.221471012,
                -0.544224024,
                0.00745955436,
                0.838908315
            );
            u55.Parent = workspace.Camera;
            TweenService:Create(u55.beam.front, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = Vector3.new(0, 0, 0)
            }):Play();
            local v56 = TweenService:Create(u55, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = u55.CFrame * CFrame.Angles(0, 0, 0)
            });
            v56:Play();

            for _, descendant in u55:GetDescendants() do
                if descendant:IsA("Beam") then
                    task.spawn(function() -- Line: 506
                        -- upvalues: descendant (copy), BoatTween (ref)
                        descendant.Enabled = true;
                        local v57 = BoatTween:Create(descendant, {
                            Time = 2,
                            EasingStyle = "Quad",
                            EasingDirection = "Out",
                            Reverses = false,
                            StepType = "Heartbeat",
                            Goal = {
                                Transparency = NumberSequence.new(1)
                            }
                        });
                        v57:Play();
                        task.wait(3);
                        v57:Destroy();
                    end);
                end;
            end;

            v56.Completed:Once(function() -- Line: 528
                -- upvalues: u55 (copy)
                task.wait(0.5);
                u55:Destroy();
            end);
        end);
        task.spawn(function() -- Line: 534
            -- upvalues: u34 (ref), newddchem (ref), HumanoidRootPart (ref), TweenService (ref), BoatTween (ref)
            local u58 = u34:Clone(newddchem.Dragon3);
            u58.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                -2.02806854,
                0.204584122,
                1.83230114,
                0.873596072,
                0.0472325683,
                0.484356821,
                0.00133031898,
                0.99504447,
                -0.099432461,
                -0.486652642,
                0.0875077993,
                0.869203329
            );
            u58.Parent = workspace.Camera;
            TweenService:Create(u58.beam.front, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = Vector3.new(0, 0, 0)
            }):Play();
            local v59 = TweenService:Create(u58, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = u58.CFrame * CFrame.Angles(0, 0, 0)
            });
            v59:Play();

            for _, descendant in u58:GetDescendants() do
                if descendant:IsA("Beam") then
                    task.spawn(function() -- Line: 546
                        -- upvalues: descendant (copy), BoatTween (ref)
                        descendant.Enabled = true;
                        local v60 = BoatTween:Create(descendant, {
                            Time = 2,
                            EasingStyle = "Cubic",
                            EasingDirection = "Out",
                            Reverses = false,
                            StepType = "Heartbeat",
                            Goal = {
                                TextureSpeed = 0,
                                Transparency = NumberSequence.new(1)
                            }
                        });
                        v60:Play();
                        task.wait(3);
                        v60:Destroy();
                    end);
                end;
            end;

            v59.Completed:Once(function() -- Line: 569
                -- upvalues: u58 (copy)
                task.wait(0.5);
                u58:Destroy();
            end);
        end);
    end);
    syncedDelay(763, function() -- Line: 577
        -- upvalues: u34 (copy), newddchem (copy), HumanoidRootPart (copy), mainreplication (ref)
        local v61 = u34:Clone(newddchem.AfterKick1);
        v61.Join.Part0 = HumanoidRootPart;
        v61.Parent = workspace.Effects;
        mainreplication.BetterEmit(v61);
    end);
    syncedDelay(799, function() -- Line: 585
        -- upvalues: u34 (copy), newddchem (copy), HumanoidRootPart (copy), mainreplication (ref)
        local v62 = u34:Clone(newddchem.AfterKick1);
        v62.Join.Part0 = HumanoidRootPart;
        v62.Parent = workspace.Effects;
        mainreplication.BetterEmit(v62);
    end);
    syncedDelay(120, function() -- Line: 593
        -- upvalues: u37 (copy), TekrinnDialogue (ref), u33 (copy)
        if u37 then
            return;
        end;

        TekrinnDialogue.Speak(u33, {
            {
                Text = "Wow. Right on the money!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 1.35);
    end);
    syncedDelay(400, function() -- Line: 620
        -- upvalues: u37 (copy), TekrinnDialogue (ref), u33 (copy)
        if u37 then
            return;
        end;

        TekrinnDialogue.Speak(u33, {
            {
                Text = "Jump",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 132)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 0.5,
                    Lifetime = 2
                }
            },
            {
                Text = ", all the cells in my body.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 2.75);
    end);
    syncedDelay(640, function() -- Line: 668
        -- upvalues: u37 (copy), TekrinnDialogue (ref), u33 (copy)
        if u37 then
            return;
        end;

        TekrinnDialogue.Speak(u33, {
            {
                Text = "DRAGON DRIVE!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 53, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 2.75);
    end);
    syncedDelay(90, function() -- Line: 695
        -- upvalues: u37 (copy), TekrinnDialogue (ref), u33 (copy)
        if not u37 then
            return;
        end;

        TekrinnDialogue.Speak(u33, {
            {
                Text = "Wow. Right on the money!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    syncedDelay(373, function() -- Line: 722
        -- upvalues: u37 (copy), TekrinnDialogue (ref), u33 (copy)
        if not u37 then
            return;
        end;

        TekrinnDialogue.Speak(u33, {
            {
                Text = "All the cells in my body..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 1.7);
    end);
    syncedDelay(494, function() -- Line: 749
        -- upvalues: u37 (copy), TekrinnDialogue (ref), u33 (copy)
        if not u37 then
            return;
        end;

        TekrinnDialogue.Speak(u33, {
            {
                Text = "Get ready for blast off!",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 132)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 0.5,
                    Lifetime = 2
                }
            }
        }, 2.5);
    end);
    syncedDelay(664, function() -- Line: 776
        -- upvalues: u37 (copy), TekrinnDialogue (ref), u33 (copy)
        if not u37 then
            return;
        end;

        TekrinnDialogue.Speak(u33, {
            {
                Text = "DRAGON DRIVE!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 53, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 2.75);
    end);
    syncedDelay(850, u34.Destroy, u34);
end;

function u1.FollowGuide(p63) -- Line: 806
    -- upvalues: ReplicatedStorage (copy)
    local u64 = ReplicatedStorage.Resources.FollowGuide:Clone();
    local Frame2 = u64:WaitForChild("Frame"):WaitForChild("Frame2");
    local ImageLabel = Frame2:WaitForChild("ImageLabel");
    local Button = Frame2:WaitForChild("Close"):WaitForChild("Button");
    ImageLabel.Image = p63;
    Button.MouseButton1Up:Once(function() -- Line: 815
        -- upvalues: u64 (copy)
        u64:Destroy();
    end);
end;

function u1.shidoudragonhit(p65, p66) -- Line: 820
    -- upvalues: u1 (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local v67 = p65.HumanoidRootPart or p65.PrimaryPart;
    local _ = p65.Torso;
    local Ball = p65:FindFirstChild("Ball");
    u1.fov(true, 35, 0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    u1.cameraShake(25, 0.8, 7);
    local u68 = ReplicatedStorage.Resources.shidou.kickShot:Clone();
    u68.Weld.Part0 = v67;
    u68.Parent = p65;
    local u69 = ReplicatedStorage.Resources.shidou.windddr:Clone();
    u69.Weld.Part0 = p65.Torso;
    u69.Parent = p65;
    local u70;

    if Ball then
        u70 = ReplicatedStorage.Resources.shidou.ballEffDd:Clone();
        u70.Weld.Part0 = Ball;
        u70.Parent = p65;

        for _, descendant in pairs(u70:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    else
        u70 = nil;
    end;

    for _, descendant in pairs(u69.Tail:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    for _, descendant in pairs(u68["Catch Emitr"]:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    for _, descendant in pairs(u69["Wing emit"]:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(0.8, function() -- Line: 870
        -- upvalues: u68 (copy), u70 (ref), u69 (copy), u1 (ref), Lighting (ref), TweenService (ref), ReplicatedStorage (ref)
        for _, descendant in pairs(u68["End Kick Emit"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        if u70 then
            u70:Destroy();
        end;

        for _, descendant in pairs(u69.Tail:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(3, u68.Destroy, u68);
        task.delay(3, u69.Destroy, u69);
        u1.cameraShake(15, 1, 7);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v71 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v71.Parent = Lighting;
        v71.TintColor = Color3.fromRGB(255, 42, 156);
        v71.Brightness = 0.4;
        v71.Contrast = 1;
        v71.Saturation = -0.4;
        TweenService:Create(v71, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v71, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(1, v71.Destroy, v71);
        u1.fov(false, 120);
        u1.fov(true, 70, 2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end);
    u1.cameraShake(10, 1.5, 6);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.7, BlurEffect.Destroy, BlurEffect);
    local v72 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v72.Parent = Lighting;
    v72.TintColor = Color3.fromRGB(255, 42, 156);
    v72.Brightness = 0.4;
    v72.Contrast = 1;
    v72.Saturation = -0.4;
    TweenService:Create(v72, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v72, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v72.Destroy, v72);
    local v73 = u1.bodyVelocity(v67, 0.8, 0.8);

    if v73 then
        v73.MaxForce = Vector3.new(0, 30000, 0);
    end;
end;

function u1.runningheader(u74) -- Line: 958
    -- upvalues: u1 (copy), ReplicatedStorage (copy), Debris (copy), TweenService (copy), RunService (copy), raycast (copy), Players (copy), Lighting (copy)
    local u75 = u74.HumanoidRootPart or u74.PrimaryPart;

    for _, descendant in ipairs(u75:GetDescendants()) do
        if descendant:IsA("BodyVelocity") then
            descendant:Destroy();
        end;
    end;

    u1.Emit(u74.Head, ReplicatedStorage.Resources.shidou.eemit, 3);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 80;
    NumberValue.Parent = u74;
    Debris:AddItem(NumberValue, 10);
    local u76 = u1.bodyVelocity(u75, 0.5, 1, nil, nil, true);
    TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0), {
        Value = 0
    }):Play();
    local u77 = nil;
    u77 = RunService.RenderStepped:Connect(function(p78) -- Line: 982
        -- upvalues: u76 (copy), u77 (ref), u75 (copy), NumberValue (copy)
        if u76 and u76:IsDescendantOf(game) then
            u76.Velocity = u75.CFrame.LookVector * NumberValue.Value;

            return;
        end;

        u77:Disconnect();
    end);
    task.delay(15, u77.Disconnect, u77);
    local u79 = nil;
    task.delay(0.4, function() -- Line: 997
        -- upvalues: u79 (ref), ReplicatedStorage (ref), u75 (copy), u74 (copy), raycast (ref), TweenService (ref), RunService (ref), Players (ref), u1 (ref), Lighting (ref)
        u79 = ReplicatedStorage.Resources.shidou.Gasterblaser:Clone();
        u79.Root.Root.Part0 = u75;
        u79.Parent = u74;
        local v80 = raycast(u75.Position, u75.CFrame.LookVector * 60, nil, { workspace.map });
        local v81;

        if v80 then
            v81 = CFrame.new(v80.Position, v80.Position + u75.CFrame.LookVector);
        else
            v81 = u75.CFrame + u75.CFrame.LookVector * 60;
        end;

        local u82 = v81 + u75.CFrame.UpVector * 22;
        local v83 = ReplicatedStorage.Resources.shidou.dhEffects:Clone();
        v83.Parent = u74;
        v83:PivotTo(CFrame.new(u75.Position, u75.Position + u82.LookVector) * CFrame.new(0, 10, -50) * CFrame.Angles(0.3490658503988659, 0, 0));
        v83.End.Mesh.Scale = Vector3.new(3.179, 0, 0);
        TweenService:Create(v83.End.Mesh, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(3.179, 1.072, 1.037)
        }):Play();
        TweenService:Create(v83.End.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(v83.End, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = v83.End.CFrame * CFrame.Angles(1.3962634015954636, 0, 0)
        }):Play();
        TweenService:Create(v83.End4, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v83.End3, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(50, 0, 0)
        }):Play();
        TweenService:Create(v83.End2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v83.Twirl, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(15.359, 50, 15.92),
            Transparency = 1,
            CFrame = v83.Twirl.CFrame * CFrame.Angles(0, -0.4174478504920037, 0)
        }):Play();
        task.delay(2, v83.Destroy, v83);
        local u85 = RunService.PreRender:Connect(function(p84) -- Line: 1089
            -- upvalues: u75 (ref), u82 (ref)
            u75.CFrame = u75.CFrame:Lerp(u82, math.min(p84, 0.03333333333333333) * 10);
        end);
        task.delay(0.25, function() -- Line: 1094
            -- upvalues: u85 (ref)
            u85:Disconnect();
        end);

        for _, descendant in ipairs(u79:GetDescendants()) do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end;
        end;

        if Players.LocalPlayer:DistanceFromCharacter(u75.Position) <= 50 then
            u1.cameraShake(15, 2, 4);
            u1.fov(false, 120);
            u1.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Parent = Lighting;
            ColorCorrectionEffect.Contrast = 5;
            task.wait(0.05);
            ColorCorrectionEffect.Contrast = -1;
            task.wait(0.05);
            ColorCorrectionEffect.Contrast = -2;
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                Contrast = 0
            }):Play();
            task.wait(0.5);
            ColorCorrectionEffect:Destroy();
        end;
    end);
    task.wait(1.5833333730697632);

    if u79 then
        u79:Destroy();
    end;
end;

function u1.shidorun(u86) -- Line: 1134
    -- upvalues: ReplicatedStorage (copy), Debris (copy), u1 (copy), TweenService (copy), RunService (copy), mainreplication (copy), actionUtil (copy), Lighting (copy)
    local u87 = u86.HumanoidRootPart or u86.PrimaryPart;
    local u88 = ReplicatedStorage.Resources.shidou.shidourunwind:Clone();
    u88:PivotTo(u87.CFrame);
    u88.RootPos.Weld.Part0 = u87;
    u88.Parent = u86;
    local u89 = ReplicatedStorage.Resources.shidou.Shidowings:Clone();
    u89.Weld.Part0 = u86.Torso;
    u89.Parent = u86;
    task.delay(0.08, function() -- Line: 1150
        -- upvalues: u88 (copy), u89 (copy), u86 (copy), Debris (ref), u1 (ref), u87 (copy), TweenService (ref), RunService (ref), mainreplication (ref)
        for _, descendant in pairs(u88:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u89:GetDescendants()) do
            if descendant:IsA("SpotLight") or (descendant:IsA("PointLight") or descendant:IsA("ParticleEmitter")) then
                descendant.Enabled = true;
            end;
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 180;

        if u86:GetAttribute("RinNoPlay") and u86:HasTag("awaketest") then
            NumberValue.Value = 500;
        end;

        NumberValue.Parent = u86;
        Debris:AddItem(NumberValue, 10);
        local u90 = u1.bodyVelocity(u87, 1, 1.6, nil, nil, true);
        TweenService:Create(NumberValue, TweenInfo.new(1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0), {
            Value = 10
        }):Play();
        local u91 = nil;
        u91 = RunService.RenderStepped:Connect(function(p92) -- Line: 1180
            -- upvalues: u90 (copy), u91 (ref), mainreplication (ref), u87 (ref), NumberValue (copy)
            if u90 and u90:IsDescendantOf(game) then
                u90.Velocity = mainreplication.fixVelocity(u87, u87.CFrame.LookVector * NumberValue.Value);

                return;
            end;

            u91:Disconnect();
        end);
        task.delay(15, u91.Disconnect, u91);
    end);
    task.delay(1, function() -- Line: 1197
        -- upvalues: u88 (copy), u89 (copy)
        for _, descendant in pairs(u88:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u89:GetDescendants()) do
            if descendant:IsA("SpotLight") or (descendant:IsA("PointLight") or descendant:IsA("ParticleEmitter")) then
                descendant.Enabled = false;
            end;
        end;

        local v93 = {};

        for _, descendant in ipairs(u89:GetDescendants()) do
            if descendant:IsA("Beam") then
                table.insert(v93, {
                    beam = descendant,
                    originalTransparency = descendant.Transparency
                });
            end;
        end;

        local v94 = 0;

        while v94 < 0.15 do
            local v95 = v94 / 0.15;

            for _, v in ipairs(v93) do
                local beam = v.beam;
                local originalTransparency = v.originalTransparency;

                if beam and originalTransparency then
                    local v96 = {};

                    for _, v2 in ipairs(originalTransparency.Keypoints) do
                        table.insert(v96, NumberSequenceKeypoint.new(v2.Time, v2.Value + (1 - v2.Value) * v95));
                    end;

                    beam.Transparency = NumberSequence.new(v96);
                end;
            end;

            wait(0.05);
            v94 = v94 + 0.05;
        end;

        for _, v in ipairs(v93) do
            if v.beam then
                v.beam.Transparency = NumberSequence.new(1);
            end;
        end;

        task.delay(4, u89.Destroy, u89);
        task.delay(3, u88.Destroy, u88);
    end);
    task.delay(0.15, function() -- Line: 1257
        -- upvalues: actionUtil (ref), u86 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), u1 (ref)
        if actionUtil.simulatesCharacter(u86) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v97 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v97.Parent = Lighting;
            v97.TintColor = Color3.fromRGB(255, 21, 146);
            v97.Brightness = 0.4;
            v97.Contrast = 1;
            v97.Saturation = -0.4;
            TweenService:Create(v97, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v97, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v97.Destroy, v97);
            u1.fov(false, 100);
            u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            u1.cameraShake(10, 1.5, 6);
        end;
    end);
end;

function u1.formlessflow(u98, p99) -- Line: 1325
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), Brightness (copy), Density (copy), Color (copy)
    local v100 = u98.HumanoidRootPart or u98.PrimaryPart;
    local _ = u98.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local Ball = u98:FindFirstChild("Ball");
    u1.sceneEnabled(true);
    local BloomEffect = Instance.new("BloomEffect");
    BloomEffect.Intensity = 0.4;
    BloomEffect.Size = 30;
    BloomEffect.Threshold = 2.5;
    BloomEffect.Parent = Lighting;
    local u101 = ReplicatedStorage.Resources.shidou.shidouflowvar:Clone();
    u101:PivotTo(v100.CFrame);
    u101.Parent = u98;

    if Util.canshiftcolor(LocalPlayer, u98) then
        vfxUtil.LeanTowardsColor(u101, u98:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u98:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u102 = ReplicatedStorage.Resources.shidou.formlessball:Clone();
    u102.Weld.Part0 = Ball;
    u102.Parent = u98;
    local u103 = ReplicatedStorage.Resources.shidou.formlesswing:Clone();
    u103.Weld.Part0 = u98.Torso;
    u103.Parent = u101;
    local u104 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u104.Parent = Lighting;
    u104.FarIntensity = 0;
    TweenService:Create(u104, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local v105;

    if u98:GetAttribute("femlock") then
        soundUtil:play(ReplicatedStorage.Resources.shidou.Femvoicelines.Formless, SoundService, {
            Character = u98
        });
        v105 = true;
    else
        v105 = soundUtil:play(ReplicatedStorage.Resources.shidou["formless in flow_1"], SoundService, {
            Character = u98
        }).Name == "Dub";
    end;

    u1.cutsceneohiocamera(v100, ReplicatedStorage.Resources.shidou.formlessflow, ReplicatedStorage.Resources.shidou.formlessFOV);

    if not v105 then
        TekrinnDialogue.Speak(u98, {
            {
                Text = "With my ",
                Bold = true,
                TypeSpeed = 0.035,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            },
            {
                Text = "goal",
                Bold = true,
                TypeSpeed = 0.045,
                Shake = {
                    Enabled = true,
                    Intensity = 15,
                    Lifetime = 0.5
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) })
            },
            {
                Text = ", I\'LL ",
                Bold = true,
                TypeSpeed = 0.035,
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 0.3
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            },
            {
                Text = "BEAT ",
                Bold = true,
                TypeSpeed = 0.045,
                Shake = {
                    Enabled = true,
                    Intensity = 15,
                    Lifetime = 0.5
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) })
            },
            {
                Text = "YOU UP!",
                Bold = true,
                TypeSpeed = 0.035,
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 0.3
                },
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
            }
        });
    end;

    if v105 then
        task.delay(0.5, function() -- Line: 1456
            -- upvalues: TekrinnDialogue (ref), u98 (copy)
            TekrinnDialogue.Speak(u98, {
                {
                    Text = "EAT THIS!",
                    Bold = true,
                    TypeSpeed = 0.035,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 15,
                        Lifetime = 0.5
                    }
                }
            }, 3);
        end);
    end;

    for _, descendant in pairs(u101.areaeffects:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    local u106 = Util.Preload(ReplicatedStorage.Resources.shidou.ImpactFrame4);
    task.delay(1, function() -- Line: 1485
        -- upvalues: Util (ref), ReplicatedStorage (ref), u101 (copy), u103 (copy)
        Util.Gif(ReplicatedStorage.Resources.shidou.ImpactFrame4, 30);

        for _, descendant in pairs(u101.LASTPARTICLES:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u101.areaeffects:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.wait(0.2);

        for _, descendant in ipairs(u103:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.65, function() -- Line: 1506
        -- upvalues: u106 (copy), u104 (copy), BloomEffect (copy), u101 (copy), u102 (copy), u1 (ref), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref)
        u106:Destroy();
        u104:Destroy();
        BloomEffect:Destroy();
        u101:Destroy();
        u102:Destroy();
        u1.sceneEnabled(false);
        u1.ultFlash();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u1.fov(false, 70);
    end);
end;

local u107 = nil;

function u1.awkMusic(p108, p109, p110, p111, u112, p113) -- Line: 1526
    -- upvalues: Players (copy), u107 (ref), TweenService (copy), soundUtil (copy), SoundService (copy), actionUtil (copy), trove (copy), Lighting (copy), u1 (copy)
    local LocalPlayer2 = Players.LocalPlayer;
    local setting2 = LocalPlayer2:FindFirstChild("setting");

    if setting2 and (setting2:FindFirstChild("music") and not setting2.music.Value) then
        return;
    end;

    if p110 == "finalMatchup" then
        p110 = LocalPlayer2.Team.Name == p113 and Color3.fromRGB(255, 60, 135) or Color3.fromRGB(70, 0, 0);
    end;

    if u107 and u107.Parent then
        local u114 = u107;
        local v115 = TweenService:Create(u114, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Volume = 0
        });
        v115:Play();
        v115.Completed:Once(function() -- Line: 1550
            -- upvalues: u114 (copy)
            if u114 then
                u114:Destroy();
            end;
        end);
    end;

    if not p108 then
        u107 = nil;

        return;
    end;

    local v116 = false;
    local u117 = 0;
    local v118;

    if typeof(u112) == "Instance" then
        local Attribute = u112:GetAttribute("heat");

        if (Attribute or u112 == LocalPlayer2.Character) and (typeof(p108) == "Instance" and p108:IsA("Sound")) then
            if Attribute then
                setting2 = Players:GetPlayerFromCharacter(p111 or u112);

                if setting2 then
                    setting2 = setting2:FindFirstChild("setting");
                end;
            end;

            local v119;

            if setting2 then
                v119 = setting2:FindFirstChild("flowMusicId");
            end;

            if v119 and v119.Value > 0 then
                local flowMusicPitch = setting2:FindFirstChild("flowMusicPitch");
                local flowMusicTimestamp = setting2:FindFirstChild("flowMusicTimestamp");
                v118 = Instance.new("Sound");
                v118.SoundId = `rbxassetid://{v119.Value}`;
                v118.Volume = p108.Volume;
                v118.Looped = p108.Looped;
                v118.SoundGroup = p108.SoundGroup;
                v118.PlaybackSpeed = flowMusicPitch and flowMusicPitch.Value or 1;
                u117 = flowMusicTimestamp and flowMusicTimestamp.Value or 0;
                v116 = true;
            else
                v118 = p108;
            end;
        else
            v118 = p108;
        end;
    else
        v118 = p108;
    end;

    local u120 = soundUtil:play(v118, SoundService);
    u120.Name = "UltimateTheme";
    local _ = u120.Volume;
    u107 = u120;

    if v116 and u117 > 0 then
        local function applyStart() -- Line: 1602
            -- upvalues: u120 (copy), u117 (ref)
            local TimeLength = u120.TimeLength;
            local v121;

            if TimeLength > 0 then
                v121 = math.clamp(u117, 0, TimeLength - 0.05);
            else
                v121 = u117;
            end;

            u120.TimePosition = v121;
        end;

        if u120.TimeLength > 0 then
            local TimeLength = u120.TimeLength;
            local v122;

            if TimeLength > 0 then
                v122 = math.clamp(u117, 0, TimeLength - 0.05);
            else
                v122 = u117;
            end;

            u120.TimePosition = v122;
        else
            u120.Loaded:Once(applyStart);
        end;
    end;

    local workspace2 = actionUtil.getworkspace();
    local u123 = trove.new();

    if typeof(u112) == "Instance" then
        u123:AttachToInstance(u112);
    end;

    local u124;

    if actionUtil.checkStyle(u112) == "rin" and u112:GetAttribute("RinNoPlay") then
        u124 = script.DestroyerCorrection:Clone();
        local v125;

        if workspace2.disabled.Value then
            v125 = nil;
        else
            v125 = Lighting;
        end;

        u124.Parent = v125;
    else
        u124 = nil;
    end;

    u123:Add(function() -- Line: 1628
        -- upvalues: u124 (ref), TweenService (ref), u120 (copy), u107 (ref)
        local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

        if u124 then
            local v126 = TweenService:Create(u124, TweenInfo_new_ret, {
                Brightness = 0,
                Contrast = 0,
                Saturation = 0,
                TintColor = Color3.new(1, 1, 1)
            });
            v126:Play();
            v126.Completed:Once(function() -- Line: 1638
                -- upvalues: u124 (ref)
                u124:Destroy();
            end);
        end;

        local v127 = TweenService:Create(u120, TweenInfo_new_ret, {
            Volume = 0
        });
        v127:Play();
        v127.Completed:Once(function() -- Line: 1648
            -- upvalues: u120 (ref), u107 (ref)
            u120:Destroy();

            if u107 == u120 then
                u107 = nil;
            end;
        end);
    end);
    u123:Connect(workspace2.disabled.Changed, function(p128) -- Line: 1656
        -- upvalues: u124 (ref), Lighting (ref), workspace2 (copy), u112 (copy), u120 (copy)
        if u124 then
            local v129;

            if p128 then
                v129 = nil;
            else
                v129 = Lighting;
            end;

            u124.Parent = v129;
        end;

        if p128 and (workspace2.disabledIsAwakening.Value and workspace2.personWhoDisabled.Value == u112) then
            u120.Playing = true;

            return;
        end;

        u120.Playing = not p128;
    end);
    u123:Connect(workspace2.lastAwaken.Changed, function(p130) -- Line: 1667
        -- upvalues: u123 (copy)
        u123:Destroy();
    end);
    u1.awkScreen(u120, p110, p113 ~= nil);
end;

function u1.nearGoalWarning(p131) -- Line: 1674
    -- upvalues: ReplicatedStorage (copy), TweenService (copy), soundUtil (copy), SoundService (copy), u1 (copy)
    local v132 = ReplicatedStorage.Resources[`{p131}Warn`]:Clone();
    v132.Parent = workspace.Effects;
    TweenService:Create(v132.SurfaceGui.StripeTex, TweenInfo.new(1), {
        ImageTransparency = 1
    }):Play();
    task.delay(1, v132.Destroy, v132);
    soundUtil:play(ReplicatedStorage.Resources.notisound, SoundService);
    u1.notification("The ball speed reduces in the penalty zone");
end;

function u1.notification(p133, p134, p135, p136) -- Line: 1687
    -- upvalues: soundUtil (copy), SoundService (copy), PlayerGui (copy), TweenService (copy)
    local v137 = 3;
    local v138;

    if typeof(p133) == "table" then
        v138 = p133[1];

        if p133[2] then
            v137 = p133[2];
        end;
    else
        v138 = p133;
    end;

    if p135 then
        soundUtil:play(p135, SoundService);
    end;

    local v139 = PlayerGui.Notification.Frame.base:Clone();
    v139.Parent = PlayerGui.Notification.Frame;
    v139.Visible = true;
    local Size = v139.Size;

    if p136 then
        UDim2.new(Size.X.Scale * p136, Size.X.Offset * p136, Size.Y.Scale * p136, Size.Y.Offset * p136);
    end;

    v139.TextLabel.Text = v138;
    v139.TextLabel.TextColor3 = typeof(p134) == "Color3" and p134 and p134 or Color3.fromRGB(255, 255, 255);
    local Position = v139.TextLabel.Position;
    local UDim2_new_ret = UDim2.new(0, 0, -0.5, 0);
    v139.TextLabel.Position = UDim2_new_ret;
    v139.TextLabel.TextTransparency = 1;
    v139.TextLabel.TextStrokeTransparency = 1;
    TweenService:Create(v139.TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        TextStrokeTransparency = 0,
        Position = Position
    }):Play();
    local v140 = TweenService:Create(v139.TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        TextTransparency = 1,
        TextStrokeTransparency = 1,
        Position = UDim2_new_ret
    });
    task.wait(v137);
    v140:Play();
    task.delay(0.5, v139.Destroy, v139);
end;

function u1.notification2(p141: string, p142: number?, p143: string?, p144: any, p145: userdata?) -- Line: 1740
    -- upvalues: PlayerGui (copy), soundUtil (copy), SoundService (copy), TweenService (copy)
    local Frame = PlayerGui.Notification2.Frame;

    if p145 then
        soundUtil:play(p145, SoundService);
    end;

    local v146 = Frame.base:Clone();
    v146.Visible = true;
    local Frame2 = v146.Frame;
    Frame2.Dialogue.Text = p141;

    if typeof(p143) == "string" then
        Frame2.Title.Text = p143;
    else
        local Position = Frame2.Dialogue.Position;
        local Size = Frame2.Dialogue.Size;
        local Y = Frame2.Title.Size.Y;
        Frame2.Title.Visible = false;
        Frame2.Dialogue.Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale + Y.Scale, Size.Y.Offset + Y.Offset);
        Frame2.Dialogue.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale - Y.Scale, Position.Y.Offset - Y.Offset);
    end;

    if tonumber(p144) then
        p144 = `rbxassetid://{p144}`;
    end;

    if typeof(p144) == "string" then
        Frame2.Icon.Image = p144;
    else
        local Position = Frame2.Dialogue.Position;
        local Size = Frame2.Dialogue.Size;
        local X = Frame2.Icon.Size.X;
        Frame2.Icon.Visible = false;
        Frame2.Dialogue.Size = UDim2.new(Size.X.Scale + X.Scale, Size.X.Offset + X.Offset, Size.Y.Scale, Size.Y.Offset);
        Frame2.Dialogue.Position = UDim2.new(Position.X.Scale - X.Scale, Position.X.Offset - X.Offset, Position.Y.Scale, Position.Y.Offset);
    end;

    v146.GroupTransparency = 1;
    v146.Parent = Frame;
    TweenService:Create(v146, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    local v147 = TweenService:Create(v146, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        GroupTransparency = 1
    });
    task.wait(p142 or 3);
    v147:Play();
    task.delay(v147.TweenInfo.Time, v146.Destroy, v146);
end;

function u1.cardRig(u148, u149, u150, p151, p152) -- Line: 1808
    -- upvalues: soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), RunService (copy), workspace_CurrentCamera (copy), animationUtil (copy), Util (copy), u1 (copy)
    soundUtil:play(ReplicatedStorage.Resources.rarityEff.cardsound, SoundService);
    local u153 = ReplicatedStorage.Resources.cardRig:Clone();
    u153:SetAttribute("IgnoresTheKid", true);
    u153.Parent = workspace.Effects;

    if p151 then
        u153.Card.SurfaceGui2.TextLabel.Text = p151;
    end;

    u153.Card.Size = Vector3.new(u153.Card.Size.X * (p152 or 1), u153.Card.Size.Y, u153.Card.Size.Z);
    local v154 = RunService.PreRender:connect(function() -- Line: 1821
        -- upvalues: u153 (copy), workspace_CurrentCamera (ref)
        u153:PivotTo(workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -1.5));
    end);
    animationUtil:loadAnimation(u153, ReplicatedStorage.Resources.cardAnim):Play(0);
    task.delay(1.516666666666667, function() -- Line: 1828
        -- upvalues: soundUtil (ref), u150 (copy), SoundService (ref), Util (ref), u1 (ref), u153 (copy), u149 (copy)
        soundUtil:play(u150, SoundService);

        if not Util.isepilepsysafe() then
            u1.Emit(u153.root, u149, 3);
            u1.cameraShake(15, 0.55, 2);
        end;
    end);
    task.delay(2.835, function() -- Line: 1837
        -- upvalues: ReplicatedStorage (ref), u153 (copy)
        ReplicatedStorage.Resources.shidou.line:Clone().Parent = u153.Card;
    end);
    task.delay(1.1, function() -- Line: 1842
        -- upvalues: u153 (copy), u148 (copy)
        u153.Card.style.TextLabel.Text = u148;
    end);
    task.delay(2.9833333333333334, u153.Destroy, u153);
    task.delay(2.9833333333333334, v154.Disconnect, v154);
end;

local u155 = {};

local function bindFreeze(u156, p157, u158, u159) -- Line: 1852
    if u156 and not p157 then
        local function onFrozen() -- Line: 1857
            -- upvalues: u156 (copy), u159 (copy), u158 (copy)
            local v160 = u156:GetAttribute("frozen") or false;
            u159.freeze = v160;

            for _, v in u158 do
                if v160 then
                    v:Pause();
                else
                    v:Play();
                end;
            end;
        end;

        onFrozen();

        return u156:GetAttributeChangedSignal("frozen"):Connect(onFrozen);
    end;
end;

local function runTimer(p161, p162, p163) -- Line: 1874
    local v164 = tick();
    local v165 = 0;

    while v165 < p161 do
        if p163 and p163() then
            return false;
        end;

        task.wait();
        local v166 = tick();

        if not (p162 and p162()) then
            v165 = v165 + (v166 - v164);
        end;

        v164 = v166;
    end;

    return true;
end;

function u1.cooldown(p167, p168, p169) -- Line: 1895
    -- upvalues: u155 (copy), u1 (copy), PlayerGui (copy), LocalPlayer (copy), TweenService (copy), runTimer (copy)
    local v170 = p169 or false;

    if u155[p167] then
        u1.removecooldown(p167, true);
    end;

    if not PlayerGui:FindFirstChild("Hotbar") then
        return;
    end;

    local v171 = PlayerGui.Hotbar.Backpack.Hotbar:FindFirstChild(p167);
    local Character = LocalPlayer.Character;

    if v171 then
        v171.Cooldown.Visible = true;
        v171.Cooldown.Size = UDim2.new(1, 0, -1, 0);
        local v172 = TweenService:Create(v171.Cooldown, TweenInfo.new(p168, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 0, 0)
        });
        local u173 = {
            cancelled = false,
            freeze = false,
            tween = v172
        };
        u155[p167] = u173;
        v172:Play();
        local u174 = { v172 };
        local v175;

        if Character and not v170 then
            local function v177() -- Line: 1857
                -- upvalues: Character (copy), u173 (copy), u174 (copy)
                local v176 = Character:GetAttribute("frozen") or false;
                u173.freeze = v176;

                for _, v in u174 do
                    if v176 then
                        v:Pause();
                    else
                        v:Play();
                    end;
                end;
            end;

            v177();
            v175 = Character:GetAttributeChangedSignal("frozen"):Connect(v177);
        else
            v175 = nil;
        end;

        runTimer(p168, function() -- Line: 2003
            -- upvalues: u173 (copy)
            return u173.freeze;
        end, function() -- Line: 2006
            -- upvalues: u173 (copy)
            return u173.cancelled;
        end);

        if v175 then
            v175:Disconnect();
        end;

        if u155[p167] ~= u173 then
            return;
        end;

        u155[p167] = nil;

        if not v171:IsDescendantOf(game) or u173.cancelled then
            return;
        end;

        v171.Cooldown.Visible = false;

        return;
    end;

    local BaseCooldown = PlayerGui.Hotbar.BaseCooldown;
    local u178 = BaseCooldown.Base:Clone();
    u178.Frame.TextLabel.Text = p167;
    u178.Visible = true;
    u178.Parent = BaseCooldown;
    local UDim2_new_ret = UDim2.new(1, 0, 0, 0);
    u178.Frame.Position = UDim2_new_ret;
    local v179 = TweenService:Create(u178.Frame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    });
    local v180 = TweenService:Create(u178.Frame.Frame, TweenInfo.new(p168, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 0, 0.07, 0)
    });
    local u181 = {
        cancelled = false,
        freeze = false,
        tween = v180,

        destroy = function() -- Line: 1933, Name: destroy
            -- upvalues: u178 (ref)
            if u178 and u178:IsDescendantOf(game) then
                u178:Destroy();
            end;
        end
    };
    u155[p167] = u181;
    v179:Play();
    v180:Play();
    local u182 = { v179, v180 };
    local v183;

    if Character and not v170 then
        local function v185() -- Line: 1857
            -- upvalues: Character (copy), u181 (copy), u182 (copy)
            local v184 = Character:GetAttribute("frozen") or false;
            u181.freeze = v184;

            for _, v in u182 do
                if v184 then
                    v:Pause();
                else
                    v:Play();
                end;
            end;
        end;

        v185();
        v183 = Character:GetAttributeChangedSignal("frozen"):Connect(v185);
    else
        v183 = nil;
    end;

    runTimer(p168, function() -- Line: 1949
        -- upvalues: u181 (copy)
        return u181.freeze;
    end, function() -- Line: 1952
        -- upvalues: u181 (copy)
        return u181.cancelled;
    end);

    if v183 then
        v183:Disconnect();
    end;

    if u155[p167] ~= u181 then
        return;
    end;

    u155[p167] = nil;

    if u181.cancelled or not u178:IsDescendantOf(game) then
        return;
    end;

    TweenService:Create(u178.Frame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Position = UDim2_new_ret
    }):Play();
    task.delay(1, u178.Destroy, u178);
end;

function u1.removecooldown(p186, p187) -- Line: 2028
    -- upvalues: PlayerGui (copy), u155 (copy), TweenService (copy)
    local v188 = PlayerGui.Hotbar.Backpack.Hotbar:FindFirstChild(p186);
    local v189 = u155[p186];

    if v189 then
        v189.cancelled = true;

        if v189.tween then
            v189.tween:Cancel();
        end;

        if v189.destroy then
            v189.destroy();
        end;

        u155[p186] = nil;
    end;

    if not v188 then
        return;
    end;

    if p187 then
        v188.Cooldown.Size = UDim2.new(1, 0, 0, 0);
    else
        v188.Cooldown.Size = UDim2.new(1, 0, -1, 0);
        TweenService:Create(v188.Cooldown, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 0, 0)
        }):Play();
        task.wait(0.1);
    end;

    if v188:IsDescendantOf(game) then
        v188.Cooldown.Visible = false;
    end;
end;

function u1.awkScreen(p190: userdata, p191: any, p192: any) -- Line: 2067
    -- upvalues: Util (copy), Players (copy), ReplicatedStorage (copy), LocalPlayer (copy)
    if Util.isepilepsysafe() then
        return;
    end;

    local setting2 = Players.LocalPlayer:FindFirstChild("setting");

    if setting2 and (setting2:FindFirstChild("flowScreen") and not setting2.flowScreen.Value) then
        return;
    end;

    local u193 = ReplicatedStorage.Resources.glowscreen:Clone();
    u193.Parent = LocalPlayer.PlayerGui;
    u193.ImageLabel2.ImageColor3 = p191 or Color3.fromRGB(0, 255, 0);
    u193.ImageLabel2.ImageTransparency = 1;
    local u194 = true;
    p190.AncestryChanged:Once(function() -- Line: 2088, Name: destroy
        -- upvalues: u193 (copy), u194 (ref)
        u193:Destroy();
        u194 = true;
    end);

    while u194 and (u193:IsDescendantOf(game) and u193:IsDescendantOf(game)) do
        if p190.Volume <= 0 or ReplicatedStorage.workspace.disabled.Value and not p192 then
            u193.ImageLabel2.ImageTransparency = 1;
        else
            u193.ImageLabel2.ImageTransparency = 1 - p190.PlaybackLoudness / 1000 * 2;
        end;

        task.wait();
    end;
end;

function u1.debrisCone(p195: userdata, p196: any) -- Line: 2123
    -- upvalues: u1 (copy), raycast (copy), TweenService (copy), Debris (copy), ReplicatedStorage (copy)
    Random.new();
    local CFrame2 = p195.CFrame;
    u1.forwardDash(p195.CFrame * CFrame.new(0, 0, p196 * 3), p195.CFrame);
    local v197 = raycast(CFrame2.Position, Vector3.new(-0, -5, -0));

    if not v197 then
        return;
    end;

    if v197.Instance.CanCollide then
        for i = 1, p196 do
            local u198 = raycast((CFrame.new(v197.Position, v197.Position + CFrame2.LookVector) * CFrame.new(i / 2 + 3, 0, i * -2.6 + -3.5)).Position + v197.Normal * 5, -v197.Normal * 10);

            if u198 then
                local Part = Instance.new("Part");
                Part.Size = Vector3.new(i * 0.2 + 3, i * 0.3 + 1, i * 0.4 + 1);
                Part.CFrame = CFrame.new(u198.Position, u198.Position + CFrame2.LookVector) * CFrame.new(0, -5, 0);
                Part.CanCollide = true;
                Part.Anchored = true;
                Part.Material = u198.Material;
                Part.Color = u198.Instance.Color;
                Part.Parent = workspace.Effects;
                local TweenInfo_new_ret = TweenInfo.new(0.1);
                local v199 = {};
                local v200 = CFrame.new(u198.Position, u198.Position + CFrame2.LookVector) * CFrame.new(Random.new():NextNumber(-i, i) / 3, -Part.Size.Y / 3, 0);
                local CFrame_Angles = CFrame.Angles;
                local v201 = Random.new():NextNumber(0, 30);
                v199.CFrame = v200 * CFrame_Angles(0, 0, (math.rad(v201)));
                TweenService:Create(Part, TweenInfo_new_ret, v199):Play();
                task.delay(Random.new():NextNumber(3, 6), function() -- Line: 2163
                    -- upvalues: TweenService (ref), Part (copy), u198 (copy), CFrame2 (copy), i (copy), Debris (ref)
                    TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        CFrame = CFrame.new(u198.Position, u198.Position + CFrame2.LookVector) * CFrame.new(-i, -Part.Size.Y * 2, 0)
                    }):Play();
                    Debris:AddItem(Part, 1);
                end);
                task.delay(0.1, function() -- Line: 2173
                    -- upvalues: ReplicatedStorage (ref), u198 (copy), Debris (ref)
                    local v202 = ReplicatedStorage.Resources.rockSmoke:Clone();
                    v202.CFrame = CFrame.new(u198.Position);
                    v202.Parent = workspace.Effects;

                    for _, descendant in v202:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Color = ColorSequence.new(u198.Instance.Color);
                            descendant:Emit(5);
                        end;
                    end;

                    Debris:AddItem(v202, 4);
                end);
            end;

            local u203 = raycast((CFrame.new(v197.Position, v197.Position + CFrame2.LookVector) * CFrame.new(-3 - i / 2, 0, i * -2.6 + -3.5)).Position + v197.Normal * 5, -v197.Normal * 10);

            if u203 then
                local Part = Instance.new("Part");
                Part.Size = Vector3.new(i * 0.2 + 3, i * 0.3 + 0.5, i * 0.4 + 1);
                Part.CFrame = CFrame.new(u203.Position, u203.Position + CFrame2.LookVector) * CFrame.new(0, -5, 0);
                Part.CanCollide = true;
                Part.Anchored = true;
                Part.Material = u203.Material;
                Part.Color = u203.Instance.Color;
                Part.Parent = workspace.Effects;
                local TweenInfo_new_ret = TweenInfo.new(0.1);
                local v204 = {};
                local v205 = CFrame.new(u203.Position, u203.Position + CFrame2.LookVector) * CFrame.new(Random.new():NextNumber(-i, i) / 3, -Part.Size.Y / 3, 0);
                local CFrame_Angles = CFrame.Angles;
                local v206 = Random.new():NextNumber(-30, 0);
                v204.CFrame = v205 * CFrame_Angles(0, 0, (math.rad(v206)));
                TweenService:Create(Part, TweenInfo_new_ret, v204):Play();
                task.delay(Random.new():NextNumber(3, 6), function() -- Line: 2210
                    -- upvalues: TweenService (ref), Part (copy), u203 (copy), CFrame2 (copy), i (copy), Debris (ref)
                    TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        CFrame = CFrame.new(u203.Position, u203.Position + CFrame2.LookVector) * CFrame.new(i, -Part.Size.Y * 2, 0)
                    }):Play();
                    Debris:AddItem(Part, 1);
                end);
                task.delay(0.1, function() -- Line: 2220
                    -- upvalues: ReplicatedStorage (ref), u203 (copy), Debris (ref)
                    local v207 = ReplicatedStorage.Resources.rockSmoke:Clone();
                    v207.CFrame = CFrame.new(u203.Position);
                    v207.Parent = workspace.Effects;

                    for _, descendant in v207:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Color = ColorSequence.new(u203.Instance.Color);
                            descendant:Emit(5);
                        end;
                    end;

                    Debris:AddItem(v207, 4);
                end);
            end;

            task.wait(0.01);
            local _ = i;
        end;

        return v197;
    end;
end;

function u1.debrisZone(p208: userdata, p209: any, p210: any, p211: any, p212: any, p213: any, p214: any, p215: any) -- Line: 2242
    -- upvalues: raycast (copy), TweenService (copy), Debris (copy)
    if p215 and Random.new():NextInteger(1, 3) ~= 3 then
        return;
    end;

    local v216 = p212 or CFrame.new();
    local Random_new_ret = Random.new();
    local v217;

    if p211 then
        v217 = raycast(p208.CFrame * v216.Position, p211);
    else
        local AssemblyLinearVelocity = p208.AssemblyLinearVelocity;
        local math_log_ret = math.log(3 + AssemblyLinearVelocity.Magnitude * 15);
        v217 = raycast(p208.Position, AssemblyLinearVelocity.Unit * math_log_ret, nil, nil, Vector3.new(10, 10, 10));
    end;

    if not v217 then
        return;
    end;

    if v217.Instance.CanCollide then
        local v218 = CFrame.new(v217.Position, v217.Position + v217.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        local v219 = p210 / 2;

        for i = 1, v219 do
            local math_random_ret = math.random(1, 3);
            local Part = Instance.new("Part");
            local v220 = Random_new_ret:NextNumber(1, p209);
            Part.Anchored = false;
            Part.CanCollide = true;
            Part.Material = v217.Material;
            Part.Color = v217.Instance.Color;
            Part.Size = Vector3.new(0.75, 0.75, 0.75) * math_random_ret;
            Part.CFrame = v218 * CFrame.new(0, 6, 0);
            Part.Parent = workspace.Effects;
            local v221 = Random_new_ret:NextNumber(-25, 25);
            local v222 = Random_new_ret:NextNumber(-25, 25);
            Part.AssemblyAngularVelocity = Vector3.new(v221, v222, Random_new_ret:NextNumber(-25, 25));
            local CFrame_Angles = CFrame.Angles;
            local v223 = Random_new_ret:NextNumber(-25, 25);
            local v224 = CFrame_Angles(0, 6.283185307179586 * i / v219 + math.rad(v223), 0);
            local CFrame_Angles2 = CFrame.Angles;
            local v225 = Random_new_ret:NextNumber(15, 20);
            Part.AssemblyLinearVelocity = (v224 * CFrame_Angles2(math.rad(v225), 0, 0)).UpVector * (v220 * 10);
            Part.CollisionGroup = "debris";

            if v217.Instance.Material == Enum.Material.Grass then
                Part.Material = Enum.Material.Mud;
                Part.Color = Color3.fromRGB(102, 51, 0);
            end;

            task.delay(Random_new_ret:NextNumber(2, 4), function() -- Line: 2367
                -- upvalues: TweenService (ref), Part (copy)
                TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 1,
                    Size = Part.Size / 2
                }):Play();
                task.wait(1);
                Part:Destroy();
            end);
            local _ = i;
        end;

        for i = 1, p210 do
            local v226 = 1 * Random_new_ret:NextInteger(1, p209);
            local v227 = v218 * CFrame.Angles(0, 6.283185307179586 * i / p210, 0) * CFrame.new(0, 2, -v226);
            local v228 = v226 < 4 and 4 or v226 / 2;
            local v229 = raycast(v227.Position + v217.Normal * 5, -v217.Normal * 10);
            local v230;

            if v229 then
                local Part = Instance.new("Part");
                Part.Size = Vector3.new(v228, v228 / 2, v228);
                Part.Material = v229.Material;
                Part.Color = v229.Instance.Color;
                Part.CanCollide = true;

                if v229.Instance.Material == Enum.Material.Grass then
                    Part.Material = Enum.Material.Mud;
                    Part.Color = Color3.fromRGB(102, 51, 0);
                end;

                local u231 = v227.Rotation + v229.Position + Vector3.new(0, -4, 0);
                local CFrame_Angles = CFrame.Angles;
                local v232 = Random_new_ret:NextNumber(5, 50);
                local v233 = u231 * CFrame_Angles(math.rad(v232), 0, 0) + Vector3.new(0, 3.5, 0);
                Part.CFrame = u231;
                Part.Parent = workspace.Effects;
                Debris:AddItem(Part, 8.5);
                TweenService:Create(Part, TweenInfo.new(Random_new_ret:NextNumber(0.1, 0.2), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    CFrame = v233
                }):Play();
                task.delay(Random_new_ret:NextNumber(4, 5), function() -- Line: 2419
                    -- upvalues: TweenService (ref), Part (copy), u231 (copy)
                    TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        CFrame = u231
                    }):Play();
                    task.wait(1);
                    Part:Destroy();
                end);
                v230 = i;
            else
                v230 = i;
            end;
        end;

        return v217;
    end;
end;

function u1.follow(u234: userdata, u235: any) -- Line: 2441
    -- upvalues: RunService (copy)
    local u237 = RunService.PreRender:connect(function(p236) -- Line: 2442
        -- upvalues: u234 (copy), u235 (copy)
        u234.CFrame = u234.CFrame:Lerp(u235, p236 * 20);
    end);
    task.delay(0.1, function() -- Line: 2445
        -- upvalues: u237 (copy)
        u237:Disconnect();
    end);
end;

function u1.rootCamera(u238: userdata, p239: any) -- Line: 2450
    -- upvalues: RunService (copy), workspace_CurrentCamera (copy), Mouse (copy), raycast (copy)
    u238.Anchored = true;
    local u244 = RunService.PreRender:connect(function(p240) -- Line: 2453
        -- upvalues: workspace_CurrentCamera (ref), Mouse (ref), raycast (ref), u238 (copy)
        local v241 = workspace_CurrentCamera:ViewportPointToRay(Mouse.X, Mouse.Y);
        local v242 = raycast(v241.Origin, v241.Direction * 500);
        local v243 = v242 and v242.Position or v241.Origin + v241.Direction * 1000;
        local unit = (Mouse.Hit.Position - u238.Position).unit;
        math.atan2(unit.Z, unit.X);
        local math_asin_ret = math.asin(unit.Y);
        local math_deg_ret = math.deg(math_asin_ret);

        if math_deg_ret > 45 or math_deg_ret < -45 then
            return;
        end;

        u238.CFrame = u238.CFrame:Lerp(CFrame.new(u238.Position, v243), p240 * 20);
    end);
    task.delay(p239, function() -- Line: 2472
        -- upvalues: u238 (copy), u244 (copy)
        u238.Anchored = false;
        u244:Disconnect();
    end);
end;

function u1.forwardDash(p245, p246) -- Line: 2478
    -- upvalues: ReplicatedStorage (copy), TweenService (copy), Debris (copy)
    local Magnitude = (p245.Position - p246.Position).Magnitude;
    local v247 = ReplicatedStorage.Resources.DashMesh:Clone();
    v247.Parent = workspace.Effects;
    v247:PivotTo(p246);
    v247.MeshPart.Size = Vector3.new(50, Magnitude / 2, 50);
    TweenService:Create(v247.MeshPart, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(1, Magnitude / 2, 1),
        CFrame = v247.MeshPart.CFrame * CFrame.new(0, -Magnitude, 0)
    }):Play();
    v247.Start.Size = Vector3.new(15, 0, 15);
    TweenService:Create(v247.Start, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(15, Magnitude, 15),
        CFrame = v247.Start.CFrame * CFrame.new(0, -Magnitude, 0)
    }):Play();
    Debris:AddItem(v247, 0.4);
end;

function u1.weld(p248: any, p249: any, p250, p251: any, u252: any, p253: any) -- Line: 2510
    -- upvalues: RunService (copy)
    local u254 = p253 or 15;
    local HumanoidRootPart = p248.HumanoidRootPart;
    local HumanoidRootPart2 = p249.HumanoidRootPart;
    local v255 = p248:FindFirstChildOfClass("Humanoid");
    local v256 = p249:FindFirstChildOfClass("Humanoid");
    local u257 = {};

    local function destroy() -- Line: 2521
        -- upvalues: u257 (copy)
        for _, v in u257 do
            v:Disconnect();
        end;

        table.clear(u257);
    end;

    task.delay(p251, destroy);
    table.insert(u257, p248.AncestryChanged:Once(destroy));
    table.insert(u257, p249.AncestryChanged:Once(destroy));
    table.insert(u257, v255.Died:Once(destroy));
    table.insert(u257, v256.Died:Once(destroy));
    local u258 = p250 or CFrame.new();
    table.insert(u257, RunService.PreRender:Connect(function(p259) -- Line: 2542
        -- upvalues: u252 (copy), HumanoidRootPart2 (copy), HumanoidRootPart (copy), u258 (ref), u254 (ref)
        if u252 then
            HumanoidRootPart2.CFrame = HumanoidRootPart2.CFrame:Lerp(HumanoidRootPart.CFrame * u258, p259 * u254);

            return;
        end;

        HumanoidRootPart2.CFrame = HumanoidRootPart.CFrame * u258;
    end));
end;

function u1.rockFlakes(u260, p261, u262) -- Line: 2553
    -- upvalues: RunService (copy), raycast (copy), TweenService (copy), Debris (copy), ReplicatedStorage (copy)
    local l_time = time;
    local u263 = l_time() + 0.085;
    Random.new();
    local u268 = RunService.PreRender:Connect(function() -- Line: 2563
        -- upvalues: l_time (copy), u263 (ref), u260 (copy), u262 (ref), raycast (ref), TweenService (ref), Debris (ref), ReplicatedStorage (ref)
        if l_time and u263 then
            local v264 = l_time();

            if u263 > v264 then
                return;
            end;

            u263 = v264 + 0.085;
        end;

        if not (u260 and u260:IsDescendantOf(game)) then
            return;
        end;

        u262 = u262 or 0.55;
        local v265 = raycast(CFrame.new(u260.Position) * CFrame.new(math.random(-u262 * 4.5, u262 * 4.5), -u262, math.random(-u262 * 4.5, u262 * 4.5)).Position, (Vector3.new(0, -u260.Size.Y * 2, 0)));

        if v265 and v265.Instance.Transparency < 1 then
            local Part = Instance.new("Part");
            Part.CanCollide = false;
            Part.Anchored = true;
            Part.CFrame = CFrame.new(v265.Position);
            Part.Size = Vector3.new(0, 0, 0);
            Part.Parent = workspace.Effects;
            Part.Material = v265.Material;
            Part.MaterialVariant = v265.Instance.MaterialVariant;
            Part.Color = v265.Instance.Color;
            TweenService:Create(Part, TweenInfo.new(0.2), {
                CFrame = CFrame.new(v265.Position) * CFrame.Angles(math.random(0, 180), math.random(0, 180), math.random(0, 180)),
                Size = Vector3.new(u262, u262, u262)
            }):Play();
            task.delay(Random.new():NextNumber(3, 6), function() -- Line: 2600
                -- upvalues: TweenService (ref), Part (copy), Debris (ref)
                TweenService:Create(Part, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    Position = Part.Position - Vector3.new(0, Part.Size.Y * 2, 0)
                }):Play();
                Debris:AddItem(Part, 1.5);
            end);
        end;

        local v266 = raycast(u260.Position, Vector3.new(0, 1, 0) * -u260.Size.Y * 2);

        if v266 and v266.Instance.Transparency < 1 then
            local v267 = ReplicatedStorage.Resources.DashSmoke:Clone();
            v267.Parent = workspace.Effects;
            v267.CFrame = CFrame.new(v266.Position);

            for _, descendant in ipairs(v267:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Color = ColorSequence.new(v266.Instance.Color);
                end;
            end;

            task.delay(3, v267.Destroy, v267);
        end;
    end);
    task.delay(p261, function() -- Line: 2628
        -- upvalues: u268 (copy)
        u268:Disconnect();
    end);
end;

function u1.WeldDash2(p269) -- Line: 2633
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local v270 = p269.HumanoidRootPart or p269.PrimaryPart;
    local u271 = ReplicatedStorage.Resources.isagi.WeldDash:Clone();
    u271.Parent = p269;
    u271.Weld.Part0 = v270;
    local u272 = ReplicatedStorage.Resources.armdrip:Clone();
    u272.Parent = p269;
    u272.Weld.Part0 = p269["Left Arm"];
    local u273 = ReplicatedStorage.Resources.armdrip:Clone();
    u273.Parent = p269;
    u273.Weld.Part0 = p269["Right Arm"];
    task.delay(0.45, function() -- Line: 2650
        -- upvalues: u272 (copy), u273 (copy)
        for _, descendant in ipairs(u272:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u273:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u272.Destroy, u272);
        task.delay(2, u273.Destroy, u273);
    end);
    task.delay(0.3, function() -- Line: 2665
        -- upvalues: u271 (copy)
        for _, descendant in ipairs(u271:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u271.Destroy, u271);
    end);
    u1.bodyVelocity(v270, p269:GetAttribute("RinNoPlay") and 500 or 225, 0.45);
end;

function u1.WeldDash(p274) -- Line: 2677
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local v275 = p274.HumanoidRootPart or p274.PrimaryPart;
    local u276 = ReplicatedStorage.Resources.isagi.WeldDash:Clone();
    u276.Parent = p274;
    u276.Weld.Part0 = v275;
    local u277 = ReplicatedStorage.Resources.armdrip:Clone();
    u277.Parent = p274;
    u277.Weld.Part0 = p274["Left Arm"];
    local u278 = ReplicatedStorage.Resources.armdrip:Clone();
    u278.Parent = p274;
    u278.Weld.Part0 = p274["Right Arm"];
    task.delay(0.45, function() -- Line: 2694
        -- upvalues: u277 (copy), u278 (copy)
        for _, descendant in ipairs(u277:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u278:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u277.Destroy, u277);
        task.delay(2, u278.Destroy, u278);
    end);
    task.delay(0.3, function() -- Line: 2709
        -- upvalues: u276 (copy)
        for _, descendant in ipairs(u276:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u276.Destroy, u276);
    end);
    u1.bodyVelocity(v275, 225, 0.45);
end;

function u1.dribbleDash(p279) -- Line: 2722
    -- upvalues: u1 (copy)
    local v280 = p279.HumanoidRootPart or p279.PrimaryPart;
    local v281 = p279:FindFirstChildOfClass("Humanoid");
    local v282 = v280.CFrame:VectorToObjectSpace(v281.MoveDirection);
    local v283 = math.round(v282.X) == -1 or math.round(v282.X) == 1;
    local v284 = math.round(v282.Z) == 1;
    local v285 = math.round(v282.X) == -1;
    u1.highlight(p279, Color3.fromRGB(255, 255, 255), 0.3);
    u1.rockFlakes(v280, 0.3, 0.6);
    local v286;

    if v283 then
        v286 = v285 and -110 or 110;
    else
        v286 = v284 and -110 or 110;
    end;

    u1.bodyVelocity(v280, v286, 0.3, nil, v283 and "RightVector" or "LookVector", nil, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
end;

function u1.kaiserrunDash(p287) -- Line: 2762
    -- upvalues: u1 (copy), ReplicatedStorage (copy), actionUtil (copy)
    local v288 = p287.HumanoidRootPart or p287.PrimaryPart;
    p287:FindFirstChildOfClass("Humanoid");
    u1.characterImage({
        ImageTransparency = 0.7,
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        countSpeed = 0.03,
        Count = 16,
        Whitelist = { p287 },
        Color = Color3.fromRGB(1000, 1000, 1000),
        Color2 = Color3.fromRGB(79, 126, 255)
    });
    u1.rockFlakes(v288, 1.1);
    local v289 = ReplicatedStorage.Resources.kaiser.A:Clone();
    v289.Weld.Part0 = v288;
    v289.Parent = p287;
    local v290 = ReplicatedStorage.Resources.kaiser.roott:Clone();
    v290.Weld.Part0 = p287["Right Arm"];
    v290.Parent = p287;
    local v291 = ReplicatedStorage.Resources.kaiser.roott:Clone();
    v291.Weld.Part0 = p287["Left Arm"];
    v291.Parent = p287;
    u1.bodyVelocity(v288, 280, 1.1, nil, nil, nil, TweenInfo.new(2.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));

    if actionUtil.simulatesCharacter(p287) then
        u1.bright(0.15, 1.5, Color3.fromRGB(111, 106, 255));
        u1.fov(false, 55);
        u1.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    u1.cameraShake(15, 1.3, 6);
    u1.Emit(v288, ReplicatedStorage.Resources.kaiser.Jump, 3, CFrame.new(0, -3, 0));
    task.wait(0.45);

    for _, descendant in ipairs(v289:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v289.Destroy, v289);

    for _, descendant in ipairs(v290:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v290.Destroy, v290);

    for _, descendant in ipairs(v291:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v291.Destroy, v291);
end;

function u1.afterImage(p292) -- Line: 2837
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    if not ReplicatedStorage.CLONES:FindFirstChild(p292.Name) then
        return;
    end;

    local v293 = ReplicatedStorage.CLONES[p292.Name];
    p292:FindFirstChildOfClass("Humanoid");
    local v294 = v293:FindFirstChildOfClass("Humanoid");
    v294.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    v294.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v293.Archivable = true;

    for _, child in pairs(p292:GetChildren()) do
        if child.Name ~= "HumanoidRootPart" and child:IsA("Part") then
            local Part = Instance.new("Part");
            Part.CanCollide = false;
            Part.Anchored = true;
            Part.Transparency = 0.5;
            Part.Color = Color3.fromRGB(255, 255, 255);
            Part.CFrame = child.CFrame;
            Part.Size = child.Size;
            Part.Parent = workspace.Effects;
            TweenService:Create(Part, TweenInfo.new(1), {
                Transparency = 1
            }):Play();
            task.delay(1, Part.Destroy, Part);
        end;
    end;
end;

function u1.izayoistepbehind(p295) -- Line: 2917
    -- upvalues: u1 (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local v296 = p295.HumanoidRootPart or p295.PrimaryPart;
    u1.fov(true, 40, 0.33, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    task.wait(0.35);
    u1.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local u297 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    u297.TintColor = Color3.fromRGB(197, 217, 255);
    u297.Brightness = -1;
    u297.Contrast = -20;
    u297.Saturation = -6;
    u297.Parent = Lighting;
    task.delay(0.016, function() -- Line: 2937
        -- upvalues: u297 (copy), TweenService (ref)
        u297.Brightness = 1;
        TweenService:Create(u297, TweenInfo.new(0.06), {
            Brightness = 1,
            Contrast = 5,
            Saturation = -10
        }):Play();
        task.wait(0.06);
        u297.TintColor = Color3.fromRGB(255, 255, 255);
        u297.Brightness = 0.1;
        u297.Contrast = 1;
        u297.Saturation = -1;
        TweenService:Create(u297, TweenInfo.new(1), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0
        }):Play();
        task.wait(1);
        u297:Destroy();
    end);
    u1.characterImage({
        ImageTransparency = 0.7,
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        countSpeed = 0.09,
        Count = 10,
        Whitelist = { p295 },
        Color = Color3.fromRGB(255, 255, 255),
        Color2 = Color3.fromRGB(0, 0, 0)
    });
    u1.Emit(v296, ReplicatedStorage.Resources.izayoi.Time, 1);
    u1.cameraShake(15, 1.3, 10);
    u1.bodyVelocity(v296, -250, 0.5);
    local v298 = ReplicatedStorage.Resources.izayoi.Behindstep:Clone();
    v298.Weld.Part0 = v296;
    v298.Parent = p295;
    task.wait(0.25);

    for _, descendant in ipairs(v298:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v298.Destroy, v298);
end;

local Welder = require(ReplicatedStorage.Welder);

function u1.cr7dribble(p299) -- Line: 2994
    -- upvalues: ReplicatedStorage (copy), Welder (copy), soundUtil (copy), Debris (copy), u1 (copy)
    local u300 = p299.HumanoidRootPart or p299.PrimaryPart;
    p299:FindFirstChild("Ball");
    local u301 = ReplicatedStorage.Resources.RonaldoDribble:Clone();
    Welder:GroupWeld(p299, u301);
    u301.Parent = workspace.Effects;
    soundUtil:play(ReplicatedStorage.Resources.ronaldo.RonaldoDribble, u300);
    Debris:AddItem(u301, 5);
    task.spawn(function() -- Line: 3006
        -- upvalues: u1 (ref), u300 (copy)
        task.delay(1.5, function() -- Line: 3007
            -- upvalues: u1 (ref), u300 (ref)
            u1.bodyVelocity(u300, 40, 1, nil, nil, nil);
        end);
        task.delay(1.8, function() -- Line: 3010
            -- upvalues: u1 (ref), u300 (ref)
            u1.bodyVelocity(u300, 120, 1.1, nil, nil, nil);
        end);
        task.delay(2.5, function() -- Line: 3013
            -- upvalues: u1 (ref), u300 (ref)
            u1.bodyVelocity(u300, 90, 0.75, nil, nil, nil);
        end);
        task.delay(2.9, function() -- Line: 3016
            -- upvalues: u1 (ref), u300 (ref)
            u1.bodyVelocity(u300, 100, 0.85, nil, nil, nil);
        end);
        task.delay(3.2, function() -- Line: 3019
            -- upvalues: u1 (ref), u300 (ref)
            u1.bodyVelocity(u300, 175, 1.7, nil, nil, nil);
        end);
        task.delay(3.9, function() -- Line: 3022
            -- upvalues: u1 (ref), u300 (ref)
            u1.bodyVelocity(u300, 40, 0.65, nil, nil, nil);
        end);
    end);
    task.spawn(function() -- Line: 3027
        -- upvalues: u301 (copy), ReplicatedStorage (ref)
        local v302 = u301.Rig.Head["1"];
        local EffectUtility = require(ReplicatedStorage.EffectUtility);
        EffectUtility.EmitAttachment(v302);
        EffectUtility.ToggleAttachment(v302, true, 1);
    end);
    task.delay(1.5166666666666666, function() -- Line: 3034
        -- upvalues: u301 (copy), ReplicatedStorage (ref)
        local v303 = u301.Rig.HumanoidRootPart["1"];
        require(ReplicatedStorage.EffectUtility).EmitAttachment(v303);
        local MeshEmit = require(ReplicatedStorage.MeshEmit);

        for _, descendant in ReplicatedStorage.Resources.Meshes2:WaitForChild("1"):GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;
    end);
    task.delay(1.8833333333333333, function() -- Line: 3052
        -- upvalues: u301 (copy), ReplicatedStorage (ref)
        local v304 = u301.Rig.HumanoidRootPart["2"];
        require(ReplicatedStorage.EffectUtility).EmitAttachment(v304);
        local MeshEmit = require(ReplicatedStorage.MeshEmit);

        for _, descendant in ReplicatedStorage.Resources.Meshes2:WaitForChild("2"):GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;

        local afterimage = u301.afterimage;
        local EffectUtility = require(ReplicatedStorage.EffectUtility);
        EffectUtility.EmitAttachment(afterimage);
        EffectUtility.ToggleAttachment(afterimage, true, 2);
    end);
    task.delay(2.5, function() -- Line: 3076
        -- upvalues: u301 (copy), ReplicatedStorage (ref)
        local v305 = u301.Rig.HumanoidRootPart["3"];
        require(ReplicatedStorage.EffectUtility).EmitAttachment(v305);
    end);
    task.delay(2.933333333333333, function() -- Line: 3083
        -- upvalues: u301 (copy), ReplicatedStorage (ref)
        local v306 = u301.Rig.HumanoidRootPart["4"];
        require(ReplicatedStorage.EffectUtility).EmitAttachment(v306);
    end);
    task.delay(3.2, function() -- Line: 3090
        -- upvalues: u301 (copy), ReplicatedStorage (ref)
        local v307 = u301.Rig.HumanoidRootPart["3.2"];
        require(ReplicatedStorage.EffectUtility).EmitAttachment(v307);
    end);
    task.delay(3.4166666666666665, function() -- Line: 3097
        -- upvalues: u301 (copy), ReplicatedStorage (ref)
        local v308 = u301.Rig.HumanoidRootPart["3.5"];
        require(ReplicatedStorage.EffectUtility).EmitAttachment(v308);
    end);
    task.delay(3.933333333333333, function() -- Line: 3104
        -- upvalues: u301 (copy), ReplicatedStorage (ref)
        local v309 = u301.Rig.HumanoidRootPart["5"];
        require(ReplicatedStorage.EffectUtility).EmitAttachment(v309);
    end);
end;

function u1.saepass(p310) -- Line: 3113
    -- upvalues: Lighting (copy), TweenService (copy), ReplicatedStorage (copy), u1 (copy)
    local v311 = p310.HumanoidRootPart or p310.PrimaryPart;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v312 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v312.Parent = Lighting;
    v312.TintColor = Color3.fromRGB(255, 104, 132);
    v312.Brightness = 0.4;
    v312.Contrast = 1;
    v312.Saturation = -0.4;
    TweenService:Create(v312, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v312, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v312.Destroy, v312);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 2, 6);
    u1.Emit(v311, ReplicatedStorage.Resources.sae.hota, 5, CFrame.new(3, 0, -4));
end;

function u1.zangetsupass(p313) -- Line: 3151
    -- upvalues: Lighting (copy), TweenService (copy), ReplicatedStorage (copy), u1 (copy)
    local v314 = p313.HumanoidRootPart or p313.PrimaryPart;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v315 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v315.Parent = Lighting;
    v315.TintColor = Color3.fromRGB(35, 35, 35);
    v315.Brightness = 0.4;
    v315.Contrast = 1;
    v315.Saturation = -0.4;
    TweenService:Create(v315, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v315, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v315.Destroy, v315);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 2, 6);
    u1.Emit(v314, ReplicatedStorage.Resources.sae.hota, 5, CFrame.new(3, 0, -4));
end;

function u1.rinpass(p316) -- Line: 3189
    -- upvalues: actionUtil (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy), u1 (copy)
    local v317 = p316.HumanoidRootPart or p316.PrimaryPart;

    if not actionUtil.checkGK(LocalPlayer.Character) then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v318 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v318.Parent = Lighting;
        v318.TintColor = Color3.fromRGB(19, 255, 239);
        v318.Brightness = 0.4;
        v318.Contrast = 1;
        v318.Saturation = -0.4;
        TweenService:Create(v318, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v318, TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2.5, v318.Destroy, v318);
    end;

    u1.fov(false, 100);
    u1.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 2, 6);
    u1.Emit(v317, ReplicatedStorage.Resources.rin.hota, 5, CFrame.new(3, 0, -4));
end;

function u1.SpeedDribble(u319, u320, p321) -- Line: 3229
    -- upvalues: MeshEmitter (copy), ReplicatedStorage (copy), Debris (copy), actionUtil (copy), u1 (copy)
    local u322 = u319.HumanoidRootPart or u319.PrimaryPart;
    local u323 = MeshEmitter.StartMeshEmitter(u322, ReplicatedStorage.Resources.yukimiya[u320 and "LeftMesh" or "RightMesh"], nil, 5);
    u323.Parent = workspace.Effects;
    local u324 = ReplicatedStorage.Resources.yukimiya["Left Arm Trail"]:Clone();
    u324.Weld.Part0 = u319["Right Arm"];
    u324.Parent = u319;
    local u325 = ReplicatedStorage.Resources.yukimiya["Right Arm Trail"]:Clone();
    u325.Weld.Part0 = u319["Left Arm"];
    u325.Parent = u319;
    local u326 = ReplicatedStorage.Resources.yukimiya["Left Leg Trail"]:Clone();
    u326.Weld.Part0 = u319["Left Leg"];
    u326.Parent = u319;
    local u327 = ReplicatedStorage.Resources.yukimiya["Right Leg Trail"]:Clone();
    u327.Weld.Part0 = u319["Right Leg"];
    u327.Parent = u319;
    local u328 = ReplicatedStorage.Resources.yukimiya["Torso Trail"]:Clone();
    u328.Weld.Part0 = u319.Torso;
    u328.Parent = u319;
    Debris:AddItem(u324, 1);
    Debris:AddItem(u325, 1);
    Debris:AddItem(u326, 1);
    Debris:AddItem(u327, 1);
    Debris:AddItem(u328, 1);
    task.spawn(function() -- Line: 3268
        -- upvalues: u323 (copy)
        for _, descendant in pairs(u323.RootPart["0"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.16666666666666666, function() -- Line: 3275
        -- upvalues: u323 (copy)
        for _, descendant in pairs(u323.RootPart["0.5"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.3, function() -- Line: 3282
        -- upvalues: u323 (copy), actionUtil (ref), u319 (copy), u1 (ref), u322 (copy), u320 (copy)
        for _, descendant in pairs(u323.RootPart["1"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        if actionUtil.simulatesCharacter(u319) then
            local v329, _ = u1.bodyVelocity(u322, 1, 0.1, nil, nil, true, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out));
            local v330 = u322.CFrame.RightVector * 75;

            if not u320 then
                v330 = u322.CFrame.RightVector * -75;
            end;

            v329.Velocity = u322.CFrame.LookVector * 150 + v330;
        end;
    end);
    task.delay(0.5, function() -- Line: 3306
        -- upvalues: u323 (copy), u324 (copy), u325 (copy), u326 (copy), u327 (copy), u328 (copy)
        for _, descendant in pairs(u323.RootPart["2"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u324:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u325:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u326:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u327:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u328:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

function u1.yukimiyadribble(u331) -- Line: 3341
    -- upvalues: actionUtil (copy), u1 (copy), MeshEmitter (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local u332 = u331.HumanoidRootPart or u331.PrimaryPart;

    if actionUtil.simulatesCharacter(u331) then
        local v333, _ = u1.bodyVelocity(u332, 1, 0.417, nil, nil, true, TweenInfo.new(0.417, Enum.EasingStyle.Quad, Enum.EasingDirection.Out));
        local _ = u332.CFrame.RightVector * -50;
        local _ = u332.CFrame.LookVector;

        repeat
            v333.Velocity = u332.CFrame.RightVector * -50;
        until not v333;

        task.delay(0.417, function() -- Line: 3361
            -- upvalues: u1 (ref), u332 (copy)
            u1.bodyVelocity(u332, 500, 0.5, nil, nil, nil, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out));
        end);
    end;

    local u334 = MeshEmitter.StartMeshEmitter(u332, ReplicatedStorage.Resources.yukimiya.CounterAAA, nil, 5);
    u334.Parent = workspace.Effects;
    local v335 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v335.Parent = Lighting;
    v335.TintColor = Color3.fromRGB(255, 149, 0);
    v335.Brightness = 0.4;
    v335.Contrast = 1;
    v335.Saturation = -0.4;
    TweenService:Create(v335, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v335, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v335.Destroy, v335);
    task.wait();
    task.spawn(function() -- Line: 3398
        -- upvalues: u1 (ref), u331 (copy)
        for i = 1, 5 do
            u1.characterImage({
                Speed = 0.2,
                CFrames = true,
                Brightness = 1,
                ImageTransparency = 0.2,
                Whitelist = { u331 },
                Color = Color3.fromRGB(255, 64, 0)
            });
            task.wait(0.03);
            local _ = i;
        end;
    end);
    task.spawn(function() -- Line: 3414
        -- upvalues: u334 (copy)
        for _, descendant in pairs(u334.step:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u334.Part1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.4166666666666667, function() -- Line: 3429
        -- upvalues: u334 (copy), u1 (ref), u331 (copy)
        for _, descendant in pairs(u334.Part1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for i = 1, 8 do
            u1.characterImage({
                Speed = 0.2,
                CFrames = true,
                Brightness = 1,
                ImageTransparency = 0.2,
                Whitelist = { u331 },
                Color = Color3.fromRGB(255, 64, 0)
            });
            task.wait(0.03);
            local _ = i;
        end;
    end);
    task.delay(0.43333333333333335, function() -- Line: 3453
        -- upvalues: u334 (copy)
        for _, descendant in pairs(u334.Part:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.8833333333333333, function() -- Line: 3461
        -- upvalues: u334 (copy)
        for _, descendant in pairs(u334.Part:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

function u1.metaVisionSae(u336, u337) -- Line: 3471
    -- upvalues: ReplicatedStorage (copy)
    if not u336.HumanoidRootPart then
        local _ = u336.PrimaryPart;
    end;

    local trove2 = require(ReplicatedStorage:WaitForChild("forum"):WaitForChild("trove"));
    local TroveValue = u336:FindFirstChild("TroveValue");
    task.spawn(function() -- Line: 3476
        -- upvalues: u337 (copy), TroveValue (copy), u336 (copy), trove2 (copy), ReplicatedStorage (ref)
        if not u337 then
            if TroveValue then
                TroveValue:Destroy();
            end;

            return;
        end;

        if TroveValue then
            TroveValue:Destroy();
        end;

        local Attachment = Instance.new("Attachment");
        Attachment.Name = "TroveValue";
        Attachment.Parent = u336;
        local u338 = trove2.new();
        u338:AttachToInstance(Attachment);
        u338:Add(workspace.Effects.ChildAdded:Connect(function(p339) -- Line: 3496
            if p339.Name == "TrajVisuals" then
                p339.ChildAdded:Connect(function(p340: userdata) -- Line: 3498, Name: onAdded
                    if p340:IsA("Highlight") then
                        p340.Enabled = true;
                        p340.FillColor = Color3.new(1, 0.0823529, 0.572549);

                        return;
                    end;

                    p340.Transparency = 0.35;
                    p340.Color = Color3.new(1, 0.0823529, 0.572549);
                end);

                for _, child in p339:GetChildren() do
                    if child:IsA("Highlight") then
                        child.Enabled = true;
                        child.FillColor = Color3.new(1, 0.0823529, 0.572549);
                    else
                        child.Transparency = 0.35;
                        child.Color = Color3.new(1, 0.0823529, 0.572549);
                    end;
                end;
            end;
        end));
        ReplicatedStorage.workspace.roundstart:GetPropertyChangedSignal("Value"):Once(function() -- Line: 3514
            -- upvalues: u338 (copy)
            u338:Destroy();
        end);
    end);
end;

function u1.metaVision(u341, u342) -- Line: 3520
    -- upvalues: ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    if not u341.HumanoidRootPart then
        local _ = u341.PrimaryPart;
    end;

    local trove2 = require(ReplicatedStorage:WaitForChild("forum"):WaitForChild("trove"));
    task.spawn(function() -- Line: 3523
        -- upvalues: trove2 (copy), u341 (copy), u342 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref)
        local u343 = trove2.new();
        u343:AttachToInstance(u341);
        u343:Add(workspace.Effects.ChildAdded:Connect(function(p344) -- Line: 3526
            if p344.Name == "TrajVisuals" then
                p344.ChildAdded:Connect(function(p345: userdata) -- Line: 3528, Name: onAdded
                    if p345:IsA("Highlight") then
                        p345.Enabled = true;

                        return;
                    end;

                    p345.Transparency = 0.35;
                end);

                for _, child in p344:GetChildren() do
                    if child:IsA("Highlight") then
                        child.Enabled = true;
                    else
                        child.Transparency = 0.35;
                    end;
                end;
            end;
        end));
        task.wait();

        if u342 then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v346 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v346.Parent = Lighting;
            v346.TintColor = Color3.fromRGB(58, 101, 255);
            v346.Brightness = 0.4;
            v346.Contrast = 1;
            v346.Saturation = -0.4;
            TweenService:Create(v346, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v346, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v346.Destroy, v346);
            local v347 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v347.TintColor = Color3.fromRGB(123, 154, 255);
            v347.Brightness = 0.4;
            v347.Contrast = 0.4;
            v347.Saturation = -0.5;
            v347.Parent = Lighting;
            u343:Add(v347);
            task.delay(u342, u343.Destroy, u343);
            task.delay(u342, function() -- Line: 3587
                -- upvalues: Lighting (ref), TweenService (ref), ReplicatedStorage (ref)
                local BlurEffect2 = Instance.new("BlurEffect");
                BlurEffect2.Size = 25;
                BlurEffect2.Parent = Lighting;
                TweenService:Create(BlurEffect2, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                task.delay(0.533, BlurEffect2.Destroy, BlurEffect2);
                local v348 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v348.Parent = Lighting;
                v348.TintColor = Color3.fromRGB(58, 101, 255);
                v348.Brightness = 0.4;
                v348.Contrast = 1;
                v348.Saturation = -0.4;
                TweenService:Create(v348, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v348, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(2, v348.Destroy, v348);
            end);
        end;

        ReplicatedStorage.workspace.roundstart:GetPropertyChangedSignal("Value"):Once(function() -- Line: 3624
            -- upvalues: u343 (copy)
            u343:Destroy();
        end);
    end);
end;

function u1.rinfakeshot(u349: userdata, p350: any) -- Line: 3630
    -- upvalues: trove (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), u1 (copy), actionUtil (copy), Lighting (copy), TweenService (copy)
    local Ball = u349:FindFirstChild("Ball");
    local u351 = u349.HumanoidRootPart or u349.PrimaryPart;
    local u352 = {};
    local u353 = trove.new();
    u353:Connect(u349:GetAttributeChangedSignal("trivela"), function() -- Line: 3636
        -- upvalues: u349 (copy), u353 (copy)
        if u349:GetAttribute("trivela") then
            u353:Destroy();
        end;
    end);
    local u354 = ReplicatedStorage.Resources.rin.allfakeshot:Clone();
    u354:PivotTo(u351.CFrame);
    u354.Parent = u349;
    u353:Add(u354);

    if Util.canshiftcolor(LocalPlayer, u349) then
        vfxUtil.LeanTowardsColor(u354, u349:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u349:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u349:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v355 = descendant;

            for _, child in ipairs(ReplicatedStorage.Resources.rin.rinaura:GetChildren()) do
                local v356 = child:Clone();
                v356.Parent = v355;

                if Util.canshiftcolor(LocalPlayer, u349) then
                    vfxUtil.LeanTowardsColor(v356, u349:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u349:GetAttribute("CustomAlpha") or 0.985);
                end;

                u353:Add(v356);
                table.insert(u352, v356);
            end;
        end;
    end;

    local u357 = false;
    local u358 = nil;
    u358 = RunService.Heartbeat:Connect(function(p359: number) -- Line: 3670
        -- upvalues: u349 (copy), u357 (ref), u358 (ref)
        if u349:GetAttribute("counterlanded") then
            u357 = true;
            u358:Disconnect();
        end;
    end);
    u353:Add(u358);
    u353:Add(task.delay(0.45, function() -- Line: 3678
        -- upvalues: u354 (copy), u351 (copy), u1 (ref), Ball (copy), ReplicatedStorage (ref), Util (ref), LocalPlayer (ref), u349 (copy), vfxUtil (ref), u353 (copy), u352 (copy)
        u354:PivotTo(u351.CFrame);

        for _, descendant in pairs(u354.rinfeintgrassstart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u1.cameraShake(10, 0.5, 4);

        if not Ball then
            return;
        end;

        for _, child in ipairs(ReplicatedStorage.Resources.rin.rinaura:GetChildren()) do
            local v360 = child:Clone();
            v360.Parent = Ball;

            if Util.canshiftcolor(LocalPlayer, u349) then
                vfxUtil.LeanTowardsColor(v360, u349:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u349:GetAttribute("CustomAlpha") or 0.985);
            end;

            u353:Add(v360);
            table.insert(u352, v360);
        end;
    end));
    u353:Add(task.delay(0.9, function() -- Line: 3706
        -- upvalues: u354 (copy), u351 (copy), u352 (copy), u1 (ref), u349 (copy), actionUtil (ref), Lighting (ref), u353 (copy), TweenService (ref), ReplicatedStorage (ref), u358 (ref), RunService (ref)
        u354:PivotTo(u351.CFrame);

        for _, descendant in pairs(u354.rinfeintgrass:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, v in u352 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;

        u1.characterImage({
            Speed = 0.3,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            ImageTransparency = 0.65,
            Count = 16,
            Whitelist = { u349 },
            Color = Color3.fromRGB(71, 218, 118),
            Color2 = Color3.fromRGB(0, 0, 0)
        });

        if actionUtil.simulatesCharacter(u349) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            u353:Add(BlurEffect);
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v361 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v361.Parent = Lighting;
            v361.TintColor = Color3.fromRGB(92, 255, 220);
            v361.Brightness = 0.4;
            v361.Contrast = 1;
            v361.Saturation = -0.4;
            u353:Add(v361);
            TweenService:Create(v361, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v361, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v361.Destroy, v361);
            u1.fov(false, 100);
            u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            u1.cameraShake(10, 1.5, 6);

            if u358 then
                u358:Disconnect();
            end;

            local X = u351.CFrame:VectorToObjectSpace(u349.Humanoid.MoveDirection).X;
            local u362 = math.round(X) == -1;
            local u363, u364 = u1.bodyVelocity(u351, 120, 0.3, nil, nil, true);
            local u365 = nil;
            u365 = RunService.RenderStepped:Connect(function(p366) -- Line: 3784
                -- upvalues: u363 (copy), u365 (ref), u351 (ref), u364 (copy), u362 (copy)
                if not (u363 and u363:IsDescendantOf(game)) then
                    u365:Disconnect();

                    return;
                end;

                local v367 = u351.CFrame.RightVector * u364.Value;
                local v368 = u351.CFrame.LookVector * u364.Value;
                print("yes i am operating beep boop");

                if u362 then
                    u363.Velocity = v368 - v367;

                    return;
                end;

                u363.Velocity = v368 + v367;
            end);
            u353:Add(u365);
            u353:Add(task.delay(15, u365.Disconnect, u365));
        end;
    end));
end;

function u1.occlusionBreak(u369) -- Line: 3807
    -- upvalues: vfxUtil (copy), LocalPlayer (copy), ReplicatedStorage (copy), Util (copy), u1 (copy), actionUtil (copy), Lighting (copy), TweenService (copy)
    local u370 = u369.HumanoidRootPart or u369.PrimaryPart;
    local u371 = {};
    local u372 = nil;
    local u373 = vfxUtil.IsOptimizationSettingOn(LocalPlayer, "RemovedDribbleEffects", false);
    local v374 = shared.allvfxcheck and shared.allvfxcheck();
    print(u373);

    if not (u373 or v374) then
        u372 = ReplicatedStorage.Resources.rin.allrun:Clone();
        u372:PivotTo(u370.CFrame);
        u372.Parent = u369;
        task.delay(2, u372.Destroy, u372);

        for _, descendant in ipairs(u369:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v375 = descendant;

                for _, child in ipairs(ReplicatedStorage.Resources.rin.rinaura:GetChildren()) do
                    local v376 = child:Clone();
                    v376.Parent = v375;
                    table.insert(u371, v376);
                end;
            end;
        end;

        for _, child in ipairs(ReplicatedStorage.Resources.rin.flashsteps:GetChildren()) do
            local v377 = child:Clone();
            v377.Parent = u369.Torso;
            table.insert(u371, v377);
        end;
    end;

    local u378 = ReplicatedStorage.Resources.rin.trail:Clone();
    u378.Weld.Part0 = u369["Right Arm"];
    u378.Parent = u369;
    local u379 = ReplicatedStorage.Resources.rin.trail:Clone();
    u379.Weld.Part0 = u369["Left Arm"];
    u379.Parent = u369;
    local u380 = ReplicatedStorage.Resources.rin.trail:Clone();
    u380.Weld.Part0 = u369["Right Leg"];
    u380.Parent = u369;
    local u381 = ReplicatedStorage.Resources.rin.trail:Clone();
    u381.Weld.Part0 = u369["Left Leg"];
    u381.Parent = u369;

    if Util.canshiftcolor(LocalPlayer, u369) then
        vfxUtil.LeanTowardsColor({
            u372,
            u371,
            u378,
            u379,
            u380,
            u381
        }, u369:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u369:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v382 = 60;
    u1.bodyVelocity(u370, v382 - v382 * 0.05, 1.333, true, nil, nil, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.In));
    task.delay(1.333, function() -- Line: 3884
        -- upvalues: u379 (copy), u378 (copy), u380 (copy), u381 (copy), u371 (copy)
        u379:Destroy();
        u378:Destroy();
        u380:Destroy();
        u381:Destroy();

        for _, v in u371 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;
    end);
    task.delay(0.15, function() -- Line: 3896
        -- upvalues: u373 (copy), u372 (ref), u370 (copy), actionUtil (ref), u369 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), u1 (ref)
        if u373 == false then
            u372:PivotTo(u370.CFrame);

            for _, descendant in pairs(u372.ringrasstep1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;

        if actionUtil.simulatesCharacter(u369) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v383 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v383.Parent = Lighting;
            v383.TintColor = Color3.fromRGB(71, 218, 181);
            v383.Brightness = 0.4;
            v383.Contrast = 1;
            v383.Saturation = -0.4;
            TweenService:Create(v383, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v383, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v383.Destroy, v383);
            u1.fov(false, 100);
            u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            u1.cameraShake(10, 1.5, 6);
        end;
    end);
    task.delay(0.4, function() -- Line: 3973
        -- upvalues: u373 (copy), u372 (ref), u370 (copy)
        if u373 == false then
            u372:PivotTo(u370.CFrame);

            for _, descendant in pairs(u372.ringrasstep2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end);
    task.delay(0.717, function() -- Line: 3985
        -- upvalues: u373 (copy), u372 (ref), u370 (copy)
        if u373 == false then
            u372:PivotTo(u370.CFrame);

            for _, descendant in pairs(u372.ringrasstep3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end);
    task.delay(1, function() -- Line: 3997
        -- upvalues: u373 (copy), u372 (ref), u370 (copy)
        if u373 == false then
            u372:PivotTo(u370.CFrame);

            for _, descendant in pairs(u372.ringrasstep4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end);
end;

function getLorenzoLine(p384, p385)
    -- upvalues: Players (copy)
    local setting2 = Players.LocalPlayer:FindFirstChild("setting");

    if setting2 and (setting2:FindFirstChild("alternatelines") and not setting2.alternatelines.Value) then
        return p384;
    end;

    if p385:FindFirstChild("RickLines") and p385.RickLines:FindFirstChild(p384.Name) then
        return p385.RickLines[p384.Name];
    end;

    if p385:FindFirstChild((`{p384.Name}-Rick`)) then
        return p385[`{p384.Name}-Rick`];
    end;

    return p384;
end;

function u1.lorenzoAwk(u386) -- Line: 4033
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), workspace_CurrentCamera (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Density (copy), Color (copy), Brightness (copy)
    local u387 = u386.HumanoidRootPart or u386.PrimaryPart;
    local _ = u386.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local Ball = u386:FindFirstChild("Ball");
    u1.bright(-1, 1);
    u1.sceneEnabled(true);
    local u388 = ReplicatedStorage.Resources.donlorenzo.DonAwaken:Clone();
    u388:PivotTo(u387.CFrame);
    u388.Parent = u386;

    if Util.canshiftcolor(LocalPlayer, u386) then
        vfxUtil.LeanTowardsColor(u388, u386:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u386:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u389 = ReplicatedStorage.Resources.donlorenzo.awkCam:Clone();
    u389.Parent = u388;
    local u390 = nil;
    u390 = RunService.PreRender:connect(function() -- Line: 4054
        -- upvalues: u389 (copy), u390 (ref), workspace_CurrentCamera (ref)
        if not u389:IsDescendantOf(game) then
            u390:Disconnect();
        end;

        u389.CFrame = workspace_CurrentCamera.CFrame;
    end);
    local u391 = {};

    for _, descendant in ipairs(u386:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v392 = descendant;

            for _, child in ipairs(ReplicatedStorage.Resources.donlorenzo.ult4aura:GetChildren()) do
                local v393 = child:Clone();
                v393.Parent = v392;
                table.insert(u391, v393);
            end;
        end;
    end;

    local u394 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u394.Parent = Lighting;
    u394.FarIntensity = 0;
    TweenService:Create(u394, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local u395 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    u395.Weld.Part0 = u386["Right Arm"];
    u395.Parent = u386;
    local u396 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    u396.Weld.Part0 = u386["Left Arm"];
    u396.Parent = u386;
    soundUtil:play(getLorenzoLine(ReplicatedStorage.Resources.donlorenzo.awaken, ReplicatedStorage.Resources.donlorenzo), SoundService, {
        Character = u386
    });
    u1.cutsceneBlender(u387, ReplicatedStorage.Resources.donlorenzo.awkcutscene, ReplicatedStorage.Resources.donlorenzo.FOV2);
    task.delay(1, function() -- Line: 4106
        -- upvalues: u388 (copy)
        for _, descendant in ipairs(u388.ultballgrasskick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.26, function() -- Line: 4114
        -- upvalues: u388 (copy)
        for _, descendant in ipairs(u388.gimme:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.52, function() -- Line: 4122
        -- upvalues: u388 (copy)
        for _, descendant in ipairs(u388.money:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.51, function() -- Line: 4130
        -- upvalues: u388 (copy)
        for _, descendant in ipairs(u388.teethshinevfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.8, function() -- Line: 4138
        -- upvalues: u389 (copy)
        for _, descendant in ipairs(u389:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.35, function() -- Line: 4146
        -- upvalues: u389 (copy)
        for _, descendant in ipairs(u389:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u389:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.45, function() -- Line: 4160
        -- upvalues: ReplicatedStorage (ref), u386 (copy), u387 (copy), Ball (copy)
        local v397 = ReplicatedStorage.Resources.donlorenzo.awkball:Clone();
        v397.Parent = u386;
        v397:PivotTo(u387.CFrame);
        v397.Weld.Part0 = Ball;
        task.wait(4);
        v397:Destroy();
    end);
    task.delay(5.57, function() -- Line: 4170
        -- upvalues: u388 (copy)
        for _, descendant in ipairs(u388.lorenzoultflick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(6.22, function() -- Line: 4178
        -- upvalues: u388 (copy)
        for _, descendant in ipairs(u388.ultballcatch:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(6.56, function() -- Line: 4186
        -- upvalues: u388 (copy)
        for _, descendant in ipairs(u388.grasstep1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.03, function() -- Line: 4194
        -- upvalues: u388 (copy)
        for _, descendant in ipairs(u388.ultballgrasskick1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.1, function() -- Line: 4202
        -- upvalues: u388 (copy)
        for _, descendant in pairs(u388.sunglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u388.bodyglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u388.bodybeams:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u388.ballbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u388.bodybeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u388.torsobeam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.14, function() -- Line: 4235
        -- upvalues: u388 (copy)
        for _, descendant in pairs(u388.movingvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.2, function() -- Line: 4243
        -- upvalues: u1 (ref), u394 (copy), u388 (copy), u395 (copy), u396 (copy), u391 (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref)
        u1.blackscene(0.5833333333333333);
        u394:Destroy();
        u388:Destroy();
        u395:Destroy();
        u396:Destroy();

        for _, v in u391 do
            v:Destroy();
        end;

        table.clear(u391);
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        u1.sceneEnabled(false);
        u1.fov(false, 15);
        u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function u1.DASTStrike(p398) -- Line: 4270
    -- upvalues: ReplicatedStorage (copy), MeshEmitter (copy), RunService (copy), workspace_CurrentCamera (copy), Debris (copy)
    local v399 = p398.HumanoidRootPart or p398.PrimaryPart;
    local Ball = p398:FindFirstChild("Ball");

    if not Ball then
        return;
    end;

    local u400 = ReplicatedStorage.Resources.exe.Ball.Attachment:Clone();
    u400.Parent = Ball;
    local u401 = MeshEmitter.StartMeshEmitter(v399, ReplicatedStorage.Resources.exe.dastkickMeshEmitter, nil, 5);
    u401.Parent = workspace.Effects;
    local u402 = 0;
    local v405 = RunService.PreRender:Connect(function(p403) -- Line: 4286
        -- upvalues: u402 (ref), ReplicatedStorage (ref), workspace_CurrentCamera (ref)
        u402 = u402 + p403 * 60;
        local FOV = ReplicatedStorage.Resources.exe["dast kick"].FOV;
        local math_ceil_ret = math.ceil(u402);
        local v404 = FOV:FindFirstChild((tonumber(math_ceil_ret)));

        if v404 then
            workspace_CurrentCamera.FieldOfView = v404.Value;
        end;
    end);
    task.delay(4.267, v405.Disconnect, v405);
    local ColorCorrection = u401.ColorCorrection;
    ColorCorrection.Parent = game.Lighting;
    Debris:AddItem(ColorCorrection, 5.25);

    for _, v in { "AURA", "AURA1", "AURA2", "FullAura", "LastAURA" } do
        local Weld = Instance.new("Weld");
        Weld.Part0 = Ball;
        Weld.Part1 = u401[v];
        Weld.Parent = Ball;
    end;

    local AURA = u401.AURA;
    AURA.Parent = workspace.Effects;
    local AURA1 = u401.AURA1;
    AURA1.Parent = workspace.Effects;
    local AURA2 = u401.AURA2;
    AURA2.Parent = workspace.Effects;
    local FullAura = u401.FullAura;
    FullAura.Parent = workspace.Effects;
    local LastAURA = u401.LastAURA;
    LastAURA.Parent = workspace.Effects;
    task.delay(4, function() -- Line: 4320
        -- upvalues: AURA (copy), AURA1 (copy), AURA2 (copy), FullAura (copy), LastAURA (copy)
        AURA.Anchored = true;
        AURA1.Anchored = true;
        AURA2.Anchored = true;
        FullAura.Anchored = true;
        LastAURA.Anchored = true;
    end);
    Debris:AddItem(AURA, 4);
    Debris:AddItem(AURA1, 4);
    Debris:AddItem(AURA2, 4);
    Debris:AddItem(FullAura, 4);
    Debris:AddItem(LastAURA, 4);
    task.spawn(function() -- Line: 4334
        -- upvalues: AURA (copy), LastAURA (copy)
        for _, descendant in pairs(AURA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(LastAURA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.8333333333333334, function() -- Line: 4349
        -- upvalues: u401 (copy)
        for _, descendant in pairs(u401.PRE1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.85, function() -- Line: 4357
        -- upvalues: u401 (copy), u400 (copy)
        for _, descendant in pairs(u401.Charge:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u400:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.1666666666666667, function() -- Line: 4372
        -- upvalues: u401 (copy), u400 (copy)
        for _, descendant in pairs(u401.PRE2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u401.Charge:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u400:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.1833333333333333, function() -- Line: 4394
        -- upvalues: u401 (copy)
        for _, descendant in pairs(u401.ChargeBeamFloor:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u401.Charge2:GetDescendants()) do
            if descendant:IsA("Beam") then
                game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.25), {
                    Width0 = 1,
                    Width1 = 5
                }):Play();
            end;
        end;
    end);
    task.delay(1.2666666666666666, function() -- Line: 4409
        -- upvalues: AURA1 (copy)
        for _, descendant in pairs(AURA1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.3, function() -- Line: 4417
        -- upvalues: u401 (copy)
        for _, descendant in pairs(u401.Charge2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.7333333333333334, function() -- Line: 4425
        -- upvalues: AURA2 (copy), AURA1 (copy)
        for _, descendant in pairs(AURA2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(AURA1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.7833333333333334, function() -- Line: 4440
        -- upvalues: AURA (copy)
        for _, descendant in pairs(AURA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.2333333333333334, function() -- Line: 4448
        -- upvalues: AURA (copy), AURA2 (copy)
        for _, descendant in pairs(AURA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(AURA2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.283333333333333, function() -- Line: 4463
        -- upvalues: u401 (copy)
        for _, descendant in ipairs(u401.Charge2:GetDescendants()) do
            if descendant:IsA("Beam") then
                game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.25), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;
    end);
    task.delay(2.5, function() -- Line: 4471
        -- upvalues: u401 (copy)
        for _, descendant in ipairs(u401.Charge2:GetDescendants()) do
            if descendant:IsA("Beam") then
                game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.25), {
                    Width0 = 1,
                    Width1 = 15
                }):Play();
            end;
        end;
    end);
    task.delay(2.716666666666667, function() -- Line: 4479
        -- upvalues: u401 (copy)
        for _, descendant in ipairs(u401.Charge2:GetDescendants()) do
            if descendant:IsA("Beam") then
                game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.25), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;
    end);
    task.delay(2.783333333333333, function() -- Line: 4487
        -- upvalues: u401 (copy)
        for _, descendant in pairs(u401.ChargeBeamFloor:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u401.Charge2:GetDescendants()) do
            if descendant:IsA("Beam") then
                game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.25), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;
    end);
    task.delay(2.8, function() -- Line: 4502
        -- upvalues: u401 (copy), AURA (copy), FullAura (copy)
        for _, descendant in pairs(u401.Charge2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(AURA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u401.PRE3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(FullAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.55, function() -- Line: 4531
        -- upvalues: FullAura (copy)
        for _, descendant in pairs(FullAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.566666666666667, function() -- Line: 4539
        -- upvalues: LastAURA (copy), u401 (copy)
        for _, descendant in pairs(LastAURA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u401.PRE4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u401.LastCharge:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.966666666666667, function() -- Line: 4561
        -- upvalues: u401 (copy)
        for _, descendant in pairs(u401.LastCharge:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.1, function() -- Line: 4570
    end);
end;

function u1.DASTStrikeEFFECT(u406, p407) -- Line: 4573
    -- upvalues: Debris (copy), MeshEmitter (copy), ReplicatedStorage (copy), RunService (copy), raycast (copy)
    local Ball = workspace.Terrain:FindFirstChild("Ball");

    if not Ball then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Parent = workspace.Effects;
    Part.Anchored = true;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Transparency = 1;
    Part.CanCollide = false;
    local Part2 = Instance.new("Part");
    Part2.Parent = workspace.Effects;
    Part2.Anchored = true;
    Part2.Size = Vector3.new(1, 1, 1);
    Part2.Transparency = 1;
    Part2.CFrame = p407;
    Part2.CanCollide = false;
    Debris:AddItem(Part2, 5);
    Debris:AddItem(Part, 5);
    local u408 = MeshEmitter.StartMeshEmitter(Part, ReplicatedStorage.Resources.exe["projectile MeshEmitter"], nil, 5);
    u408.Parent = workspace.Effects;
    local u409 = {};
    local u410 = false;

    for _, child in pairs(u408.main:GetChildren()) do
        if child:IsA("Attachment") then
            child.Parent = Part2;
            table.insert(u409, child);
        end;
    end;

    local u411 = nil;
    local Y = Part.Position.Y;
    u411 = RunService.PreRender:Connect(function() -- Line: 4617
        -- upvalues: Ball (copy), u411 (ref), Part (copy), u406 (copy), raycast (ref), Y (ref), u410 (ref), u408 (copy), u409 (copy)
        if not Ball then
            u411:Disconnect();
        end;

        Part.Position = Ball.Position;
        Part.CFrame = CFrame.new(Ball.Position, Ball.Position + u406) * CFrame.Angles(0, -1.5707963267948966, 0);

        if raycast(Part.Position, u406 * 20, nil, { workspace.map }) or Part.Position.Y < Y - 0.75 then
            u411:Disconnect();
        end;

        if u411.Connected == false then
            u410 = true;

            for _, descendant in pairs(u408:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, v in ipairs(u409) do
                for _, child in pairs(v:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        child.Enabled = false;
                    elseif child:IsA("Beam") then
                        game:GetService("TweenService"):Create(child, TweenInfo.new(1), {
                            Width0 = 0,
                            Width1 = 0
                        }):Play();
                    end;
                end;
            end;
        end;

        Y = Part.Position.Y;
    end);
    local u412 = nil;
    task.delay(4, function() -- Line: 4651
        -- upvalues: u409 (copy)
        for _, v in ipairs(u409) do
            for _, child in pairs(v:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    child.Enabled = false;
                elseif child:IsA("Beam") then
                    game:GetService("TweenService"):Create(child, TweenInfo.new(1), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;
        end;
    end);
    task.spawn(function() -- Line: 4663
        -- upvalues: Ball (copy), u411 (ref), u412 (ref), MeshEmitter (ref), Part (copy), ReplicatedStorage (ref)
        for i = 1, 50 do
            if Ball.Position.Y > 1 and Ball then
                if u411.Connected == true then
                    u412 = MeshEmitter.StartMeshEmitter(Part, ReplicatedStorage.Resources.exe["projectile MeshEmitter2"], nil, 0.517);
                    u412.Parent = workspace.Effects;
                end;
            elseif not Ball then
                break;
            end;

            task.wait(0.1);
            local _ = i;
        end;
    end);
    task.delay(5, u411.Disconnect, u411);
end;

function u1.TP(p413, u414) -- Line: 4688
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local v415 = p413.HumanoidRootPart or p413.PrimaryPart;
    p413:FindFirstChild("Ball");
    u1.cutsceneBlender(v415, ReplicatedStorage.Resources.exe.Tpcam, ReplicatedStorage.Resources.exe.FOV);
    local u416, u417;

    if u414 then
        u416 = nil;
        u417 = nil;
    else
        u416 = ReplicatedStorage.Resources.exe.Exe:Clone();
        u416.Parent = workspace.Effects;

        for _, descendant in ipairs(u416:GetDescendants()) do
            if descendant:IsA("Weld") and p413:FindFirstChild(descendant.Name) then
                descendant.Part1 = p413[descendant.Name];
            end;
        end;

        u417 = function(p418, p419) -- Line: 4710
            -- upvalues: u416 (ref)
            local v420 = p418 or false;
            local v421 = p419 or 0.1;

            for _, descendant in pairs(u416:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = v420;

                    if v420 then
                        task.delay(v421, function() -- Line: 4717
                            -- upvalues: descendant (copy)
                            descendant.Enabled = false;
                        end);
                    end;
                end;
            end;
        end;
    end;

    task.delay(3, function() -- Line: 4726
        -- upvalues: u416 (ref)
        if u416 then
            u416:Destroy();
        end;
    end);
    task.delay(0.3, function() -- Line: 4732
        -- upvalues: u414 (copy), u417 (ref)
        if not u414 then
            u417(true, 0.117);
        end;
    end);
end;

function u1.Shortcut(u422) -- Line: 4739
    -- upvalues: actionUtil (copy), u1 (copy), ReplicatedStorage (copy), Invisible (copy)
    local u423 = u422.HumanoidRootPart or u422.PrimaryPart;
    u422:FindFirstChild("Ball");
    task.spawn(function() -- Line: 4743
        -- upvalues: actionUtil (ref), u422 (copy), u1 (ref), u423 (copy)
        if actionUtil.simulatesCharacter(u422) then
            task.spawn(function() -- Line: 4745
                -- upvalues: u1 (ref)
                u1.cameraShake(10, 2, 6);
                u1.fov(false, 85);
                u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            end);
            local v424 = u1.bodyVelocity(u423, 85, 3, nil, nil, nil);
            task.wait(1.756);
            v424:Destroy();
            u1.bodyVelocity(u423, 210, 0.75, nil, nil, nil);
            task.wait(0.567);
            u1.bodyVelocity(u423, 90, 0.4, nil, nil, nil);
        end;
    end);
    local u425 = ReplicatedStorage.Resources.exe.Exe:Clone();
    u425.Parent = workspace.Effects;

    for _, descendant in ipairs(u425:GetDescendants()) do
        if descendant:IsA("Weld") and u422:FindFirstChild(descendant.Name) then
            descendant.Part1 = u422[descendant.Name];
        end;
    end;

    local function Displayer(p426, p427) -- Line: 4772
        -- upvalues: u425 (copy)
        local v428 = p426 or false;
        local v429 = p427 or 0.1;

        for _, descendant in pairs(u425:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = v428;

                if v428 then
                    task.delay(v429, function() -- Line: 4779
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;
    end;

    task.delay(3, function() -- Line: 4787
        -- upvalues: u425 (copy)
        u425:Destroy();
    end);
    task.delay(0.3, function() -- Line: 4791
        -- upvalues: Displayer (copy), Invisible (ref), u422 (copy)
        Displayer(true, 0.117);
        Invisible({
            Time = 0.117,
            Character = u422
        });
    end);
    task.delay(0.517, function() -- Line: 4796
        -- upvalues: Displayer (copy), Invisible (ref), u422 (copy)
        Displayer(true, 0.1);
        Invisible({
            Time = 0.1,
            Character = u422
        });
    end);
    task.delay(0.917, function() -- Line: 4801
        -- upvalues: Displayer (copy), Invisible (ref), u422 (copy)
        Displayer(true, 0.1);
        Invisible({
            Time = 0.1,
            Character = u422
        });
    end);
    task.delay(1.167, function() -- Line: 4806
        -- upvalues: Displayer (copy), Invisible (ref), u422 (copy)
        Displayer(true, 0.1);
        Invisible({
            Time = 0.1,
            Character = u422
        });
    end);
    task.delay(1.667, function() -- Line: 4812
        -- upvalues: Displayer (copy), Invisible (ref), u422 (copy)
        Displayer(true, 0.2);
        Invisible({
            Time = 0.2,
            Character = u422
        });
    end);
    task.delay(2.167, function() -- Line: 4818
        -- upvalues: Displayer (copy), Invisible (ref), u422 (copy)
        Displayer(true, 0.2);
        Invisible({
            Time = 0.2,
            Character = u422
        });
    end);
end;

function u1.DashSuper(p430) -- Line: 4825
    -- upvalues: MeshEmitter (copy), ReplicatedStorage (copy), raycast (copy), u1 (copy), Lighting (copy), TweenService (copy), RunService (copy), Debris (copy)
    local u431 = p430.HumanoidRootPart or p430.PrimaryPart;
    p430:FindFirstChild("Ball");
    local CFrame2 = u431.CFrame;
    local LookVector = CFrame2.LookVector;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.Size = Vector3.new(2, 2, 1);
    Part.CanCollide = false;
    Part.Parent = workspace.Effects;
    Part.CFrame = CFrame2 * CFrame.new(Vector3.new(LookVector.X, 1e-7, LookVector.Z).Unit);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 0;
    NumberValue.Parent = p430;
    local u432 = MeshEmitter.StartMeshEmitter(Part, ReplicatedStorage.Resources.exe.DashMeshEmitter, nil, 5);
    u432.Parent = workspace.Effects;
    local u433 = ReplicatedStorage.Resources.exe.te:Clone();
    u433.Parent = workspace.Effects;
    Part.Transparency = 1;
    u433.Transparency = 1;
    u433.CFrame = u432.RootPart.CFrame * CFrame.new(0, 0, -76.509);
    local v434 = raycast(u431.Position, u431.CFrame.LookVector * 100, nil, { workspace.map });
    local u435;

    if v434 then
        u435 = CFrame.new(v434.Position);
        u433.Position = v434.Position;
    else
        u435 = u432.RootPart.CFrame * CFrame.new(0, 0, -76.509);
    end;

    task.delay(0.13333333333333333, function() -- Line: 4865
        -- upvalues: u432 (copy)
        for _, descendant in pairs(u432.PRE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.spawn(function() -- Line: 4874
        -- upvalues: u1 (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        task.wait(0.233);
        u1.cameraShake(10, 1.5, 6);
        local v436 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v436.Parent = Lighting;
        v436.Enabled = true;
        v436.TintColor = Color3.fromRGB(184, 197, 255);
        v436.Brightness = 0;
        v436.Contrast = 1;
        v436.Saturation = -2;
        TweenService:Create(v436, TweenInfo.new(0.067, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Saturation = 1
        }):Play();
        task.wait(0.067);
        task.wait(0.017);
        v436.Enabled = true;
        v436.TintColor = Color3.fromRGB(207, 216, 255);
        v436.Brightness = -1;
        v436.Contrast = -20;
        v436.Saturation = -1;
        task.wait(0.017);
        v436.Enabled = true;
        v436.TintColor = Color3.fromRGB(207, 216, 255);
        v436.Brightness = -1;
        v436.Contrast = -10;
        v436.Saturation = -1;
        task.wait(0.017);
        v436:Destroy();
    end);
    task.delay(0.3333333333333333, function() -- Line: 4905
        -- upvalues: u432 (copy), u433 (copy), TweenService (ref), NumberValue (copy), RunService (ref), u431 (copy), u435 (ref)
        for _, descendant in pairs(u432.TP:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.wait();

        for _, descendant in pairs(u433:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Transparency = NumberSequence.new(0);
                descendant.TextureSpeed = 5;
                TweenService:Create(descendant, TweenInfo.new(0.584), {
                    TextureSpeed = 0.1
                }):Play();
                task.spawn(function() -- Line: 4918
                    -- upvalues: descendant (copy)
                    for i = 0, 1, 0.1 do
                        descendant.Transparency = NumberSequence.new(i, 1);
                        wait();
                        local _ = i;
                    end;
                end);
            end;
        end;

        TweenService:Create(NumberValue, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0), {
            Value = 1
        }):Play();
        local u437 = nil;
        u437 = RunService.PreRender:Connect(function(p438) -- Line: 4940
            -- upvalues: NumberValue (ref), u437 (ref), u431 (ref), u435 (ref)
            if NumberValue.Value == 1 then
                u437:Disconnect();
            end;

            u431.CFrame = u431.CFrame:Lerp(u435, NumberValue.Value);
        end);
        task.delay(0.3, u437.Disconnect, u437);
    end);
    Debris:AddItem(u433, 5);
    Debris:AddItem(Part, 5);
    Debris:AddItem(NumberValue, 5);
end;

local function emitall(p439, p440) -- Line: 4977
    if not p439 then
        return;
    end;

    for _, descendant in pairs(p439:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(p440 or descendant:GetAttribute("EmitCount"));
        end;
    end;
end;

function u1.zombiedribble(u441) -- Line: 4990
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), u1 (copy), actionUtil (copy), Lighting (copy), TweenService (copy)
    local u442 = u441.HumanoidRootPart or u441.PrimaryPart;
    local Ball = u441:FindFirstChild("Ball");
    local u443 = {};

    for _, descendant in ipairs(u441:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v444 = descendant;

            for _, descendant2 in ipairs(ReplicatedStorage.Resources.donlorenzo.zombiedribble:GetDescendants()) do
                local v445 = descendant2:Clone();
                v445.Parent = v444;
                table.insert(u443, v445);
            end;
        end;
    end;

    local u446 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    u446.Weld.Part0 = u441["Right Arm"];
    u446.Parent = u441;
    local u447 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    u447.Weld.Part0 = u441["Left Arm"];
    u447.Parent = u441;
    local u448 = ReplicatedStorage.Resources.donlorenzo.balltrail:Clone();
    u448.Weld.Part0 = Ball;
    u448.Parent = u441;
    local u449 = ReplicatedStorage.Resources.donlorenzo.skill1movingpart:Clone();
    u449.Weld.Part0 = u442;
    u449.Parent = u441;

    if Util.canshiftcolor(LocalPlayer, u441) then
        vfxUtil.LeanTowardsColor(u443, u441:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u441:GetAttribute("CustomAlpha") or 0.985);
        vfxUtil.LeanTowardsColor({
            u446,
            u447,
            u448,
            u449
        }, u441:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u441:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.spawn(function() -- Line: 5031
        -- upvalues: u1 (ref), u442 (copy)
        u1.bodyVelocity(u442, 70, 0.8, nil, nil, nil);
        task.wait(0.57);
        u1.bodyVelocity(u442, 65, 0.6, nil, nil, nil);
        task.wait(0.1);
        u1.bodyVelocity(u442, 75, 1, nil, nil, nil);
        task.wait(0.62);
        u1.bodyVelocity(u442, 95, 0.8, nil, nil, nil);
        task.wait(0.3);
        u1.bodyVelocity(u442, 85, 0.6, nil, nil, nil);
    end);
    task.delay(2.03, function() -- Line: 5043
        -- upvalues: u447 (copy), u446 (copy), u449 (copy), u448 (copy), u443 (copy)
        u447:Destroy();
        u446:Destroy();
        u449:Destroy();
        u448:Destroy();

        for _, v in u443 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;
    end);
    task.delay(0.15, function() -- Line: 5056
        -- upvalues: actionUtil (ref), u441 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), u1 (ref)
        if actionUtil.simulatesCharacter(u441) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v450 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v450.Parent = Lighting;
            v450.TintColor = Color3.fromRGB(85, 0, 255);
            v450.Brightness = 0.4;
            v450.Contrast = 1;
            v450.Saturation = -0.4;
            TweenService:Create(v450, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v450, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v450.Destroy, v450);
            u1.fov(false, 100);
            u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            u1.cameraShake(10, 1.5, 6);
        end;
    end);
end;

function u1.doncounter(u451) -- Line: 5099
    -- upvalues: ReplicatedStorage (copy), soundUtil (copy), actionUtil (copy), Lighting (copy), TweenService (copy), u1 (copy)
    local v452 = u451.HumanoidRootPart or u451.PrimaryPart;
    local u453 = {};

    for _, descendant in ipairs(u451:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v454 = descendant;

            for _, descendant2 in ipairs(ReplicatedStorage.Resources.donlorenzo.zombiedribble:GetDescendants()) do
                local v455 = descendant2:Clone();
                v455.Parent = v454;
                table.insert(u453, v455);
            end;
        end;
    end;

    soundUtil:play(ReplicatedStorage.Resources.dcsound, v452);
    local u456 = nil;
    u456 = u451:GetAttributeChangedSignal("deathCounter"):connect(function() -- Line: 5117
        -- upvalues: u451 (copy), u456 (ref), u453 (copy)
        if u451:GetAttribute("deathCounter") then
            return;
        end;

        if u456 then
            u456:Disconnect();
        end;

        for _, v in u453 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;
    end);
    task.delay(2, function() -- Line: 5130
        -- upvalues: u456 (ref)
        u456:Disconnect();
    end);

    if not actionUtil.simulatesCharacter(u451) then
        return;
    end;

    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v457 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v457.Parent = Lighting;
    v457.TintColor = Color3.fromRGB(85, 0, 255);
    v457.Brightness = 0.4;
    v457.Contrast = 1;
    v457.Saturation = -0.4;
    TweenService:Create(v457, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v457, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v457.Destroy, v457);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 1.5, 6);
end;

function u1.lorenzodefenseHit(p458, p459) -- Line: 5174
    -- upvalues: ReplicatedStorage (copy), actionUtil (copy), Lighting (copy), TweenService (copy), u1 (copy)
    local v460 = p458.HumanoidRootPart or p458.PrimaryPart;
    local v461;

    if p459 then
        v461 = ReplicatedStorage.Resources.donlorenzo.skill3lorenzoD:Clone();
    else
        v461 = ReplicatedStorage.Resources.donlorenzo.skill3lorenzoA:Clone();
    end;

    v461.Parent = p458;
    v461:PivotTo(v460.CFrame);

    for _, descendant in pairs(v461:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(3, v461.Destroy, v461);

    if not actionUtil.simulatesCharacter(p458) then
        return;
    end;

    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v462 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v462.Parent = Lighting;
    v462.TintColor = Color3.fromRGB(85, 0, 255);
    v462.Brightness = 0.4;
    v462.Contrast = 1;
    v462.Saturation = -0.4;
    TweenService:Create(v462, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v462, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v462.Destroy, v462);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 1.5, 6);
end;

function u1.lorenzodefense(p463, p464) -- Line: 5234
    -- upvalues: ReplicatedStorage (copy), actionUtil (copy), u1 (copy), RunService (copy)
    local v465 = p463.HumanoidRootPart or p463.PrimaryPart;
    local u466 = {};

    for _, descendant in ipairs(p463:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v467 = descendant;

            for _, descendant2 in ipairs(ReplicatedStorage.Resources.donlorenzo.zombiedribble:GetDescendants()) do
                local v468 = descendant2:Clone();
                v468.Parent = v467;
                table.insert(u466, v468);
            end;
        end;
    end;

    local u469 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    u469.Weld.Part0 = p463["Right Arm"];
    u469.Parent = p463;
    local u470 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    u470.Weld.Part0 = p463["Left Arm"];
    u470.Parent = p463;
    task.delay(0.3, function() -- Line: 5302
        -- upvalues: u469 (copy), u470 (copy), u466 (copy)
        u469:Destroy();
        u470:Destroy();

        for _, v in u466 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;

        table.clear(u466);
    end);

    if actionUtil.simulatesCharacter(p463) then
        local u471;

        if p464 then
            u471 = v465.CFrame.RightVector * 70;
        else
            u471 = v465.CFrame.RightVector * -70;
        end;

        local u472 = u1.bodyVelocity(v465, 1, 0.15, nil, nil, true);
        u472.MaxForce = Vector3.new(300000, 300000, 300000);
        local u473 = nil;
        u473 = RunService.RenderStepped:Connect(function(p474) -- Line: 5328
            -- upvalues: u472 (copy), u473 (ref), u471 (ref)
            if u472 and u472:IsDescendantOf(game) then
                u472.Velocity = u471;

                return;
            end;

            u473:Disconnect();
        end);
        task.delay(15, u473.Disconnect, u473);
    end;
end;

function u1.lorenzocatch(p475) -- Line: 5339
    -- upvalues: u1 (copy), ReplicatedStorage (copy), RunService (copy), actionUtil (copy)
    local u476 = p475.HumanoidRootPart or p475.PrimaryPart;
    local _ = p475.Torso;
    u1.raycastEffect(u476, ReplicatedStorage.Resources.jumpsmoke, 3);
    local u477 = u1.bodyVelocity(u476, 1, 0.13, nil, nil, true);

    if u477 then
        u477.MaxForce = Vector3.new(300000, 300000, 300000);
        local u478 = nil;
        u478 = RunService.RenderStepped:Connect(function(p479) -- Line: 5352
            -- upvalues: u477 (copy), u478 (ref), u476 (copy)
            if u477 and u477:IsDescendantOf(game) then
                u477.Velocity = u476.CFrame.LookVector * 135 + u476.CFrame.UpVector * 25;

                return;
            end;

            u478:Disconnect();
        end);
        task.delay(15, u478.Disconnect, u478);
    end;

    if not actionUtil.simulatesCharacter(p475) then
        return;
    end;

    u1.cameraShake(15, 0.7, 4);
    u1.fov(false, 90);
    u1.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

local u480 = { { 0.3, "Look at you.", 1.567 }, { 2.517, "I guess you can still make that face.", 4.983 }, { 13.9, "Go!", 15 }, { 36.553, "Japan! Japan!", 51.55 } };
local u481 = { "Will you look at that..", "I\'m surprised you can still make that face.", "Let\'s go!" };

function CreateSubtitle(p482, p483)
    -- upvalues: PlayerGui (copy), Debris (copy)
    if PlayerGui:FindFirstChild("SubtitleUI") then
        pcall(game.Destroy, PlayerGui.SubtitleUI);
    end;

    local v484 = script.Subtitles:Clone();
    v484.Name = "SubtitleUI";
    v484.Holder.Dialogue.Text = p482;
    v484.Parent = PlayerGui;
    Debris:AddItem(v484, p483);
end;

function u1.finalmatch(u485, u486, p487, p488) -- Line: 5396
    -- upvalues: Lighting (copy), u1 (copy), StarterGui (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), ReplicatedStorage2 (copy), u480 (copy), u481 (copy), Brightness (copy), RunService (copy), workspace_CurrentCamera (copy), PlayerGui (copy), Debris (copy), trove (copy)
    local v489 = u485.HumanoidRootPart or u485.PrimaryPart;

    if not u486.HumanoidRootPart then
        local _ = u486.PrimaryPart;
    end;

    local Ball = u485:FindFirstChild("Ball");
    local _ = u485.Torso;
    local _ = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
    local u490 = ReplicatedStorage.Resources.rin.finalmatcheff:Clone();
    u490:PivotTo(v489.CFrame);
    u490.Parent = u485;

    if Util.canshiftcolor(LocalPlayer, u485) then
        vfxUtil.LeanTowardsColor(u490, u485:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u485:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u490:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    Lighting.Brightness = 0;
    local u491 = ReplicatedStorage.Resources.Blur:Clone();
    u491.Size = 0;
    u491.Parent = Lighting;
    local u492 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    u492.Parent = Lighting;
    u492.Brightness = 0;
    u492.TintColor = Color3.fromRGB(255, 255, 255);
    u492.Contrast = 0.2;
    u492.Saturation = -0.4;
    local u493 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u493.Parent = Lighting;
    u493.FarIntensity = 0;
    TweenService:Create(u493, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local u494 = soundUtil:play(ReplicatedStorage.Resources.rin.finalmatchs, SoundService, {
        Character = u485
    }).Name == "Dub";

    if p488 or (u485:GetAttribute("saeawk") or u486:GetAttribute("saeawk")) then
        u1.awkMusic(nil);
        soundUtil:play(ReplicatedStorage2.Resources.rin.finalmatchmusic, "default");
    end;

    u1.cutscene(v489, nil, 52.083, ReplicatedStorage.Resources.rin.finalmatchFOV);

    for i, v in ipairs(u480) do
        task.delay(v[1], function() -- Line: 5456
            -- upvalues: v (copy), u494 (copy), u481 (ref), i (copy)
            local v495 = v[2];

            if u494 then
                v495 = u481[i] or v495;
            end;

            CreateSubtitle(v495, v[3] - v[1]);
        end);
    end;

    task.delay(5.987, function() -- Line: 5468
        -- upvalues: u1 (ref), u486 (copy), ReplicatedStorage (ref)
        u1.Emit(u486.Head, ReplicatedStorage.Resources.rin.oxygen, 3);
    end);
    task.delay(7.933, function() -- Line: 5472
        -- upvalues: u1 (ref), u486 (copy), ReplicatedStorage (ref)
        u1.Emit(u486.Head, ReplicatedStorage.Resources.rin.oxygen, 3);
    end);
    task.delay(11.783, function() -- Line: 5476
        -- upvalues: u1 (ref), u486 (copy), ReplicatedStorage (ref)
        u1.Emit(u486.Head, ReplicatedStorage.Resources.rin.oxygen, 3);
    end);
    task.delay(14.467, function() -- Line: 5480
        -- upvalues: Lighting (ref), Brightness (ref), u493 (copy), ReplicatedStorage (ref), RunService (ref), workspace_CurrentCamera (ref)
        Lighting.Brightness = Brightness;
        u493.Enabled = false;
        local u496 = ReplicatedStorage.Resources.rin.zoomCam:Clone();
        u496.Parent = workspace.Effects;
        local u497 = nil;
        u497 = RunService.PreRender:connect(function() -- Line: 5489
            -- upvalues: u496 (copy), u497 (ref), workspace_CurrentCamera (ref)
            if not u496:IsDescendantOf(game) then
                u497:Disconnect();
            end;

            u496.CFrame = workspace_CurrentCamera.CFrame;
        end);
        task.delay(2.716, function() -- Line: 5499
            -- upvalues: u496 (copy), u493 (ref)
            u496:Destroy();
            u493.Enabled = true;
        end);
    end);
    task.delay(15.908, function() -- Line: 5506
        -- upvalues: PlayerGui (ref), Debris (ref)
        local v498 = script.FinalMatchUp:Clone();
        v498.Parent = PlayerGui;
        Debris:AddItem(v498, 1.2750000000000004);
    end);
    task.delay(17.183, function() -- Line: 5512
        -- upvalues: u490 (copy), u1 (ref), u485 (copy), ReplicatedStorage (ref)
        for _, descendant in pairs(u490.steppingparticleslol1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u1.Emit(u485["Left Leg"], ReplicatedStorage.Resources.rin.speedlineLeg, 1);
    end);
    task.delay(17.283, function() -- Line: 5523
        -- upvalues: u490 (copy), u1 (ref), u485 (copy), ReplicatedStorage (ref)
        for _, descendant in pairs(u490.steppingparticleslol2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u1.Emit(u485["Right Leg"], ReplicatedStorage.Resources.rin.speedlineLeg, 1);
    end);
    task.delay(17.383, function() -- Line: 5534
        -- upvalues: u1 (ref), u485 (copy), ReplicatedStorage (ref)
        u1.Emit(u485["Right Leg"], ReplicatedStorage.Resources.rin.speedlineLeg, 1);
    end);
    task.delay(17.917, function() -- Line: 5538
        -- upvalues: u1 (ref), u485 (copy), ReplicatedStorage (ref)
        u1.Emit(u485["Left Leg"], ReplicatedStorage.Resources.rin.speedlineLeg, 1);
    end);
    task.delay(18.017, function() -- Line: 5542
        -- upvalues: u1 (ref), u485 (copy), ReplicatedStorage (ref)
        u1.Emit(u485["Right Leg"], ReplicatedStorage.Resources.rin.speedlineLeg, 1);
    end);
    task.delay(18.133, function() -- Line: 5546
        -- upvalues: u1 (ref), u485 (copy), ReplicatedStorage (ref)
        u1.Emit(u485["Right Leg"], ReplicatedStorage.Resources.rin.speedlineLeg, 1);
    end);
    task.delay(18.25, function() -- Line: 5550
        -- upvalues: u1 (ref), u485 (copy), ReplicatedStorage (ref)
        u1.Emit(u485["Right Leg"], ReplicatedStorage.Resources.rin.speedlineLeg, 1);
    end);
    task.delay(18.267, function() -- Line: 5554
        -- upvalues: u1 (ref), u485 (copy), ReplicatedStorage (ref)
        u1.Emit(u485["Left Leg"], ReplicatedStorage.Resources.rin.speedlineLeg, 1);
    end);
    task.delay(17.4, function() -- Line: 5558
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.steppingparticleslol3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(17.917, function() -- Line: 5567
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.steppingparticleslol4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(18.133, function() -- Line: 5576
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.steppingparticleslol5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(18.233, function() -- Line: 5585
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.steppingparticleslol6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u490.dash:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(18.25, function() -- Line: 5601
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Step:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u490.fastjump:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(19.133, function() -- Line: 5617
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Step21:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(19.167, function() -- Line: 5626
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(19.233, function() -- Line: 5635
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Step22:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(19.25, function() -- Line: 5644
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(19.45, function() -- Line: 5653
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Step23:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(19.333, function() -- Line: 5662
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Step3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(20.35, function() -- Line: 5671
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Stepball:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(20.817, function() -- Line: 5680
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.ballkick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(21.617, function() -- Line: 5689
        -- upvalues: u490 (copy), Ball (copy), ReplicatedStorage (ref)
        for _, descendant in pairs(u490.ballkick2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        if not Ball then
            return;
        end;

        local v499 = ReplicatedStorage.Resources.rin.balltrail:Clone();
        v499.Weld.Part0 = Ball;
        v499.Parent = Ball;
        task.delay(0.884, v499.Destroy, v499);
    end);
    task.delay(23.233, function() -- Line: 5707
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.StepSlaam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(23.833, function() -- Line: 5716
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.RINRUNPARTICLES:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u490.saerinrunpart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(23.95, function() -- Line: 5734
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprun1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.083, function() -- Line: 5743
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprun2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.3, function() -- Line: 5752
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprun3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.45, function() -- Line: 5761
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprun4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.567, function() -- Line: 5770
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprun5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.767, function() -- Line: 5779
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprun6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.917, function() -- Line: 5788
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprun7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(23.917, function() -- Line: 5799
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprunsae1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.05, function() -- Line: 5808
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprunsae2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.133, function() -- Line: 5817
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprunsae3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.3, function() -- Line: 5826
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprunsae4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.433, function() -- Line: 5835
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprunsae5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.633, function() -- Line: 5844
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprunsae6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.767, function() -- Line: 5853
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprunsae7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(24.95, function() -- Line: 5862
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.Steprunsae8:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(25.383, function() -- Line: 5873
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.RINRUNPARTICLES:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u490.saerinrunpart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(26.133, function() -- Line: 5889
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.hit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(30.983, function() -- Line: 5898
        -- upvalues: Lighting (ref), Brightness (ref), ReplicatedStorage (ref), RunService (ref), workspace_CurrentCamera (ref)
        Lighting.Brightness = Brightness;
        local u500 = ReplicatedStorage.Resources.rin.zoomCam:Clone();
        u500.camvfx.camparticles.Enabled = false;
        u500.camvfx.CAM2.Enabled = true;
        u500.Parent = workspace.Effects;
        local u501 = nil;
        u501 = RunService.PreRender:connect(function() -- Line: 5907
            -- upvalues: u500 (copy), u501 (ref), workspace_CurrentCamera (ref)
            if not u500:IsDescendantOf(game) then
                u501:Disconnect();
            end;

            u500.CFrame = workspace_CurrentCamera.CFrame;
        end);
        task.delay(0.867, u500.Destroy, u500);
    end);
    task.delay(35.383, function() -- Line: 5918
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.hit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(37.217, function() -- Line: 5927
        -- upvalues: u1 (ref), u486 (copy), ReplicatedStorage (ref)
        u1.Emit(u486["Right Arm"], ReplicatedStorage.Resources.rin.armline, 3);
    end);
    task.delay(39.65, function() -- Line: 5931
        -- upvalues: u490 (copy)
        for _, descendant in pairs(u490.BRO:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(40.483, function() -- Line: 5940
        -- upvalues: TweenService (ref), u492 (copy), Lighting (ref), u490 (copy)
        TweenService:Create(u492, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
            Brightness = -0.2,
            Contrast = 1,
            Saturation = -0.4,
            TintColor = Color3.fromRGB(255, 177, 177)
        }):Play();
        TweenService:Create(Lighting, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();

        for _, descendant in pairs(u490.saebeams:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                if descendant:IsA("Beam") then
                    local CurveSize0 = descendant.CurveSize0;
                    local CurveSize1 = descendant.CurveSize1;
                    local Width0 = descendant.Width0;
                    local Width1 = descendant.Width1;
                    task.spawn(function() -- Line: 5964
                        -- upvalues: descendant (copy), CurveSize0 (copy), CurveSize1 (copy), Width0 (copy), Width1 (copy)
                        for i = 1, 15 do
                            descendant.CurveSize0 = Random.new():NextNumber(-25, 25);
                            descendant.CurveSize1 = Random.new():NextNumber(-25, 25);
                            descendant.Width0 = Random.new():NextNumber(-25, 25);
                            descendant.Width1 = Random.new():NextNumber(-25, 25);
                            task.wait(0.01);
                            local _ = i;
                        end;

                        descendant.CurveSize0 = CurveSize0;
                        descendant.CurveSize1 = CurveSize1;
                        descendant.Width0 = Width0;
                        descendant.Width1 = Width1;
                    end);
                end;

                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(42.583, function() -- Line: 5989
        -- upvalues: Lighting (ref), Brightness (ref), u492 (copy), u490 (copy)
        Lighting.Brightness = Brightness;
        u492.Brightness = 0;
        u492.TintColor = Color3.fromRGB(255, 255, 255);
        u492.Contrast = 0.2;
        u492.Saturation = -0.4;

        for _, descendant in pairs(u490.SAEVSRINAMBIENT:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u490.saebeams:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(48.15, function() -- Line: 6012
        -- upvalues: u490 (copy), ReplicatedStorage (ref), RunService (ref), workspace_CurrentCamera (ref)
        for _, descendant in pairs(u490.SAEVSRINAMBIENT:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local u502 = ReplicatedStorage.Resources.rin.zoomCam:Clone();
        u502.camvfx.camparticles.Enabled = false;
        u502.camvfx.CAM3.Enabled = true;
        u502.Parent = workspace.Effects;
        local u503 = nil;
        u503 = RunService.PreRender:connect(function() -- Line: 6026
            -- upvalues: u502 (copy), u503 (ref), workspace_CurrentCamera (ref)
            if not u502:IsDescendantOf(game) then
                u503:Disconnect();
            end;

            u502.CFrame = workspace_CurrentCamera.CFrame;
        end);
        task.delay(3.017, u502.Destroy, u502);
    end);
    local u504 = trove.new();
    u504:Add(function() -- Line: 6038
        -- upvalues: u490 (copy), u491 (copy), u492 (copy), u493 (copy)
        u490:Destroy();
        u491:Destroy();
        u492:Destroy();
        u493:Destroy();
    end);
    u504:Connect(p487.Changed, function(p505) -- Line: 6046
        -- upvalues: u504 (copy)
        if p505 then
            u504:Destroy();
        end;
    end);
    u504:Add(task.delay(52.083, function() -- Line: 6051
        -- upvalues: u1 (ref), StarterGui (ref), u504 (copy)
        pcall(function() -- Line: 6052
            -- upvalues: u1 (ref), StarterGui (ref)
            u1.sceneEnabled(false);
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
            u1.ultFlash(nil, 1.5);
            u1.fov(false, 15);
            u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end);
        u504:Destroy();
    end));
end;

function u1.lorenzocrossup(u506) -- Line: 6066
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), u1 (copy), Lighting (copy), TweenService (copy), soundUtil (copy), SoundService (copy), RunService (copy), workspace_CurrentCamera (copy), TekrinnDialogue (copy)
    local v507 = u506.HumanoidRootPart or u506.PrimaryPart;
    local Ball = u506:FindFirstChild("Ball");
    local _ = u506.Torso;
    local u508 = ReplicatedStorage.Resources.donlorenzo.crossuplorenzo:Clone();
    u508:PivotTo(v507.CFrame);
    u508.Parent = u506;

    if Util.canshiftcolor(LocalPlayer, u506) then
        vfxUtil.LeanTowardsColor(u508, u506:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u506:GetAttribute("CustomAlpha") or 0.985);
    end;

    u1.sceneEnabled(true);
    local v509 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v509.Parent = Lighting;
    v509.FarIntensity = 0;
    TweenService:Create(v509, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.donlorenzo.crossup, SoundService);
    u1.cutsceneBlender(v507, ReplicatedStorage.Resources.donlorenzo.camcrossup, ReplicatedStorage.Resources.donlorenzo.FOV3);
    local v510 = ReplicatedStorage.Resources.donlorenzo.ult4ball:Clone();
    v510.Weld.Part0 = Ball;
    v510.Parent = u506;
    local v511 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    v511.Weld.Part0 = u506["Right Arm"];
    v511.Parent = u506;
    local v512 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    v512.Weld.Part0 = u506["Left Arm"];
    v512.Parent = u506;
    local u513 = ReplicatedStorage.Resources.donlorenzo.awkCam:Clone();
    u513.Parent = u508;
    local u514 = nil;
    u514 = RunService.PreRender:connect(function() -- Line: 6111
        -- upvalues: u513 (copy), u514 (ref), workspace_CurrentCamera (ref)
        if not u513:IsDescendantOf(game) then
            u514:Disconnect();
        end;

        u513.CFrame = workspace_CurrentCamera.CFrame;
    end);
    task.delay(0, function() -- Line: 6119
        -- upvalues: TekrinnDialogue (ref), u506 (copy)
        TekrinnDialogue.Speak(u506, {
            {
                Text = "Nyo-ho!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 37, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            }
        }, 3);
    end);
    task.delay(1, function() -- Line: 6145
        -- upvalues: u513 (copy)
        for _, child in ipairs(u513:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;
    end);
    task.delay(2.32, function() -- Line: 6153
        -- upvalues: u508 (copy), u513 (copy), u1 (ref)
        for _, descendant in ipairs(u508.skill2ultemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, child in ipairs(u513:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;

        u1.bright(0.8, 0.6);
    end);
    local v515 = {};

    for _, descendant in ipairs(u506:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v516 = descendant;

            for _, child in ipairs(ReplicatedStorage.Resources.donlorenzo.ult4aura:GetChildren()) do
                local v517 = child:Clone();
                v517.Parent = v516;
                table.insert(v515, v517);
            end;
        end;
    end;

    task.wait(3);
    u508:Destroy();
    v510:Destroy();
    v511:Destroy();
    v512:Destroy();
    u513:Destroy();

    for _, v in v515 do
        v.Enabled = false;
        task.delay(3, v.Destroy, v);
    end;

    v509:Destroy();
    u1.sceneEnabled(false);
end;

function u1.InterceptSound() -- Line: 6201
    -- upvalues: Lighting (copy), TweenService (copy), u1 (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy)
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 11;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 2, 6);
    soundUtil:play(ReplicatedStorage.Resources.dcsound, SoundService);
end;

function u1.donyomi() -- Line: 6219
    -- upvalues: Lighting (copy), TweenService (copy), ReplicatedStorage (copy), u1 (copy), soundUtil (copy), SoundService (copy)
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 11;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v518 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v518.Parent = Lighting;
    v518.TintColor = Color3.fromRGB(136, 0, 255);
    v518.Brightness = 0.4;
    v518.Contrast = 1;
    v518.Saturation = -0.4;
    TweenService:Create(v518, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v518, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v518.Destroy, v518);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 2, 6);
    soundUtil:play(ReplicatedStorage.Resources.dcsound, SoundService);
end;

function u1.lorenzoundeadcrash(u519) -- Line: 6258
    -- upvalues: ReplicatedStorage (copy), u1 (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), actionUtil (copy), Lighting (copy), TweenService (copy)
    local u520 = u519.HumanoidRootPart or u519.PrimaryPart;
    local Ball = u519:FindFirstChild("Ball");
    local u521 = {};

    for _, descendant in ipairs(u519:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v522 = descendant;

            for _, descendant2 in ipairs(ReplicatedStorage.Resources.donlorenzo.zombiedribble:GetDescendants()) do
                local v523 = descendant2:Clone();
                v523.Parent = v522;
                table.insert(u521, v523);
            end;
        end;
    end;

    local u524 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    u524.Weld.Part0 = u519["Right Arm"];
    u524.Parent = u519;
    local u525 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
    u525.Weld.Part0 = u519["Left Arm"];
    u525.Parent = u519;
    local u526 = ReplicatedStorage.Resources.donlorenzo.balltrail:Clone();
    u526.Weld.Part0 = Ball;
    u526.Parent = u519;
    local u527 = ReplicatedStorage.Resources.donlorenzo.skill1movingpart:Clone();
    u527.Weld.Part0 = u520;
    u527.Parent = u519;
    task.delay(0.12, function() -- Line: 6293
        -- upvalues: u1 (ref), u520 (copy)
        u1.bodyVelocity(u520, 75, 0.6, nil, nil, nil);
        task.wait(0.28);
        u1.bodyVelocity(u520, 135, 1, nil, nil, nil);
    end);
    task.delay(0.55, function() -- Line: 6299
        -- upvalues: ReplicatedStorage (ref), u520 (copy), u519 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref)
        local v528 = ReplicatedStorage.Resources.donlorenzo.skull2lorenzoheader:Clone();
        v528:PivotTo(u520.CFrame);
        v528.Parent = u519;

        if Util.canshiftcolor(LocalPlayer, u519) then
            vfxUtil.LeanTowardsColor(v528, u519:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u519:GetAttribute("CustomAlpha") or 0.985);
        end;

        for _, descendant in pairs(v528:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.delay(3, v528.Destroy, v528);
    end);
    task.delay(1.25, function() -- Line: 6317
        -- upvalues: u521 (copy), u525 (copy), u524 (copy), u527 (copy), u526 (copy)
        for _, v in u521 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;

        u525:Destroy();
        u524:Destroy();
        u527:Destroy();
        u526:Destroy();
    end);
    task.delay(0.5, function() -- Line: 6330
        -- upvalues: actionUtil (ref), u519 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), u1 (ref)
        if actionUtil.simulatesCharacter(u519) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v529 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v529.Parent = Lighting;
            v529.TintColor = Color3.fromRGB(85, 0, 255);
            v529.Brightness = 0.4;
            v529.Contrast = 1;
            v529.Saturation = -0.4;
            TweenService:Create(v529, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v529, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v529.Destroy, v529);
            u1.fov(false, 100);
            u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            u1.cameraShake(15, 1.5, 6);
        end;
    end);
end;

function u1.yomichealTrue(u530, p531, p532) -- Line: 6373
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), PlayerGui (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), u1 (copy), TweenService (copy), soundUtil (copy), SoundService (copy), RunService (copy), workspace_CurrentCamera (copy), TekrinnDialogue (copy), Brightness (copy)
    local v533 = u530.HumanoidRootPart or u530.PrimaryPart;
    local Ball = u530:FindFirstChild("Ball");
    local _ = u530.Torso;
    local _ = Lighting.Atmosphere;
    local v534 = ReplicatedStorage.Resources.darkscreen:Clone();
    v534.Parent = PlayerGui;
    local u535 = ReplicatedStorage.Resources.donlorenzo.yomichealtruee:Clone();
    u535:PivotTo(v533.CFrame);
    u535.Parent = u530;

    if Util.canshiftcolor(LocalPlayer, u530) then
        vfxUtil.LeanTowardsColor(u535, u530:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u530:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u535:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    u1.sceneEnabled(true);
    Lighting.Brightness = 0;
    local v536 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v536.Parent = Lighting;
    v536.FarIntensity = 0;
    TweenService:Create(v536, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.donlorenzo[p532 and "yo micheal" or "yomichealfail"], SoundService);
    u1.cutsceneBlender(v533, p532 and ReplicatedStorage.Resources.donlorenzo.yomicTrueC or ReplicatedStorage.Resources.donlorenzo.yomicFailC, p532 and ReplicatedStorage.Resources.donlorenzo.yomicTrueFOV or ReplicatedStorage.Resources.donlorenzo.yomicFailFOV);
    local u537 = ReplicatedStorage.Resources.donlorenzo.camYomicheal:Clone();
    u537.Parent = u535;
    local u538 = nil;
    u538 = RunService.PreRender:connect(function() -- Line: 6430
        -- upvalues: u537 (copy), u538 (ref), workspace_CurrentCamera (ref)
        if not u537:IsDescendantOf(game) then
            u538:Disconnect();
        end;

        u537.CFrame = workspace_CurrentCamera.CFrame;
    end);
    task.delay(1.717, function() -- Line: 6440
        -- upvalues: TekrinnDialogue (ref), u530 (copy)
        TekrinnDialogue.Speak(u530, {
            {
                Text = "Yo Michael",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(119, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            }
        }, 1.5);
    end);
    local u539 = {};
    task.delay(0.433, function() -- Line: 6471
        -- upvalues: ReplicatedStorage (ref), u530 (copy), u535 (copy), u539 (copy)
        local v540 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
        v540.Weld.Part0 = u530["Right Arm"];
        v540.Parent = u535;
        local v541 = ReplicatedStorage.Resources.donlorenzo.trail:Clone();
        v541.Weld.Part0 = u530["Left Arm"];
        v541.Parent = u535;

        for _, descendant in ipairs(u530:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v542 = descendant;

                for _, child in ipairs(ReplicatedStorage.Resources.donlorenzo.ult4aura:GetChildren()) do
                    local v543 = child:Clone();
                    v543.Parent = v542;
                    table.insert(u539, v543);
                end;
            end;
        end;
    end);
    task.delay(1.5, function() -- Line: 6492
        -- upvalues: u535 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref)
        for _, descendant in ipairs(u535.skill1movingpart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u535.yomichealbeams:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;

                if descendant:IsA("Beam") then
                    descendant.TextureSpeed = 0.65;
                end;
            end;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 11;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v544 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v544.Parent = Lighting;
        v544.TintColor = Color3.fromRGB(136, 0, 255);
        v544.Brightness = 0.4;
        v544.Contrast = 1;
        v544.Saturation = -0.4;
        TweenService:Create(v544, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v544, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(1, v544.Destroy, v544);
    end);
    task.delay(2.517, function() -- Line: 6540
        -- upvalues: u535 (copy), u537 (copy)
        for _, descendant in ipairs(u535.yomichealbeams:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u535.skill1movingpart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u537:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);

    if p532 then
        task.delay(3.167, function() -- Line: 6561
            -- upvalues: Lighting (ref), Brightness (ref), u535 (copy), u537 (copy)
            Lighting.Brightness = Brightness;

            for _, descendant in ipairs(u535.skill1movingpart:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in ipairs(u535.skill4ballpartflashsteps:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            for _, descendant in ipairs(u537:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        task.delay(3.5, function() -- Line: 6584
            -- upvalues: Ball (copy), ReplicatedStorage (ref), u539 (copy)
            if not Ball then
                return;
            end;

            for _, child in ipairs(ReplicatedStorage.Resources.donlorenzo.ult4aura:GetChildren()) do
                local v545 = child:Clone();
                v545.Parent = Ball;
                table.insert(u539, v545);
            end;
        end);
        task.delay(3.833, function() -- Line: 6597
            -- upvalues: Lighting (ref), TweenService (ref), ReplicatedStorage (ref)
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 11;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v546 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v546.Parent = Lighting;
            v546.TintColor = Color3.fromRGB(136, 0, 255);
            v546.Brightness = 0.4;
            v546.Contrast = 1;
            v546.Saturation = -0.4;
            TweenService:Create(v546, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v546, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(1, v546.Destroy, v546);
        end);
    else
        task.delay(3.167, function() -- Line: 6631
            -- upvalues: Lighting (ref), Brightness (ref)
            Lighting.Brightness = Brightness;
        end);
        task.delay(3.25, function() -- Line: 6636
            -- upvalues: u535 (copy)
            for _, descendant in pairs(u535.skill2failstep2:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
        task.delay(3.333, function() -- Line: 6645
            -- upvalues: u535 (copy)
            for _, descendant in pairs(u535.skill2failstep1:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
        task.delay(3.677, function() -- Line: 6654
            -- upvalues: u535 (copy)
            for _, descendant in pairs(u535.skill2failstep3:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
        task.delay(3.677, function() -- Line: 6663
            -- upvalues: u535 (copy)
            for _, descendant in pairs(u535.skill2failstep4:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
        task.delay(3.867, function() -- Line: 6672
            -- upvalues: u535 (copy)
            for _, descendant in pairs(u535.skill2failstep5:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
        task.delay(3.967, function() -- Line: 6681
            -- upvalues: u535 (copy)
            for _, descendant in pairs(u535.skill2failstep6:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
    end;

    task.wait(5);
    u535:Destroy();
    v534:Destroy();
    u1.ultFlash(1, 1);

    for _, v in u539 do
        v:Destroy();
    end;

    table.clear(u539);
    v536:Destroy();
    u1.sceneEnabled(false);
end;

function u1.legacydribHit(p547) -- Line: 6715
    -- upvalues: u1 (copy), actionUtil (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local u548 = p547.HumanoidRootPart or p547.PrimaryPart;
    u1.characterImage({
        Duration = 0.8,
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        Count = 5,
        Whitelist = { p547 },
        Color = Color3.fromRGB(220, 172, 255)
    });
    u1.rockFlakes(u548, 0.45);

    if not actionUtil.simulatesCharacter(p547) then
        return;
    end;

    local v549 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v549.Parent = Lighting;
    v549.TintColor = Color3.fromRGB(0, 255, 106);
    v549.Brightness = 0.15;
    TweenService:Create(v549, TweenInfo.new(0.45), {
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(0.45, v549.Destroy, v549);
    u1.fov(false, 55);
    u1.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    u1.cameraShake(15, 1.3, 3);
    u1.destroyPosition(p547);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 0, 30000);
    BodyPosition.D = 300;
    BodyPosition.Parent = u548;
    TweenService:Create(BodyPosition, TweenInfo.new(0.45, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        P = 2500,
        D = 500
    }):Play();
    local u550 = -5;
    local v552 = RunService.PreRender:Connect(function(p551) -- Line: 6747
        -- upvalues: u550 (ref), u548 (copy), BodyPosition (copy)
        u550 = math.clamp(u550 + 0.7 * p551 * 60, -5, 2.5);
        local CFrame2 = u548.CFrame;
        BodyPosition.Position = CFrame2.LookVector * 4 + CFrame2.RightVector * u550 + u548.Position;
    end);
    task.delay(0.45, v552.Disconnect, v552);
    task.delay(0.45, BodyPosition.Destroy, BodyPosition);
end;

function u1.dribHit(p553, p554) -- Line: 6760
    -- upvalues: u1 (copy), Players (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy)
    local u555 = p553.HumanoidRootPart or p553.PrimaryPart;
    u1.cameraShake(10, 0.65, 6);

    if p554 and Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p554) then
        return;
    end;

    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v556 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v556.Parent = Lighting;
    v556.TintColor = Color3.fromRGB(255, 255, 255);
    v556.Brightness = 0.4;
    v556.Contrast = 1;
    v556.Saturation = -0.4;
    TweenService:Create(v556, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v556, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v556.Destroy, v556);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.bodyVelocity(u555, 190, 0.9, nil, nil, nil, TweenInfo.new(1.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
    u1.cameraShake(10, 1.5, 6);
    local u557, u558 = u1.bodyVelocity(u555, 120, 0.5, nil, nil, true);
    local u559 = 15;
    local u560 = 0;
    local u561 = nil;
    u561 = RunService.RenderStepped:Connect(function(p562) -- Line: 6832
        -- upvalues: u557 (copy), u561 (ref), u560 (ref), u559 (ref), u555 (copy), u558 (copy)
        local math_min_ret = math.min(p562, 0.03333333333333333);

        if not (u557 and (u557:IsDescendantOf(game) and shared.TabbedIn)) then
            u561:Disconnect();

            return;
        end;

        u560 = u560 + math_min_ret;
        u559 = u559 + math.sin(u560 * -5) * math_min_ret * 240;
        u559 = math.clamp(u559, 0, (1 / 0));
        u557.Velocity = u555.CFrame.LookVector * u558.Value + u555.CFrame.RightVector * -(u559 * 10);
    end);
    task.delay(15, u561.Disconnect, u561);
end;

function u1.AfterImage(p563, p564) -- Line: 6853
end;

function u1.beautifulDestruction(u565, u566, u567) -- Line: 6855
    -- upvalues: Util (copy), LocalPlayer (copy), u1 (copy), actionUtil (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy)
    local u568 = u565.HumanoidRootPart or u565.PrimaryPart;

    if Util.canshiftcolor(LocalPlayer, u565) then
        local _ = u565:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127);
    end;

    task.delay(0.283, function() -- Line: 6870
        -- upvalues: u1 (ref), u565 (copy), actionUtil (ref), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), u568 (copy), u567 (copy), RunService (ref), u566 (copy)
        u1.characterImage({
            Speed = 0.5,
            Brightness = 1,
            Whitelist = { u565 },
            Color = Color3.fromRGB(255, 67, 158)
        });
        u1.characterImage({
            Speed = 1,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            Count = 8,
            Whitelist = { u565 },
            Color = Color3.fromRGB(255, 74, 146),
            Color2 = Color3.fromRGB(66, 255, 113)
        });

        if actionUtil.simulatesCharacter(u565) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v569 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v569.Parent = Lighting;
            v569.TintColor = Color3.fromRGB(255, 104, 132);
            v569.Brightness = 0.4;
            v569.Contrast = 1;
            v569.Saturation = -0.4;
            TweenService:Create(v569, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v569, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v569.Destroy, v569);
            u1.fov(false, 100);
            u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            u1.cameraShake(10, 1.5, 6);
            local v570 = u565:GetAttribute("RinNoPlay") and 160 or 120;
            local u571, u572 = u1.bodyVelocity(u568, u567 and 200 or v570, 0.5, nil, nil, true);
            local u573 = u565:GetAttribute("RinNoPlay") and 30 or 23;
            local u574 = 0;
            local u575 = nil;
            u575 = RunService.RenderStepped:Connect(function(p576) -- Line: 6966
                -- upvalues: u571 (copy), u575 (ref), u574 (ref), u573 (ref), u566 (ref), u568 (ref), u572 (copy)
                local math_min_ret = math.min(p576, 0.03333333333333333);

                if not (u571 and u571:IsDescendantOf(game)) then
                    u575:Disconnect();

                    return;
                end;

                u574 = u574 + math_min_ret;
                u573 = u573 + math.sin(u574 * -5) * math_min_ret * 240;
                u573 = math.clamp(u573, 0, (1 / 0));
                u571.Velocity = u568.CFrame.LookVector * u572.Value + (u566 and u568.CFrame.RightVector * -(u573 * 10) or u568.CFrame.RightVector * (u573 * 10));
            end);
            task.delay(15, u575.Disconnect, u575);
        end;
    end);
end;

function u1.AbsoluteDestruction(u577, u578, u579) -- Line: 6990
    -- upvalues: soundUtil (copy), ReplicatedStorage (copy), UwUEffects (copy), u1 (copy), actionUtil (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local u580 = u577.HumanoidRootPart or u577.PrimaryPart;
    task.delay(0.75, function() -- Line: 6992
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), u580 (copy), UwUEffects (ref), u577 (copy), u1 (ref), actionUtil (ref), Lighting (ref), TweenService (ref), u579 (copy), RunService (ref), u578 (copy)
        soundUtil:play(ReplicatedStorage.Resources.sae.counterdribble, u580);
        UwUEffects.createEffect({
            Character = u577
        }, "SaeConfirm");
        u1.characterImage({
            Speed = 0.5,
            Brightness = 1,
            Whitelist = { u577 },
            Color = Color3.fromRGB(255, 67, 158)
        });
        u1.characterImage({
            Speed = 1,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            Count = 8,
            Whitelist = { u577 },
            Color = Color3.fromRGB(255, 74, 146),
            Color2 = Color3.fromRGB(66, 255, 113)
        });

        if actionUtil.simulatesCharacter(u577) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v581 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v581.Parent = Lighting;
            v581.TintColor = Color3.fromRGB(255, 104, 132);
            v581.Brightness = 0.4;
            v581.Contrast = 1;
            v581.Saturation = -0.4;
            TweenService:Create(v581, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v581, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(4, v581.Destroy, v581);
            u1.fov(false, 150);
            u1.fov(true, 70, 1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            u1.cameraShake(10, 1.5, 6);
            local u582, u583 = u1.bodyVelocity(u580, u579 and 200 or 149.74, 0.45, nil, nil, true);
            local u584 = 30;
            local u585 = 0;
            local u586 = nil;
            u586 = RunService.RenderStepped:Connect(function(p587) -- Line: 7061
                -- upvalues: u582 (copy), u586 (ref), u585 (ref), u584 (ref), u578 (ref), u580 (ref), u583 (copy)
                local math_min_ret = math.min(p587, 0.03333333333333333);

                if not (u582 and u582:IsDescendantOf(game)) then
                    u586:Disconnect();

                    return;
                end;

                u585 = u585 + math_min_ret;
                u584 = u584 + math.sin(u585 * -3) * math_min_ret * 240;
                u584 = math.clamp(u584, 0, (1 / 0));
                u582.Velocity = u580.CFrame.LookVector * u583.Value + (not u578 and u580.CFrame.RightVector * -(u584 * 10) or u580.CFrame.RightVector * (u584 * 10));
            end);
            task.delay(15, u586.Disconnect, u586);
        end;
    end);
end;

function u1.var2dash(u588, u589) -- Line: 7085
    -- upvalues: u1 (copy), actionUtil (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local u590 = u588.HumanoidRootPart or u588.PrimaryPart;
    task.delay(0, function() -- Line: 7088
        -- upvalues: u1 (ref), u588 (copy), actionUtil (ref), Lighting (ref), TweenService (ref), u590 (copy), RunService (ref), u589 (copy)
        u1.characterImage({
            Speed = 2.5,
            Brightness = 1,
            Whitelist = { u588 },
            Color = Color3.fromRGB(0, 0, 0)
        });
        u1.characterImage({
            Speed = 0.5,
            Brightness = 1,
            Whitelist = { u588 },
            Color = Color3.fromRGB(0, 0, 0)
        });
        u1.characterImage({
            Speed = 1,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            Count = 8,
            Whitelist = { u588 },
            Color = Color3.fromRGB(64, 109, 255),
            Color2 = Color3.fromRGB(74, 255, 64)
        });

        if actionUtil.simulatesCharacter(u588) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            u1.cameraShake(10, 1.5, 6);
            local u591, u592 = u1.bodyVelocity(u590, 160, 0.5, nil, nil, true);
            local u593 = 15;
            local u594 = 0;
            local u595 = nil;
            u595 = RunService.RenderStepped:Connect(function(p596) -- Line: 7138
                -- upvalues: u591 (copy), u595 (ref), u594 (ref), u593 (ref), u589 (ref), u590 (ref), u592 (copy)
                local math_min_ret = math.min(p596, 0.03333333333333333);

                if not (u591 and u591:IsDescendantOf(game)) then
                    u595:Disconnect();

                    return;
                end;

                u594 = u594 + math_min_ret;
                u593 = u593 + math.sin(u594 * -5) * math_min_ret * 240;
                u593 = math.clamp(u593, 0, (1 / 0));
                u591.Velocity = u590.CFrame.LookVector * u592.Value + (not u589 and u590.CFrame.RightVector * -(u593 * 10) or u590.CFrame.RightVector * (u593 * 10));
            end);
            task.delay(15, u595.Disconnect, u595);
        end;
    end);
end;

function u1.beautifulDestruction2(u597, u598) -- Line: 7162
    -- upvalues: ReplicatedStorage (copy), workspace_CurrentCamera (copy), RunService (copy), Lighting (copy), TweenService (copy), u1 (copy), actionUtil (copy)
    local u599 = u597.HumanoidRootPart or u597.PrimaryPart;
    task.delay(0, function() -- Line: 7171
        -- upvalues: ReplicatedStorage (ref), workspace_CurrentCamera (ref), RunService (ref), Lighting (ref), TweenService (ref), u1 (ref), u597 (copy), actionUtil (ref), u599 (copy), u598 (copy)
        local u600 = ReplicatedStorage.Resources.sae.bgScene:Clone();
        u600.Parent = workspace.Effects;
        u600.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -2);

        for _, descendant in ipairs(u600:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v602 = RunService.PreRender:connect(function(p601) -- Line: 7183
            -- upvalues: u600 (copy), workspace_CurrentCamera (ref)
            u600.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -2);
        end);
        task.delay(5, v602.Disconnect, v602);
        task.delay(5, u600.Destroy, u600);
        local u603 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        u603.Parent = Lighting;
        u603.TintColor = Color3.fromRGB(149, 156, 255);
        u603.Brightness = 0.1;
        u603.Contrast = 15;
        TweenService:Create(u603, TweenInfo.new(0.55), {
            Contrast = 0.5
        }):Play();
        task.delay(0.8333333333333333, function() -- Line: 7197
            -- upvalues: u1 (ref), TweenService (ref), u603 (copy)
            u1.cameraShake(20, 1, 3);
            u1.fov(false, 30);
            u1.cameraShake(20, 1.5, 3);
            TweenService:Create(u603, TweenInfo.new(1), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(1, u603.Destroy, u603);
        end);
        u1.fov(true, 70, 0.8333333333333333, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        u1.characterImage({
            Speed = 2.5,
            Brightness = 1,
            Whitelist = { u597 },
            Color = Color3.fromRGB(255, 255, 255)
        });
        u1.characterImage({
            Speed = 0.5,
            Brightness = 1,
            Whitelist = { u597 },
            Color = Color3.fromRGB(255, 67, 158)
        });
        u1.characterImage({
            Speed = 1,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            Count = 8,
            Whitelist = { u597 },
            Color = Color3.fromRGB(255, 74, 146),
            Color2 = Color3.fromRGB(66, 255, 113)
        });

        if actionUtil.simulatesCharacter(u597) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v604 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v604.Parent = Lighting;
            v604.TintColor = Color3.fromRGB(255, 104, 132);
            v604.Brightness = 0.4;
            v604.Contrast = 1;
            v604.Saturation = -0.4;
            TweenService:Create(v604, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v604, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v604.Destroy, v604);
            u1.fov(false, 100);
            u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            u1.cameraShake(10, 1.5, 6);
            local u605, u606 = u1.bodyVelocity(u599, 160, 0.5, nil, nil, true);
            local u607 = 30;
            local u608 = 0;
            local u609 = nil;
            u609 = RunService.RenderStepped:Connect(function(p610) -- Line: 7306
                -- upvalues: u605 (copy), u609 (ref), u608 (ref), u607 (ref), u598 (ref), u599 (ref), u606 (copy)
                local math_min_ret = math.min(p610, 0.03333333333333333);

                if not (u605 and u605:IsDescendantOf(game)) then
                    u609:Disconnect();

                    return;
                end;

                u608 = u608 + math_min_ret;
                u607 = u607 + math.sin(u608 * -5) * math_min_ret * 240;
                u607 = math.clamp(u607, 0, (1 / 0));
                u605.Velocity = u599.CFrame.LookVector * u606.Value + (not u598 and u599.CFrame.RightVector * -(u607 * 10) or u599.CFrame.RightVector * (u607 * 10));
            end);
            task.delay(15, u609.Disconnect, u609);
        end;
    end);
end;

function u1.saeheelflick(u611) -- Line: 7330
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), u1 (copy), TweenService (copy), actionUtil (copy), Lighting (copy)
    local u612 = u611.HumanoidRootPart or u611.PrimaryPart;
    local u613 = ReplicatedStorage.Resources.sae.heelflickeff:Clone();
    u613.Parent = u611;

    if Util.canshiftcolor(LocalPlayer, u611) then
        vfxUtil.LeanTowardsColor(u613, u611:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u611:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.delay(2, u613.Destroy, u613);
    task.delay(0.25, function() -- Line: 7348
        -- upvalues: u613 (copy), u612 (copy), u1 (ref)
        u613:PivotTo(u612.CFrame);

        for _, descendant in ipairs(u613.p1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u1.cameraShake(10, 0.4, 5);
    end);
    task.delay(0.717, function() -- Line: 7360
        -- upvalues: u613 (copy), u612 (copy), u1 (ref)
        u613:PivotTo(u612.CFrame);

        for _, descendant in ipairs(u613.p2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u1.cameraShake(10, 0.4, 5);
    end);
    task.delay(0.9889830508474577, function() -- Line: 7372
        -- upvalues: u1 (ref), u611 (copy), u613 (copy), u612 (copy), TweenService (ref), ReplicatedStorage (ref), actionUtil (ref), Lighting (ref)
        u1.characterImage({
            Speed = 0.5,
            Brightness = 1,
            Whitelist = { u611 },
            Color = Color3.fromRGB(255, 67, 158)
        });
        u1.characterImage({
            Speed = 0.5,
            CFrames = true,
            Brightness = 3,
            countSpeed = 0.03,
            Count = 8,
            Whitelist = { u611 },
            Color = Color3.fromRGB(255, 111, 185),
            Color2 = Color3.fromRGB(66, 255, 113)
        });
        u613:PivotTo(u612.CFrame);
        u613.Reda.Mesh.Scale = Vector3.new(0.1, 0.9, 0.9);
        TweenService:Create(u613.Reda.Mesh, TweenInfo.new(0.266, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Scale = Vector3.new(0.8, 0, 0)
        }):Play();

        for _, descendant in ipairs(u613.Reda:GetDescendants()) do
            if descendant:IsA("Decal") then
                descendant.Transparency = 0;
            end;
        end;

        local u614 = ReplicatedStorage.Resources.sae.aurarun:Clone();
        u614.Weld.Part0 = u612;
        u614.Parent = u613;

        for _, descendant in ipairs(u614:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;

                if descendant:IsA("Beam") then
                    task.spawn(function() -- Line: 7425
                        -- upvalues: u614 (copy), descendant (copy)
                        for i = 1, 50 do
                            if not u614:IsDescendantOf(game) then
                                break;
                            end;

                            descendant.CurveSize0 = Random.new():NextNumber(-8, 8);
                            descendant.CurveSize1 = Random.new():NextNumber(-8, 8);
                            descendant.Width1 = Random.new():NextNumber(0, 8);
                            task.wait(0.01);
                            local _ = i;
                        end;
                    end);
                end;
            end;
        end;

        task.delay(0.55, u613.Destroy, u613);

        if actionUtil.simulatesCharacter(u611) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v615 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v615.Parent = Lighting;
            v615.TintColor = Color3.fromRGB(255, 104, 132);
            v615.Brightness = 0.4;
            v615.Contrast = 1;
            v615.Saturation = -0.4;
            TweenService:Create(v615, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v615, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v615.Destroy, v615);
            u1.fov(false, 100);
            u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            u1.bodyVelocity(u612, 229.99999999999997, 0.9, nil, nil, nil, TweenInfo.new(1.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
            u1.cameraShake(10, 1.5, 6);
        end;
    end);
end;

function u1.saeoffballrun(p616, p617) -- Line: 7517
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), u1 (copy), TweenService (copy), actionUtil (copy), Lighting (copy)
    local v618 = p616.HumanoidRootPart or p616.PrimaryPart;
    local v619 = ReplicatedStorage.Resources.sae.heelflickeff:Clone();
    v619.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, p616) then
        vfxUtil.LeanTowardsColor(v619, p616:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p616:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.delay(2, v619.Destroy, v619);
    u1.characterImage({
        Speed = 0.5,
        Brightness = 1,
        Whitelist = { p616 },
        Color = Color3.fromRGB(255, 67, 158)
    });
    u1.characterImage({
        Speed = 0.5,
        CFrames = true,
        Brightness = 3,
        countSpeed = 0.03,
        Count = 8,
        Whitelist = { p616 },
        Color = Color3.fromRGB(255, 111, 185),
        Color2 = Color3.fromRGB(66, 255, 113)
    });
    v619:PivotTo(v618.CFrame);
    v619.Reda.Mesh.Scale = Vector3.new(0.1, 0.9, 0.9);
    TweenService:Create(v619.Reda.Mesh, TweenInfo.new(0.266, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Scale = Vector3.new(0.8, 0, 0)
    }):Play();

    for _, descendant in ipairs(v619.Reda:GetDescendants()) do
        if descendant:IsA("Decal") then
            descendant.Transparency = 0;
        end;
    end;

    local u620 = ReplicatedStorage.Resources.sae.aurarun:Clone();
    u620.Weld.Part0 = v618;
    u620.Parent = v619;

    for _, descendant in ipairs(u620:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = true;

            if descendant:IsA("Beam") then
                task.spawn(function() -- Line: 7572
                    -- upvalues: u620 (copy), descendant (copy)
                    for i = 1, 50 do
                        if not u620:IsDescendantOf(game) then
                            break;
                        end;

                        descendant.CurveSize0 = Random.new():NextNumber(-8, 8);
                        descendant.CurveSize1 = Random.new():NextNumber(-8, 8);
                        descendant.Width1 = Random.new():NextNumber(0, 8);
                        task.wait(0.01);
                        local _ = i;
                    end;
                end);
            end;
        end;
    end;

    task.delay(0.55, v619.Destroy, v619);

    if actionUtil.simulatesCharacter(p616) then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v621 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v621.Parent = Lighting;
        v621.TintColor = Color3.fromRGB(255, 104, 132);
        v621.Brightness = 0.4;
        v621.Contrast = 1;
        v621.Saturation = -0.4;
        TweenService:Create(v621, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v621, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v621.Destroy, v621);
        u1.fov(false, 100);
        u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        u1.bodyVelocity(v618, (p617 and 200 or 300) * (p617 and 0.96 or 1), 0.5, nil, nil, nil, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
        u1.cameraShake(10, 1.5, 6);
    end;
end;

function u1.zantetsuoffballrun(p622, p623) -- Line: 7642
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), u1 (copy), TweenService (copy), actionUtil (copy), Lighting (copy)
    local v624 = p622.HumanoidRootPart or p622.PrimaryPart;
    local v625 = ReplicatedStorage.Resources.sae.zantetuseff:Clone();
    v625.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, p622) then
        vfxUtil.LeanTowardsColor(v625, p622:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p622:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.delay(2, v625.Destroy, v625);
    u1.characterImage({
        Speed = 0.5,
        Brightness = 1,
        Whitelist = { p622 },
        Color = Color3.fromRGB(27, 27, 27)
    });
    u1.characterImage({
        Speed = 0.5,
        CFrames = true,
        Brightness = 3,
        countSpeed = 0.03,
        Count = 8,
        Whitelist = { p622 },
        Color = Color3.fromRGB(42, 42, 42),
        Color2 = Color3.fromRGB(255, 255, 255)
    });
    v625:PivotTo(v624.CFrame);
    v625.Reda.Mesh.Scale = Vector3.new(0.1, 0.9, 0.9);
    TweenService:Create(v625.Reda.Mesh, TweenInfo.new(0.266, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Scale = Vector3.new(0.8, 0, 0)
    }):Play();

    for _, descendant in ipairs(v625.Reda:GetDescendants()) do
        if descendant:IsA("Decal") then
            descendant.Transparency = 0;
        end;
    end;

    local u626 = ReplicatedStorage.Resources.sae.zantetsuararun:Clone();
    u626.Weld.Part0 = v624;
    u626.Parent = v625;

    for _, descendant in ipairs(u626:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = true;

            if descendant:IsA("Beam") then
                task.spawn(function() -- Line: 7698
                    -- upvalues: u626 (copy), descendant (copy)
                    for i = 1, 50 do
                        if not u626:IsDescendantOf(game) then
                            break;
                        end;

                        descendant.CurveSize0 = Random.new():NextNumber(-8, 8);
                        descendant.CurveSize1 = Random.new():NextNumber(-8, 8);
                        descendant.Width1 = Random.new():NextNumber(0, 8);
                        task.wait(0.01);
                        local _ = i;
                    end;
                end);
            end;
        end;
    end;

    task.delay(0.55, v625.Destroy, v625);

    if actionUtil.simulatesCharacter(p622) then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v627 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v627.Parent = Lighting;
        v627.TintColor = Color3.fromRGB(27, 27, 27);
        v627.Brightness = 0.4;
        v627.Contrast = 1;
        v627.Saturation = -0.4;
        TweenService:Create(v627, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v627, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v627.Destroy, v627);
        u1.fov(false, 100);
        u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        u1.bodyVelocity(v624, 300, 0.5, nil, nil, nil, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
        u1.cameraShake(10, 1.5, 6);
    end;
end;

function setting(p628, p629)
    return typeof(p628) ~= "table" and true or not p628[p629];
end;

function u1.start(p630, p631, p632, p633) -- Line: 7772
    -- upvalues: u1 (copy), ReplicatedStorage (copy), PlayerGui (copy), TweenService (copy), soundUtil (copy), SoundService (copy), vfxUtil (copy), Players (copy)
    if not p633 then
        u1.sceneEnabled(true);
    end;

    local v634 = p630 or 3;
    local u635 = ReplicatedStorage.Resources.startUI:Clone();
    u635.Parent = PlayerGui;
    local TextLabel = u635.Frame.TextLabel;
    TextLabel.TextTransparency = 0;
    TextLabel.Text = tostring(v634);
    local v636;

    if typeof(p632) == "table" and typeof(p632.NoCountdown) == "number" then
        v636 = p632.NoCountdown;
    else
        v636 = nil;
    end;

    for i = v634, 1, -1 do
        TextLabel.TextTransparency = 0;
        TextLabel.Text = tostring(i);
        TweenService:Create(u635.Frame.ImageLabel2, TweenInfo.new(3), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(TextLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play();

        if (setting(p632, "NoCountdown") or v636) and (not v636 or i <= v636) then
            soundUtil:play(ReplicatedStorage.Resources.count, SoundService);
            u1.bright(0.15, 3);
            u1.cameraShake(5, 3, 3);
        end;

        task.wait(1);
        local _ = i;
    end;

    if setting(p632, "NoKickOff") then
        TextLabel.TextTransparency = 0;
        TextLabel.Text = p631 or "KICK OFF!";

        if setting(p632, "NoWhistle") and not vfxUtil.IsSettingOn(Players.LocalPlayer, "RemoveRefereeWhistle") then
            soundUtil:play(ReplicatedStorage.Resources.goal2, SoundService);
        end;

        if setting(p632, "NoCrowd") then
            soundUtil:play(ReplicatedStorage.Resources.startgame, SoundService);
        end;
    end;

    u1.bright(0.15, 3);
    u1.cameraShake(15, 3, 3);

    if not p633 then
        u1.sceneEnabled(false);
    end;

    TweenService:Create(u635.Frame.ImageLabel2, TweenInfo.new(3), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(TextLabel, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        TextTransparency = 1
    }):Play();
    task.delay(3, function() -- Line: 7833
        -- upvalues: u635 (copy)
        u635:Destroy();
    end);
end;

function u1.endgamewhistle() -- Line: 7838
    -- upvalues: vfxUtil (copy), Players (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy)
    if not vfxUtil.IsSettingOn(Players.LocalPlayer, "RemoveRefereeWhistle") then
        soundUtil:play(ReplicatedStorage.Resources.endgamewhistle, SoundService);
    end;
end;

function u1.goal(u637, p638, p639, u640, p641, p642) -- Line: 7844
    -- upvalues: Players (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), vfxUtil (copy), LocalPlayer (copy), u1 (copy), PlayerGui (copy), TweenService (copy), workspace_CurrentCamera (copy), RunService (copy), Lighting (copy)
    if not u640 then
        return;
    end;

    Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
    soundUtil:play(ReplicatedStorage.Resources.goal, SoundService);

    if not vfxUtil.IsSettingOn(Players.LocalPlayer, "RemoveRefereeWhistle") then
        soundUtil:play(ReplicatedStorage.Resources.goal2, SoundService);
    end;

    local setting2 = LocalPlayer:FindFirstChild("setting");
    local v643;

    if setting2 and setting2:FindFirstChild("crowdCheer") then
        v643 = setting2:FindFirstChild("crowdCheer").Value;
    else
        v643 = nil;
    end;

    if not v643 then
        soundUtil:play(ReplicatedStorage.Resources.CrowdGOL, SoundService);
    end;

    local u644 = u640 == "A" and p638 and p638 or p639;

    if u640 == "A" then
        p638 = p638 - 1;
    else
        p639 = p639 - 1;
    end;

    u1.sceneEnabled(true);
    u1.cameraShake(15, 3, 8);
    u1.fov(false, 40);
    u1.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local u645 = ReplicatedStorage.Resources.GoalUI:Clone();
    u645.Parent = PlayerGui;
    u645.Frame.ImageLabel.Position = UDim2.new(0.1, 0, -1, 0);
    u645.Frame.A.Text = p638;
    u645.Frame.B.Text = p639;
    task.delay(1, function() -- Line: 7882
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u645 (copy), u640 (copy), TweenService (ref), u644 (copy)
        soundUtil:play(ReplicatedStorage.Resources.count, SoundService);
        u645.Frame[u640].BackgroundTransparency = 0;
        TweenService:Create(u645.Frame[u640], TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        }):Play();
        u645.Frame[u640].Text = u644;
        TweenService:Create(u645.Frame.A, TweenInfo.new(1), {
            TextTransparency = 1
        }):Play();
        TweenService:Create(u645.Frame.B, TweenInfo.new(1), {
            TextTransparency = 1
        }):Play();
        TweenService:Create(u645.Frame.TextLabel, TweenInfo.new(1), {
            TextTransparency = 1
        }):Play();
    end);
    TweenService:Create(u645.Frame.ImageLabel2, TweenInfo.new(3), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(u645.Frame.ImageLabel, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.1, 0, 0, 0)
    }):Play();
    TweenService:Create(u645.Frame.ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    u1.bright(1, 1.5);
    local Character = LocalPlayer.Character;
    task.delay(4, u645.Destroy, u645);
    task.wait(2);

    if (u637 or p641 and (p641.root or p641.ballControl)) and not ReplicatedStorage.workspace.disabled.Value then
        u1.fov(true, 45, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local u646 = nil;

        if p641 and p641.root then
            u646 = p641.root;
        elseif u637 and u637:IsA("BasePart") then
            u646 = u637;
        elseif u637 then
            u646 = u637.HumanoidRootPart or u637.PrimaryPart;
        end;

        local u647;

        if p641 then
            u647 = p641.ballControl;
        else
            u647 = p641;
        end;

        if not (u646 or u647) then
            u1.sceneEnabled(false);

            return;
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local v650 = RunService.PreRender:Connect(function(p648) -- Line: 7939
            -- upvalues: u647 (copy), ReplicatedStorage (ref), u646 (ref), workspace_CurrentCamera (ref)
            local v649;

            if u647 then
                local CFBall = ReplicatedStorage:FindFirstChild("CFBall");

                if CFBall and CFBall:IsA("CFrameValue") then
                    v649 = CFBall.Value;
                else
                    if not u646 then
                        return;
                    end;

                    v649 = u646.CFrame;
                end;
            else
                v649 = u646.CFrame;
            end;

            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:Lerp(v649 * CFrame.new(-4, 0.5, -15) * CFrame.Angles(0, 3.141592653589793, 0), p648 * 5);
        end);
        local v651;

        if LocalPlayer.Character == Character then
            v651 = ReplicatedStorage.Resources.DepthOfField:Clone();
            v651.Name = "GoalDepth";
            v651.Parent = Lighting;
            v651.FarIntensity = 0;
            TweenService:Create(v651, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                FarIntensity = 1
            }):Play();
        else
            v651 = nil;
        end;

        local u652 = ReplicatedStorage.Resources.playerstatsUI:Clone();
        u652.Parent = PlayerGui;

        local function showStats(p653) -- Line: 7974
            -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u652 (copy), TweenService (ref), u637 (copy), Players (ref)
            soundUtil:play(ReplicatedStorage.Resources.uishow, SoundService);
            u652.Frame.bg.ImageTransparency = 1;
            TweenService:Create(u652.Frame.bg, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = 0.68
            }):Play();
            TweenService:Create(u652.Frame.icon, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Rotation = 0
            }):Play();
            TweenService:Create(u652.Frame.ImageLabel3.Frame, TweenInfo.new(0.5), {
                BackgroundTransparency = 1
            }):Play();
            u652.Frame.ImageLabel3.Frame.BackgroundTransparency = 0;
            u652.Frame.icon.Rotation = 90;

            if p653.ballControl then
                u652.Frame.ImageLabel3.goname.Text = "Ball";
                u652.Frame.ImageLabel3.role.Text = p653.role or "Ball";
                u652.Frame.ImageLabel3.goltext.Text = `GOL : {p653.stats.goals}`;
                u652.Frame.ImageLabel3.asttext.Text = `AST : {p653.stats.assists}`;
                u652.Frame.ImageLabel3.savtext.Text = `SAV : {p653.stats.saves}`;

                return;
            end;

            if u637 and u637:GetAttribute("AIGK") then
                u652.Frame.ImageLabel3.goname.Text = "-";
                u652.Frame.ImageLabel3.role.Text = p653.role;
                u652.Frame.ImageLabel3.goltext.Text = "GOL : 0";
                u652.Frame.ImageLabel3.asttext.Text = "AST : 0";
                u652.Frame.ImageLabel3.savtext.Text = "SAV : 0";

                return;
            end;

            local v654 = p653.name or u637.Name;
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(workspace.characters:FindFirstChild(v654));
            local v655 = PlayerFromCharacter and (PlayerFromCharacter:GetAttribute("style") == "dio" and workspace.characters[v654]:HasTag("fit")) and "DIO" or v654;
            u652.Frame.ImageLabel3.goname.Text = v655;
            u652.Frame.ImageLabel3.role.Text = p653.role;
            u652.Frame.ImageLabel3.goltext.Text = `GOL : {p653.stats.goals}`;
            u652.Frame.ImageLabel3.asttext.Text = `AST : {p653.stats.assists}`;
            u652.Frame.ImageLabel3.savtext.Text = `SAV : {p653.stats.saves}`;
        end;

        showStats(p641);
        task.wait(2.25);

        if p642 then
            showStats(p642);
            u646 = p642.root;
        end;

        task.wait(2.25);
        local v656 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v656.Parent = Lighting;
        v656.Brightness = 0;
        TweenService:Create(v656, TweenInfo.new(0.5), {
            Brightness = -1
        }):Play();
        task.wait(0.5);
        TweenService:Create(v656, TweenInfo.new(1), {
            Brightness = 0
        }):Play();
        task.delay(1, v656.Destroy, v656);
        v650:Disconnect();
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        u1.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        pcall(function() -- Line: 8052
            -- upvalues: TweenService (ref), u652 (copy)
            TweenService:Create(u652.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                GroupTransparency = 1
            }):Play();
        end);
        pcall(game.Destroy, v651);
        u652:Destroy();
    end;

    u1.sceneEnabled(false);
end;

function u1.skip() -- Line: 8068
    -- upvalues: ReplicatedStorage (copy), PlayerGui (copy)
    local v657 = ReplicatedStorage.Resources.Black:Clone();
    v657.Parent = PlayerGui;
    task.delay(1, v657.Destroy, v657);
end;

function u1.drip(p658, p659) -- Line: 8075
    -- upvalues: ReplicatedStorage (copy)
    if not p659.HumanoidRootPart then
        local _ = p659.PrimaryPart;
    end;

    local _ = p659.Torso;
    local u660 = ReplicatedStorage.Resources.armdrip:Clone();
    u660.Parent = p659;
    u660.Weld.Part0 = p659["Left Arm"];
    local u661 = ReplicatedStorage.Resources.armdrip:Clone();
    u661.Parent = p659;
    u661.Weld.Part0 = p659["Right Arm"];
    task.delay(0.25, function() -- Line: 8106
        -- upvalues: u660 (copy), u661 (copy)
        for _, descendant in ipairs(u660:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u661:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u660.Destroy, u660);
        task.delay(2, u661.Destroy, u661);
    end);
end;

function u1.isagiawaken(u662) -- Line: 8122
    -- upvalues: u1 (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), TekrinnDialogue (copy), RunService (copy)
    local v663 = u662.HumanoidRootPart or u662.PrimaryPart;
    local _ = u662.Torso;
    u1.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage.Resources.isagi.isagiawaken, SoundService);
    u1.cutscene(v663, CFrame.new(Vector3.new(0, 0, 0)), 4.5, ReplicatedStorage.Resources.isagi.FOV);
    task.delay(0.05, function() -- Line: 8133
        -- upvalues: TekrinnDialogue (ref), u662 (copy)
        TekrinnDialogue.Speak(u662, {
            {
                Text = "I need you to shut up, genius",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1.5);
    end);
    task.delay(3.55, function() -- Line: 8159
        -- upvalues: TekrinnDialogue (ref), u662 (copy)
        TekrinnDialogue.Speak(u662, {
            {
                Text = "I\'m about to get to the",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            },
            {
                Text = " good part.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1.5
                }
            }
        }, 1.5);
    end);
    local u664 = ReplicatedStorage.Resources.isagi.A:Clone();
    u664.CFrame = v663.CFrame;
    u664.Parent = u662;
    local v667 = RunService.PreRender:Connect(function(p665) -- Line: 8210
        -- upvalues: u664 (copy)
        local v666 = u664;
        v666.CFrame = v666.CFrame * CFrame.Angles(0, 0.005, 0);
    end);
    u1.bright(1, 1.5);
    local v668 = ReplicatedStorage.Resources.isagi.RoomReal:Clone();
    v668.CFrame = v663.CFrame;
    v668.Parent = u662;
    task.wait(1.91);
    v668:Destroy();
    local v669 = ReplicatedStorage.Resources.isagi.RoomReal2:Clone();
    v669.CFrame = v663.CFrame;
    v669.Parent = u662;
    local v670 = ReplicatedStorage.Resources.isagi.legwater:Clone();
    v670.Parent = u662;
    v670.CFrame = CFrame.new(u662["Left Leg"].Position);
    local v671 = ReplicatedStorage.Resources.isagi.legwater:Clone();
    v671.Parent = u662;
    v671.CFrame = CFrame.new(u662["Right Leg"].Position);
    task.wait(2.5);
    v669:Destroy();
    v667:Disconnect();
    u664:Destroy();
    v670:Destroy();
    v671:Destroy();
    u1.ultFlash(-1, 1);
    u1.fov(false, 40);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    u1.sceneEnabled(false);
end;

function u1.isagiult(u672) -- Line: 8283
    -- upvalues: u1 (copy), TekrinnDialogue (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Density (copy), Color (copy)
    local v673 = u672.HumanoidRootPart or u672.PrimaryPart;
    local _ = u672.Torso;
    u1.sceneEnabled(true);
    task.delay(0.15, function() -- Line: 8293
        -- upvalues: TekrinnDialogue (ref), u672 (copy)
        TekrinnDialogue.Speak(u672, {
            {
                Text = "I want to...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.5
                }
            }
        }, 1.5);
    end);
    task.delay(1.333, function() -- Line: 8319
        -- upvalues: TekrinnDialogue (ref), u672 (copy)
        TekrinnDialogue.Speak(u672, {
            {
                Text = "I want to win with my goal!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            }
        }, 2);
    end);
    task.delay(4.117, function() -- Line: 8345
        -- upvalues: TekrinnDialogue (ref), u672 (copy)
        TekrinnDialogue.Speak(u672, {
            {
                Text = "MY DIRECT SHOT!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 4, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, 2);
    end);
    local v674 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v674.Parent = Lighting;
    v674.FarIntensity = 0;
    TweenService:Create(v674, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.isagi["DIRECTA SHOOTOTA"], SoundService);
    u1.cutscene(v673, CFrame.new(Vector3.new(0, 0, 0)), 5.5, ReplicatedStorage.Resources.isagi.uFOV, true);
    task.wait(0.15);
    local v675 = ReplicatedStorage.Resources.isagi.step:Clone();
    v675.CFrame = v673.CFrame * CFrame.new(0.5, -2.6, 0.3);
    v675.Parent = workspace.Effects;

    for _, descendant in ipairs(v675:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(2, v675.Destroy, v675);
    task.wait(0.3);
    u1.bright(0.3, 1.5);
    local v676 = ReplicatedStorage.Resources.isagi.popup:Clone();
    v676.CFrame = v673.CFrame * CFrame.new(0.5, -3, 0.3);
    v676.Parent = workspace.Effects;

    for _, descendant in ipairs(v676:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(2, v676.Destroy, v676);
    task.wait(0.4);
    local v677 = ReplicatedStorage.Resources.isagi.PE:Clone();
    v677:PivotTo(v673.CFrame * CFrame.new(0.5, -3, 0.3));
    v677.Parent = workspace.Effects;

    for _, descendant in ipairs(v677.PE:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(2, v677.Destroy, v677);
    local v678 = ReplicatedStorage.Resources.isagi.PE2:Clone();
    v678.CFrame = v673.CFrame * CFrame.new(0.5, -3, 0.3);
    v678.Parent = workspace.Effects;
    task.delay(1, function() -- Line: 8423
        -- upvalues: ReplicatedStorage (ref)
        local v679 = ReplicatedStorage.Resources.isagi.bg:Clone();
        v679:PivotTo(workspace.CurrentCamera.CFrame * CFrame.new(0, 15, -15));
        v679.Parent = workspace.Effects;
        task.delay(1, v679.Destroy, v679);
    end);
    task.wait(2);

    for _, descendant in ipairs(v678:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(2, v678.Destroy, v678);
    TweenService:Create(Lighting.Atmosphere, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Density = 0.929,
        Haze = 4.55,
        Color = Color3.fromRGB(0, 0, 0)
    }):Play();
    local v680 = ReplicatedStorage.Resources.isagi.line:Clone();
    v680.CFrame = CFrame.new(v673.Position) * CFrame.new(0, -0.7, 0);
    v680.Parent = workspace.Effects;
    task.delay(0.3, v680.Destroy, v680);
    task.wait(1.8);
    TweenService:Create(Lighting.Atmosphere, TweenInfo.new(0.3), {
        Density = Density,
        Color = Color
    }):Play();
    u1.Emit(v673, ReplicatedStorage.Resources.isagi.im1, 3, CFrame.new(0.95, -0.15, -3));
    u1.bright(0.3, 1.5);
    task.wait(0.9);
    v674:Destroy();
    u1.sceneEnabled(false);
    u1.bigshockwave(v673);
end;

function u1.hitstopflash(p681, p682) -- Line: 8512
    -- upvalues: Lighting (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Brightness = p682;
    ColorCorrectionEffect.Saturation = -0.2;
    ColorCorrectionEffect.Contrast = 0.3;
    task.delay(p681, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
end;

mainreplication.hitstopflash = u1.hitstopflash;

function u1.bigshockwave(p683) -- Line: 8523
    -- upvalues: u1 (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy)
    u1.Emit(p683, ReplicatedStorage.Resources.PunchImpact2, 3);
    local v684 = ReplicatedStorage.Resources.Cylinder:Clone();
    v684.Parent = workspace.Effects;
    v684.CFrame = p683.CFrame;
    TweenService:Create(v684, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = Vector3.new(50, 50, 150),
        CFrame = v684.CFrame * CFrame.new(0, 0, -65) * CFrame.Angles(0, 0, -3.141592653589793)
    }):Play();
    Debris:AddItem(v684, 1);
end;

mainreplication.bigshockwave = u1.bigshockwave;

function u1.lorenzodefensecatch(p685) -- Line: 8539
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), u1 (copy), Lighting (copy), TweenService (copy), soundUtil (copy), SoundService (copy), RunService (copy), workspace_CurrentCamera (copy)
    local v686 = p685.HumanoidRootPart or p685.PrimaryPart;
    local Ball = p685:FindFirstChild("Ball");
    local _ = p685.Torso;
    local u687 = ReplicatedStorage.Resources.donlorenzo.ult4vfx:Clone();
    u687.rootlocation.Weld.Part0 = v686;
    u687:PivotTo(v686.CFrame);
    u687.Parent = p685;

    if Util.canshiftcolor(LocalPlayer, p685) then
        vfxUtil.LeanTowardsColor(u687, p685:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p685:GetAttribute("CustomAlpha") or 0.985);
    end;

    u1.sceneEnabled(true);
    local v688 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v688.Parent = Lighting;
    v688.FarIntensity = 0;
    TweenService:Create(v688, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.donlorenzo.ult4, SoundService);
    u1.cutsceneBlender(v686, ReplicatedStorage.Resources.donlorenzo.Skill4Cam, ReplicatedStorage.Resources.donlorenzo.FOV);
    local v689 = ReplicatedStorage.Resources.donlorenzo.ult4ball:Clone();
    v689.Weld.Part0 = Ball;
    v689.Parent = p685;
    task.delay(0.025, function() -- Line: 8573
        -- upvalues: u687 (copy)
        for _, child in ipairs(u687.skill4ballpartflashsteps:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;
    end);
    local u690 = ReplicatedStorage.Resources.donlorenzo.lorenzocam:Clone();
    u690.Parent = u687;
    local u691 = nil;
    u691 = RunService.PreRender:connect(function() -- Line: 8585
        -- upvalues: u690 (copy), u691 (ref), workspace_CurrentCamera (ref)
        if not u690:IsDescendantOf(game) then
            u691:Disconnect();
        end;

        u690.CFrame = workspace_CurrentCamera.CFrame;
    end);
    task.delay(0.2, function() -- Line: 8593
        -- upvalues: u687 (copy)
        for _, descendant in ipairs(u687.skill4emit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);

    for _, descendant in ipairs(p685:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v692 = descendant;

            for _, child in ipairs(ReplicatedStorage.Resources.donlorenzo.ult4aura:GetChildren()) do
                local u693 = child:Clone();
                u693.Parent = v692;
                task.delay(2, function() -- Line: 8607
                    -- upvalues: u693 (copy)
                    u693.Enabled = false;
                    task.delay(3, u693.Destroy, u693);
                end);
            end;
        end;
    end;

    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
    BodyPosition.D = 300;
    BodyPosition.Parent = v686;
    BodyPosition.Position = v686.Position;
    task.wait(2);
    u687:Destroy();
    v689:Destroy();
    u690:Destroy();
    BodyPosition:Destroy();
    v688:Destroy();
    u1.sceneEnabled(false);
end;

function u1.bodyPosition(u694: userdata, u695: any, p696: number, p697: table, p698: table?, p699: number?, p700: number?, p701: vector?) -- Line: 8638
    -- upvalues: TweenService (copy), RunService (copy)
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = p699 or 12500;
    BodyPosition.D = p700 or 300;
    BodyPosition.MaxForce = p701 or Vector3.new(30000, 0, 30000);
    BodyPosition.Parent = u694;
    TweenService:Create(BodyPosition, TweenInfo.new(table.unpack(p697)), p698 or {
        P = 5000,
        D = 600
    }):Play();
    local u702 = typeof(u695) == "Vector3";
    local v704 = RunService.PreRender:Connect(function() -- Line: 8655
        -- upvalues: u694 (copy), u702 (copy), u695 (copy), BodyPosition (copy)
        local CFrame2 = u694.CFrame;

        if not u702 then
            BodyPosition.Position = CFrame2.LookVector * u695 + u694.Position;

            return;
        end;

        local v703 = u695;
        BodyPosition.Position = u694.Position + CFrame2.RightVector * v703.X + CFrame2.UpVector * v703.Y + CFrame2.LookVector * v703.Z;
    end);
    task.delay(p696, v704.Disconnect, v704);
    task.delay(p696, BodyPosition.Destroy, BodyPosition);

    return BodyPosition;
end;

local function makeweld(p705, p706, p707, p708) -- Line: 8671
    local Weld = Instance.new("Weld");
    Weld.Parent = p705;
    Weld.Part0 = p706;
    Weld.Part1 = p707;

    if p708 then
        Weld.C0 = p708;
    end;
end;

function u1.andrewcatch(p709) -- Line: 8682
    -- upvalues: ReplicatedStorage (copy), u1 (copy), Lighting (copy), TweenService (copy), soundUtil (copy), SoundService (copy), mainreplication (copy)
    local Resources = ReplicatedStorage.Resources;
    local v710 = p709.HumanoidRootPart or p709.PrimaryPart;
    p709:FindFirstChild("Ball");
    local _ = p709.Torso;
    u1.sceneEnabled(true);
    local v711 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v711.Parent = Lighting;
    v711.FarIntensity = 0;
    TweenService:Create(v711, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.screech, SoundService);
    mainreplication.cutscene(v710, CFrame.new(Vector3.new(0, 0, 0)), 1.36, Resources.FOVSUSSSS);
    task.wait(1.36);
    v711:Destroy();
    u1.sceneEnabled(false);
end;

function u1.andrewthrow(p712) -- Line: 8707
    -- upvalues: ReplicatedStorage (copy), u1 (copy), Lighting (copy), TweenService (copy), soundUtil (copy), SoundService (copy), mainreplication (copy)
    local Resources = ReplicatedStorage.Resources;
    local v713 = p712.HumanoidRootPart or p712.PrimaryPart;
    p712:FindFirstChild("Ball");
    local _ = p712.Torso;
    u1.sceneEnabled(true);
    local v714 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v714.Parent = Lighting;
    v714.FarIntensity = 0;
    TweenService:Create(v714, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.DIRECTTHROW, SoundService);
    mainreplication.cutscene(v713, CFrame.new(Vector3.new(0, 0, 0)), 0.38, Resources.UPSIDEDOWNFOVSUSSSS);
    task.wait(0.38);
    v714:Destroy();
    u1.sceneEnabled(false);
end;

function u1.AndrewFlow(u715, p716) -- Line: 8732
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy)
    local v717 = u715.HumanoidRootPart or u715.PrimaryPart;
    local Resources = ReplicatedStorage.Resources;
    mainreplication.sceneEnabled(true);
    mainreplication.cutscene(v717, CFrame.new(Vector3.new(0, 0, 0)), 3, Resources.susFOV);
    task.delay(2.867, function() -- Line: 8740
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    soundUtil:play(ReplicatedStorage.Resources.LIMBUS, SoundService);
    TekrinnDialogue.Speak(u715, {
        {
            Text = "LIMBUS.........",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.08,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 10,
                Lifetime = 1
            }
        }
    }, 1);
    task.delay(1.5, function() -- Line: 8770
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), TekrinnDialogue (ref), u715 (copy)
        soundUtil:play(ReplicatedStorage.Resources.COMPANY, SoundService);
        TekrinnDialogue.Speak(u715, {
            {
                Text = "COMPANY!!!!!!!!!!!!!!!!!!!!!!!!!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 10,
                    Lifetime = 1
                }
            }
        }, 2.867);
    end);
end;

local function addArmDrip(p718, p719) -- Line: 8799
    -- upvalues: ReplicatedStorage (copy)
    local v720 = ReplicatedStorage.Resources.armdrip:Clone();
    v720.Parent = p718;
    v720.Weld.Part0 = p718[`{p719 and "Left" or "Right"} Leg`];

    return v720;
end;

function u1.fakevolley(u721, u722) -- Line: 8808
    -- upvalues: ReplicatedStorage (copy)
    if not u721.HumanoidRootPart then
        local _ = u721.PrimaryPart;
    end;

    local _ = u721.Torso;
    local u723 = ReplicatedStorage.Resources.armdrip:Clone();
    u723.Parent = u721;
    u723.Weld.Part0 = u721[`{u722 and "Left" or "Right"} Leg`];
    local u724 = nil;
    u724 = u721.ChildAdded:Connect(function() -- Line: 8817
        -- upvalues: u723 (ref), u721 (copy), u722 (copy), ReplicatedStorage (ref), u724 (ref)
        if not u723 then
            local v725 = u721;
            local v726 = ReplicatedStorage.Resources.armdrip:Clone();
            v726.Parent = v725;
            v726.Weld.Part0 = v725[`{u722 and "Left" or "Right"} Leg`];
            u723 = v726;

            if u723 then
                u724:Disconnect();
            end;
        end;
    end);
    task.delay(0.5, function() -- Line: 8826
        -- upvalues: u724 (ref), u723 (ref)
        u724:Disconnect();

        if u723 then
            for _, descendant in ipairs(u723:GetDescendants()) do
                if descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2, u723.Destroy, u723);
        end;
    end);
end;

function u1.fakevolleyhit(p727, p728) -- Line: 8839
    -- upvalues: u1 (copy), ReplicatedStorage (copy), actionUtil (copy)
    local v729 = p727.HumanoidRootPart or p727.PrimaryPart;

    if not p728 then
        u1.raycastEffect(v729, ReplicatedStorage.Resources.jumpsmoke, 3);
        u1.Emit(v729, ReplicatedStorage.Resources.headball, 3, CFrame.new(0, 0, -2));
    end;

    if actionUtil.simulatesCharacter(p727) then
        u1.cameraShake(15, 0.7, 4);
        u1.fov(false, 90);
        u1.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;
end;

function u1.windupHeavynagi(p730) -- Line: 8853
end;

function u1.resetRecord() -- Line: 8881
end;

function u1.deathcounteraura(u731) -- Line: 8890
    -- upvalues: Lighting (copy), TweenService (copy), ReplicatedStorage (copy), u1 (copy), soundUtil (copy), SoundService (copy)
    if not u731.HumanoidRootPart then
        local _ = u731.PrimaryPart;
    end;

    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 11;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v732 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v732.Parent = Lighting;
    v732.TintColor = Color3.fromRGB(255, 0, 4);
    v732.Brightness = 0.4;
    v732.Contrast = 1;
    v732.Saturation = -0.4;
    TweenService:Create(v732, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v732, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v732.Destroy, v732);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 2, 6);
    local u733 = {};

    for _, child in ipairs(u731:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v734 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.rin.deathcounterAura:GetChildren()) do
                local v735 = child2:Clone();
                v735.Parent = v734;
                table.insert(u733, v735);
            end;
        end;
    end;

    soundUtil:play(ReplicatedStorage.Resources.dcsound, SoundService);
    local u736 = nil;
    u736 = u731:GetAttributeChangedSignal("deathCounter"):connect(function() -- Line: 8941
        -- upvalues: u731 (copy), u736 (ref), u733 (copy)
        if u731:GetAttribute("deathCounter") then
            return;
        end;

        if u736 then
            u736:Disconnect();
        end;

        for _, v in u733 do
            v:Destroy();
        end;

        table.clear(u733);
    end);
end;

function u1.saecounteraura(u737) -- Line: 8957
    -- upvalues: Lighting (copy), TweenService (copy), ReplicatedStorage (copy), u1 (copy), soundUtil (copy), SoundService (copy)
    if not u737.HumanoidRootPart then
        local _ = u737.PrimaryPart;
    end;

    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 11;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v738 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v738.Parent = Lighting;
    v738.TintColor = Color3.fromRGB(255, 0, 153);
    v738.Brightness = 0.4;
    v738.Contrast = 1;
    v738.Saturation = -0.4;
    TweenService:Create(v738, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v738, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v738.Destroy, v738);
    u1.fov(false, 100);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.cameraShake(10, 2, 6);
    local u739 = {};

    for _, child in ipairs(u737:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v740 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.sae.ReflexAura:GetChildren()) do
                local v741 = child2:Clone();
                v741.Parent = v740;
                table.insert(u739, v741);
            end;
        end;
    end;

    for _, child in ipairs(ReplicatedStorage.Resources.sae.Aura:GetChildren()) do
        local v742 = child:Clone();
        local Position = v742.Position;
        v742.Parent = u737.HumanoidRootPart;
        v742.Position = Vector3.new(0, 0, 0);
        TweenService:Create(v742, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = Position
        }):Play();

        for _, descendant in pairs(v742:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        table.insert(u739, v742);
    end;

    soundUtil:play(ReplicatedStorage.Resources.sae.ReflexAuraStart, SoundService);
    local u743 = nil;
    u743 = u737:GetAttributeChangedSignal("deathCounter"):connect(function() -- Line: 9027
        -- upvalues: u737 (copy), u743 (ref), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u739 (copy)
        if u737:GetAttribute("deathCounter") then
            return;
        end;

        if u743 then
            u743:Disconnect();
        end;

        soundUtil:play(ReplicatedStorage.Resources.sae.AuraFinish, SoundService);
        local v744 = ReplicatedStorage.Resources.sae.End:Clone();
        v744.Parent = u737.HumanoidRootPart;

        for _, descendant in pairs(v744:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        game:GetService("Debris"):AddItem(v744, 10);

        for _, v in u739 do
            v:Destroy();
        end;

        table.clear(u739);
    end);
end;

function u1.saescreeneffectmanihatethesetesters() -- Line: 9055
    -- upvalues: Lighting (copy), TweenService (copy), ReplicatedStorage (copy), u1 (copy)
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 11;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v745 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v745.Parent = Lighting;
    v745.TintColor = Color3.fromRGB(255, 0, 153);
    v745.Brightness = 0.4;
    v745.Contrast = 1;
    v745.Saturation = -0.4;
    TweenService:Create(v745, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v745, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v745.Destroy, v745);
    u1.cameraShake(10, 2, 6);
end;

function u1.zantetsuscreeneffectmanihatethesetesters() -- Line: 9087
    -- upvalues: Lighting (copy), TweenService (copy), ReplicatedStorage (copy), u1 (copy)
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 11;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.533, BlurEffect.Destroy, BlurEffect);
    local v746 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v746.Parent = Lighting;
    v746.TintColor = Color3.fromRGB(35, 35, 35);
    v746.Brightness = 0.4;
    v746.Contrast = 1;
    v746.Saturation = -0.4;
    TweenService:Create(v746, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Saturation = 0
    }):Play();
    TweenService:Create(v746, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v746.Destroy, v746);
    u1.cameraShake(10, 2, 6);
end;

function u1.vipseat(u747, u748) -- Line: 9119
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy)
    local v749 = u747.HumanoidRootPart or u747.PrimaryPart;
    u747:FindFirstChild("Ball");
    local _ = u747.Torso;
    local _ = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    local u750 = ReplicatedStorage.Resources.rin.rinvipseateff:Clone();
    u750:PivotTo(v749.CFrame);
    u750.Parent = u747;

    if Util.canshiftcolor(LocalPlayer, u747) then
        vfxUtil.LeanTowardsColor(u750, u747:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u747:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u750:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u751 = ReplicatedStorage.Resources.Blur:Clone();
    u751.Size = 0;
    u751.Parent = Lighting;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    local v752 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v752.Parent = Lighting;
    v752.FarIntensity = 0;
    TweenService:Create(v752, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local Attribute = u747:GetAttribute("RinNoPlay");
    local v753;

    if Attribute then
        v753 = soundUtil:play(ReplicatedStorage.Resources.rin.vipseatdub_2, SoundService, {
            Character = u747
        });
    else
        v753 = soundUtil:play(ReplicatedStorage.Resources.rin.vipseat_2, SoundService, {
            Character = u747
        });
    end;

    u1.cutscene(v749, nil, 9.917, ReplicatedStorage.Resources.rin.vipseatFOV);
    task.delay(0.883, function() -- Line: 9168
        -- upvalues: u751 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        u751.Size = 24;
        TweenService:Create(u751, TweenInfo.new(0.767, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        ColorCorrectionEffect.Brightness = 0.4;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.267, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(0.95, function() -- Line: 9179
        -- upvalues: u750 (copy)
        for _, descendant in pairs(u750.slap:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.667, function() -- Line: 9188
        -- upvalues: u750 (copy)
        for _, descendant in pairs(u750.stap:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.667, function() -- Line: 9197
        -- upvalues: u751 (copy), TweenService (ref)
        u751.Size = 23;
        TweenService:Create(u751, TweenInfo.new(0.366, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);
    local u754 = {};
    task.delay(5.683, function() -- Line: 9204
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.Saturation = -1;

        for i = 1, 5 do
            ColorCorrectionEffect.Contrast = ColorCorrectionEffect.Contrast == 15 and -15 or 15;
            task.wait(0.017);
            local _ = i;
        end;

        local v755 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.117, Enum.EasingStyle.Linear), {
            Brightness = 0.498,
            Contrast = 0.412,
            Saturation = -0.704,
            TintColor = Color3.fromRGB(255, 215, 215)
        });
        v755:Play();
        v755.Completed:Wait();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 210, 210);
        ColorCorrectionEffect.Brightness = -1;
        ColorCorrectionEffect.Contrast = 0.471;
        ColorCorrectionEffect.Saturation = -0.683;
        local v756 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 1,
            Saturation = -0.5,
            TintColor = Color3.fromRGB(255, 160, 160)
        });
        v756:Play();
        v756.Completed:Wait();
        local v757 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.384, Enum.EasingStyle.Linear), {
            Brightness = -0.408,
            Contrast = 0.796,
            Saturation = -0.126,
            TintColor = Color3.fromRGB(255, 175, 175)
        });
        v757:Play();
        v757.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.866, Enum.EasingStyle.Linear), {
            Brightness = -1,
            Contrast = 0.1,
            Saturation = 0.05,
            TintColor = Color3.fromRGB(255, 175, 175)
        }):Play();
    end);
    local u758 = nil;
    task.delay(5.683, function() -- Line: 9255
        -- upvalues: u758 (ref), ReplicatedStorage (ref), u747 (copy), u750 (copy)
        u758 = ReplicatedStorage.Resources.rin.rineyeya:Clone();
        u758.Weld.Part0 = u747.Head;
        u758.Parent = u750;

        for _, descendant in ipairs(u750.rinawkbg:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.883, function() -- Line: 9267
        -- upvalues: u750 (copy), u747 (copy), ReplicatedStorage (ref), u754 (copy)
        for _, descendant in pairs(u750.aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, child in ipairs(u747:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v759 = child;

                for _, child2 in ipairs(ReplicatedStorage.Resources.rin.vipseataura:GetChildren()) do
                    local v760 = child2:Clone();
                    v760.Parent = v759;
                    table.insert(u754, v760);
                end;
            end;
        end;
    end);
    task.delay(7.55, function() -- Line: 9287
        -- upvalues: u751 (copy), TweenService (ref)
        u751.Size = 11;
        TweenService:Create(u751, TweenInfo.new(0.733, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);
    task.delay(8.4, function() -- Line: 9292
        -- upvalues: u758 (ref), u750 (copy), u754 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        u758:Destroy();
        u750.rinawkbg:Destroy();
        u750.aura:Destroy();

        for _, v in u754 do
            v:Destroy();
        end;

        table.clear(u754);

        for _, descendant in pairs(u750.lastimpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        ColorCorrectionEffect.Saturation = -1;
        ColorCorrectionEffect.Brightness = 0;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);

        for i = 1, 5 do
            ColorCorrectionEffect.Contrast = ColorCorrectionEffect.Contrast == 15 and -15 or 15;
            ColorCorrectionEffect.Brightness = ColorCorrectionEffect.Brightness == 1 and -1 or 1;
            task.wait(0.017);
            local _ = i;
        end;

        ColorCorrectionEffect.Saturation = 0;
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(8.3, function() -- Line: 9331
        -- upvalues: u751 (copy), TweenService (ref)
        u751.Size = 56;
        TweenService:Create(u751, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);

    if v753.Name == "Dub" then
        TekrinnDialogue.Speak(u747, {
            {
                Text = "Stop trying to limit my potential...",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 4
                }
            }
        }, 4);
        task.delay(3.07, function() -- Line: 9376
            -- upvalues: u748 (copy), TekrinnDialogue (ref), u747 (copy)
            local v761 = {
                {
                    Text = "Get away from me, ",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                },
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = u748.Name,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            };
            local table_clone_ret = table.clone(v761[1]);
            table_clone_ret.Text = "...";
            table.insert(v761, table_clone_ret);
            TekrinnDialogue.Speak(u747, v761, 2);
        end);
        task.delay(4.463, function() -- Line: 9427
            -- upvalues: TekrinnDialogue (ref), u747 (copy)
            TekrinnDialogue.Speak(u747, {
                {
                    Text = "YOU PARASITE!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(5.876, function() -- Line: 9452
            -- upvalues: TekrinnDialogue (ref), u747 (copy)
            TekrinnDialogue.Speak(u747, {
                {
                    Text = "Destroy...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(7.231, function() -- Line: 9477
            -- upvalues: TekrinnDialogue (ref), u747 (copy)
            TekrinnDialogue.Speak(u747, {
                {
                    Text = "Kill!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            }, 0.952);
        end);
    else
        TekrinnDialogue.Speak(u747, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Text = Attribute and "Stop trying to limit my potential..." or "Don\'t leash my potential!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 4
                }
            }
        }, 4);
        task.delay(3.15, function() -- Line: 9527
            -- upvalues: Attribute (copy), u748 (copy), TekrinnDialogue (ref), u747 (copy)
            local v762 = {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Text = Attribute and "Get away from me " or "Stop clinging to me, ",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                },
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = u748.Name,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            };

            if Attribute then
                local table_clone_ret = table.clone(v762[1]);
                table_clone_ret.Text = "...";
                table.insert(v762, table_clone_ret);
            else
                v762[2].Text = v762[2].Text .. "!";
            end;

            TekrinnDialogue.Speak(u747, v762, 2);
        end);

        if Attribute then
            task.delay(4.443, function() -- Line: 9583
                -- upvalues: TekrinnDialogue (ref), u747 (copy)
                TekrinnDialogue.Speak(u747, {
                    {
                        Text = "YOU PARASITE!",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.01,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = true,
                            Intensity = 5,
                            Lifetime = 2
                        }
                    }
                }, 2);
            end);
            task.delay(6.099, function() -- Line: 9608
                -- upvalues: TekrinnDialogue (ref), u747 (copy)
                TekrinnDialogue.Speak(u747, {
                    {
                        Text = "Destroy...",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.01,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = true,
                            Intensity = 5,
                            Lifetime = 2
                        }
                    }
                }, 2);
            end);
            task.delay(7.487, function() -- Line: 9633
                -- upvalues: TekrinnDialogue (ref), u747 (copy)
                TekrinnDialogue.Speak(u747, {
                    {
                        Text = "KILL!",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.01,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = true,
                            Intensity = 5,
                            Lifetime = 2
                        }
                    }
                }, 0.952);
            end);
        end;
    end;

    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.wait(9.917);
    ScreenDimmer:Destroy();
    u751:Destroy();
    u750:Destroy();
    ColorCorrectionEffect:Destroy();
    v752:Destroy();
    u1.sceneEnabled(false);
    u1.ultFlash(nil, 1.5);
    u1.fov(false, 15);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.bigbangdrive(u763) -- Line: 9685
    -- upvalues: Lighting (copy), vfxUtil (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy)
    local v764 = u763.HumanoidRootPart or u763.PrimaryPart;
    local Ball = u763:FindFirstChild("Ball");
    local _ = u763.Torso;
    local _ = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    u1.sceneEnabled(true);
    local u765 = ReplicatedStorage.Resources.shidou.NEWBIGBANGDRIVE:Clone();
    u765:PivotTo(v764.CFrame);
    u765.Parent = u763;

    if Util.canshiftcolor(LocalPlayer, u763) then
        vfxUtil.LeanTowardsColor(u765, u763:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u763:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u765:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local v766 = Util.Preload({ ReplicatedStorage.Resources.shidou.ImpactFrame1, ReplicatedStorage.Resources.shidou.ImpactFrame2, ReplicatedStorage.Resources.shidou.ImpactFrame3 });
    local u767 = ReplicatedStorage.Resources.Blur:Clone();
    u767.Size = 0;
    u767.Parent = Lighting;
    local u768 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    TweenService:Create(u768, TweenInfo.new(0.417, Enum.EasingStyle.Linear), {
        Brightness = 0,
        Contrast = 0.3,
        Saturation = -0.2,
        TintColor = Color3.fromRGB(207, 218, 255)
    }):Play();
    u768.Parent = Lighting;
    local v769 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v769.Parent = Lighting;
    v769.FarIntensity = 0;
    TweenService:Create(v769, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local Attribute = u763:GetAttribute("femlock");
    local u770 = Attribute or soundUtil:play(Attribute and ReplicatedStorage.Resources.shidou.Femvoicelines.BBD or ReplicatedStorage.Resources.shidou.BigBangDrive.SFX, SoundService, {
        Character = u763
    }).Name == "Dub";
    u1.cutsceneBlender(v764, ReplicatedStorage.Resources.shidou.skill32, ReplicatedStorage.Resources.shidou.FOV);

    for _, descendant in ipairs(u765.help:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(0.733, function() -- Line: 9758
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "My soccer cells...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 2.5);
    end);
    task.delay(6.267, function() -- Line: 9785
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "are tingling and stirring to spark.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 5);
    end);
    task.delay(10.217, function() -- Line: 9812
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "With my goal...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 46, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = " With my genes...",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 3);
    end);
    task.delay(13.995, function() -- Line: 9861
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "BIG BANG DRIVE!!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    task.delay(18.583, function() -- Line: 9888
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "ILL BEAT YOU UP!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1.15
                }
            }
        }, 1.15);
    end);
    task.delay(0.85, function() -- Line: 9915
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if not u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "I feel it in my soccer cells...",
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 2.5);
    end);
    task.delay(6, function() -- Line: 9937
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if not u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "All of them are tingling.. ",
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            },
            {
                Text = "telling me to explode!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 2.9);
    end);
    task.delay(10.11, function() -- Line: 9978
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if not u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "With my goals.. ",
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) })
            },
            {
                Text = "and my genes...",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 3);
    end);
    task.delay(14.07, function() -- Line: 10013
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if not u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "MY BIG BANG DRIVE!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3);
    end);
    task.delay(18.09, function() -- Line: 10038
        -- upvalues: u770 (copy), TekrinnDialogue (ref), u763 (copy)
        if not u770 then
            return;
        end;

        TekrinnDialogue.Speak(u763, {
            {
                Text = "BOOM BABY!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1
                }
            }
        }, 3.5);
    end);
    task.delay(0.633, function() -- Line: 10065
        -- upvalues: u1 (ref), u763 (copy), ReplicatedStorage (ref)
        u1.Emit(u763.Head, ReplicatedStorage.Resources.shidou.EYE2, 3);
    end);
    task.delay(0.983, function() -- Line: 10069
        -- upvalues: u765 (copy)
        for _, descendant in ipairs(u765.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.717, function() -- Line: 10077
        -- upvalues: u765 (copy)
        for _, descendant in ipairs(u765.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.05, function() -- Line: 10085
        -- upvalues: u765 (copy)
        for _, descendant in ipairs(u765.help:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.667, function() -- Line: 10093
        -- upvalues: u765 (copy)
        for _, descendant in ipairs(u765.Jumpshidou:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u765.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.933, function() -- Line: 10107
        -- upvalues: u765 (copy)
        for _, descendant in ipairs(u765.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.2, function() -- Line: 10115
        -- upvalues: u765 (copy)
        for _, descendant in ipairs(u765.charge:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.417, function() -- Line: 10123
        -- upvalues: u765 (copy)
        for _, descendant in pairs(u765.bigbang1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.5, function() -- Line: 10132
        -- upvalues: u765 (copy)
        for _, descendant in pairs(u765.bigbang1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.567, function() -- Line: 10141
        -- upvalues: u768 (copy), TweenService (ref)
        u768.Brightness = -0.7;
        u768.Contrast = 1;
        u768.Saturation = 0;
        task.wait(0.016);
        u768.Brightness = 0;
        u768.Contrast = 0;
        u768.Saturation = 0;
        task.wait(0.016);
        u768.Brightness = -50;
        u768.Contrast = -200;
        u768.Saturation = -1;
        task.wait(0.016);
        u768.Brightness = 0;
        u768.Contrast = -200;
        u768.Saturation = -1;
        task.wait(0.016);
        u768.Brightness = 0;
        u768.Contrast = 200;
        u768.Saturation = -1;
        task.wait(0.016);
        u768.Brightness = 100;
        u768.Contrast = 500;
        u768.Saturation = -1;
        task.wait(0.016);
        u768.Brightness = 0;
        u768.Contrast = 200;
        u768.Saturation = -1;
        task.wait(0.016);
        u768.Brightness = -50;
        u768.Contrast = -200;
        u768.Saturation = -1;
        task.wait(0.016);
        u768.Brightness = 1;
        u768.Contrast = 20;
        u768.Saturation = -1;
        task.wait(0.016);
        u768.Brightness = 0.3;
        u768.Contrast = 10;
        u768.Saturation = -1;
        task.wait(0.016);
        u768.Brightness = -0.2;
        u768.Contrast = 0.3;
        u768.Saturation = 0.6;
        TweenService:Create(u768, TweenInfo.new(0.417, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 0.3,
            Saturation = -0.2,
            TintColor = Color3.fromRGB(207, 218, 255)
        }):Play();
    end);
    task.delay(4.6, function() -- Line: 10215
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.shidou.ImpactFrame1, 30);
    end);
    local u771 = nil;
    task.delay(4.667, function() -- Line: 10220
        -- upvalues: u771 (ref), ReplicatedStorage (ref), u763 (copy), u765 (copy)
        u771 = ReplicatedStorage.Resources.shidou.wingyaya:Clone();
        u771.Weld.Part0 = u763.Torso;
        u771.Parent = u765;

        for _, descendant in pairs(u765.helpemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(u765.charge:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u765.help:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u765.helpemit1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.9, function() -- Line: 10255
        -- upvalues: u765 (copy)
        for _, descendant in pairs(u765.helpemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.1;
            end;
        end;
    end);
    task.delay(10.517, function() -- Line: 10264
        -- upvalues: u765 (copy)
        for _, descendant in pairs(u765.help:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u765.helpemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(10.533, function() -- Line: 10280
        -- upvalues: u771 (ref), u767 (copy), u768 (copy), TweenService (ref)
        if u771 then
            u771:Destroy();
        end;

        u767.Size = 10;
        u768.TintColor = Color3.fromRGB(255, 195, 209);
        u768.Brightness = -0.2;
        u768.Contrast = 1;
        u768.Saturation = -1;
        TweenService:Create(u767, TweenInfo.new(1.234, Enum.EasingStyle.Linear), {
            Size = 25
        }):Play();
        task.delay(1.234, function() -- Line: 10294
            -- upvalues: TweenService (ref), u767 (ref)
            TweenService:Create(u767, TweenInfo.new(0.75, Enum.EasingStyle.Linear), {
                Size = 0
            }):Play();
        end);
        TweenService:Create(u768, TweenInfo.new(1.117, Enum.EasingStyle.Linear), {
            Saturation = -0.8,
            TintColor = Color3.fromRGB(255, 105, 105)
        }):Play();
        task.wait(1.117);
        TweenService:Create(u768, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Contrast = 0.7,
            TintColor = Color3.fromRGB(255, 71, 71)
        }):Play();
        TweenService:Create(u768, TweenInfo.new(0.233, Enum.EasingStyle.Linear), {
            Brightness = 1
        }):Play();
        task.wait(0.233);
        TweenService:Create(u768, TweenInfo.new(0.167, Enum.EasingStyle.Linear), {
            Brightness = 0.4
        }):Play();
    end);
    local u772 = nil;
    task.delay(11.6, function() -- Line: 10322
        -- upvalues: u772 (ref), ReplicatedStorage (ref), u763 (copy), u765 (copy)
        u772 = ReplicatedStorage.Resources.shidou.eye2:Clone();
        u772.Weld.Part0 = u763.Head;
        u772.Parent = u765;

        for _, descendant in ipairs(u765.Blackhole:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(12.967, function() -- Line: 10334
        -- upvalues: u772 (ref), u768 (copy), u765 (copy)
        if u772 then
            u772:Destroy();
        end;

        u768.TintColor = Color3.fromRGB(177, 201, 255);
        u768.Brightness = 0;
        u768.Contrast = 0.3;
        u768.Saturation = -0.4;

        for _, descendant in ipairs(u765.Blackhole:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u765.AA2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(180);
            end;
        end;
    end);
    task.delay(15.85, function() -- Line: 10357
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.shidou.ImpactFrame2, 30);
    end);
    local u773 = {};
    task.delay(16.65, function() -- Line: 10363
        -- upvalues: u763 (copy), ReplicatedStorage (ref), u773 (copy), u768 (copy)
        for _, child in ipairs(u763:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v774 = child;

                for _, child2 in ipairs(ReplicatedStorage.Resources.shidou.lineya:GetChildren()) do
                    local v775 = child2:Clone();
                    v775.Parent = v774;
                    table.insert(u773, v775);
                end;
            end;
        end;

        u768.TintColor = Color3.fromRGB(255, 255, 255);
        u768.Brightness = 0;
        u768.Contrast = 0;
        u768.Saturation = 0;
    end);
    task.delay(17.05, function() -- Line: 10381
        -- upvalues: Util (ref), ReplicatedStorage (ref), Ball (copy), u765 (copy), u768 (copy), TweenService (ref)
        Util.Gif(ReplicatedStorage.Resources.shidou.ImpactFrame3, 30);

        if Ball then
            local v776 = ReplicatedStorage.Resources.shidou.ballspin:Clone();
            v776.Weld.Part0 = Ball;
            v776.Parent = u765;
            task.delay(0.8, v776.Destroy, v776);
        end;

        for _, descendant in ipairs(u765.WIND:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u765.normalkick2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(10);
            end;
        end;

        u768.TintColor = Color3.fromRGB(255, 45, 203);
        u768.Brightness = 5;
        u768.Contrast = 6;
        u768.Saturation = -0.4;
        TweenService:Create(u768, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    task.delay(17.85, function() -- Line: 10412
        -- upvalues: u773 (copy), u765 (copy), u768 (copy)
        for _, v in u773 do
            v:Destroy();
        end;

        table.clear(u773);
        u765.WIND:Destroy();
        u765.normalkick2:Destroy();
        u765.AA2:Destroy();
        u768.TintColor = Color3.fromRGB(255, 255, 255);
        u768.Brightness = 0;
        u768.Contrast = 0;
        u768.Saturation = 0;
    end);
    task.delay(18.467, function() -- Line: 10428
        -- upvalues: u767 (copy), u768 (copy), TweenService (ref)
        u767.Size = 25;
        u768.TintColor = Color3.fromRGB(240, 35, 255);
        u768.Contrast = 255;
        task.wait(0.1);
        u768.Contrast = 25;
        task.wait(0.05);
        TweenService:Create(u768, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Contrast = -3
        }):Play();
        TweenService:Create(u767, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
            Size = 7
        }):Play();
        TweenService:Create(u768, TweenInfo.new(0.666, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 5,
            Saturation = -0.3,
            TintColor = Color3.fromRGB(255, 66, 132)
        }):Play();
    end);
    task.delay(18.683, function() -- Line: 10450
        -- upvalues: u765 (copy)
        for _, descendant in ipairs(u765.SCREAM:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.wait(19.85);
    ScreenDimmer:Destroy();
    v766:Destroy();
    u767:Destroy();
    u765:Destroy();
    u768:Destroy();
    v769:Destroy();
    u1.sceneEnabled(false);
    u1.ultFlash(nil, 1.5);
    u1.fov(false, 15);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.dragondrive(u777) -- Line: 10658
    -- upvalues: Lighting (copy), vfxUtil (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), RunService (copy), Color (copy), Density (copy), Brightness (copy)
    local v778 = u777.HumanoidRootPart or u777.PrimaryPart;
    local _ = u777.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local Ball = u777:FindFirstChild("Ball");
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    u1.bright(-1, 0.15);
    u1.sceneEnabled(true);
    local u779 = ReplicatedStorage.Resources.shidou.newddeffect:Clone();
    u779:PivotTo(v778.CFrame);
    u779.Parent = u777;

    if Util.canshiftcolor(LocalPlayer, u777) then
        vfxUtil.LeanTowardsColor(u779, u777:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u777:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v780 = ReplicatedStorage.Resources.shidou.eyesangle:Clone();
    v780.Weld.Part0 = u777.Head;
    v780.Parent = u779;
    local v781 = ReplicatedStorage.Resources.shidou.sh:Clone();
    v781.Weld.Part0 = u777.Head;
    v781.Parent = u779;
    local v782 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v782.Parent = Lighting;
    v782.FarIntensity = 0;
    TweenService:Create(v782, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();

    if Util.canshiftcolor(LocalPlayer, u777) then
        vfxUtil.LeanTowardsColor(u779, u777:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u777:GetAttribute("CustomAlpha") or 0.985);
    end;

    local Attribute = u777:GetAttribute("femlock");
    local u783 = Attribute or soundUtil:play(Attribute and ReplicatedStorage.Resources.shidou.Femvoicelines.dragondrive or ReplicatedStorage.Resources.shidou.ddsound, SoundService, {
        Character = u777
    }).Name == "Dub";
    u1.cutscene(v778, CFrame.new(Vector3.new(0, 0, 0)), 7.767, ReplicatedStorage.Resources.shidou.ddFOV);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 0;
    BlurEffect.Parent = Lighting;
    task.delay(1.74, function() -- Line: 10713
        -- upvalues: u783 (copy), TekrinnDialogue (ref), u777 (copy)
        if u783 then
            return;
        end;

        TekrinnDialogue.Speak(u777, {
            {
                Text = "Jump",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.015,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 0.5
                }
            },
            {
                Text = ", all the cells in my body.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 49, 138)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 4);
    end);
    task.delay(5.405, function() -- Line: 10761
        -- upvalues: u783 (copy), TekrinnDialogue (ref), u777 (copy)
        if u783 then
            return;
        end;

        TekrinnDialogue.Speak(u777, {
            {
                Text = "DRAGON DRIVE!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 53, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 2.2);
    end);
    task.delay(1.617, function() -- Line: 10788
        -- upvalues: u783 (copy), TekrinnDialogue (ref), u777 (copy)
        if not u783 then
            return;
        end;

        TekrinnDialogue.Speak(u777, {
            {
                Text = "Jump",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.015,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 0.5
                }
            },
            {
                Text = ", all the cells in my body.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 49, 138)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 2
                }
            }
        }, 3.5);
    end);
    task.delay(5.317, function() -- Line: 10836
        -- upvalues: u783 (copy), TekrinnDialogue (ref), u777 (copy)
        if not u783 then
            return;
        end;

        TekrinnDialogue.Speak(u777, {
            {
                Text = "DRAGON",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 53, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 1);
    end);
    task.delay(6.417, function() -- Line: 10863
        -- upvalues: u783 (copy), TekrinnDialogue (ref), u777 (copy)
        if not u783 then
            return;
        end;

        TekrinnDialogue.Speak(u777, {
            {
                Text = "DRIVE!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 53, 124)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 2.2);
    end);
    local u784 = ReplicatedStorage.Resources.shidou.CAMERAPARTstart:Clone();
    u784.Parent = u779;

    for _, descendant in ipairs(u784:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    local u785 = nil;
    u785 = RunService.PreRender:connect(function() -- Line: 10901
        -- upvalues: u784 (copy), u785 (ref)
        if u784:IsDescendantOf(game) then
            u784.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 0, -0.17453292519943295);

            return;
        end;

        u785:Disconnect();
    end);
    task.delay(0.05, function() -- Line: 10911
        -- upvalues: u779 (copy)
        for _, descendant in ipairs(u779.step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.867, function() -- Line: 10919
        -- upvalues: u779 (copy)
        for _, descendant in ipairs(u779.step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u779.step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.967, function() -- Line: 10934
        -- upvalues: u784 (copy)
        u784:Destroy();
    end);
    local u786 = nil;
    local u787 = nil;
    local u788 = {};
    task.delay(1.55, function() -- Line: 10943
        -- upvalues: u779 (copy), u777 (copy), ReplicatedStorage (ref), u788 (copy), BlurEffect (copy), Atmosphere (copy), Lighting (ref), ColorCorrectionEffect (copy), TweenService (ref), u787 (ref), u786 (ref), RunService (ref)
        for _, descendant in pairs(u779.cut:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, child in ipairs(u777:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v789 = ReplicatedStorage.Resources.shidou.lineaura:Clone();
                v789.Parent = child;
                table.insert(u788, v789);
            end;
        end;

        BlurEffect.Size = 25;
        Atmosphere.Color = Color3.fromRGB(108, 36, 69);
        Atmosphere.Density = 0.45;
        Lighting.Brightness = 3.5;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 143, 217);
        ColorCorrectionEffect.Brightness = 1;
        ColorCorrectionEffect.Contrast = 0.4;
        ColorCorrectionEffect.Saturation = -0.8;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.733, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Saturation = 0
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(0.633, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        u787 = ReplicatedStorage.Resources.shidou.ddwingyaya:Clone();
        u787.Weld.Part0 = u777.Torso;
        u787.Parent = u779;
        u786 = ReplicatedStorage.Resources.shidou.CAMERAPART:Clone();
        u786.Parent = u779;

        for _, descendant in ipairs(u786:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        local u790 = nil;
        u790 = RunService.PreRender:connect(function() -- Line: 10997
            -- upvalues: u786 (ref), u790 (ref)
            if u786:IsDescendantOf(game) then
                u786.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1.5) * CFrame.Angles(0, 0, -1.3962634015954636);

                return;
            end;

            u790:Disconnect();
        end);

        for _, descendant in ipairs(u779.bgAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    local u791 = nil;
    task.delay(4.983, function() -- Line: 11027
        -- upvalues: u791 (ref), ReplicatedStorage (ref), u777 (copy), u779 (copy)
        u791 = ReplicatedStorage.Resources.shidou.legline:Clone();
        u791.Weld.Part0 = u777["Right Leg"];
        u791.Parent = u779;
    end);
    local u792 = nil;
    local u793 = nil;
    task.delay(5.317, function() -- Line: 11037
        -- upvalues: u788 (copy), u786 (ref), BlurEffect (copy), ColorCorrectionEffect (copy), TweenService (ref), u787 (ref), u791 (ref), u793 (ref), ReplicatedStorage (ref), u777 (copy), u779 (copy), u792 (ref), RunService (ref), Ball (copy)
        for _, v in u788 do
            v:Destroy();
        end;

        table.clear(u788);
        u786:Destroy();
        BlurEffect.Size = 25;
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(BlurEffect, TweenInfo.new(0.266, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.583, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        u787:Destroy();
        u791:Destroy();
        u793 = ReplicatedStorage.Resources.shidou.kickline:Clone();
        u793.Weld.Part0 = u777["Right Leg"];
        u793.Parent = u779;
        u792 = ReplicatedStorage.Resources.shidou.CAMERAPARTkick:Clone();
        u792.Parent = u779;

        for _, descendant in ipairs(u792:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        local u794 = nil;
        u794 = RunService.PreRender:connect(function() -- Line: 11078
            -- upvalues: u792 (ref), u794 (ref)
            if u792:IsDescendantOf(game) then
                u792.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, -0.3, -0.5) * CFrame.Angles(0, 0, -0.7853981633974483);

                return;
            end;

            u794:Disconnect();
        end);

        if not Ball:IsDescendantOf(game) then
            return;
        end;

        local Attachment = Instance.new("Attachment");
        Attachment.Parent = Ball;

        for _, child in ipairs(u779.DONTBESLOW.Attachment:GetChildren()) do
            if child:IsA("Beam") then
                child.Attachment1 = Attachment;
                child.Enabled = true;
            end;
        end;
    end);
    task.delay(5.417, function() -- Line: 11103
        -- upvalues: u779 (copy)
        for _, descendant in pairs(u779.DONTBESLOW:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u795 = nil;
    task.delay(6.5, function() -- Line: 11114
        -- upvalues: u792 (ref), u793 (ref), u795 (ref), ReplicatedStorage (ref), u779 (copy), RunService (ref)
        u792:Destroy();

        if u793 then
            u793:Destroy();
        end;

        u795 = ReplicatedStorage.Resources.shidou.CAMERAPART:Clone();
        u795.Parent = u779;

        for _, descendant in ipairs(u795:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        local u796 = nil;
        u796 = RunService.PreRender:connect(function() -- Line: 11131
            -- upvalues: u795 (ref), u796 (ref)
            if u795:IsDescendantOf(game) then
                u795.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1.5) * CFrame.Angles(0, 0, -1.3962634015954636);

                return;
            end;

            u796:Disconnect();
        end);

        for _, child in ipairs(u779.DONTBESLOW.Attachment:GetChildren()) do
            if child:IsA("Beam") then
                child.Enabled = false;
            end;
        end;
    end);
    task.delay(6.7, function() -- Line: 11148
        -- upvalues: BlurEffect (copy), ColorCorrectionEffect (copy), TweenService (ref), u779 (copy)
        BlurEffect.Size = 25;
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(BlurEffect, TweenInfo.new(0.217, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.217, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();

        for _, descendant in pairs(u779.STOP:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(6.933, function() -- Line: 11163
        -- upvalues: u795 (ref)
        u795:Destroy();
    end);
    task.delay(7.133, function() -- Line: 11167
        -- upvalues: BlurEffect (copy), ColorCorrectionEffect (copy), TweenService (ref), u779 (copy)
        BlurEffect.Size = 25;
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(BlurEffect, TweenInfo.new(0.217, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.217, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();

        for _, descendant in pairs(u779.STOP2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.wait(7.767);
    ScreenDimmer:Destroy();
    BlurEffect:Destroy();
    Atmosphere.Color = Color;
    Atmosphere.Density = Density;
    Lighting.Brightness = Brightness;
    ColorCorrectionEffect:Destroy();
    v780:Destroy();
    v782:Destroy();
    u1.sceneEnabled(false);
    u779:Destroy();
    u1.ultFlash();
    u1.fov(false, 50);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.shidoushockwave(p797) -- Line: 11208
    -- upvalues: u1 (copy), ReplicatedStorage (copy), TweenService (copy)
    local v798 = p797.HumanoidRootPart or p797.PrimaryPart;
    u1.bigshockwave(v798);
    local v799 = ReplicatedStorage.Resources.shidou.dhEffects:Clone();
    v799.Parent = p797;
    v799:PivotTo(v798.CFrame * CFrame.new(0, 0, -25));
    v799.End.Mesh.Scale = Vector3.new(3.179, 0, 0);
    TweenService:Create(v799.End.Mesh, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Scale = Vector3.new(3.179, 1.072, 1.037)
    }):Play();
    TweenService:Create(v799.End.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    TweenService:Create(v799.End, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = v799.End.CFrame * CFrame.Angles(1.3962634015954636, 0, 0)
    }):Play();
    TweenService:Create(v799.End4, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(80, 0, 0)
    }):Play();
    TweenService:Create(v799.End3, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(50, 0, 0)
    }):Play();
    TweenService:Create(v799.End2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(80, 0, 0)
    }):Play();
    TweenService:Create(v799.Twirl, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(15.359, 50, 15.92),
        Transparency = 1,
        CFrame = v799.Twirl.CFrame * CFrame.Angles(0, -0.4174478504920037, 0)
    }):Play();
    task.delay(2, v799.Destroy, v799);
end;

function u1.TimeStop(p800) -- Line: 11270
    -- upvalues: ReplicatedStorage (copy), MeshEmitter (copy), workspace_CurrentCamera (copy), Debris (copy)
    local v801 = p800.HumanoidRootPart or p800.PrimaryPart;
    local u802 = ReplicatedStorage.Resources.izayoi.TimeStopVFX:Clone();
    u802.Time.HumanoidRootPart.Part1 = v801;
    u802.Parent = workspace.Effects;
    task.delay(7, function() -- Line: 11276
        -- upvalues: u802 (copy)
        u802:Destroy();
    end);
    local v803 = MeshEmitter.StartMeshEmitter(v801, ReplicatedStorage.Resources.izayoi["Time Stop MeshEmitter"], nil, 5);
    v803.Parent = workspace_CurrentCamera;
    local TimeStopCC = v803.TimeStopCC;
    Debris:AddItem(TimeStopCC, 5);
    TimeStopCC.Enabled = true;
    TimeStopCC.Parent = workspace_CurrentCamera;
    task.delay(0.45, function() -- Line: 11288
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.Time:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.617, function() -- Line: 11304
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.9;
            end;
        end;
    end);
    task.delay(0.8, function() -- Line: 11313
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.8;
            end;
        end;
    end);
    task.delay(0.95, function() -- Line: 11322
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.7;
            end;
        end;
    end);
    task.delay(1.083, function() -- Line: 11331
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.6;
            end;
        end;
    end);
    task.delay(1.217, function() -- Line: 11340
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.5;
            end;
        end;
    end);
    task.delay(1.367, function() -- Line: 11349
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.4;
            end;
        end;
    end);
    task.delay(1.533, function() -- Line: 11358
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.3;
            end;
        end;
    end);
    task.delay(1.7, function() -- Line: 11367
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.2;
            end;
        end;
    end);
    task.delay(1.867, function() -- Line: 11376
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.1;
            end;
        end;
    end);
    task.delay(2.017, function() -- Line: 11385
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.05;
            end;
        end;
    end);
    task.delay(3.483, function() -- Line: 11394
        -- upvalues: u802 (copy)
        for _, descendant in pairs(u802.SMOKE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
end;

function u1.powerfulstriker(p804) -- Line: 11404
    -- upvalues: u1 (copy), ReplicatedStorage (copy), TweenService (copy)
    local v805 = p804.HumanoidRootPart or p804.PrimaryPart;
    u1.bigshockwave(v805);
    local v806 = ReplicatedStorage.Resources.izayoi.SakuyaShot:Clone();
    v806.Parent = p804;
    v806:PivotTo(v805.CFrame);

    for _, descendant in ipairs(v806.impact:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    TweenService:Create(v806.Haze.Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Scale = Vector3.new(-0.2, -0.18, -0.2)
    }):Play();
    TweenService:Create(v806.Haze.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    TweenService:Create(v806.Haze, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = v806.Haze.CFrame * CFrame.new(-20, 0, 0) * CFrame.Angles(1.6277115137024316, 0, 0)
    }):Play();
    TweenService:Create(v806.Start, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(99.601, 8.841, 9.273)
    }):Play();
    TweenService:Create(v806.Start.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    TweenService:Create(v806.Start, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = v806.Start.CFrame * CFrame.new(-35, 0, 0) * CFrame.Angles(-1.7444565873683324, 0, 0)
    }):Play();
    TweenService:Create(v806.Reda.Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Scale = Vector3.new(3.039, 0, 0)
    }):Play();
    TweenService:Create(v806.Reda.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    TweenService:Create(v806.Reda, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = v806.Reda.CFrame * CFrame.new(-8, 0, 0) * CFrame.Angles(1.4541734261766355, 0, 0)
    }):Play();
    TweenService:Create(v806.XD.Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Scale = Vector3.new(3.179, 1.072, 1.037)
    }):Play();
    TweenService:Create(v806.XD.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    TweenService:Create(v806.XD, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = v806.XD.CFrame * CFrame.new(-5, 0, 0) * CFrame.Angles(1.6277115137024316, 0, 0)
    }):Play();
    TweenService:Create(v806.WaveMesh, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(275.083, 54.481, 51.904)
    }):Play();
    TweenService:Create(v806.WaveMesh.Decal, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    TweenService:Create(v806.WaveMesh, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = v806.WaveMesh.CFrame * CFrame.new(-15, 0, 0) * CFrame.Angles(-1.3636781044607293, 0, 0)
    }):Play();
    task.delay(2, v806.Destroy, v806);
end;

function u1.cr7Kick(p807) -- Line: 11531
    -- upvalues: ReplicatedStorage (copy)
    local v808 = p807:FindFirstChild("HumanoidRootPart") or p807.PrimaryPart;

    if not v808 then
        return;
    end;

    local TuffCharacterRig = ReplicatedStorage.Resources:FindFirstChild("TuffCharacterRig");

    if TuffCharacterRig then
        local HumanoidRootPart = TuffCharacterRig:FindFirstChild("HumanoidRootPart");
        local v809 = HumanoidRootPart and HumanoidRootPart:FindFirstChild("1");

        if v809 then
            local v810 = v809:Clone();
            v810.Parent = v808;
            require(ReplicatedStorage:WaitForChild("EffectUtility")).EmitAttachment(v810);
        end;
    end;

    local MeshesBK = ReplicatedStorage.Resources.ronaldo:FindFirstChild("MeshesBK");
    local v811 = MeshesBK and MeshesBK:FindFirstChild("1");

    if v811 then
        local MeshEmit = require(ReplicatedStorage:WaitForChild("MeshEmit"));

        for _, descendant in ipairs(v811:GetDescendants()) do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;
    end;
end;

function u1.formlessHit(p812) -- Line: 11565
    -- upvalues: u1 (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    u1.Emit(p812.HumanoidRootPart or p812.PrimaryPart, ReplicatedStorage.Resources.shidou.normalkick2, 5, CFrame.new(0, 0, -4));
    u1.cameraShake(20, 2, 15);
    u1.fov(false, 120);
    u1.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 5;
    task.wait(0.05);
    ColorCorrectionEffect.Contrast = -1;
    task.wait(0.05);
    ColorCorrectionEffect.Contrast = -2;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
        Contrast = 0
    }):Play();
    task.wait(0.5);
    ColorCorrectionEffect:Destroy();
end;

function u1.formless(u813) -- Line: 11589
    -- upvalues: u1 (copy), ReplicatedStorage (copy), TweenService (copy), Players (copy), Lighting (copy), actionUtil (copy), RunService (copy)
    local u814 = u813.HumanoidRootPart or u813.PrimaryPart;
    u1.Emit(u813.Head, ReplicatedStorage.Resources.shidou.eemit, 3);
    task.delay(0.2, function() -- Line: 11619
        -- upvalues: ReplicatedStorage (ref), u813 (copy), u814 (copy), TweenService (ref), Players (ref), u1 (ref), Lighting (ref), actionUtil (ref), RunService (ref)
        local v815 = ReplicatedStorage.Resources.shidou.dhEffects:Clone();
        v815.Parent = u813;
        v815:PivotTo(CFrame.new(u814.Position, u814.Position + u814.CFrame.LookVector) * CFrame.new(0, 5, -10) * CFrame.Angles(0.5235987755982988, 0, 0));
        v815.End.Mesh.Scale = Vector3.new(3.179, 0, 0);
        TweenService:Create(v815.End.Mesh, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(3.179, 1.072, 1.037)
        }):Play();
        TweenService:Create(v815.End.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(v815.End, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = v815.End.CFrame * CFrame.Angles(1.3962634015954636, 0, 0)
        }):Play();
        TweenService:Create(v815.End4, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v815.End3, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(50, 0, 0)
        }):Play();
        TweenService:Create(v815.End2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v815.Twirl, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(15.359, 50, 15.92),
            Transparency = 1,
            CFrame = v815.Twirl.CFrame * CFrame.Angles(0, -0.4174478504920037, 0)
        }):Play();
        task.delay(2, v815.Destroy, v815);
        task.spawn(function() -- Line: 11682
            -- upvalues: Players (ref), u814 (ref), u1 (ref), Lighting (ref), TweenService (ref)
            if Players.LocalPlayer:DistanceFromCharacter(u814.Position) <= 50 then
                u1.cameraShake(15, 2, 4);
                u1.fov(false, 30);
                u1.fov(true, 70, 0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Parent = Lighting;
                ColorCorrectionEffect.Contrast = 5;
                task.wait(0.05);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                    Contrast = 0
                }):Play();
                task.wait(0.2);
                ColorCorrectionEffect:Destroy();
            end;
        end);

        if not actionUtil.simulatesCharacter(u813) then
            return;
        end;

        local u816 = u1.bodyVelocity(u814, 1, 0.15, nil, nil, true);
        u816.MaxForce = Vector3.new(300000, 300000, 300000);
        local u817 = nil;
        u817 = RunService.RenderStepped:Connect(function(p818) -- Line: 11710
            -- upvalues: u816 (copy), u817 (ref), u814 (ref)
            if u816 and u816:IsDescendantOf(game) then
                u816.Velocity = u814.CFrame.LookVector * 100 + u814.CFrame.UpVector * 50;

                return;
            end;

            u817:Disconnect();
        end);
        task.delay(15, u817.Disconnect, u817);
    end);
end;

function u1.formlessdragonmovement(p819, p820, p821, p822) -- Line: 11721
    -- upvalues: u1 (copy), ReplicatedStorage (copy), RunService (copy)
    local u823 = p819.HumanoidRootPart or p819.PrimaryPart;
    local u824 = (typeof(p822) ~= "number" or p822 <= 0) and 75 or math.sqrt(2 * workspace.Gravity * p822);

    if not p821 then
        u1.Emit(u823, ReplicatedStorage.Resources["Jump Wind"], 3, CFrame.new(Vector3.new(-0, -3, -0)));
        u1.cameraShake(10, 0.5, 3);
    end;

    local u825 = u1.bodyVelocity(u823, 1, 0.05, nil, nil, true);

    if u825 then
        u825.MaxForce = Vector3.new(300000, 300000, 300000);
        local u826 = ({
            Back = u823.CFrame.LookVector * -50,
            Front = u823.CFrame.LookVector * 25,
            Left = u823.CFrame.RightVector * -50,
            Right = u823.CFrame.RightVector * 50
        })[p820];
        local u827 = nil;
        u827 = RunService.RenderStepped:Connect(function(p828) -- Line: 11748
            -- upvalues: u825 (copy), u827 (ref), u826 (copy), u823 (copy), u824 (ref)
            if u825 and u825:IsDescendantOf(game) then
                u825.Velocity = u826 + u823.CFrame.UpVector * u824;

                return;
            end;

            u827:Disconnect();
        end);
        task.delay(15, u827.Disconnect, u827);
    end;
end;

function u1.karasuaerialjump(p829, p830, p831) -- Line: 11764
    -- upvalues: u1 (copy), ReplicatedStorage (copy), mainreplication (copy), actionUtil (copy), RunService (copy)
    if p829:GetAttribute("frozen") then
        return;
    end;

    local u832 = p829.HumanoidRootPart or p829.PrimaryPart;

    if not p831 then
        u1.Emit(u832, ReplicatedStorage.Resources.karasu["Silent Steal"].AerialCrowTrap["Jump Wind"], 3, CFrame.new(Vector3.new(-0, -3, -0)));
        mainreplication.highlight(p829, Color3.fromRGB(56, 67, 214), 0.8);

        if actionUtil.simulatesCharacter(p829) then
            u1.cameraShake(10, 0.5, 3);
            mainreplication.fov(false, 55);
            mainreplication.fov(true, 70, 0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;
    end;

    local u833 = u1.bodyVelocity(u832, 1, 0.05, nil, nil, true);

    if u833 then
        u833.MaxForce = Vector3.new(300000, 300000, 300000);
        local u834 = ({
            Back = u832.CFrame.LookVector * -50,
            Front = u832.CFrame.LookVector * 25,
            Left = u832.CFrame.RightVector * -50,
            Right = u832.CFrame.RightVector * 50
        })[p830];
        local u835 = nil;
        u835 = RunService.RenderStepped:Connect(function(p836) -- Line: 11794
            -- upvalues: u833 (copy), u835 (ref), u834 (copy), u832 (copy)
            if u833 and u833:IsDescendantOf(game) then
                u833.Velocity = u834 + u832.CFrame.UpVector * 75;

                return;
            end;

            u835:Disconnect();
        end);
        task.delay(15, u835.Disconnect, u835);
    end;
end;

function u1.nagivolleymovement(p837) -- Line: 11810
    -- upvalues: actionUtil (copy), mainreplication (copy), RunService (copy)
    local u838 = p837.HumanoidRootPart or p837.PrimaryPart;

    if not actionUtil.simulatesCharacter(p837) then
        return;
    end;

    local u839, u840 = mainreplication.bodyVelocity(u838, 60, 0.467, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
    u839.MaxForce = Vector3.new(300000, 300000, 300000);
    local u841 = nil;
    u841 = RunService.RenderStepped:Connect(function(p842) -- Line: 11828
        -- upvalues: u839 (copy), u841 (ref), u838 (copy), u840 (copy)
        if u839 and u839:IsDescendantOf(game) then
            u839.Velocity = u838.CFrame.LookVector * -10 + u838.CFrame.UpVector * u840.Value;

            return;
        end;

        u841:Disconnect();
    end);
    task.delay(15, u841.Disconnect, u841);
    task.delay(0.465, function() -- Line: 11838
        -- upvalues: mainreplication (ref), u838 (copy), RunService (ref)
        local u843, u844 = mainreplication.bodyVelocity(u838, 25, 0.65, nil, nil, true, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        u843.MaxForce = Vector3.new(300000, 300000, 300000);
        local u845 = nil;
        u845 = RunService.RenderStepped:Connect(function(p846) -- Line: 11850
            -- upvalues: u843 (copy), u845 (ref), u838 (ref), u844 (copy)
            if u843 and u843:IsDescendantOf(game) then
                u843.Velocity = u838.CFrame.LookVector * 5 + u838.CFrame.UpVector * -u844.Value;

                return;
            end;

            u845:Disconnect();
        end);
        task.delay(15, u845.Disconnect, u845);
    end);
    task.delay(1.067, function() -- Line: 11861
        -- upvalues: mainreplication (ref), u838 (copy), RunService (ref)
        local u847, u848 = mainreplication.bodyVelocity(u838, 75, 0.467, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        u847.MaxForce = Vector3.new(300000, 300000, 300000);
        local u849 = nil;
        u849 = RunService.RenderStepped:Connect(function(p850) -- Line: 11873
            -- upvalues: u847 (copy), u849 (ref), u838 (ref), u848 (copy)
            if u847 and u847:IsDescendantOf(game) then
                u847.Velocity = u838.CFrame.UpVector * u848.Value + u838.CFrame.LookVector * -u848.Value;

                return;
            end;

            u849:Disconnect();
        end);
    end);
end;

function u1.dragonheader(u851) -- Line: 11884
    -- upvalues: u1 (copy), ReplicatedStorage (copy), raycast (copy), TweenService (copy), RunService (copy), Players (copy), Lighting (copy)
    local u852 = u851.HumanoidRootPart or u851.PrimaryPart;
    u1.Emit(u851.Head, ReplicatedStorage.Resources.shidou.eemit, 3);
    local u853 = ReplicatedStorage.Resources.shidou.dhWing:Clone();
    u853.Weld.Part0 = u851.Torso;
    u853.Parent = u851;
    local u854 = nil;
    task.delay(0.4333333333333333, function() -- Line: 11920
        -- upvalues: u854 (ref), ReplicatedStorage (ref), u852 (copy), u851 (copy), raycast (ref), TweenService (ref), RunService (ref), u853 (copy), Players (ref), u1 (ref), Lighting (ref)
        u854 = ReplicatedStorage.Resources.shidou.Gasterblaser:Clone();
        u854.Root.Root.Part0 = u852;
        u854.Parent = u851;
        local v855 = raycast(u852.Position, u852.CFrame.LookVector * 60, nil, { workspace.map });
        local v856;

        if v855 then
            v856 = CFrame.new(v855.Position, v855.Position + u852.CFrame.LookVector);
        else
            v856 = u852.CFrame + u852.CFrame.LookVector * 60;
        end;

        local u857 = v856 + u852.CFrame.UpVector * 22;
        local v858 = ReplicatedStorage.Resources.shidou.dhEffects:Clone();
        v858.Parent = u851;
        v858:PivotTo(CFrame.new(u852.Position, u852.Position + u857.LookVector) * CFrame.new(0, 10, -50) * CFrame.Angles(0.3490658503988659, 0, 0));
        v858.End.Mesh.Scale = Vector3.new(3.179, 0, 0);
        TweenService:Create(v858.End.Mesh, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(3.179, 1.072, 1.037)
        }):Play();
        TweenService:Create(v858.End.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(v858.End, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = v858.End.CFrame * CFrame.Angles(1.3962634015954636, 0, 0)
        }):Play();
        TweenService:Create(v858.End4, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v858.End3, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(50, 0, 0)
        }):Play();
        TweenService:Create(v858.End2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v858.Twirl, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(15.359, 50, 15.92),
            Transparency = 1,
            CFrame = v858.Twirl.CFrame * CFrame.Angles(0, -0.4174478504920037, 0)
        }):Play();
        task.delay(2, v858.Destroy, v858);
        local u860 = RunService.PreRender:Connect(function(p859) -- Line: 12012
            -- upvalues: u852 (ref), u857 (ref)
            u852.CFrame = u852.CFrame:Lerp(u857, math.min(p859, 0.03333333333333333) * 10);
        end);
        task.delay(0.25, function() -- Line: 12017
            -- upvalues: u853 (ref), u860 (ref)
            u853:Destroy();
            u860:Disconnect();
        end);

        for _, descendant in ipairs(u854:GetDescendants()) do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end;
        end;

        if Players.LocalPlayer:DistanceFromCharacter(u852.Position) <= 50 then
            u1.cameraShake(15, 2, 4);
            u1.fov(false, 120);
            u1.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Parent = Lighting;
            ColorCorrectionEffect.Contrast = 5;
            task.wait(0.05);
            ColorCorrectionEffect.Contrast = -1;
            task.wait(0.05);
            ColorCorrectionEffect.Contrast = -2;
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                Contrast = 0
            }):Play();
            task.wait(0.5);
            ColorCorrectionEffect:Destroy();
        end;
    end);
    task.wait(1.5833333730697632);

    if u854 then
        u854:Destroy();
    end;
end;

function u1.shidouawk(u861) -- Line: 12058
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), PlayerGui (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Color (copy), Density (copy), TekrinnDialogue (copy)
    local v862 = u861.HumanoidRootPart or u861.PrimaryPart;
    local _ = u861.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.bright(-1, -0.15);
    u1.sceneEnabled(true);
    local u863 = ReplicatedStorage.Resources.shidou.awkEffects:Clone();
    u863:PivotTo(v862.CFrame);
    u863.Parent = u861;

    if Util.canshiftcolor(LocalPlayer, u861) then
        vfxUtil.LeanTowardsColor(u863, u861:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u861:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v864 = ReplicatedStorage.Resources.darkscreen:Clone();
    v864.Parent = PlayerGui;
    local v865 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v865.Parent = Lighting;
    v865.FarIntensity = 0;
    TweenService:Create(v865, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.shidou.awake_1, SoundService);
    u1.cutscene(v862, CFrame.new(Vector3.new(0, 0, 0)), 4.8, ReplicatedStorage.Resources.shidou.awkFOV);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 163, 247);
    ColorCorrectionEffect.Parent = Lighting;
    Atmosphere.Color = Color3.fromRGB(255, 0, 132);
    Atmosphere.Density = 0.7;
    task.delay(0.1666666666666667, function() -- Line: 12095
        -- upvalues: u863 (copy)
        for _, descendant in ipairs(u863.slam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.116666666666667, function() -- Line: 12104
        -- upvalues: u863 (copy)
        for _, descendant in ipairs(u863.spin:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.683333333333333, function() -- Line: 12113
        -- upvalues: ColorCorrectionEffect (copy), Atmosphere (copy), Color (ref), Density (ref), u863 (copy)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        Atmosphere.Color = Color;
        Atmosphere.Density = Density;

        for _, descendant in ipairs(u863.line:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.85, function() -- Line: 12126
        -- upvalues: ColorCorrectionEffect (copy), Atmosphere (copy), u863 (copy), TekrinnDialogue (ref), u861 (copy)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 163, 247);
        Atmosphere.Color = Color3.fromRGB(255, 0, 132);
        Atmosphere.Density = 0.7;

        for _, descendant in ipairs(u863.line2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u863.bgAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.wait(0.85);
        TekrinnDialogue.Speak(u861, {
            {
                Text = "My ball.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.015,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1.5
                }
            }
        }, 1.5);
    end);
    task.wait(4.8);
    Atmosphere.Color = Color;
    Atmosphere.Density = Density;
    ColorCorrectionEffect:Destroy();
    v864:Destroy();
    v865:Destroy();
    u1.sceneEnabled(false);
    u863:Destroy();
    u1.ultFlash();
    u1.fov(false, 15);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.amnagi(u866, u867) -- Line: 12192
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), u1 (copy), vfxUtil (copy), Util (copy), LocalPlayer (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), TweenService (copy)
    local v868 = u866.HumanoidRootPart or u866.PrimaryPart;
    local _ = u866.Torso;
    local _ = Lighting.Atmosphere;
    local Ball = u866:FindFirstChild("Ball");
    local u869 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u869.Parent = Lighting;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    u1.bright(-1, 0.15);
    u1.sceneEnabled(true);
    vfxUtil.cutscene_ball(true);
    local u870 = ReplicatedStorage.Resources.nagi.allEffnagiNEW:Clone();
    u870:PivotTo(v868.CFrame);
    u870.Parent = u866;

    if Util.canshiftcolor(LocalPlayer, u866) then
        vfxUtil.LeanTowardsColor(u870, u866:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u866:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u870:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local v871 = soundUtil:play(ReplicatedStorage.Resources.nagi.nagiyahoo, SoundService, {
        Character = u866
    });
    u1.cutscene(v868, CFrame.new(Vector3.new(0, 0, 0)), 14.816666603088379, ReplicatedStorage.Resources.nagi.newFOV);

    if v871.Name == "Dub" then
        task.delay(0.1, function() -- Line: 12231
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Text = "Start with the motion...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 1.9);
        end);
        task.delay(1.9, function() -- Line: 12257
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Text = "... insta-kill it!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2.867);
        end);
        task.delay(8.2, function() -- Line: 12283
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Text = "Nice to meet you, Japan.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 1.9);
        end);
        task.delay(11.133, function() -- Line: 12309
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Text = "My name...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 1.9);
        end);
        task.delay(14.317, function() -- Line: 12335
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = `"Is {string.upper(u866.Name)}!!`,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 199, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 1);
        end);
    else
        task.delay(0.1, function() -- Line: 12361
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Text = "Start the shooting motion, then...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 1.9);
        end);
        task.delay(1.9, function() -- Line: 12387
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Text = "... instantly kill it!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2.867);
        end);
        task.delay(8.2, function() -- Line: 12413
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Text = "Nice to meet you, Japan.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 1.9);
        end);
        task.delay(11.133, function() -- Line: 12439
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Text = "I am...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 1.9);
        end);
        task.delay(14.317, function() -- Line: 12465
            -- upvalues: TekrinnDialogue (ref), u866 (copy)
            TekrinnDialogue.Speak(u866, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = `{string.upper(u866.Name)}!!`,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(184, 199, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1
                    }
                }
            }, 1);
        end);
    end;

    task.delay(3.8, function() -- Line: 12494
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(197, 215, 255);
        ColorCorrectionEffect.Contrast = 0.5;
        ColorCorrectionEffect.Saturation = -0.4;
    end);
    task.delay(3.083, function() -- Line: 12500
        -- upvalues: u870 (copy)
        for _, descendant in ipairs(u870.glass:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.283, function() -- Line: 12508
        -- upvalues: u870 (copy)
        for _, descendant in ipairs(u870.hitground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.283, function() -- Line: 12516
        -- upvalues: u870 (copy)
        for _, descendant in ipairs(u870.hitground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.45, function() -- Line: 12524
        -- upvalues: u870 (copy)
        for _, descendant in ipairs(u870.lin:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.717, function() -- Line: 12532
        -- upvalues: u870 (copy)
        for _, descendant in ipairs(u870.lin:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.783, function() -- Line: 12540
        -- upvalues: u867 (copy), u870 (copy)
        if u867 then
            u870:PivotTo(u867);
        end;

        for _, descendant in u870.line2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.167, function() -- Line: 12551
        -- upvalues: u870 (copy)
        for _, descendant in u870.bg:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in u870.glowingspechand:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(11.633, function() -- Line: 12565
        -- upvalues: u870 (copy), ColorCorrectionEffect (copy)
        u870.bg:Destroy();
        u870.glowingspechand:Destroy();
        u870.line2:Destroy();
        ColorCorrectionEffect.Brightness = 0.055;
    end);
    task.delay(12.65, function() -- Line: 12573
        -- upvalues: u870 (copy), TweenService (ref)
        for _, descendant in ipairs(u870.hit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u870.beam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.TextureSpeed = 0;
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    TextureSpeed = 10
                }):Play();
            end;
        end;
    end);
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = Ball;
    task.delay(13.083, function() -- Line: 12599
        -- upvalues: vfxUtil (ref), u869 (copy), ColorCorrectionEffect (copy), u870 (copy), Ball (copy), Attachment (copy)
        vfxUtil.cutscene_ball(false);
        u869:Destroy();
        ColorCorrectionEffect:Destroy();

        for _, descendant in ipairs(u870.beam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u870.be2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u870.be2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        if Ball then
            for _, descendant in ipairs(u870.be2:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Attachment1 = Attachment;
                end;
            end;
        end;
    end);
    task.wait(14.816666603088379);
    Attachment:Destroy();
    u870:Destroy();

    if ColorCorrectionEffect then
        ColorCorrectionEffect:Destroy();
    end;

    u1.sceneEnabled(false);
    u1.ultFlash();
    u1.fov(false, 50);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.centerofgravity(u872) -- Line: 12648
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), vfxUtil (copy), u1 (copy), Util (copy), LocalPlayer (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), RunService (copy), workspace_CurrentCamera (copy), TweenService (copy)
    local v873 = u872.HumanoidRootPart or u872.PrimaryPart;
    local _ = u872.Torso;
    local _ = Lighting.Atmosphere;
    u872:FindFirstChild("Ball");
    local v874 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v874.Parent = Lighting;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local BloomEffect = Instance.new("BloomEffect");
    BloomEffect.Intensity = 0.4;
    BloomEffect.Size = 30;
    BloomEffect.Threshold = 2.5;
    BloomEffect.Parent = Lighting;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    u1.bright(-1, 0.6);
    u1.sceneEnabled(true);
    local u875 = ReplicatedStorage.Resources.rin.cogEff:Clone();
    u875:PivotTo(v873.CFrame);
    u875.Parent = u872;

    if Util.canshiftcolor(LocalPlayer, u872) then
        vfxUtil.LeanTowardsColor(u875, u872:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u872:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u876 = ReplicatedStorage.Resources.rin.eyebeam:Clone();
    u876.Weld.Part0 = u872.Head;
    u876.Parent = u875;
    u876["1"]["1"].Attachment1 = u875.Part["2"];
    u876["3"]["2"].Attachment1 = u875.Part["4"];
    local v877 = soundUtil:play(ReplicatedStorage.Resources.rin.ringravity, SoundService, {
        Character = u872
    });
    u1.cutsceneBlender(v873, ReplicatedStorage.Resources.rin.cogC, ReplicatedStorage.Resources.rin.cogFOV);

    if v877.Name == "Dub" then
        task.delay(2.006, function() -- Line: 12697
            -- upvalues: TekrinnDialogue (ref), u872 (copy)
            TekrinnDialogue.Speak(u872, {
                {
                    Text = "Know your place.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 2)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 6);
        end);
        task.delay(3.821, function() -- Line: 12723
            -- upvalues: TekrinnDialogue (ref), u872 (copy)
            TekrinnDialogue.Speak(u872, {
                {
                    Text = "Piss off, old man.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 2)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 6);
        end);
        task.delay(5.495, function() -- Line: 12749
            -- upvalues: TekrinnDialogue (ref), u872 (copy)
            TekrinnDialogue.Speak(u872, {
                {
                    Text = "Center of gravity...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 2)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 4);
        end);
        task.delay(7.104, function() -- Line: 12775
            -- upvalues: TekrinnDialogue (ref), u872 (copy)
            TekrinnDialogue.Speak(u872, {
                {
                    Text = ".. full burst!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    else
        task.delay(2.1, function() -- Line: 12801
            -- upvalues: TekrinnDialogue (ref), u872 (copy)
            TekrinnDialogue.Speak(u872, {
                {
                    Text = "Know your place.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 2)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 2.5);
        end);
        task.delay(3.817, function() -- Line: 12827
            -- upvalues: TekrinnDialogue (ref), u872 (copy)
            TekrinnDialogue.Speak(u872, {
                {
                    Text = "Turn around.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 2)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 4);
        end);
        task.delay(6.217, function() -- Line: 12853
            -- upvalues: TekrinnDialogue (ref), u872 (copy)
            TekrinnDialogue.Speak(u872, {
                {
                    Text = "The center of gravity...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 2)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                },
                {
                    Text = " full burst!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1.5
                    }
                }
            }, 2);
        end);
    end;

    local u878 = ReplicatedStorage.Resources.rin.CamPart:Clone();
    u878.Parent = u875;
    local u879 = nil;
    u879 = RunService.PreRender:connect(function() -- Line: 12908
        -- upvalues: u878 (copy), u879 (ref), workspace_CurrentCamera (ref)
        if not u878:IsDescendantOf(game) then
            u879:Disconnect();
        end;

        u878.CFrame = workspace_CurrentCamera.CFrame;
    end);
    local u880 = nil;
    task.delay(0.867, function() -- Line: 12916
        -- upvalues: u880 (ref), ReplicatedStorage (ref), u875 (copy), RunService (ref), workspace_CurrentCamera (ref), TweenService (ref), ColorCorrectionEffect (copy)
        u880 = ReplicatedStorage.Resources.rin.CAMERAPART:Clone();
        u880.Parent = u875;
        local u881 = nil;
        u881 = RunService.PreRender:connect(function() -- Line: 12921
            -- upvalues: u880 (ref), u881 (ref), workspace_CurrentCamera (ref)
            if not u880:IsDescendantOf(game) then
                u881:Disconnect();
            end;

            u880.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -1.5) * CFrame.Angles(0, 0, -1.0471975511965976);
        end);

        for _, descendant in ipairs(u875.grasskick1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Brightness = -0.35,
            Contrast = 1.5,
            Saturation = -0.7,
            TintColor = Color3.fromRGB(255, 124, 126)
        }):Play();
    end);
    task.delay(1.55, function() -- Line: 12944
        -- upvalues: u880 (ref), u878 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        u880:Destroy();

        for _, descendant in ipairs(u878:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        ColorCorrectionEffect.Saturation = 0;
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Brightness = 0;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2.467, Enum.EasingStyle.Linear), {
            Brightness = -0.3,
            Contrast = 0.3,
            Saturation = 1
        }):Play();
    end);
    task.delay(3.133, function() -- Line: 12967
        -- upvalues: u876 (copy), TweenService (ref)
        for _, descendant in ipairs(u876:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Width0 = 0;
                descendant.Width1 = 0;
                TweenService:Create(descendant, TweenInfo.new(1.434, Enum.EasingStyle.Linear), {
                    Width0 = 0.01,
                    Width1 = 0
                }):Play();
            end;
        end;
    end);
    task.delay(5.067, function() -- Line: 12980
        -- upvalues: u876 (copy), u878 (copy), u875 (copy), ColorCorrectionEffect (copy), TweenService (ref), BloomEffect (copy)
        u876:Destroy();

        for _, descendant in ipairs(u878:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u878:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u875.stinkyred:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u875.grasskick2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        ColorCorrectionEffect.Saturation = 0;
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Brightness = 1;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0
        }):Play();
        BloomEffect.Threshold = 0;
        TweenService:Create(BloomEffect, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Threshold = 0.85
        }):Play();
    end);
    task.delay(8.55, function() -- Line: 13026
        -- upvalues: BloomEffect (copy), u878 (copy), ColorCorrectionEffect (copy)
        BloomEffect:Destroy();

        for _, descendant in ipairs(u878:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 0, 0);
    end);
    task.wait(9.567);
    ScreenDimmer:Destroy();
    v874:Destroy();
    BloomEffect:Destroy();
    u875:Destroy();

    if ColorCorrectionEffect then
        ColorCorrectionEffect:Destroy();
    end;

    u1.sceneEnabled(false);
    u1.ultFlash();
    u1.fov(false, 50);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.centerofeverything(u882, u883) -- Line: 13056
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), u1 (copy), Debris (copy), PlayerGui (copy), TweenService (copy), TekrinnDialogue (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy)
    local u884 = u882.HumanoidRootPart or u882.PrimaryPart;
    local _ = u882.Torso;
    local _ = Lighting.Atmosphere;
    local Attribute = u882:GetAttribute("evil");
    u882:FindFirstChild("Ball");
    local v885 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v885.Parent = Lighting;
    u1.sceneEnabled(true);
    local v886 = ReplicatedStorage.Resources.rin.eyebeam:Clone();
    v886.Weld.Part0 = u882.Head;
    v886.Parent = workspace.Effects;
    local u887 = ReplicatedStorage.Resources.rin.rinawkdotsbackground2:Clone();
    u887.Parent = workspace.Effects;
    local u888 = ReplicatedStorage.Resources.rin.RinNoPlayAsset["Kitchen Knife"]:Clone();
    u888["Kitchen Knife"].Part0 = u882["Left Arm"];
    Debris:AddItem(u888["Kitchen Knife"], 24.571);
    u888.Parent = workspace.Effects;
    local v889 = ReplicatedStorage.Resources.rin.RinNoPlayAsset["Kitchen KnifeRight"]:Clone();
    v889["Kitchen KnifeRight"].Part0 = u882["Right Arm"];
    Debris:AddItem(v889["Kitchen KnifeRight"], 24.571);
    v889.Parent = workspace.Effects;
    task.spawn(function() -- Line: 13087
        -- upvalues: u887 (copy), u884 (copy)
        u887.CFrame = u884.CFrame * CFrame.new(35.583, -100, 2.907);
        u887.CFrame = u887.CFrame * CFrame.Angles(-0, 1.5707963267948966, 1.5707963267948966);
    end);
    task.delay(2.171, function() -- Line: 13092
        -- upvalues: u887 (copy), u884 (copy)
        u887.CFrame = u884.CFrame * CFrame.new(7.212, -3.04, 6.693);
        u887.CFrame = u887.CFrame * CFrame.Angles(-0, 1.5707963267948966, 1.5707963267948966);
    end);
    task.delay(6, function() -- Line: 13097
        -- upvalues: u887 (copy), u884 (copy)
        u887.CFrame = u884.CFrame * CFrame.new(-9.3, -3.23, 1.561);
        u887.CFrame = u887.CFrame * CFrame.Angles(-0, 1.5707963267948966, 1.5707963267948966);
    end);
    task.delay(10.829, function() -- Line: 13102
        -- upvalues: u887 (copy), u884 (copy)
        u887.CFrame = u884.CFrame * CFrame.new(-1.569, -3.23, 1.561);
        u887.CFrame = u887.CFrame * CFrame.Angles(-0, 1.5707963267948966, 1.5707963267948966);
    end);
    task.delay(12.771, function() -- Line: 13107
        -- upvalues: u887 (copy), u884 (copy), u888 (copy)
        u887.CFrame = u884.CFrame * CFrame.new(-1.569, -100, 1.561);
        u887.CFrame = u887.CFrame * CFrame.Angles(-0, 1.5707963267948966, 1.5707963267948966);
        u888:Destroy();
    end);

    if Attribute then
        local u890 = ReplicatedStorage.Resources.rin.RinNoPlayAsset.EvilBlood:Clone();
        local u891 = ReplicatedStorage.Resources.rin.RinNoPlayAsset.Bleeding:Clone();
        local u892 = ReplicatedStorage.Resources.rin.RinNoPlayAsset.pool:Clone();
        local u893 = ReplicatedStorage.Resources.rin.RinNoPlayAsset.SuperStarEyes:Clone();
        local u894 = ReplicatedStorage.Resources.rin.Vignette:Clone();
        local Vignette = u894.Vignette;
        u894.Parent = PlayerGui;
        Vignette.ImageColor3 = Color3.new();
        u890.Parent = u883:FindFirstChild("Torso") or u883.PrimaryPart;
        u891.Parent = u883:FindFirstChild("Torso") or u883.PrimaryPart;
        u892.Parent = workspace.Effects;
        u892.Transparency = 1;
        u893.Weld.Part0 = u882.Head;
        TweenService:Create(Vignette, TweenInfo.new(2.4), {
            ImageTransparency = 0.5
        }):Play();
        task.delay(3.047, function() -- Line: 13130
            -- upvalues: TekrinnDialogue (ref), u882 (copy)
            TekrinnDialogue.Speak(u882, {
                {
                    Text = "Don\'t leash my potential!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 4
                    }
                }
            }, 5);
        end);
        task.delay(6.036, function() -- Line: 13156
            -- upvalues: TekrinnDialogue (ref), u882 (copy), u883 (copy)
            TekrinnDialogue.Speak(u882, {
                {
                    Text = "Stop clinging to me, ",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                },
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = `{u883.Name}!`,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            }, 5);
        end);
        task.delay(8.815, function() -- Line: 13201
            -- upvalues: u893 (copy), u882 (copy), TweenService (ref), Vignette (copy), TekrinnDialogue (ref)
            u893.Parent = u882;
            TweenService:Create(Vignette, TweenInfo.new(3), {
                ImageColor3 = Color3.fromRGB(170, 0, 0)
            }):Play();
            TekrinnDialogue.Speak(u882, {
                {
                    Text = "Kill... ",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.12,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    }
                },
                {
                    Text = "KILL!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            }, 5);
        end);
        task.delay(10.867, function() -- Line: 13248
            -- upvalues: u893 (copy), Vignette (copy), u888 (copy)
            u893:Destroy();
            Vignette.ImageTransparency = 1;
            shared.vfx.emit(u888);
        end);
        task.delay(13.183, function() -- Line: 13254
            -- upvalues: Vignette (copy), u890 (copy), vfxUtil (ref), u891 (copy), TweenService (ref)
            Vignette.ImageTransparency = 0;
            shared.vfx.emit(u890);
            vfxUtil.enableEffects(u891, true, "ParticleEmitter");
            TweenService:Create(Vignette, TweenInfo.new(0.5), {
                ImageTransparency = 1
            }):Play();
        end);
        task.delay(14.15, function() -- Line: 13261
            -- upvalues: Vignette (copy), u890 (copy), TweenService (ref)
            Vignette.ImageTransparency = 0;
            shared.vfx.emit(u890);
            TweenService:Create(Vignette, TweenInfo.new(0.5), {
                ImageTransparency = 1
            }):Play();
        end);
        task.delay(16.483, function() -- Line: 13267
            -- upvalues: Vignette (copy), TweenService (ref)
            Vignette.ImageTransparency = 0;
            TweenService:Create(Vignette, TweenInfo.new(0.5), {
                ImageTransparency = 1
            }):Play();
        end);
        task.delay(16.833, function() -- Line: 13272
            -- upvalues: u892 (copy), u884 (copy), Debris (ref), TweenService (ref)
            u892.Transparency = 0;
            u892.CFrame = u884.CFrame * CFrame.new(-10.357, -3.089, -4.444) * CFrame.Angles(0, -0.7853981633974483, 1.5707963267948966);
            Debris:AddItem(u892, 7.734000000000002);
            TweenService:Create(u892, TweenInfo.new(7.734000000000002), {
                Size = Vector3.new(0.3, 5, 5)
            }):Play();
        end);
        task.delay(17.533, function() -- Line: 13279
            -- upvalues: Vignette (copy), u890 (copy), TweenService (ref)
            Vignette.ImageTransparency = 0;
            shared.vfx.emit(u890);
            TweenService:Create(Vignette, TweenInfo.new(0.5), {
                ImageTransparency = 1
            }):Play();
        end);
        task.delay(18.567, function() -- Line: 13285
            -- upvalues: Vignette (copy), u890 (copy), TweenService (ref)
            Vignette.ImageTransparency = 0;
            shared.vfx.emit(u890);
            TweenService:Create(Vignette, TweenInfo.new(0.5), {
                ImageTransparency = 1
            }):Play();
        end);
        task.delay(21.283, function() -- Line: 13291
            -- upvalues: u890 (copy), u894 (copy)
            pcall(game.Destroy, u890);
            pcall(game.Destroy, u894);
        end);
    end;

    soundUtil:play(ReplicatedStorage.Resources.rin[Attribute and "evilscaryrin" or "scaryrin"], SoundService);
    u1.cutscene(u884, nil, 24.571, ReplicatedStorage.Resources.rin.rinBestFov);
    task.wait(24.571);
    v885:Destroy();
    v886:Destroy();
    u887:Destroy();
    v889:Destroy();

    if u883 and (u883:FindFirstChild("Torso") and u883.Torso:FindFirstChild("Bleeding")) then
        pcall(game.Destroy, u883.Torso.Bleeding);
    end;

    u1.sceneEnabled(false);
end;

function u1.nagicontrolawk(u895) -- Line: 13335
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), PlayerGui (copy), TweenService (copy), TekrinnDialogue (copy)
    local v896 = u895.HumanoidRootPart or u895.PrimaryPart;
    local _ = u895.Torso;
    local _ = Lighting.Atmosphere;
    u1.bright(-1, 0.15);
    local u897 = ReplicatedStorage.Resources.nagi.goalEffects:Clone();
    u897:PivotTo(v896.CFrame);
    u897.Parent = u895;

    if Util.canshiftcolor(LocalPlayer, u895) then
        vfxUtil.LeanTowardsColor(u897, u895:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u895:GetAttribute("CustomAlpha") or 0.985);
    end;

    local v898 = ReplicatedStorage.Resources.darkscreen:Clone();
    v898.Parent = PlayerGui;
    u1.sceneEnabled(true);
    task.delay(5.3, function() -- Line: 13355
        -- upvalues: u897 (copy)
        for _, descendant in ipairs(u897.hit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local v899 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v899.Parent = Lighting;
    v899.FarIntensity = 0;
    TweenService:Create(v899, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    u1.cutscene(v896, CFrame.new(Vector3.new(0, 0, 0)), 6.033333333333333, ReplicatedStorage.Resources.nagi["4FOV"]);
    task.delay(0.01, function() -- Line: 13374
        -- upvalues: TekrinnDialogue (ref), u895 (copy)
        TekrinnDialogue.Speak(u895, {
            {
                Text = "This curiosity of mine can\'t be stopped.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2.667
                }
            }
        }, 2.667);
    end);
    task.delay(2.667, function() -- Line: 13400
        -- upvalues: TekrinnDialogue (ref), u895 (copy)
        TekrinnDialogue.Speak(u895, {
            {
                Text = "With soccer...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 1.9
                }
            }
        }, 1.9);
    end);
    task.delay(4.333, function() -- Line: 13426
        -- upvalues: TekrinnDialogue (ref), u895 (copy)
        TekrinnDialogue.Speak(u895, {
            {
                Text = "I want to challenge myself!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(201, 206, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 1.9
                }
            }
        }, 1.9);
    end);
    task.wait(6.033333333333333);
    u897:Destroy();
    v899:Destroy();
    v898:Destroy();
    u1.ultFlash();
    u1.sceneEnabled(false);
    u1.fov(false, 15);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.twogun(u900) -- Line: 13465
    -- upvalues: Lighting (copy), u1 (copy), TekrinnDialogue (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy)
    local v901 = u900.HumanoidRootPart or u900.PrimaryPart;
    local _ = u900.Torso;
    local _ = Lighting.Atmosphere;
    u1.bright(-1, 0.15);
    task.delay(0.05, function() -- Line: 13474
        -- upvalues: TekrinnDialogue (ref), u900 (copy)
        TekrinnDialogue.Speak(u900, {
            {
                Text = "I\'m... a striker.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1.5
                }
            }
        }, 1.5);
    end);
    local u902 = ReplicatedStorage.Resources.isagi.allGunEffect:Clone();
    u902:PivotTo(v901.CFrame);
    u902.Parent = u900;

    if Util.canshiftcolor(LocalPlayer, u900) then
        vfxUtil.LeanTowardsColor(u902, u900:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u900:GetAttribute("CustomAlpha") or 0.985);
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    task.delay(0.3666666666666667, function() -- Line: 13511
        -- upvalues: u902 (copy)
        for _, descendant in ipairs(u902.slam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.9, function() -- Line: 13520
        -- upvalues: u902 (copy), TweenService (ref)
        u902.footya.Decal.Transparency = 0;
        TweenService:Create(u902.footya, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = u902.footya.CFrame * CFrame.Angles(0, 0, 2.0943951023931953)
        }):Play();
        TweenService:Create(u902.footya.Decal, TweenInfo.new(1.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end);
    task.delay(2.2, function() -- Line: 13538
        -- upvalues: ReplicatedStorage (ref), u900 (copy)
        local v903 = ReplicatedStorage.Resources.shidou.line:Clone();
        v903.Parent = u900["Right Leg"];
        task.delay(0.5, v903.Destroy, v903);
    end);
    task.delay(2.766666666666667, function() -- Line: 13545
        -- upvalues: u902 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        for _, descendant in ipairs(u902.hit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u902.End.Decal.Transparency = 0.95;
        u902.End.Mesh.Scale = Vector3.new(0.1, 0.15, 0.15);
        TweenService:Create(u902.End.Mesh, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(0.8, 0.2, 0.2)
        }):Play();
        TweenService:Create(u902.End, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = u902.End.CFrame * CFrame.Angles(1.0471975511965976, 0, 0)
        }):Play();
        TweenService:Create(u902.End.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        ColorCorrectionEffect.Contrast = -15;
        task.wait(0.03);
        ColorCorrectionEffect.Contrast = 15;
        task.wait(0.03);
        ColorCorrectionEffect.Contrast = 5;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.65), {
            Contrast = 0
        }):Play();
    end);
    local v904 = ReplicatedStorage.Resources.darkscreen:Clone();
    v904.Parent = PlayerGui;
    u1.sceneEnabled(true);
    local v905 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v905.Parent = Lighting;
    v905.FarIntensity = 0;
    TweenService:Create(v905, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.isagi.isagitwogunvolley_1, SoundService);
    u1.cutscene(v901, CFrame.new(Vector3.new(0, 0, 0)), 3.816666666666667, ReplicatedStorage.Resources.isagi["2FOV"]);
    local v906 = ReplicatedStorage.Resources.isagi.Gun1:Clone();
    v906.Parent = u900;
    v906.Gun1.Part0 = v901;
    local v907 = ReplicatedStorage.Resources.isagi.Gun2:Clone();
    v907.Parent = u900;
    v907.Gun2.Part0 = v901;
    task.wait(3.816666666666667);
    v905:Destroy();
    v904:Destroy();
    v906:Destroy();
    v907:Destroy();
    u1.ultFlash();
    u1.sceneEnabled(false);
    u1.fov(false, 15);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function u1.NEWtwogun(u908) -- Line: 13626
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy)
    local Ball = u908:FindFirstChild("Ball");
    local v909 = u908.HumanoidRootPart or u908.PrimaryPart;
    local _ = u908.Torso;
    local _ = Lighting.Atmosphere;
    u1.bright(-1, 0.15);
    local u910 = ReplicatedStorage.Resources.isagi.NEWtwogunvolleyEff:Clone();
    u910:PivotTo(v909.CFrame);
    u910.Parent = u908;

    if Util.canshiftcolor(LocalPlayer, u908) then
        vfxUtil.LeanTowardsColor(u910, u908:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u908:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u910:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local v911 = ReplicatedStorage.Resources.isagi.guneyehead:Clone();
    v911.Weld.Part0 = u908.Head;
    v911.Parent = u910;
    local u912;

    if Ball then
        u912 = ReplicatedStorage.Resources.isagi.ballEff:Clone();
        u912.Weld.Part0 = Ball;
        u912.Parent = u910;

        for _, descendant in ipairs(u912:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    else
        u912 = nil;
    end;

    local u913 = ReplicatedStorage.Resources.isagi.camEffGun:Clone();
    u913.Parent = u910;
    local u914 = nil;
    u914 = RunService.PreRender:connect(function() -- Line: 13677
        -- upvalues: u913 (copy), u914 (ref)
        if u913:IsDescendantOf(game) then
            u913.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u914:Disconnect();
    end);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    u1.sceneEnabled(true);
    local v915 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v915.Parent = Lighting;
    v915.FarIntensity = 0;
    TweenService:Create(v915, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local v916 = soundUtil:play(ReplicatedStorage.Resources.isagi.twogunvolley, SoundService, {
        Character = u908
    });
    u1.cutsceneBlender(v909, ReplicatedStorage.Resources.isagi.NEWtwogunC, ReplicatedStorage.Resources.isagi.NEWTGVFOV);

    if v916.Name == "Dub" then
        task.delay(0.15, function() -- Line: 13705
            -- upvalues: TekrinnDialogue (ref), u908 (copy)
            TekrinnDialogue.Speak(u908, {
                {
                    Text = "All of my senses...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(2.05, function() -- Line: 13731
            -- upvalues: TekrinnDialogue (ref), u908 (copy)
            TekrinnDialogue.Speak(u908, {
                {
                    Text = "In this moment, and react!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    }
                }
            }, 5.5);
        end);
    else
        task.delay(0.15, function() -- Line: 13758
            -- upvalues: TekrinnDialogue (ref), u908 (copy)
            TekrinnDialogue.Speak(u908, {
                {
                    Text = "All of my sense...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(2.05, function() -- Line: 13784
            -- upvalues: TekrinnDialogue (ref), u908 (copy)
            TekrinnDialogue.Speak(u908, {
                {
                    Text = "In this moment, I\'ll pour all of it into my reflexes!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    }
                }
            }, 5.5);
        end);
    end;

    local u917 = ReplicatedStorage.Resources.isagi.LeftGun:Clone();
    u917.HandleLeft.HandleLeft.Part0 = v909;
    u917.HandleLeft.bullet1.Part0 = v909;
    u917.Parent = u908;
    local u918 = ReplicatedStorage.Resources.isagi.RightGun:Clone();
    u918.HandleRight.HandleRight.Part0 = v909;
    u918.HandleRight.bullet2.Part0 = v909;
    u918.Parent = u908;
    task.delay(0.7, function() -- Line: 13822
        -- upvalues: u913 (copy)
        u913[1].Enabled = true;
        u913[2].Enabled = true;
        u913[3].Enabled = true;
    end);
    task.delay(1.033, function() -- Line: 13828
        -- upvalues: u913 (copy)
        u913[1].Enabled = false;
        u913[2].Enabled = false;
        u913[3].Enabled = false;
    end);
    task.delay(1.383, function() -- Line: 13834
        -- upvalues: u910 (copy)
        for _, descendant in ipairs(u910.grass:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.067, function() -- Line: 13843
        -- upvalues: u912 (ref)
        if not u912 then
            return;
        end;

        for _, descendant in ipairs(u912.ballspin:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u912.ballspinglow1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u912.ballspinglow2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.967, function() -- Line: 13870
        -- upvalues: u913 (copy)
        u913[4].Enabled = true;
        u913[5].Enabled = true;
        u913[6].Enabled = true;
        u913[7].Enabled = true;
    end);
    task.delay(3.6, function() -- Line: 13876
        -- upvalues: u913 (copy), u910 (copy), TweenService (ref), u917 (copy), u918 (copy), ColorCorrectionEffect (copy)
        u913[4].Enabled = false;
        u913[5].Enabled = false;
        u913[6].Enabled = false;
        u913[7].Enabled = false;

        for _, descendant in ipairs(u910.FLARE1.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u910.windbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                descendant.TextureSpeed = 9;
                TweenService:Create(descendant, TweenInfo.new(1.184, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    TextureSpeed = 0.1
                }):Play();
            end;
        end;

        for _, descendant in ipairs(u910.LASTPARTICLES:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u917.bullet1["Diagonal Smoke Burst"].Enabled = true;
        u918.bullet2["Diagonal Smoke Burst"].Enabled = true;

        for _, descendant in ipairs(u917.Barrel:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u918.Barrel:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        ColorCorrectionEffect.Saturation = -1;

        for i = 1, 4 do
            ColorCorrectionEffect.Contrast = ColorCorrectionEffect.Contrast == 15 and -15 or 15;
            task.wait(0.017);
            local _ = i;
        end;

        ColorCorrectionEffect.Brightness = 0.4;
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Saturation = 0;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.733, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0
        }):Play();
    end);
    local u919 = {};
    task.delay(4.287, function() -- Line: 13950
        -- upvalues: u910 (copy), u917 (copy), u918 (copy), TweenService (ref), u919 (copy), ColorCorrectionEffect (copy)
        for _, descendant in ipairs(u910["TWIN-GUN"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u910.LASTPARTICLES:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u917.Barrel:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u918.Barrel:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u910.FLARE1.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u910.FLARE1.Attachment2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u910.windbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u910.lastwindbeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                descendant.TextureSpeed = 9;
                TweenService:Create(descendant, TweenInfo.new(1.184, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    TextureSpeed = 0.1
                }):Play();
            end;
        end;

        for _, descendant in ipairs(u910.lastwindbeams2:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                descendant.TextureSpeed = 9;
                TweenService:Create(descendant, TweenInfo.new(1.184, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    TextureSpeed = 0.1
                }):Play();
            end;
        end;

        for _, v in u919 do
            TweenService:Create(v, TweenInfo.new(1.184, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                TimeScale = 0.15
            }):Play();
        end;

        ColorCorrectionEffect.Saturation = -1;

        for i = 1, 4 do
            ColorCorrectionEffect.Contrast = ColorCorrectionEffect.Contrast == 15 and -15 or 15;
            task.wait(0.017);
            local _ = i;
        end;

        ColorCorrectionEffect.Brightness = 0.4;
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Saturation = 0;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.733, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0
        }):Play();
    end);
    task.delay(4.55, function() -- Line: 14058
        -- upvalues: u910 (copy)
        for _, descendant in ipairs(u910.VOLLEY:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.983, function() -- Line: 14067
        -- upvalues: u908 (copy), ReplicatedStorage (ref), u919 (copy), u910 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        for _, child in ipairs(u908:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v920 = ReplicatedStorage.Resources.isagi["Dark Shadow Fire1"]:Clone();
                v920.Parent = child;
                table.insert(u919, v920);
            end;
        end;

        local v921 = ReplicatedStorage.Resources.isagi.twogunTrail:Clone();
        v921.Weld.Part0 = u908["Left Leg"];
        v921.Parent = u910;
        task.delay(1, v921.Destroy, v921);
        ColorCorrectionEffect.Saturation = -1;

        for i = 1, 4 do
            ColorCorrectionEffect.Contrast = ColorCorrectionEffect.Contrast == 15 and -15 or 15;
            task.wait(0.017);
            local _ = i;
        end;

        ColorCorrectionEffect.Brightness = 0.4;
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Saturation = 0;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.733, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0
        }):Play();
    end);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.wait(5.733);
    ScreenDimmer:Destroy();
    v915:Destroy();
    u910:Destroy();
    ColorCorrectionEffect:Destroy();
    u917:Destroy();
    u918:Destroy();
    u1.ultFlash();
    u1.sceneEnabled(false);
    u1.fov(false, 15);
    u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

    for _, v in u919 do
        v:Destroy();
    end;

    table.clear(u919);
end;

function u1.saeAwkold(u922) -- Line: 14129
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), PlayerGui (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), RunService (copy), Density (copy), Color (copy), Brightness (copy)
    local v923 = u922.HumanoidRootPart or u922.PrimaryPart;
    local _ = u922.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.bright(-1, 0.55);
    u1.sceneEnabled(true);
    local u924 = ReplicatedStorage.Resources.Blur:Clone();
    u924.Size = 0;
    u924.Parent = Lighting;
    local v925 = ReplicatedStorage.Resources.sae.glowscreen:Clone();
    v925.Parent = PlayerGui;
    local ImageLabel2 = v925.ImageLabel2;
    ImageLabel2.ImageTransparency = 0;
    local u926 = ReplicatedStorage.Resources.sae.newsaeawkya.effectawk:Clone();
    u926:PivotTo(v923.CFrame);
    u926.Parent = u922;

    if Util.canshiftcolor(LocalPlayer, u922) then
        vfxUtil.LeanTowardsColor(u926, u922:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u922:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u926:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u927 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u927.Parent = Lighting;
    u927.FarIntensity = 0;
    TweenService:Create(u927, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    soundUtil:play(ReplicatedStorage.Resources.sae["Itoshi lock in"], SoundService);
    u1.cutscene(v923, CFrame.new(Vector3.new(0, 0, 0)), 10.55, ReplicatedStorage.Resources.sae.FOV);
    local v928 = ReplicatedStorage.Resources.sae.newsaeawkya.eyesangle:Clone();
    v928.Weld.Part0 = u922.Head;
    v928.Parent = u926;

    for _, descendant in ipairs(u926.CAMERAPARTstart:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(1.75, function() -- Line: 14190
        -- upvalues: TekrinnDialogue (ref), u922 (copy)
        TekrinnDialogue.Speak(u922, {
            {
                Text = "I\'m taking this game to the next level.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 4);
    end);
    task.delay(4.883, function() -- Line: 14216
        -- upvalues: TekrinnDialogue (ref), u922 (copy)
        TekrinnDialogue.Speak(u922, {
            {
                Text = "Only the",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            },
            {
                Text = " idiots",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(253, 255, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 74, 116)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            },
            {
                Text = " who can keep up with me.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 4);
    end);
    task.delay(8.767, function() -- Line: 14284
        -- upvalues: TekrinnDialogue (ref), u922 (copy)
        TekrinnDialogue.Speak(u922, {
            {
                Text = "will get to see what comes next.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 73, 112)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 1.35
                }
            }
        }, 1.35);
    end);
    task.delay(0.55, function() -- Line: 14313
        -- upvalues: ImageLabel2 (copy), u926 (copy)
        ImageLabel2.ImageTransparency = 1;
        u926.CAMERAPARTstart:Destroy();
    end);
    task.delay(0.667, function() -- Line: 14319
        -- upvalues: u926 (copy)
        for _, descendant in ipairs(u926.step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.933, function() -- Line: 14327
        -- upvalues: u926 (copy)
        for _, descendant in ipairs(u926.step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.05, function() -- Line: 14335
        -- upvalues: u926 (copy)
        for _, descendant in ipairs(u926.step3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.183, function() -- Line: 14343
        -- upvalues: u926 (copy)
        for _, descendant in ipairs(u926.step4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.517, function() -- Line: 14351
        -- upvalues: u924 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        u924.Size = 25;
        TweenService:Create(u924, TweenInfo.new(0.783, Enum.EasingStyle.Linear), {
            Size = 5
        }):Play();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 225, 241);
        ColorCorrectionEffect.Brightness = -1;
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Saturation = -0.8;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.516, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.466, Enum.EasingStyle.Linear), {
            Saturation = -0.4
        }):Play();
    end);
    task.delay(2.783, function() -- Line: 14364
        -- upvalues: TweenService (ref), u924 (copy)
        local v929 = TweenService:Create(u924, TweenInfo.new(0.084, Enum.EasingStyle.Linear), {
            Size = 25
        });
        v929:Play();
        v929.Completed:Wait();
        v929:Destroy();
        TweenService:Create(u924, TweenInfo.new(0.983, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);
    task.delay(2.817, function() -- Line: 14373
        -- upvalues: u926 (copy)
        for _, descendant in ipairs(u926.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    local u930 = {};
    task.delay(2.983, function() -- Line: 14383
        -- upvalues: TweenService (ref), Atmosphere (copy), Lighting (ref), ColorCorrectionEffect (copy), u922 (copy), ReplicatedStorage (ref), u930 (copy), u926 (copy), RunService (ref)
        TweenService:Create(Atmosphere, TweenInfo.new(0.334, Enum.EasingStyle.Linear), {
            Density = 0.315,
            Color = Color3.fromRGB(255, 106, 138)
        }):Play();
        TweenService:Create(Lighting, TweenInfo.new(0.334, Enum.EasingStyle.Linear), {
            Brightness = 3,
            ColorShift_Top = Color3.fromRGB(255, 82, 183)
        }):Play();
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.534, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 103, 174)
        }):Play();

        for _, child in ipairs(u922:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v931 = child;

                for _, child2 in ipairs(ReplicatedStorage.Resources.sae.auraya:GetChildren()) do
                    local v932 = child2:Clone();
                    v932.Parent = v931;
                    table.insert(u930, v932);
                end;
            end;
        end;

        for _, descendant in ipairs(u926.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u926.step6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    TimeScale = 0.05
                }):Play();
            end;
        end;

        local u933 = ReplicatedStorage.Resources.sae.newsaeawkya.CAMERAPART:Clone();
        u933.Parent = u926;

        for _, descendant in ipairs(u933:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        local u934 = nil;
        u934 = RunService.PreRender:connect(function() -- Line: 14444
            -- upvalues: u933 (copy), u934 (ref)
            if u933:IsDescendantOf(game) then
                u933.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.1) * CFrame.Angles(0, 0, -0.7853981633974483);

                return;
            end;

            u934:Disconnect();
        end);
    end);
    task.delay(3.05, function() -- Line: 14455
        -- upvalues: u926 (copy)
        for _, descendant in ipairs(u926.aira:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.283, function() -- Line: 14463
        -- upvalues: u924 (copy), TweenService (ref), ColorCorrectionEffect (copy), ImageLabel2 (copy), u926 (copy)
        u924.Size = 25;
        TweenService:Create(u924, TweenInfo.new(0.284, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 103, 174);
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.Saturation = -0.8;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Contrast = 1,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 103, 174)
        }):Play();
        ImageLabel2.ImageTransparency = 0.6;

        for _, descendant in ipairs(u926.aura1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u926.step6:Destroy();
    end);
    task.delay(8.6, function() -- Line: 14490
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref), ReplicatedStorage (ref), u922 (copy), u926 (copy), u924 (copy)
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
        local v935 = ReplicatedStorage.Resources.sae.newsaeawkya.eyeaura:Clone();
        v935.Weld.Part0 = u922.Head;
        v935.Parent = u926;

        for _, descendant in ipairs(u926.BeamDAD:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u924.Size = 25;
        TweenService:Create(u924, TweenInfo.new(0.767, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);
    task.delay(10.55, function() -- Line: 14508
        -- upvalues: u927 (copy), u926 (copy), ColorCorrectionEffect (copy), u930 (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), ImageLabel2 (copy), u1 (ref)
        u927:Destroy();
        u926:Destroy();
        ColorCorrectionEffect:Destroy();

        for _, v in u930 do
            v:Destroy();
        end;

        table.clear(u930);
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        ImageLabel2:Destroy();
        u1.ultFlash(-1, 0.7);
        u1.sceneEnabled(false);
        u1.fov(false, 30);
        u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function u1.goalsound(p936, p937) -- Line: 14535
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), TweenService (copy)
    local setting2 = LocalPlayer:FindFirstChild("setting");

    if setting2 and (setting2:FindFirstChild("otherGoalSounds") and (not setting2:FindFirstChild("otherGoalSounds").Value and p937 ~= LocalPlayer.Character)) then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = `rbxassetid://{p936}`;
    Sound.Parent = ReplicatedStorage.Resources;
    Sound.Name = `{p937.Name}'s Goal Sound`;
    local u938 = soundUtil:play(Sound, SoundService);
    Sound:Destroy();
    task.delay(7, function() -- Line: 14551
        -- upvalues: TweenService (ref), u938 (copy)
        TweenService:Create(u938, TweenInfo.new(1), {
            Volume = 0
        }):Play();
        task.delay(1, function() -- Line: 14553
            -- upvalues: u938 (ref)
            u938:Stop();
            u938:Destroy();
        end);
    end);
end;

function u1.dribblesound(p939, p940) -- Line: 14560
    -- upvalues: LocalPlayer (copy), soundUtil (copy)
    local setting2 = LocalPlayer:FindFirstChild("setting");

    if setting2 and (setting2:FindFirstChild("CustomDribbleSounds") and (setting2:FindFirstChild("CustomDribbleSounds").Value and p940 ~= LocalPlayer.Character)) then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.Volume = 0.5;
    Sound.SoundId = `rbxassetid://{p939}`;
    local v941;

    if p940 then
        v941 = p940:FindFirstChild("HumanoidRootPart");
    else
        v941 = p940;
    end;

    Sound.Parent = v941;
    Sound.Name = `{p940.Name}'s Dribble Sound`;

    if p940 then
        p940 = p940:FindFirstChild("HumanoidRootPart");
    end;

    local u942 = soundUtil:play(Sound, p940);
    task.delay(10, function() -- Line: 14575
        -- upvalues: u942 (copy)
        pcall(game.Destroy, u942);
    end);
end;

function u1.saeAwk2(u943) -- Line: 14580
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), RunService (copy), TekrinnDialogue (copy), Density (copy), Color (copy), Brightness (copy)
    local v944 = u943.HumanoidRootPart or u943.PrimaryPart;
    local _ = u943.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.bright(-1, 0.5);
    u1.sceneEnabled(true);
    local Model = Instance.new("Model");
    Model.Parent = u943;
    local u945 = {};

    for _, child in ipairs(u943:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v946 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.sae.auraya:GetChildren()) do
                local v947 = child2:Clone();
                v947.Parent = v946;
                table.insert(u945, v947);
            end;
        end;
    end;

    if Util.canshiftcolor(LocalPlayer, u943) then
        vfxUtil.LeanTowardsColor(Model, u943:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u943:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u948 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u948.Parent = Lighting;
    u948.FarIntensity = 0;
    TweenService:Create(u948, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    soundUtil:play(ReplicatedStorage.Resources.sae["one shot matchs"], SoundService);
    u1.cutsceneBlender(v944, ReplicatedStorage.Resources.sae.oneshotmatch2, ReplicatedStorage.Resources.sae.FOV3);
    local u949 = nil;
    task.delay(0.633, function() -- Line: 14630
        -- upvalues: ReplicatedStorage (ref), u943 (copy), Model (copy), u949 (ref), RunService (ref), Atmosphere (copy)
        local v950 = ReplicatedStorage.Resources.sae.eyesangle2:Clone();
        v950.Weld.Part0 = u943.Head;
        v950.Parent = Model;
        local v951 = ReplicatedStorage.Resources.sae.glowa:Clone();
        v951.Weld.Part0 = u943.Torso;
        v951.Parent = Model;
        u949 = ReplicatedStorage.Resources.sae.zoom:Clone();
        u949.Parent = Model;
        local u952 = nil;
        u952 = RunService.PreRender:connect(function() -- Line: 14643
            -- upvalues: u949 (ref), u952 (ref)
            if u949:IsDescendantOf(game) then
                u949.CFrame = workspace.CurrentCamera.CFrame;

                return;
            end;

            u952:Disconnect();
        end);

        for _, descendant in ipairs(u949:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        u949.Attachment.ParticleEmitterSoft.Enabled = true;
        Atmosphere.Color = Color3.fromRGB(98, 10, 57);
        Atmosphere.Density = 0.85;
    end);
    task.delay(3.217, function() -- Line: 14662
        -- upvalues: u949 (ref)
        u949.Attachment.ParticleEmitterRough.Enabled = true;
    end);
    task.delay(3.45, function() -- Line: 14666
        -- upvalues: TekrinnDialogue (ref), u943 (copy), u949 (ref), ReplicatedStorage (ref), Model (copy), RunService (ref)
        TekrinnDialogue.Speak(u943, {
            {
                Text = "This is a one-shot match.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 2);
        u949:Destroy();
        local u953 = ReplicatedStorage.Resources.sae.CamPart2:Clone();
        u953.Parent = Model;
        local u954 = nil;
        u954 = RunService.PreRender:connect(function() -- Line: 14697
            -- upvalues: u953 (copy), u954 (ref)
            if u953:IsDescendantOf(game) then
                u953.CFrame = workspace.CurrentCamera.CFrame;

                return;
            end;

            u954:Disconnect();
        end);
    end);
    task.delay(5.367, function() -- Line: 14706
        -- upvalues: u945 (copy), u948 (copy), Model (copy), ColorCorrectionEffect (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), u1 (ref)
        for _, v in u945 do
            v:Destroy();
        end;

        table.clear(u945);
        u948:Destroy();
        Model:Destroy();
        ColorCorrectionEffect:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        u1.ultFlash(-1);
        u1.sceneEnabled(false);
        u1.fov(false, 15);
        u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function u1.karmaText(p955) -- Line: 14731
    -- upvalues: soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), TekrinnDialogue (copy)
    soundUtil:play(ReplicatedStorage.Resources.karma.HOWDOYOULIKETHIS, SoundService);
    TekrinnDialogue.Speak(p955, {
        {
            Text = "HOW DO YOU LIKE THIS?!",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 1.3,
                Lifetime = 4
            }
        }
    }, 2.867);
end;

function u1.saenutmegold(u956) -- Line: 14758
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Density (copy), Color (copy), Brightness (copy)
    local v957 = u956.HumanoidRootPart or u956.PrimaryPart;
    local _ = u956.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    local u958 = ReplicatedStorage.Resources.sae.saeEffect:Clone();
    u958:PivotTo(v957.CFrame);
    u958.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, u956) then
        vfxUtil.LeanTowardsColor(u958, u956:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u956:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u959 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u959.Parent = Lighting;
    u959.FarIntensity = 0;
    TweenService:Create(u959, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    soundUtil:play(ReplicatedStorage.Resources.sae[`you'll never surpass me_{Random.new():NextInteger(1, 2)}`], SoundService);
    u1.cutscene(v957, CFrame.new(Vector3.new(0, 0, 0)), 10.43333333333333, ReplicatedStorage.Resources.sae.FOV2old);
    task.delay(0.8166666666666667, function() -- Line: 14785
        -- upvalues: u958 (copy)
        for _, descendant in ipairs(u958.hit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.216666666666667, function() -- Line: 14793
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect.Contrast = 0.35;
        ColorCorrectionEffect.Saturation = -0.3;
    end);
    task.delay(3.716666666666667, function() -- Line: 14798
        -- upvalues: u958 (copy)
        for _, descendant in ipairs(u958.hit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u960 = nil;
    task.delay(4.2, function() -- Line: 14807
        -- upvalues: u960 (ref), ReplicatedStorage (ref), u956 (copy), u958 (copy)
        u960 = ReplicatedStorage.Resources.sae.Head2:Clone();
        u960.Weld.Part0 = u956.Head;
        u960.Parent = workspace.Effects;

        for _, descendant in ipairs(u958.aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.183333333333334, function() -- Line: 14822
        -- upvalues: u960 (ref)
        u960:Destroy();
    end);
    task.delay(9.366666666666667, function() -- Line: 14826
        -- upvalues: u958 (copy)
        for _, descendant in ipairs(u958.hit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(10.43333333333333, function() -- Line: 14834
        -- upvalues: u959 (copy), u958 (copy), ColorCorrectionEffect (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), ReplicatedStorage (ref), TweenService (ref), u1 (ref)
        u959:Destroy();
        u958:Destroy();
        ColorCorrectionEffect:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        local v961 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v961.Parent = Lighting;
        v961.Brightness = 1;
        task.wait(0.2);
        TweenService:Create(v961, TweenInfo.new(1), {
            Brightness = 0
        }):Play();
        task.delay(1, v961.Destroy, v961);
        u1.sceneEnabled(false);
        u1.fov(false, 15);
        u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function u1.saenutmeg(u962) -- Line: 14861
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), PlayerGui (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), RunService (copy), Density (copy), Color (copy), Brightness (copy)
    local v963 = u962.HumanoidRootPart or u962.PrimaryPart;
    local _ = u962.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    local v964 = ReplicatedStorage.Resources.sae.glowscreen:Clone();
    v964.Parent = PlayerGui;
    local ImageLabel2 = v964.ImageLabel2;
    ImageLabel2.ImageTransparency = 0.3;
    local u965 = ReplicatedStorage.Resources.sae.allNEWSAE:Clone();
    u965:PivotTo(v963.CFrame);
    u965.Parent = u962;

    if Util.canshiftcolor(LocalPlayer, u962) then
        vfxUtil.LeanTowardsColor(u965, u962:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u962:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u966 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u966.Parent = Lighting;
    u966.FarIntensity = 0;
    TweenService:Create(u966, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    local Attribute = u962:GetAttribute("femlock");
    local v967;

    if Attribute then
        v967 = ReplicatedStorage.Resources.sae.Femvoicelines.elastico;
    else
        v967 = ReplicatedStorage.Resources.sae["you\'ll neversurpassme sae only_1"];
    end;

    local v968 = soundUtil:play(v967, SoundService, {
        Character = u962
    });
    u1.cutsceneBlender(v963, ReplicatedStorage.Resources.sae.nutmeg3, ReplicatedStorage.Resources.sae.FOV2);

    for _, descendant in ipairs(u965:GetDescendants()) do
        if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        elseif descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    u965.bgblack.Transparency = 0;

    if Attribute or v968.Name == "Dub" then
        task.delay(3.852, function() -- Line: 14912
            -- upvalues: TekrinnDialogue (ref), u962 (copy)
            TekrinnDialogue.Speak(u962, {
                {
                    Text = "You do realize...",
                    Bold = false,
                    Italic = false,
                    Pause = 1.031,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 2
                    }
                },
                {
                    Text = " if you keep acting like my little brother..",
                    Bold = false,
                    Italic = false,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 2
                    }
                }
            }, 3.3510000000000004);
        end);
        task.delay(11.442, function() -- Line: 14960
            -- upvalues: TekrinnDialogue (ref), u962 (copy)
            TekrinnDialogue.Speak(u962, {
                {
                    Text = "... you can\'t surpass me..",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(13.469, function() -- Line: 14986
            -- upvalues: TekrinnDialogue (ref), u962 (copy)
            TekrinnDialogue.Speak(u962, {
                {
                    Text = "... and never will.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 1.7100000000000009);
        end);
    else
        task.delay(3.983, function() -- Line: 15012
            -- upvalues: TekrinnDialogue (ref), u962 (copy)
            TekrinnDialogue.Speak(u962, {
                {
                    Text = "If you keep behaving like you\'re my little brother...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 2
                    }
                }
            }, 5);
        end);
        task.delay(11.483, function() -- Line: 15038
            -- upvalues: TekrinnDialogue (ref), u962 (copy)
            TekrinnDialogue.Speak(u962, {
                {
                    Text = "...you will never surpass me.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
    end;

    task.delay(1.083, function() -- Line: 15067
        -- upvalues: u965 (copy)
        for _, descendant in ipairs(u965.att1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.083, function() -- Line: 15075
        -- upvalues: u965 (copy)
        for _, descendant in ipairs(u965.att1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u969 = nil;
    task.delay(1.283, function() -- Line: 15085
        -- upvalues: ImageLabel2 (copy), u969 (ref), ReplicatedStorage (ref), u962 (copy), u965 (copy)
        ImageLabel2.ImageTransparency = 1;
        u969 = ReplicatedStorage.Resources.sae.ratrail:Clone();
        u969.Weld.Part0 = u962["Right Arm"];
        u969.Parent = u965;
        u965.bgblack.Transparency = 1;

        for _, descendant in ipairs(u965.LOM:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.1, function() -- Line: 15101
        -- upvalues: ImageLabel2 (copy), u969 (ref)
        ImageLabel2.ImageTransparency = 0.3;
        u969:Destroy();
    end);
    task.delay(6.117, function() -- Line: 15107
        -- upvalues: ImageLabel2 (copy)
        ImageLabel2.ImageTransparency = 1;
    end);
    local u970 = nil;
    task.delay(7.467, function() -- Line: 15113
        -- upvalues: u965 (copy), ImageLabel2 (copy), u970 (ref), ReplicatedStorage (ref), RunService (ref), ColorCorrectionEffect (copy), TweenService (ref)
        u965.redBG.Transparency = 0;
        ImageLabel2.ImageTransparency = 0;
        u970 = ReplicatedStorage.Resources.sae.zoom:Clone();
        u970.Parent = u965;

        for _, descendant in ipairs(u970:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        local u971 = nil;
        u971 = RunService.PreRender:connect(function() -- Line: 15127
            -- upvalues: u970 (ref), u971 (ref)
            if u970:IsDescendantOf(game) then
                u970.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.2);

                return;
            end;

            u971:Disconnect();
        end);
        ColorCorrectionEffect.Brightness = -1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.283, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    local u972 = nil;
    task.delay(8.267, function() -- Line: 15141
        -- upvalues: ColorCorrectionEffect (copy), u972 (ref), TweenService (ref)
        ColorCorrectionEffect.Brightness = 0;
        u972 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            Brightness = -1
        });
        u972:Play();
    end);
    local u973 = nil;
    task.delay(8.483, function() -- Line: 15149
        -- upvalues: u972 (ref), ColorCorrectionEffect (copy), u965 (copy), ImageLabel2 (copy), u970 (ref), u973 (ref), ReplicatedStorage (ref), RunService (ref)
        if u972 then
            u972:Cancel();
            u972:Destroy();
        end;

        ColorCorrectionEffect.Brightness = 0;
        u965.redBG.Transparency = 1;
        ImageLabel2.ImageTransparency = 1;

        for _, descendant in ipairs(u970:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        u973 = ReplicatedStorage.Resources.sae.CAMERAPART:Clone();
        u973.Parent = u965;
        local u974 = nil;
        u974 = RunService.PreRender:connect(function() -- Line: 15169
            -- upvalues: u973 (ref), u974 (ref)
            if u973:IsDescendantOf(game) then
                u973.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 0, -1.3962634015954636);

                return;
            end;

            u974:Disconnect();
        end);
    end);
    task.delay(8.567, function() -- Line: 15178
        -- upvalues: u965 (copy)
        for _, descendant in ipairs(u965.step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.783, function() -- Line: 15186
        -- upvalues: u965 (copy)
        for _, descendant in ipairs(u965.step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.983, function() -- Line: 15194
        -- upvalues: u965 (copy)
        for _, descendant in ipairs(u965.kick1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(9.383, function() -- Line: 15202
        -- upvalues: u965 (copy)
        for _, descendant in ipairs(u965.step3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u975 = nil;
    task.delay(10.333, function() -- Line: 15212
        -- upvalues: u973 (ref), ImageLabel2 (copy), u975 (ref), ReplicatedStorage (ref), u962 (copy), u965 (copy), u970 (ref)
        if u973 then
            u973:Destroy();
        end;

        ImageLabel2.ImageTransparency = 0.3;
        u975 = ReplicatedStorage.Resources.sae.eyesangle:Clone();
        u975.Weld.Part0 = u962.Head;
        u975.Parent = u965;

        for _, descendant in ipairs(u970:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u965.step4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u965.pass:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u965.EW:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(10.4, function() -- Line: 15248
        -- upvalues: u965 (copy)
        for _, descendant in pairs(u965.LOM:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(11.45, function() -- Line: 15257
        -- upvalues: ImageLabel2 (copy), u975 (ref), u965 (copy)
        ImageLabel2.ImageTransparency = 1;

        if u975 then
            u975:Destroy();
        end;

        for _, descendant in ipairs(u965.EW:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u965.zoom:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u965.pass:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    local u976 = nil;
    task.delay(13.583, function() -- Line: 15285
        -- upvalues: u976 (ref), ReplicatedStorage (ref), u965 (copy), RunService (ref)
        u976 = ReplicatedStorage.Resources.sae.CAMERAPART2:Clone();
        u976.Parent = u965;
        local u977 = nil;
        u977 = RunService.PreRender:connect(function() -- Line: 15290
            -- upvalues: u976 (ref), u977 (ref)
            if u976:IsDescendantOf(game) then
                u976.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2.5) * CFrame.Angles(0, 0, -1.3089969389957472);

                return;
            end;

            u977:Disconnect();
        end);
    end);
    task.delay(15.317, function() -- Line: 15301
        -- upvalues: u1 (ref), u965 (copy)
        u1.bright(0.3, 0.3);

        for _, descendant in ipairs(u965.charw:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u965.spinbeam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u965.step5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(15.733, function() -- Line: 15323
        -- upvalues: u1 (ref), u976 (ref), ReplicatedStorage (ref), u965 (copy), RunService (ref), TweenService (ref)
        u1.bright(0.8, 0.6);

        if u976 then
            u976:Destroy();
        end;

        local u978 = ReplicatedStorage.Resources.sae.CAMERAPART2:Clone();
        u978.Parent = u965;
        local u979 = nil;
        u979 = RunService.PreRender:connect(function() -- Line: 15334
            -- upvalues: u978 (copy), u979 (ref)
            if u978:IsDescendantOf(game) then
                u978.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 0, 1.3962634015954636);

                return;
            end;

            u979:Disconnect();
        end);

        for _, descendant in ipairs(u965.swing:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u965.step6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 1;
                TweenService:Create(descendant, TweenInfo.new(1), {
                    TimeScale = 0
                }):Play();
            end;
        end;

        for _, descendant in ipairs(u965.charw:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u965.spinbeam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(16.917, function() -- Line: 15421
        -- upvalues: u966 (copy), u965 (copy), ColorCorrectionEffect (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), u1 (ref)
        u966:Destroy();
        u965:Destroy();
        ColorCorrectionEffect:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        u1.ultFlash();
        u1.sceneEnabled(false);
        u1.fov(false, 15);
        u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function u1.rvs(u980, u981) -- Line: 15441
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), PlayerGui (copy), Density (copy), Color (copy), Brightness (copy)
    local v982 = u980.HumanoidRootPart or u980.PrimaryPart;
    local _ = u980.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    local u983 = ReplicatedStorage.Resources.sae.allNEWSAEvsrin:Clone();
    u983:PivotTo(v982.CFrame);
    u983.Parent = u980;

    if Util.canshiftcolor(LocalPlayer, u980) then
        vfxUtil.LeanTowardsColor(u983, u980:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u980:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u983:GetDescendants()) do
        if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        elseif descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    local u984 = ReplicatedStorage.Resources.sae.CAMERAPART:Clone();
    u984.Parent = u983;
    local u985 = nil;
    u985 = RunService.PreRender:connect(function() -- Line: 15468
        -- upvalues: u984 (copy), u985 (ref)
        if u984:IsDescendantOf(game) then
            u984.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 0, -1.3962634015954636);

            return;
        end;

        u985:Disconnect();
    end);
    local u986 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u986.Parent = Lighting;
    u986.FarIntensity = 0;
    TweenService:Create(u986, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    local Attribute = u980:GetAttribute("femlock");
    local v987;

    if Attribute then
        v987 = ReplicatedStorage.Resources.sae.Femvoicelines.elasticorin;
    else
        v987 = ReplicatedStorage.Resources.sae.saevsrinya;
    end;

    local v988 = soundUtil:play(v987, SoundService, {
        Character = u980
    });
    u1.cutsceneBlender(v982, ReplicatedStorage.Resources.sae.rvs3, ReplicatedStorage.Resources.sae.rvsFOV);

    if Attribute or v988.Name == "Dub" then
        task.delay(0.715, function() -- Line: 15493
            -- upvalues: TekrinnDialogue (ref), u981 (copy)
            TekrinnDialogue.Speak(u981, {
                {
                    Text = "Same goes for all of you!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(2.544, function() -- Line: 15519
            -- upvalues: TekrinnDialogue (ref), u981 (copy)
            TekrinnDialogue.Speak(u981, {
                {
                    Text = "This is between me and my brother!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
    else
        task.delay(0.867, function() -- Line: 15545
            -- upvalues: TekrinnDialogue (ref), u981 (copy)
            TekrinnDialogue.Speak(u981, {
                {
                    Text = "Get lost, outsiders.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(2.5, function() -- Line: 15571
            -- upvalues: TekrinnDialogue (ref), u981 (copy)
            TekrinnDialogue.Speak(u981, {
                {
                    Text = "We\'re in the middle of a sibling fight!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
    end;

    task.delay(0.233, function() -- Line: 15598
        -- upvalues: u983 (copy)
        for _, descendant in pairs(u983.Stap:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.233, function() -- Line: 15607
        -- upvalues: u983 (copy)
        for _, descendant in pairs(u983.Stap:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.65, function() -- Line: 15616
        -- upvalues: u983 (copy)
        for _, descendant in pairs(u983.rinunique_grasstep1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.4, function() -- Line: 15625
        -- upvalues: u983 (copy)
        for _, descendant in pairs(u983.rinunique_grasstep2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u989 = {};
    local u990 = {};
    task.delay(5.517, function() -- Line: 15636
        -- upvalues: u980 (copy), ReplicatedStorage (ref), u989 (copy), u983 (copy)
        for _, child in ipairs(u980:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v991 = child;

                for _, child2 in ipairs(ReplicatedStorage.Resources.sae.rinvssaeaura:GetChildren()) do
                    local v992 = child2:Clone();
                    v992.Enabled = true;
                    v992.Parent = v991;
                    table.insert(u989, v992);
                end;
            end;
        end;

        for _, descendant in pairs(u983.rinunique_grasstep3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(6.003, function() -- Line: 15657
        -- upvalues: u981 (copy), ReplicatedStorage (ref), u990 (copy)
        for _, child in ipairs(u981:GetChildren()) do
            if child:IsA("Part") and child.Transparency < 1 then
                local v993 = child;

                for _, child2 in ipairs(ReplicatedStorage.Resources.sae.rinvssaeaurarin:GetChildren()) do
                    local v994 = child2:Clone();
                    v994.Enabled = true;
                    v994.Parent = v993;
                    table.insert(u990, v994);
                end;
            end;
        end;
    end);
    task.delay(6.65, function() -- Line: 15671
        -- upvalues: u989 (copy), u983 (copy), u984 (copy)
        for _, v in u989 do
            v:Destroy();
        end;

        table.clear(u989);

        for _, descendant in pairs(u983.Stap2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u984:Destroy();
    end);
    task.wait(8.35);

    for _, v in u990 do
        v:Destroy();
    end;

    table.clear(u990);
    local v995 = ReplicatedStorage.Resources.sae.glowscreen:Clone();
    v995.Parent = PlayerGui;
    local ImageLabel2 = v995.ImageLabel2;
    ImageLabel2.ImageTransparency = 1;
    TweenService:Create(u983.bgblack, TweenInfo.new(0.3), {
        Transparency = 0
    }):Play();
    TweenService:Create(ImageLabel2, TweenInfo.new(0.3), {
        ImageTransparency = 0.3
    }):Play();

    if Attribute or v988.Name == "Dub" then
        task.delay(3.852, function() -- Line: 15708
            -- upvalues: TekrinnDialogue (ref), u980 (copy)
            TekrinnDialogue.Speak(u980, {
                {
                    Text = "You do realize...",
                    Bold = false,
                    Italic = false,
                    Pause = 1.031,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 2
                    }
                },
                {
                    Text = " if you keep acting like my little brother..",
                    Bold = false,
                    Italic = false,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 2
                    }
                }
            }, 3.3510000000000004);
        end);
        task.delay(11.442, function() -- Line: 15756
            -- upvalues: TekrinnDialogue (ref), u980 (copy)
            TekrinnDialogue.Speak(u980, {
                {
                    Text = "... you can\'t surpass me..",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
        task.delay(13.469, function() -- Line: 15782
            -- upvalues: TekrinnDialogue (ref), u980 (copy)
            TekrinnDialogue.Speak(u980, {
                {
                    Text = "... and never will.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 1.7100000000000009);
        end);
    else
        task.delay(3.983, function() -- Line: 15808
            -- upvalues: TekrinnDialogue (ref), u980 (copy)
            TekrinnDialogue.Speak(u980, {
                {
                    Text = "If you keep behaving like you\'re my little brother...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.3,
                        Lifetime = 2
                    }
                }
            }, 5);
        end);
        task.delay(11.483, function() -- Line: 15834
            -- upvalues: TekrinnDialogue (ref), u980 (copy)
            TekrinnDialogue.Speak(u980, {
                {
                    Text = "...you will never surpass me.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 73, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
    end;

    task.delay(1.083, function() -- Line: 15863
        -- upvalues: u983 (copy)
        for _, descendant in ipairs(u983.att1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.083, function() -- Line: 15871
        -- upvalues: u983 (copy)
        for _, descendant in ipairs(u983.att1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u996 = nil;
    task.delay(1.283, function() -- Line: 15881
        -- upvalues: ImageLabel2 (copy), u996 (ref), ReplicatedStorage (ref), u980 (copy), u983 (copy)
        ImageLabel2.ImageTransparency = 1;
        u996 = ReplicatedStorage.Resources.sae.ratrail:Clone();
        u996.Weld.Part0 = u980["Right Arm"];
        u996.Parent = u983;
        u983.bgblack.Transparency = 1;

        for _, descendant in ipairs(u983.LOM:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.1, function() -- Line: 15897
        -- upvalues: ImageLabel2 (copy), u996 (ref)
        ImageLabel2.ImageTransparency = 0.3;
        u996:Destroy();
    end);
    task.delay(6.117, function() -- Line: 15903
        -- upvalues: ImageLabel2 (copy)
        ImageLabel2.ImageTransparency = 1;
    end);
    local u997 = nil;
    task.delay(7.467, function() -- Line: 15909
        -- upvalues: u983 (copy), ImageLabel2 (copy), u997 (ref), ReplicatedStorage (ref), RunService (ref), ColorCorrectionEffect (copy), TweenService (ref)
        u983.redBG.Transparency = 0;
        ImageLabel2.ImageTransparency = 0;
        u997 = ReplicatedStorage.Resources.sae.zoom:Clone();
        u997.Parent = u983;

        for _, descendant in ipairs(u997:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        local u998 = nil;
        u998 = RunService.PreRender:connect(function() -- Line: 15923
            -- upvalues: u997 (ref), u998 (ref)
            if u997:IsDescendantOf(game) then
                u997.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.2);

                return;
            end;

            u998:Disconnect();
        end);
        ColorCorrectionEffect.Brightness = -1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.283, Enum.EasingStyle.Linear), {
            Brightness = 0
        }):Play();
    end);
    local u999 = nil;
    task.delay(8.267, function() -- Line: 15937
        -- upvalues: ColorCorrectionEffect (copy), u999 (ref), TweenService (ref)
        ColorCorrectionEffect.Brightness = 0;
        u999 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            Brightness = -1
        });
        u999:Play();
    end);
    local u1000 = nil;
    task.delay(8.483, function() -- Line: 15945
        -- upvalues: u999 (ref), ColorCorrectionEffect (copy), u983 (copy), ImageLabel2 (copy), u997 (ref), u1000 (ref), ReplicatedStorage (ref), RunService (ref)
        if u999 then
            u999:Cancel();
            u999:Destroy();
        end;

        ColorCorrectionEffect.Brightness = 0;
        u983.redBG.Transparency = 1;
        ImageLabel2.ImageTransparency = 1;

        for _, descendant in ipairs(u997:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        u1000 = ReplicatedStorage.Resources.sae.CAMERAPART:Clone();
        u1000.Parent = u983;
        local u1001 = nil;
        u1001 = RunService.PreRender:connect(function() -- Line: 15965
            -- upvalues: u1000 (ref), u1001 (ref)
            if u1000:IsDescendantOf(game) then
                u1000.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 0, -1.3962634015954636);

                return;
            end;

            u1001:Disconnect();
        end);
    end);
    task.delay(8.567, function() -- Line: 15974
        -- upvalues: u983 (copy)
        for _, descendant in ipairs(u983.step1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.783, function() -- Line: 15982
        -- upvalues: u983 (copy)
        for _, descendant in ipairs(u983.step2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.983, function() -- Line: 15990
        -- upvalues: u983 (copy)
        for _, descendant in ipairs(u983.kick1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(9.383, function() -- Line: 15998
        -- upvalues: u983 (copy)
        for _, descendant in ipairs(u983.step3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u1002 = nil;
    task.delay(10.333, function() -- Line: 16008
        -- upvalues: u1000 (ref), ImageLabel2 (copy), u1002 (ref), ReplicatedStorage (ref), u980 (copy), u983 (copy), u997 (ref)
        if u1000 then
            u1000:Destroy();
        end;

        ImageLabel2.ImageTransparency = 0.3;
        u1002 = ReplicatedStorage.Resources.sae.eyesangle:Clone();
        u1002.Weld.Part0 = u980.Head;
        u1002.Parent = u983;

        for _, descendant in ipairs(u997:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u983.step4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u983.pass:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u983.EW:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(10.4, function() -- Line: 16044
        -- upvalues: u983 (copy)
        for _, descendant in pairs(u983.LOM:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(11.45, function() -- Line: 16053
        -- upvalues: ImageLabel2 (copy), u1002 (ref), u983 (copy)
        ImageLabel2.ImageTransparency = 1;

        if u1002 then
            u1002:Destroy();
        end;

        for _, descendant in ipairs(u983.EW:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u983.zoom:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u983.pass:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    local u1003 = nil;
    task.delay(13.583, function() -- Line: 16081
        -- upvalues: u1003 (ref), ReplicatedStorage (ref), u983 (copy), RunService (ref)
        u1003 = ReplicatedStorage.Resources.sae.CAMERAPART2:Clone();
        u1003.Parent = u983;
        local u1004 = nil;
        u1004 = RunService.PreRender:connect(function() -- Line: 16086
            -- upvalues: u1003 (ref), u1004 (ref)
            if u1003:IsDescendantOf(game) then
                u1003.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2.5) * CFrame.Angles(0, 0, -1.3089969389957472);

                return;
            end;

            u1004:Disconnect();
        end);
    end);
    task.delay(15.317, function() -- Line: 16097
        -- upvalues: u1 (ref), u983 (copy)
        u1.bright(0.3, 0.3);

        for _, descendant in ipairs(u983.charw:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u983.spinbeam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u983.step5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(15.733, function() -- Line: 16119
        -- upvalues: u1 (ref), u1003 (ref), ReplicatedStorage (ref), u983 (copy), RunService (ref), TweenService (ref)
        u1.bright(0.8, 0.6);

        if u1003 then
            u1003:Destroy();
        end;

        local u1005 = ReplicatedStorage.Resources.sae.CAMERAPART2:Clone();
        u1005.Parent = u983;
        local u1006 = nil;
        u1006 = RunService.PreRender:connect(function() -- Line: 16130
            -- upvalues: u1005 (copy), u1006 (ref)
            if u1005:IsDescendantOf(game) then
                u1005.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 0, 1.3962634015954636);

                return;
            end;

            u1006:Disconnect();
        end);

        for _, descendant in ipairs(u983.swing:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u983.step6:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 1;
                TweenService:Create(descendant, TweenInfo.new(1), {
                    TimeScale = 0
                }):Play();
            end;
        end;

        for _, descendant in ipairs(u983.charw:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u983.spinbeam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(16.917, function() -- Line: 16217
        -- upvalues: u986 (copy), u983 (copy), ColorCorrectionEffect (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), u1 (ref)
        u986:Destroy();
        u983:Destroy();
        ColorCorrectionEffect:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        u1.ultFlash();
        u1.sceneEnabled(false);
        u1.fov(false, 15);
        u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function u1.saeskill2(p1007, p1008, p1009) -- Line: 16237
    -- upvalues: Players (copy), soundUtil (copy), ReplicatedStorage (copy), workspace_CurrentCamera (copy), RunService (copy), Lighting (copy), TweenService (copy), u1 (copy)
    local u1010 = p1007.HumanoidRootPart or p1007.PrimaryPart;
    local v1011 = 0.8 * (p1009 and 0.75 or 1);

    if p1009 then
        Players.LocalPlayer.Character:SetAttribute("lockrotation", true);
    end;

    soundUtil:play(ReplicatedStorage.Resources.sae.countered, u1010);
    soundUtil:play(ReplicatedStorage.Resources.sae.counterdribble, u1010);
    local u1012 = ReplicatedStorage.Resources.sae.bgScene:Clone();
    u1012.Parent = workspace.Effects;
    u1012.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -2);

    for _, descendant in ipairs(u1012:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    local v1014 = RunService.PreRender:connect(function(p1013) -- Line: 16261
        -- upvalues: u1012 (copy), workspace_CurrentCamera (ref)
        u1012.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -2);
    end);
    task.delay(5, v1014.Disconnect, v1014);
    task.delay(5, u1012.Destroy, u1012);
    local v1015 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v1015.Parent = Lighting;
    v1015.TintColor = Color3.fromRGB(149, 156, 255);
    v1015.Brightness = 0.1;
    v1015.Contrast = 15;
    TweenService:Create(v1015, TweenInfo.new(0.55), {
        Contrast = 0.5
    }):Play();
    u1.fov(false, 30);
    u1.cameraShake(20, 1.5, 3);
    u1.fov(true, 70, 0.8333333333333333, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    u1.characterImage({
        Speed = 2.5,
        Brightness = 1,
        Whitelist = { p1007 },
        Color = Color3.fromRGB(255, 255, 255)
    });
    task.wait(0.8333333333333333);
    u1.cameraShake(20, 1, 3);
    TweenService:Create(v1015, TweenInfo.new(1), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v1015.Destroy, v1015);
    u1.characterImage({
        Speed = 0.5,
        CFrames = true,
        Brightness = 1,
        Count = 5,
        countSpeed = 0.1,
        Whitelist = { p1007 },
        Duration = v1011,
        Color = Color3.fromRGB(220, 172, 255)
    });
    local v1016 = 95;

    if p1009 then
        v1016 = v1016 - v1016 * 0.25;
    end;

    local u1017, u1018 = u1.bodyVelocity(u1010, v1016, v1011, nil, nil, true, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In));
    local u1019 = -5;
    local u1020 = 0;
    local u1021 = nil;
    u1021 = RunService.RenderStepped:Connect(function(p1022) -- Line: 16327
        -- upvalues: u1017 (copy), u1021 (ref), u1010 (copy), u1018 (copy), u1020 (ref), u1019 (ref)
        local math_min_ret = math.min(p1022, 0.03333333333333333);

        if not (u1017 and u1017:IsDescendantOf(game)) then
            u1021:Disconnect();

            return;
        end;

        local v1023 = u1010.CFrame.LookVector * u1018.Value;
        u1020 = u1020 + math_min_ret;
        u1019 = u1019 + math.sin(u1020 * 1) * math_min_ret * 240;
        u1019 = math.clamp(u1019, -10, 0);
        u1017.Velocity = v1023 + u1010.CFrame.RightVector * (u1019 * 20);
    end);
    task.delay(15, u1021.Disconnect, u1021);
    Players.LocalPlayer.Character:SetAttribute("lockrotation", nil);
end;

function u1.saePass(p1024) -- Line: 16351
    -- upvalues: actionUtil (copy), u1 (copy)
    if not p1024.HumanoidRootPart then
        local _ = p1024.PrimaryPart;
    end;

    if not actionUtil.simulatesCharacter(p1024) then
        return;
    end;

    u1.fov(false, 55);
    u1.fov(true, 70, 1.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
end;

function u1.mvpGoal(u1025: any, u1026: any, u1027: any, p1028: any, u1029: any, u1030: any, u1031, u1032: number?) -- Line: 16367
    -- upvalues: Players (copy), ReplicatedStorage (copy), PlayerGui (copy), TweenService (copy), u1 (copy)
    if not u1027 then
        return;
    end;

    Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    local function add() -- Line: 16374
        -- upvalues: u1027 (copy), u1025 (ref), u1026 (ref), ReplicatedStorage (ref), u1029 (copy), PlayerGui (ref), u1032 (copy), u1031 (copy), u1030 (copy), TweenService (ref), u1 (ref)
        if u1027 == "A" then
            if u1025 == 0 then
                u1025 = 1;
            end;
        elseif u1026 == 0 then
            u1026 = 1;
        end;

        local u1033 = u1027 == "A" and u1025 or u1026;

        if u1027 == "A" then
            u1025 = math.max(0, u1025 - 1);
        else
            u1026 = math.max(0, u1026 - 1);
        end;

        local u1034 = ReplicatedStorage.Resources[u1029 and `GoalUI_{u1029}` or "GoalUI"]:Clone();
        u1034.Parent = PlayerGui;
        u1034.Frame.ImageLabel2.ImageTransparency = 1;
        local ImageLabel = u1034.Frame:FindFirstChild("ImageLabel");
        local UDim2_new_ret = UDim2.new(0.1, 0, 0, 0);

        if ImageLabel then
            ImageLabel.Position = UDim2.new(0.1, 0, -1, 0);
        end;

        if u1032 and u1032 > 0 then
            local UDim2_new_ret2 = UDim2.new((u1034.Frame.A.Position.X.Scale + u1034.Frame.B.Position.X.Scale + u1034.Frame.B.Size.X.Scale) / 2, (u1034.Frame.A.Position.X.Offset + u1034.Frame.B.Position.X.Offset + u1034.Frame.B.Size.X.Offset) / 2, u1034.Frame.A.Position.Y.Scale + u1034.Frame.A.Size.Y.Scale / 2, u1034.Frame.A.Position.Y.Offset + u1034.Frame.A.Size.Y.Offset / 2);
            UDim2_new_ret = UDim2.new(UDim2_new_ret2.X.Scale + (UDim2_new_ret.X.Scale - UDim2_new_ret2.X.Scale) * u1032, UDim2_new_ret2.X.Offset + (UDim2_new_ret.X.Offset - UDim2_new_ret2.X.Offset) * u1032, UDim2_new_ret2.Y.Scale + (UDim2_new_ret.Y.Scale - UDim2_new_ret2.Y.Scale) * u1032, UDim2_new_ret2.Y.Offset + (UDim2_new_ret.Y.Offset - UDim2_new_ret2.Y.Offset) * u1032);

            for _, child in u1034.Frame:GetChildren() do
                if child:IsA("TextLabel") or child == ImageLabel then
                    local Position = child.Position;
                    local Size = child.Size;
                    child.Position = UDim2.new(UDim2_new_ret2.X.Scale + (Position.X.Scale - UDim2_new_ret2.X.Scale) * u1032, UDim2_new_ret2.X.Offset + (Position.X.Offset - UDim2_new_ret2.X.Offset) * u1032, UDim2_new_ret2.Y.Scale + (Position.Y.Scale - UDim2_new_ret2.Y.Scale) * u1032, UDim2_new_ret2.Y.Offset + (Position.Y.Offset - UDim2_new_ret2.Y.Offset) * u1032);
                    child.Size = UDim2.new(Size.X.Scale * u1032, Size.X.Offset * u1032, Size.Y.Scale * u1032, Size.Y.Offset * u1032);

                    if child:IsA("TextLabel") and not child.TextScaled then
                        child.TextSize = child.TextSize * u1032;
                    end;
                end;
            end;
        end;

        if u1031 then
            UDim2_new_ret = UDim2_new_ret + u1031;

            for _, child in u1034.Frame:GetChildren() do
                if child:IsA("TextLabel") or child == ImageLabel then
                    child.Position = child.Position + u1031;
                end;
            end;
        end;

        u1034.Frame.A.Text = u1025;
        u1034.Frame.B.Text = u1026;
        local u1035 = u1030 or 3;
        task.delay(1, function() -- Line: 16440
            -- upvalues: u1034 (copy), u1027 (ref), TweenService (ref), u1033 (copy), u1035 (copy)
            u1034.Frame[u1027].BackgroundTransparency = 0;
            TweenService:Create(u1034.Frame[u1027], TweenInfo.new(0.3), {
                BackgroundTransparency = 1
            }):Play();
            u1034.Frame[u1027].Text = u1033;

            for _, child in u1034.Frame:GetChildren() do
                if child:IsA("TextLabel") then
                    TweenService:Create(child, TweenInfo.new(u1035), {
                        TextTransparency = 1
                    }):Play();

                    for _, child2 in child:GetChildren() do
                        if child2:IsA("UIStroke") then
                            TweenService:Create(child2, TweenInfo.new(u1035), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                end;
            end;
        end);

        if ImageLabel then
            TweenService:Create(ImageLabel, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Position = UDim2_new_ret
            }):Play();
            TweenService:Create(ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
        end;

        u1.bright(0.35, 1);
        task.delay(u1035 + 1, u1034.Destroy, u1034);
    end;

    if p1028 then
        task.delay(p1028, add);
    else
        add();
    end;
end;

function u1.saeVSrinUI(p1036) -- Line: 16477
    -- upvalues: ReplicatedStorage (copy), PlayerGui (copy), TweenService (copy)
    local v1037 = p1036 and Color3.fromRGB(255, 73, 161) or Color3.fromRGB(101, 234, 255);
    local v1038 = ReplicatedStorage.Resources.rin.SAEVSRIN:Clone();
    v1038.CanvasGroup.GroupTransparency = 1;
    v1038.Parent = PlayerGui;
    TweenService:Create(v1038.CanvasGroup, TweenInfo.new(1), {
        GroupTransparency = 0
    }):Play();
    TweenService:Create(v1038.CanvasGroup.ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 1, 0),
        ImageColor3 = v1037
    }):Play();
    task.wait(2);
    TweenService:Create(v1038.CanvasGroup.Frame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        BackgroundTransparency = 0
    }):Play();
    task.wait(1);
    v1038:Destroy();
end;

function u1.kaisercounter(u1039) -- Line: 16506
    -- upvalues: Lighting (copy), vfxUtil (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), PlayerGui (copy), ClockTime (copy), RunService (copy), Density (copy), Color (copy), Brightness (copy)
    local Ball = u1039:FindFirstChild("Ball");
    local v1040 = u1039.HumanoidRootPart or u1039.PrimaryPart;
    local _ = u1039.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    u1.bright(1, 1.5);
    u1.sceneEnabled(true);
    u1.cutsceneLeftright(v1040, ReplicatedStorage.Resources.kaiser.skill1counter3, ReplicatedStorage.Resources.kaiser.FOV);
    local u1041 = ReplicatedStorage.Resources.kaiser.ColorCorrection:Clone();
    u1041.Parent = Lighting;
    local u1042 = ReplicatedStorage.Resources.kaiser.couallEff:Clone();
    u1042:PivotTo(v1040.CFrame);
    u1042.Parent = u1039;

    if Util.canshiftcolor(LocalPlayer, u1039) then
        vfxUtil.LeanTowardsColor(u1042, u1039:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u1039:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u1043 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1043.Parent = Lighting;
    u1043.FarIntensity = 0;
    TweenService:Create(u1043, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local u1044 = Util.Preload({ ReplicatedStorage.Resources.kaiser.ImpactFrame1, ReplicatedStorage.Resources.kaiser.ImpactFrame2, ReplicatedStorage.Resources.kaiser.ImpactFrame3 });
    local Attribute = u1039:GetAttribute("femlock");
    local v1045;

    if Attribute then
        v1045 = ReplicatedStorage.Resources.kaiser.Femvoicelines.beinschuss;
    else
        v1045 = ReplicatedStorage.Resources.kaiser.kaiser;
    end;

    local u1046 = Attribute or soundUtil:play(v1045, SoundService, {
        Character = u1039
    }).Name == "Dub";

    local function getLine(p1047, p1048) -- Line: 16550
        -- upvalues: u1046 (copy)
        if u1046 then
            p1048 = p1047 or p1048;
        end;

        return p1048;
    end;

    if u1046 then
        task.delay(6.7, function() -- Line: 16556
            -- upvalues: TekrinnDialogue (ref), u1039 (copy)
            TekrinnDialogue.Speak(u1039, {
                {
                    Text = "Eat this...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            }, 0.55);
        end);
        task.delay(8.3, function() -- Line: 16582
            -- upvalues: TekrinnDialogue (ref), u1039 (copy)
            TekrinnDialogue.Speak(u1039, {
                {
                    Text = "LOSERS!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1
                    }
                }
            }, 0.35);
        end);
        task.delay(10.2, function() -- Line: 16608
            -- upvalues: TekrinnDialogue (ref), u1039 (copy)
            TekrinnDialogue.Speak(u1039, {
                {
                    Text = "Kaiser Impact...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 1
                    }
                }
            }, 0.65);
        end);
        task.delay(12, function() -- Line: 16633
            -- upvalues: TekrinnDialogue (ref), u1039 (copy), u1046 (copy)
            TekrinnDialogue.Speak(u1039, {
                {
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Text = u1046 and "BEINSCHUSS!" or "BOUNDING!",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1.25
                    }
                }
            }, 1.25);
        end);
    end;

    local u1049 = {};

    for _, child in ipairs(u1039:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v1050 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.kaiser.auraya:GetChildren()) do
                local v1051 = child2:Clone();
                v1051.Enabled = true;
                v1051.Parent = v1050;
                table.insert(u1049, v1051);
            end;
        end;
    end;

    local function spawnmisspoint() -- Line: 16674
        -- upvalues: ReplicatedStorage (ref), u1042 (copy)
        local v1052 = ReplicatedStorage.Resources.kaiser.Point:Clone();
        v1052.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(Random.new():NextInteger(-5, 5), Random.new():NextInteger(0, 5), Random.new():NextInteger(-11, -7));
        v1052.Parent = u1042;

        for _, descendant in pairs(v1052.emit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16687
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(v1052.misspoint:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16695
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(v1052.MISS:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16703
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        task.delay(3, v1052.Destroy, v1052);
    end;

    task.delay(5.166666666666667, spawnmisspoint);
    task.delay(5.55, spawnmisspoint);
    task.delay(5.8, spawnmisspoint);
    task.delay(5.966666666666667, spawnmisspoint);
    task.delay(6.083333333333333, spawnmisspoint);
    task.delay(6.183333333333333, spawnmisspoint);
    task.delay(6.266666666666667, spawnmisspoint);
    task.delay(6.35, spawnmisspoint);
    task.delay(6.433333333333333, spawnmisspoint);
    task.delay(6.516666666666667, spawnmisspoint);
    task.delay(6.6, spawnmisspoint);
    task.delay(6.65, spawnmisspoint);
    task.delay(6.783333333333333, spawnmisspoint);
    task.delay(7, function() -- Line: 16726
        -- upvalues: ReplicatedStorage (ref), u1042 (copy)
        local v1053 = ReplicatedStorage.Resources.kaiser.Point:Clone();
        v1053.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -7);
        v1053.Parent = u1042;

        for _, descendant in pairs(v1053.emit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16734
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(v1053.goalpoint:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16742
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(v1053.GOAL:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16750
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        task.delay(3, v1053.Destroy, v1053);
    end);
    local u1054 = nil;
    task.delay(4.766666666666667, function() -- Line: 16761
        -- upvalues: Ball (copy), u1054 (ref), ReplicatedStorage (ref), u1042 (copy)
        if not Ball then
            return;
        end;

        u1054 = ReplicatedStorage.Resources.kaiser.Ball:Clone();
        u1054.Weld.Part0 = Ball;
        u1054.Parent = u1042;

        for _, descendant in pairs(u1054.ballseeingaura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.983333333333333, function() -- Line: 16778
        -- upvalues: u1054 (ref)
        if not u1054 then
            return;
        end;

        for _, descendant in pairs(u1054.ballseeingaura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u1054.ballaimed:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16793
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                end);
            end;
        end;
    end);
    task.delay(7.733333333333333, function() -- Line: 16800
        -- upvalues: u1054 (ref)
        if not u1054 then
            return;
        end;

        for _, descendant in pairs(u1054.ballaimed:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16808
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in pairs(u1054.ballauranormal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16817
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                end);
            end;
        end;
    end);
    task.delay(9.233333333333333, function() -- Line: 16824
        -- upvalues: u1054 (ref)
        if not u1054 then
            return;
        end;

        for _, descendant in ipairs(u1054.ballauranormal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.05;
            end;
        end;

        for _, descendant in ipairs(u1054.ballglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(10.98333333333333, function() -- Line: 16842
        -- upvalues: u1054 (ref)
        if not u1054 then
            return;
        end;

        for _, descendant in ipairs(u1054.ballauranormal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(0.85, function() -- Line: 16856
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.kaiser.ImpactFrame1, 30);
    end);
    task.delay(10.16666666666667, function() -- Line: 16860
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.kaiser.ImpactFrame2, 30);
    end);
    task.delay(11.6, function() -- Line: 16864
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        Util.Gif(ReplicatedStorage.Resources.kaiser.ImpactFrame3, 30);
    end);
    task.delay(0.85, function() -- Line: 16870
        -- upvalues: u1049 (copy), u1042 (copy)
        for _, v in u1049 do
            v.Enabled = false;
        end;

        for _, descendant in ipairs(u1042.kaiserimpactslam1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.733333333333333, function() -- Line: 16882
        -- upvalues: u1042 (copy)
        for _, descendant in ipairs(u1042.kaiserimpactslam2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u1055 = nil;
    task.delay(3.75, function() -- Line: 16892
        -- upvalues: u1049 (copy), u1055 (ref), ReplicatedStorage (ref), u1039 (copy), u1042 (copy)
        for _, v in u1049 do
            v.Enabled = true;
        end;

        u1055 = ReplicatedStorage.Resources.kaiser.eyeflash:Clone();
        u1055.Weld.Part0 = u1039.Head;
        u1055.Parent = u1042;

        for _, descendant in pairs(u1055.eyeflash:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16904
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    local u1056 = nil;
    task.delay(4.716666666666667, function() -- Line: 16914
        -- upvalues: Lighting (ref), u1056 (ref), ReplicatedStorage (ref), PlayerGui (ref), TweenService (ref), ClockTime (ref)
        Lighting.ClockTime = 24;
        u1056 = ReplicatedStorage.Resources.kaiser.glowscreen:Clone();
        u1056.Parent = PlayerGui;
        task.wait(2.283333333333333);
        TweenService:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            ClockTime = ClockTime
        }):Play();
    end);
    task.delay(4.416666666666667, function() -- Line: 16931
        -- upvalues: u1055 (ref)
        if not u1055 then
            return;
        end;

        for _, descendant in pairs(u1055.impact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16939
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(4.616666666666667, function() -- Line: 16946
        -- upvalues: u1042 (copy)
        for _, descendant in ipairs(u1042.kaiserimpactsurroundingstuff1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.633333333333333, function() -- Line: 16954
        -- upvalues: u1055 (ref)
        if not u1055 then
            return;
        end;

        for _, descendant in pairs(u1055.explosion:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 16962
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(4.733333333333333, function() -- Line: 16969
        -- upvalues: ReplicatedStorage (ref), u1039 (copy), RunService (ref)
        local u1057 = ReplicatedStorage.Resources.kaiser.CamEffect:Clone();
        u1057.CFrame = workspace.CurrentCamera.CFrame;
        u1057.Parent = u1039;

        for _, descendant in ipairs(u1057:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v1058 = RunService.PreRender:connect(function() -- Line: 16980
            -- upvalues: u1057 (copy)
            u1057.CFrame = workspace.CurrentCamera.CFrame;
        end);
        task.delay(3, v1058.Disconnect, v1058);
        task.delay(3, u1057.Destroy, u1057);
    end);
    task.delay(4.75, function() -- Line: 16988
        -- upvalues: u1042 (copy)
        for _, descendant in ipairs(u1042.kaisergrid:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.5, function() -- Line: 16996
        -- upvalues: ReplicatedStorage (ref), u1039 (copy), RunService (ref)
        local u1059 = ReplicatedStorage.Resources.kaiser.CamEffect:Clone();
        u1059.CFrame = workspace.CurrentCamera.CFrame;
        u1059.Parent = u1039;
        local v1060 = RunService.PreRender:connect(function() -- Line: 17001
            -- upvalues: u1059 (copy)
            u1059.CFrame = workspace.CurrentCamera.CFrame;
        end);

        for _, descendant in ipairs(u1059:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.2333333333333333, u1059.Destroy, u1059);
        task.delay(0.2333333333333333, v1060.Disconnect, v1060);
    end);
    task.delay(8, function() -- Line: 17014
        -- upvalues: u1042 (copy)
        for _, descendant in ipairs(u1042.kaiserimpactsurroundingstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.116666666666667, function() -- Line: 17022
        -- upvalues: u1042 (copy)
        for _, descendant in ipairs(u1042.kaiserimpactsurroundingstuff1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(8.133333333333333, function() -- Line: 17030
        -- upvalues: ReplicatedStorage (ref), u1039 (copy)
        local v1061 = ReplicatedStorage.Resources.kaiser.trail:Clone();
        v1061.Weld.Part0 = u1039["Right Arm"];
        v1061.Parent = u1039;
        local v1062 = ReplicatedStorage.Resources.kaiser.trail:Clone();
        v1062.Weld.Part0 = u1039["Left Arm"];
        v1062.Parent = u1039;
        local v1063 = ReplicatedStorage.Resources.kaiser.trail:Clone();
        v1063.Weld.Part0 = u1039["Right Leg"];
        v1063.Parent = u1039;
        local v1064 = ReplicatedStorage.Resources.kaiser.trail:Clone();
        v1064.Weld.Part0 = u1039["Left Leg"];
        v1064.Parent = u1039;
        task.delay(0.8, v1061.Destroy, v1061);
        task.delay(0.8, v1062.Destroy, v1062);
        task.delay(0.8, v1063.Destroy, v1063);
        task.delay(0.8, v1064.Destroy, v1064);
    end);
    task.delay(9.233333333333333, function() -- Line: 17053
        -- upvalues: u1049 (copy), u1042 (copy)
        for _, v in u1049 do
            v.TimeScale = 0.1;
        end;

        for _, descendant in ipairs(u1042.kaiserimpactsurroundingstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.05;
            end;
        end;
    end);
    task.delay(9.283333333333333, function() -- Line: 17065
        -- upvalues: u1042 (copy)
        for _, descendant in pairs(u1042.kaiserimpactsurroundingstuff.Part.Stars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(u1042.kaiserimpactsurroundingstuff.Part.Ground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;
    end);
    task.delay(9.266666666666667, function() -- Line: 17081
        -- upvalues: u1042 (copy)
        for _, descendant in ipairs(u1042.kaisergrid:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(10.98333333333333, function() -- Line: 17089
        -- upvalues: u1049 (copy), u1042 (copy)
        for _, v in u1049 do
            v.TimeScale = 1;
        end;

        for _, descendant in pairs(u1042.kaiserimpactsurroundingstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(11.58333333333333, function() -- Line: 17102
        -- upvalues: u1042 (copy)
        for _, descendant in pairs(u1042.kaiserimpactlegflashpart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 17106
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                end);
            end;
        end;
    end);
    task.delay(12.26666666666667, function() -- Line: 17113
        -- upvalues: u1056 (ref), u1049 (copy), u1042 (copy)
        if u1056 then
            u1056:Destroy();
        end;

        for _, v in u1049 do
            v:Destroy();
        end;

        table.clear(u1049);

        for _, descendant in pairs(u1042.kaiserimpactlegflashpart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 17126
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in pairs(u1042.kaiserimpactsurroundingstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 17135
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(12.31666666666667, function() -- Line: 17142
        -- upvalues: u1054 (ref), u1042 (copy)
        if u1054 then
            u1054:Destroy();
        end;

        for _, descendant in pairs(u1042.kaiserimpactkick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(13.16666666666667, function() -- Line: 17155
        -- upvalues: ScreenDimmer (copy), u1044 (copy), u1043 (copy), u1042 (copy), u1041 (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), u1 (ref), u1056 (ref), u1049 (copy)
        ScreenDimmer:Destroy();
        u1044:Destroy();
        u1043:Destroy();
        u1042:Destroy();
        u1041:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        u1.ultFlash();
        u1.sceneEnabled(false);
        u1.fov(false, 100);
        u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

        if u1056 then
            u1056:Destroy();
        end;

        for _, v in u1049 do
            v:Destroy();
        end;

        table.clear(u1049);
    end);
end;

function u1.kaiserImpactmagnus(u1065) -- Line: 17187
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local u1066 = u1065.HumanoidRootPart or u1065.PrimaryPart;
    local Ball = u1065:FindFirstChild("Ball");
    u1.fov(true, 120, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    task.delay(0.1333333333333333, function() -- Line: 17196
        -- upvalues: Ball (copy), ReplicatedStorage (ref), u1065 (copy), u1 (ref), u1066 (copy)
        if not Ball then
            return;
        end;

        local u1067 = ReplicatedStorage.Resources.kaiser.XDD:Clone();
        u1067.ball.Part0 = Ball;
        u1067.Parent = u1065;
        task.spawn(function() -- Line: 17205
            -- upvalues: u1067 (copy)
            for _, descendant in ipairs(u1067:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;

                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        task.delay(3, u1067.Destroy, u1067);
        u1.Emit(u1066, ReplicatedStorage.Resources.kaiser.Jump, 3, CFrame.new(0, -3, 0));
    end);
    task.delay(0.4333333333333333, function() -- Line: 17221
        -- upvalues: u1 (ref), u1066 (copy), ReplicatedStorage (ref)
        u1.fov(false, 70);
        u1.Emit(u1066, ReplicatedStorage.Resources.kaiser.IMPACTA, 3, CFrame.new(0, -2, -3));
    end);
end;

function u1.kaiserImpactmagnusTrail(p1068) -- Line: 17228
    -- upvalues: ReplicatedStorage (copy)
    if not p1068.HumanoidRootPart then
        local _ = p1068.PrimaryPart;
    end;

    local Ball = workspace.Terrain:FindFirstChild("Ball");

    if not Ball then
        return;
    end;

    local u1069 = ReplicatedStorage.Resources.kaiser.MagnusTrail:Clone();
    u1069.ball.Part0 = Ball;
    u1069.Parent = p1068;
    task.spawn(function() -- Line: 17240
        -- upvalues: u1069 (copy)
        task.wait();

        for _, descendant in ipairs(u1069:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;

            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.65, u1069.Destroy, u1069);
end;

function u1.kaiserImpactLightningStrike(p1070, p1071) -- Line: 17256
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), workspace_CurrentCamera (copy), TweenService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), Brightness (copy), Density (copy), Color (copy)
    local v1072 = p1070.HumanoidRootPart or p1070.PrimaryPart;
    local _ = p1070.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    u1.ultFlash(-1);
    local u1073 = ReplicatedStorage.Resources.kaiser.lseff:Clone();
    u1073:PivotTo(v1072.CFrame);
    u1073.Parent = p1070;
    local u1074 = ReplicatedStorage.Resources.kaiser.eyeki:Clone();
    u1074.Weld.Part0 = p1070.Head;
    u1074.Parent = u1073;

    if Util.canshiftcolor(LocalPlayer, p1070) then
        vfxUtil.LeanTowardsColor(u1073, p1070:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p1070:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u1075 = {};

    for _, child in ipairs(p1070:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v1076 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.kaiser.auraya:GetChildren()) do
                local v1077 = child2:Clone();
                v1077.Enabled = true;
                v1077.Parent = v1076;
                table.insert(u1075, v1077);
            end;
        end;
    end;

    task.delay(0.8, function() -- Line: 17300
        -- upvalues: ReplicatedStorage (ref), u1073 (copy), RunService (ref), workspace_CurrentCamera (ref), TweenService (ref)
        local u1078 = ReplicatedStorage.Resources.kaiser.CAMERAPART:Clone();
        u1078.Parent = u1073;
        local u1079 = nil;
        u1079 = RunService.PreRender:connect(function() -- Line: 17305
            -- upvalues: u1078 (copy), u1079 (ref), workspace_CurrentCamera (ref)
            if not u1078:IsDescendantOf(game) then
                u1079:Disconnect();
            end;

            u1078.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -1.5) * CFrame.Angles(0, 0, 0.3490658503988659);
        end);

        for _, descendant in ipairs(u1073.KICKPARTICLES1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u1073.End.Size = Vector3.new(10, 20, 20);
        u1073.End.Transparency = 0;
        TweenService:Create(u1073.End, TweenInfo.new(0.217), {
            Transparency = 1,
            Size = Vector3.new(13, 0, 0),
            CFrame = u1073.End.CFrame * CFrame.Angles(10, 0, 0)
        }):Play();
        u1073.EndBlue.Size = Vector3.new(3, 6, 6);
        u1073.EndBlue.Transparency = 0.95;
        TweenService:Create(u1073.EndBlue, TweenInfo.new(0.867), {
            Transparency = 1,
            Size = Vector3.new(14, 14, 14),
            CFrame = u1073.EndBlue.CFrame * CFrame.Angles(10, 0, 0)
        }):Play();
    end);
    task.delay(0.367, function() -- Line: 17342
        -- upvalues: u1074 (copy)
        for _, descendant in ipairs(u1074:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.817, function() -- Line: 17350
        -- upvalues: u1075 (copy)
        for _, v in u1075 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;

        table.clear(u1075);
    end);
    local u1080 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1080.Parent = Lighting;
    u1080.FarIntensity = 0;
    TweenService:Create(u1080, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local v1081;

    if p1070:GetAttribute("femlock") then
        v1081 = ReplicatedStorage.Resources.kaiser.Femvoicelines.flash;
    else
        v1081 = ReplicatedStorage.Resources.kaiser["lightning strike"];
    end;

    soundUtil:play(v1081, SoundService, {
        Character = p1070
    });
    u1.cutsceneBlender(v1072, ReplicatedStorage.Resources.kaiser.skill52, ReplicatedStorage.Resources.kaiser.FOV3);
    TekrinnDialogue.Speak(p1070, {
        {
            Text = "Insta-Kill Flash!",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 89, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 3,
                Lifetime = 1
            }
        }
    }, 1.6);
    task.delay(1.667, function() -- Line: 17397
        -- upvalues: u1080 (copy), u1 (ref), u1073 (copy), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref)
        u1080:Destroy();
        u1.ultFlash(1);
        u1.sceneEnabled(false);
        u1073:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u1.fov(false, 70);
    end);
end;

function u1.izayoiAwk(u1082, p1083) -- Line: 17418
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), TekrinnDialogue (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Brightness (copy), Density (copy), Color (copy)
    local v1084 = u1082.HumanoidRootPart or u1082.PrimaryPart;
    local _ = u1082.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    u1.ultFlash(-1);
    local u1085 = nil;
    local u1086 = nil;
    local u1087 = ReplicatedStorage.Resources.izayoi.ThrowKnives:Clone();
    u1087.b11.Blade1.Blade1.Part0 = v1084;
    u1087.b22.Blade2.Blade2.Part0 = v1084;
    u1087.b33.Blade3.Blade3.Part0 = v1084;
    u1087.Parent = u1082;
    task.delay(4, function() -- Line: 17434
        -- upvalues: u1085 (ref), ReplicatedStorage (ref), u1082 (copy), u1086 (ref)
        u1085 = ReplicatedStorage.Resources.izayoi.HandKnives:Clone();
        u1085.b1.Blade.Blade.Part0 = u1082["Left Arm"];
        u1085.b2.Bladee2.Blade.Part0 = u1082["Left Arm"];
        u1085.b3.Bladee3.Blade.Part0 = u1082["Left Arm"];
        u1085.Parent = u1082;
        u1086 = ReplicatedStorage.Resources.izayoi.watch:Clone();
        u1086.Base.beamattachright.Part0 = u1082["Right Arm"];
        u1086.Parent = u1082;
    end);
    task.delay(2.2, function() -- Line: 17446
        -- upvalues: ReplicatedStorage (ref), Lighting (ref)
        local v1088 = ReplicatedStorage.Resources.izayoi.timestop:Clone();
        v1088.Parent = Lighting;
        task.wait(0.38);
        v1088:Destroy();
    end);
    task.delay(7.2, function() -- Line: 17452
        -- upvalues: TekrinnDialogue (ref), u1082 (copy)
        TekrinnDialogue.Speak(u1082, {
            {
                Text = "You will lose without understanding what this power is.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 223, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3.5);
    end);
    local u1089 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1089.Parent = Lighting;
    u1089.FarIntensity = 0;
    TweenService:Create(u1089, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.izayoi.sakuyaeff, SoundService);
    u1.cutsceneBlender(v1084, ReplicatedStorage.Resources.izayoi.ultawkCam, ReplicatedStorage.Resources.izayoi.ultFOV);
    task.delay(10.65, function() -- Line: 17492
        -- upvalues: u1089 (copy), u1 (ref), u1085 (ref), u1086 (ref), u1087 (copy), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref)
        u1089:Destroy();
        u1.ultFlash(1);
        u1.sceneEnabled(false);
        u1085:Destroy();
        u1086:Destroy();
        u1087:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u1.fov(false, 70);
    end);
end;

function u1.evil_exeAwk(u1090, p1091) -- Line: 17515
    -- upvalues: vfxUtil (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), Lighting (copy), RunService (copy), LocalPlayer (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u1090);
    local exe = vfxUtil.getResources().exe;
    local u1092 = vfxUtil.character_trove(u1090);
    u1.sceneEnabled(true);
    u1.ultFlash(-1);
    u1092:Add(function() -- Line: 17523
        -- upvalues: u1 (ref)
        u1.ultFlash(1);
        u1.sceneEnabled(false);
    end);
    local v1093, v1094 = u1.cutsceneBlender(Root, ReplicatedStorage.Resources.exe.awkCam, ReplicatedStorage.Resources.exe.FOV2);
    u1092:Add(v1094);
    local u1095, u1096;

    if Util.isepilepsysafe() then
        u1095 = nil;
        u1096 = nil;
    else
        u1096 = exe.Glitchin:Clone();
        u1096.Parent = v1093.CamPart;
        u1092:Add(u1096);
        u1095 = exe.Glitchin2:Clone();
        u1095.Parent = v1093.CamPart;
        u1092:Add(u1095);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Enabled = false;
        ColorCorrectionEffect:SetAttribute("NextGlitch", os.clock() + math.random(30, 50) / 100);
        ColorCorrectionEffect:SetAttribute("GlitchUntil", 0);
        ColorCorrectionEffect.Parent = Lighting;
        u1092:Add(ColorCorrectionEffect);
        u1092:Add(RunService.RenderStepped:Connect(function() -- Line: 17556
            -- upvalues: u1096 (ref), u1095 (ref), ColorCorrectionEffect (ref)
            if not (u1096.Parent and u1095.Parent) then
                ColorCorrectionEffect.Enabled = false;

                return;
            end;

            if os.clock() >= ColorCorrectionEffect:GetAttribute("NextGlitch") then
                ColorCorrectionEffect:SetAttribute("NextGlitch", os.clock() + math.random(30, 50) / 100);
                ColorCorrectionEffect:SetAttribute("GlitchUntil", os.clock() + math.random(10, 25) / 100);
            end;

            ColorCorrectionEffect.Enabled = os.clock() < ColorCorrectionEffect:GetAttribute("GlitchUntil");

            if not ColorCorrectionEffect.Enabled then
                return;
            end;

            ColorCorrectionEffect.Brightness = math.random(-20, 8) / 100;
            ColorCorrectionEffect.Contrast = math.random(35, 85) / 100;
            ColorCorrectionEffect.Saturation = math.random(-80, 15) / 100;
            ColorCorrectionEffect.TintColor = Color3.fromHSV(math.random(), math.random(60, 100) / 100, math.random(60, 100) / 100);
        end));
    end;

    u1092:Add(task.delay(9.369, function() -- Line: 17579
        -- upvalues: u1 (ref), LocalPlayer (ref), u1090 (copy), u1095 (ref), u1096 (ref)
        if u1.x2011_pursuit_jumpscare and LocalPlayer.Character then
            u1.x2011_pursuit_jumpscare(u1090, LocalPlayer.Character, true);
        end;

        if u1095 then
            u1095:Destroy();
        end;

        if u1096 then
            u1096:Destroy();
        end;
    end));
    u1092:Add(task.delay(9.8, function() -- Line: 17591
        -- upvalues: vfxUtil (ref), u1092 (copy), exe (copy), Lighting (ref)
        vfxUtil.cutscene_lighting(u1092, {}, exe.Lighting, {
            ClockTime = 19,
            ShadowSoftness = 0.2,
            Ambient = Color3.fromRGB(70, 70, 70),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
        local v1097 = script.DestroyerCorrection:Clone();
        v1097.Parent = Lighting;
        u1092:Add(v1097);
    end));
    task.delay(11.883, function() -- Line: 17604
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), TekrinnDialogue (ref), u1090 (copy)
        soundUtil:play(ReplicatedStorage.Resources.exe.awkSound, SoundService);
        TekrinnDialogue.Speak(u1090, {
            {
                Text = "So many souls to play with, so little time.",
                Bold = false,
                Italic = false,
                SpecialText = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 4.5);
        task.delay(6.116, function() -- Line: 17634
            -- upvalues: TekrinnDialogue (ref), u1090 (ref)
            TekrinnDialogue.Speak(u1090, {
                {
                    Text = "Would you agree?",
                    Bold = false,
                    Italic = false,
                    SpecialText = true,
                    TypeSpeed = 0.04,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3.5);
        end);
    end);
    u1092:Add(task.delay(p1091, function() -- Line: 17716
        -- upvalues: u1092 (copy)
        u1092:Destroy();
    end));
end;

function u1.exeAwk(u1098, p1099, u1100) -- Line: 17721
    -- upvalues: Lighting (copy), u1 (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), TekrinnDialogue (copy), TweenService (copy), Brightness (copy), Density (copy), Color (copy)
    local v1101 = u1098.HumanoidRootPart or u1098.PrimaryPart;
    local _ = u1098.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    u1.ultFlash(-1);
    task.delay(11.883, function() -- Line: 17729
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u1100 (copy), u1098 (copy), TekrinnDialogue (ref)
        soundUtil:play(ReplicatedStorage.Resources.exe.awkSound, SoundService);
        local u1102 = u1100 and `{u1098.Name}-kun` or u1098.Name;
        TekrinnDialogue.Speak(u1102, {
            {
                Bold = false,
                Italic = false,
                SpecialText = true,
                TypeSpeed = 0.04,
                Text = u1100 and "遊ぶ魂はこんなにも多いのに、時間はあまりにも少ない" or "So many souls to play with, so little time.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 223, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 4.5);
        task.delay(6.116, function() -- Line: 17761
            -- upvalues: TekrinnDialogue (ref), u1102 (copy), u1100 (ref)
            TekrinnDialogue.Speak(u1102, {
                {
                    Bold = false,
                    Italic = false,
                    SpecialText = true,
                    TypeSpeed = 0.04,
                    Text = u1100 and "そう思わないか？" or "Would you agree?",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 223, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 3.5);
        end);
    end);
    local u1103 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1103.Parent = Lighting;
    u1103.FarIntensity = 0;
    TweenService:Create(u1103, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    u1.cutsceneBlender(v1101, ReplicatedStorage.Resources.exe.awkCam, ReplicatedStorage.Resources.exe.FOV2);
    task.delay(p1099, function() -- Line: 17800
        -- upvalues: u1103 (copy), u1 (ref), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref)
        u1103:Destroy();
        u1.ultFlash(1);
        u1.sceneEnabled(false);
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u1.fov(false, 70);
    end);
end;

local script_BackgroundHighlight = require(script.BackgroundHighlight);

function u1.characterImage(p1104) -- Line: 17823
    -- upvalues: script_BackgroundHighlight (copy)
    script_BackgroundHighlight(p1104);
end;

function u1.mvp_firstFlow(u1105, u1106) -- Line: 17827
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Brightness (copy), TekrinnDialogue (copy)
    local v1107 = u1105.HumanoidRootPart or u1105.PrimaryPart;
    local _ = u1105.Torso;
    local _ = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    local u1108 = ReplicatedStorage.Resources.mvpAssets.firstFlow.eff:Clone();
    u1108:PivotTo(v1107.CFrame);
    u1108.Parent = u1105;

    if Util.canshiftcolor(LocalPlayer, u1105) then
        vfxUtil.LeanTowardsColor(u1108, u1105:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u1105:GetAttribute("CustomAlpha") or 0.985);
    end;

    Lighting.Brightness = 0;
    local u1109 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1109.Parent = Lighting;
    u1109.FarIntensity = 0;
    TweenService:Create(u1109, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.mvpAssets.firstFlow.soundmvp, SoundService);
    u1.cutscene(v1107, CFrame.new(Vector3.new(0, 0, 0)), u1106, ReplicatedStorage.Resources.mvpAssets.firstFlow.FOV);
    u1108["1"].sh:Emit(10);
    u1108.Part2.Attachment.sh3:Emit(3);
    task.delay(0.1, function() -- Line: 17861
        -- upvalues: u1108 (copy)
        for _, descendant in ipairs(u1108["1"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.883333333333333, function() -- Line: 17870
        -- upvalues: Lighting (ref), Brightness (ref), u1108 (copy), TweenService (ref), ReplicatedStorage (ref), u1105 (copy)
        Lighting.Brightness = Brightness;
        u1108.Part2.line.Enabled = true;

        for _, descendant in ipairs(u1108.Part:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                TweenService:Create(descendant, TweenInfo.new(0.05), {
                    TimeScale = 0
                }):Play();
            end;
        end;

        for _, descendant in ipairs(u1108.Part2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v1110 = ReplicatedStorage.Resources.shidou.line:Clone();
        v1110.Parent = u1105["Left Arm"];
        task.delay(0.135, v1110.Destroy, v1110);
    end);
    task.delay(u1106 / 2, function() -- Line: 17894
        -- upvalues: u1 (ref), u1106 (copy), u1109 (copy)
        u1.blackscene(u1106 / 2);
        u1109:Destroy();
        u1.fov(false, 70);
    end);
    task.delay(0.043, function() -- Line: 17901
        -- upvalues: TekrinnDialogue (ref), u1105 (copy)
        TekrinnDialogue.Speak("???", {
            {
                Italic = true,
                TypeSpeed = 0.03,
                Text = `{u1105.Name}`,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 212)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = ".. you were the first one to enter the \"",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 3
                }
            },
            {
                Text = "flow",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 212)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 3
                }
            },
            {
                Text = "\".",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 3
                }
            }
        }, 2);
    end);
end;

function u1.mvp_chigiriTriumph(u1111, u1112) -- Line: 17973
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy)
    local v1113 = u1111.HumanoidRootPart or u1111.PrimaryPart;
    local _ = u1111.Torso;
    local _ = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    local u1114 = ReplicatedStorage.Resources.mvpAssets.chigiriTriumph.ChigiriMvp:Clone();
    u1114:PivotTo(v1113.CFrame);
    u1114.Parent = u1111;

    if Util.canshiftcolor(LocalPlayer, u1111) then
        vfxUtil.LeanTowardsColor(u1114, u1111:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u1111:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u1115 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1115.Parent = Lighting;
    u1115.FarIntensity = 0;
    TweenService:Create(u1115, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.mvpAssets.chigiriTriumph.soundmvp, SoundService);
    u1.cutscene(v1113, CFrame.new(Vector3.new(0, 0, 0)), 9, ReplicatedStorage.Resources.mvpAssets.chigiriTriumph.ChigiriFOV);
    task.delay(0.5, function() -- Line: 18007
        -- upvalues: ReplicatedStorage (ref), u1111 (copy), u1114 (copy)
        local v1116 = ReplicatedStorage.Resources.mvpAssets.chigiriTriumph.Speedlines:Clone();
        v1116.Parent = u1111["Right Leg"];
        v1116.Enabled = true;
        task.wait(0.25);
        v1116:Destroy();

        for _, descendant in ipairs(u1114.RootPosition:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.167, function() -- Line: 18020
        -- upvalues: ReplicatedStorage (ref), u1111 (copy)
        local v1117 = ReplicatedStorage.Resources.mvpAssets.chigiriTriumph.Sweat:Clone();
        v1117.Parent = u1111["Right Arm"];
        v1117:Emit(6);
        task.wait(3);
        v1117:Destroy();
    end);
    task.delay(4.1, function() -- Line: 18028
        -- upvalues: u1 (ref), u1114 (copy), TweenService (ref), ReplicatedStorage (ref), u1111 (copy)
        u1.ultFlash(3, 0.25);

        for _, descendant in ipairs(u1114.JumpFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        TweenService:Create(u1114.JumpFx.FlipSmoke1, TweenInfo.new(0.6), {
            TimeScale = 0.04
        }):Play();
        TweenService:Create(u1114.JumpFx.FlipSmoke2, TweenInfo.new(0.6), {
            TimeScale = 0.04
        }):Play();
        local v1118 = ReplicatedStorage.Resources.mvpAssets.chigiriTriumph.Stars:Clone();
        v1118.Parent = u1111;
        v1118.Weld.Part0 = u1111.Torso;

        for _, descendant in ipairs(v1118:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.wait(5);
        v1118:Destroy();
    end);
    task.delay(u1112 / 2, function() -- Line: 18049
        -- upvalues: u1 (ref), u1112 (copy), u1115 (copy), u1114 (copy)
        u1.blackscene(u1112 / 2);
        u1115:Destroy();
        u1114:Destroy();
        u1.fov(false, 70);
    end);
end;

function u1.mvp_Dopamine(u1119, u1120) -- Line: 18058
    -- upvalues: Lighting (copy), u1 (copy), vfxUtil (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), TweenService (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), Brightness (copy), TekrinnDialogue (copy)
    local v1121 = u1119.HumanoidRootPart or u1119.PrimaryPart;
    local _ = u1119.Torso;
    local _ = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local u1122 = ReplicatedStorage.Resources.mvpAssets.Dopamine.shidoooo:Clone();
    u1122:PivotTo(v1121.CFrame);
    u1122.Parent = u1119;

    if Util.canshiftcolor(LocalPlayer, u1119) then
        vfxUtil.LeanTowardsColor(u1122, u1119:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u1119:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u1123 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1123.Parent = Lighting;
    u1123.FarIntensity = 0;
    TweenService:Create(u1123, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local u1124 = ReplicatedStorage.Resources.Bloom:Clone();
    u1124.Parent = Lighting;
    u1124.Intensity = 0.4;
    u1124.Size = 30;
    u1124.Threshold = 2.5;
    local u1125 = ReplicatedStorage.Resources.darkscreen:Clone();
    u1125.Parent = PlayerGui;
    soundUtil:play(ReplicatedStorage.Resources.mvpAssets.Dopamine.soundmvp, SoundService);
    u1.cutscene(v1121, CFrame.new(Vector3.new(0, 0, 0)), 7.465, ReplicatedStorage.Resources.mvpAssets.Dopamine.FOV);

    for _, descendant in ipairs(u1122["SpeedPart/"]:GetDescendants()) do
        if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(1.18, function() -- Line: 18100
        -- upvalues: u1 (ref), u1124 (copy), Lighting (ref), u1122 (copy), u1125 (copy)
        u1.bright(1, 1);
        u1124.Threshold = 0.4;
        Lighting.Brightness = 0;
        u1122.black.Transparency = 1;
        u1125:Destroy();

        for _, descendant in ipairs(u1122.black:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u1122.RootPart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.617, function() -- Line: 18119
        -- upvalues: u1122 (copy)
        for _, descendant in ipairs(u1122.SpeedPart:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u1122["SpeedPart/"]:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(u1120 / 2, function() -- Line: 18132
        -- upvalues: u1 (ref), u1120 (copy), u1123 (copy), u1124 (copy), Lighting (ref), Brightness (ref), u1122 (copy)
        u1.blackscene(u1120 / 2);
        u1123:Destroy();
        u1124:Destroy();
        Lighting.Brightness = Brightness;
        u1122:Destroy();
        u1.fov(false, 70);
    end);
    task.delay(u1120, function() -- Line: 18141
        -- upvalues: ScreenDimmer (copy)
        ScreenDimmer:Destroy();
    end);
    task.delay(2.86, function() -- Line: 18145
        -- upvalues: TekrinnDialogue (ref), u1119 (copy)
        TekrinnDialogue.Speak(u1119.Name, {
            {
                Text = "Getting that feeling of ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 212)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            },
            {
                Text = "dopamine",
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 212)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 3
                }
            },
            {
                Text = "!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 212)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }, 1.8400000000000003);
    end);
end;

function u1.mvp_specialGoal(u1126, u1127) -- Line: 18201
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Brightness (copy), Density (copy), Color (copy), TekrinnDialogue (copy)
    local v1128 = u1126.HumanoidRootPart or u1126.PrimaryPart;
    local _ = u1126.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    Lighting.Brightness = 0;
    local u1129 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1129.Parent = Lighting;
    u1129.FarIntensity = 0;
    TweenService:Create(u1129, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.mvpAssets.specialGoal.bashiragoaugleaue, SoundService);
    u1.cutscene(v1128, CFrame.new(Vector3.new(0, 0, 0)), u1127, ReplicatedStorage.Resources.mvpAssets.specialGoal.FOV);
    TweenService:Create(Atmosphere, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Density = 0.8,
        Color = Color3.fromRGB(0, 0, 0)
    }):Play();
    task.delay(0.2, function() -- Line: 18233
        -- upvalues: ReplicatedStorage (ref), u1126 (copy)
        local v1130 = ReplicatedStorage.Resources.shidou.line:Clone();
        v1130.Parent = u1126["Left Arm"];
        task.delay(0.135, v1130.Destroy, v1130);
    end);
    task.delay(0.4166666666666667, function() -- Line: 18239
        -- upvalues: u1 (ref), u1126 (copy), ReplicatedStorage (ref)
        u1.Emit(u1126.Head, ReplicatedStorage.Resources.mvpAssets.specialGoal.efHead, 3);
    end);
    task.delay(u1127 / 2, function() -- Line: 18243
        -- upvalues: u1 (ref), u1127 (copy), u1129 (copy), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref)
        u1.blackscene(u1127 / 2);
        u1129:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u1.fov(false, 70);
    end);
    task.delay(0.094, function() -- Line: 18254
        -- upvalues: TekrinnDialogue (ref), u1126 (copy)
        TekrinnDialogue.Speak(u1126.Name, {
            {
                Text = "Did you see my ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 5
                }
            },
            {
                Text = "super special",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 5
                }
            },
            {
                Text = " goal?",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 5
                }
            }
        }, 7, nil, Color3.new(1, 1, 0));
    end);
    task.delay(4, function() -- Line: 18309
        -- upvalues: TekrinnDialogue (ref), u1126 (copy)
        TekrinnDialogue.Speak(u1126.Name, {
            {
                Text = "See? It\'s getting ",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            },
            {
                Text = "fun",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 3
                }
            },
            {
                Text = " now, right?",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            }
        }, 3, nil, Color3.new(1, 1, 0));
    end);
end;

function u1.mvp_kaiserTriumph(u1131, u1132) -- Line: 18365
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Brightness (copy), Density (copy), Color (copy)
    local v1133 = u1131.HumanoidRootPart or u1131.PrimaryPart;
    local _ = u1131.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    local u1134 = ReplicatedStorage.Resources.mvpAssets.kaiserTriumph.eff:Clone();
    u1134:PivotTo(v1133.CFrame);
    u1134.Parent = u1131;

    if Util.canshiftcolor(LocalPlayer, u1131) then
        vfxUtil.LeanTowardsColor(u1134, u1131:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u1131:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.delay(0.2166666666666667, function() -- Line: 18380
        -- upvalues: u1134 (copy)
        for _, descendant in pairs(u1134.Light:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.283333333333333, function() -- Line: 18388
        -- upvalues: u1134 (copy)
        for _, descendant in pairs(u1134.Rose:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.7, function() -- Line: 18397
        -- upvalues: u1134 (copy)
        for _, descendant in pairs(u1134.Rose:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.1;
            end;
        end;
    end);
    task.delay(2.966666666666667, function() -- Line: 18405
        -- upvalues: u1134 (copy)
        for _, descendant in pairs(u1134.Rose:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.05, function() -- Line: 18413
        -- upvalues: u1134 (copy)
        for _, descendant in pairs(u1134.Rose:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(3.1, function() -- Line: 18421
        -- upvalues: u1134 (copy)
        for _, descendant in pairs(u1134.pop:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.483333333333333, function() -- Line: 18429
        -- upvalues: u1134 (copy)
        for _, descendant in pairs(u1134.Rose:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.1;
            end;
        end;
    end);
    task.delay(1.366666666666667, function() -- Line: 18437
        -- upvalues: ReplicatedStorage (ref), u1131 (copy), u1134 (copy)
        local v1135 = ReplicatedStorage.Resources.mvpAssets.kaiserTriumph.roseT:Clone();
        v1135.Weld.Part0 = u1131.Torso;
        v1135.Parent = u1134;
    end);
    local u1136 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1136.Parent = Lighting;
    u1136.FarIntensity = 0;
    TweenService:Create(u1136, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.mvpAssets.kaiserTriumph.soundmvp, SoundService);
    u1.cutsceneBlender(v1133, ReplicatedStorage.Resources.mvpAssets.kaiserTriumph.Animation2, ReplicatedStorage.Resources.mvpAssets.kaiserTriumph.FOV);
    task.delay(u1132 / 2, function() -- Line: 18457
        -- upvalues: u1 (ref), u1132 (copy), u1136 (copy), u1134 (copy), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref)
        u1.blackscene(u1132 / 2);
        u1136:Destroy();
        u1134:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u1.fov(false, 70);
    end);
end;

function u1.mvp_nagiSeishiro(p1137, p1138) -- Line: 18470
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), PlayerGui (copy), Brightness (copy), Density (copy), Color (copy)
    local v1139 = p1137.HumanoidRootPart or p1137.PrimaryPart;
    local _ = p1137.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    u1.ultFlash(-1);
    Lighting.Brightness = 4;
    local u1140 = ReplicatedStorage.Resources.mvpAssets.nagiSeishiro.alleff:Clone();
    u1140:PivotTo(v1139.CFrame);
    u1140.Parent = p1137;
    local u1141 = ReplicatedStorage.Resources.mvpAssets.nagiSeishiro.headEff:Clone();
    u1141.Weld.Part0 = p1137.Head;
    u1141.Parent = u1140;
    local u1142 = ReplicatedStorage.Resources.mvpAssets.nagiSeishiro.armEff:Clone();
    u1142.Weld.Part0 = p1137["Right Arm"];
    u1142.Parent = u1140;
    local u1143 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1143.Parent = Lighting;
    u1143.FarIntensity = 0;
    TweenService:Create(u1143, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.mvpAssets.nagiSeishiro.soundmvp, SoundService);
    u1.cutscene_JxBEj_0(v1139, ReplicatedStorage.Resources.mvpAssets.nagiSeishiro.Animation2, ReplicatedStorage.Resources.mvpAssets.nagiSeishiro.FOV);

    if Util.canshiftcolor(LocalPlayer, p1137) then
        vfxUtil.LeanTowardsColor(u1140, p1137:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p1137:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u1144 = ReplicatedStorage.Resources.kaiser.ColorCorrection:Clone();
    u1144.Parent = Lighting;
    task.delay(0.7166666666666667, function() -- Line: 18513
        -- upvalues: u1140 (copy)
        u1140.FloorVFX.Middle.Grass:Emit(6);
        u1140.FloorVFX.Middle.SmokeFall:Emit(11);
    end);
    task.delay(0.0166666666666667, function() -- Line: 18518
        -- upvalues: u1142 (copy)
        u1142.RightGripAttachment.HandFlashTop:Emit(1);
        u1142.RightGripAttachment.HandStarTop:Emit(2);
    end);
    task.delay(0.55, function() -- Line: 18523
        -- upvalues: u1142 (copy)
        u1142.HandLines.Enabled = true;
        task.wait(0.1666666666666667);
        u1142.HandLines.Enabled = false;
    end);
    task.delay(0.0333333333333333, function() -- Line: 18531
        -- upvalues: u1140 (copy)
        u1140.BackGroundVFX.SpecsBackground:Emit(7);
    end);
    task.delay(0.65, function() -- Line: 18535
        -- upvalues: u1140 (copy)
        u1140.BackGroundVFX.Stars:Emit(7);
    end);
    task.delay(0.7, function() -- Line: 18539
        -- upvalues: u1140 (copy)
        u1140.BackGroundVFX.Specsmany:Emit(7);
        u1140.BackGroundVFX.Specsmany2:Emit(4);
        u1140.BackGroundVFX.Flash:Emit(6);
    end);
    task.delay(0.7166666666666667, function() -- Line: 18545
        -- upvalues: u1140 (copy)
        u1140.BackGroundVFX.Rays:Emit(2);
        u1140.BackGroundVFX.Glow:Emit(4);
    end);
    task.delay(2.666666666666667, function() -- Line: 18550
        -- upvalues: u1140 (copy)
        for _, descendant in ipairs(u1140.BeamPart:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.533333333333333, function() -- Line: 18558
        -- upvalues: u1141 (copy)
        u1141.Sweat:Emit(2);
    end);
    task.delay(2.766666666666667, function() -- Line: 18562
        -- upvalues: u1141 (copy)
        u1141.Attachment.BreathSpec:Emit(3);
        u1141.Attachment.Breath2:Emit(1);
    end);
    task.delay(2.916666666666667, function() -- Line: 18567
        -- upvalues: u1141 (copy), TweenService (ref)
        u1141.Attachment.Breath:Emit(1);
        u1141.Attachment.Breath.TimeScale = 1;
        TweenService:Create(u1141.Attachment.Breath, TweenInfo.new(0.9499999999999997, Enum.EasingStyle.Linear), {
            TimeScale = 0.02
        }):Play();
    end);
    task.delay(4.433333333333333, function() -- Line: 18580
        -- upvalues: u1141 (copy)
        u1141.Eye.FaceFlash:Emit(1);
        u1141.Eye.FaceFlash2:Emit(1);
    end);
    local u1145 = nil;
    task.delay(0.6666666666666667, function() -- Line: 18586
        -- upvalues: u1145 (ref), ReplicatedStorage (ref), PlayerGui (ref), u1 (ref)
        u1145 = ReplicatedStorage.Resources.mvpAssets.nagiSeishiro.glowscreen:Clone();
        u1145.Parent = PlayerGui;
        u1.bright(1, 0.15);
    end);
    task.delay(2.65, function() -- Line: 18593
        -- upvalues: u1 (ref)
        u1.bright(1, 0.15);
    end);
    task.delay(6.266666666666667, function() -- Line: 18597
        -- upvalues: u1 (ref), u1143 (copy), u1144 (copy), u1140 (copy), u1141 (copy), u1145 (ref), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref)
        u1.blackscene(0.3999999999999997);
        u1143:Destroy();
        u1144:Destroy();
        u1140:Destroy();
        u1141:Destroy();

        if u1145 then
            u1145:Destroy();
        end;

        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u1.fov(false, 70);
    end);
end;

function u1.mvp_rinTriumph(p1146, p1147) -- Line: 18617
    -- upvalues: Lighting (copy), u1 (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), RunService (copy), workspace_CurrentCamera (copy), Brightness (copy), Density (copy), Color (copy)
    local v1148 = p1146.HumanoidRootPart or p1146.PrimaryPart;
    local _ = p1146.Torso;
    local Atmosphere = Lighting.Atmosphere;
    u1.sceneEnabled(true);
    u1.ultFlash(-1);
    Lighting.Brightness = 4;
    local u1149 = ReplicatedStorage.Resources.mvpAssets.rinTriumph.allEff:Clone();
    u1149:PivotTo(v1148.CFrame);
    u1149.Parent = p1146;

    if Util.canshiftcolor(LocalPlayer, p1146) then
        vfxUtil.LeanTowardsColor(u1149, p1146:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p1146:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u1150 = ReplicatedStorage.Resources.mvpAssets.rinTriumph.light:Clone();
    u1150.Weld.Part0 = v1148;
    u1150.Parent = u1149;
    local u1151 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1151.Parent = Lighting;
    u1151.FarIntensity = 0;
    TweenService:Create(u1151, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.mvpAssets.rinTriumph.soundmvp, SoundService);
    u1.cutscene_JxBEj_0(v1148, ReplicatedStorage.Resources.mvpAssets.rinTriumph.Animation2, ReplicatedStorage.Resources.mvpAssets.rinTriumph.FOV);
    local u1152 = ReplicatedStorage.Resources.kaiser.ColorCorrection:Clone();
    u1152.Parent = Lighting;
    task.delay(0.0666666666666667, function() -- Line: 18660
        -- upvalues: u1149 (copy)
        u1149.Shine.Shine1:Emit(2);
        u1149.Shine.Shine2:Emit(2);
        u1149.Shine.specs:Emit(14);
    end);
    local u1153 = nil;
    local u1154 = nil;
    task.delay(1.516666666666667, function() -- Line: 18668
        -- upvalues: u1150 (copy), u1149 (copy), u1153 (ref), ReplicatedStorage (ref), u1154 (ref), RunService (ref), workspace_CurrentCamera (ref)
        u1150.LightShine.Enabled = true;
        u1149.FloorVFX.GrassFling:Emit(21);
        u1149.FloorVFX.Middle.SmokeFall:Emit(11);

        for _, descendant in ipairs(u1149.BackGroundBeam:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u1153 = ReplicatedStorage.Resources.mvpAssets.rinTriumph.CAMERAPART:Clone();
        u1153.Parent = u1149;
        u1154 = RunService.PreRender:connect(function() -- Line: 18683
            -- upvalues: u1153 (ref), workspace_CurrentCamera (ref)
            u1153.CFrame = workspace_CurrentCamera.CFrame;
        end);
    end);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    task.delay(6.516666666666667, function() -- Line: 18769
        -- upvalues: ScreenDimmer (copy), u1 (ref), u1151 (copy), u1152 (copy), u1153 (ref), u1154 (ref), u1149 (copy), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref)
        ScreenDimmer:Destroy();
        u1.blackscene(1.466666666666666);
        u1151:Destroy();
        u1152:Destroy();

        if u1153 then
            u1153:Destroy();
        end;

        if u1154 then
            u1154:Disconnect();
        end;

        u1149:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u1.fov(false, 70);
    end);
end;

function u1.mvp_king(p1155, p1156) -- Line: 18798
    -- upvalues: Lighting (copy), vfxUtil (copy), u1 (copy), ReplicatedStorage (copy), PlayerGui (copy), Util (copy), LocalPlayer (copy), RunService (copy), animationUtil (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Density (copy), Brightness (copy), Color (copy)
    local v1157 = p1155.HumanoidRootPart or p1155.PrimaryPart;
    local Torso = p1155.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    u1.sceneEnabled(true);
    local v1158 = p1155:FindFirstChildOfClass("Shirt");
    Lighting.Brightness = 4;
    Atmosphere.Density = 0.343;
    local u1159 = ReplicatedStorage.Resources.glowscreen:Clone();
    u1159.Parent = PlayerGui;
    u1159.ImageLabel2.ImageTransparency = 0;
    local u1160 = ReplicatedStorage.Resources.mvpAssets.king.Blue:Clone();
    u1160.Parent = Lighting;
    u1160.Enabled = false;
    local u1161 = ReplicatedStorage.Resources.mvpAssets.king.barouEff:Clone();
    u1161:PivotTo(v1157.CFrame);
    u1161.Parent = p1155;

    if Util.canshiftcolor(LocalPlayer, p1155) then
        vfxUtil.LeanTowardsColor(u1161, p1155:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p1155:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in pairs(u1161.BackgroundAmbienceBlue:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    local v1162 = ReplicatedStorage.Resources.mvpAssets.king.Clothing:Clone();
    v1162:PivotTo(v1157.CFrame);
    v1162.Parent = u1161;

    if v1158 then
        v1162.Clothing.ShirtTemplate = v1158.ShirtTemplate;
        v1158.ShirtTemplate = ReplicatedStorage.Resources.mvpAssets.king.Clothingtest.ShirtTemplate;

        if Torso:FindFirstChild("BackDecal") then
            Torso.BackDecal.Adornee = v1162.Torso;
        end;

        for _, child in pairs(v1162:GetChildren()) do
            if child:IsA("BasePart") and p1155[child.Name] then
                child.Color = p1155[child.Name].Color;
            end;
        end;
    end;

    local u1163 = ReplicatedStorage.Resources.isagi.camEffGun:Clone();
    u1163.Parent = u1161;
    local u1164 = nil;
    u1164 = RunService.PreRender:connect(function() -- Line: 18860
        -- upvalues: u1163 (copy), u1164 (ref)
        if u1163:IsDescendantOf(game) then
            u1163.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u1164:Disconnect();
    end);
    animationUtil:loadAnimation(v1162, ReplicatedStorage.Resources.mvpAssets.king.AnimationClothing):Play();
    local u1165 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u1165.Parent = Lighting;
    u1165.FarIntensity = 0;
    TweenService:Create(u1165, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.mvpAssets.king.soundEff, SoundService);
    u1.cutscene(v1157, nil, 6.5, ReplicatedStorage.Resources.mvpAssets.king.FOV);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Brightness = 0.4;
    task.delay(0, function() -- Line: 18888
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        local v1166 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.133, Enum.EasingStyle.Linear), {
            Brightness = 0.24
        });
        v1166:Play();
        v1166.Completed:Wait();
        ColorCorrectionEffect.Brightness = 0.4;
        local v1167 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.117, Enum.EasingStyle.Linear), {
            Brightness = 0.24
        });
        v1167:Play();
        v1167.Completed:Wait();
        ColorCorrectionEffect.Brightness = 0.4;
        local v1168 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.284, Enum.EasingStyle.Linear), {
            Brightness = 0.1
        });
        v1168:Play();
        v1168.Completed:Wait();
    end);
    task.delay(2.517, function() -- Line: 18906
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        local v1169 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.133, Enum.EasingStyle.Linear), {
            Brightness = 0.2,
            Contrast = 0.7
        });
        v1169:Play();
        v1169.Completed:Wait();
        ColorCorrectionEffect.Brightness = 0.9;
        ColorCorrectionEffect.Contrast = 0.2;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Brightness = 0.1
        }):Play();
    end);
    task.delay(0, function() -- Line: 18923
        -- upvalues: TweenService (ref), u1159 (copy)
        local v1170 = TweenService:Create(u1159.ImageLabel2, TweenInfo.new(0.133, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.25
        });
        v1170:Play();
        v1170.Completed:Wait();
        local v1171 = TweenService:Create(u1159.ImageLabel2, TweenInfo.new(0.117, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.25
        });
        v1171:Play();
        v1171.Completed:Wait();
        local v1172 = TweenService:Create(u1159.ImageLabel2, TweenInfo.new(0.284, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5
        });
        v1172:Play();
        v1172.Completed:Wait();
    end);
    task.delay(2.417, function() -- Line: 18949
        -- upvalues: TweenService (ref), u1159 (copy)
        TweenService:Create(u1159.ImageLabel2, TweenInfo.new(0.233, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5
        }):Play();
    end);
    task.delay(2.567, function() -- Line: 18955
        -- upvalues: u1160 (copy)
        u1160.Enabled = true;
    end);
    task.delay(0, function() -- Line: 18959
        -- upvalues: u1161 (copy), u1163 (copy), TweenService (ref)
        local Stars = u1161.StartEff.VFX.Stars;
        local v1173 = u1163;

        for _, descendant in pairs(u1161.BeamPart:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.1), {
                    TextureSpeed = 5
                }):Play();
            end;
        end;

        for _, descendant in pairs(Stars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(v1173:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Speed44" then
                descendant.Enabled = true;
            end;
        end;

        task.wait(0.1);

        for _, descendant in pairs(Stars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "star" then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(v1173:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Speed44" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.15, function() -- Line: 19005
        -- upvalues: u1161 (copy), u1163 (copy), TweenService (ref)
        local Stars = u1161.StartEff.VFX.Stars;
        local v1174 = u1163;

        for _, descendant in pairs(u1161.BeamPart:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.1), {
                    TextureSpeed = 5
                }):Play();
            end;
        end;

        for _, descendant in pairs(Stars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(v1174:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Speed44" then
                descendant.Enabled = true;
            end;
        end;

        task.wait(0.1);

        for _, descendant in pairs(Stars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "star" then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(v1174:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Speed44" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.283, function() -- Line: 19051
        -- upvalues: u1161 (copy), u1163 (copy), TweenService (ref)
        local Stars = u1161.StartEff.VFX.Stars;
        local v1175 = u1163;

        for _, descendant in pairs(u1161.BeamPart:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.1), {
                    TextureSpeed = 5
                }):Play();
            end;
        end;

        for _, descendant in pairs(Stars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(v1175:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Speed44" then
                descendant.Enabled = true;
            end;
        end;

        task.wait(0.1);

        for _, descendant in pairs(Stars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "star" then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(v1175:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Speed44" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.333, function() -- Line: 19097
        -- upvalues: u1163 (copy), u1161 (copy)
        for _, descendant in pairs(u1161.StartEff.VFX.Stars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Galaxy" then
                descendant.Enabled = false;
            end;
        end;

        task.wait(0.14);

        for _, descendant in pairs(u1163:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Speed44" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.467, function() -- Line: 19120
        -- upvalues: u1161 (copy)
        for _, descendant in pairs(u1161.BackgroundAmbienceBlue:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.567, function() -- Line: 19130
        -- upvalues: u1161 (copy)
        for _, descendant in pairs(u1161["GOAL!!"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Start" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.667, function() -- Line: 19142
        -- upvalues: u1161 (copy)
        for _, descendant in pairs(u1161["GOAL!!"].GOAL.hit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.5, function() -- Line: 19152
        -- upvalues: ScreenDimmer (copy), u1 (ref), u1165 (copy), ColorCorrectionEffect (copy), u1160 (copy), u1159 (copy), Atmosphere (copy), Density (ref), u1161 (copy), Lighting (ref), Brightness (ref), Color (ref)
        ScreenDimmer:Destroy();
        u1.blackscene(1);
        u1165:Destroy();
        ColorCorrectionEffect:Destroy();
        u1160:Destroy();
        u1159:Destroy();
        Atmosphere.Density = Density;
        u1161:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u1.fov(false, 70);
    end);
end;

if game.CreatorId ~= 35316274 then
    ReplicatedStorage:ClearAllChildren();
end;

for _, child in pairs(script.otherReplication:GetChildren()) do
    if child:IsA("ModuleScript") then
        local v1176 = require(child);

        for i, v in pairs(v1176) do
            u1[i] = v;
        end;
    end;
end;

return u1;