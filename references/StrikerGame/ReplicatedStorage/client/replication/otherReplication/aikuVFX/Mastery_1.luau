 
 

local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
require(ReplicatedStorage.allTypes.rig);
local Ray = require(ReplicatedStorage.util.Ray);
local trove = require(ReplicatedStorage.forum.trove);
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
require(ReplicatedStorage.util.MoonCFrameTimeline);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local wiki = require(ReplicatedStorage.wiki);
require(ReplicatedStorage.util.KatUtil);
local aiku = vfxUtil.getResources().aiku;
local u1 = Ray.new({
    FilterType = Enum.RaycastFilterType.Exclude,
    Ignore = { workspace.characters, workspace.gks, workspace.CF }
});
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;

local function SerpentineJumpVFX(p2) -- Line: 55
    -- upvalues: u1 (copy), aiku (copy), Util (copy), vfxUtil (copy)
    local v3 = u1:fire(p2.Position, Vector3.new(0, -100, 0));
    local v4;

    if v3 then
        v4 = CFrame.new(v3.Position + Vector3.new(0, 0.219, 0)) * p2.Rotation;
    else
        v4 = CFrame.new(p2.Position - Vector3.new(0, 2.781, 0)) * p2.Rotation;
    end;

    local v5 = aiku.SerpentineClear.Jump:Clone();
    v5.CFrame = Util.flatten_cframe(v4);
    v5.Parent = workspace.Effects;
    vfxUtil.forge.emit(v5);
    vfxUtil.disposal(v5);
end;

local v15 = {
    serpentine_jump = function(u6: any, u7: number) -- Line: 78, Name: serpentine_jump
        -- upvalues: vfxUtil (copy), soundUtil (copy), aiku (copy), trove (copy), mainreplication (copy), RunService (copy), SerpentineJumpVFX (copy), TweenService (copy)
        if not u6:GetAttribute("SerpentineJump") then
            return;
        end;

        local HumanoidRootPart = u6.HumanoidRootPart;
        local u8 = u6:FindFirstChildWhichIsA("Humanoid");
        local u9 = vfxUtil.isLocalPlayer(u6);
        local u10 = false;
        soundUtil:play(aiku.SerpentineClear.JumpSFX, HumanoidRootPart);
        local u11 = trove.new();
        u11:AttachToInstance(u6);
        u11:Add(function() -- Line: 93
            -- upvalues: u6 (copy), u10 (ref), mainreplication (ref)
            if u6:GetAttribute("SerpentineClear") then
                if not u10 then
                    u6:SetAttribute("SerpentineMissingJump", true);
                end;
            else
                mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            end;
        end);
        u11:Connect(u6:GetAttributeChangedSignal("SerpentineJump"), function() -- Line: 102
            -- upvalues: u6 (copy), u11 (copy)
            if not u6:GetAttribute("SerpentineJump") then
                u11:Destroy();
            end;
        end);
        u11:Add(task.delay(u7, function() -- Line: 107
            -- upvalues: u10 (ref), u9 (copy), mainreplication (ref), HumanoidRootPart (copy), u8 (copy), trove (ref), RunService (ref), SerpentineJumpVFX (ref), u6 (copy), TweenService (ref), u7 (copy), u11 (copy)
            u10 = true;

            if u9 then
                mainreplication.cameraShake(10, 0.5, 3);
                mainreplication.fov(true, 60, 0.234, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                local u12 = mainreplication.bodyVelocity(HumanoidRootPart, 0, 0.1, nil, nil, true);

                if u12 then
                    u12.MaxForce = Vector3.new(300000, 300000, 300000);
                    local u13 = not u8 and Vector3.new(0, 0, 0) or HumanoidRootPart.CFrame:VectorToObjectSpace(u8.MoveDirection);
                    u12.Velocity = Vector3.new(0, 100, 0);
                    local v14 = trove.new();
                    v14:AttachToInstance(u12);
                    v14:Connect(RunService.PreRender, function() -- Line: 124
                        -- upvalues: u12 (copy), HumanoidRootPart (ref), u13 (ref)
                        u12.Velocity = HumanoidRootPart.CFrame:VectorToWorldSpace(u13) * 95 + Vector3.new(0, 100, 0);
                    end);
                end;
            end;

            SerpentineJumpVFX(HumanoidRootPart.CFrame);
            local Highlight = Instance.new("Highlight");
            Highlight.FillTransparency = 0.5;
            Highlight.OutlineTransparency = 0;
            Highlight.OutlineColor = Color3.fromRGB(76, 221, 36);
            Highlight.Parent = u6;
            TweenService:Create(Highlight, TweenInfo.new(0.6 - u7, Enum.EasingStyle.Linear), {
                OutlineTransparency = 1,
                FillTransparency = 1
            }):Play();
            u11:Add(Highlight);
        end));
    end
};
local TweenInfo_new_ret = TweenInfo.new(0.883, Enum.EasingStyle.Quart);
local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quart);

