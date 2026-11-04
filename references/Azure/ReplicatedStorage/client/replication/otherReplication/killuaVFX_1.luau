 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local Killua = ReplicatedStorage.Resources.Killua;
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local trove = require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.util.raycast);
local BackgroundHighlight = require(ReplicatedStorage.client.replication.BackgroundHighlight);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);

return {
    KilluaTSpecial = function(p1: userdata, p2, p3) -- Line: 20, Name: KilluaTSpecial
        -- upvalues: mainreplication (copy), Killua (copy), LocalPlayer (copy), Players (copy), TekrinnDialogue (copy)
        mainreplication.EmitAttachmentIn({
            Effect = Killua.TSpecial.Effect,
            Offset = p2 * Killua.TSpecial.Effect.CFrame,
            Parent = workspace.Terrain
        });
        mainreplication.EmitAttachmentIn({
            Effect = Killua.TSpecial.Effect,
            Offset = p3 * Killua.TSpecial.Effect.CFrame,
            Parent = workspace.Terrain
        });
        mainreplication.highlight(p1, Color3.fromRGB(139, 218, 255), 0.2666666666666667);

        if LocalPlayer == Players:GetPlayerFromCharacter(p1) then
            mainreplication.cameraShake(11, 1, 7);
            mainreplication.bright(0.15, 1.5, Color3.fromRGB(185, 246, 255));
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;

        TekrinnDialogue.Speak(p1, {
            {
                Text = "Lightning Flash",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(164, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 2);
    end,

    KilluaFlow = function(u4: userdata) -- Line: 69, Name: KilluaFlow
        -- upvalues: Killua (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy)
        local HumanoidRootPart = u4.HumanoidRootPart;
        local Flow = Killua.Flow;
        local u5 = trove.new();

        local function syncedDelay(p6: number, p7: function, ...) -- Line: 74
            -- upvalues: u5 (copy)
            return u5:Add(task.delay(math.max(0, p6 / 60), p7, ...));
        end;

        mainreplication.sceneEnabled(true);
        soundUtil:play(Flow.newvoice, SoundService);
        local v8, v9 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, Flow.Camera, nil, u4, CFrame.new(0, -3, 0));

        if v8 and v9 then
            u5:Add(v9);
            local v10 = u5:Clone(Flow.Cam);

            for _, child in v10:GetChildren() do
                child.Parent = v8.camera;
            end;

            v10:Destroy();
        end;

        local u11 = u5:Clone(Flow.domain);
        u11.Join.Part0 = HumanoidRootPart;
        TekrinnDialogue.Speak(u4, {
            {
                Text = "I\'ll play tag with you.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(164, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.3,
                    Lifetime = 2
                }
            }
        }, 3);
        syncedDelay(180, function() -- Line: 121
            -- upvalues: TekrinnDialogue (ref), u4 (copy)
            TekrinnDialogue.Speak(u4, {
                {
                    Text = "GOD SPEED",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(164, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        syncedDelay(209, function() -- Line: 147
            -- upvalues: mainreplication (ref), Flow (copy), u4 (copy), u11 (copy)
            mainreplication.EmitAttachmentIn({
                Effect = Flow.Effect,
                Parent = u4.Head
            });
            u11:Destroy();
        end);
        syncedDelay(260, function() -- Line: 156
            -- upvalues: mainreplication (ref), Flow (copy), HumanoidRootPart (copy)
            mainreplication.newblackscene(0.75, 1, 3);
            mainreplication.EmitAttachmentIn({
                Effect = Flow.Explode,
                Parent = HumanoidRootPart
            });
        end);
        syncedDelay(250, u5.Destroy, u5);
        u5:Add(function() -- Line: 167
            -- upvalues: mainreplication (ref)
            mainreplication.ultFlash(2, 0.75);
            mainreplication.sceneEnabled(false);
        end);
    end,

    SpeedOfLightningOffTheBall = function(p12: userdata) -- Line: 173, Name: SpeedOfLightningOffTheBall
        -- upvalues: Killua (copy), trove (copy), mainreplication (copy), ReplicatedStorage (copy), BackgroundHighlight (copy), LocalPlayer (copy), Players (copy)
        local v13 = Killua["Speed Of Lighting"]["Off the ball"];
        local u14 = trove.new();
        local HumanoidRootPart = p12.HumanoidRootPart;
        mainreplication.Emit(HumanoidRootPart, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));

        if p12:GetAttribute("RinNoPlay") then
            mainreplication.bodyVelocity(HumanoidRootPart, 200, 1.5, nil, nil, nil, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0), 1.35);
        else
            mainreplication.bodyVelocity(HumanoidRootPart, 130, 1.5, nil, nil, nil, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0), 1.35);
        end;

        mainreplication.highlight(p12, Color3.fromRGB(79, 102, 255), 0.2666666666666667);
        BackgroundHighlight({
            ImageTransparency = 0.7,
            Speed = 0.3,
            CFrames = true,
            Brightness = 1,
            countSpeed = 0.03,
            Count = 30,
            Whitelist = { p12 },
            Color = Color3.fromRGB(1000, 1000, 1000),
            Color2 = Color3.fromRGB(79, 126, 255)
        });
        mainreplication.rockFlakes(HumanoidRootPart, 2);

        for _, v in { "Right", "Left" } do
            local v15 = u14:Clone(v13.trail);
            v15.Weld.Part0 = p12:FindFirstChild((`{v} Arm`));
            v15.Parent = p12;
            u14:Add(task.delay(1, v15.Destroy, v15));
        end;

        if LocalPlayer == Players:GetPlayerFromCharacter(p12) then
            mainreplication.cameraShake(11, 1, 7);
            mainreplication.bright(0.15, 1.5, Color3.fromRGB(111, 106, 255));
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end;

        task.delay(2, function() -- Line: 238
            -- upvalues: u14 (copy)
            u14:Destroy();
        end);
    end,

    KilluaElectricSurge = function(u16, p17: userdata) -- Line: 243, Name: KilluaElectricSurge
        -- upvalues: Killua (copy), trove (copy), mainreplication (copy)
        if not p17 then
            return;
        end;

        local u18 = Killua["Electical Surge"];
        local u19 = trove.new();
        p17.Destroying:Once(function() -- Line: 251
            -- upvalues: u19 (copy), mainreplication (ref), u16 (copy), u18 (copy)
            u19:Destroy();
            mainreplication.EmitAttachmentIn({
                Offset = u16,
                Effect = u18.Emit,
                Parent = workspace.Terrain
            });
        end);
        mainreplication.EmitAttachmentIn({
            Offset = u16,
            Effect = u18.Emit,
            Parent = workspace.Terrain
        });
        local v20 = u19:Clone(u18.Enable);
        v20.CFrame = u16 * CFrame.new(0, -3, 0);
        v20.sfx:Play();
        v20.Parent = workspace.Effects;
        mainreplication.BetterEnable(v20, true);
    end,

    TekrinnDialogue = function(...) -- Line: 275, Name: TekrinnDialogue
        -- upvalues: TekrinnDialogue (copy)
        return TekrinnDialogue.Speak(...);
    end
};