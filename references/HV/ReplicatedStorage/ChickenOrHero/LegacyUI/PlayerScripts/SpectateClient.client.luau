 

 

local HudNavigation = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local Presentation = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation");
local Session = Presentation.Parent:WaitForChild("Game"):WaitForChild("Session");
local SpectateConfig = require(Presentation:WaitForChild("SpectateConfig"));
local VerifiedName = require(Presentation:WaitForChild("VerifiedName"));
local CreatorPolicy = require(Presentation:WaitForChild("CreatorPolicy"));
local u1 = false;
local SpectateGeometry = require(Presentation:WaitForChild("SpectateGeometry"));
local SpectateCamera = require(Presentation:WaitForChild("SpectateCamera"));
local SpectateView = require(Presentation:WaitForChild("SpectateView"));
local SpectateInput = require(Presentation:WaitForChild("SpectateInput"));
local ParticipantDirectory = require(Presentation:WaitForChild("ParticipantDirectory"));
local u2;

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots then
    u2 = require(Presentation.Parent:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;
else
    u2 = nil;
end;

local u3 = nil;

local function characterOf(p4) -- Line: 23
    -- upvalues: u2 (copy)
    local v5 = u2;

    if v5 then
        if type(p4) == "number" then
            v5 = u2.resolve(p4);
        else
            v5 = false;
        end;
    end;

    return v5 and v5.Character or nil;
end;

local SpectateEvent = Presentation:WaitForChild("SpectateEvent");
local u6 = SpectateView.new(LocalPlayer);
local u7 = false;
local u8 = "Follow";
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = {};
local u16 = {};
local u17 = 0;
local u18 = 0;
local u19 = false;
local u20 = 0;
local u21 = nil;
local u22 = { "MapVoteOpen", "JourneyOpen", "ArmoryOpen", "BalloonOfferOpen", "ServerBrowserOpen", "FairPlayNoticeOpen", "ChoiceSpotlightActive", "AdminConsoleActive", "SettingsOpen", "UpdateLogOpen" };

local function connect(p23, p24) -- Line: 36
    -- upvalues: u15 (copy)
    table.insert(u15, p23:Connect(p24));
end;

local function eligible(p25) -- Line: 37
    -- upvalues: SpectateConfig (copy), CreatorPolicy (copy), LocalPlayer (copy), Session (copy)
    if p25 then
        local v26 = SpectateConfig.Enabled and CreatorPolicy.lobby(LocalPlayer, Session);

        return v26;
    end;

    local Enabled = SpectateConfig.Enabled;

    if Enabled then
        if Session:GetAttribute("SpectateAvailable") == true then
            Enabled = not Session:GetAttribute("MapChanging");

            if Enabled then
                if LocalPlayer:GetAttribute("ClientReady") == true and (LocalPlayer:GetAttribute("InMatch") ~= true and (LocalPlayer:GetAttribute("GameRole") or "Lobby") == "Lobby") then
                    Enabled = not (LocalPlayer:GetAttribute("TutorialSession") or LocalPlayer:GetAttribute("TutorialRouting") or (LocalPlayer:GetAttribute("ScreenPresentationActive") or LocalPlayer:GetAttribute("AdminTransferring"))) and not LocalPlayer:GetAttribute("ServerBrowserTransferring");
                else
                    Enabled = false;
                end;
            end;
        else
            Enabled = false;
        end;
    end;

    return Enabled;
end;

local function menuOpen() -- Line: 44
    -- upvalues: u22 (copy), LocalPlayer (copy)
    for _, v in u22 do
        if LocalPlayer:GetAttribute(v) then
            return true;
        end;
    end;

    return false;
end;

local function render() -- Line: 45
    -- upvalues: UserInputService (copy), u6 (copy), u7 (ref), u8 (ref), u1 (ref), HudNavigation (copy), eligible (copy), u22 (copy), LocalPlayer (copy)
    local v27 = UserInputService:GetLastInputType().Name:find("Gamepad") ~= nil;
    u6:render(u7, u8, UserInputService.TouchEnabled and not v27, v27);

    if u7 and u1 then
        u6.bar.Visible = false;
        u6.hint.Visible = false;
        u6.hintButton.Visible = false;
    end;

    u6.open.Visible = false;
    local setAvailable = HudNavigation.setAvailable;
    local v28 = eligible();

    if v28 then
        v28 = not u7;

        if v28 then
            local v29 = false;

            for _, v in u22 do
                if LocalPlayer:GetAttribute(v) then
                    v29 = true;
                    break;
                end;
            end;

            v28 = not v29;
        end;
    end;

    setAvailable("Spectate", v28);
end;

local function touchControls() -- Line: 51
    -- upvalues: LocalPlayer (copy), u21 (ref), u11 (ref)
    local TouchGui = LocalPlayer.PlayerGui:FindFirstChild("TouchGui");

    if TouchGui and TouchGui ~= u21 then
        if u21 and (u21.Parent and u11) then
            u21.Enabled = u11.touchEnabled;
        end;

        u21 = TouchGui;
        u11.touchEnabled = TouchGui.Enabled;
        TouchGui.Enabled = false;
    end;
end;

local function u33(p30) -- Line: 58
    -- upvalues: u19 (ref), u20 (ref), SpectateEvent (copy), u7 (ref), u1 (ref), LocalPlayer (copy), u14 (ref), u8 (ref), u11 (ref), u21 (ref), UserInputService (copy), u3 (ref), u2 (copy), u9 (ref), u10 (ref), u13 (ref), u12 (ref), u16 (copy), render (copy)
    u19 = false;
    u20 = u20 + 1;

    if p30 then
        SpectateEvent:FireServer("Stop");
    end;

    local v31 = u7;
    u7 = false;
    u1 = false;
    LocalPlayer:SetAttribute("CreatorCameraActive", nil);
    u14:set(false, u8);
    LocalPlayer:SetAttribute("Spectating", nil);
    LocalPlayer:SetAttribute("SpectateMode", nil);
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if v31 and workspace_CurrentCamera then
        local v32 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or u11 and u11.subject;
        workspace_CurrentCamera.CameraSubject = v32;
        workspace_CurrentCamera.CameraType = u11 and u11.cameraType or Enum.CameraType.Custom;

        if u11 then
            workspace_CurrentCamera.FieldOfView = u11.fov;
            workspace_CurrentCamera.CFrame = u11.cf;
            workspace_CurrentCamera.Focus = u11.focus;
        end;
    end;

    if u21 and (u21.Parent and u11) then
        u21.Enabled = u11.touchEnabled;
    end;

    u21 = nil;

    if v31 and u11 then
        UserInputService.MouseBehavior = u11.mouse;
        UserInputService.MouseIconEnabled = u11.icon;
    end;

    if u3 then
        u3 = nil;
        u2.setFocus(nil);
    end;

    u9 = nil;
    u10 = nil;
    u13 = nil;
    u12 = nil;
    u11 = nil;
    table.clear(u16);
    render();
end;

local function action(p34) -- Line: 78
    -- upvalues: u33 (ref), u7 (ref), u1 (ref), SpectateEvent (copy), u8 (ref)
    if p34 == "Stop" then
        u33(true);

        return;
    end;

    if u7 then
        if u1 then
            return;
        end;

        if p34 == "Previous" then
            SpectateEvent:FireServer("Next", -1);

            return;
        end;

        if p34 == "Next" then
            SpectateEvent:FireServer("Next", 1);

            return;
        end;

        if p34 == "Toggle" then
            SpectateEvent:FireServer(u8 == "Free" and "Follow" or "Free");

            return;
        end;

        if p34 == "Follow" or p34 == "Free" then
            SpectateEvent:FireServer(p34);
        end;
    end;
end;

u14 = SpectateInput.new(u6, action);

local function startWatching() -- Line: 89
    -- upvalues: HudNavigation (copy), eligible (copy), u22 (copy), LocalPlayer (copy), u19 (ref), u20 (ref), SpectateEvent (copy)
    HudNavigation.opening("Spectate");

    if eligible() then
        local v35 = false;

        for _, v in u22 do
            if LocalPlayer:GetAttribute(v) then
                v35 = true;
                break;
            end;
        end;

        if not (v35 or u19) then
            u19 = true;
            u20 = u20 + 1;
            local u36 = u20;
            SpectateEvent:FireServer("Start");
            task.delay(8, function() -- Line: 93
                -- upvalues: u20 (ref), u36 (copy), u19 (ref)
                if u20 == u36 then
                    u19 = false;
                end;
            end);
        end;
    end;
end;

HudNavigation.register("CreatorCamera", function() -- Line: 95
    -- upvalues: u1 (ref), u7 (ref), u19 (ref), u33 (ref), SpectateConfig (copy), CreatorPolicy (copy), LocalPlayer (copy), Session (copy), HudNavigation (copy), u22 (copy), u20 (ref), SpectateEvent (copy)
    if u1 and (u7 or u19) then
        u33(true);

        return;
    end;

    local v37 = SpectateConfig.Enabled and CreatorPolicy.lobby(LocalPlayer, Session);

    if not v37 then
        HudNavigation.Notice:Fire("Creator freecam is available while you are in the lobby.");

        return;
    end;

    HudNavigation.opening("CreatorCamera");
    local v38 = false;

    for _, v in u22 do
        if LocalPlayer:GetAttribute(v) then
            v38 = true;
            break;
        end;
    end;

    if v38 then
        HudNavigation.Notice:Fire("Close the other menu before starting the camera.");

        return;
    end;

    if u7 then
        u33(false);
    end;

    u1 = true;
    u19 = true;
    u20 = u20 + 1;
    local u39 = u20;
    SpectateEvent:FireServer("CreatorStart");
    task.delay(8, function() -- Line: 103
        -- upvalues: u20 (ref), u39 (copy), u19 (ref), u33 (ref), HudNavigation (ref)
        if u20 == u39 and u19 then
            u33(true);
            HudNavigation.Notice:Fire("Camera request timed out. Try again.");
        end;
    end);
end);
HudNavigation.setAvailable("CreatorCamera", true);
HudNavigation.register("Spectate", startWatching);
table.insert(u15, u6.open.Activated:Connect(startWatching));

for _, v in {
    { u6.prev, "Previous" },
    { u6.next, "Next" },
    { u6.follow, "Follow" },
    { u6.free, "Free" },
    { u6.exit, "Stop" }
} do
    table.insert(u15, v[1].Activated:Connect(function() -- Line: 109
        -- upvalues: action (copy), v (copy)
        action(v[2]);
    end));
end;

table.insert(u15, u6.zoomIn.Activated:Connect(function() -- Line: 111
    -- upvalues: u12 (ref)
    if u12 then
        u12:zoom(-3);
    end;
end));
table.insert(u15, u6.zoomOut.Activated:Connect(function() -- Line: 112
    -- upvalues: u12 (ref)
    if u12 then
        u12:zoom(3);
    end;
end));

local function refreshIgnore() -- Line: 113
    -- upvalues: u16 (copy), LocalPlayer (copy), ParticipantDirectory (copy), u2 (copy), u17 (ref)
    table.clear(u16);

    if LocalPlayer.Character then
        table.insert(u16, LocalPlayer.Character);
    end;

    for _, v in ParticipantDirectory.list() do
        if v.Character then
            table.insert(u16, v.Character);
        end;
    end;

    local SpectatorStreamingFoci = workspace:FindFirstChild("SpectatorStreamingFoci");

    if SpectatorStreamingFoci then
        table.insert(u16, SpectatorStreamingFoci);
    end;

    local v40 = u2 and workspace:FindFirstChild("ClientBots");

    if v40 then
        table.insert(u16, v40);
    end;

    u17 = os.clock();
end;

table.insert(u15, SpectateEvent.OnClientEvent:Connect(function(p41, u42) -- Line: 121
    -- upvalues: u33 (ref), u6 (copy), u7 (ref), SpectateGeometry (copy), u12 (ref), eligible (copy), u22 (copy), LocalPlayer (copy), u19 (ref), u1 (ref), u11 (ref), UserInputService (copy), SpectateCamera (copy), u13 (ref), u8 (ref), u10 (ref), u21 (ref), u9 (ref), u18 (ref), u2 (copy), VerifiedName (copy), u14 (ref), refreshIgnore (copy), render (copy)
    if p41 == "Stop" then
        u33(false);

        if type(u42) == "string" then
            u6.note.Text = u42;
            task.delay(4, function() -- Line: 125
                -- upvalues: u6 (ref), u42 (copy)
                if u6.note.Parent and u6.note.Text == u42 then
                    u6.note.Text = "";
                end;
            end);
        end;

        return;
    end;

    if p41 == "Bounds" and (u7 and SpectateGeometry.valid(u42)) then
        u12.area = u42;

        return;
    end;

    if p41 ~= "Target" and p41 ~= "Free" then
        return;
    end;

    if type(u42) ~= "table" or not SpectateGeometry.valid(u42.area) then
        return;
    end;

    local v43 = u42.creator == true;

    if eligible(v43) then
        local v44 = false;

        for _, v in u22 do
            if LocalPlayer:GetAttribute(v) then
                v44 = true;
                break;
            end;
        end;

        if not v44 and (u7 or u19) then
            u1 = v43;
            local workspace_CurrentCamera = workspace.CurrentCamera;

            if not workspace_CurrentCamera then
                u33(true);

                return;
            end;

            local v45 = not u7;

            if v45 then
                u11 = {
                    subject = workspace_CurrentCamera.CameraSubject,
                    cameraType = workspace_CurrentCamera.CameraType,
                    fov = workspace_CurrentCamera.FieldOfView,
                    cf = workspace_CurrentCamera.CFrame,
                    focus = workspace_CurrentCamera.Focus,
                    mouse = UserInputService.MouseBehavior,
                    icon = UserInputService.MouseIconEnabled
                };
                local v46 = u42.position or u42.area.cf.Position;
                local CFrame_lookAt_ret = CFrame.lookAt(SpectateGeometry.clamp(v46 + Vector3.new(0, 9, 18), u42.area), v46 + Vector3.new(0, 1.5, 0));

                if u1 then
                    CFrame_lookAt_ret = CFrame.new(SpectateGeometry.clamp(v46, u42.area)) * workspace_CurrentCamera.CFrame.Rotation;
                end;

                u12 = SpectateCamera.new(CFrame_lookAt_ret, u42.area);
                workspace_CurrentCamera.FieldOfView = u1 and (LocalPlayer:GetAttribute("CreatorFOV") or 60) or 70;

                if u1 then
                    workspace_CurrentCamera.CFrame = CFrame_lookAt_ret;
                end;
            end;

            u12.area = u42.area;
            u13 = u42.token;
            u19 = false;
            local v47 = p41 == "Free" and "Free" or "Follow";
            local v48 = u8 ~= v47;
            local v49 = u10 ~= u42.id;
            u8 = v47;
            u7 = true;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            LocalPlayer:SetAttribute("Spectating", true);
            LocalPlayer:SetAttribute("SpectateMode", u8);
            LocalPlayer:SetAttribute("CreatorCameraActive", u1 or nil);
            local TouchGui = LocalPlayer.PlayerGui:FindFirstChild("TouchGui");

            if TouchGui and TouchGui ~= u21 then
                if u21 and (u21.Parent and u11) then
                    u21.Enabled = u11.touchEnabled;
                end;

                u21 = TouchGui;
                u11.touchEnabled = TouchGui.Enabled;
                TouchGui.Enabled = false;
            end;

            if u8 == "Free" then
                u12:resetPosition(workspace_CurrentCamera.CFrame);
                u12.focus = nil;
                u9 = nil;
                u6.label.Text = "SPECTATING  /  FREE CAMERA";
                u6.name.Text = "Explore the field";
                u6.role.Text = "STAYING IN THE LOBBY";
                u18 = 0;
            else
                local character = u42.character;

                if not character then
                    local id = u42.id;
                    local v50 = u2;

                    if v50 then
                        if type(id) == "number" then
                            v50 = u2.resolve(id);
                        else
                            v50 = false;
                        end;
                    end;

                    character = v50 and v50.Character or nil;
                end;

                u9 = character;
                u10 = u42.id;

                if v49 or v48 then
                    u12.focus = nil;
                end;

                u6.label.Text = "WATCHING  /  " .. u42.index .. " OF " .. u42.total;
                u6.name.RichText = true;
                u6.name.Text = VerifiedName.format(u42.name, u42.verified, u42.id);
                u6.role.Text = u42.role .. "  ·  " .. u42.state;

                if (v45 or v49) and (workspace.StreamingEnabled and u42.position) then
                    task.spawn(function() -- Line: 160
                        -- upvalues: LocalPlayer (ref), u42 (copy)
                        pcall(function() -- Line: 160
                            -- upvalues: LocalPlayer (ref), u42 (ref)
                            LocalPlayer:RequestStreamAroundAsync(u42.position, 5);
                        end);
                    end);
                end;
            end;

            if v45 or v48 then
                u14:set(true, u8);
            end;

            refreshIgnore();
            u6.note.Text = "";
            render();

            return;
        end;
    end;

    u33(true);
end));

local function v52() -- Line: 166
    -- upvalues: u7 (ref), u19 (ref), eligible (copy), u1 (ref), u22 (copy), LocalPlayer (copy), u33 (ref), render (copy)
    if not (u7 or u19) then
        render();

        return;
    end;

    if eligible(u1) then
        local v51 = false;

        for _, v in u22 do
            if LocalPlayer:GetAttribute(v) then
                v51 = true;
                break;
            end;
        end;

        if not v51 then
            render();

            return;
        end;
    end;

    u33(true);
end;

for _, v in { "CreatorAuthorized", "ClientReady", "InMatch", "GameRole", "TutorialSession", "TutorialRouting", "ScreenPresentationActive", "AdminTransferring", "ServerBrowserTransferring" } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u15, AttributeChangedSignal:Connect(v52));
end;

