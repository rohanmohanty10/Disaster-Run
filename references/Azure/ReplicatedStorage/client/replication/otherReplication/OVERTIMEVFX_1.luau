 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
game:GetService("TweenService");
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local trove = require(ReplicatedStorage.forum.trove);
local replication = ReplicatedStorage.client.replication;
local mainreplication = require(replication.mainreplication);
local OvertimeCutIn = vfxUtil.getResources().OvertimeCutIn;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = nil;
local u2 = {};

function u2.otCutInReferee(u3: string) -- Line: 31
    -- upvalues: OvertimeCutIn (copy), u1 (ref), workspace_CurrentCamera (copy), trove (copy), u2 (copy), Lighting (copy), mainreplication (copy), vfxUtil (copy), animationUtil (copy), MoonPropertyAnimator (copy), soundUtil (copy)
    local Referee = OvertimeCutIn.Referee;
    u1 = workspace_CurrentCamera.CFrame;
    local u4 = trove.new();
    u4:Add(task.delay(4.667, function() -- Line: 37
        -- upvalues: u4 (copy), u2 (ref), u3 (copy)
        u4:Destroy();

        if u2.otCutInCommentators then
            u2.otCutInCommentators(u3);
        end;
    end));
    Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    Lighting.Bloom.Enabled = false;
    mainreplication.sceneEnabled(true);
    local v5 = u4:Clone(Referee.Character);
    v5:SetAttribute("IgnoresTheKid", true);
    v5.Parent = workspace.Effects;
    local overtimeRef = workspace.map.something:FindFirstChild("overtimeRef");

    if overtimeRef then
        v5:PivotTo(overtimeRef.CFrame);
    end;

    local Root = vfxUtil.getRoot(v5);
    animationUtil:loadAnimation(v5, Referee.Animation):Play(0);
    u4:Add(mainreplication.kuronaCam(Root, Referee.Cam, Referee.FOV, nil, nil, {
        OriginCFrame = u1
    }));
    local v6 = u4:Add(vfxUtil.getMoonEffects());
    local v7 = {
        Letterbox = v6.Letterbox.Letterbox,
        Vignette = v6.Vignette
    };

    for _, child in Referee.Lighting:GetChildren() do
        u4:Clone(child).Parent = Lighting;
        v7[child.Name] = child;
    end;

    local v8 = u4:Construct(MoonPropertyAnimator);
    v8:LoadAndConvertSave(Referee.Moon, v7);
    v8:PlayAll();
    soundUtil:play(Referee.SFX, soundUtil);
end;

local function createSubtitle(p9, p10) -- Line: 82
    -- upvalues: PlayerGui (copy), replication (copy), Debris (copy)
    pcall(game.Destroy, PlayerGui:FindFirstChild("SubtitleUI"));
    local v11 = replication.Subtitles:Clone();
    v11.Name = "SubtitleUI";
    v11.Holder.Dialogue.Text = p9;
    v11.Parent = PlayerGui;
    Debris:AddItem(v11, p10);

    return v11;
end;

local u12 = { { 0.467, "One minute of additional time.." }, { 2.294, ".. and BALLHOLDER has the ball!" }, { 3.545, "So little time left!" }, { 5.007, "Will this be the last play?" } };

