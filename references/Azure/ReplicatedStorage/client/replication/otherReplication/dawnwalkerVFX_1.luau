 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local Util = require(ReplicatedStorage.util.Util);
local styles = require(ReplicatedStorage.wiki.styles);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.VfxHandler);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local color = styles.dawnwalker.color;
local dawnwalker = vfxUtil.getResources().dawnwalker;
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);

local function is_local_character(p2) -- Line: 27
    -- upvalues: LocalPlayer (copy), Players (copy)
    return LocalPlayer == Players:GetPlayerFromCharacter(p2);
end;

local function apply_recolor(p3, ...) -- Line: 31
    -- upvalues: Util (copy), LocalPlayer (copy), vfxUtil (copy), color (copy)
    if Util.canshiftcolor(LocalPlayer, p3) then
        vfxUtil.LeanTowardsColor({ ... }, p3:GetAttribute("CustomColor") or color, p3:GetAttribute("CustomAlpha") or 0.985);
    end;
end;

local function get_accent_color(p4: any, p5) -- Line: 41
    -- upvalues: Util (copy), LocalPlayer (copy), color (copy)
    if Util.canshiftcolor(LocalPlayer, p4) then
        return p5:Lerp(p4:GetAttribute("CustomColor") or color, p4:GetAttribute("CustomAlpha") or 0.985);
    end;

    return p5;
end;

function v1.dawnwalker_radiant_kick(p6) -- Line: 51
    -- upvalues: vfxUtil (copy), dawnwalker (copy)
    if not vfxUtil.getRoot(p6) then
        return;
    end;

    local v7 = vfxUtil.character_trove(p6);
    local RadiantKick = dawnwalker.RadiantKick;
    local v8 = v7:Construct(RadiantKick.VFX);
    vfxUtil.setupAura(p6, v8, true);
    v8.Parent = workspace.Effects;
    vfxUtil.execute_compiled(RadiantKick.Compiled, v7, v8);
    v7:Add(task.delay(2.5, v7.Destroy, v7));
end;

function v1.dawnwalker_radiant_kick_flow(p9) -- Line: 68
    -- upvalues: vfxUtil (copy), dawnwalker (copy)
    local Root = vfxUtil.getRoot(p9);

    if not Root then
        return;
    end;

    local v10 = vfxUtil.character_trove(p9);
    local v11 = v10:Clone(dawnwalker.RadiantKick.Flow:FindFirstChildOfClass("Attachment"));
    v11.Parent = Root;
    shared.vfx.emit(v11).Finished:await();
    v10:Destroy();
end;

function v1.dawnwalker_blinding_dawn(p12: any, p13: boolean) -- Line: 83
    -- upvalues: vfxUtil (copy), dawnwalker (copy)
    if not vfxUtil.getRoot(p12) then
        return;
    end;

    local v14 = vfxUtil.character_trove(p12);
    local BlindingDawn = dawnwalker.BlindingDawn;
    local v15 = v14:Construct(BlindingDawn.VFX);
    vfxUtil.setupAura(p12, v15, true);
    v15.Parent = workspace.Effects;
    vfxUtil.execute_compiled(BlindingDawn.Compiled, v14, v15);
    v14:Add(task.delay(2.5, v14.Destroy, v14));
end;

