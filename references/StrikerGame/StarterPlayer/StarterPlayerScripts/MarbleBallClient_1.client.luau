 
 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TextChatService = game:GetService("TextChatService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local ContextActionService = game:GetService("ContextActionService");
local StarterGui = game:GetService("StarterGui");
local LocalPlayer = Players.LocalPlayer;
local Marble = ReplicatedStorage:WaitForChild("Marble");
local Config = require(Marble:WaitForChild("Config"));
local MarbleBall = require(Marble:WaitForChild("MarbleBall"));
local workspace2 = ReplicatedStorage:WaitForChild("workspace", 10);
local packets = require(ReplicatedStorage:WaitForChild("packets"));
local Attribute = MarbleBall.Attribute;
local CFrame_new_ret = CFrame.new(0, -2.25, -2);
local u1 = TextChatService:FindFirstChildOfClass("BubbleChatConfiguration");

local function flat(p2: vector) -- Line: 27
    return Vector3.new(p2.X, 0, p2.Z);
end;

local u3 = {};

local function watchTerrain(p4: userdata) -- Line: 35
    -- upvalues: u3 (copy)
    if (p4.Name == "Ball" or p4.Name == "MarbleStuckBall") and p4:IsA("BasePart") then
        u3[p4] = true;
    end;
end;

for _, child in workspace.Terrain:GetChildren() do
    if (child.Name == "Ball" or child.Name == "MarbleStuckBall") and child:IsA("BasePart") then
        u3[child] = true;
    end;
end;

workspace.Terrain.ChildAdded:Connect(watchTerrain);
workspace.Terrain.ChildRemoved:Connect(function(p5) -- Line: 44
    -- upvalues: u3 (copy)
    u3[p5] = nil;
end);
local u6 = nil;

local function freeBallPart() -- Line: 49
    -- upvalues: u6 (ref), u3 (copy)
    if u6 and u6.Parent == workspace.Terrain then
        return u6;
    end;

    u6 = nil;

    for i in u3 do
        if i.Name == "Ball" and (i.Parent and i:FindFirstChild("position")) then
            u6 = i;
        end;
    end;

    return u6;
end;

local function marbleOf(p7: userdata) -- Line: 62
    -- upvalues: Players (copy), CollectionService (copy), Config (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p7);

    if not PlayerFromCharacter then
        return nil;
    end;

    for _, v in CollectionService:GetTagged(Config.Tag) do
        if v:IsA("BasePart") and v:GetAttribute("OwnerUserId") == PlayerFromCharacter.UserId then
            return v;
        end;
    end;

    return nil;
end;

local function drawnBall() -- Line: 77
    -- upvalues: workspace2 (copy), Attribute (copy), marbleOf (copy), CFrame_new_ret (copy), freeBallPart (copy), ReplicatedStorage (copy)
    local v8 = workspace2 and workspace2:FindFirstChild("ballHolder");

    if v8 then
        v8 = v8.Value;
    end;

    if not (v8 and (v8:IsA("Model") and v8.Parent)) then
        local v9 = freeBallPart();

        if v9 then
            return v9.Position, v9.Transparency < 1;
        end;

        local CFBall = ReplicatedStorage:FindFirstChild("CFBall");

        if CFBall and CFBall:IsA("CFrameValue") then
            return CFBall.Value.Position, true;
        end;

        return nil, true;
    end;

    if v8:GetAttribute(Attribute) then
        return nil, true;
    end;

    if v8:GetAttribute("InMarble") then
        local v10 = marbleOf(v8);
        local v11;

        if v10 then
            v11 = v10:GetAttribute("StuckBall");
        else
            v11 = v10;
        end;

        if v10 and typeof(v11) == "Vector3" then
            return (v10.CFrame * CFrame.new(v11)).Position, true;
        end;
    end;

    local v12 = v8:GetAttribute("AlternateBallRig") and v8:FindFirstChild("AlternateBallRig");

    if v12 then
        v12 = v12:FindFirstChild("Ball");
    end;

    if v12 and v12:IsA("BasePart") then
        return v12.Position, v12.Transparency < 1;
    end;

    local Ball = v8:FindFirstChild("Ball");

    if Ball and Ball:IsA("BasePart") then
        return Ball.Position, Ball.Transparency < 1;
    end;

    local v13 = v8:FindFirstChild("HumanoidRootPart") or v8.PrimaryPart;

    if v13 and v13:IsA("BasePart") then
        return (v13.CFrame * CFrame_new_ret).Position, true;
    end;

    return nil, true;
end;

local function fallback() -- Line: 117
    local map = workspace:FindFirstChild("map");

    if map then
        map = map:FindFirstChild("centrePoint");
    end;

    return not (map and map:IsA("BasePart")) and Vector3.new(0, 0, 0) or map.Position;
end;

local u14 = {};
local u15 = nil;

local function makeGlass(p16: number) -- Line: 140
    -- upvalues: Config (copy)
    local Part = Instance.new("Part");
    Part.Name = "MarbleBallGlass";
    Part.Shape = Enum.PartType.Ball;
    Part.Size = Vector3.new(1, 1, 1) * p16;
    Part.Material = Enum.Material.Glass;
    Part.Color = Config.Color;
    Part.Transparency = Config.Transparency;
    Part.Reflectance = Config.Reflectance;
    Part.TopSurface = Enum.SurfaceType.Smooth;
    Part.BottomSurface = Enum.SurfaceType.Smooth;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    Part.Parent = workspace.Terrain;

    return Part;
end;

local function makeTag(p17: userdata, p18: userdata) -- Line: 160
    -- upvalues: LocalPlayer (copy)
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "MarbleBallTag";
    BillboardGui.Adornee = p17;
    BillboardGui.Size = UDim2.fromOffset(160, 42);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, p17.Size.Y / 2 + 1.4, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.LightInfluence = 0;
    BillboardGui.ResetOnSpawn = false;
    local Frame = Instance.new("Frame");
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.new(1, 0, 0, 20);
    Frame.Parent = BillboardGui;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 4);
    UIListLayout.Parent = Frame;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromOffset(18, 18);
    ImageLabel.LayoutOrder = 1;
    ImageLabel.Image = `rbxthumb://type=AvatarHeadShot&id={p18.UserId}&w=48&h=48`;
    Instance.new("UICorner", ImageLabel).CornerRadius = UDim.new(1, 0);
    ImageLabel.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel.Size = UDim2.fromOffset(0, 18);
    TextLabel.LayoutOrder = 2;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.TextSize = 15;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.TextStrokeTransparency = 0.7;
    TextLabel.Text = p18.DisplayName;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromOffset(0, 22);
    TextLabel2.Size = UDim2.new(1, 0, 0, 18);
    TextLabel2.Font = Enum.Font.Gotham;
    TextLabel2.TextSize = 13;
    TextLabel2.TextColor3 = Color3.fromRGB(220, 240, 255);
    TextLabel2.TextStrokeTransparency = 0.7;
    TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel2.Visible = false;
    TextLabel2.Parent = BillboardGui;
    BillboardGui.Parent = LocalPlayer:WaitForChild("PlayerGui");

    return BillboardGui, TextLabel2;
