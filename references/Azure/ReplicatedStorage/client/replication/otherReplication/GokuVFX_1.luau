 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local Goku = vfxUtil.getResources().Goku;
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = {};
local u2 = {};
local v89 = {
    GokuWorldDestroyVFX = function(u3) -- Line: 34, Name: GokuWorldDestroyVFX
        -- upvalues: Goku (copy), trove (copy), vfxUtil (copy), RunService (copy)
        if not u3 then
            return;
        end;

        local WorldDestroy = Goku:FindFirstChild("WorldDestroy");

        if not WorldDestroy then
            return;
        end;

        local u4 = trove.new();
        u4:AttachToInstance(u3);
        local Root = vfxUtil.getRoot(u3);
        local u5 = u3:FindFirstChild("Torso") or u3:FindFirstChild("UpperTorso");

        if not (u5 and u5:IsA("BasePart")) then
            u5 = nil;
        end;

        if not (Root and u5) then
            u4:Destroy();

            return;
        end;

        local function placeDashFollower(p6: userdata, p7) -- Line: 55
            -- upvalues: Root (copy)
            if not Root.Parent then
                return;
            end;

            local v8 = Root.CFrame * p7;

            if p6:IsA("Model") then
                p6:PivotTo(v8);

                return;
            end;

            if p6:IsA("BasePart") then
                p6:PivotTo(v8);
            end;
        end;

        u4:Add(task.delay(0.13, function() -- Line: 67
            -- upvalues: WorldDestroy (copy), u5 (copy)
            local v9 = WorldDestroy:FindFirstChild("4thBaseMoveVFX");

            if not v9 then
                return;
            end;

            local v10 = v9:Clone();
            v10.Parent = u5;
            shared.vfx.emit(v10).Finished:await();
            v10:Destroy();
        end));
        u4:Add(task.delay(1, function() -- Line: 80
            -- upvalues: WorldDestroy (copy), u3 (copy), u5 (copy)
            local v11 = WorldDestroy:FindFirstChild("ssjaura") or WorldDestroy:FindFirstChild("SSJaura");

            if not v11 then
                return;
            end;

            local v12 = v11:Clone();
            v12.Parent = u3;
            local v13 = v12:FindFirstChildOfClass("Weld");

            if v13 and v13:IsA("Weld") then
                v13.Part0 = u5;
            end;

            shared.vfx.emit(v12).Finished:await();
            v12:Destroy();
        end));
        u4:Add(task.delay(2.18, function() -- Line: 97
            -- upvalues: WorldDestroy (copy), u4 (copy), Root (copy), RunService (ref)
            local v14 = WorldDestroy:FindFirstChild("SSJauraFLY") or WorldDestroy:FindFirstChild("ssjauraFLY");
            local v15 = WorldDestroy:FindFirstChild("dashwindbeam") or WorldDestroy:FindFirstChild("DashWindBeam");
            local DashWindMesh = WorldDestroy:FindFirstChild("DashWindMesh");

            if not (v14 and (v15 and DashWindMesh)) then
                return;
            end;

            local u16 = v14:Clone();
            local u17 = v15:Clone();
            local u18 = DashWindMesh:Clone();
            u16.Parent = workspace.Effects;
            u17.Parent = workspace.Effects;
            u18.Parent = workspace.Effects;
            u4:Add(u16);
            u4:Add(u17);
            u4:Add(u18);
            local u19 = CFrame.new(0.456, -0.331, -1.284) * CFrame.fromEulerAnglesXYZ(-1.086205659978671, 2.057900267733994, -2.214840274073324);
            local CFrame_new_ret = CFrame.new(0.6, 0.092, -6.419);
            local u20 = CFrame.new(0.382, 0.006, 2.144) * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, 1.5707963267948966);

            if Root.Parent then
                local v21 = Root.CFrame * u19;

                if u16:IsA("Model") then
                    u16:PivotTo(v21);
                elseif u16:IsA("BasePart") then
                    u16:PivotTo(v21);
                end;
            end;

            if Root.Parent then
                local v22 = Root.CFrame * CFrame_new_ret;

                if u17:IsA("Model") then
                    u17:PivotTo(v22);
                elseif u17:IsA("BasePart") then
                    u17:PivotTo(v22);
                end;
            end;

            if Root.Parent then
                local v23 = Root.CFrame * u20;

                if u18:IsA("Model") then
                    u18:PivotTo(v23);
                elseif u18:IsA("BasePart") then
                    u18:PivotTo(v23);
                end;
            end;

            shared.vfx.emit(u16, u17, u18);
            local u32 = u4:Connect(RunService.PreRender, function() -- Line: 124
                -- upvalues: u16 (copy), u19 (copy), Root (ref), u17 (copy), CFrame_new_ret (copy), u18 (copy), u20 (copy)
                local v24 = u16;
                local v25 = u19;

                if Root.Parent then
                    local v26 = Root.CFrame * v25;

                    if v24:IsA("Model") then
                        v24:PivotTo(v26);
                    elseif v24:IsA("BasePart") then
                        v24:PivotTo(v26);
                    end;
                end;

                local v27 = u17;
                local v28 = CFrame_new_ret;

                if Root.Parent then
                    local v29 = Root.CFrame * v28;

                    if v27:IsA("Model") then
                        v27:PivotTo(v29);
                    elseif v27:IsA("BasePart") then
                        v27:PivotTo(v29);
                    end;
                end;

                local v30 = u18;

                if not Root.Parent then
                    return;
                end;

                local v31 = Root.CFrame * u20;

                if v30:IsA("Model") then
                    v30:PivotTo(v31);

                    return;
                end;

                if v30:IsA("BasePart") then
                    v30:PivotTo(v31);
                end;
            end);
            u4:Add(task.delay(1.9199999999999995, function() -- Line: 131
                -- upvalues: u4 (ref), u32 (copy), u16 (copy), u17 (copy), u18 (copy)
                u4:Remove(u32);
                u4:Remove(u16);
                u4:Remove(u17);
                u4:Remove(u18);
            end));
        end));
        u4:Add(task.delay(6, function() -- Line: 139
            -- upvalues: u4 (copy)
            u4:Destroy();
        end));
    end,

    GokuWorldDestroyYell = function(p33) -- Line: 144, Name: GokuWorldDestroyYell
        -- upvalues: TekrinnDialogue (copy)
        if not p33 then
            return;
        end;

        TekrinnDialogue.Speak(p33, {
            {
                Text = "I WILL NOT LET YOU DESTROY MY WORLD!!!",
                Italic = true,
                Color = ColorSequence.new(Color3.fromRGB(255, 210, 60), Color3.fromRGB(255, 255, 255)),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 2
                },
                TextStrokeColor = Color3.new(0, 0, 0)
            }
        }, 3.5, nil, nil, true);
    end,

    GokuFlow = function(u34) -- Line: 165, Name: GokuFlow
        -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), LocalPlayer (copy), MoonPropertyAnimator (copy)
        local Goku2 = vfxUtil.getResources():WaitForChild("Goku");
        local u35 = trove.new();
        u35:AttachToInstance(u34);
        local Flow = Goku2.Flow;
        local Root = vfxUtil.getRoot(u34);
        local _ = vfxUtil.forge;
        local v36 = u35:Construct(Flow.aurafall);
        vfxUtil.setupAura(u34, v36, true);
        v36.Parent = workspace.Effects;
        local v37 = u35:Construct(Flow.aura);
        vfxUtil.setupAura(u34, v37, true);
        v37.Parent = workspace.Effects;
        mainreplication.sceneEnabled(true);
        mainreplication.EnableMapLights(false);
        mainreplication.cutsceneBlender(Root, Flow.Camera, Flow.FOV, nil, nil, nil);
        soundUtil:play(Flow.Sound, SoundService);
        local _baseplate_controller, u38 = vfxUtil.get_baseplate_controller();
        u35:Add(vfxUtil.make_baseplate_connection(_baseplate_controller.update));
        u38.Transparency = 1;
        u35:Add(function() -- Line: 192
            -- upvalues: u38 (copy), _baseplate_controller (copy)
            u38.Transparency = 0;
            _baseplate_controller.update();
        end);
        local v39 = u35:Add(Flow.VFX:Clone());
        v39:PivotTo(CFrame.new(Root.Position, Root.Position - Root.CFrame.LookVector) * CFrame.new(0, -639, 0) * CFrame.Angles(0, 3.141592653589793, 0));
        v39.Parent = workspace.Effects;
        vfxUtil.execute_compiled(Flow.Compiled, u35, v39, v36, v37);
        u35:Add(task.delay(20.4, function() -- Line: 210
            -- upvalues: TekrinnDialogue (ref), u34 (copy)
            TekrinnDialogue.Speak(u34, {
                {
                    Text = "This is where the real fight starts.",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(0.54902, 0.784314, 1), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 3, nil, nil, true);
        end));
        local ScreenGui = Instance.new("ScreenGui");
        local Frame = Instance.new("Frame");
        Frame.BackgroundColor3 = Color3.new(0, 0, 0);
        Frame.BackgroundTransparency = 1;
        Frame.Size = UDim2.new(1, 0, 1, 0);
        Frame.Parent = ScreenGui;
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.DisplayOrder = 1000;
        local v40 = u35:Construct(MoonPropertyAnimator);
        v40:LoadSave(Flow.Moon, MoonPropertyAnimator.ConvertSave(Flow.Moon, {
            UltraInstinct = v39,
            ["Screen Cover"] = Frame,
            Baseplate = u38
        }));
        v40:SetRoot(Root);
        v40:PlayAll();
        v40:SetOriginalRoot(CFrame.new(0, 3, 0));
        u35:Add(function() -- Line: 249
            -- upvalues: mainreplication (ref), ScreenGui (copy), Root (copy)
            mainreplication.sceneEnabled(false);
            mainreplication.EnableMapLights(true);

            if ScreenGui then
                ScreenGui:Destroy();
            end;

            if Root then
                Root.Anchored = false;
            end;
        end);
        u35:Add(task.delay(26, function() -- Line: 261
            -- upvalues: u35 (copy)
            u35:Destroy();
        end));
    end,

    KamehamehaOn = function(p41) -- Line: 268, Name: KamehamehaOn
        -- upvalues: Goku (copy), vfxUtil (copy), soundUtil (copy), trove (copy), mainreplication (copy), workspace_CurrentCamera (copy), MoonPropertyAnimator (copy), RunService (copy)
        local Ball = Goku.Kamehameha.Ball;
        local Root = vfxUtil.getRoot(p41);
        soundUtil:play(Ball.Sound, Root);
        local u42 = trove.new();
        u42:AttachToInstance(p41);
        u42:Add(task.delay(6.6, function() -- Line: 278
            -- upvalues: u42 (copy)
            u42:Destroy();
        end));
        u42:Add(task.delay(4.333, function() -- Line: 281
            -- upvalues: u42 (copy), mainreplication (ref), Root (copy)
            u42:Add(mainreplication.bodyVelocity(Root, 150, 1.6669999999999998, nil, nil, false, TweenInfo.new(6, Enum.EasingStyle.Quart, Enum.EasingDirection.In)));
        end));
        local v43 = u42:Clone(Ball.VFX);
        local Children = v43:GetChildren();
        table.remove(Children, table.find(Children, v43.R6));
        table.remove(Children, table.find(Children, v43.Core));
        local u44 = {};

        for _, v in Children do
            u44[v] = v43.Core:GetPivot():ToObjectSpace(v:GetPivot());
        end;

        v43:PivotTo(Root.CFrame);
        vfxUtil.setupAura(p41, v43.R6, true, true);
        v43.Parent = workspace.Effects;
        local v45 = {
            Workspace = v43,
            CurrentCamera = workspace_CurrentCamera
        };
        vfxUtil.contain_lighting(u42, v45, Ball.Lighting);

        for _, v in MoonPropertyAnimator.ConvertSave(Ball.Moon, v45) do
            if table.find(Children, v) then
                table.remove(Children, table.find(Children, v));
            end;
        end;

        local u46 = u42:Connect(RunService.PreRender, function() -- Line: 312
            -- upvalues: Children (copy), Root (copy), u44 (copy)
            for _, v in Children do
                v:PivotTo(Root.CFrame:ToWorldSpace(u44[v]));
            end;
        end);
        u42:Add(task.delay(6, function() -- Line: 318
            -- upvalues: u42 (copy), u46 (copy)
            u42:Remove(u46);
        end));
        local v47 = u42:Construct(MoonPropertyAnimator);
        v47:LoadAndConvertSave(Ball.Moon, v45);
        v47:SetOriginalRoot(Ball.VFX.Core.CFrame);
        v47:SetRoot(Root);
        v47:PlayAll();
        u42:Add(function() -- Line: 328
            -- upvalues: workspace_CurrentCamera (ref)
            workspace_CurrentCamera.FieldOfView = 70;
        end);
        vfxUtil.execute_compiled(Ball.Compiled, u42, v43);
    end,

    KamehamehaOff = function(p48) -- Line: 335, Name: KamehamehaOff
        -- upvalues: Goku (copy), vfxUtil (copy), soundUtil (copy), trove (copy), workspace_CurrentCamera (copy), MoonPropertyAnimator (copy), RunService (copy)
        local None = Goku.Kamehameha.None;
        local Root = vfxUtil.getRoot(p48);
        soundUtil:play(None.Sound, Root);
        local u49 = trove.new();
        u49:AttachToInstance(p48);
        u49:Add(task.delay(6.6, function() -- Line: 345
            -- upvalues: u49 (copy)
            u49:Destroy();
        end));
        local v50 = u49:Clone(None.VFX);
        local Children = v50:GetChildren();
        table.remove(Children, table.find(Children, v50.R6two));
        table.remove(Children, table.find(Children, v50.Core));
        local u51 = {};

        for _, v in Children do
            u51[v] = v50.Core:GetPivot():ToObjectSpace(v:GetPivot());
        end;

        v50:PivotTo(Root.CFrame);
        vfxUtil.setupAura(p48, v50.R6two, true, true);
        v50.Parent = workspace.Effects;
        local v52 = {
            Workspace = v50,
            CurrentCamera = workspace_CurrentCamera
        };
        vfxUtil.contain_lighting(u49, v52, None.Lighting);

        for _, v in MoonPropertyAnimator.ConvertSave(None.Moon, v52) do
            if table.find(Children, v) then
                table.remove(Children, table.find(Children, v));
            end;
        end;

        local u53 = u49:Connect(RunService.PreRender, function() -- Line: 376
            -- upvalues: Children (copy), Root (copy), u51 (copy)
            for _, v in Children do
                v:PivotTo(Root.CFrame:ToWorldSpace(u51[v]));
            end;
        end);
        u49:Add(task.delay(5.583, function() -- Line: 382
            -- upvalues: u49 (copy), u53 (copy)
            u49:Remove(u53);
        end));
        local v54 = u49:Construct(MoonPropertyAnimator);
        v54:LoadAndConvertSave(None.Moon, v52);
        v54:SetOriginalRoot(None.VFX.Core.CFrame);
        v54:SetRoot(Root);
        v54:PlayAll();
        u49:Add(function() -- Line: 392
            -- upvalues: workspace_CurrentCamera (ref)
            workspace_CurrentCamera.FieldOfView = 70;
        end);
        vfxUtil.execute_compiled(None.Compiled, u49, v50);
    end,

    GokuMeteorRush = function(u55: any, p56: userdata) -- Line: 401, Name: GokuMeteorRush
        -- upvalues: trove (copy), Goku (copy), vfxUtil (copy), u1 (copy), RunService (copy)
        local u57 = trove.new();
        u57:AttachToInstance(u55);
        u57:AttachToInstance(p56);
        local MeteorRush = Goku.MeteorRush;
        local Root = vfxUtil.getRoot(u55);
        local u58 = u57:Clone(MeteorRush.SSJauraFLY);
        local u59 = u57:Clone(MeteorRush.FlyBeam);
        local u60 = u57:Clone(MeteorRush.FlyWindMesh);
        u58.Parent = workspace.Effects;
        u59.Parent = workspace.Effects;
        u60.Parent = workspace.Effects;
        u1[u55] = {
            auraFly = u58,
            flyBeam = u59,
            flyWindMesh = u60
        };
        u57:Add(RunService.PreRender:Connect(function() -- Line: 423
            -- upvalues: Root (copy), u58 (copy), u59 (copy), u60 (copy)
            if not (Root and Root.Parent) then
                return;
            end;

            local CFrame2 = Root.CFrame;
            u58:PivotTo(CFrame2 * CFrame.new(0.456, -0.331, -1.284) * CFrame.fromEulerAnglesXYZ(-1.086205659978671, 2.057900267733994, -2.214840274073324));
            u59:PivotTo(CFrame2 * CFrame.new(0.6, 0.092, -6.419));
            u60:PivotTo(CFrame2 * CFrame.new(0.382, 0.006, 2.144) * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, 1.5707963267948966));
        end));
        u57:Add(function() -- Line: 432
            -- upvalues: u1 (ref), u55 (copy)
            u1[u55] = nil;
        end);
        u57:Add(task.delay(10, function() -- Line: 436
            -- upvalues: u57 (copy)
            u57:Destroy();
        end));
    end,

    GokuMeteorRushFly = function(p61) -- Line: 441, Name: GokuMeteorRushFly
        -- upvalues: u1 (copy), vfxUtil (copy), Players (copy), mainreplication (copy)
        local v62 = u1[p61];

        if not v62 then
            return;
        end;

        shared.vfx.emit(v62.auraFly, v62.flyBeam, v62.flyWindMesh);
        local Root = vfxUtil.getRoot(p61);

        if not Root then
            return;
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(p61) then
            mainreplication.bodyVelocity(Root, 200, 2, nil, nil, nil, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
            mainreplication.cameraShake(10, 1.5, 6);
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;
    end,

    GokuGodShot = function(p63) -- Line: 469, Name: GokuGodShot
        -- upvalues: trove (copy)
        local u64 = trove.new();
        u64:AttachToInstance(p63);
        u64:Add(task.delay(5, function() -- Line: 473
            -- upvalues: u64 (copy)
            u64:Destroy();
        end));
    end,

    GokuGodShotKick = function(p65) -- Line: 478, Name: GokuGodShotKick
    end,

    GokuSSJ = function(p66) -- Line: 484, Name: GokuSSJ
        -- upvalues: trove (copy), vfxUtil (copy), Goku (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
        local u67 = trove.new();
        u67:AttachToInstance(p66);
        local Root = vfxUtil.getRoot(p66);

        if not Root then
            u67:Destroy();

            return;
        end;

        u67:Clone(Goku.God.Aura).Parent = Root;
        mainreplication.sceneEnabled(true);
        local v68 = ReplicatedStorage.Resources.DepthOfField:Clone();
        v68.Parent = Lighting;
        v68.FarIntensity = 0;
        TweenService:Create(v68, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FarIntensity = 1
        }):Play();
        u67:Add(v68);
        mainreplication.cameraShake(15, 2, 8);
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.bright(1, 1.5);
        u67:Add(function() -- Line: 510
            -- upvalues: mainreplication (ref)
            mainreplication.ultFlash(nil, 1.5);
            mainreplication.sceneEnabled(false);
            mainreplication.fov(false, 70);
        end);
        u67:Add(task.delay(5, function() -- Line: 516
            -- upvalues: u67 (copy)
            u67:Destroy();
        end));
    end,

    GokuVariantsStart = function(u69: any, p70: userdata) -- Line: 523, Name: GokuVariantsStart
        -- upvalues: trove (copy), u2 (copy)
        local u71 = trove.new();
        u71:AttachToInstance(u69);
        u71:AttachToInstance(p70);
        u2[u69] = u71;
        u71:Add(function() -- Line: 530
            -- upvalues: u2 (ref), u69 (copy)
            u2[u69] = nil;
        end);
        u71:Add(task.delay(10, function() -- Line: 534
            -- upvalues: u71 (copy)
            u71:Destroy();
        end));
    end,

    GokuGodSteal4thBase = function(p72) -- Line: 539, Name: GokuGodSteal4thBase
        -- upvalues: u2 (copy), Goku (copy)
        local v73 = u2[p72];

        if not v73 then
            return;
        end;

        local Torso = p72:FindFirstChild("Torso");

        if not Torso then
            return;
        end;

        local v74 = v73:Clone(Goku.God["4thBaseMoveVFX"]);
        v74.Parent = Torso;
        shared.vfx.emit(v74);
    end,

    GokuGodStealAura = function(p75) -- Line: 552, Name: GokuGodStealAura
        -- upvalues: u2 (copy), vfxUtil (copy), Goku (copy), RunService (copy)
        local v76 = u2[p75];

        if not v76 then
            return;
        end;

        local Root = vfxUtil.getRoot(p75);

        if not Root then
            return;
        end;

        local u77 = v76:Clone(Goku.God.ssjaura);
        u77.Parent = workspace.Effects;
        v76:Add(RunService.PreRender:Connect(function() -- Line: 562
            -- upvalues: Root (copy), u77 (copy)
            if not (Root and Root.Parent) then
                return;
            end;

            u77:PivotTo(Root.CFrame * CFrame.new(-0.153, 0.535, 0.111));
        end));
        shared.vfx.emit(u77);
    end,

    GokuGodStealDash = function(p78) -- Line: 570, Name: GokuGodStealDash
        -- upvalues: u2 (copy), vfxUtil (copy), Goku (copy), RunService (copy), Players (copy), mainreplication (copy)
        local v79 = u2[p78];

        if not v79 then
            return;
        end;

        local Root = vfxUtil.getRoot(p78);

        if not Root then
            return;
        end;

        local u80 = v79:Clone(Goku.God.SSJauraFLY);
        local u81 = v79:Clone(Goku.God.dashwindbeam);
        local u82 = v79:Clone(Goku.God.DashWindMesh);
        u80.Parent = workspace.Effects;
        u81.Parent = workspace.Effects;
        u82.Parent = workspace.Effects;
        v79:Add(RunService.PreRender:Connect(function() -- Line: 585
            -- upvalues: Root (copy), u80 (copy), u81 (copy), u82 (copy)
            if not (Root and Root.Parent) then
                return;
            end;

            local CFrame2 = Root.CFrame;
            u80:PivotTo(CFrame2 * CFrame.new(0.27, -0.557, -0.585) * CFrame.Angles(-1.5707963267948966, 0, 0));
            u81:PivotTo(CFrame2 * CFrame.new(0.6, -0.152, -6.419));
            u82:PivotTo(CFrame2 * CFrame.new(1.562, -0.239, 4.066) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966));
        end));
        shared.vfx.emit(u80, u81, u82);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(p78) then
            mainreplication.bodyVelocity(Root, 200, 2, nil, nil, nil, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out));
            mainreplication.cameraShake(10, 1.5, 6);
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;
    end,

    GokuFinalClashOfFate = function(p83, u84) -- Line: 614, Name: GokuFinalClashOfFate
        -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), animationUtil (copy), Players (copy)
        if not (p83 and u84) then
            return;
        end;

        local NOAUTO = vfxUtil.getResources():WaitForChild("Goku").NOAUTO;
        local u85 = trove.new();
        u85:AttachToInstance(p83);
        u85:AttachToInstance(u84);
        local Root = vfxUtil.getRoot(p83);
        local Root2 = vfxUtil.getRoot(u84);

        if not (Root and Root2) then
            u85:Destroy();

            return;
        end;

        local v86 = u85:Construct(NOAUTO.VFX);
        vfxUtil.setupAura(p83, v86, true);
        v86.Parent = workspace.Effects;
        mainreplication.sceneEnabled(true);
        Root2.Anchored = true;
        Root.Anchored = true;
        Root2.CFrame = Root.CFrame;
        u85:Add(animationUtil:loadAnimation(p83, NOAUTO.User), "Stop"):Play();
        u85:Add(animationUtil:loadAnimation(u84, NOAUTO.Victim), "Stop"):Play();
        local v87, u88 = mainreplication.cutsceneBlender(Root, NOAUTO.Camera, NOAUTO.FOV, nil, nil, nil);

        if u88 then
            u85:Add(function() -- Line: 651
                -- upvalues: u88 (copy)
                u88();
            end);
        end;

        u85:Clone(NOAUTO:FindFirstChildOfClass("Attachment")).Parent = v87:FindFirstChild("CamPart");
        vfxUtil.execute_compiled(NOAUTO.Compiled, u85, v86, v87);
        u85:Add(function() -- Line: 661
            -- upvalues: mainreplication (ref), Players (ref), u84 (copy), Root (copy)
            mainreplication.ultFlash(nil, 1.5);
            mainreplication.sceneEnabled(false);
            mainreplication.fov(false, 70);

            if Players:GetPlayerFromCharacter(u84) then
                u84:BreakJoints();
            end;

            Root.Anchored = false;
        end);
        u85:Add(task.delay(5, function() -- Line: 674
            -- upvalues: u85 (copy)
            u85:Destroy();
        end));
    end
};
local u90 = {};

