 

 

local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local trove = require(ReplicatedStorage.forum.trove);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.client.replication.BackgroundHighlight);
local styles = require(ReplicatedStorage.wiki).styles;
local LocalPlayer = Players.LocalPlayer;
local v9 = {
    messiFlow = function(p1) -- Line: 26, Name: messiFlow
        -- upvalues: ReplicatedStorage (copy), trove (copy), mainreplication (copy), RunService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), styles (copy), Lighting (copy), TweenService (copy)
        local messi = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("messi");
        local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");
        local Ball = p1:FindFirstChild("Ball");
        local Head = p1:FindFirstChild("Head");
        local u2 = trove.new();
        u2:AttachToInstance(p1);
        mainreplication.sceneEnabled(true);
        local u3 = u2:Add(messi.VFX.Flow.FlowVFX:Clone());
        u3:PivotTo(HumanoidRootPart.CFrame);
        u3.Parent = p1;
        local BallVFX = u3.BallVFX;
        BallVFX.Weld.Part0 = Ball or HumanoidRootPart;
        BallVFX.Parent = BallVFX.Weld.Part0;
        u2:Add(BallVFX);
        local HeadVFX = u3.HeadVFX;
        HeadVFX.Weld.Part0 = Head or HumanoidRootPart;
        HeadVFX.Parent = HeadVFX.Weld.Part0;
        u2:Add(HeadVFX);
        u2:Add(RunService.RenderStepped:Connect(function() -- Line: 51
            -- upvalues: u3 (copy), HumanoidRootPart (copy)
            u3:PivotTo(HumanoidRootPart.CFrame);
        end));
        u2:Construct(mainreplication.kuronaCam, HumanoidRootPart, nil, messi.VFX.Flow.FOV);
        local v4 = u2:Construct(messi.VFX.Flow.ScreenEffect);
        local v5 = u2:Construct(messi.VFX.Flow.ScreenEffect2);
        local v6 = u2:Construct(messi.VFX.Flow.ScreenEffect3);
        v4.Parent = workspace;
        v5.Parent = workspace;
        v6.Parent = workspace;

        for _, v in { "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
            local v7 = u2:Construct(messi.VFX.Flow.FlowTrail);
            v7.Parent = p1:FindFirstChild(v) or HumanoidRootPart;
            v7.Weld.Part0 = v7.Parent;

            if Util.canshiftcolor(LocalPlayer, p1) then
                vfxUtil.LeanTowardsColor(v7, p1:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p1:GetAttribute("CustomAlpha") or 0.985);
            end;
        end;

        if Util.canshiftcolor(LocalPlayer, p1) then
            vfxUtil.LeanTowardsColor({
                u3,
                BallVFX,
                HeadVFX,
                v4,
                v5,
                v6
            }, p1:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p1:GetAttribute("CustomAlpha") or 0.985);
        end;

        soundUtil:play(messi.Sounds.Flow, SoundService);
        u2:Add(task.delay(0.167, TekrinnDialogue.Speak, p1, {
            {
                Text = "Mess with the ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, styles.messi.color), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1.5
                }
            },
            {
                Text = "best...",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, styles.messi.color) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1.5
                }
            }
        }, 5));
        u2:Add(task.delay(0.83, shared.vfx.emit, BallVFX.Attachment));
        u2:Add(task.delay(0.95, shared.vfx.emit, HeadVFX));
        u2:Add(task.delay(1.15, shared.vfx.emit, BallVFX.Kick));
        u2:Add(task.delay(1.17, shared.vfx.emit, u3.Dribble));
        u2:Add(task.delay(1.43, shared.vfx.emit, BallVFX.Kick));
        u2:Add(task.delay(1.67, shared.vfx.emit, u3.Dribble2));
        u2:Add(task.delay(1.7, shared.vfx.emit, BallVFX.Kick));
        u2:Add(task.delay(1.98, shared.vfx.emit, BallVFX.Attachment));
        u2:Add(task.delay(2.25, shared.vfx.emit, BallVFX.Kick));
        u2:Add(task.delay(2.27, shared.vfx.emit, BallVFX.Emit));
        u2:Add(task.delay(2.28, shared.vfx.emit, v4));
        u2:Add(task.delay(2.83, shared.vfx.emit, v5));
        u2:Add(task.delay(2.87, shared.vfx.emit, u3.Burst));
        u2:Add(task.delay(2.88, shared.vfx.emit, v6));
        u2:Add(task.delay(3.133, TekrinnDialogue.Speak, p1, {
            {
                Text = "Die ",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            },
            {
                Text = "with the ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, styles.messi.color), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "rest.",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, styles.ronaldo.color) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1.5
                }
            }
        }, 5));
        mainreplication.ultFlash(-1, 1);
        u2:Add(function() -- Line: 190
            -- upvalues: mainreplication (ref)
            mainreplication.sceneEnabled(false);
            mainreplication.ultFlash(1, 1);
            mainreplication.fov(false, 40);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end);
        u2:Add(task.delay(4.5, function() -- Line: 197
            -- upvalues: u2 (copy), Lighting (ref), TweenService (ref)
            local v8 = u2:Construct(Instance, "ColorCorrectionEffect");
            v8.Parent = Lighting;
            TweenService:Create(v8, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Brightness = -1
            }):Play();
        end));
        u2:Add(task.delay(5, function() -- Line: 203
            -- upvalues: u2 (copy)
            u2:Destroy();
        end));
    end
};
local u10 = { { 0.517, 200, 1.2 }, { 1.267, 150, 1.3 }, { 1.967, 130, 1.8 }, { 2.993, 140, 1.15 }, { 3.533, 180, 0.7170000000000001 } };