end;

local function hideLobbyButtons(u19: any, p20: userdata) -- Line: 214
    -- upvalues: u15 (ref)
    local v21;

    if p20.Name == "Lobby" then
        v21 = p20:FindFirstChild("Frame");
    else
        v21 = false;
    end;

    if not v21 then
        return;
    end;

    for _, v in { "Play", "Spectate" } do
        local u22 = v21:FindFirstChild(v);

        if u22 and (u22:IsA("GuiObject") and u19.hidden[u22] == nil) then
            u19.hidden[u22] = u22.Visible;
            u22.Visible = false;
            local conns = u19.conns;
            local PropertyChangedSignal = u22:GetPropertyChangedSignal("Visible");
            table.insert(conns, PropertyChangedSignal:Connect(function() -- Line: 224
                -- upvalues: u15 (ref), u19 (copy), u22 (copy)
                if u15 == u19 and u22.Visible then
                    u22.Visible = false;
                end;
            end));
        end;
    end;
end;

local function stopEmote(p23, p24) -- Line: 235
    -- upvalues: packets (copy)
    if p24 == Enum.UserInputState.Begin then
        packets.bytenet_useEmote.send({
            emoteName = "",
            method = "Stop"
        });
    end;

    return Enum.ContextActionResult.Sink;
end;