for _, v in u22 do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u15, AttributeChangedSignal:Connect(v52));
end;

for _, v in { "SpectateAvailable", "MapChanging", "GlobalPaused" } do
    local AttributeChangedSignal = Session:GetAttributeChangedSignal(v);
    table.insert(u15, AttributeChangedSignal:Connect(v52));
end;

local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("SpectateRequestedExit");
table.insert(u15, AttributeChangedSignal:Connect(function() -- Line: 174
    -- upvalues: u7 (ref), u19 (ref), u33 (ref)
    if u7 or u19 then
        u33(true);
    end;
end));
table.insert(u15, LocalPlayer.CharacterRemoving:Connect(function() -- Line: 175
    -- upvalues: u7 (ref), u19 (ref), u33 (ref)
    if u7 or u19 then
        u33(true);
    end;
end));
table.insert(u15, LocalPlayer.CharacterAdded:Connect(function() -- Line: 176
    -- upvalues: u7 (ref), u19 (ref), u33 (ref)
    if u7 or u19 then
        u33(true);
    end;
end));
table.insert(u15, UserInputService.LastInputTypeChanged:Connect(render));
local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("SpectatorHints");
table.insert(u15, AttributeChangedSignal2:Connect(render));
table.insert(u15, LocalPlayer.PlayerGui.ChildAdded:Connect(function(p53) -- Line: 179
    -- upvalues: u7 (ref), LocalPlayer (copy), u21 (ref), u11 (ref)
    if u7 and p53.Name == "TouchGui" then
        local TouchGui = LocalPlayer.PlayerGui:FindFirstChild("TouchGui");

        if TouchGui and TouchGui ~= u21 then
            if u21 and (u21.Parent and u11) then
                u21.Enabled = u11.touchEnabled;
            end;

            u21 = TouchGui;
            u11.touchEnabled = TouchGui.Enabled;
            TouchGui.Enabled = false;
        end;
    end;
end));
RunService:BindToRenderStep("ValleySpectate", Enum.RenderPriority.Camera.Value + 3, function(p54) -- Line: 180
    -- upvalues: u7 (ref), eligible (copy), u1 (ref), u22 (copy), LocalPlayer (copy), u33 (ref), u8 (ref), u9 (ref), u2 (copy), u10 (ref), ParticipantDirectory (copy), u17 (ref), refreshIgnore (copy), u14 (ref), u12 (ref), SpectateGeometry (copy), u16 (copy), u3 (ref), UserInputService (copy), u18 (ref), SpectateConfig (copy), SpectateEvent (copy), u13 (ref)
    if not u7 then
        return;
    end;

    if eligible(u1) then
        local v55 = false;

        for _, v in u22 do
            if LocalPlayer:GetAttribute(v) then
                v55 = true;
                break;
            end;
        end;

        if not v55 then
            local workspace_CurrentCamera = workspace.CurrentCamera;

            if not workspace_CurrentCamera then
                return;
            end;

            if u8 == "Follow" and not (u9 and u9.Parent) then
                if u2 then
                    local v56 = u10;
                    local v57 = u2;

                    if v57 then
                        if type(v56) == "number" then
                            v57 = u2.resolve(v56);
                        else
                            v57 = false;
                        end;
                    end;

                    u9 = v57 and v57.Character or nil;
                else
                    for _, v in ParticipantDirectory.list() do
                        if v.UserId == u10 then
                            u9 = v.Character;
                            break;
                        end;
                    end;
                end;
            end;

            if os.clock() - u17 > 0.5 then
                refreshIgnore();
            end;

            local v58, v59, v60, v61, v62 = u14:sample(p54);

            if LocalPlayer:GetAttribute("FootballCutsceneActive") then
                v59 = Vector2.zero;
                v62 = false;
                v58 = Vector3.new(0, 0, 0);
                v61 = false;
                v60 = 0;
            end;

            u12:look(v59);

            if u8 == "Follow" then
                u12:zoom(v60);
            end;

            local v63 = u9 and u9:FindFirstChild("HumanoidRootPart");

            if not (v63 or (u8 ~= "Follow" or not (u2 and u10))) then
                local v64 = u2.get(u10);
                v63 = v64 and v64:pose() or nil;
            end;

            local Attribute = LocalPlayer:GetAttribute("CreatorCameraSpeed");
            u12.speedScale = u1 and (type(Attribute) == "number" and Attribute == Attribute) and (math.clamp(Attribute, 0.25, 2) or 1) or 1;

            if u1 then
                local Attribute2 = LocalPlayer:GetAttribute("CreatorFOV");
                local v65 = type(Attribute2) == "number" and Attribute2 == Attribute2 and (math.clamp(Attribute2, 35, 90) or 60) or 60;
                workspace_CurrentCamera.FieldOfView = workspace_CurrentCamera.FieldOfView + (v65 - workspace_CurrentCamera.FieldOfView) * SpectateGeometry.alpha(12, p54);
            end;

            local v66, v67 = u12:step(u8, v63, v58, v61, p54, u16);
            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            workspace_CurrentCamera.CFrame = v66;
            workspace_CurrentCamera.Focus = v67;

            if u2 and (not u3 or os.clock() - u3 >= 0.1) then
                u3 = os.clock();
                u2.setFocus(v67.Position);
            end;

            UserInputService.MouseBehavior = v62 and Enum.MouseBehavior.LockCurrentPosition or Enum.MouseBehavior.Default;
            UserInputService.MouseIconEnabled = not v62;

            if u8 == "Free" and os.clock() - u18 >= SpectateConfig.FocusInterval then
                u18 = os.clock();
                SpectateEvent:FireServer("Focus", {
                    token = u13,
                    position = v66.Position
                });
            end;

            return;
        end;
    end;

    u33(true);
end);
v52();
script.Destroying:Connect(function() -- Line: 212
    -- upvalues: u33 (ref), RunService (copy), u14 (ref), u15 (copy), u6 (copy)
    u33(true);
    RunService:UnbindFromRenderStep("ValleySpectate");
    u14:destroy();

    for _, v in u15 do
        v:Disconnect();
    end;

    u6:destroy();
end);