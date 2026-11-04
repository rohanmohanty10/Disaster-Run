 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Session = ChickenOrHero.Game.Session;
local ParticipantDirectory = require(ChickenOrHero.Presentation.ParticipantDirectory);
local VerifiedName = require(ChickenOrHero.Presentation.VerifiedName);
local ChoiceSpotlightConfig = require(ChickenOrHero.Presentation.ChoiceSpotlightConfig);
local u1;

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots then
    u1 = require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;
else
    u1 = nil;
end;

local script_Parent = script.Parent;
local NotificationsF = LocalPlayer.PlayerGui:WaitForChild("Notifications").MainFrame.NotificationsF;
local ChoiceAnnouncement = NotificationsF:WaitForChild("ChoiceAnnouncement");
local u2 = {};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = {};
local u9 = nil;
local u10 = false;

local function actorById(p11) -- Line: 20
    -- upvalues: u1 (copy), ParticipantDirectory (copy)
    if u1 then
        return type(p11) == "number" and u1.resolve(p11) or nil;
    end;

    for _, v in ParticipantDirectory.list() do
        if v.UserId == p11 then
            return v;
        end;
    end;
end;

local function canFocus() -- Line: 25
    -- upvalues: Session (copy), LocalPlayer (copy)
    local Attribute = Session:GetAttribute("Phase");
    local v12;

    if LocalPlayer:GetAttribute("InMatch") == true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true then
        v12 = (Attribute == "SelectHero" or Attribute == "HeroChoice") and true or Attribute == "ChoiceReveal";
    else
        v12 = false;
    end;

    return v12;
end;

local function stopCamera() -- Line: 31
    -- upvalues: u3 (ref), u1 (copy), LocalPlayer (copy)
    local v13 = u3;
    u3 = nil;

    if v13 and v13.focusAt then
        u1.setFocus(nil);
    end;

    if v13 and (workspace.CurrentCamera == v13.camera and v13.camera.CameraType == Enum.CameraType.Scriptable) then
        v13.camera.CFrame = v13.from;
        v13.camera.Focus = v13.focus;
        v13.camera.FieldOfView = v13.fov;
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildOfClass("Humanoid");
        end;

        v13.camera.CameraSubject = Character or v13.subject;
        v13.camera.CameraType = v13.kind;
    end;

    LocalPlayer:SetAttribute("ChoiceSpotlightActive", nil);
end;

local function clearMarker() -- Line: 41
    -- upvalues: u4 (ref), u5 (ref)
    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    if u5 then
        u5:Destroy();
        u5 = nil;
    end;
end;

local function setBanner(p14) -- Line: 45
    -- upvalues: u10 (ref), u9 (ref), ChoiceAnnouncement (copy), TweenService (copy)
    if p14 == u10 then
        return;
    end;

    u10 = p14;

    if u9 then
        u9:Cancel();
    end;

    if p14 then
        ChoiceAnnouncement.Visible = true;
    end;

    u9 = TweenService:Create(ChoiceAnnouncement, TweenInfo.new(p14 and 0.22 or 0.18), {
        GroupTransparency = p14 and 0 or 1
    });
    u9:Play();

    if not p14 then
        local u15 = u9;
        task.delay(0.19, function() -- Line: 54
            -- upvalues: u9 (ref), u15 (copy), u10 (ref), ChoiceAnnouncement (ref)
            if u9 == u15 and not u10 then
                ChoiceAnnouncement.Visible = false;
            end;
        end);
    end;
end;