local function enterLocal(u25: userdata) -- Line: 242
    -- upvalues: u15 (ref), ContextActionService (copy), stopEmote (copy), LocalPlayer (copy), Config (copy), ProximityPromptService (copy), StarterGui (copy), hideLobbyButtons (copy)
    local u26 = {
        conns = {},
        hidden = {}
    };
    u15 = u26;

    local function emoting() -- Line: 245
        -- upvalues: u15 (ref), u26 (copy), u25 (copy), ContextActionService (ref), stopEmote (ref)
        if u15 ~= u26 then
            return;
        end;

        if not u25:GetAttribute("Emoting") then
            ContextActionService:UnbindAction("MarbleBallStopEmote");

            return;
        end;

        ContextActionService:BindActionAtPriority("MarbleBallStopEmote", stopEmote, true, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Space, Enum.KeyCode.ButtonA);
        ContextActionService:SetTitle("MarbleBallStopEmote", "Stop");
    end;

    local conns = u26.conns;
    local AttributeChangedSignal = u25:GetAttributeChangedSignal("Emoting");
    table.insert(conns, AttributeChangedSignal:Connect(emoting));
    emoting();
    local success, result = pcall(function() -- Line: 259
        -- upvalues: LocalPlayer (ref)
        return require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
    end);

    if not success then
        result = nil;
    end;

    u26.controls = result;

    if u26.controls then
        u26.controls:Disable();
    end;

    u26.minZoom = LocalPlayer.CameraMinZoomDistance;
    local math_max_ret = math.max(u26.minZoom, Config.BallCameraMinZoom);
    LocalPlayer.CameraMinZoomDistance = math.min(math_max_ret, LocalPlayer.CameraMaxZoomDistance);
    u26.prompts = ProximityPromptService.Enabled;
    ProximityPromptService.Enabled = false;
    local success2, result2 = pcall(StarterGui.GetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Backpack);
    u26.backpack = success2 and result2;

    if u26.backpack then
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Backpack, false);
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

    for _, child in PlayerGui:GetChildren() do
        hideLobbyButtons(u26, child);
    end;

    table.insert(u26.conns, PlayerGui.ChildAdded:Connect(function(u27) -- Line: 279
        -- upvalues: u15 (ref), u26 (copy), hideLobbyButtons (ref)
        task.defer(function() -- Line: 280
            -- upvalues: u15 (ref), u26 (ref), hideLobbyButtons (ref), u27 (copy)
            if u15 == u26 then
                hideLobbyButtons(u26, u27);
            end;
        end);
    end));
end;

local function leaveLocal(p28: userdata) -- Line: 288
    -- upvalues: u15 (ref), ContextActionService (copy), LocalPlayer (copy), ProximityPromptService (copy), StarterGui (copy)
    local v29 = u15;

    if not v29 then
        return;
    end;

    u15 = nil;

    for _, v in v29.conns do
        v:Disconnect();
    end;

    ContextActionService:UnbindAction("MarbleBallStopEmote");

    for i, v in v29.hidden do
        if i.Parent then
            i.Visible = v;
        end;
    end;

    if v29.controls then
        v29.controls:Enable();
    end;

    LocalPlayer.CameraMinZoomDistance = v29.minZoom;
    ProximityPromptService.Enabled = v29.prompts;

    if v29.backpack then
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Backpack, true);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v30 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if workspace_CurrentCamera and (workspace_CurrentCamera.CameraSubject == p28 and v30) then
        workspace_CurrentCamera.CameraSubject = v30;
    end;
end;

local function untrack(p31: userdata) -- Line: 318
    -- upvalues: u14 (copy), LocalPlayer (copy), leaveLocal (copy)
    local v32 = u14[p31];

    if not v32 then
        return;
    end;

    u14[p31] = nil;

    for _, v in v32.cleanups do
        v();
    end;

    for _, v in v32.joints do
        if v.joint.Parent then
            v.joint.C0 = v.c0;
        end;
    end;

    if v32.owner == LocalPlayer then
        leaveLocal(v32.glass);
    end;

    v32.glass:Destroy();

    if v32.tag then
        v32.tag:Destroy();
    end;
end;

