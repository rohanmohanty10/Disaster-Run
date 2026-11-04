  

local Lighting = game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local ContentProvider = game:GetService("ContentProvider");
require(ReplicatedStorage.Shared.LightingStorage);
local MoonCutsceneStreamer = require(ReplicatedStorage.Shared.MoonCutsceneStreamer);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage.Shared.SoundManager);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local TekrinnDialogue = require(ReplicatedStorage.Modules.TekrinnDialogue);
require(ReplicatedStorage.Shared.MVPCutscenes);
local LocalPlayer = Players.LocalPlayer;

local function timestampToCutsceneSeconds(p1) -- Line: 21
    local v2, v3 = tostring(p1):match("^(%d+):(%d+)$");

    return not (v2 and v3) and (tonumber(p1) or 0) or tonumber(v2) + tonumber(v3) / 1000;
end;

local function normalizeDialogueSpeaker(p4) -- Line: 30
    return typeof(p4) == "string" and {
        Name = p4
    } or (p4 or {
        Name = "Narrator"
    });
end;

local function normalizeDialogueData(p5) -- Line: 46
    if p5.Dialogue ~= nil then
        return p5.Dialogue;
    end;

    if p5.Text == nil then
        return nil;
    end;

    local Color = p5.Color;

    if typeof(Color) == "Color3" then
        Color = ColorSequence.new(Color);
    end;

    return {
        {
            Text = p5.Text,
            Color = Color or ColorSequence.new(Color3.new(1, 1, 1)),
            TextStrokeColor = p5.TextStrokeColor or Color3.new(0, 0, 0),
            Bold = p5.Bold or false,
            Italic = p5.Italic or false,
            Shake = p5.Shake or {
                Enabled = false,
                Intensity = 1,
                Lifetime = 0.5
            },
            TypeSpeed = p5.TypeSpeed or 0.03
        }
    };
end;

local function normalizeCutsceneSubtitles(p6) -- Line: 77
    -- upvalues: normalizeDialogueData (copy)
    if typeof(p6) == "Instance" then
        if not p6:IsA("ModuleScript") then
            return nil;
        end;

        p6 = require(p6);
    end;

    if typeof(p6) ~= "table" then
        return nil;
    end;

    local v7 = 0;
    local v8 = {};

    for i, v in p6 do
        if typeof(v) == "table" then
            local v9 = normalizeDialogueData(v);

            if v9 ~= nil then
                local v10;

                if typeof(i) == "string" then
                    v10 = i;
                else
                    v10 = nil;
                end;

                v7 = v7 + 1;
                local v11 = {
                    Duration = v.Duration or 3,
                    Dialogue = v9,
                    Order = v7
                };
                local v12 = v.Speaker or v.SpeakerName;
                v11.Speaker = typeof(v12) == "string" and {
                    Name = v12
                } or (v12 or {
                    Name = "Narrator"
                });
                local v13 = v.Timestamp or (v.Time or (v10 or 0));
                local v14, v15 = tostring(v13):match("^(%d+):(%d+)$");
                local v16;

                if v14 and v15 then
                    v16 = tonumber(v14) + tonumber(v15) / 1000;
                else
                    v16 = tonumber(v13) or 0;
                end;

                v11.TimePosition = v16;
                table.insert(v8, v11);
            end;
        end;
    end;

    table.sort(v8, function(p17, p18) -- Line: 114
        if p17.TimePosition == p18.TimePosition then
            return p17.Order < p18.Order;
        end;

        return p17.TimePosition < p18.TimePosition;
    end);

    return v8;
end;

local function normalizeCutsceneSoundCues(p19) -- Line: 127
    if typeof(p19) == "Instance" then
        if not p19:IsA("ModuleScript") then
            return nil;
        end;

        p19 = require(p19);
    end;

    if typeof(p19) ~= "table" then
        return nil;
    end;

    local v20 = 0;
    local v21 = {};

    for i, v in p19 do
        if typeof(v) == "table" then
            v20 = v20 + 1;
            local v22;

            if typeof(i) == "string" then
                v22 = i;
            else
                v22 = nil;
            end;

            local v23 = v.Sound or (v.SoundName or v.Name);
            local TimePosition = v.TimePosition;
            local v24 = {
                Action = v.Action or "PlayOnce",
                CatchUp = v.CatchUp ~= false,
                Distance = v.Distance,
                DropIfLateOver = v.DropIfLateOver,
                FadeTime = v.FadeTime,
                Frame = v.Frame,
                Id = v.Id or (v.CueId or (v23 or tostring(v20))),
                Looped = v.Looped,
                Marker = v.Marker,
                MaxTailSeconds = v.MaxTailSeconds,
                Order = v20,
                Parent = v.Parent,
                Path = v.Path or v.SoundPath,
                PlaybackPosition = v.PlaybackPosition or (v.StartTime or v.SetTime),
                Sound = v23,
                SoundInstance = v.SoundInstance,
                StopId = v.StopId
            };

            if TimePosition == nil then
                if v.Timestamp == nil and (v.Time == nil and v22 == nil) then
                    TimePosition = nil;
                else
                    local v25 = v.Timestamp or (v.Time or v22);
                    local v26, v27 = tostring(v25):match("^(%d+):(%d+)$");

                    if v26 and v27 then
                        TimePosition = tonumber(v26) + tonumber(v27) / 1000;
                    else
                        TimePosition = tonumber(v25) or 0;
                    end;
                end;
            end;

            v24.TimePosition = TimePosition;
            v24.UseVolumeMultiplier = v.UseVolumeMultiplier ~= false;
            v24.Volume = v.Volume;
            table.insert(v21, v24);
        end;
    end;

    return v21;
end;

local function findDescendantByPath(p28: userdata, p29: string) -- Line: 181
    for i in string.gmatch(p29, "[^%.]+") do
        p28 = p28:FindFirstChild(i);

        if p28 == nil then
            return nil;
        end;
    end;

    return p28;
end;