local function startCamera(p16) -- Line: 57
    -- upvalues: stopCamera (copy), LocalPlayer (copy), u1 (copy), ChoiceSpotlightConfig (copy), Session (copy), ParticipantDirectory (copy), u3 (ref), u2 (ref), ChickenOrHero (copy)
    stopCamera();

    if not p16 or p16.UserId == LocalPlayer.UserId then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = p16.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v17;

    if u1 and (type(p16) == "table" and p16) then
        v17 = p16;
    else
        v17 = nil;
    end;

    if ChoiceSpotlightConfig.CameraEnabled then
        local Attribute = Session:GetAttribute("Phase");
        local v18;

        if LocalPlayer:GetAttribute("InMatch") == true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true then
            v18 = (Attribute == "SelectHero" or Attribute == "HeroChoice") and true or Attribute == "ChoiceReveal";
        else
            v18 = false;
        end;

        if v18 and (Character or v17) and (workspace_CurrentCamera and workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable) then
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
            RaycastParams_new_ret.RespectCanCollide = true;
            local v19 = {};

            for _, v in ParticipantDirectory.list() do
                if v.Character then
                    table.insert(v19, v.Character);
                end;
            end;

            local v20 = u1 and workspace:FindFirstChild("ClientBots");

            if v20 then
                table.insert(v19, v20);
            end;

            RaycastParams_new_ret.FilterDescendantsInstances = v19;
            u3 = {
                camera = workspace_CurrentCamera,
                root = Character,
                actor = v17,
                actorId = p16.UserId,
                started = os.clock(),
                from = workspace_CurrentCamera.CFrame,
                focus = workspace_CurrentCamera.Focus,
                fov = workspace_CurrentCamera.FieldOfView,
                subject = workspace_CurrentCamera.CameraSubject,
                kind = workspace_CurrentCamera.CameraType,
                params = RaycastParams_new_ret,
                deadline = (u2.endsAt or workspace:GetServerTimeNow()) + ChoiceSpotlightConfig.DeadlineGrace
            };
            LocalPlayer:SetAttribute("ChoiceSpotlightActive", true);
            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            ChickenOrHero.Audio.PresentationCues:Fire("ChoiceFocus", ChoiceSpotlightConfig.ApproachTime);
        end;
    end;
end;

local function update() -- Line: 76
    -- upvalues: Session (copy), HttpService (copy), u2 (ref), ChoiceSpotlightConfig (copy), LocalPlayer (copy), setBanner (copy), u4 (ref), u5 (ref), stopCamera (copy), NotificationsF (copy), ChoiceAnnouncement (copy), VerifiedName (copy), u6 (ref), u1 (copy), ParticipantDirectory (copy), script_Parent (copy), u3 (ref), u7 (ref), startCamera (copy), actorById (copy)
    local Attribute = Session:GetAttribute("ChoiceMoment");

    if Attribute then
        local success, result = pcall(function() -- Line: 78
            -- upvalues: HttpService (ref), Attribute (copy)
            return HttpService:JSONDecode(Attribute);
        end);

        if success and type(result) == "table" then
            u2 = result;
        end;
    end;

    local v21 = u2.kind == "Chosen";
    local v22 = u2.kind == "Selected";
    local v23 = (u2.endsAt or 0) + (v22 and ChoiceSpotlightConfig.DeadlineGrace or 0);
    local v24;

    if LocalPlayer:GetAttribute("InMatch") == true then
        if v21 or v22 then
            if workspace:GetServerTimeNow() < v23 and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true then
                if v21 then
                    v24 = v21;
                else
                    local Attribute2 = Session:GetAttribute("Phase");

                    if LocalPlayer:GetAttribute("InMatch") == true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true then
                        v24 = (Attribute2 == "SelectHero" or Attribute2 == "HeroChoice") and true or Attribute2 == "ChoiceReveal";
                    else
                        v24 = false;
                    end;
                end;
            else
                v24 = false;
            end;
        else
            v24 = v22;
        end;
    else
        v24 = false;
    end;

    setBanner(v24);

    if not v24 then
        if u4 then
            u4:Destroy();
            u4 = nil;
        end;

        if u5 then
            u5:Destroy();
            u5 = nil;
        end;

        stopCamera();

        return;
    end;

    local EscapeStreak = NotificationsF:FindFirstChild("EscapeStreak");
    ChoiceAnnouncement.Position = UDim2.new(0.5, 0, 1, EscapeStreak and (EscapeStreak.Visible and 14 + EscapeStreak.AbsoluteSize.Y) or 10);
    local v25 = u2.choice == "Hero";
    local v26 = v21 and v25 and Color3.fromRGB(255, 202, 86) or Color3.fromRGB(158, 217, 238);
    ChoiceAnnouncement.Title.RichText = true;
    local v27 = VerifiedName.format(u2.name or "Runner", u2.verified, u2.userId);
    ChoiceAnnouncement.Title.Text = v21 and v27 .. " chose " .. string.upper(u2.choice or "Chicken") or v27 .. " is choosing…";
    ChoiceAnnouncement.Description.Text = v21 and (v25 and "They cross alone first. Watch their escape." or "Everyone crosses together. Get ready.") or "Chicken or Hero?";
    ChoiceAnnouncement.Accent.BackgroundColor3 = v26;

    if u6 ~= u2.version then
        u6 = u2.version;

        if u4 then
            u4:Destroy();
            u4 = nil;
        end;

        if u5 then
            u5:Destroy();
            u5 = nil;
        end;

        local userId = u2.userId;
        local v28;

        if u1 then
            v28 = type(userId) == "number" and u1.resolve(userId) or nil;
        else
            v28 = nil;

            for _, v in ParticipantDirectory.list() do
                if v.UserId == userId then
                    v28 = v;
                    break;
                end;
            end;
        end;

        if v28 then
            v28 = v28.Character;
        end;

        if v28 then
            u4 = Instance.new("Highlight");
            u4.Name = "ChoiceFocus";
            u4.Adornee = v28;
            u4.FillTransparency = 0.94;
            u4.OutlineTransparency = 0.15;
            u4.DepthMode = Enum.HighlightDepthMode.Occluded;
            u4.FillColor = v26;
            u4.OutlineColor = v26;
            u4.Parent = v28;

            if v21 then
                u5 = script_Parent.DecisionTemplate:Clone();
                u5.Name = "ChoiceDecision";
                u5.Enabled = true;
                u5.Adornee = v28:FindFirstChild("Head") or v28:FindFirstChild("HumanoidRootPart");
                u5.Label.Text = string.upper(u2.choice or "Chicken");
                u5.Label.TextColor3 = v26;
                u5.Parent = script_Parent;
            end;
        end;
    end;

    if v21 and (u3 and (u3.actorId == u2.userId and not u3.resolvedAt)) then
        u3.resolvedAt = os.clock();
    end;

    if v22 and u7 ~= u2.version then
        local Attribute2 = Session:GetAttribute("Phase");
        local v29;

        if LocalPlayer:GetAttribute("InMatch") == true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true then
            v29 = (Attribute2 == "SelectHero" or Attribute2 == "HeroChoice") and true or Attribute2 == "ChoiceReveal";
        else
            v29 = false;
        end;

        if v29 then
            u7 = u2.version;
            startCamera(actorById(u2.userId));
        end;
    end;

    local Attribute2 = Session:GetAttribute("Phase");
    local v30;

    if LocalPlayer:GetAttribute("InMatch") == true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true then
        v30 = (Attribute2 == "SelectHero" or Attribute2 == "HeroChoice") and true or Attribute2 == "ChoiceReveal";
    else
        v30 = false;
    end;

    if not v30 then
        stopCamera();
    end;