local function track(p33: userdata, p34: userdata) -- Line: 341
    -- upvalues: u14 (copy), Attribute (copy), makeGlass (copy), MarbleBall (copy), LocalPlayer (copy), makeTag (copy), enterLocal (copy)
    if u14[p34] then
        return;
    end;

    local HumanoidRootPart = p34:WaitForChild("HumanoidRootPart", 5);

    if not (HumanoidRootPart and (HumanoidRootPart:IsA("BasePart") and (p34:GetAttribute(Attribute) and (p34.Parent and not u14[p34])))) then
        return;
    end;

    local v35 = makeGlass(MarbleBall.ballDiameter());
    local v36, v37;

    if p33 == LocalPlayer then
        v36 = nil;
        v37 = nil;
    else
        v36, v37 = makeTag(v35, p33);
    end;

    u14[p34] = {
        ready = false,
        offset = 0,
        chatUntil = 0,
        owner = p33,
        character = p34,
        root = HumanoidRootPart,
        humanoid = p34:FindFirstChildOfClass("Humanoid"),
        joints = {},
        glass = v35,
        tag = v36,
        chat = v37,
        cleanups = { MarbleBall.prepareBody(p34, nil) }
    };

    if p33 == LocalPlayer then
        enterLocal(p34);
    end;
end;

local function watch(u38: userdata) -- Line: 390
    -- upvalues: untrack (copy), Attribute (copy), track (copy), Players (copy)
    local u39 = nil;
    local u40 = {};

    local function drop() -- Line: 393
        -- upvalues: u40 (copy), u39 (ref), untrack (ref)
        for _, v in u40 do
            v:Disconnect();
        end;

        table.clear(u40);

        if u39 then
            untrack(u39);
            u39 = nil;
        end;
    end;

    local function onCharacter(u41: userdata) -- Line: 403
        -- upvalues: u39 (ref), u40 (copy), untrack (ref), Attribute (ref), track (ref), u38 (copy)
        if u39 == u41 then
            return;
        end;

        for _, v in u40 do
            v:Disconnect();
        end;

        table.clear(u40);

        if u39 then
            untrack(u39);
            u39 = nil;
        end;

        u39 = u41;

        local function update() -- Line: 409
            -- upvalues: u39 (ref), u41 (copy), Attribute (ref), track (ref), u38 (ref), untrack (ref)
            if u39 ~= u41 then
                return;
            end;

            if u41.Parent and u41:GetAttribute(Attribute) then
                track(u38, u41);

                return;
            end;

            untrack(u41);
        end;

        local AttributeChangedSignal = u41:GetAttributeChangedSignal(Attribute);
        table.insert(u40, AttributeChangedSignal:Connect(update));
        table.insert(u40, u41.AncestryChanged:Connect(update));
        table.insert(u40, u41.Destroying:Connect(function() -- Line: 421
            -- upvalues: u39 (ref), u41 (copy), u40 (ref), untrack (ref)
            if u39 == u41 then
                for _, v in u40 do
                    v:Disconnect();
                end;

                table.clear(u40);

                if u39 then
                    untrack(u39);
                    u39 = nil;
                end;
            end;
        end));

        if u39 ~= u41 then
            return;
        end;

        if u41.Parent and u41:GetAttribute(Attribute) then
            track(u38, u41);

            return;
        end;

        untrack(u41);
    end;

    if u38.Character then
        task.spawn(onCharacter, u38.Character);
    end;

    local u42 = u38.CharacterAdded:Connect(onCharacter);
    local u43 = nil;
    u43 = Players.PlayerRemoving:Connect(function(p44) -- Line: 433
        -- upvalues: u38 (copy), u40 (copy), u39 (ref), untrack (ref), u42 (copy), u43 (ref)
        if p44 == u38 then
            for _, v in u40 do
                v:Disconnect();
            end;

            table.clear(u40);

            if u39 then
                untrack(u39);
                u39 = nil;
            end;

            u42:Disconnect();
            u43:Disconnect();
        end;
    end);
end;

local function getReady(p45: table) -- Line: 375
    -- upvalues: MarbleBall (copy)
    if p45.ready or not p45.character:GetAttribute(MarbleBall.ScaleAttribute) then
        return;
    end;

    p45.ready = true;
    p45.offset = MarbleBall.measure(p45.character, p45.root);

    for _, descendant in p45.character:GetDescendants() do
        if descendant:IsA("Motor6D") and descendant.Part0 == p45.root then
            table.insert(p45.joints, {
                joint = descendant,
                c0 = descendant.C0
            });
        end;
    end;

    table.insert(p45.cleanups, MarbleBall.hideAdded(p45.character));
