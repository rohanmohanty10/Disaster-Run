 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local trove = require(ReplicatedStorage.forum.trove);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local shidouAutogoalZone = require(ReplicatedStorage.util.shidouAutogoalZone);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
Color3.fromRGB(255, 105, 180);
local u1 = {};
local u2 = {};
local u3 = {};

local function getZoneMarker(p4: string) -- Line: 28
    return workspace.map.something:FindFirstChild((`shidouBackheel{p4}`));
end;

local function ensureZoneVisual(p5: string) -- Line: 32
    -- upvalues: u1 (copy), shidouAutogoalZone (copy)
    local v6 = workspace.map.something:FindFirstChild((`shidouBackheel{p5}`));

    if not v6 then
        return nil;
    end;

    local v7 = u1[p5];

    if v7 and v7.part.Parent then
        v7.part.CFrame = shidouAutogoalZone.getGroundCFrame(v6);

        return v7;
    end;

    local v8 = script.shidouhighlight:Clone();
    v8.Size = shidouAutogoalZone.getGroundSize();
    v8.CFrame = shidouAutogoalZone.getGroundCFrame(v6);
    v8.Parent = workspace.Effects;
    u1[p5] = {
        part = v8,
        highlight = v8:FindFirstChildOfClass("Highlight")
    };

    return u1[p5];
end;

local function untrackAutogoalCharacter(p9: userdata) -- Line: 55
    -- upvalues: u3 (copy)
    local v10 = u3[p9];

    if v10 then
        v10:Disconnect();
        u3[p9] = nil;
    end;
end;

local function setZoneVisualVisible(p11: string, p12: boolean) -- Line: 63
    -- upvalues: ensureZoneVisual (copy), u1 (copy)
    if p12 then
        local v13 = ensureZoneVisual(p11);

        if v13 then
            v13.highlight.Enabled = true;
        end;

        return;
    end;

    local v14 = u1[p11];

    if v14 then
        if v14.part.Parent then
            v14.part:Destroy();
        end;

        u1[p11] = nil;
    end;
end;

local function refreshAutogoalZoneHighlights() -- Line: 81
    -- upvalues: u2 (copy), u3 (copy), ensureZoneVisual (copy), u1 (copy)
    local v15 = false;
    local v16 = false;

    for i, v in u2 do
        if i.Parent then
            if v == "A" then
                v15 = true;
            elseif v == "B" then
                v16 = true;
            end;
        else
            u2[i] = nil;
            local v17 = u3[i];

            if v17 then
                v17:Disconnect();
                u3[i] = nil;
            end;
        end;
    end;

    if v15 then
        local v18 = ensureZoneVisual("A");

        if v18 then
            v18.highlight.Enabled = true;
        end;
    else
        local A = u1.A;

        if A then
            if A.part.Parent then
                A.part:Destroy();
            end;

            u1.A = nil;
        end;
    end;

    if v16 then
        local v19 = ensureZoneVisual("B");

        if v19 then
            v19.highlight.Enabled = true;
        end;
    else
        local B = u1.B;

        if B then
            if B.part.Parent then
                B.part:Destroy();
            end;

            u1.B = nil;
        end;
    end;
end;

local function trackAutogoalCharacter(u20: userdata) -- Line: 101
    -- upvalues: u3 (copy), u2 (copy), refreshAutogoalZoneHighlights (copy)
    if u3[u20] then
        return;
    end;

    u3[u20] = u20.Destroying:Connect(function() -- Line: 106
        -- upvalues: u20 (copy), u3 (ref), u2 (ref), refreshAutogoalZoneHighlights (ref)
        local v21 = u20;
        local v22 = u3[v21];

        if v22 then
            v22:Disconnect();
            u3[v21] = nil;
        end;

        if u2[u20] ~= nil then
            u2[u20] = nil;
            refreshAutogoalZoneHighlights();
        end;
    end);
end;