end;

local AttributeChangedSignal = Session:GetAttributeChangedSignal("ChoiceMoment");
table.insert(u8, AttributeChangedSignal:Connect(update));
local AttributeChangedSignal2 = Session:GetAttributeChangedSignal("Phase");
table.insert(u8, AttributeChangedSignal2:Connect(update));
local u31 = 0;

for _, v in { "InMatch", "ScreenPresentationActive" } do
    local AttributeChangedSignal3 = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u8, AttributeChangedSignal3:Connect(update));
end;

table.insert(u8, LocalPlayer.CharacterAdded:Connect(function() -- Line: 121
    -- upvalues: stopCamera (copy), u4 (ref), u5 (ref)
    stopCamera();

    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    if u5 then
        u5:Destroy();
        u5 = nil;
    end;
end));
local PropertyChangedSignal = workspace:GetPropertyChangedSignal("CurrentCamera");
table.insert(u8, PropertyChangedSignal:Connect(stopCamera));

local function subject(p32) -- Line: 124
    -- upvalues: u1 (copy)
    if not p32.actor then
        if p32.root.Parent then
            return p32.root.Position, p32.root.CFrame.LookVector;
        end;

        return nil;
    end;

    local v33 = u1.get(p32.actorId);

    if not v33 then
        return nil;
    end;

    p32.actor = v33;
    local v34, v35 = v33:pose();

    if typeof(v34) ~= "Vector3" then
        return nil;
    end;

    if type(v35) == "number" then
        return v34, CFrame.Angles(0, v35, 0).LookVector;
    end;

    return v34, typeof(v35) ~= "Vector3" and Vector3.new(0, 0, 1) or v35;