end;

for _, v in Players:GetPlayers() do
    task.spawn(watch, v);
end;

Players.PlayerAdded:Connect(watch);
local CFrame_identity = CFrame.identity;
local u46 = nil;
local u47 = Vector3.new(0, 0, 0);
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;

local function roll(p48: vector, p49: number, p50: number) -- Line: 454
    -- upvalues: u46 (ref), u47 (ref), RaycastParams_new_ret (copy), CFrame_identity (ref)
    local v51 = u46;
    u46 = p48;

    if not v51 or p50 <= 0 then
        return;
    end;

    local v52 = p48 - v51;

    if v52.Magnitude > 30 then
        u47 = Vector3.new(0, 0, 0);

        return;
    end;

    local characters = workspace:FindFirstChild("characters");
    RaycastParams_new_ret.FilterDescendantsInstances = characters and { characters } or {};
    local v53 = workspace:Raycast(p48, Vector3.new(0, -(p49 + 0.5), 0), RaycastParams_new_ret) ~= nil;
    local Vector3_new_ret = Vector3.new(v52.X, 0, v52.Z);

    if v53 then
        if Vector3_new_ret.Magnitude > 0.0001 then
            local Unit = (Vector3.new(0, 1, 0)):Cross(Vector3_new_ret).Unit;
            local v54 = Vector3_new_ret.Magnitude / p49;
            CFrame_identity = CFrame.fromAxisAngle(Unit, v54) * CFrame_identity;
            u47 = Unit * (v54 / p50);
        else
            u47 = Vector3.new(0, 0, 0);
        end;
    else
        u47 = u47 * math.exp(p50 * -0.6);
        local Magnitude = u47.Magnitude;

        if Magnitude > 0.001 then
            CFrame_identity = CFrame.fromAxisAngle(u47.Unit, Magnitude * p50) * CFrame_identity;
        end;
    end;

    CFrame_identity = CFrame_identity:Orthonormalize();
end;

local function place(p55: vector, p56: boolean, p57: number) -- Line: 492
    -- upvalues: CFrame_identity (ref), u14 (copy), getReady (copy), LocalPlayer (copy), Config (copy)
    local CFrame_new_ret2 = CFrame.new(p55);
    local v58 = CFrame_new_ret2 * CFrame_identity;
    local CFrame_new_ret3 = CFrame.new(p55 + Vector3.new(0, 1, 0) * (p57 + 0.3));

    for _, v in u14 do
        getReady(v);
        local root = v.root;
        local v59;

        if root.Parent then
            if not root.Anchored then
                root.Anchored = true;
            end;

            if p56 and v.ready then
                if #v.joints > 0 then
                    root.CFrame = CFrame_new_ret3;
                    local v60 = CFrame_new_ret3:ToObjectSpace(v58 * CFrame.new(0, v.offset, 0));
                    v59 = v;

                    for _, v2 in v.joints do
                        v2.joint.C0 = v60 * v2.c0;
                    end;
                else
                    root.CFrame = v58 * CFrame.new(0, v.offset, 0);
                    v59 = v;
                end;
            else
                root.CFrame = CFrame.new(p55 - Vector3.new(0, 2000, 0));
                v59 = v;
            end;
        else
            v59 = v;
        end;

        if v59.owner == LocalPlayer then
            local humanoid = v59.humanoid;

            if humanoid and (humanoid.Parent == v59.character and not humanoid.PlatformStand) then
                humanoid.PlatformStand = true;
            end;
        end;

        v59.glass.CFrame = CFrame_new_ret2;
        v59.glass.Transparency = not p56 and 1 or Config.Transparency;

        if v59.tag then
            v59.tag.Enabled = p56;
        end;
    end;
end;