local ExposureCompensation = Lighting.ExposureCompensation;
local v28 = {
    shidouAutogoalZoneHighlight = function(u23: userdata, p24: string?) -- Line: 119, Name: shidouAutogoalZoneHighlight
        -- upvalues: u2 (copy), u3 (copy), refreshAutogoalZoneHighlights (copy)
        u2[u23] = p24;

        if p24 then
            if not u3[u23] then
                u3[u23] = u23.Destroying:Connect(function() -- Line: 106
                    -- upvalues: u23 (copy), u3 (ref), u2 (ref), refreshAutogoalZoneHighlights (ref)
                    local v25 = u23;
                    local v26 = u3[v25];

                    if v26 then
                        v26:Disconnect();
                        u3[v25] = nil;
                    end;

                    if u2[u23] ~= nil then
                        u2[u23] = nil;
                        refreshAutogoalZoneHighlights();
                    end;
                end);
            end;
        else
            local v27 = u3[u23];

            if v27 then
                v27:Disconnect();
                u3[u23] = nil;
            end;
        end;

        refreshAutogoalZoneHighlights();
    end
};
local u29 = nil;

function v28.idkwhatthisis(u30) -- Line: 132
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), Lighting (copy), ExposureCompensation (copy), MoonPropertyAnimator (copy), u29 (ref), TekrinnDialogue (copy)
    local AwkOvertime = vfxUtil.getResources().shidou.AwkOvertime;
    local Root = vfxUtil.getRoot(u30);
    local u31 = soundUtil:play(AwkOvertime.SFX, soundUtil, {
        Character = u30
    }).Name == "Dub";
    mainreplication.sceneEnabled(true);
    local u32 = trove.new();
    u32:Add(function() -- Line: 143
        -- upvalues: mainreplication (ref), Lighting (ref), ExposureCompensation (ref)
        mainreplication.sceneEnabled(false);
        Lighting.ExposureCompensation = ExposureCompensation;
    end);
    u32:Add(task.delay(14.333, function() -- Line: 147
        -- upvalues: u32 (copy)
        u32:Destroy();
    end));
    u32:Add(task.delay(14.3, function() -- Line: 150
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1);
    end));
    local v33, v34 = mainreplication.cutsceneCamRigWithLetterBox(Root, AwkOvertime.CamAnimation, AwkOvertime.FOV, nil, CFrame.new(0, -3, 0), AwkOvertime.Cam, "CamPart");
    u32:Add(v34);
    local v35 = u32:Clone(AwkOvertime.CharacterFX);
    v35:PivotTo(Root.CFrame);
    vfxUtil.setupAura(u30, v35, true);
    v35.Parent = workspace.Effects;
    local v36 = u32:Clone(AwkOvertime.VFX);
    v36:PivotTo(Root.CFrame);
    v36.Parent = workspace.Effects;
    local v37 = {
        MoonAnimatorEffects = u32:Add(vfxUtil.getMoonEffects()),
        Lighting = Lighting,
        Shidou = v35,
        Domain = v36.Domain,
        DomainNeon = v36.DomainNeon,
        Shadow = v36.Shadow
    };

    for _, child in AwkOvertime.Lighting:GetChildren() do
        local v38 = u32:Clone(child);
        v38.Parent = Lighting;
        v37[child.Name] = v38;
    end;

    local v39 = u32:Construct(MoonPropertyAnimator);
    v39:LoadAndConvertSave(AwkOvertime.Moon, v37);
    v39:SetOriginalRoot(AwkOvertime.VFX:GetPivot());
    v39:SetRoot(Root);
    v39:PlayAll();

    if not u29 then
        u29 = require(AwkOvertime.Compiled);
    end;

    for _, v in ipairs(u29) do
        u32:Add(task.delay(v[1] / 60, v[2], v37.Blur, v36, v33, v35));
    end;

    u32:Add(task.delay(0.883, function() -- Line: 194
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "Impossible?",
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }, 3));
    end));
    u32:Add(task.delay(2.147, function() -- Line: 218
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "What\'s with that concept?",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 4));
    end));

    for _, v in { 4.305, 4.723, 5.107 } do
        u32:Add(task.delay(v, function() -- Line: 241
            -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
            if u31 then
                return;
            end;

            u32:Add(TekrinnDialogue.Speak(u30, {
                {
                    Text = "EXPLOSION!",
                    Bold = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2));
        end));
    end;

    u32:Add(task.delay(5.534, function() -- Line: 264
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "AND...",
                Italic = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 3));
    end));
    u32:Add(task.delay(6.602, function() -- Line: 286
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "Boom!",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 5
                }
            }
        }, 5));
    end));
    u32:Add(task.delay(8.281, function() -- Line: 308
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "My life is ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 5
                }
            },
            {
                Text = "boiling",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 5
                }
            },
            {
                Text = " over!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 5
                }
            }
        }, 5));
    end));
    u32:Add(task.delay(11.117, function() -- Line: 356
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "Awesome.",
                Bold = true,
                Font = Enum.Font.Fondamento,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }, 1.3399999999999999));
    end));
    u32:Add(task.delay(0.017, function() -- Line: 379
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if not u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "I saw you going wild.",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 1.2));
    end));
    u32:Add(task.delay(1.383, function() -- Line: 398
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if not u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "Looks like I\'m gonna have to put a stop to that.",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 2.4));
    end));
    u32:Add(task.delay(4.05, function() -- Line: 417
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if not u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "HAHAHAHAHA",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 2));
    end));
    u32:Add(task.delay(6.233, function() -- Line: 438
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if not u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "BOOM BABY!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 1));
    end));
    u32:Add(task.delay(7.367, function() -- Line: 459
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if not u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "What I have is a biological need!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 3.5));
    end));
    u32:Add(task.delay(11.183, function() -- Line: 478
        -- upvalues: u31 (copy), u32 (copy), TekrinnDialogue (ref), u30 (copy)
        if not u31 then
            return;
        end;

        u32:Add(TekrinnDialogue.Speak(u30, {
            {
                Text = "Awesome..",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Font = Enum.Font.Fondamento,
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 2.5));
    end));
end;

function v28.shidouOvertime(u40: any, p41: userdata) -- Line: 501
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), Lighting (copy), ExposureCompensation (copy), Util (copy), MoonPropertyAnimator (copy), u29 (ref), TekrinnDialogue (copy)
    local AwkOvertime = vfxUtil.getResources().shidou.AwkOvertime;
    local Root = vfxUtil.getRoot(u40);
    local Attribute = u40:GetAttribute("femlock");
    local v42 = soundUtil:play(Attribute and AwkOvertime.Parent.Femvoicelines.OTAWK or AwkOvertime.SFX, soundUtil, {
        Character = u40
    });
    local u43 = Attribute or v42.Name == "Dub";
    mainreplication.sceneEnabled(true);
    local u44 = trove.new();
    u44:Add(function() -- Line: 514
        -- upvalues: mainreplication (ref), Lighting (ref), ExposureCompensation (ref)
        mainreplication.sceneEnabled(false);
        Lighting.ExposureCompensation = ExposureCompensation;
    end);
    u44:Add(task.delay(14.333, function() -- Line: 518
        -- upvalues: u44 (copy)
        u44:Destroy();
    end));
    u44:Add(task.delay(14.3, function() -- Line: 521
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1);
    end));
    print(p41);

    if p41 then
        Util.flowCancel(u44, p41, { v42 });
    end;

    local v45, v46 = mainreplication.cutsceneCamRigWithLetterBox(Root, AwkOvertime.CamAnimation, AwkOvertime.FOV, nil, CFrame.new(0, -3, 0), AwkOvertime.CamRigWithLetterBox);
    u44:Add(v46);
    local v47 = u44:Clone(AwkOvertime.CharacterFX);
    v47:PivotTo(Root.CFrame);
    vfxUtil.setupAura(u40, v47, true);
    v47.Parent = workspace.Effects;
    local v48 = u44:Clone(AwkOvertime.VFX);
    v48:PivotTo(Root.CFrame);
    v48.Parent = workspace.Effects;
    local v49 = u44:Clone(AwkOvertime["red vignette"]);
    v49.Parent = vfxUtil.getPlayerGui();
    local v50 = {
        MoonAnimatorEffects = u44:Add(vfxUtil.getMoonEffects()),
        ["red vignette"] = v49,
        Lighting = Lighting,
        R6 = v47
    };

    for _, child in AwkOvertime.Lighting:GetChildren() do
        local v51 = u44:Clone(child);
        v51.Parent = Lighting;
        v50[child.Name] = v51;
    end;

    local v52 = u44:Construct(MoonPropertyAnimator);
    v52:LoadAndConvertSave(AwkOvertime.Moon, v50);
    v52:SetOriginalRoot(v47.HumanoidRootPart.CFrame);
    v52:SetRoot(Root);
    v52:PlayAll();

    if not u29 then
        u29 = require(AwkOvertime.Compiled);
    end;

    for _, v in ipairs(u29) do
        u44:Add(task.delay(v[1] / 60, v[2], v50.Blur, v48, v45, v47));
    end;

    u44:Add(task.delay(0.883, function() -- Line: 580
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "Impossible?",
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }, 3));
    end));
    u44:Add(task.delay(2.147, function() -- Line: 604
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "What\'s with that concept?",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 4));
    end));

    for _, v in { 4.305, 4.723, 5.107 } do
        u44:Add(task.delay(v, function() -- Line: 627
            -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
            if u43 then
                return;
            end;

            u44:Add(TekrinnDialogue.Speak(u40, {
                {
                    Text = "EXPLOSION!",
                    Bold = true,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2));
        end));
    end;

    u44:Add(task.delay(5.534, function() -- Line: 650
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "AND...",
                Italic = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 3));
    end));
    u44:Add(task.delay(6.602, function() -- Line: 672
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "Boom!",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 5
                }
            }
        }, 5));
    end));
    u44:Add(task.delay(8.281, function() -- Line: 694
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "My life is ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 5
                }
            },
            {
                Text = "boiling",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 5
                }
            },
            {
                Text = " over!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 5
                }
            }
        }, 5));
    end));
    u44:Add(task.delay(11.117, function() -- Line: 742
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "Awesome.",
                Bold = true,
                Font = Enum.Font.Fondamento,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }, 1.3399999999999999));
    end));
    u44:Add(task.delay(0.017, function() -- Line: 765
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if not u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "I saw you going wild.",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 1.2));
    end));
    u44:Add(task.delay(1.383, function() -- Line: 784
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if not u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "Looks like I\'m gonna have to put a stop to that.",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 2.4));
    end));
    u44:Add(task.delay(4.05, function() -- Line: 803
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if not u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "HAHAHAHA",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 2));
    end));
    u44:Add(task.delay(6.233, function() -- Line: 824
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if not u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "BOOM BABY!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 5,
                    Lifetime = 1
                }
            }
        }, 1));
    end));
    u44:Add(task.delay(7.367, function() -- Line: 845
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if not u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "What I have is a biological need!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 3.5));
    end));
    u44:Add(task.delay(11.183, function() -- Line: 864
        -- upvalues: u43 (copy), u44 (copy), TekrinnDialogue (ref), u40 (copy)
        if not u43 then
            return;
        end;

        u44:Add(TekrinnDialogue.Speak(u40, {
            {
                Text = "Awesome..",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 105)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Font = Enum.Font.Fondamento,
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 3
                }
            }
        }, 2.5));
    end));