local function resolveSoundCueSource(p30: any, p31: userdata) -- Line: 193
    -- upvalues: findDescendantByPath (copy), ReplicatedStorage (copy)
    local SoundInstance = p30.SoundInstance;

    if typeof(SoundInstance) == "Instance" and SoundInstance:IsA("Sound") then
        return SoundInstance;
    end;

    if p30.Path then
        local v32 = findDescendantByPath(p31, p30.Path);

        if v32 and v32:IsA("Sound") then
            return v32;
        end;
    end;

    if p30.Sound then
        local v33 = ReplicatedStorage.Assets.Sfx:FindFirstChild(p30.Sound, true);

        if v33 and v33:IsA("Sound") then
            return v33;
        end;
    end;

    return nil;
end;

local function resolveAndPreloadSoundCues(p34: any, p35: userdata) -- Line: 216
    -- upvalues: resolveSoundCueSource (copy), ContentProvider (copy)
    if not p34 or #p34 == 0 then
        return;
    end;

    local v36 = {};
    local v37 = {};

    for _, v in p34 do
        local v38 = resolveSoundCueSource(v, p35);
        v.Source = v38;

        if v38 and not v36[v38] then
            v36[v38] = true;
            table.insert(v37, v38);
        elseif not v38 and v.Action ~= "Stop" then
            warn(("Cutscene sound %s could not be resolved"):format((tostring(v.Sound or (v.Path or v.Id)))));
        end;
    end;

    if #v37 > 0 then
        ContentProvider:PreloadAsync(v37);
    end;
end;

local function destroySoundAfterPlayback(u39: userdata, u40: any, u41: any) -- Line: 241
    if u39.Looped then
        return;
    end;

    local u42 = nil;
    u42 = u39.Ended:Connect(function() -- Line: 247
        -- upvalues: u42 (ref), u40 (copy), u41 (copy), u39 (copy)
        if u42 then
            u42:Disconnect();
        end;

        if u40[u41] == u39 then
            u40[u41] = nil;
        end;

        if u39.Parent then
            u39:Destroy();
        end;
    end);
end;

local function cleanupManagedSound(p43: userdata) -- Line: 262
    -- upvalues: Debris (copy)
    if not p43.Parent then
        return;
    end;

    local Attribute = p43:GetAttribute("CutsceneMaxTailSeconds");

    if typeof(Attribute) == "number" and (Attribute > 0 and (p43.IsPlaying and (not p43.Looped and p43.PlaybackSpeed > 0))) then
        local v44 = (p43.TimeLength - p43.TimePosition) / p43.PlaybackSpeed;

        if v44 > 0 and v44 <= math.min(Attribute, 5) then
            Debris:AddItem(p43, v44 + 0.5);

            return;
        end;
    end;

    p43:Stop();
    p43:Destroy();
end;

local function getSoundCueTriggerTime(p45, p46) -- Line: 284
    if p45.TimePosition == nil then
        return p45.Frame == nil and 0 or p45.Frame / p46.FrameRate;
    end;

    return p45.TimePosition;
end;

local function createSoundFromCue(p47) -- Line: 296
    local Source = p47.Source;

    if not Source then
        return nil;
    end;

    local v48 = Source:Clone();
    v48.RollOffMode = Enum.RollOffMode.Linear;

    if p47.Volume == nil then
        v48.Volume = Source.Volume;
    else
        local v49;

        if p47.UseVolumeMultiplier then
            v49 = p47.Volume * 2.35;
        else
            v49 = p47.Volume;
        end;

        v48.Volume = v49;
    end;

    if p47.Distance then
        v48.RollOffMinDistance = p47.Distance / 2.5;
        v48.RollOffMaxDistance = p47.Distance * 1.5;
    end;

    if p47.Looped ~= nil then
        v48.Looped = p47.Looped;
    end;

    v48:SetAttribute("CutsceneMaxTailSeconds", p47.MaxTailSeconds);
    v48.Parent = p47.Parent or workspace;

    return v48;
end;

local function stopManagedSound(p50, p51) -- Line: 325
    -- upvalues: TweenService (copy)
    local v52 = p50.StopId or p50.Id;
    local u53 = p51[v52];

    if not u53 then
        return;
    end;

    p51[v52] = nil;

    if p50.FadeTime and p50.FadeTime > 0 then
        TweenService:Create(u53, TweenInfo.new(p50.FadeTime), {
            Volume = 0
        }):Play();
        task.delay(p50.FadeTime, function() -- Line: 336
            -- upvalues: u53 (copy)
            if u53.Parent then
                u53:Stop();
                u53:Destroy();
            end;
        end);

        return;
    end;

    u53:Stop();
    u53:Destroy();
end;

local function triggerSoundCue(p54, p55, u56) -- Line: 349
    -- upvalues: stopManagedSound (copy), createSoundFromCue (copy)
    if p54.Action == "Stop" then
        stopManagedSound(p54, u56);

        return;
    end;

    local u57 = createSoundFromCue(p54);

    if not u57 then
        return;
    end;

    local Id = p54.Id;
    local v58 = p54.PlaybackPosition or 0;

    if p54.CatchUp then
        local math_max_ret = math.max(0, p55.TimePosition - p54.TriggerTimePosition);

        if p54.DropIfLateOver and p54.DropIfLateOver < math_max_ret then
            u57:Destroy();

            return;
        end;

        v58 = v58 + math_max_ret;
    end;

    if v58 > 0 then
        local TimeLength = u57.TimeLength;

        if TimeLength > 0 then
            if u57.Looped then
                v58 = v58 % TimeLength;
            elseif TimeLength <= v58 then
                u57:Destroy();

                return;
            end;
        end;

        u57.TimePosition = v58;
    end;

    u57:Play();
    u56[Id] = u57;

    if u57.Looped then
        return;
    end;

    local u59 = nil;
    u59 = u57.Ended:Connect(function() -- Line: 247
        -- upvalues: u59 (ref), u56 (copy), Id (copy), u57 (copy)
        if u59 then
            u59:Disconnect();
        end;

        if u56[Id] == u57 then
            u56[Id] = nil;
        end;

        if u57.Parent then
            u57:Destroy();
        end;
    end);
end;

local function resolveCutsceneConfig(p60, p61, p62, p63, p64, p65, p66) -- Line: 406
    if typeof(p60) ~= "Instance" then
        return p60;
    end;

    local v67;

    if typeof(p64) == "table" and p65 == nil then
        v67 = nil;
    else
        v67 = p64;
        p64 = p65;
    end;

    return {
        Character = p60,
        CharsToReplace = p61,
        MoonFileName = p62,
        CodeEvents = p63,
        Length = v67,
        Subtitles = p64,
        SoundCues = p66
    };