local function getOrbFrame(p91: userdata, p92: string) -- Line: 681
    local Orbs = p91:FindFirstChild("Orbs");

    if not Orbs then
        return nil;
    end;

    local v93 = Orbs:FindFirstChild(p92);

    if v93 and v93:IsA("Frame") then
        return v93;
    end;

    return nil;
end;

local function applyFormState(p94: userdata, p95: any) -- Line: 690
    local Bar = p94:FindFirstChild("Bar");
    local v96;

    if Bar then
        v96 = Bar:FindFirstChild("Fill");
    else
        v96 = Bar;
    end;

    local v97 = p95.form == "SSJG";
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 90);
    local Color3_fromRGB_ret2 = Color3.fromRGB(255, 50, 50);

    if not v97 then
        Color3_fromRGB_ret2 = Color3_fromRGB_ret;
    end;

    if Bar and Bar:IsA("GuiObject") then
        Bar.Visible = not v97;
    end;

    if v96 and v96:IsA("Frame") then
        v96.Size = UDim2.new(1, 0, math.clamp(v97 and 0 or (p95.buildup or 0), 0, 1), 0);
        v96.BackgroundColor3 = Color3_fromRGB_ret2;
    end;

    local v98 = p95.spheres or {};

    for i = 1, 3 do
        local v99 = tostring(i);
        local Orbs = p94:FindFirstChild("Orbs");
        local v100;

        if Orbs then
            v100 = Orbs:FindFirstChild(v99);

            if not (v100 and v100:IsA("Frame")) then
                v100 = nil;
            end;
        else
            v100 = nil;
        end;

        local v101;

        if v100 then
            local v102;

            if p95.form == "SSJ" then
                if i == 1 then
                    v102 = (v98.tackle or 0) == 1;
                else
                    v102 = false;
                end;

                v100.Visible = i == 1;
            else
                if i == 1 then
                    v102 = (v98.tackle or 0) == 1;
                elseif i == 2 then
                    v102 = (v98.timestop or 0) == 1;
                else
                    v102 = (v98.steal or 0) == 1;
                end;

                v100.Visible = true;
            end;

            v100.BackgroundColor3 = Color3_fromRGB_ret2;
            v100.BackgroundTransparency = v102 and 0 or 0.72;
            v101 = i;
        else
            v101 = i;
        end;
    end;
