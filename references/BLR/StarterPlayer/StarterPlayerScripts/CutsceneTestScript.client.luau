  

if not game:GetService("RunService"):IsStudio() or game.PlaceId ~= 88233429548268 then
    return;
end;

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Debris = game:GetService("Debris");
local Knit = require(ReplicatedStorage.Packages.Knit);

if not Knit.OnStart():await() then
    return;
end;

local LocalPlayer = Players.LocalPlayer;
local DebugUtil = require(ReplicatedStorage.Shared.DebugUtil);
local MoonCutsceneStreamer = require(ReplicatedStorage.Shared.MoonCutsceneStreamer);
local Service = Knit.GetService("AwakeningService");
local Controller = Knit.GetController("CameraController");
local AikuSelfishCaptain = require(ReplicatedStorage.Effects.Aiku.AikuSelfishCaptain);
local u1 = DebugUtil.createGroup("Selfish Captain Preview");
local u2 = false;

local function status(p3) -- Line: 22
    -- upvalues: u1 (copy)
    u1.setLabel("status", p3);
    script:SetAttribute("PreviewStatus", p3);
end;

local function readyCharacter() -- Line: 27
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Controller (copy)
    local Character = LocalPlayer.Character;
    local v4;

    if Character then
        v4 = Character:FindFirstChild("HumanoidRootPart");
    else
        v4 = Character;
    end;

    local v5;

    if Character then
        v5 = Character:FindFirstChildOfClass("Humanoid");
    else
        v5 = Character;
    end;

    local v6;

    if Character then
        v6 = Character:FindFirstChild("Values");
    else
        v6 = Character;
    end;

    if not (v4 and (v5 and (v5.Health > 0 and (v6 and (v6:FindFirstChild("InCutscene") and (v6:FindFirstChild("Goalie") and (v6:FindFirstChild("HasBall") and (LocalPlayer.PlayerGui:FindFirstChild("InGameUI") and ReplicatedStorage.Football.Value)))))))) then
        return nil, "Wait for your character and the field to load.";
    end;

    if v4.Anchored or (v6.InCutscene.Value or (Controller.Cutscene or LocalPlayer:GetAttribute("MVPPreviewActive"))) then
        return nil, "Wait for the current cutscene to finish.";
    end;

    return Character;
end;

local function preview() -- Line: 45
    -- upvalues: u2 (ref), readyCharacter (copy), u1 (copy), Service (copy), MoonCutsceneStreamer (copy), LocalPlayer (copy), Debris (copy), AikuSelfishCaptain (copy)
    if u2 then
        return;
    end;

    local u7, v8 = readyCharacter();

    if not u7 then
        u1.setLabel("status", v8);
        script:SetAttribute("PreviewStatus", v8);

        return;
    end;

    u2 = true;
    local u9 = nil;
    local v15, v16 = xpcall(function() -- Line: 51
        -- upvalues: u1 (ref), Service (ref), MoonCutsceneStreamer (ref), readyCharacter (ref), u7 (copy), u9 (ref), LocalPlayer (ref), Debris (ref), AikuSelfishCaptain (ref)
        u1.setLabel("status", "Loading Selfish Captain...");
        script:SetAttribute("PreviewStatus", "Loading Selfish Captain...");
        local v10 = Service:RequestTemporaryCutscene("AikuSelfishCaptain") == true;
        assert(v10, "Could not request the cutscene.");
        local CutsceneData, v11 = MoonCutsceneStreamer.getCutsceneData("AikuSelfishCaptain");
        assert(CutsceneData and v11, "Cutscene streaming timed out. Press L to retry.");
        local v12, v13 = readyCharacter();
        assert(v12 == u7, v13 or "Your character changed. Press L to retry.");
        u9 = Instance.new("Model");
        u9.Name = LocalPlayer.Name;
        local Part = Instance.new("Part");
        Part.Name = "HumanoidRootPart";
        Part.Size = Vector3.new(1, 1, 1);
        Part.Transparency = 1;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CFrame = u7.HumanoidRootPart.CFrame;
        Part.Parent = u9;
        u9.Parent = workspace;
        Debris:AddItem(u9, 30);
        u1.setLabel("status", "Playing Selfish Captain...");
        script:SetAttribute("PreviewStatus", "Playing Selfish Captain...");
        local os_clock_ret = os.clock();
        AikuSelfishCaptain({
            StudioPreview = true,
            Char = u7,
            TeammateChar = u9
        });
        local v14 = os.clock() - os_clock_ret >= 13;
        assert(v14, "The preview did not finish; check Studio Output.");
    end, debug.traceback);

    if u9 then
        u9:Destroy();
    end;

    u2 = false;

    if v15 then
        script:SetAttribute("CompletedPreviews", (script:GetAttribute("CompletedPreviews") or 0) + 1);
        u1.setLabel("status", "Press L to replay Selfish Captain.");
        script:SetAttribute("PreviewStatus", "Press L to replay Selfish Captain.");
    else
        u1.setLabel("status", "Preview unavailable - check Output, then press L to retry.");
        script:SetAttribute("PreviewStatus", "Preview unavailable - check Output, then press L to retry.");
        warn("[Selfish Captain Preview] " .. tostring(v16));
    end;
end;

u1.addButton("play", "Play Selfish Captain [L]", preview);
u1.setLabel("status", "Press L to preview Selfish Captain. No pass or awakening needed.");
script:SetAttribute("PreviewStatus", "Press L to preview Selfish Captain. No pass or awakening needed.");
UserInputService.InputBegan:Connect(function(p17, p18) -- Line: 94
    -- upvalues: UserInputService (copy), preview (copy)
    if not (p18 or (UserInputService:GetFocusedTextBox() or p17.KeyCode ~= Enum.KeyCode.L)) then
        task.spawn(preview);
    end;
end);