end;

function v28.BananaShot(p53) -- Line: 887
    -- upvalues: ReplicatedStorage (copy), vfxUtil (copy), KatUtil (copy), mainreplication (copy), Players (copy), Lighting (copy), TweenService (copy)
    local v54 = p53.HumanoidRootPart or p53.PrimaryPart;
    local u55 = ReplicatedStorage.Resources.shidou.PivotShotVFX:Clone();
    u55.Parent = v54;
    vfxUtil.disposal(u55, 2);
    task.delay(0.15, function() -- Line: 895
        -- upvalues: KatUtil (ref), u55 (copy)
        KatUtil.forge_emit(u55.Spin);
    end);
    mainreplication.highlight(p53, Color3.fromRGB(254, 38, 225), 0.75);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p53) then
        mainreplication.springcamerashake(25, 15);
        mainreplication.fov(true, 55, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 8;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v56 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v56.Parent = Lighting;
        v56.TintColor = Color3.fromRGB(255, 255, 255);
        v56.Brightness = 0.3;
        v56.Contrast = 1;
        v56.Saturation = -0.4;
        TweenService:Create(v56, TweenInfo.new(0.66, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v56, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v56.Destroy, v56);
    end;
end;

function v28.BananaShotLand(p57) -- Line: 927
    -- upvalues: KatUtil (copy), Players (copy), mainreplication (copy)
    KatUtil.forge_emit((p57.HumanoidRootPart or p57.PrimaryPart).PivotShotVFX.Grab);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p57) then
        mainreplication.springcamerashake(25, 15);
    end;
end;

function v28.BananaShotShot(p58) -- Line: 936
    -- upvalues: KatUtil (copy), Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    KatUtil.forge_emit((p58.HumanoidRootPart or p58.PrimaryPart).PivotShotVFX.Kick);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p58) then
        mainreplication.springcamerashake(50, 40);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        local v59 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v59.Parent = Lighting;
        v59.TintColor = Color3.fromRGB(255, 115, 183);
        v59.Brightness = 0.4;
        v59.Contrast = 1;
        v59.Saturation = -0.4;
        TweenService:Create(v59, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v59, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v59.Destroy, v59);
    end;
