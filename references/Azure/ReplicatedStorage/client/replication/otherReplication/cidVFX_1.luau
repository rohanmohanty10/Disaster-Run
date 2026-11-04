 
 

local u1 = require("@game/ReplicatedStorage/util/vfxUtil");
local u2 = require("@game/ReplicatedStorage/util/MoonPropertyAnimator");
local u3 = require("@game/ReplicatedStorage/client/replication/mainreplication");
local u4 = require("@game/ReplicatedStorage/util/soundUtil");
local u5 = require("@game/ReplicatedStorage/client/replication/TekrinnDialogue");
local Lighting = game:GetService("Lighting");
local ContentProvider = game:GetService("ContentProvider");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local v6 = {};

local function preload_final_atomic() -- Line: 17
    -- upvalues: ContentProvider (copy), u1 (copy)
    task.spawn(function() -- Line: 18
        -- upvalues: ContentProvider (ref), u1 (ref)
        ContentProvider:PreloadAsync({ u1.getResources():WaitForChild("cid"):WaitForChild("FinalAtomic") });
    end);
end;

local function watch_style(u7: userdata) -- Line: 23
    -- upvalues: ContentProvider (copy), u1 (copy)
    local function check() -- Line: 24
        -- upvalues: u7 (copy), ContentProvider (ref), u1 (ref)
        if u7:GetAttribute("style") == "cid" then
            task.spawn(function() -- Line: 18
                -- upvalues: ContentProvider (ref), u1 (ref)
                ContentProvider:PreloadAsync({ u1.getResources():WaitForChild("cid"):WaitForChild("FinalAtomic") });
            end);
        end;
    end;

    if u7:GetAttribute("style") == "cid" then
        task.spawn(function() -- Line: 18
            -- upvalues: ContentProvider (ref), u1 (ref)
            ContentProvider:PreloadAsync({ u1.getResources():WaitForChild("cid"):WaitForChild("FinalAtomic") });
        end);
    end;

    u7:GetAttributeChangedSignal("style"):Connect(check);
end;

if RunService:IsClient() then
    for _, v in Players:GetPlayers() do
        local function v8() -- Line: 24
            -- upvalues: v (copy), ContentProvider (copy), u1 (copy)
            if v:GetAttribute("style") == "cid" then
                task.spawn(function() -- Line: 18
                    -- upvalues: ContentProvider (ref), u1 (ref)
                    ContentProvider:PreloadAsync({ u1.getResources():WaitForChild("cid"):WaitForChild("FinalAtomic") });
                end);
            end;
        end;

        if v:GetAttribute("style") == "cid" then
            task.spawn(function() -- Line: 18
                -- upvalues: ContentProvider (copy), u1 (copy)
                ContentProvider:PreloadAsync({ u1.getResources():WaitForChild("cid"):WaitForChild("FinalAtomic") });
            end);
        end;

        v:GetAttributeChangedSignal("style"):Connect(v8);
    end;

    Players.PlayerAdded:Connect(watch_style);
end;

function v6.cid_flow(p9: any, p10: number?) -- Line: 40
    -- upvalues: ContentProvider (copy), u1 (copy), u3 (copy), Lighting (copy), u2 (copy), u4 (copy)
    task.spawn(function() -- Line: 18
        -- upvalues: ContentProvider (ref), u1 (ref)
        ContentProvider:PreloadAsync({ u1.getResources():WaitForChild("cid"):WaitForChild("FinalAtomic") });
    end);
    local Flow = u1.getResources().cid.Flow;
    local Root = u1.getRoot(p9);
    local v11 = u1.character_trove(p9);
    u3.sceneEnabled(true);
    v11:Add(function() -- Line: 47
        -- upvalues: u3 (ref)
        u3.sceneEnabled(false);
    end);
    local v12 = v11:Clone(Flow.VFX);
    v12:PivotTo(Root.CFrame);
    v12.Parent = workspace.Effects;
    local _, v13 = u3.cutsceneCamRigWithLetterBox(Root, Flow.Camera, Flow.FOV, nil, "default", Flow.Cam2, "CamPart");
    v11:Add(v13);
    v11:Add(u1.buildFromRig(p9, Flow.Aura), "Destroy");
    u1.execute_compiled(Flow.Compiled, v11, v12, p9);
    local v14 = {
        Vignette = v11:Add(u1.getMoonEffects()).Vignette,
        Lighting = Lighting,
        Highlight = p9:FindFirstChild("Highlight"),
        Crowbar = p9:FindFirstChild("Crowbar")
    };
    u1.cutscene_lighting(v11, v14, Flow.Lighting, {
        Brightness = 3,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ClockTime = 1.964,
        GeographicLatitude = 68.023,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70),
        ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
        ColorShift_Top = Color3.fromRGB(0, 0, 0)
    });
    local v15 = v11:Construct(u2);
    v15:LoadAndConvertSave(Flow.Moon, v14);
    v15:SetRoot(Root);
    v15:PlayAll();
    u4:play(Flow.OnBall, "default");
    v11:Add(task.delay(15, v11.Destroy, v11));