end;

local u68 = {};

function u68.PlayCutscene(...) -- Line: 430
    -- upvalues: resolveCutsceneConfig (copy), normalizeCutsceneSubtitles (copy), normalizeCutsceneSoundCues (copy), MoonCutsceneStreamer (copy), resolveAndPreloadSoundCues (copy), Players (copy), SpectatorController (copy), Knit (copy), Moonlite (copy), u68 (copy), RunService (copy), LocalPlayer (copy), TweenService (copy), triggerSoundCue (copy), cleanupManagedSound (copy), TekrinnDialogue (copy), ReplicatedStorage (copy)
    local v69 = resolveCutsceneConfig(...);
    local Character = v69.Character;
    local v70 = v69.CharsToReplace or {};
    local MoonFileName = v69.MoonFileName;
    local CodeEvents = v69.CodeEvents;
    local Length = v69.Length;
    local SoundCues = v69.SoundCues;
    local GoalFrame = v69.GoalFrame;
    local OriginCFrame = v69.OriginCFrame;
    local u71 = normalizeCutsceneSubtitles(v69.Subtitles);
    local v72 = normalizeCutsceneSoundCues(SoundCues);
    print("play cutscene: ", MoonFileName);
    local CutsceneData, v73 = MoonCutsceneStreamer.getCutsceneData(MoonFileName);

    if not (CutsceneData and v73) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local u74 = v73.VFX:Clone();
    resolveAndPreloadSoundCues(v72, u74);
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Humanoid = Character:FindFirstChild("Humanoid");

    if not Humanoid then
        return;
    end;

    local string_find_ret = string.find(MoonFileName, "MVP");
    local u75 = true;
    local LocalPlayer2 = Players.LocalPlayer;
    local v76 = LocalPlayer2 == PlayerFromCharacter and true or LocalPlayer2.Character == Character;
    local v77 = SpectatorController and SpectatorController.IsSpectating;
    local v78 = LocalPlayer2:GetAttribute("MVPPreviewActive") == true;

    if LocalPlayer2.Team == game.Teams.Visitor and not (v76 or (v77 or v78)) then
        u75 = false;
    end;

    local HUD = Players.LocalPlayer.PlayerGui:FindFirstChild("HUD");
    local v79;

    if HUD then
        v79 = HUD.Enabled;
    else
        v79 = HUD;
    end;

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    Character:SetAttribute("CutsceneChar", true);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local Controller = Knit.GetController("CameraController");

    if u75 then
        Players.LocalPlayer.Character.Values.InCutscene.Value = true;

        if Controller.BeginCutscene then
            Controller:BeginCutscene();
        else
            Controller.Cutscene = true;
        end;

        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;

        if string_find_ret and HUD then
            HUD.Enabled = false;
        end;
    end;

    HumanoidRootPart.Anchored = true;
    local u80 = true;
    task.spawn(function() -- Line: 512
        -- upvalues: u80 (ref), u75 (ref), Controller (copy), Players (ref), string_find_ret (copy), HUD (copy)
        while u80 do
            task.wait();

            if u75 then
                if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                end;

                Controller.Cutscene = true;
                Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;

                if string_find_ret and HUD then
                    HUD.Enabled = false;
                end;
            end;
        end;
    end);
    local Pivot = u74:GetPivot();
    local u81 = OriginCFrame or HumanoidRootPart:GetPivot();
    u74:PivotTo(u81);
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u74;
    local u82 = Moonlite.CreatePlayer(CutsceneData, u74);
    u82.Looped = false;
    local v83 = {};
    local u84 = {};
    local u85 = true;

    for _, child in u74:GetChildren() do
        if child:IsA("PostEffect") then
            table.insert(v83, child);
        end;
    end;

    if u82._moduleInfo then
        for i, v in u82._moduleInfo.Compiled do
            local v86 = v.Path or i;

            if v86.ItemType == "Lighting" then
                v.Override = game:GetService("Lighting");
            end;

            local v87 = v;

            for _, v2 in v83 do
                if v86.InstanceNames[2] == v2.Name then
                    local table_clone_ret = table.clone(v86);
                    table.remove(table_clone_ret.InstanceNames, 2);
                    table.remove(table_clone_ret.InstanceTypes, 2);
                    v87.Override = Moonlite.resolveAnimPath(table_clone_ret, v2);
                end;
            end;
        end;
    end;

    local function replaceChar(p88, p89) -- Line: 577
        -- upvalues: u74 (copy), u68 (ref), u84 (copy), Character (copy), u82 (copy), Moonlite (ref), u81 (copy), Pivot (copy)
        if not u74:FindFirstChild(p88) then
            warn("Could not find " .. p88 .. " in vfx model");

            return;
        end;

        local PlrFootball = p89:FindFirstChild("PlrFootball");
        print(PlrFootball);

        if PlrFootball then
            PlrFootball:Destroy();
        end;

        local Football = p89:FindFirstChild("Football");
        print(Football);

        if Football then
            Football:Destroy();
        end;

        u68.AmendWelds(u74, p89, p88);
        local v90 = u74[p88];

        for _, child in v90:GetChildren() do
            if child:IsA("Highlight") then
                local v91 = child:Clone();

                if v91.Adornee == v90 then
                    v91.Adornee = p89;
                else
                    local v92 = v91.Adornee and v91.Adornee:IsDescendantOf(v90) and p89:FindFirstChild(v91.Adornee.Name, true);

                    if v92 then
                        v91.Adornee = v92;
                    end;
                end;

                v91.Parent = p89;
                table.insert(u84, v91);
            end;
        end;

        for _, child in v90:GetChildren() do
            if child:GetAttribute("OtherRig") then
                child.Parent = Character;
            else
                local v93 = p89:FindFirstChild(child.Name);

                if v93 then
                    for _, child2 in child:GetChildren() do
                        child2.Parent = v93;
                        table.insert(u84, child2);
                    end;
                end;
            end;
        end;

        u74[p88]:Destroy();

        if u82._moduleInfo and p89 then
            for i, v in u82._moduleInfo.Compiled do
                local v94 = v.Path or i;

                if v94.InstanceNames[2] == p88 then
                    local table_clone_ret = table.clone(v94);
                    table.remove(table_clone_ret.InstanceNames, 2);
                    table.remove(table_clone_ret.InstanceTypes, 2);
                    v.Override = Moonlite.resolveAnimPath(table_clone_ret, p89);
                end;

                local CFrame3 = v.Props.CFrame;

                if CFrame3 and v94.ItemType ~= "Attachment" then
                    CFrame3.Default = u81:ToWorldSpace(Pivot:ToObjectSpace(CFrame3.Default));

                    for _, v2 in CFrame3.Sequence do
                        v2.Value = u81:ToWorldSpace(Pivot:ToObjectSpace(v2.Value));
                    end;
                end;
            end;
        end;
    end;

    local v95 = {};

    for i, v in v70 do
        if v and v:FindFirstChild("HumanoidRootPart") then
            v.Archivable = true;
            local v96 = v:Clone();
            v96.HumanoidRootPart.Anchored = true;
            v96:PivotTo(u74[i].HumanoidRootPart.CFrame);
            v96.Parent = workspace;

            for _, child in v96:GetChildren() do
                if child:IsA("Sound") and (PlayerFromCharacter and child.Name == PlayerFromCharacter.PlayerStats.Style.Value) then
                    child:Destroy();
                end;
            end;

            table.insert(v95, v96);
            replaceChar(i, v96);
        end;
    end;

    local v97 = {};

    for _, v in v70 do
        v97[v] = true;
    end;

    local v98 = u68.HideAllPlayers(string_find_ret, v97);

    for _, child in u74:GetChildren() do
        local v99;

        if child:IsA("LayerCollector") then
            v99 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 724
                        -- upvalues: child2 (copy), RunService (ref)
                        local v100 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v100);
                        child2.ImageTransparency = 0.999;
                        local v101 = RunService.PreRender:Connect(function() -- Line: 730
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v101:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v99.Parent = LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v99 = child;
        else
            v99 = child;
        end;

        table.insert(u84, v99);
    end;

    local u102 = nil;

    if u82._moduleInfo then
        for i, v in u82._moduleInfo.Compiled do
            local v103 = v.Path or i;

            if type(v103) == "table" and (v103.ItemType == "Camera" and v.Props.AttachToPart) then
                local AttachToPart = v.Props.AttachToPart;

                if AttachToPart.Sequence and #AttachToPart.Sequence > 0 then
                    local Value = AttachToPart.Sequence[1].Value;

                    if type(Value) == "table" and Value.InstanceNames then
                        u102 = Moonlite.resolveAnimPath(Value, u74);
                    end;
                end;

                v.Props.AttachToPart = nil;
            end;
        end;
    end;

    u82:Compile();
    local v104 = false;
    local v105 = nil;

    if u82._buffer then
        local v106 = u82._buffer[Camera];

        if v106 then
            for i, v in v106 do
                if v.FieldOfView ~= nil then
                    v104 = true;

                    if i == 0 then
                        v105 = v.FieldOfView;
                    end;
                end;
            end;
        end;
    end;

    if u75 and v105 ~= nil then
        Camera.FieldOfView = v105;
        workspace_CurrentCamera.FieldOfView = v105;
    end;

    u74.Parent = workspace;
    local Character2 = game.Players.LocalPlayer.Character;

    if u75 then
        if v104 then
            RunService:BindToRenderStep("CutsceneUtilsFOVSync", Enum.RenderPriority.Camera.Value + 2, function() -- Line: 812
                -- upvalues: Camera (copy)
                local workspace_CurrentCamera2 = workspace.CurrentCamera;

                if workspace_CurrentCamera2 then
                    workspace_CurrentCamera2.FieldOfView = Camera.FieldOfView;
                end;
            end);
        end;

        if u102 then
            local u107 = nil;
            local u108 = 0;
            RunService:BindToRenderStep("CutsceneUtilsCameraSync", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 824
                -- upvalues: u102 (ref), u107 (ref), u108 (ref)
                local CFrame3 = u102.CFrame;

                if u107 then
                    if u107.LookVector:Dot(CFrame3.LookVector) < 0 then
                        u108 = u108 + 1;

                        if u108 < 4 then
                            CFrame3 = CFrame.new(CFrame3.Position) * (u107 - u107.Position);
                        else
                            u108 = 0;
                        end;
                    else
                        u108 = 0;
                    end;
                end;

                u107 = CFrame3;
                workspace.CurrentCamera.CFrame = CFrame3;
            end);
            Camera.Changed:Connect(function(p109: string) -- Line: 847
                -- upvalues: Camera (copy)
                if p109 == "FieldOfView" then
                    workspace.CurrentCamera.FieldOfView = Camera.FieldOfView;
                end;
            end);
        else
            Camera.Changed:Connect(function(p110: string) -- Line: 853
                -- upvalues: Camera (copy)
                if p110 ~= "CFrame" and p110 ~= "FieldOfView" then
                    return;
                end;

                workspace.CurrentCamera[p110] = Camera[p110];
            end);
        end;
    end;

    local Volume = game.SoundService.SoundGroup.OST.Volume;
    game.SoundService.SoundGroup.OST.Volume = 0;
    task.spawn(function() -- Line: 865
        -- upvalues: Character (copy), PlayerFromCharacter (copy), TweenService (ref)
        for _, child in Character:GetChildren() do
            if child:IsA("Sound") and (PlayerFromCharacter and child.Name == PlayerFromCharacter.PlayerStats.Style.Value) then
                TweenService:Create(child, TweenInfo.new(0.5), {
                    Volume = 0
                }):Play();
                task.wait();
                child:Pause();
            end;
        end;
    end);
    u82:Play();
    local v111;

    if v72 and #v72 > 0 then
        local u112 = {};
        local u113 = {};
        local u114 = {};

        for _, v in v72 do
            local v115;

            if v.TimePosition == nil then
                v115 = v.Frame == nil and 0 or v.Frame / u82.FrameRate;
            else
                v115 = v.TimePosition;
            end;

            v.TriggerTimePosition = v115;

            if v.Marker then
                local MarkerReachedSignal = u82:GetMarkerReachedSignal(v.Marker);
                table.insert(u113, MarkerReachedSignal:Connect(function() -- Line: 890
                    -- upvalues: triggerSoundCue (ref), v (copy), u82 (copy), u114 (copy)
                    triggerSoundCue(v, u82, u114);
                end));
            else
                table.insert(u112, v);
            end;
        end;

        table.sort(u112, function(p116, p117) -- Line: 898
            if p116.TriggerTimePosition == p117.TriggerTimePosition then
                return p116.Order < p117.Order;
            end;

            return p116.TriggerTimePosition < p117.TriggerTimePosition;
        end);

        v111 = function() -- Line: 906
            -- upvalues: u113 (copy), u114 (copy), cleanupManagedSound (ref)
            for _, v in u113 do
                v:Disconnect();
            end;

            for i, v in u114 do
                u114[i] = nil;
                cleanupManagedSound(v);
            end;
        end;

        task.spawn(function() -- Line: 917
            -- upvalues: u85 (ref), u112 (copy), u82 (copy), RunService (ref), triggerSoundCue (ref), u114 (copy)
            local v118 = 1;

            while u85 and v118 <= #u112 do
                local v119 = u112[v118];

                if v119.Frame == nil then
                    while u85 and u82.TimePosition < v119.TriggerTimePosition do
                        RunService.Heartbeat:Wait();
                    end;
                else
                    while u85 and u82.CurrentFrame < v119.Frame do
                        RunService.Heartbeat:Wait();
                    end;
                end;

                if not u85 then
                    break;
                end;

                triggerSoundCue(v119, u82, u114);
                v118 = v118 + 1;
            end;
        end);
    else
        v111 = function() -- Line: 879
        end;
    end;

    if CodeEvents then
        require(CodeEvents)(u82);
    end;

    if u71 and #u71 > 0 then
        task.spawn(function() -- Line: 949
            -- upvalues: u85 (ref), u71 (copy), u82 (copy), RunService (ref), TekrinnDialogue (ref)
            local v120 = 1;

            while u85 and v120 <= #u71 do
                local v121 = u71[v120];

                while u85 and u82.TimePosition < v121.TimePosition do
                    RunService.Heartbeat:Wait();
                end;

                if not u85 then
                    break;
                end;

                TekrinnDialogue.Speak(v121.Speaker, v121.Dialogue, v121.Duration);
                v120 = v120 + 1;
            end;
        end);
    end;

    if GoalFrame then
        task.spawn(function() -- Line: 970
            -- upvalues: u85 (ref), u82 (copy), GoalFrame (copy), RunService (ref), u68 (ref), MoonFileName (copy)
            while u85 and u82.CurrentFrame < GoalFrame do
                RunService.Heartbeat:Wait();
            end;

            if u85 then
                u68.MVPGoal(MoonFileName);
            end;
        end);
    end;

    task.spawn(function() -- Line: 981
        -- upvalues: MoonFileName (copy), LocalPlayer (ref), u82 (copy), u68 (ref)
        local v122 = script.ImpactFrames:FindFirstChild(MoonFileName) and script.ImpactFrames:FindFirstChild(MoonFileName):Clone() or nil;
        local v123 = script.ImpactFramesPictures:FindFirstChild(MoonFileName);

        if not v122 then
            if v123 then
                u68.PrepFrames(MoonFileName);

                repeat
                    task.wait();
                until u82.TimePosition >= v123:GetAttribute("TimeStamp");

                local v124 = v123:GetAttribute("FPS") or 0.042;
                u68.ImpactFrames(MoonFileName, v124);
            end;

            return;
        end;

        local v125 = {};

        for _, descendant in v122:GetDescendants() do
            if descendant:IsA("VideoFrame") then
                table.insert(v125, descendant);
            end;
        end;

        if #v125 == 0 then
            warn("No Video Frame found");

            return;
        end;

        local Attribute = v122:GetAttribute("TimeStamp");

        for _, v in v125 do
            if v:GetAttribute("TimeStamp") == nil and Attribute == nil then
                warn("Impact frame missing time stamp");

                return;
            end;
        end;

        v122.Parent = LocalPlayer.PlayerGui;

        for _, v in v125 do
            v.Visible = false;
        end;

        local u126 = #v125;

        for _, v in v125 do
            task.spawn(function() -- Line: 1017
                -- upvalues: v (copy), Attribute (copy), u82 (ref), u126 (ref)
                local v127 = v:GetAttribute("TimeStamp") or Attribute;

                repeat
                    task.wait();
                until v127 <= u82.TimePosition;

                v.Visible = true;
                v:Play();
                task.wait(v.TimeLength);
                v.Visible = false;
                u126 = u126 - 1;
            end);
        end;

        repeat
            task.wait();
        until u126 <= 0;

        v122:Destroy();
    end);

    if Character2.Values.Goalie.Value and (Character ~= Character2 and (LocalPlayer.Team ~= PlayerFromCharacter.Team and not string_find_ret)) then
        print("end early for goalie!");
        local v128 = Length and Length - 3 or u82:GetTimeLength() - 3;
        task.wait(v128);
    elseif Length then
        task.wait(Length);
    else
        u82.Completed:Wait();
    end;

    u85 = false;
    u82:Stop();
    task.wait();
    u82:Destroy();
    v111();
    u68.UnhideAllPlayers(v98);
    u80 = false;

    if u102 then
        pcall(RunService.UnbindFromRenderStep, RunService, "CutsceneUtilsCameraSync");
    end;

    if v104 then
        pcall(RunService.UnbindFromRenderStep, RunService, "CutsceneUtilsFOVSync");
    end;

    Camera:Destroy();
    u74:Destroy();

    for _, v in u84 do
        v:Destroy();
    end;

    for _, v in v95 do
        v:Destroy();
    end;

    task.wait();
    local Value = ReplicatedStorage.Football.Value;
    local BallSkinBall = Value:FindFirstChild("BallSkinBall", true);

    if Value.Parent == workspace then
        Value.Transparency = 0;

        if BallSkinBall then
            BallSkinBall.Transparency = 0;
        end;
    end;

    if Character.Values.HasBall.Value then
        local PlrFootball = Character:FindFirstChild("PlrFootball");
        local BALL = PlrFootball:FindFirstChild("BALL", true);
        local BallSkinBall2 = PlrFootball:FindFirstChild("BallSkinBall", true);

        if BALL then
            BALL.Transparency = 0;
        end;

        if BallSkinBall2 then
            BallSkinBall2.Transparency = 0;
        end;
    end;

    if u75 then
        local workspace_CurrentCamera2 = workspace.CurrentCamera;

        if workspace_CurrentCamera2 then
            workspace_CurrentCamera2.FieldOfView = FieldOfView;
        end;

        if Controller.EndCutscene then
            Controller:EndCutscene();
        else
            Controller.Cutscene = false;
        end;

        LocalPlayer.Character.Values.InCutscene.Value = false;

        if LocalPlayer.Team ~= game.Teams.Visitor then
            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
        end;

        if string_find_ret and HUD then
            HUD.Enabled = v79;
        end;
    end;

    Character:SetAttribute("CutsceneChar", nil);
    game.SoundService.SoundGroup.OST.Volume = Volume;

    for _, child in Character:GetChildren() do
        if child:IsA("Sound") and (PlayerFromCharacter and child.Name == PlayerFromCharacter.PlayerStats.Style.Value) then
            child:Play();
            TweenService:Create(child, TweenInfo.new(1), {
                Volume = 1
            }):Play();
        end;
    end;

    if u75 then
        workspace.CurrentCamera.CFrame = CFrame2;
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace.CurrentCamera.CameraSubject = CameraSubject;
    end;

    HumanoidRootPart.Anchored = false;
    LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;

function u68.HideAllPlayers(p129, p130) -- Line: 1177
    -- upvalues: Players (copy)
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Parent = workspace;
    local v131 = {};

    for _, v in Players:GetPlayers() do
        local Character = v.Character;

        if Character and (not Character.Values.Goalie.Value or (p129 or p130 and p130[Character])) then
            Character.Parent = ViewportFrame;
            table.insert(v131, Character);
        end;
    end;

    task.delay(60, function() -- Line: 1192
        -- upvalues: ViewportFrame (copy)
        ViewportFrame:Destroy();
    end);

    return v131;
end;

function u68.UnhideAllPlayers(p132) -- Line: 1199
    -- upvalues: Players (copy), ReplicatedStorage (copy)
    for _, v in p132 do
        if Players:GetPlayerFromCharacter(v) then
            v.Parent = ReplicatedStorage;
            v.Parent = workspace;
        end;
    end;
end;

function u68.ChangeLighting(p133: userdata, p134: boolean?) -- Line: 1208
    -- upvalues: Lighting (copy)
    if not p133 then
        warn("no Lighting config");

        return;
    end;

    for _, child in Lighting:GetChildren() do
        child:Destroy();
    end;

    for i, v in p133:GetAttributes() do
        Lighting[i] = v;
    end;

    for _, child in p133:GetChildren() do
        child:Clone().Parent = Lighting;
    end;
end;

function u68.SaveWeldInfo(p135, p136, p137) -- Line: 1229
    local v138 = {};

    for _, descendant in p135[p137]:GetDescendants() do
        if descendant:IsA("Weld") or (descendant:IsA("WeldConstraint") or descendant:IsA("Motor6D")) then
            v138[descendant] = {};

            if descendant.Part0 then
                v138[descendant].Part0 = descendant.Part0.Name;
            end;

            if descendant.Part1 then
                v138[descendant].Part1 = descendant.Part1.Name;
            end;

            return v138;
        end;
    end;
end;

function u68.AmendWelds(p139: userdata, p140: userdata, p141: string) -- Line: 1251
    local v142 = p139[p141];

    for _, descendant in p139:GetDescendants() do
        if descendant:IsA("Weld") or (descendant:IsA("WeldConstraint") or descendant:IsA("Motor6D")) then
            local Part1 = descendant.Part1;

            if Part1 and Part1:IsDescendantOf(v142) then
                descendant.Part1 = p140:FindFirstChild(Part1.Name);
            end;

            local Part0 = descendant.Part0;

            if Part0 and Part0:IsDescendantOf(v142) then
                descendant.Part0 = p140:FindFirstChild(Part0.Name);
            end;
        end;
    end;
end;

function u68.CutsceneText(p143: string, u144: number, u145: string, u146) -- Line: 1269
    -- upvalues: Players (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy)
    local v147, v148 = tostring(p143):match("^(%d+):(%d+)$");
    local v149;

    if v147 and v148 then
        v149 = tonumber(v147) + tonumber(v148) / 1000;
    else
        v149 = tonumber(p143) or 0;
    end;

    task.delay(v149, function() -- Line: 1272
        -- upvalues: Players (ref), ReplicatedStorage (ref), u145 (copy), u146 (copy), TweenService (ref), u144 (copy), Debris (ref)
        local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

        if Popup then
            Popup:Destroy();
        end;

        local u150 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u150.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u150.Position = UDim2.new(0.5, 0, 0.8, 0);
        u150.AnchorPoint = Vector2.new(0.5, 0.5);
        u150.Size = UDim2.new(1, 0, 0.1, 0);
        u150.BackgroundTransparency = 1;
        u150.Font = Enum.Font.ArialBold;
        u150.Text = u145;
        u150.TextColor3 = u146 or Color3.new(1, 1, 1);
        u150.TextTransparency = 0;
        u150.TextStrokeTransparency = 0;
        u150.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u150;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u150, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u145
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u144, function() -- Line: 1304
            -- upvalues: TweenService (ref), u150 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u150, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u150, 1);
        end);
    end);