end;

function v28.shidou_bigBangDrive(u60) -- Line: 961
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), Lighting (copy), ExposureCompensation (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local BigBangDrive = vfxUtil.getResources().shidou.BigBangDrive;
    local Root = vfxUtil.getRoot(u60);
    local Attribute = u60:GetAttribute("femlock");
    local v61 = Attribute or soundUtil:play(Attribute and BigBangDrive.Parent.Femvoicelines.BBD or BigBangDrive.SFX, soundUtil, {
        Character = u60
    }).Name == "Dub";
    mainreplication.sceneEnabled(true);
    local u62 = trove.new();
    u62:Add(function() -- Line: 973
        -- upvalues: mainreplication (ref), Lighting (ref), ExposureCompensation (ref)
        mainreplication.sceneEnabled(false);
        Lighting.ExposureCompensation = ExposureCompensation;
    end);
    u62:Add(task.delay(20.5, function() -- Line: 977
        -- upvalues: u62 (copy)
        u62:Destroy();
    end));
    u62:Add(task.delay(20.467, function() -- Line: 980
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(1);
    end));
    local v63, v64 = mainreplication.cutsceneCamRigWithLetterBox(Root, BigBangDrive.CamAnimation, BigBangDrive.FOV, nil, CFrame.new(0, -3, 0), BigBangDrive.CamRigWithLetterBox);
    u62:Add(v64);
    local v65 = u62:Clone(BigBangDrive.CharacterFX);
    v65:PivotTo(Root.CFrame);
    vfxUtil.setupAura(u60, v65, true);
    v65.Parent = workspace.Effects;
    local v66 = u62:Clone(BigBangDrive.VFX);
    v66:PivotTo(Root.CFrame);
    v66.Parent = workspace.Effects;
    local v67 = u62:Clone(BigBangDrive["red vignette"]);
    v67.Parent = vfxUtil.getPlayerGui();
    local v68 = {
        MoonAnimatorEffects = u62:Add(vfxUtil.getMoonEffects()),
        ["red vignette"] = v67,
        Lighting = Lighting,
        R6 = v65
    };

    for _, child in BigBangDrive.Lighting:GetChildren() do
        local v69 = u62:Clone(child);
        v69.Parent = Lighting;
        v68[child.Name] = v69;
    end;

    local v70 = u62:Construct(MoonPropertyAnimator);
    v70:LoadAndConvertSave(BigBangDrive.Moon, v68);
    v70:SetOriginalRoot(v65.HumanoidRootPart.CFrame);
    v70:SetRoot(Root);
    v70:PlayAll();
    local Compiled = require(BigBangDrive.Compiled);

    for _, v in ipairs(Compiled) do
        u62:Add(task.delay(v[1] / 60, v[2], v68.Blur, v66, v63, v65));
    end;

    if not v61 then
        u62:Add(task.delay(0.733, function() -- Line: 1026
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
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
            }, 2.5));
        end));
    end;

    if v61 then
        u62:Add(task.delay(0.9, function() -- Line: 1049
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
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
            }, 2.5));
        end));
    end;

    if v61 then
        u62:Add(task.delay(6, function() -- Line: 1072
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
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
            }, 2.9));
        end));
    end;

    if v61 then
        u62:Add(task.delay(10.11, function() -- Line: 1114
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
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
            }, 3));
        end));
    end;

    if v61 then
        u62:Add(task.delay(14.07, function() -- Line: 1150
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
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
            }, 3));
        end));
    end;

    if v61 then
        u62:Add(task.delay(18.09, function() -- Line: 1176
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
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
            }, 3.5));
        end));
    end;

    if not v61 then
        u62:Add(task.delay(6.267, function() -- Line: 1202
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
                {
                    Text = "are tingling and stirring to spark.",
                    TypeSpeed = 0.04,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            }, 5));
        end));
    end;

    if not v61 then
        u62:Add(task.delay(10.217, function() -- Line: 1225
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
                {
                    Text = "With my goal...",
                    TypeSpeed = 0.04,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 46, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
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
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 3));
        end));
    end;

    if not v61 then
        u62:Add(task.delay(13.995, function() -- Line: 1267
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
                {
                    Text = "BIG BANG DRIVE!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2
                    }
                }
            }, 3));
        end));
    end;

    if not v61 then
        u62:Add(task.delay(18.583, function() -- Line: 1293
            -- upvalues: u62 (copy), TekrinnDialogue (ref), u60 (copy)
            u62:Add(TekrinnDialogue.Speak(u60, {
                {
                    Text = "ILL BEAT YOU UP!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.04,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 124)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 1.15
                    }
                }
            }, 1.15));
        end));
    end;