function v9.messiDribbleVFX(u11, p12) -- Line: 216
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), trove (copy), Util (copy), vfxUtil (copy), styles (copy), Lighting (copy), TweenService (copy), mainreplication (copy), u10 (copy), Debris (copy)
    local messi = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("messi");
    local HumanoidRootPart = u11:FindFirstChild("HumanoidRootPart");
    local Ball = u11:FindFirstChild("Ball");
    local u13 = 0.95;

    if p12 then
        u13 = u13 + 0.1;
    end;

    local u14 = LocalPlayer.Character == u11;
    local u15 = trove.new();
    u15:AttachToInstance(Ball);
    local u16 = u15:Construct(messi.VFX.RunningEffects);
    u16.Part.Part0 = HumanoidRootPart;
    u16.Parent = u11;

    if Util.canshiftcolor(LocalPlayer, u11) then
        vfxUtil.LeanTowardsColor(u16, u11:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u11:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u17;

    if u14 then
        u17 = u15:Construct(Instance, "ColorCorrectionEffect");
        u17.TintColor = styles.messi.color;
        u17.Parent = Lighting;
        TweenService:Create(u17, TweenInfo.new(0.517, Enum.EasingStyle.Linear), {
            Brightness = 0.25
        }):Play();
        mainreplication.fov(true, 50, 0.517, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
    else
        u17 = nil;
    end;

    for i, v in u10 do
        local u18 = i == #u10;
        u15:Add(task.delay(v[1], function() -- Line: 251
            -- upvalues: u15 (copy), messi (copy), u11 (copy), Debris (ref), u14 (copy), mainreplication (ref), HumanoidRootPart (copy), v (copy), u13 (ref), u17 (ref), styles (ref), TweenService (ref), vfxUtil (ref), u16 (copy), u18 (copy), Ball (copy), Util (ref), LocalPlayer (ref)
            local v19 = u15:Construct(messi.VFX.DribbleHighlight);
            v19.Parent = u11;
            Debris:AddItem(v19, 1);

            if u14 then
                u15:Add(mainreplication.bodyVelocity(HumanoidRootPart, v[2] * u13, v[3]));
                u17.TintColor = styles.messi.color;
                u17.Brightness = 0.5;
                TweenService:Create(u17, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                    Brightness = 0,
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
                mainreplication.fov(false, 100);
                mainreplication.fov(true, 70, 0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
            end;

            vfxUtil.enableEffects(u16, not u18, "ParticleEmitter");
            local v20 = u15:Construct(messi.VFX.DribbleArcana);
            v20:PivotTo(HumanoidRootPart.CFrame * HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(Ball.Position)));
            v20.Parent = u11;
            Debris:AddItem(v20, vfxUtil.getEmittersLifetime(v20));
            local v21 = u15:Construct(messi.VFX.DribbleDenky);
            v21:PivotTo(HumanoidRootPart.CFrame);
            v21.Parent = u11;
            Debris:AddItem(v21, 1);

            if Util.canshiftcolor(LocalPlayer, u11) then
                vfxUtil.LeanTowardsColor({ v20, v21 }, u11:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u11:GetAttribute("CustomAlpha") or 0.985);
            end;

            TweenService:Create(v21, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = v21.CFrame * CFrame.new(0, 0, 6) * CFrame.Angles(0, 0, 1.5707963267948966)
            }):Play();
            shared.vfx.emit(v21);
            shared.vfx.emit(v20);
            shared.vfx.emit(v19);
        end));
    end;

    u15:Add(task.delay(4.25, function() -- Line: 289
        -- upvalues: u15 (copy)
        u15:Destroy();
    end));
end;

function v9.messiShootVFX(p22) -- Line: 294
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), trove (copy), RunService (copy), Util (copy), vfxUtil (copy), mainreplication (copy)
    local messi = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("messi");
    local u23 = LocalPlayer.Character == p22;
    local u24 = trove.new();
    u24:AttachToInstance(p22);
    local HumanoidRootPart = p22:FindFirstChild("HumanoidRootPart");
    local Ball = p22:FindFirstChild("Ball");
    local u25 = u24:Construct(messi.VFX.ShootVFX);
    u25:PivotTo(HumanoidRootPart.CFrame);
    u25.Parent = p22;
    local u26 = u24:Construct(messi.VFX.ShootHighlight);
    u26.Parent = p22;
    local BallVFX = u25.BallVFX;
    BallVFX.Weld.Part0 = Ball or HumanoidRootPart;
    BallVFX.Parent = BallVFX.Weld.Part0;
    u24:Add(BallVFX);
    u24:Add(RunService.RenderStepped:Connect(function() -- Line: 316
        -- upvalues: u25 (copy), HumanoidRootPart (copy)
        u25:PivotTo(HumanoidRootPart.CFrame);
    end));

    if Util.canshiftcolor(LocalPlayer, p22) then
        vfxUtil.LeanTowardsColor({ u25, BallVFX }, p22:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p22:GetAttribute("CustomAlpha") or 0.985);
    end;

    if u23 then
        mainreplication.fov(true, 50, 0.417, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
    end;

    u24:Add(task.delay(0.417, function() -- Line: 329
        -- upvalues: u23 (copy), mainreplication (ref), u26 (copy), BallVFX (copy), u25 (copy)
        if u23 then
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 40, 0.6499999999999999, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        end;

        shared.vfx.emit(u26);
        shared.vfx.emit(BallVFX);
        shared.vfx.emit(u25.balllift);
    end));
    u24:Add(task.delay(1.067, function() -- Line: 339
        -- upvalues: u23 (copy), mainreplication (ref), u25 (copy)
        if u23 then
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.5660000000000001, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        end;

        shared.vfx.emit(u25.KickMesh);
    end));
    u24:Add(task.delay(3, function() -- Line: 347
        -- upvalues: u24 (copy)
        u24:Destroy();
    end));
end;

function v9.messiPassVFX(p27) -- Line: 352
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), trove (copy), RunService (copy), Util (copy), vfxUtil (copy), TweenService (copy), mainreplication (copy)
    local messi = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("messi");
    local u28 = LocalPlayer.Character == p27;
    local u29 = trove.new();
    u29:AttachToInstance(p27);
    local HumanoidRootPart = p27:FindFirstChild("HumanoidRootPart");
    local Ball = p27:FindFirstChild("Ball");
    local u30 = u29:Construct(messi.VFX.PassVFX);
    u30:PivotTo(HumanoidRootPart.CFrame);
    u30.Parent = p27;
    local BallVFX = u30.BallVFX;
    BallVFX.Weld.Part0 = Ball or HumanoidRootPart;
    BallVFX.Parent = BallVFX.Weld.Part0;
    u29:Add(BallVFX);
    u29:Add(RunService.RenderStepped:Connect(function() -- Line: 371
        -- upvalues: u30 (copy), HumanoidRootPart (copy)
        u30:PivotTo(HumanoidRootPart.CFrame);
    end));
    local u31 = u29:Construct(messi.VFX.LegTrail);
    u31.Parent = p27;
    u31.Weld.Part0 = p27:FindFirstChild("Right Leg") or HumanoidRootPart;

    if Util.canshiftcolor(LocalPlayer, p27) then
        vfxUtil.LeanTowardsColor({ u30, BallVFX, u31 }, p27:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p27:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u32;

    if u28 then
        u32 = u29:Construct(vfxUtil.getMoonEffects);
        u32.Vignette.ImageColor3 = Color3.fromRGB(97, 169, 255);
        u32["Screen Cover"].BackgroundColor3 = Color3.fromRGB(36, 60, 255);
        TweenService:Create(u32.Vignette, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(u32["Screen Cover"], TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            BackgroundTransparency = 0.5
        }):Play();
        mainreplication.fov(true, 50, 0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
    else
        u32 = nil;
    end;

    shared.vfx.emit(u30.Lines);
    u29:Add(task.delay(0.017, shared.vfx.emit, BallVFX));
    u29:Add(task.delay(0.033, shared.vfx.emit, u31));
    u29:Add(task.delay(0.383, shared.vfx.emit, u30.BlueImpact));
    u29:Add(task.delay(0.4, function() -- Line: 402
        -- upvalues: u28 (copy), mainreplication (ref), TweenService (ref), u32 (ref), u30 (copy)
        if u28 then
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.417, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
            TweenService:Create(u32.Vignette, TweenInfo.new(0.417, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            TweenService:Create(u32["Screen Cover"], TweenInfo.new(0.417, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        end;

        shared.vfx.emit(u30.Shoot);
    end));
    u29:Add(task.delay(0.417, shared.vfx.emit, u30.WindImpact));
    u29:Add(task.delay(0.433, shared.vfx.emit, u30.GradJay));
    u29:Add(task.delay(0.45, shared.vfx.emit, u30.WindImpact));
    u29:Add(task.delay(0.417, function() -- Line: 415
        -- upvalues: u31 (copy)
        u31:Destroy();
    end));
    u29:Add(task.delay(3, function() -- Line: 419
        -- upvalues: u29 (copy)
        u29:Destroy();
    end));
end;

function v9.messiInterceptStart(p33) -- Line: 424
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), trove (copy), Util (copy), vfxUtil (copy), mainreplication (copy)
    local messi = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("messi");
    local u34 = LocalPlayer.Character == p33;
    local HumanoidRootPart = p33:FindFirstChild("HumanoidRootPart");
    local u35 = trove.new();
    u35:AttachToInstance(p33);
    local u36 = u35:Construct(messi.VFX.Intercept.Startup);
    u36.Parent = HumanoidRootPart;

    if Util.canshiftcolor(LocalPlayer, p33) then
        vfxUtil.LeanTowardsColor(u36, p33:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p33:GetAttribute("CustomAlpha") or 0.985);
    end;

    if u34 then
        mainreplication.fov(true, 40, 0.183, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    end;

    u35:Add(task.delay(0.183, function() -- Line: 443
        -- upvalues: u34 (copy), mainreplication (ref), u36 (copy)
        if u34 then
            mainreplication.fov(false, 70);
            mainreplication.fov(true, 100, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;

        shared.vfx.emit(u36);
    end));
    u35:Add(task.delay(0.7, function() -- Line: 451
        -- upvalues: u34 (copy), mainreplication (ref)
        if u34 then
            mainreplication.fov(true, 70, 0.583, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;
    end));
    local task_delay = task.delay;
    local v37 = vfxUtil.getEmittersLifetime(u36) + 0.3;
    u35:Add(task_delay(math.max(v37, 1.283), function() -- Line: 457
        -- upvalues: u35 (copy)
        u35:Destroy();
    end));
end;

function v9.messiInterceptCutscene(p38) -- Line: 463
    -- upvalues: ReplicatedStorage (copy), trove (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), styles (copy), Lighting (copy), TweenService (copy)
    local messi = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("messi");
    local HumanoidRootPart = p38:FindFirstChild("HumanoidRootPart");
    local Torso = p38:FindFirstChild("Torso");
    local Head = p38:FindFirstChild("Head");
    local u39 = trove.new();
    u39:AttachToInstance(p38);
    mainreplication.sceneEnabled(true);
    local v40 = u39:Construct(messi.VFX.Intercept.InterceptVFX);
    v40.Torso.Weld.Part0 = Torso or HumanoidRootPart;
    v40.Head.Weld.Part0 = Head or HumanoidRootPart;
    v40.FloorDust.Weld.Part0 = HumanoidRootPart;
    v40.Parent = p38;

    if Util.canshiftcolor(LocalPlayer, p38) then
        vfxUtil.LeanTowardsColor(v40, p38:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p38:GetAttribute("CustomAlpha") or 0.985);
    end;

    u39:Construct(mainreplication.kuronaCam, HumanoidRootPart, nil, messi.VFX.Intercept.FOV, nil, 0.175);

    for _, v in { "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
        u39:Construct(messi.VFX.Flow.FlowTrail).Parent = p38:FindFirstChild(v) or HumanoidRootPart;
    end;

    soundUtil:play(messi.Sounds.TrapCutscene, SoundService);
    u39:Add(task.delay(0.05, shared.vfx.emit, v40.Torso));
    u39:Add(task.delay(1, shared.vfx.emit, v40.FloorDust));
    u39:Add(task.delay(1.983, shared.vfx.emit, v40.Head));
    u39:Add(task.delay(2, TekrinnDialogue.Speak, p38, {
        {
            Text = "Too slow.",
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, styles.messi.color), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 1,
                Lifetime = 1.5
            }
        }
    }, 1));
    u39:Add(task.delay(3, function() -- Line: 516
        -- upvalues: u39 (copy), Lighting (ref), TweenService (ref)
        local v41 = u39:Construct(Instance, "ColorCorrectionEffect");
        v41.Parent = Lighting;
        TweenService:Create(v41, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = -1
        }):Play();
    end));
    u39:Add(function() -- Line: 522
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1);
    end);
    u39:Add(task.delay(3.5, function() -- Line: 527
        -- upvalues: u39 (copy)
        u39:Destroy();
    end));
end;

function v9.messiInterceptShot(p42) -- Line: 532
    -- upvalues: ReplicatedStorage (copy), trove (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy)
    local messi = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("messi");
    local HumanoidRootPart = p42:FindFirstChild("HumanoidRootPart");
    p42:FindFirstChild("Torso");
    local Ball = p42:FindFirstChild("Ball");
    local u43 = trove.new();
    u43:AttachToInstance(Ball);
    mainreplication.sceneEnabled(true);
    local u44 = u43:Construct(messi.VFX.Intercept.TrapShotVFX);
    u44.BallVFX.Weld.Part0 = Ball or HumanoidRootPart;
    u44.TrapShot.Weld.Part0 = HumanoidRootPart;

    for _, child in u44:GetChildren() do
        if child:FindFirstChild("Weld") and not child.Weld.Part0 then
            child.Weld.Part0 = p42:FindFirstChild(child.Name) or HumanoidRootPart;
        end;
    end;

    u44.Parent = p42;

    if Util.canshiftcolor(LocalPlayer, p42) then
        vfxUtil.LeanTowardsColor(u44, p42:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p42:GetAttribute("CustomAlpha") or 0.985);
    end;

    u43:Construct(mainreplication.kuronaCam, HumanoidRootPart, nil, messi.VFX.Intercept.ShotFOV, nil);
    soundUtil:play(messi.Sounds.TrapShot, SoundService);
    u43:Add(task.delay(0.05, shared.vfx.emit, u44.BallVFX.HeelFlick));
    u43:Add(task.delay(0.583, function() -- Line: 560
        -- upvalues: u44 (copy)
        shared.vfx.emit(u44.Torso);
        shared.vfx.emit(u44.Head);
        shared.vfx.emit(u44["Right Arm"]);
        shared.vfx.emit(u44["Right Leg"]);
    end));
    u43:Add(task.delay(0.584, shared.vfx.emit, u44.BallVFX));
    u43:Add(task.delay(1.667, shared.vfx.emit, u44.TrapShot));
    u43:Add(function() -- Line: 569
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1);
    end);
    u43:Add(task.delay(2.9, function() -- Line: 574
        -- upvalues: u43 (copy)
        u43:Destroy();
    end));
end;

local u45 = {
    { 0.18299999999999983, 5.5 },
    { 0.30000000000000004, 9.5 },
    {
        0.16699999999999982,
        3,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    }
};

function v9.messiNutmeg(p46) -- Line: 585
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), trove (copy), Util (copy), vfxUtil (copy), u45 (copy), Debris (copy), TweenService (copy)
    local messi = ReplicatedStorage:WaitForChild("Resources"):WaitForChild("messi");
    local HumanoidRootPart = p46:FindFirstChild("HumanoidRootPart");
    p46:FindFirstChild("Torso");
    local Ball = p46:FindFirstChild("Ball");
    local u47 = LocalPlayer.Character == p46;
    local u48 = trove.new();
    u48:AttachToInstance(Ball);
    local v49 = u48:Construct(messi.VFX.NutmegHitVFX);

    for _, child in v49:GetChildren() do
        if child:FindFirstChild("Weld") and not child.Weld.Part0 then
            child.Weld.Part0 = p46:FindFirstChild(child.Name) or HumanoidRootPart;
        end;
    end;

    v49.Parent = p46;

    if Util.canshiftcolor(LocalPlayer, p46) then
        vfxUtil.LeanTowardsColor(v49, p46:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p46:GetAttribute("CustomAlpha") or 0.985);
    end;

    shared.vfx.emit(v49["Left Arm"].Hit, v49["Left Arm"].Smoke11, v49["Left Arm"].Smoke34);
    u48:Add(task.delay(0.1, shared.vfx.emit, v49.Ball.Attachment));
    u48:Add(task.delay(0.3, shared.vfx.emit, v49.Dribble));
    u48:Add(task.delay(0.33, shared.vfx.emit, v49["Right Leg"].Beam116, v49["Right Arm"].Beam116, v49["Left Leg"].Beam116, v49["Left Arm"].Beam116));
    u48:Add(task.delay(0.27, shared.vfx.emit, v49.Ball.Kick));
    u48:Add(task.delay(0.4, shared.vfx.emit, v49["Left Arm"].Sparkles, v49["Left Leg"].Sparkles, v49["Right Leg"].Sparkles, v49["Right Arm"].Sparkles));
    u48:Add(task.delay(0.57, shared.vfx.emit, v49.Ball.Attachment));
    u48:Add(task.delay(0.7, shared.vfx.emit, v49.Ball.Kick));
    u48:Add(task.delay(0.75, shared.vfx.emit, v49.Dribble3));
    u48:Add(task.delay(1.23, shared.vfx.emit, v49.Ball.Attachment));
    u48:Add(task.delay(1.37, shared.vfx.emit, v49.Dribble2));
    u48:Add(task.delay(1.38, shared.vfx.emit, v49.Mesh));
    u48:Add(task.delay(1.4, shared.vfx.emit, v49.Ball.Kick));
    u48:Add(task.delay(1.35, function() -- Line: 620
        -- upvalues: u47 (copy), u45 (ref), HumanoidRootPart (copy), Debris (ref), u48 (copy), TweenService (ref)
        if u47 then
            for _, v in u45 do
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(400000, 0, 400000);
                BodyVelocity.Velocity = HumanoidRootPart.CFrame.LookVector * v[2] * (4 / v[1]);
                BodyVelocity.Parent = HumanoidRootPart;
                Debris:AddItem(BodyVelocity, v[1]);
                u48:Add(BodyVelocity);

                if v[3] then
                    TweenService:Create(BodyVelocity, TweenInfo.new(v[1], v[3], v[4]), {
                        Velocity = HumanoidRootPart.CFrame.LookVector
                    }):Play();
                end;

                task.wait(v[1]);
            end;
        end;
    end));
    u48:Add(task.delay(2.05, function() -- Line: 637
        -- upvalues: u48 (copy)
        u48:Destroy();
    end));
end;

return v9;