end;

local function alive(p36) -- Line: 136
    -- upvalues: u1 (copy)
    if p36.actor then
        return u1.get(p36.actorId) ~= nil;
    end;

    return p36.root.Parent ~= nil;
end;

RunService:BindToRenderStep("CoHChoiceSpotlight", Enum.RenderPriority.Camera.Value + 3, function(p37) -- Line: 140
    -- upvalues: u3 (ref), Session (copy), LocalPlayer (copy), u1 (copy), stopCamera (copy), u31 (ref), update (copy), subject (copy), ChoiceSpotlightConfig (copy)
    if u3 then
        local Attribute = Session:GetAttribute("Phase");
        local v38;

        if LocalPlayer:GetAttribute("InMatch") == true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true then
            v38 = (Attribute == "SelectHero" or Attribute == "HeroChoice") and true or Attribute == "ChoiceReveal";
        else
            v38 = false;
        end;

        if v38 then
            local v39 = u3;
            local v40;

            if v39.actor then
                v40 = u1.get(v39.actorId) ~= nil;
            else
                v40 = v39.root.Parent ~= nil;
            end;

            if not v40 or workspace:GetServerTimeNow() > u3.deadline then
                stopCamera();
            end;
        else
            stopCamera();
        end;
    end;

    u31 = u31 + p37;

    if u31 >= 0.1 then
        u31 = 0;
        update();
    end;

    local v41 = u3;

    if not v41 then
        return;
    end;

    local v42, v43 = subject(v41);
    local Attribute = Session:GetAttribute("Phase");
    local v44;

    if LocalPlayer:GetAttribute("InMatch") == true and LocalPlayer:GetAttribute("ScreenPresentationActive") ~= true then
        v44 = (Attribute == "SelectHero" or Attribute == "HeroChoice") and true or Attribute == "ChoiceReveal";
    else
        v44 = false;
    end;

    if not (v44 and (v42 and (workspace.CurrentCamera == v41.camera and (v41.camera.CameraType == Enum.CameraType.Scriptable and (v41.resolvedAt or workspace:GetServerTimeNow() <= v41.deadline))))) then
        stopCamera();

        return;
    end;

    local v45 = os.clock() - v41.started;
    local v46 = v42 + Vector3.new(0, 1, 0);
    local v47 = v46 + v43 * ChoiceSpotlightConfig.Distance + Vector3.new(0, 1, 0) * ChoiceSpotlightConfig.Height;

    if u1 and (not v41.focusAt or os.clock() - v41.focusAt >= 0.1) then
        v41.focusAt = os.clock();
        u1.setFocus(v46);
    end;

    local v48 = workspace:Raycast(v46, v47 - v46, v41.params);

    if v48 then
        v47 = v48.Position + v48.Normal * 0.5;
    end;

    if (v47 - v46).Magnitude < 0.1 then
        v47 = v46 + Vector3.new(0, 0, 1);
    end;

    local CFrame_lookAt_ret = CFrame.lookAt(v47, v46);
    local math_clamp_ret = math.clamp(v45 / ChoiceSpotlightConfig.ApproachTime, 0, 1);

    if v41.resolvedAt then
        local v49 = os.clock() - v41.resolvedAt - ChoiceSpotlightConfig.AnswerHoldTime;

        if ChoiceSpotlightConfig.ReturnTime <= v49 then
            stopCamera();

            return;
        end;

        if v49 > 0 then
            math_clamp_ret = math_clamp_ret * (1 - math.clamp(v49 / ChoiceSpotlightConfig.ReturnTime, 0, 1));
        end;
    end;

    local v50 = math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
    v41.camera.CFrame = v41.from:Lerp(CFrame_lookAt_ret, v50);
    v41.camera.Focus = v41.focus:Lerp(CFrame.new(v46), v50);
end);
script.Destroying:Connect(function() -- Line: 166
    -- upvalues: stopCamera (copy), u4 (ref), u5 (ref), setBanner (copy), RunService (copy), u8 (copy)
    stopCamera();

    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    if u5 then
        u5:Destroy();
        u5 = nil;
    end;

    setBanner(false);
    RunService:UnbindFromRenderStep("CoHChoiceSpotlight");

    for _, v in u8 do
        v:Disconnect();
    end;
end);
update();