end;

function v28.NEWshidouawk(u71, p72) -- Line: 1320
    -- upvalues: Lighting (copy), trove (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), PlayerGui (copy), TweenService (copy), soundUtil (copy), Color (copy), Density (copy), TekrinnDialogue (copy), Brightness (copy)
    local v73 = u71.HumanoidRootPart or u71.PrimaryPart;
    local _ = u71.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local u74 = trove.new();
    u74:Add(task.delay(8.767, function() -- Line: 1328
        -- upvalues: u74 (copy)
        u74:Destroy();
    end));
    mainreplication.bright(-1, -0.15);
    mainreplication.sceneEnabled(true);
    Lighting.Brightness = 2;
    local u75 = u74:Clone(ReplicatedStorage.Resources.shidou.NEWshidouawkEff);
    u75:PivotTo(v73.CFrame);
    u75.Parent = u71;

    if Util.canshiftcolor(LocalPlayer, u71) then
        vfxUtil.LeanTowardsColor(u75, u71:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u71:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u76 = u74:Clone(ReplicatedStorage.Resources.Blur);
    u76.Size = 36;
    u76.Parent = Lighting;

    for _, descendant in ipairs(u75:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    for _, descendant in ipairs(u75.fall:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    local u77 = u74:Clone(ReplicatedStorage.Resources.glowscreen);
    u77.ImageLabel2.ImageColor3 = Color3.new(0, 0, 0);
    u77.ImageLabel2.ImageTransparency = 1;
    u77.Parent = PlayerGui;
    local v78 = u74:Clone(ReplicatedStorage.Resources.DepthOfField);
    v78.Parent = Lighting;
    v78.FarIntensity = 0;
    TweenService:Create(v78, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local Attribute = u71:GetAttribute("femlock");
    local v79 = soundUtil:play(Attribute and ReplicatedStorage.Resources.shidou.Femvoicelines.awakening or ReplicatedStorage.Resources.shidou.NEWshiawk, "default", {
        Character = u71
    });
    local v80 = Attribute or v79.Name == "Dub";
    u74:Add((mainreplication.cutscene(v73, CFrame.new(Vector3.new(0, 0, 0)), 8.767, ReplicatedStorage.Resources.shidou.NEWShidouUltFOV)));
    Util.flowCancel(u74, p72, { v79 });
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Brightness = 1;
    ColorCorrectionEffect.Saturation = 0.05;
    ColorCorrectionEffect.Parent = Lighting;
    u74:Add(ColorCorrectionEffect);
    u74:Add(function() -- Line: 1392
        -- upvalues: Atmosphere (copy), Color (ref), Density (ref), mainreplication (ref)
        Atmosphere.Color = Color;
        Atmosphere.Density = Density;
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash();
        mainreplication.fov(false, 15);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.133, Enum.EasingStyle.Linear), {
        Brightness = 0,
        Contrast = 0.1,
        Saturation = -0.7,
        TintColor = Color3.fromRGB(205, 255, 247)
    }):Play();

    if not v80 then
        u74:Add(task.delay(0.55, function() -- Line: 1413
            -- upvalues: u74 (copy), TekrinnDialogue (ref), u71 (copy)
            u74:Add(TekrinnDialogue.Speak(u71, {
                {
                    Text = "I feel like It\'s about to explode!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 3));
        end));
    end;

    if v80 then
        u74:Add(task.delay(0.24, function() -- Line: 1441
            -- upvalues: u74 (copy), TekrinnDialogue (ref), u71 (copy)
            u74:Add(TekrinnDialogue.Speak(u71, {
                {
                    Text = "That\'s what i call... ",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 1.5));
        end));
    end;

    if v80 then
        u74:Add(task.delay(1.65, function() -- Line: 1459
            -- upvalues: u74 (copy), TekrinnDialogue (ref), u71 (copy)
            u74:Add(TekrinnDialogue.Speak(u71, {
                {
                    Text = "MY EXPLOSION!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 3));
        end));
    end;

    if v80 then
        u74:Add(task.delay(5.36, function() -- Line: 1478
            -- upvalues: u74 (copy), TekrinnDialogue (ref), u71 (copy)
            u74:Add(TekrinnDialogue.Speak(u71, {
                {
                    Text = "Heheh.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 1));
        end));
    end;

    if v80 then
        u74:Add(task.delay(7.55, function() -- Line: 1497
            -- upvalues: u74 (copy), TekrinnDialogue (ref), u71 (copy)
            u74:Add(TekrinnDialogue.Speak(u71, {
                {
                    Text = "My Ball.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1.5
                    }
                }
            }, 1.5));
        end));
    end;

    if not v80 then
        u74:Add(task.delay(2.683, function() -- Line: 1525
            -- upvalues: u74 (copy), TekrinnDialogue (ref), u71 (copy)
            u74:Add(TekrinnDialogue.Speak(u71, {
                {
                    Text = "Heheh.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 1));
        end));
    end;

    if not v80 then
        u74:Add(task.delay(7.55, function() -- Line: 1553
            -- upvalues: u74 (copy), TekrinnDialogue (ref), u71 (copy)
            u74:Add(TekrinnDialogue.Speak(u71, {
                {
                    Text = "My Ball.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 35, 105)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 1.5
                    }
                }
            }, 1.5));
        end));
    end;

    u74:Add(task.spawn(function() -- Line: 1581
        -- upvalues: TweenService (ref), Atmosphere (copy), u76 (copy), u74 (copy)
        TweenService:Create(Atmosphere, TweenInfo.new(1.283, Enum.EasingStyle.Linear), {
            Color = Color3.fromRGB(255, 91, 91)
        }):Play();
        local v81 = TweenService:Create(u76, TweenInfo.new(2.617, Enum.EasingStyle.Linear), {
            Size = 0
        });
        v81:Play();
        u74:Connect(v81.Completed, function() -- Line: 1588
            -- upvalues: u76 (ref), TweenService (ref), u74 (ref)
            u76.Size = 12;
            local v82 = TweenService:Create(u76, TweenInfo.new(1.717, Enum.EasingStyle.Linear), {
                Size = 1
            });
            v82:Play();
            u74:Connect(v82.Completed, function() -- Line: 1592
                -- upvalues: TweenService (ref), u76 (ref), u74 (ref)
                local v83 = TweenService:Create(u76, TweenInfo.new(0.033, Enum.EasingStyle.Linear), {
                    Size = 22
                });
                v83:Play();
                u74:Connect(v83.Completed, function() -- Line: 1595
                    -- upvalues: TweenService (ref), u76 (ref)
                    TweenService:Create(u76, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                        Size = 0
                    }):Play();
                end);
            end);
        end);
    end));
    u74:Add(task.delay(4.35, function() -- Line: 1602
        -- upvalues: TweenService (ref), Atmosphere (copy)
        TweenService:Create(Atmosphere, TweenInfo.new(0.033, Enum.EasingStyle.Linear), {
            Density = 1
        }):Play();
    end));
    u74:Add(task.delay(5.833, function() -- Line: 1606
        -- upvalues: Atmosphere (copy), Density (ref), Lighting (ref), Brightness (ref)
        Atmosphere.Color = Color3.fromRGB(255, 255, 255);
        Atmosphere.Density = Density;
        Lighting.Brightness = Brightness;
    end));
    u74:Add(task.delay(2.317, function() -- Line: 1613
        -- upvalues: u75 (copy), ColorCorrectionEffect (copy), TweenService (ref), u74 (copy)
        u75.fall:Destroy();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(205, 255, 247);
        ColorCorrectionEffect.Brightness = -0.2;
        ColorCorrectionEffect.Saturation = 0.05;
        local v84 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.283, Enum.EasingStyle.Linear), {
            Brightness = -0.1,
            Contrast = 0.1,
            Saturation = -0.7,
            TintColor = Color3.fromRGB(205, 255, 247)
        });
        v84:Play();
        u74:Connect(v84.Completed, function() -- Line: 1626
            -- upvalues: ColorCorrectionEffect (ref), TweenService (ref), u74 (ref)
            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 218, 245);
            ColorCorrectionEffect.Brightness = 0.3;
            ColorCorrectionEffect.Saturation = -0.3;
            local v85 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Brightness = 0,
                Contrast = 0.1,
                Saturation = -0.7,
                TintColor = Color3.fromRGB(236, 231, 246)
            });
            v85:Play();
            u74:Connect(v85.Completed, function() -- Line: 1637
                -- upvalues: TweenService (ref), ColorCorrectionEffect (ref), u74 (ref)
                local v86 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.666, Enum.EasingStyle.Linear), {
                    Brightness = 0,
                    Contrast = 0.1,
                    Saturation = -0.7,
                    TintColor = Color3.fromRGB(205, 255, 247)
                });
                v86:Play();
                u74:Connect(v86.Completed, function() -- Line: 1644
                    -- upvalues: TweenService (ref), ColorCorrectionEffect (ref), u74 (ref)
                    local v87 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.734, Enum.EasingStyle.Linear), {
                        Brightness = -0.1,
                        Contrast = 0.1,
                        Saturation = -0.7,
                        TintColor = Color3.fromRGB(205, 255, 247)
                    });
                    v87:Play();
                    u74:Connect(v87.Completed, function() -- Line: 1651
                        -- upvalues: ColorCorrectionEffect (ref), TweenService (ref)
                        ColorCorrectionEffect.Brightness = 0.6;
                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.734, Enum.EasingStyle.Linear), {
                            Brightness = 0,
                            Contrast = 0.1,
                            Saturation = 0.05,
                            TintColor = Color3.fromRGB(255, 255, 255)
                        }):Play();
                    end);
                end);
            end);
        end);
    end));
    u74:Add(task.delay(2.5, function() -- Line: 1666
        -- upvalues: TweenService (ref), u77 (copy), u74 (copy)
        local v88 = TweenService:Create(u77.ImageLabel2, TweenInfo.new(1.85, Enum.EasingStyle.Linear), {
            ImageTransparency = 0
        });
        v88:Play();
        u74:Connect(v88.Completed, function() -- Line: 1673
            -- upvalues: u77 (ref)
            u77.ImageLabel2.ImageTransparency = 1;
        end);
    end));
    u74:Add(task.delay(2.617, function() -- Line: 1678
        -- upvalues: u75 (copy)
        for _, descendant in ipairs(u75.hu:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u75.eye:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u75.to:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u74:Add(task.delay(4.35, function() -- Line: 1699
        -- upvalues: u75 (copy)
        for _, descendant in ipairs(u75.Step:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
end;

return v28;