function u2.otCutInCommentators(p13: string) -- Line: 99
    -- upvalues: OvertimeCutIn (copy), trove (copy), animationUtil (copy), mainreplication (copy), u1 (ref), Lighting (copy), vfxUtil (copy), PlayerGui (copy), MoonPropertyAnimator (copy), soundUtil (copy), u12 (copy), replication (copy), Debris (copy)
    local Commentators = OvertimeCutIn.Commentators;
    local workspace_overtime = workspace.overtime;
    local u14 = trove.new();
    u14:Add(task.delay(6.333, function() -- Line: 106
        -- upvalues: u14 (copy)
        u14:Destroy();
    end));
    local v15 = {};
    local v16 = `Reporter{1}`;
    table.insert(v15, animationUtil:loadAnimation(workspace_overtime[v16], Commentators[v16]));
    local v17 = `Reporter{2}`;
    table.insert(v15, animationUtil:loadAnimation(workspace_overtime[v17], Commentators[v17]));

    for _, v in ipairs(v15) do
        v:Play(0);
    end;

    u14:Add(mainreplication.kuronaCam(workspace_overtime.Reporter1.HumanoidRootPart, Commentators.Cam, Commentators.FOV, nil, nil, {
        OriginCFrame = u1
    }));

    for _, child in Commentators.Lighting:GetChildren() do
        u14:Clone(child).Parent = Lighting;
    end;

    local v18 = u14:Add(vfxUtil.getMoonEffects());
    u14:Clone(OvertimeCutIn.Bars).Parent = PlayerGui;
    local v19 = u14:Construct(MoonPropertyAnimator);
    v19:LoadAndConvertSave(Commentators.Moon, {
        Vignette = v18.Vignette
    });
    v19:PlayAll();
    soundUtil:play(Commentators.SFX, soundUtil);

    for i = 1, #u12 do
        local u20 = u12[i];
        local u21 = u12[i + 1];
        local u22 = u20[2]:gsub("BALLHOLDER", p13);
        u14:Add(task.delay(u20[1], function() -- Line: 143
            -- upvalues: u22 (copy), u21 (copy), u20 (copy), PlayerGui (ref), replication (ref), Debris (ref)
            local v23 = u21 and u21[1] - u20[1] or 6.333 - u20[1];
            pcall(game.Destroy, PlayerGui:FindFirstChild("SubtitleUI"));
            local v24 = replication.Subtitles:Clone();
            v24.Name = "SubtitleUI";
            v24.Holder.Dialogue.Text = u22;
            v24.Parent = PlayerGui;
            Debris:AddItem(v24, v23);
        end));
        local _ = i;
    end;
end;

function u2.otCutInFinished() -- Line: 149
    -- upvalues: OvertimeCutIn (copy), ReplicatedStorage (copy), actionUtil (copy), LocalPlayer (copy), mainreplication (copy), Lighting (copy)
    local _ = OvertimeCutIn.Lighting;
    local _ = ReplicatedStorage.workspace.disabled;

    if actionUtil.ingame(LocalPlayer.Character) then
        mainreplication.sceneEnabled(false);
    end;

    Lighting.Bloom.Enabled = true;
end;

function u2.otCutInCleanup() -- Line: 185
    -- upvalues: Lighting (copy)
    Lighting.ClockTime = 12;

    for _, child in Lighting:GetChildren() do
        if child.Name == "OVERTIME" then
            child:Destroy();
        end;
    end;

    Lighting.Ambient = Color3.new(1, 1, 1);
end;

local u25 = nil;

