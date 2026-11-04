 
 

local Lighting = game:GetService("Lighting");
game:GetService("RunService");
game:GetService("TweenService");
require("@game/ReplicatedStorage/util/animationUtil");
local u1 = require("@game/ReplicatedStorage/client/replication/mainreplication");
local u2 = require("@game/ReplicatedStorage/util/MoonPropertyAnimator");
require("@game/ReplicatedStorage/util/Util");
local u3 = require("@game/ReplicatedStorage/util/vfxUtil");
local u4 = require("@game/ReplicatedStorage/util/soundUtil");
local u5 = require("@game/ReplicatedStorage/client/replication/TekrinnDialogue");
local akashi = u3.getResources().akashi;

return {
    thegameisalreadyover = function(u6: any, p7: number, p8: any) -- Line: 22, Name: thegameisalreadyover
        -- upvalues: u3 (copy), akashi (copy), u1 (copy), Lighting (copy), u2 (copy), u5 (copy), u4 (copy)
        local Root = u3.getRoot(u6);

        if not Root then
            return;
        end;

        local Ball = akashi.Flow.Ball;
        local v9 = p8[1];
        local u10 = u3.character_trove(u6);
        u3.buildFromRig(u6, Ball.akashi, u10);
        u1.sceneEnabled(true);
        u10:Add(function() -- Line: 34
            -- upvalues: u1 (ref), u3 (ref)
            u1.sceneEnabled(false);
            u3.cutscene_ball(false);
        end);
        u3.cutscene_invisiball(u6, u10);
        u3.cutscene_ball(true);
        local v11 = u10:Clone(Ball.VFX);
        v11:PivotTo(Root.CFrame);
        v11.Parent = workspace.Effects;
        local v12 = u10:Add(u3.highlight(v9, {
            Name = "Highlight",
            Enabled = false,
            FillTransparency = -1,
            OutlineTransparency = 1,
            DepthMode = Enum.HighlightDepthMode.Occluded,
            FillColor = Color3.new(1, 0, 0.0588235296),
            OutlineColor = Color3.new(0.384313762, 1, 0.137254909)
        }));
        local _, v13 = u1.cutsceneBlender(Root, Ball.Animations.Camera, Ball.FOV_OBA, nil, nil, nil, Ball.Cam);
        u10:Add(v13);
        local v14 = {
            Workspace = v11,
            Lighting = Lighting,
            Highlight = v12
        };
        u3.cutscene_lighting(u10, v14, Ball.Lighting, {
            ShadowSoftness = 0,
            ClockTime = 14.5,
            GeographicLatitude = 25.579,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(70, 70, 70)
        });
        local v15 = u10:Construct(u2);
        v15:LoadAndConvertSave(Ball.Moon, v14);
        v15:SetOriginalRoot(Ball.VFX:GetPivot());
        v15:SetRoot(Root);
        v15:PlayAll();
        u3.execute_compiled(Ball.Compiled, u10, v11, u6);
        u10:Add(task.delay(2.8666666666666667, function() -- Line: 89
            -- upvalues: u10 (copy), u5 (ref), u6 (copy)
            u10:Add(u5.Speak(u6, {
                {
                    Text = "This game is already over...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            }, 3));
        end));
        u10:Add(task.delay(8.633333333333333, function() -- Line: 115
            -- upvalues: u10 (copy), u5 (ref), u6 (copy)
            u10:Add(u5.Speak(u6, {
                {
                    Text = "You will not be able to touch the ball again...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1
                    }
                }
            }, 5));
        end));
        u10:Add(task.delay(11.883333333333333, function() -- Line: 141
            -- upvalues: u10 (copy), u5 (ref), u6 (copy)
            u10:Add(u5.Speak(u6, {
                {
                    Text = "MOVE.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 14)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1
                    }
                }
            }, 5));
        end));
        u10:Add(task.delay(16.183333333333334, function() -- Line: 167
            -- upvalues: u10 (copy), u5 (ref), u6 (copy)
            u10:Add(u5.Speak(u6, {
                {
                    Text = "My orders are absolute.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 14)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1
                    }
                }
            }, 5));
        end));
        u10:Add(u4:play(Ball.SFX, "default"));
        u10:Add(task.delay(p7, u10.Destroy, u10));
    end,

    dudeits3amandthisvfxarehelltoimport = function(u16: any, p17: number, p18: any) -- Line: 197, Name: dudeits3amandthisvfxarehelltoimport
        -- upvalues: u3 (copy), akashi (copy), u1 (copy), Lighting (copy), u2 (copy), u4 (copy)
        local Root = u3.getRoot(u16);

        if not Root then
            return;
        end;

        local Steal = akashi.Flow.Steal;
        local u19 = p18[1];
        local u20 = u3.character_trove(u16);
        u3.buildFromRig(u16, Steal.akashi, u20);
        u1.sceneEnabled(true);
        u20:Add(function() -- Line: 209
            -- upvalues: u1 (ref), u3 (ref)
            u1.sceneEnabled(false);
            u3.cutscene_ball(false);
        end);
        u3.cutscene_invisiball(u16, u20);
        u3.cutscene_ball(true);
        local u21 = u20:Clone(Steal.VFX);
        u21:PivotTo(Root.CFrame);
        u21.Parent = workspace.Effects;
        local u22, v23 = u1.cutsceneBlender(Root, Steal.Animations.Camera, Steal.FOV_SFA, nil, nil, nil, Steal.Cam);
        u20:Add(v23);
        u20:Add(task.spawn(function() -- Line: 233
            -- upvalues: u21 (copy), u16 (copy), u19 (copy), u20 (copy), u22 (copy)
            u21.Grab.Grab.Part0 = u16["Right Arm"];
            u21.LightningEyes.Head.Part1 = u16.Head;
            u21.Sweat.HeadV.Part1 = u19.Head;

            for _, child in u21:GetChildren() do
                if child:IsA("Attachment") then
                    u20:Add(child).Parent = u19.Head;
                end;
            end;

            if u22 then
                u21.Speedlines.Speedlines.Part0 = u22.CamPart;
            end;
        end));
        local v24 = {
            CutsceneVFX = u21,
            cam = u22,
            Lighting = Lighting,
            Vignette = u20:Add(u3.getMoonEffects()).Vignette
        };
        u3.cutscene_lighting(u20, v24, Steal.Lighting, {
            ShadowSoftness = 0,
            ClockTime = 2.777,
            GeographicLatitude = -1.273,
            ExposureCompensation = 0,
            Ambient = Color3.fromRGB(70, 70, 70),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        });
        local v25 = u20:Construct(u2);
        v25:LoadAndConvertSave(Steal.Moon, v24);
        v25:SetOriginalRoot(Steal.VFX:GetPivot());
        v25:SetRoot(Root);
        v25:PlayAll();
        u3.execute_compiled(Steal.Compiled, u20, u21, u16, u19, u22);
        u20:Add(u4:play(Steal.SFX, "default"));
        u20:Add(task.delay(p17, u20.Destroy, u20));
    end
};