function v15.serpentine_clear(u16: any, p17: vector) -- Line: 150
    -- upvalues: aiku (copy), vfxUtil (copy), soundUtil (copy), trove (copy), mainreplication (copy), Lighting (copy), TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy), SerpentineJumpVFX (copy)
    if not u16:GetAttribute("SerpentineClear") then
        return;
    end;

    local SerpentineClear = aiku.SerpentineClear;
    local HumanoidRootPart = u16.HumanoidRootPart;
    local v18 = vfxUtil.isLocalPlayer(u16);
    soundUtil:play(SerpentineClear.Hit, HumanoidRootPart);
    local u19 = trove.new();
    u19:AttachToInstance(u16);
    u19:Connect(u16:GetAttributeChangedSignal("SerpentineClear"), function() -- Line: 164
        -- upvalues: u16 (copy), u19 (copy)
        if not u16:GetAttribute("SerpentineClear") then
            u19:Destroy();
        end;
    end);

    if v18 then
        HumanoidRootPart.CFrame = CFrame.new(p17) * HumanoidRootPart.CFrame.Rotation;
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        local BodyPosition = Instance.new("BodyPosition");
        BodyPosition.MaxForce = Vector3.new(300000, 300000, 300000);
        BodyPosition.Position = p17;
        BodyPosition.D = 350;
        BodyPosition.P = 10000;
        BodyPosition.Parent = HumanoidRootPart;
        u19:Add(BodyPosition);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.TintColor = Color3.fromRGB(121, 216, 109);
        ColorCorrectionEffect.Brightness = 0.3;
        ColorCorrectionEffect.Contrast = 0.8;
        ColorCorrectionEffect.Saturation = -0.5;
        ColorCorrectionEffect.Parent = Lighting;
        TweenService:Create(ColorCorrectionEffect, TweenInfo_new_ret, {
            Brightness = 0,
            Contrast = 0,
            TintColor = Color3.new(1, 1, 1)
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo_new_ret2, {
            Saturation = 0
        }):Play();
        vfxUtil.disposal(ColorCorrectionEffect, TweenInfo_new_ret.Time);
        local Highlight = Instance.new("Highlight");
        Highlight.FillTransparency = 0.5;
        Highlight.OutlineTransparency = 0;
        Highlight.OutlineColor = Color3.fromRGB(76, 221, 36);
        Highlight.FillColor = Color3.fromRGB(76, 221, 36);
        Highlight.Parent = u16;
        vfxUtil.disposal(Highlight, 0.5);
        TweenService:Create(Highlight, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            OutlineTransparency = 1,
            FillTransparency = 1
        }):Play();
    end;

    if u16:GetAttribute("SerpentineMissingJump") then
        u16:SetAttribute("SerpentineMissingJump", nil);
        SerpentineJumpVFX(HumanoidRootPart.CFrame);
    end;

    local v20 = SerpentineClear.Attachment:Clone();
    v20.Parent = u16:FindFirstChild("Head");
    vfxUtil.forge.emit(v20);
    vfxUtil.disposal(v20);
end;