end;

function v89.GokuFormUI(u103, p104) -- Line: 731
    -- upvalues: u90 (copy), vfxUtil (copy), Goku (copy), trove (copy), applyFormState (copy)
    if not (u103 and p104) then
        return;
    end;

    if not p104.active then
        local v105 = u90[u103];

        if v105 then
            v105:Destroy();
            u90[u103] = nil;
        end;

        return;
    end;

    local Root = vfxUtil.getRoot(u103);

    if not Root then
        return;
    end;

    local GokuCore = Goku:FindFirstChild("GokuCore");

    if not GokuCore then
        return;
    end;

    local u106 = u90[u103];

    if not u106 then
        u106 = GokuCore:Clone();
        u106.Name = "GokuCoreActive";
        u106.Adornee = Root;
        u106.Parent = Root;
        u90[u103] = u106;
        local v107 = trove.new();
        v107:AttachToInstance(u103);
        v107:Add(function() -- Line: 765
            -- upvalues: u90 (ref), u103 (copy), u106 (ref)
            if u90[u103] == u106 then
                u90[u103] = nil;
            end;

            if u106.Parent then
                u106:Destroy();
            end;
        end);
    end;

    applyFormState(u106, p104);
end;

function v89.GokuFormSwap(p108: any, p109: string) -- Line: 778
    -- upvalues: vfxUtil (copy), Goku (copy), Players (copy), mainreplication (copy)
    if not p108 then
        return;
    end;

    local Root = vfxUtil.getRoot(p108);

    if not Root then
        return;
    end;

    local v110;

    if p109 == "SSJG" then
        v110 = Goku:FindFirstChild("God");
    else
        v110 = Goku:FindFirstChild("MeteorRush");
    end;

    if v110 then
        v110 = v110:FindFirstChild("ssjaura") or v110:FindFirstChild("SSJaura");
    end;

    if v110 then
        local v111 = v110:Clone();
        v111.Parent = workspace.Effects;

        if v111:IsA("Model") or v111:IsA("BasePart") then
            v111:PivotTo(Root.CFrame);
        end;

        shared.vfx.emit(v111);
        task.delay(2, v111.Destroy, v111);
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p108) then
        mainreplication.cameraShake(8, 0.5, 4);
    end;