function v1.dawnwalker_blinding_autogoal(p16: any, p17: number) -- Line: 102
    -- upvalues: vfxUtil (copy), dawnwalker (copy), mainreplication (copy), apply_recolor (copy), soundUtil (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(p16);

    if not Root then
        return;
    end;

    local Autogoal = dawnwalker.BlindingDawn.Autogoal;
    local u18 = vfxUtil.character_trove(p16);
    mainreplication.sceneEnabled(true);
    u18:Add(function() -- Line: 112
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    local v19 = u18:Construct(Autogoal.VFX);
    v19:PivotTo(p16:GetPivot());
    v19.Parent = workspace.Effects;
    apply_recolor(v19);
    soundUtil:play(Autogoal.Cast, "default");
    local v20, v21 = mainreplication.cutsceneAll(Root, CFrame.identity, p17, Autogoal.FOV_DawnAuto);
    u18:Add(v21);
    v19:FindFirstChild("CamVFX"):FindFirstChildOfClass("Weld").Part1 = v20:FindFirstChild("CamPart");
    v19:FindFirstChild("FakeRleg"):FindFirstChildOfClass("Weld").Part0 = p16["Right Leg"];
    v19:FindFirstChild("SpinBeam"):FindFirstChildOfClass("Weld").Part1 = p16.Torso;
    local v22 = {
        Vignette = u18:Add(vfxUtil.getMoonEffects()).Vignette,
        Lighting = game.Lighting
    };
    vfxUtil.contain_lighting(u18, v22, Autogoal.Lighting);
    vfxUtil.execute_compiled(Autogoal.Compiled, u18, v19);
    vfxUtil.cutscene_invisiball(p16, u18);
    local v23 = u18:Construct(MoonPropertyAnimator);
    v23:LoadAndConvertSave(Autogoal.Moon, v22);
    v23:SetRoot(Root);
    v23:PlayAll();
    u18:Add(task.delay(p17, function() -- Line: 147
        -- upvalues: u18 (copy)
        u18:Destroy();
    end));
end;

function v1.dawnwalker_blinding_special(p24) -- Line: 221
    -- upvalues: vfxUtil (copy), dawnwalker (copy), apply_recolor (copy), LocalPlayer (copy), Players (copy), mainreplication (copy)
    local Root = vfxUtil.getRoot(p24);

    if not Root then
        return;
    end;

    local v25 = vfxUtil.character_trove(p24);
    local Autogoal = dawnwalker.BlindingDawn.Autogoal;
    local v26 = Autogoal:FindFirstChild("Goal") or Autogoal:FindFirstChild("GoalVFX");

    if v26 then
        local v27 = v25:Clone(v26);
        v27:PivotTo(Root.CFrame);
        v27.Parent = workspace.Effects;
        apply_recolor(v27);
        shared.vfx.emit(v27);
    end;

    if LocalPlayer == Players:GetPlayerFromCharacter(p24) then
        mainreplication.cameraShake(12, 0.5, 4);
    end;

    v25:Add(task.delay(2.5, v25.Destroy, v25));
end;

function v1.dawnwalker_radiant_dawn(p28: any, p29: boolean?) -- Line: 246
    -- upvalues: vfxUtil (copy), dawnwalker (copy)
    local Root = vfxUtil.getRoot(p28);

    if not Root then
        return;
    end;

    local v30 = vfxUtil.character_trove(p28);
    local RadiantDawn = dawnwalker.RadiantDawn;

    if p29 then
        local v31 = v30:Clone(RadiantDawn:FindFirstChild("Control"));
        v31.Parent = Root;
        shared.vfx.emit(v31).Finished:await();
        v30:Destroy();

        return;
    end;

    local v32 = v30:Clone(RadiantDawn:FindFirstChild("WindUp"));
    v32.Parent = Root;
    shared.vfx.emit(v32).Finished:await();
    v30:Destroy();
end;

function v1.dawnwalker_strong_left(u33: any, u34: boolean?, p35: any) -- Line: 273
    -- upvalues: vfxUtil (copy), dawnwalker (copy), mainreplication (copy), TweenInfo_new_ret (copy), LocalPlayer (copy), Players (copy)
    local Root = vfxUtil.getRoot(u33);

    if not Root then
        return;
    end;

    local u36 = vfxUtil.character_trove(u33);
    local StrongLeft = dawnwalker.StrongLeft;
    local v37 = u36:Construct(StrongLeft.VFX);
    vfxUtil.setupAura(u33, v37, true);
    v37.Parent = workspace.Effects;

    if p35 then
        vfxUtil.LeanTowardsColor(v37, u33:GetAttribute("CustomColor") or Color3.fromRGB(85, 255, 0), u33:GetAttribute("CustomAlpha") or 0.985);
    end;

    vfxUtil.execute_compiled(StrongLeft.Compiled, u36, v37);
    u36:Add(task.delay(0.35, function() -- Line: 290
        -- upvalues: u34 (copy), mainreplication (ref), Root (copy), TweenInfo_new_ret (ref), u36 (copy), u33 (copy), LocalPlayer (ref), Players (ref)
        local u38 = u34 == true and 200 or 175;
        mainreplication.bodyVelocity(Root, u34 == true and 85 or 70, 0.35, nil, nil, nil, TweenInfo_new_ret);
        u36:Add(task.delay(0.167, function() -- Line: 295
            -- upvalues: mainreplication (ref), Root (ref), u38 (copy), TweenInfo_new_ret (ref)
            mainreplication.bodyVelocity(Root, u38, 0.35, nil, nil, nil, TweenInfo_new_ret);
        end));

        if LocalPlayer == Players:GetPlayerFromCharacter(u33) then
            mainreplication.cameraShake(10, 0.6, 3);
            u36:Add(task.delay(0.167, function() -- Line: 301
                -- upvalues: mainreplication (ref)
                mainreplication.cameraShake(10, 0.3, 6);
            end));
        end;
    end));
    u36:Add(task.delay(0.85, u36.Destroy, u36));
end;

function v1.dawnwalker_strong_right(u39: any, u40: boolean?, p41: any) -- Line: 310
    -- upvalues: vfxUtil (copy), dawnwalker (copy), mainreplication (copy), TweenInfo_new_ret (copy), LocalPlayer (copy), Players (copy)
    local Root = vfxUtil.getRoot(u39);

    if not Root then
        return;
    end;

    local u42 = vfxUtil.character_trove(u39);
    local StrongRight = dawnwalker.StrongRight;
    local v43 = u42:Construct(StrongRight.VFX);
    vfxUtil.setupAura(u39, v43, true);
    v43.Parent = workspace.Effects;

    if p41 then
        vfxUtil.LeanTowardsColor(v43, u39:GetAttribute("CustomColor") or Color3.fromRGB(85, 255, 0), u39:GetAttribute("CustomAlpha") or 0.985);
    end;

    vfxUtil.execute_compiled(StrongRight.Compiled, u42, v43);
    u42:Add(task.delay(0.35, function() -- Line: 329
        -- upvalues: u40 (copy), mainreplication (ref), Root (copy), TweenInfo_new_ret (ref), u42 (copy), u39 (copy), LocalPlayer (ref), Players (ref)
        local u44 = u40 == true and 200 or 175;
        mainreplication.bodyVelocity(Root, u40 == true and 85 or 70, 0.35, nil, nil, nil, TweenInfo_new_ret);
        u42:Add(task.delay(0.167, function() -- Line: 334
            -- upvalues: mainreplication (ref), Root (ref), u44 (copy), TweenInfo_new_ret (ref)
            mainreplication.bodyVelocity(Root, u44, 0.35, nil, nil, nil, TweenInfo_new_ret);
        end));

        if LocalPlayer == Players:GetPlayerFromCharacter(u39) then
            mainreplication.cameraShake(10, 0.6, 3);
            u42:Add(task.delay(0.167, function() -- Line: 340
                -- upvalues: mainreplication (ref)
                mainreplication.cameraShake(10, 0.3, 6);
            end));
        end;
    end));
    u42:Add(task.delay(0.85, u42.Destroy, u42));
end;

function v1.dawnwalker_absolute_radiance(p45) -- Line: 350
    -- upvalues: vfxUtil (copy), dawnwalker (copy)
    local Root = vfxUtil.getRoot(p45);

    if not Root then
        return;
    end;

    local v46 = vfxUtil.character_trove(p45);
    v46:Clone(dawnwalker.AbsoluteRadiance.Aura).Parent = Root;
    v46:Add(task.delay(20, v46.Destroy, v46));
end;

function v1.dawnwalker_crazy_slots_roll(p47) -- Line: 363
    -- upvalues: vfxUtil (copy), dawnwalker (copy)
    local Root = vfxUtil.getRoot(p47);

    if not Root then
        return;
    end;

    local u48 = vfxUtil.character_trove(p47);
    u48:Add(task.delay(0.4, function() -- Line: 371
        -- upvalues: u48 (copy), dawnwalker (ref), Root (copy)
        local v49 = u48:Clone(dawnwalker.CrazySlots:FindFirstChild("VFX"));
        v49.CFrame = Root.CFrame;
        v49.Parent = workspace.Effects;
        shared.vfx.emit(v49).Finished:await();
        u48:Destroy();
    end));
end;

function v1.dawnwalker_crazy_slots_result(p50: any, p51: string) -- Line: 382
    -- upvalues: LocalPlayer (copy), Players (copy), color (copy), Util (copy), TekrinnDialogue (copy)
    if LocalPlayer ~= Players:GetPlayerFromCharacter(p50) then
        return;
    end;

    local v52 = color;

    if Util.canshiftcolor(LocalPlayer, p50) then
        v52 = v52:Lerp(p50:GetAttribute("CustomColor") or color, p50:GetAttribute("CustomAlpha") or 0.985);
    end;

    TekrinnDialogue.Speak(p50, {
        {
            Bold = false,
            Italic = false,
            TypeSpeed = 0.05,
            Text = `Ah, {p51}? Not a bad roll. I'll show you just a taste of what I've seen...`,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v52), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 1,
                Lifetime = 1
            }
        }
    }, 5);