function v15.askmemyfavoritecolorwhatsyourfavoritecolorthankyousoiwasborninmiamiflorida(u21, p22) -- Line: 228
    -- upvalues: vfxUtil (copy), mainreplication (copy), PlayerGui (copy), soundUtil (copy), aiku (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
    local ReflexSteal = vfxUtil.getResources().aiku.ReflexSteal;
    local Root = vfxUtil.getRoot(u21);
    p22:FindFirstChild("Ball");
    mainreplication.sceneEnabled(true);
    local v23 = vfxUtil.character_trove(u21);
    v23:Add(function() -- Line: 236
        -- upvalues: mainreplication (ref), vfxUtil (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
        vfxUtil.restore_lighting();
        vfxUtil.restore_lighting_properties();
    end);
    v23:Add(task.delay(8.4, v23.Destroy, v23));

    for _, child in ReflexSteal.UI:GetChildren() do
        v23:Clone(child).Parent = PlayerGui;
    end;

    local Attribute = u21:GetAttribute("femlock");
    local u24 = Attribute or soundUtil:play(Attribute and aiku.Femvoicelines.reflexflow or ReflexSteal.sound, "default", {
        Character = u21
    }).Name == "Dub";
    v23:Add(task.delay(0.33, function() -- Line: 255
        -- upvalues: TekrinnDialogue (ref), u21 (copy), u24 (copy)
        TekrinnDialogue.Speak(u21, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u24 and "I\'ll crush every one of you..." or "I\'ll crush you all...",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end));
    v23:Add(task.delay(6.88, function() -- Line: 281
        -- upvalues: TekrinnDialogue (ref), u21 (copy)
        TekrinnDialogue.Speak(u21, {
            {
                Text = "So that I can ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            },
            {
                Text = "bloom!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end));
    local v25, v26 = mainreplication.cutsceneCamRigWithLetterBox(Root, ReflexSteal.Cam, ReflexSteal.FOV, nil, "default", ReflexSteal["CamRigWithLetterBox "], "camera");
    v23:Add(v26);
    local v27 = v23:Construct(ReflexSteal.UserVFX);
    vfxUtil.setupAura(u21, v27, true);
    v27.Parent = workspace.Effects;
    local v28 = v23:Construct(ReflexSteal.VictimVFX);
    local Ball = v28.Ball;
    vfxUtil.setupAura(p22, v28, true);
    Ball.Name = "BallVFX";
    v28.Parent = workspace.Effects;
    local v29 = v23:Add(ReflexSteal.VFX:Clone());
    v29:PivotTo(u21:GetPivot());
    v29.Parent = workspace.Effects;
    local u30 = v23:Clone(ReflexSteal.Dark);
    u30.Parent = workspace.Effects;
    v23:Add(task.delay(2.575, function() -- Line: 366
        -- upvalues: u30 (copy)
        u30.Transparency = 1;
    end));
    local v31 = {
        Workspace = v29,
        Vignette = v23:Add(vfxUtil.getMoonEffects()).Vignette,
        Lighting = game:GetService("Lighting"),
        bachirabeeshotdomain = v29.bachirabeeshotdomain
    };
    vfxUtil.contain_lighting(v23, v31, ReflexSteal.Lighting);
    MoonPropertyAnimator.ConvertSave(ReflexSteal.Moon, v31);
    local v32 = v23:Construct(MoonPropertyAnimator);
    v32:LoadAndConvertSave(ReflexSteal.Moon, v31);
    v32:SetOriginalRoot(CFrame.new(-19.089, 3, 0));
    v32:SetRoot(Root);
    v32:PlayAll();
    vfxUtil.execute_compiled(ReflexSteal.Compiled, v23, v25, v28, v29, v27);
end;

function v15.wowthathurts(u33) -- Line: 392
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), aiku (copy), PlayerGui (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
    local HeaderDefense = vfxUtil.getResources().aiku.HeaderDefense;
    local Root = vfxUtil.getRoot(u33);
    local v34 = vfxUtil.character_trove(u33);
    mainreplication.sceneEnabled(true);
    v34:Add(function() -- Line: 399
        -- upvalues: mainreplication (ref), vfxUtil (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
        vfxUtil.restore_lighting();
        vfxUtil.restore_lighting_properties();
    end);
    v34:Add(task.delay(3.19, v34.Destroy, v34));
    local Attribute = u33:GetAttribute("femlock");
    local u35 = Attribute or soundUtil:play(Attribute and aiku.Femvoicelines.box1flowig or HeaderDefense.sound, "default", {
        Character = u33
    }).Name == "Dub";
    soundUtil:play(HeaderDefense.music, "default");
    local v36, v37 = mainreplication.cutsceneCamRigWithLetterBox(Root, HeaderDefense.Cam, HeaderDefense.FOV, nil, "default", HeaderDefense["CamRigWithLetterBox "], "camera");
    v34:Add(v37);

    for _, child in HeaderDefense.UI:GetChildren() do
        v34:Clone(child).Parent = PlayerGui;
    end;

    v34:Add(task.delay(1.3, function() -- Line: 430
        -- upvalues: TekrinnDialogue (ref), u33 (copy), u35 (copy)
        TekrinnDialogue.Speak(u33, {
            {
                Bold = true,
                TypeSpeed = 0.01,
                Pause = 1.3,
                Text = u35 and "Blossom... " or "Bloom... ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            },
            {
                TypeSpeed = 0.01,
                Text = u35 and "and try to surpass me!" or "try to surpass me!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3.5);
    end));
    local v38 = v34:Construct(HeaderDefense.UserVFX);
    vfxUtil.setupAura(u33, v38, true);
    v38.Ball.Name = "BallVFX";
    v38.Parent = workspace.Effects;
    local v39 = v34:Add(HeaderDefense.VFX:Clone());
    v39:PivotTo(u33:GetPivot());
    v39.Parent = workspace.Effects;
    local v40 = {
        Workspace = v39,
        Vignette = vfxUtil.getMoonEffects().Vignette,
        Lighting = game:GetService("Lighting"),
        bachirabeeshotdomain = v39.bachirabeeshotdomain
    };
    vfxUtil.contain_lighting(v34, v40, HeaderDefense.Lighting);
    MoonPropertyAnimator.ConvertSave(HeaderDefense.Moon, v40);
    local v41 = v34:Construct(MoonPropertyAnimator);
    v41:LoadAndConvertSave(HeaderDefense.Moon, v40);
    v41:SetOriginalRoot(CFrame.new(-20.206, 2.992, 1.464));
    v41:SetRoot(Root);
    v41:PlayAll();
    vfxUtil.execute_compiled(HeaderDefense.Compiled, v34, v38, v39, v36);
end;

local function niceshoe(p42) -- Line: 509
    -- upvalues: Util (copy), soundUtil (copy), ReplicatedStorage (copy), TekrinnDialogue (copy)
    local Players2 = game:GetService("Players");
    local SoundService2 = game:GetService("SoundService");
    local PlayerFromCharacter = Players2:GetPlayerFromCharacter(p42);
    local v43;

    if p42:GetAttribute("FunnyVoicelines") == true then
        v43 = true;
    else
        v43 = Util.isSettingEnabled(PlayerFromCharacter, "britishaikuevil") and Util.isSettingEnabled(Players2.LocalPlayer, "modifiedVoices");
    end;

    local v44 = soundUtil:play(ReplicatedStorage.Resources.aiku[v43 and "trappedrnp" or "trapped"], SoundService2, {
        Character = p42
    });
    TekrinnDialogue.Speak(p42, {
        {
            Bold = false,
            Italic = false,
            TypeSpeed = 0.01,
            Text = v44 and v44.Name == "Dub" and "So close.." or (v43 and "I\'M HERE!" or "Nice shot."),
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 153, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(131, 255, 29)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 2,
                Lifetime = 1.5
            }
        }
    }, 1);
end;

function v15.venom_deflect_lunge(p45: any, p46: boolean) -- Line: 548
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), RunService (copy)
    local u47 = p45.HumanoidRootPart or p45.PrimaryPart;
    local u48 = p46 and -1 or 1;
    mainreplication.raycastEffect(u47, ReplicatedStorage.Resources.jumpsmoke);
    local u49, u50 = mainreplication.bodyVelocity(u47, 140, 1.05, nil, nil, true, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));

    if not u49 then
        return;
    end;

    local u51 = nil;
    u51 = RunService.RenderStepped:Connect(function() -- Line: 568
        -- upvalues: u49 (copy), u51 (ref), u47 (copy), u48 (copy), u50 (copy)
        if u49 and u49:IsDescendantOf(game) then
            u49.Velocity = u47.CFrame.RightVector * u48 * u50.Value;

            return;
        end;

        u51:Disconnect();
    end);
    task.delay(15, u51.Disconnect, u51);
end;

function v15.venom_deflect(p52: any, p53: boolean, p54: number) -- Line: 578
    -- upvalues: vfxUtil (copy), mainreplication (copy), niceshoe (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p52);
    local VenomDeflect = vfxUtil.getResources().aiku.VenomDeflect;
    local v55 = p53 and VenomDeflect.Left or VenomDeflect.Right;
    local Ball = p52:FindFirstChild("Ball");
    mainreplication.sceneEnabled(true);
    local v56 = vfxUtil.character_trove(p52);
    v56:Add(function() -- Line: 587
        -- upvalues: mainreplication (ref), vfxUtil (ref), Ball (copy)
        mainreplication.sceneEnabled(false);
        vfxUtil.restore_lighting();
        vfxUtil.restore_lighting_properties();

        if Ball then
            Ball.Transparency = 0;
            Ball.Name = "Ball";
        end;
    end);
    v56:Add(task.delay(1.05, v56.Destroy, v56));
    niceshoe(p52);
    local v57 = v56:Construct(v55.Aiku);
    vfxUtil.setupAura(p52, v57, true, true);
    v57.Parent = workspace.Effects;
    local v58 = v56:Add(v57["azl ballllllls_rig"]);
    v58.Ball.Ball.Part0 = Root;
    v58.Parent = p52;

    if Ball then
        Ball.Transparency = 1;
        Ball.Name = "Temp";
    end;

    local v59, v60 = mainreplication.cutsceneCamRigWithLetterBoxForIdiots(Root, v55.Cam, v55.FOV, nil, CFrame.new(0, -2.5, 0), v55.CamTemplate, "Part");
    v56:Add(v60);
    local v61 = {
        Vignette = v56:Add(vfxUtil.getMoonEffects()).Vignette,
        Highlight = v58.Ball:FindFirstChildOfClass("Highlight")
    };
    vfxUtil.contain_lighting(v56, v61, v55.Lighting);
    local v62 = v56:Construct(MoonPropertyAnimator);
    v62:LoadAndConvertSave(v55.Moon, v61);
    v62:SetRoot(Root);
    v62:PlayAll();
    vfxUtil.execute_compiled(v55.Compiled, v56, v58, v57, v59);
end;

function v15.venom_deflect_air(p63) -- Line: 638
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), niceshoe (copy), Util (copy), vfxUtil (copy)
    local v64 = p63.HumanoidRootPart or p63.PrimaryPart;
    mainreplication.sceneEnabled(true);
    mainreplication.cutsceneBlender(v64, ReplicatedStorage.Resources.aiku.aikutrapcam, ReplicatedStorage.Resources.aiku.FOV2);
    niceshoe(p63);
    local u65 = ReplicatedStorage.Resources.aiku.AikuTrapVfx:Clone();
    u65:PivotTo(v64.CFrame);
    u65.Parent = p63;
    local Players2 = game:GetService("Players");

    if Util.canshiftcolor(Players2.LocalPlayer, p63) then
        vfxUtil.LeanTowardsColor(u65, p63:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p63:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.delay(5, u65.Destroy, u65);
    task.delay(0.15, function() -- Line: 660
        -- upvalues: u65 (copy)
        for _, descendant in pairs(u65.Somethingelse.BallFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u65.Somethingelse:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
    BodyPosition.D = 300;
    BodyPosition.Parent = v64;
    BodyPosition.Position = v64.Position;
    task.delay(1.15, function() -- Line: 683
        -- upvalues: mainreplication (ref), BodyPosition (copy)
        mainreplication.sceneEnabled(false);
        BodyPosition:Destroy();
    end);
end;

function v15.snakes_grasp(p66: any, p67: any, p68: number, p69: boolean) -- Line: 689
    -- upvalues: aiku (copy), trove (copy), mainreplication (copy), vfxUtil (copy)
    local SnakesGrasp = aiku.SnakesGrasp;
    local HumanoidRootPart = p66.HumanoidRootPart;
    local u70 = trove.new();
    u70:Add(task.delay(2.533, function() -- Line: 694
        -- upvalues: u70 (copy)
        u70:Destroy();
    end));
    local u71 = {};

    for _, child in SnakesGrasp.RootVFX:GetChildren() do
        local v72 = u70:Clone(child);
        v72.Parent = HumanoidRootPart;
        u71[child.Name] = v72;
    end;

    u70:Add(task.delay(0.21666666666666667, function() -- Line: 706
        -- upvalues: u71 (copy), mainreplication (ref)
        shared.vfx.emit(u71["1"]);
        shared.vfx.emit(u71["2"]);
        mainreplication.springcamerashake(15, 30);
    end));

    if not p69 then
        u70:Add(task.delay(0.5333333333333333, function() -- Line: 712
            -- upvalues: u71 (copy)
            shared.vfx.emit(u71.ball);
        end));
    end;

    u70:Add(task.delay(1.1666666666666667, function() -- Line: 716
        -- upvalues: u71 (copy), mainreplication (ref)
        shared.vfx.emit(u71["3"]);
        mainreplication.springcamerashake(20, 30);
    end));
    local v73 = vfxUtil.isLocalPlayer(p66);

    if v73 then
        mainreplication.destroyVelocity(HumanoidRootPart);
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
    end;

    if v73 or vfxUtil.isLocalPlayer(p67) then
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        u70:Add(task.delay(p68, function() -- Line: 731
            -- upvalues: mainreplication (ref), vfxUtil (ref)
            mainreplication.fov(false, 95);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            vfxUtil.flash(Color3.new(0.5, 1, 0), 1);
        end));
    end;
end;

local u74 = {};

function v15.BurglarRadar(u75: any, p76: string, p77: table) -- Line: 742
    -- upvalues: actionUtil (copy), u74 (ref), aiku (copy), wiki (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), mainreplication (copy), Util (copy), vfxUtil (copy), LocalPlayer (copy), soundUtil (copy), SoundService (copy)
    if p76 == "Update" then
        local v78 = { "skill1", "skill2", "skill3", "skill4", "skill5", "Tspecialer" };

        for _, v in p77 do
            local data = v.data;
            local character = v.character;

            if character and (character ~= u75 and not actionUtil.checksameTeam(character, u75)) then
                local v79 = 10;

                for i, _ in data do
                    if table.find(v78, i) then
                        v79 = v79 + (v79 == 10 and 15 or 25);
                    end;
                end;

                local math_clamp_ret = math.clamp(v79, 0, 100);

                if character:FindFirstChild("Head") and not character:FindFirstChild("Indicator") then
                    pcall(game.Destroy, u74[character]);
                    u74[character] = nil;
                    local v80 = aiku.BurglarRadar.Indicator:Clone();
                    v80.Enabled = true;
                    v80.Parent = character:FindFirstChild("Head");
                    u74[character] = v80;
                end;

                local v81 = u74[character];

                if v81 then
                    local v82 = actionUtil.checkflow(character) or false;
                    v81.indicator.Text = v82 and "UNPREDICTABLE" or tostring(math_clamp_ret) .. "%";
                    v81.indicator.TextColor3 = v82 and Color3.new(0.462745, 0, 0) or Color3.new(0.9, 0, 0):Lerp(Color3.new(0, 0.9, 0), math_clamp_ret / 100);
                    v81.background.ImageColor3 = v82 and Color3.new(0.462745, 0, 0) or Color3.new(0.9, 0, 0):Lerp(Color3.new(0, 0.9, 0), math_clamp_ret / 100);
                    v81.indicator.UITextSizeConstraint.MaxTextSize = v82 and 25 or 1;
                    v81.indicator.UITextSizeConstraint.MinTextSize = v82 and 15 or 1;
                    local indicator = v81.indicator;
                    local v83;

                    if v82 then
                        local UDim2_fromScale = UDim2.fromScale;
                        local v84 = math.random(0, 1000) / 1000;
                        local v85 = math.lerp(-0.015, 0.015, v84) + 0.5;
                        local v86 = math.random(0, 1000) / 1000;
                        v83 = UDim2_fromScale(v85, math.lerp(-0.015, 0.015, v86) + 0.5) or UDim2.fromScale(0.5, 0.5);
                    else
                        v83 = UDim2.fromScale(0.5, 0.5);
                    end;

                    indicator.Position = v83;
                    local v87 = actionUtil.checkStyle(character);

                    if v87 and (wiki.styles[v87] and wiki.styles[v87].icon) then
                        v81.icon.Image = wiki.styles[v87].icon;
                    end;
                end;
            end;
        end;
    end;

    if p76 == "Kill" then
        if u75:FindFirstChild("Aiku Radar") then
            local v88 = u75:FindFirstChild("Aiku Radar");
            v88.Name = "deleting";

            for _, descendant in v88:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            for _, v in u74 do
                pcall(game.Destroy, v);
            end;

            u74 = {};
            task.delay(5, game.Destroy, v88);
        end;

        if u75 == Players.LocalPlayer.Character then
            local v89 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v89.Parent = Lighting;
            v89.TintColor = Color3.fromRGB(137, 255, 3);
            v89.Brightness = 0.4;
            v89.Contrast = 1;
            v89.Saturation = -0.4;
            TweenService:Create(v89, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(0.5, v89.Destroy, v89);
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end;
    end;

    if p76 == "Activate" then
        local u90 = {};
        task.spawn(function() -- Line: 845
            -- upvalues: ReplicatedStorage (ref), u75 (copy), u90 (copy)
            local v91 = ReplicatedStorage.Resources.aiku.eyeEff:Clone();
            v91.Weld.Part0 = u75.Head;
            v91.Parent = u75;
            v91.Name = "Aiku Radar";

            for _, descendant in v91:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Lifetime = NumberRange.new(0.25);
                    descendant.Rate = 12;
                    task.delay(0.15, function() -- Line: 856
                        -- upvalues: descendant (copy)
                        descendant.Lifetime = NumberRange.new(2);
                        descendant.Rate = 1;
                    end);
                end;
            end;

            table.insert(u90, v91);
        end);

        if Util.canshiftcolor(Players.LocalPlayer, u75) then
            vfxUtil.LeanTowardsColor(u90, u75:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u75:GetAttribute("CustomAlpha") or 0.985);
        end;

        if u75 == Players.LocalPlayer.Character then
            LocalPlayer.CharacterAdded:Once(function() -- Line: 874
                -- upvalues: u74 (ref)
                for _, v in u74 do
                    pcall(game.Destroy, v);
                end;

                u74 = {};
            end);
            soundUtil:play(ReplicatedStorage.Resources.aiku.BurglarRadar.Sound, SoundService);
            mainreplication.fov(false, 95);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            mainreplication.highlight(u75, Color3.fromRGB(75, 120, 48), 0.5);
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.15, BlurEffect.Destroy, BlurEffect);
            local v92 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v92.Parent = Lighting;
            v92.TintColor = Color3.fromRGB(137, 255, 3);
            v92.Brightness = 0.4;
            v92.Contrast = 1;
            v92.Saturation = -0.4;
            TweenService:Create(v92, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(0.5, v92.Destroy, v92);
        end;
    end;
end;

function v15.serpentslip(u93) -- Line: 908
    -- upvalues: aiku (copy), trove (copy), TweenService (copy), vfxUtil (copy), mainreplication (copy), Lighting (copy), ReplicatedStorage (copy)
    local SerpentSlip = aiku.SerpentSlip;
    local HumanoidRootPart = u93.HumanoidRootPart;
    local u94 = trove.new();
    u94:AttachToInstance(u93);
    u94:Add(task.delay(3, function() -- Line: 915
        -- upvalues: u94 (copy)
        u94:Destroy();
    end));
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = u93;
    u94:Add(Highlight);
    TweenService:Create(Highlight, TweenInfo.new(0.517, Enum.EasingStyle.Sine), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    local u95 = {};

    for _, child in SerpentSlip.RootVFX:GetChildren() do
        local v96 = u94:Clone(child);
        v96.Parent = HumanoidRootPart;
        u95[v96.Name] = v96;
    end;

    u95.aikubase1vfxrun.Weld.Part0 = HumanoidRootPart;
    vfxUtil.forge.emit(u95.Step);
    mainreplication.bodyVelocity(HumanoidRootPart, 40, 0.4, false, nil, false, nil, -1);
    u94:Add(task.delay(0.4, function() -- Line: 943
        -- upvalues: u93 (copy), mainreplication (ref), HumanoidRootPart (copy), vfxUtil (ref), u95 (copy)
        if u93:HasTag("_midSkill4") then
            return;
        end;

        mainreplication.bodyVelocity(HumanoidRootPart, 99, 1.083, false, nil, false, TweenInfo.new(2.5, Enum.EasingStyle.Quad));
        vfxUtil.forge.emit(u95.Dash);
        vfxUtil.forge.emit(u95.aikubase1vfxrun);
        mainreplication.springcamerashake(22.5, 35);
    end));

    if vfxUtil.isLocalPlayer(u93) then
        mainreplication.fov(true, 67, 0.317, Enum.EasingStyle.Linear);
        u94:Add(task.delay(0.4, function() -- Line: 956
            -- upvalues: Lighting (ref), TweenService (ref), ReplicatedStorage (ref), mainreplication (ref)
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 12;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v97 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v97.Parent = Lighting;
            v97.TintColor = Color3.fromRGB(137, 255, 3);
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
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 1.083, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        end));
    end;
end;

function v15.aiku_leashed(u98: any, p99: any, p100: table, p101: any) -- Line: 980
    -- upvalues: aiku (copy), mainreplication (copy), soundUtil (copy), trove (copy), vfxUtil (copy), PlayerGui (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Leashed = aiku.Leashed;
    local HumanoidRootPart = u98.HumanoidRootPart;
    mainreplication.sceneEnabled(true);
    local Attribute = u98:GetAttribute("femlock");
    local u102 = Attribute or soundUtil:play(Attribute and aiku.Femvoicelines.snekgrasp or Leashed.Sound, "default", {
        Character = u98
    }).Name == "Dub";
    local u103 = trove.new();
    u103:AttachToInstance(u98);
    u103:Add(function() -- Line: 991
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1, 2);
        mainreplication.sceneEnabled(false);
    end);
    u103:Add(task.delay(p101.Duration, function() -- Line: 995
        -- upvalues: u103 (copy)
        u103:Destroy();
    end));
    local v104 = u103:Clone(Leashed.VFX);
    v104:PivotTo(u98:GetPivot());
    vfxUtil.setupAura(u98, v104.wojtekwroblox2, true);
    vfxUtil.setupAura(p100[1], v104.TuffCharacterRig2, true);
    v104.Parent = workspace.Effects;
    local _, v105 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, Leashed.CameraAnimation, Leashed.FOV, u98, "default", Leashed["CamRigWithLetterBox "]);
    u103:Add(v105);
    local MoonEffects = vfxUtil.getMoonEffects();
    u103:Add(MoonEffects);
    local v106 = {
        Vignette = MoonEffects.Vignette,
        Workspace = v104
    };

    for _, child in Leashed.GUI:GetChildren() do
        local v107 = u103:Clone(child);
        v107.Parent = PlayerGui;
        v106[child.Name] = v107;
    end;

    vfxUtil.cutscene_lighting(u103, v106, Leashed.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0.20000000298023224,
        ClockTime = 12,
        GeographicLatitude = 23,
        Ambient = Color3.new(0.741176, 0.741176, 0.741176),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.184314, 0.184314, 0.184314)
    });
    local v108 = u103:Construct(MoonPropertyAnimator);
    v108:LoadAndConvertSave(Leashed.Moon, v106);
    v108:PlayAll();
    vfxUtil.execute_compiled(Leashed.Compiled, u103, v104);
    u103:Add(task.delay(4.463, function() -- Line: 1042
        -- upvalues: TekrinnDialogue (ref), u98 (copy), u102 (copy)
        TekrinnDialogue.Speak(u98, {
            {
                TypeSpeed = 0.01,
                Text = u102 and "Thought i wasn\'t gonna put a collar on you?" or "I\'m here to put a leash on you.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 2.0010000000000003
                }
            }
        }, 2.0010000000000003);
    end));
end;

function v15.aiku_overtime(u109: any, p110: any, p111: table, p112: any) -- Line: 1065
    -- upvalues: aiku (copy), mainreplication (copy), soundUtil (copy), trove (copy), vfxUtil (copy), PlayerGui (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Overtime = aiku.Overtime;
    local HumanoidRootPart = u109.HumanoidRootPart;
    mainreplication.sceneEnabled(true);
    local Attribute = u109:GetAttribute("femlock");
    local u113 = Attribute or soundUtil:play(Attribute and aiku.Femvoicelines.overtimeawk or Overtime.Sound, "default", {
        Character = u109
    }).Name == "Dub";
    local u114 = false;
    local task_delay_ret = task.delay(p112.Duration - 1, function() -- Line: 1076
        -- upvalues: mainreplication (ref)
        mainreplication.blackscene(1);
    end);
    local u115 = trove.new();
    u115:AttachToInstance(u109);
    u115:Add(function() -- Line: 1082
        -- upvalues: u114 (ref), task_delay_ret (copy), mainreplication (ref)
        if not u114 and coroutine.status(task_delay_ret) == "suspended" then
            task.cancel(task_delay_ret);
        end;

        mainreplication.sceneEnabled(false);
    end);
    u115:Add(task.delay(p112.Duration, function() -- Line: 1088
        -- upvalues: u114 (ref), u115 (copy)
        u114 = true;
        u115:Destroy();
    end));
    local u116 = u115:Clone(Overtime.VFX);
    u116:PivotTo(HumanoidRootPart.CFrame);
    u116.Parent = workspace.Effects;
    local Pivot = u116.aikuOfftheballEff:GetPivot();
    u116.aikuOfftheballEff:PivotTo(Pivot * CFrame.new(0, -150, 0));
    u115:Add(task.delay(0.26666666666666666, function() -- Line: 1101
        -- upvalues: u116 (copy), Pivot (copy)
        u116.aikuOfftheballEff:PivotTo(Pivot);
    end));
    u115:Add(task.delay(1.6, function() -- Line: 1105
        -- upvalues: u116 (copy), Pivot (copy)
        u116.aikuOfftheballEff:PivotTo(Pivot * CFrame.new(0, -150, 0));
    end));
    u115:Add(vfxUtil.buildFromRig(u109, u116.me));
    u115:Add(vfxUtil.buildFromRig(p111[1], u116.TemplateR6));
    local v117, v118 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, Overtime.CameraAnimation, Overtime.FOV, nil, "default", Overtime.Cam, "CamPart");
    u115:Add(v118);
    local v119;

    if workspace:FindFirstChild("map") and (workspace.map:FindFirstChild("map") and (workspace.map.map:FindFirstChild("sanam") and workspace.map.map.sanam:FindFirstChild("main"))) then
        v119 = u115:Clone(workspace.map.map.sanam.main);
        v119.Parent = workspace.Effects;
    else
        v119 = nil;
    end;

    local MoonEffects = vfxUtil.getMoonEffects();
    u115:Add(MoonEffects);
    local v120 = {
        Workspace = u116,
        maindark = v119,
        Vignette = MoonEffects.Vignette
    };

    for _, child in Overtime.GUI:GetChildren() do
        local v121 = u115:Clone(child);
        v121.Parent = PlayerGui;
        v120[child.Name] = v121;
    end;

    vfxUtil.cutscene_lighting(u115, v120, Overtime.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0,
        ClockTime = 12,
        GeographicLatitude = 201,
        Ambient = Color3.new(0.984314, 0.984314, 0.984314),
        ColorShift_Bottom = Color3.new(0.00784314, 0.00784314, 0.00784314),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.184314, 0.184314, 0.184314)
    });
    local v122 = u115:Construct(MoonPropertyAnimator);
    v122:LoadAndConvertSave(Overtime.Moon, v120);
    v122:SetOriginalRoot(u116:GetPivot());
    v122:SetRoot(HumanoidRootPart);
    v122:PlayAll();
    vfxUtil.execute_compiled(Overtime.Compiled, u115, u116, v117, u109, p111[1]);
    u115:Add(task.delay(0.352, function() -- Line: 1157
        -- upvalues: u115 (copy), TekrinnDialogue (ref), u109 (copy), u113 (copy)
        u115:Add(TekrinnDialogue.Speak(u109, {
            {
                Bold = true,
                TypeSpeed = 0.01,
                Text = u113 and "Those are some pretty great moves" or "Nice movements!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }, 3));
    end));
    u115:Add(task.delay(1.822, function() -- Line: 1179
        -- upvalues: u115 (copy), TekrinnDialogue (ref), u109 (copy)
        u115:Add(TekrinnDialogue.Speak(u109, {
            {
                Text = "Lil\' burglar...",
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 4
                }
            }
        }, 4));
    end));
    u115:Add(task.delay(4.423, function() -- Line: 1200
        -- upvalues: u115 (copy), TekrinnDialogue (ref), u109 (copy), u113 (copy)
        u115:Add(TekrinnDialogue.Speak(u109, {
            {
                Italic = true,
                TypeSpeed = 0.03,
                Text = u113 and "I\'ll never play soccer for someone else again!" or "I won\'t play soccer for anyone else...",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }, 3));
    end));
    u115:Add(task.delay(9.816, function() -- Line: 1222
        -- upvalues: u115 (copy), TekrinnDialogue (ref), u109 (copy), u113 (copy)
        u115:Add(TekrinnDialogue.Speak(u109, {
            {
                Bold = true,
                TypeSpeed = 0.03,
                Text = u113 and "From now on..." or "I\'ll...",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 5
                }
            }
        }, 5));
    end));
    u115:Add(task.delay(12.065, function() -- Line: 1244
        -- upvalues: u115 (copy), TekrinnDialogue (ref), u109 (copy), u113 (copy)
        u115:Add(TekrinnDialogue.Speak(u109, {
            {
                TypeSpeed = 0.01,
                Text = u113 and "I\'ll let my flower bloom for my own sake!" or ".. let this flower bloom for myself!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 2));
    end));
end;

return v15;