end;

function v6.cid_otflow(u16, p17) -- Line: 100
    -- upvalues: ContentProvider (copy), u1 (copy), u3 (copy), u4 (copy), Lighting (copy), u2 (copy), u5 (copy)
    task.spawn(function() -- Line: 18
        -- upvalues: ContentProvider (ref), u1 (ref)
        ContentProvider:PreloadAsync({ u1.getResources():WaitForChild("cid"):WaitForChild("FinalAtomic") });
    end);
    local Root = u1.getRoot(u16);
    local u18 = u1.mvp_cutscene_defaults(u3, p17, {
        NoFade = true,
        BackScene = true
    });
    u1.getPlayer(u16);
    local Atomic = u1.getResources().cid.Atomic;
    local v19 = u18:Clone(Atomic.VFX);
    v19:PivotTo(Root.CFrame);
    v19.Parent = workspace.Effects;
    local v20 = u18:Add(v19.eyer);
    v20.Name = "eye";
    v20.Parent = u16.Head;
    local v21 = u18:Clone(Atomic["ugly sword"]);
    v21.Parent = u16;
    local v22 = u18:Add(v21.HandleM);
    v22.Parent = u16["Right Arm"];
    v22.Part0 = u16["Right Arm"];
    v22.Name = "Handle";
    local v23, v24 = u3.cutsceneBlender(Root, Atomic.Animations.Cam, Atomic.FOV_Atomic);
    u18:Add(v24);

    for _, child in Atomic.CamVFX:GetChildren() do
        u18:Clone(child).Parent = v23.CamPart;
    end;

    u4:play(Atomic.SFX, "default");
    local v25 = u18:Add(u1.getMoonEffects());
    local v26 = {
        Workspace = v19,
        MVP_scene = v19.MVP_scene,
        Lighting = Lighting,
        Vignette = v25.Vignette,
        ["Screen Cover"] = v25["Screen Cover"]
    };
    u1.cutscene_lighting(u18, v26, Atomic.Lighting, {});
    u1.execute_compiled(Atomic.Compiled, u18, v19, v23, u16);
    local v27 = u18:Construct(u2);
    v27:LoadAndConvertSave(Atomic.Moon, v26);
    v27:SetOriginalRoot(Atomic.VFX.Root.CFrame);
    v27:SetRoot(Root);
    v27:PlayAll();
    u18:Add(task.delay(0.31, function() -- Line: 157
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "Run?",
                TypeSpeed = 0.06,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            }
        }, 4));
    end));
    u18:Add(task.delay(1.96, function() -- Line: 169
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "Who\'s running?",
                TypeSpeed = 0.055,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(226, 211, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            }
        }, 4));
    end));
    u18:Add(task.delay(3.4, function() -- Line: 185
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "Running where?",
                TypeSpeed = 0.055,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(207, 183, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            }
        }, 4));
    end));
    u18:Add(task.delay(5.03, function() -- Line: 201
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "WHY?!",
                Bold = true,
                TypeSpeed = 0.035,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(193, 97, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 0.5
                }
            }
        }, 6));
    end));
    u18:Add(task.delay(8.31, function() -- Line: 218
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "Observe, and witness for yourselves!",
                Bold = true,
                TypeSpeed = 0.045,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(223, 196, 255)),
                    ColorSequenceKeypoint.new(0.65, Color3.fromRGB(174, 92, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 0.5
                }
            }
        }, 10));
    end));
    u18:Add(task.delay(10.47, function() -- Line: 236
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "My earth-shattering...",
                Bold = true,
                TypeSpeed = 0.065,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.45, Color3.fromRGB(194, 134, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 0.7
                }
            }
        }, 10));
    end));
    u18:Add(task.delay(13.02, function() -- Line: 253
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "sky-rending...",
                Italic = true,
                TypeSpeed = 0.07,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(153, 93, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 0.7
                }
            }
        }, 10));
    end));
    u18:Add(task.delay(14.93, function() -- Line: 270
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "supremely ultimate, ",
                TypeSpeed = 0.045,
                Pause = 1,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(231, 215, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            },
            {
                Text = "almighty ",
                Bold = true,
                TypeSpeed = 0.05,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(203, 121, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 0.6
                }
            },
            {
                Text = "and unparalleled attack!",
                Bold = true,
                TypeSpeed = 0.04,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(232, 196, 255)),
                    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(191, 83, 255)),
                    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(118, 35, 196)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                }),
                Shake = {
                    Enabled = true,
                    Intensity = 3.5,
                    Lifetime = 0.8
                }
            }
        }, 10));
    end));
    u18:Add(task.delay(23.02, function() -- Line: 313
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "I...",
                Bold = true,
                TypeSpeed = 0.12,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 181, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 0,
                    Lifetime = 0
                }
            }
        }, 4));
    end));
    u18:Add(task.delay(26.72, function() -- Line: 330
        -- upvalues: u18 (copy), u5 (ref), u16 (copy)
        u18:Add(u5.Speak(u16, {
            {
                Text = "AM...",
                Bold = true,
                TypeSpeed = 0.14,
                TextStrokeColor = Color3.new(0, 0, 0),
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(225, 192, 255)),
                    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(180, 78, 255)),
                    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(105, 29, 182)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1
                }
            }
        }, 5));
    end));
    task.delay(46.62, function() -- Line: 349
        -- upvalues: u16 (copy), u5 (ref)
        if u16 and u16.Parent ~= nil then
            u5.Speak(u16, {
                {
                    Text = "I mean, this time it really is just for show.",
                    Italic = true,
                    TypeSpeed = 0.045,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(213, 197, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    Shake = {
                        Enabled = false,
                        Intensity = 0,
                        Lifetime = 0
                    }
                }
            }, 5);
        end;
    end);
end;

function v6.cid_finalatomic(u28: any, p29: number, u30: table) -- Line: 370
    -- upvalues: u1 (copy), u3 (copy), u4 (copy), TweenService (copy), Lighting (copy), u2 (copy)
    local Root = u1.getRoot(u28);
    local u31 = u1.mvp_cutscene_defaults(u3, p29, {
        NoFade = true,
        BackScene = true
    });
    local FinalAtomic = u1.getResources().cid.FinalAtomic;
    local u32 = u4:play(FinalAtomic.SFX, "default");
    workspace:GetAttributeChangedSignal("activeMvp"):Once(function() -- Line: 377
        -- upvalues: TweenService (ref), u32 (copy)
        local v33 = TweenService:Create(u32, TweenInfo.new(1.5), {
            Volume = 0
        });
        v33.Completed:Once(function() -- Line: 379
            -- upvalues: u32 (ref)
            u32:Stop();
        end);
        v33:Play();
    end);
    local _, v34 = u3.cutsceneBlender(Root, FinalAtomic.Animations.Cam, FinalAtomic.FOV);
    u31:Add(v34);
    local v35 = u31:Clone(FinalAtomic.VFX);
    v35:PivotTo(Root.CFrame);
    v35.Parent = workspace.Effects;
    local u36 = u31:Add(v35.Dudes);
    u36.Parent = game.ReplicatedStorage;
    u31:Add(task.delay(50.43333333333333, function() -- Line: 394
        -- upvalues: u36 (copy)
        local overtimedude2 = u36.overtimedude2;
        local v37 = workspace.overtime.Reporter2:Clone();

        for _, v in overtimedude2:QueryDescendants("Motor6D") do
            v37:FindFirstChild(v.Name, true).C0 = v.C0;
        end;

        v37.HumanoidRootPart.CFrame = overtimedude2.HumanoidRootPart.CFrame;
        v37.Name = overtimedude2.Name;
        v37.Parent = u36;
        overtimedude2:Destroy();
    end));
    u31:Add(task.spawn(function() -- Line: 406
        -- upvalues: u1 (ref), u28 (copy), FinalAtomic (copy), u31 (copy), u30 (copy)
        u1.buildFromRig(u28, FinalAtomic.Aura, u31);
        u1.cutscene_invisiball(u28, u31);
        u1.cutscene_invisiball(u30[1], u31);
    end));
    local _baseplate_controller, u38 = u1.get_baseplate_controller();
    u31:Add(u1.make_baseplate_connection(_baseplate_controller));
    u38.Transparency = 1;
    local u39 = {};

    for _, descendant in workspace.map.map.Billboards:GetDescendants() do
        if descendant:IsA("SurfaceGui") and descendant.Enabled then
            descendant.Enabled = false;
            table.insert(u39, descendant);
        end;
    end;

    u31:Add(function() -- Line: 422
        -- upvalues: u39 (copy)
        for _, v in u39 do
            v.Enabled = true;
        end;
    end);
    u31:Add(function() -- Line: 427
        -- upvalues: u38 (copy), _baseplate_controller (copy)
        u38.Transparency = 0;
        _baseplate_controller.update();
    end);
    local v40 = u31:Add(u1.getMoonEffects());
    local v41 = {
        Lighting = Lighting,
        Vignette = v40.Vignette,
        ["Screen Cover"] = v40["Screen Cover"]
    };
    u1.cutscene_lighting(u31, v41, FinalAtomic.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0,
        GeographicLatitude = 0,
        Ambient = Color3.fromRGB(70, 70, 70),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70),
        ColorShift_Bottom = Color3.new(),
        ColorShift_Top = Color3.new()
    });
    u1.execute_compiled(FinalAtomic.Compiled, u31, v35, u28, u36);
    local v42 = u31:Construct(u2);
    v42:LoadAndConvertSave(FinalAtomic.Moon, v41);
    v42:SetRoot(Root);
    v42:PlayAll();
end;

return v6;