end;

function u68.HideMap() -- Line: 1317
    -- upvalues: ReplicatedStorage (copy)
    local v151 = workspace.Maps:GetChildren()[1];
    v151.Parent = ReplicatedStorage;
    local v152 = {};

    for _, descendant in workspace.Field:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("Texture")) and descendant.Transparency ~= 1 then
            v152[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    local CrowdMap2 = workspace:FindFirstChild("CrowdMap2");

    if CrowdMap2 then
        for _, child in CrowdMap2:GetChildren() do
            if child:IsA("BasePart") then
                v152[child] = child.Transparency;
                child.Transparency = 1;
            end;
        end;
    end;

    return v151, v152;
end;

function u68.UnhideMap(p153, p154) -- Line: 1342
    p153.Parent = workspace.Maps;

    for i, v in p154 do
        i.Transparency = v;
    end;
end;

function u68.HideLobby() -- Line: 1350
    -- upvalues: ReplicatedStorage (copy)
    local workspace_NewLobby = workspace.NewLobby;
    workspace_NewLobby.Parent = ReplicatedStorage;

    return workspace_NewLobby;
end;

function u68.UnhideLobby(p155) -- Line: 1356
    p155.Parent = workspace;
end;

function u68.PrepFrames(p156) -- Line: 1360
    -- upvalues: LocalPlayer (copy)
    local v157 = script.ImpactFramesPictures:FindFirstChild(p156);
    assert(v157, "No frame folder found");

    for i = 1, #v157:GetChildren() do
        local v158 = v157:FindFirstChild(i);
        local v159;

        if v158 then
            local v160 = v158:Clone();
            v160.Parent = LocalPlayer.PlayerGui.ImpactFramesPreload;
            v160.Visible = true;
            v160.Size = UDim2.new(0, 1, 0, 1);
            v160.Position = UDim2.new(0, 0, 0, 0);
            v160.Visible = true;
            task.delay(25, v160.Destroy, v160);
            v159 = i;
        else
            v159 = i;
        end;
    end;
end;

function u68.ImpactFrames(p161, p162) -- Line: 1381
    -- upvalues: LocalPlayer (copy)
    local v163 = script.ImpactFramesPictures:FindFirstChild(p161);
    assert(v163, "No frame folder found");

    for i = 1, #v163:GetChildren() do
        local v164 = v163:FindFirstChild(i);
        local v165;

        if v164 then
            v165 = i;
            local v166 = nil;

            for _, child in pairs(LocalPlayer.PlayerGui.ImpactFramesPreload:GetChildren()) do
                print(child);

                if child:IsA("ImageLabel") and child.Image == v164.Image then
                    v166 = child;
                    break;
                end;
            end;

            if v166 then
                v166.Size = UDim2.new(1.075, 0, 1.075, 0);
                v166.Position = UDim2.new(-0.038, 0, -0.038, 0);
                v166.Visible = true;
                v166.ZIndex = v165;
                task.delay(p162 * 1.5, v166.Destroy, v166);
                task.wait(p162);
            end;
        else
            v165 = i;
        end;
    end;
end;

local u167 = nil;

function u68.MVPGoal(p168: string?) -- Line: 1417
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), u167 (ref), TweenService (copy), Debris (copy), RunService (copy)
    local Value = ReplicatedStorage.Goals.Home.Value;
    local Value2 = ReplicatedStorage.Goals.Away.Value;
    local MVPCutsceneGoal = LocalPlayer.PlayerGui.MVPCutsceneGoal;
    local v169 = p168 and script.MVPGoalUIs:FindFirstChild(p168);

    if v169 then
        require(v169)(MVPCutsceneGoal, Value, Value2);

        return;
    end;

    local GoalText = MVPCutsceneGoal.Frame.GoalText;
    local Separator = MVPCutsceneGoal.Frame.Separator;
    local Score1Frame = Separator.Score1Frame;
    local Score2Frame = Separator.Score2Frame;
    local CurrentScore = Score1Frame.CurrentScore;
    local NewScore = Score1Frame.NewScore;
    local CurrentScore2 = Score2Frame.CurrentScore;
    local NewScore2 = Score2Frame.NewScore;

    if u167 == nil then
        u167 = {
            goalPos = GoalText.Position,
            separatorPos = Separator.Position
        };
    end;

    local goalPos = u167.goalPos;
    local separatorPos = u167.separatorPos;
    local string_match_ret, v170 = string.match(Value .. " - " .. Value2, "^%s*(%S+)%s*-%s*(%S+)%s*$");
    local u171 = tonumber(string_match_ret) or 0;
    local u172 = tonumber(v170) or 0;
    local ShineEffect = GoalText:FindFirstChild("ShineEffect");

    if ShineEffect then
        ShineEffect:Destroy();
    end;

    local ShineOverlay = GoalText:FindFirstChild("ShineOverlay");

    if ShineOverlay then
        ShineOverlay:Destroy();
    end;

    for _, child in GoalText.Parent:GetChildren() do
        if child.Name == "GoalAfterimage" or child.Name == "GoalShadow" then
            child:Destroy();
        end;
    end;

    for _, child in Separator:GetChildren() do
        if child.Name == "Score1NewShadow" or child.Name == "Score2NewShadow" then
            child:Destroy();
        end;
    end;

    local UDim2_new_ret = UDim2.new(separatorPos.X.Scale, separatorPos.X.Offset, 1.5, 0);
    local UDim2_new_ret2 = UDim2.new(goalPos.X.Scale, goalPos.X.Offset, -0.5, 0);
    local UDim2_fromScale_ret = UDim2.fromScale(0.5, 0.5);
    local UDim2_fromScale_ret2 = UDim2.fromScale(0.5, -0.5);
    local UDim2_fromScale_ret3 = UDim2.fromScale(0.5, 1.5);
    CurrentScore.Text = "0";
    CurrentScore.Position = UDim2_fromScale_ret;
    NewScore.Position = UDim2_fromScale_ret2;
    CurrentScore2.Text = "0";
    CurrentScore2.Position = UDim2_fromScale_ret;
    NewScore2.Position = UDim2_fromScale_ret2;
    Separator.Position = UDim2_new_ret;
    GoalText.Position = UDim2_new_ret2;
    GoalText.ImageTransparency = 1;
    MVPCutsceneGoal.Enabled = true;
    local v173 = TweenService:Create(Separator, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = separatorPos
    });
    v173:Play();
    v173.Completed:Wait();
    task.wait(0.35);
    local v174 = TweenService:Create(GoalText, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0,
        Position = goalPos
    });
    v174:Play();
    local u175 = true;
    task.spawn(function() -- Line: 1509
        -- upvalues: u175 (ref), GoalText (copy), TweenService (ref), Debris (ref)
        while u175 do
            local v176 = GoalText:Clone();
            v176.Name = "GoalAfterimage";
            v176:ClearAllChildren();
            v176.Position = GoalText.Position;
            v176.ImageTransparency = math.min(1, GoalText.ImageTransparency + 0.3);
            v176.ZIndex = GoalText.ZIndex - 1;
            v176.Parent = GoalText.Parent;
            TweenService:Create(v176, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                ImageTransparency = 1
            }):Play();
            Debris:AddItem(v176, 0.3);
            task.wait(0.03);
        end;
    end);
    v174.Completed:Connect(function() -- Line: 1525
        -- upvalues: u175 (ref)
        u175 = false;
    end);

    local function flickScore(p177, p178, p179) -- Line: 1533
        -- upvalues: UDim2_fromScale_ret2 (copy), TweenService (ref), UDim2_fromScale_ret (copy), UDim2_fromScale_ret3 (copy)
        if p179 <= 0 then
            return p177;
        end;

        local TweenInfo_new_ret = TweenInfo.new(0.4 / p179, Enum.EasingStyle.Linear);

        for i = 1, p179 do
            p178.Text = tostring(i);
            p178.Position = UDim2_fromScale_ret2;
            TweenService:Create(p178, TweenInfo_new_ret, {
                Position = UDim2_fromScale_ret
            }):Play();
            local v180 = TweenService:Create(p177, TweenInfo_new_ret, {
                Position = UDim2_fromScale_ret3
            });
            v180:Play();
            v180.Completed:Wait();
            local _ = i;
            local v181 = p177;
            p177 = p178;
            p178 = v181;
        end;

        return p177;
    end;

    local u182 = CurrentScore;
    local u183 = CurrentScore2;
    local u184 = 2;
    task.spawn(function() -- Line: 1552
        -- upvalues: u182 (ref), flickScore (copy), CurrentScore (copy), NewScore (copy), u171 (copy), u184 (ref)
        u182 = flickScore(CurrentScore, NewScore, u171);
        u184 = u184 - 1;
    end);
    task.spawn(function() -- Line: 1556
        -- upvalues: u183 (ref), flickScore (copy), CurrentScore2 (copy), NewScore2 (copy), u172 (copy), u184 (ref)
        u183 = flickScore(CurrentScore2, NewScore2, u172);
        u184 = u184 - 1;
    end);

    while u184 > 0 do
        RunService.Heartbeat:Wait();
    end;

    local AbsolutePosition = Separator.AbsolutePosition;
    local AbsoluteSize = Separator.AbsoluteSize;

    local function spawnScoreShadow(p185, p186, p187) -- Line: 1568
        -- upvalues: AbsolutePosition (copy), AbsoluteSize (copy), Separator (copy), TweenService (ref), Debris (ref)
        local AbsoluteSize2 = p185.AbsoluteSize;
        local v188 = (p185.AbsolutePosition + AbsoluteSize2 * 0.5 - AbsolutePosition) / AbsoluteSize;
        local v189 = AbsoluteSize2 / AbsoluteSize;
        local v190 = p185:Clone();
        v190.Name = p187;
        v190:ClearAllChildren();
        v190.AnchorPoint = Vector2.new(0.5, 0.5);
        v190.Position = UDim2.fromScale(v188.X, v188.Y);
        v190.Size = UDim2.fromScale(v189.X, v189.Y);
        v190.Text = p185.Text;
        v190.TextTransparency = 0;
        v190.ZIndex = p186.ZIndex - 1;
        v190.Parent = Separator;
        local UDim2_fromScale_ret4 = UDim2.fromScale(v189.X * 2.25, v189.Y * 2.25);
        local v191 = TweenService:Create(v190, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1,
            Size = UDim2_fromScale_ret4
        });
        v191:Play();
        Debris:AddItem(v190, 0.7);

        return v191;
    end;

    spawnScoreShadow(u182, Score1Frame, "Score1NewShadow");
    local v192 = spawnScoreShadow(u183, Score2Frame, "Score2NewShadow");
    local v193 = GoalText:Clone();
    v193.Name = "GoalShadow";
    v193:ClearAllChildren();
    v193.AnchorPoint = GoalText.AnchorPoint;
    v193.Position = GoalText.Position;
    v193.Size = GoalText.Size;
    v193.ImageTransparency = 0;
    v193.ZIndex = GoalText.ZIndex - 1;
    v193.Parent = GoalText.Parent;
    local UDim2_new_ret3 = UDim2.new(GoalText.Size.X.Scale * 1.5, GoalText.Size.X.Offset * 1.5, GoalText.Size.Y.Scale * 1.5, GoalText.Size.Y.Offset * 1.5);
    TweenService:Create(v193, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1,
        Size = UDim2_new_ret3
    }):Play();
    Debris:AddItem(v193, 0.7);
    v192.Completed:Wait();
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "ShineEffect";
    UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1));
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.35, 0),
        NumberSequenceKeypoint.new(0.5, 0.7),
        NumberSequenceKeypoint.new(0.65, 0),
        NumberSequenceKeypoint.new(1, 0)
    });
    UIGradient.Rotation = 75;
    UIGradient.Offset = Vector2.new(-1, 0);
    UIGradient.Enabled = true;
    UIGradient.Parent = GoalText;
    TweenService:Create(UIGradient, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Offset = Vector2.new(1, 0)
    }):Play();
    task.delay(0.2, function() -- Line: 1644
        -- upvalues: TweenService (ref), UIGradient (copy)
        TweenService:Create(UIGradient, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Offset = Vector2.new(1, 0)
        }):Play();
    end);
    task.wait(0.15);
    TweenService:Create(GoalText, TweenInfo.new(1), {
        ImageTransparency = 1
    }):Play();
    task.wait(0.55);
    UIGradient:Destroy();
    local v194 = TweenService:Create(GoalText, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2_new_ret2
    });
    local v195 = TweenService:Create(Separator, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2_new_ret
    });
    v194:Play();
    v195:Play();
    TweenService:Create(u182, TweenInfo.new(0.4), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(u183, TweenInfo.new(0.4), {
        TextTransparency = 1
    }):Play();
    v195.Completed:Wait();
    MVPCutsceneGoal.Enabled = false;
    GoalText.Position = goalPos;
    GoalText.ImageTransparency = 0;
    Separator.Position = separatorPos;
    CurrentScore.Position = UDim2_fromScale_ret;
    NewScore.Position = UDim2_fromScale_ret2;
    CurrentScore2.Position = UDim2_fromScale_ret;
    NewScore2.Position = UDim2_fromScale_ret2;
    CurrentScore.TextTransparency = 0;
    NewScore.TextTransparency = 0;
    CurrentScore2.TextTransparency = 0;
    NewScore2.TextTransparency = 0;
end;

return u68;