end;

function v1.dawnwalker_awaken(u53: any, p54: number) -- Line: 408
    -- upvalues: vfxUtil (copy), dawnwalker (copy), mainreplication (copy), apply_recolor (copy), Util (copy), LocalPlayer (copy), color (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local Root = vfxUtil.getRoot(u53);

    if not Root then
        return;
    end;

    local v55 = vfxUtil.character_trove(u53);
    local Awaken = dawnwalker.Awaken;
    mainreplication.sceneEnabled(true);
    v55:Add(function() -- Line: 418
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    local v56 = v55:Construct(Awaken.Aura);
    vfxUtil.setupAura(u53, v56, true);
    v56.Parent = workspace.Effects;
    local v57 = v55:Clone(Awaken.VFX);
    v57:PivotTo(Root.CFrame);
    v57.Parent = workspace.Effects;
    local v58 = v55:Clone(Awaken.Halo);
    local v59 = v58:FindFirstChildOfClass("Motor6D");
    v59.Part0 = u53:FindFirstChild("Right Arm");
    v59.Parent = v59.Part0;
    v58.Parent = u53;
    apply_recolor(v56);
    apply_recolor(v58);
    apply_recolor(v57);
    local v60 = v58["Dawnwalker Halo"]:FindFirstChildOfClass("MeshPart");
    local Color = v60.Color;

    if Util.canshiftcolor(LocalPlayer, u53) then
        Color = Color:Lerp(u53:GetAttribute("CustomColor") or color, u53:GetAttribute("CustomAlpha") or 0.985);
    end;

    v60.Color = Color;
    local v61, v62 = mainreplication.cutsceneCamRigWithLetterBox(Root, Awaken.Camera, Awaken.FOV, nil, CFrame.new(0, -3, 0) * CFrame.Angles(0, -1.5707963267948966, 0), Awaken.Cam, "CamPart");
    v55:Add(v62);

    if v61 then
        v57:FindFirstChild("CamVFX"):FindFirstChildOfClass("Weld").Part0 = v61:FindFirstChild("CamPart");
        v57:FindFirstChild("FakeHead"):FindFirstChildOfClass("Weld").Part0 = u53:FindFirstChild("Head");
    end;

    v57:FindFirstChild("Charge"):FindFirstChild("Large"):FindFirstChildOfClass("Weld").Part0 = v58.PrimaryPart;
    local v63 = {
        Main = v55:Add(vfxUtil.getMoonEffects()).Vignette,
        Lighting = game.Lighting
    };
    vfxUtil.contain_lighting(v55, v63, Awaken.Lighting);
    vfxUtil.execute_compiled(Awaken.Compiled, v55, v56, v57);
    local v64 = v55:Construct(MoonPropertyAnimator);
    v64:LoadAndConvertSave(Awaken.Moon, v63);
    v64:SetRoot(Root);
    v64:PlayAll();
    v55:Add(task.delay(0.8, function() -- Line: 474
        -- upvalues: u53 (copy), color (ref), Util (ref), LocalPlayer (ref), TekrinnDialogue (ref)
        local v65 = u53;
        local v66 = color;

        if Util.canshiftcolor(LocalPlayer, v65) then
            v66 = v66:Lerp(v65:GetAttribute("CustomColor") or color, v65:GetAttribute("CustomAlpha") or 0.985);
        end;

        TekrinnDialogue.Speak(u53, {
            {
                Text = "Allow me to show ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v66), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "you",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, v66) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 2);
    end));
    v55:Add(task.delay(3, function() -- Line: 512
        -- upvalues: u53 (copy), color (ref), Util (ref), LocalPlayer (ref), TekrinnDialogue (ref)
        local v67 = u53;
        local v68 = color;

        if Util.canshiftcolor(LocalPlayer, v67) then
            v68 = v68:Lerp(v67:GetAttribute("CustomColor") or color, v67:GetAttribute("CustomAlpha") or 0.985);
        end;

        TekrinnDialogue.Speak(u53, {
            {
                Text = "The true light of a ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v68), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "DAWNWALKER",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, v68) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 2);
    end));
    v55:Add(task.delay(6.35, v55.Destroy, v55));
end;

return v1;