local function followGlass() -- Line: 532
    -- upvalues: u14 (copy), LocalPlayer (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera or workspace_CurrentCamera.CameraType ~= Enum.CameraType.Custom then
        return;
    end;

    for _, v in u14 do
        if v.owner == LocalPlayer then
            local CameraSubject = workspace_CurrentCamera.CameraSubject;

            if CameraSubject ~= v.glass and (CameraSubject == nil or (CameraSubject == v.character or CameraSubject:IsDescendantOf(v.character))) then
                workspace_CurrentCamera.CameraSubject = v.glass;
            end;
        end;
    end;
end;

local u61 = setmetatable({}, {
    __mode = "k"
});

local function hide(p62: userdata?) -- Line: 550
    -- upvalues: u61 (copy)
    if p62 and p62:IsA("BasePart") then
        if p62.LocalTransparencyModifier ~= 1 then
            p62.LocalTransparencyModifier = 1;
        end;

        u61[p62] = true;
    end;
end;

local function hideSoccerBall() -- Line: 559
    -- upvalues: u3 (copy), u61 (copy), workspace2 (copy)
    for i in u3 do
        if i and i:IsA("BasePart") then
            if i.LocalTransparencyModifier ~= 1 then
                i.LocalTransparencyModifier = 1;
            end;

            u61[i] = true;
        end;
    end;

    local v63 = workspace2 and workspace2:FindFirstChild("ballHolder");

    if v63 then
        v63 = v63.Value;
    end;

    if v63 and v63:IsA("Model") then
        local Ball = v63:FindFirstChild("Ball");

        if Ball and Ball:IsA("BasePart") then
            if Ball.LocalTransparencyModifier ~= 1 then
                Ball.LocalTransparencyModifier = 1;
            end;

            u61[Ball] = true;
        end;

        local AlternateBallRig = v63:FindFirstChild("AlternateBallRig");

        if AlternateBallRig then
            local Ball2 = AlternateBallRig:FindFirstChild("Ball");

            if Ball2 and Ball2:IsA("BasePart") then
                if Ball2.LocalTransparencyModifier ~= 1 then
                    Ball2.LocalTransparencyModifier = 1;
                end;

                u61[Ball2] = true;
            end;
        end;
    end;
end;

local function showSoccerBall() -- Line: 574
    -- upvalues: u61 (copy)
    for i in u61 do
        if i.Parent then
            i.LocalTransparencyModifier = 0;
        end;
    end;

    table.clear(u61);
end;

local u64 = nil;
local u65 = true;
RunService:BindToRenderStep("MarbleBallGlue", Enum.RenderPriority.Camera.Value - 1, function(p66: number) -- Line: 586
    -- upvalues: u14 (copy), u64 (ref), u46 (ref), drawnBall (copy), u65 (ref), MarbleBall (copy), roll (copy), place (copy), followGlass (copy), u1 (copy)
    if not next(u14) then
        u64 = nil;
        u46 = nil;

        return;
    end;

    local v67, v68 = drawnBall();

    if not v67 then
        v67 = u64;

        if not v67 then
            local map = workspace:FindFirstChild("map");

            if map then
                map = map:FindFirstChild("centrePoint");
            end;

            v67 = not (map and map:IsA("BasePart")) and Vector3.new(0, 0, 0) or map.Position;
        end;

        v68 = u65;
    end;

    u64 = v67;
    u65 = v68;
    local v69 = MarbleBall.ballDiameter() / 2;
    roll(v67, v69, p66);
    place(v67, v68, v69);
    followGlass();
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v70 = not u1 and 100 or u1.MaxDistance;
    local os_clock_ret = os.clock();

    for _, v in u14 do
        if v.chat then
            local v71;

            if os_clock_ret < v.chatUntil and workspace_CurrentCamera ~= nil then
                v71 = v70 < (workspace_CurrentCamera.CFrame.Position - v.glass.Position).Magnitude;
            else
                v71 = false;
            end;

            v.chat.Visible = v71;
        end;
    end;
end);
RunService:BindToRenderStep("MarbleBallHideBall", Enum.RenderPriority.Last.Value, function() -- Line: 614
    -- upvalues: u14 (copy), hideSoccerBall (copy), u61 (copy)
    if next(u14) then
        hideSoccerBall();

        return;
    end;

    if next(u61) then
        for i in u61 do
            if i.Parent then
                i.LocalTransparencyModifier = 0;
            end;
        end;

        table.clear(u61);
    end;
end);
TextChatService.MessageReceived:Connect(function(p72: userdata) -- Line: 623
    -- upvalues: u14 (copy)
    local TextSource = p72.TextSource;

    if not TextSource or p72.Text == "" then
        return;
    end;

    for _, v in u14 do
        if v.chat and v.owner.UserId == TextSource.UserId then
            v.chat.Text = p72.Text;
            v.chatUntil = os.clock() + 6;
        end;
    end;
end);