end;

function v89.GokuSSJTackleReact(p112: any, p113: any, p114: any, p115: string) -- Line: 805
end;

function v89.GokuMUIBallCatch(p116) -- Line: 813
end;

function v89.SpiritBomb(p117: any, p118: number?) -- Line: 815
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), Lighting (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p117);
    local SpiritBomb = vfxUtil.getResources().Goku.SpiritBomb;
    local u119 = vfxUtil.character_trove(p117);
    mainreplication.sceneEnabled(true);
    u119:Add(function() -- Line: 822
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    soundUtil:play(SpiritBomb.SFX, "default");
    local _, v120 = mainreplication.cutsceneBlender(Root, SpiritBomb.Animations.Cam, SpiritBomb.FOV_GokuSB);
    u119:Add(v120);
    local v121 = u119:Clone(SpiritBomb.VFX);
    v121.Parent = p117;
    v121:PivotTo(Root:GetPivot());
    local v122 = u119:Add(v121.Follower);
    v122.Parent = p117.Torso;
    v122.Weld.Part1 = p117.Torso;

    for _, child in SpiritBomb.PlayerAura.Main:GetChildren() do
        local u123 = u119:Clone(child);
        u123.Parent = p117.Torso;
        u119:Add(task.delay((u123.Name == "ssjb" and 1645 or 1804) / 60, function() -- Line: 846
            -- upvalues: u123 (copy)
            shared.vfx.emit(u123);
        end));
    end;

    for _, child in SpiritBomb.PlayerAura.StepUp:GetChildren() do
        local u124 = u119:Clone(child);
        local v125 = u124.Name == "SteppingVFX";
        u124.Parent = p117[v125 and "Left Leg" or "Right Leg"];
        u119:Add(task.delay(v125 and 0 or 0.95, function() -- Line: 857
            -- upvalues: u124 (copy)
            shared.vfx.emit(u124);
        end));

        if v125 then
            u119:Add(task.delay(1.7166666666666666, function() -- Line: 862
                -- upvalues: u124 (copy)
                shared.vfx.emit(u124);
            end));
        end;
    end;

    local v126 = u119:Add(Instance.new("ColorCorrectionEffect", Lighting));
    local v127 = u119:Add(vfxUtil.getMoonEffects());
    local v128 = {
        Workspace = v121,
        Letterbox = v127.Letterbox.Letterbox,
        Vignette = v127.Vignette,
        ColorCorrection = v126
    };
    local v129 = u119:Construct(MoonPropertyAnimator);
    v129:LoadAndConvertSave(SpiritBomb.Moon, v128);
    v129:SetOriginalRoot(SpiritBomb.VFX.PrimaryPart.CFrame);
    v129:SetRoot(Root);
    v129:PlayAll();
    vfxUtil.execute_compiled(SpiritBomb.Compiled, u119, v121, v122);
    u119:Add(task.delay(p118, function() -- Line: 887
        -- upvalues: u119 (copy)
        u119:Destroy();
    end));
end;

return v89;