function u2.otCutIn_shidou(u26) -- Line: 197
    -- upvalues: OvertimeCutIn (copy), vfxUtil (copy), trove (copy), u25 (ref), PlayerGui (copy), Lighting (copy), MoonPropertyAnimator (copy), mainreplication (copy), u1 (ref), soundUtil (copy), replication (copy), Debris (copy)
    local shidou = OvertimeCutIn.Styles.shidou;
    local Root = vfxUtil.getRoot(u26);
    local Attribute = shidou:GetAttribute("Length");
    local u27 = trove.new();
    u27:Add(task.delay(Attribute, function() -- Line: 203
        -- upvalues: u27 (copy)
        u27:Destroy();
    end));
    task.defer(function() -- Line: 207
        -- upvalues: u26 (copy), u27 (copy)
        local Ball = u26:WaitForChild("Ball", 1);

        if Ball then
            Ball.Size = Vector3.new(1.5, 1.5, 1.5);
            u27:Add(function() -- Line: 211
                -- upvalues: Ball (copy)
                Ball.Size = Vector3.new(1.95, 1.95, 1.95);
            end);
        end;
    end);
    local v28 = u27:Clone(shidou.VFX);
    v28.Parent = workspace.Effects;
    local v29 = u27:Clone(shidou.CharacterFX);
    vfxUtil.setupAura(u26, v29, true);
    v29.Parent = workspace.Effects;

    if not u25 then
        u25 = require(shidou.Compiled);
    end;

    for _, v in ipairs(u25) do
        u27:Add(task.delay(v[1] / 60, v[2], v28, v29));
    end;

    u27:Clone(OvertimeCutIn.Bars).Parent = PlayerGui;
    local v30 = {};

    for _, child in shidou.Lighting:GetChildren() do
        local v31 = u27:Clone(child);
        v31.Parent = Lighting;
        v30[child.Name] = v31;
    end;

    local v32 = u27:Construct(MoonPropertyAnimator);
    v32:LoadAndConvertSave(shidou.Moon, v30);
    v32:PlayAll();
    u27:Add(mainreplication.kuronaCam(Root, shidou.Cam, shidou.FOV, nil, nil, {
        OriginCFrame = u1
    }));
    local u33 = soundUtil:play(shidou.SFX, soundUtil, {
        Character = u26
    }).Name == "Dub";
    u27:Add(task.delay(0.113, function() -- Line: 248
        -- upvalues: u33 (copy), PlayerGui (ref), replication (ref), Debris (ref)
        pcall(game.Destroy, PlayerGui:FindFirstChild("SubtitleUI"));
        local v34 = replication.Subtitles:Clone();
        v34.Name = "SubtitleUI";
        v34.Holder.Dialogue.Text = u33 and "Yeah this is gonna be GOOD!" or "Totally hot, no doubt!";
        v34.Parent = PlayerGui;
        Debris:AddItem(v34, 1.774);
    end));
end;

local u35 = nil;

function u2.otCutIn_sae(u36) -- Line: 255
    -- upvalues: OvertimeCutIn (copy), vfxUtil (copy), trove (copy), u35 (ref), PlayerGui (copy), Lighting (copy), MoonPropertyAnimator (copy), mainreplication (copy), u1 (ref), soundUtil (copy)
    local sae = OvertimeCutIn.Styles.sae;
    local Root = vfxUtil.getRoot(u36);
    local Attribute = sae:GetAttribute("Length");
    local u37 = trove.new();
    u37:Add(task.delay(Attribute, function() -- Line: 261
        -- upvalues: u37 (copy)
        u37:Destroy();
    end));
    task.defer(function() -- Line: 265
        -- upvalues: u36 (copy), u37 (copy)
        local Ball = u36:WaitForChild("Ball", 1);

        if Ball then
            Ball.Size = Vector3.new(1.5, 1.5, 1.5);
            u37:Add(function() -- Line: 269
                -- upvalues: Ball (copy)
                Ball.Size = Vector3.new(1.95, 1.95, 1.95);
            end);
        end;
    end);
    local v38 = u37:Clone(sae.VFX);
    v38.Parent = workspace.Effects;
    local v39 = u37:Clone(sae.CharacterFX);
    vfxUtil.setupAura(u36, v39, true);
    v39.Parent = workspace.Effects;

    if not u35 then
        u35 = require(sae.Compiled);
    end;

    for _, v in ipairs(u35) do
        u37:Add(task.delay(v[1] / 60, v[2], v38, v39));
    end;

    u37:Clone(OvertimeCutIn.Bars).Parent = PlayerGui;
    local v40 = {
        Vignette = u37:Add(vfxUtil.getMoonEffects()).Vignette
    };

    for _, child in sae.Lighting:GetChildren() do
        local v41 = u37:Clone(child);
        v41.Parent = Lighting;
        v40[child.Name] = v41;
    end;

    local v42 = u37:Construct(MoonPropertyAnimator);
    v42:LoadAndConvertSave(sae.Moon, v40);
    v42:PlayAll();
    u37:Add(mainreplication.kuronaCam(Root, sae.Cam, sae.FOV, nil, nil, {
        OriginCFrame = u1
    }));
    soundUtil:play(sae.SFX, soundUtil);
end;

return u2;