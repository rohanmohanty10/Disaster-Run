 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local LocalPlayer = Players.LocalPlayer;
local u1 = { Enum.KeyCode.Space, Enum.KeyCode.E, Enum.KeyCode.ButtonR2 };
local u2 = { Enum.KeyCode.LeftControl, Enum.KeyCode.Q, Enum.KeyCode.ButtonL2 };
local u3 = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonL3 };
local u4 = {
    up = false,
    down = false,
    fast = false
};
local u5 = nil;
local u6 = nil;
local u7 = {
    { Enum.KeyCode.W, Vector3.new(0, 0, -1) },
    { Enum.KeyCode.Up, Vector3.new(0, 0, -1) },
    { Enum.KeyCode.S, Vector3.new(0, 0, 1) },
    { Enum.KeyCode.Down, Vector3.new(0, 0, 1) },
    { Enum.KeyCode.A, Vector3.new(-1, 0, 0) },
    { Enum.KeyCode.Left, Vector3.new(-1, 0, 0) },
    { Enum.KeyCode.D, Vector3.new(1, 0, 0) },
    { Enum.KeyCode.Right, Vector3.new(1, 0, 0) }
};
local u8 = Vector3.new(0, 0, 0);
UserInputService.InputChanged:Connect(function(p9) -- Line: 35
    -- upvalues: u8 (ref)
    if p9.KeyCode == Enum.KeyCode.Thumbstick1 then
        local Position = p9.Position;
        u8 = Vector2.new(Position.X, Position.Y).Magnitude <= 0.2 and Vector3.new(0, 0, 0) or Vector3.new(Position.X, 0, -Position.Y);
    end;
end);
UserInputService.InputEnded:Connect(function(p10) -- Line: 41
    -- upvalues: u8 (ref)
    if p10.KeyCode == Enum.KeyCode.Thumbstick1 then
        u8 = Vector3.new(0, 0, 0);
    end;
end);

local function localMove() -- Line: 46
    -- upvalues: UserInputService (copy), u7 (copy), u8 (ref)
    local v11 = Vector3.new(0, 0, 0);

    if not UserInputService:GetFocusedTextBox() then
        for _, v in u7 do
            if UserInputService:IsKeyDown(v[1]) then
                v11 = v11 + v[2];
            end;
        end;
    end;

    if v11.Magnitude == 0 then
        v11 = u8;
    end;

    return v11;
end;

local function onKey(p12, p13, p14) -- Line: 62
    -- upvalues: u1 (copy), u4 (copy), u2 (copy), u3 (copy)
    local v15 = p13 == Enum.UserInputState.Begin and true or p13 == Enum.UserInputState.Change;

    if table.find(u1, p14.KeyCode) then
        u4.up = v15;
    elseif table.find(u2, p14.KeyCode) then
        u4.down = v15;
    elseif table.find(u3, p14.KeyCode) then
        u4.fast = v15;
    end;

    return Enum.ContextActionResult.Sink;
end;

local function touchButtons() -- Line: 74
    -- upvalues: u6 (ref), UserInputService (copy), u4 (copy), LocalPlayer (copy)
    if u6 or not UserInputService.TouchEnabled then
        return;
    end;

    u6 = Instance.new("ScreenGui");
    u6.Name = "HostFlightTouch";
    u6.ResetOnSpawn = false;
    u6.DisplayOrder = 60;
    u6.Enabled = false;

    local function button(p16, p17, p18, u19) -- Line: 83
        -- upvalues: u4 (ref), u6 (ref)
        local TextButton = Instance.new("TextButton");
        TextButton.Name = p16;
        TextButton.Text = p17;
        TextButton.AnchorPoint = Vector2.new(1, 1);
        TextButton.Position = UDim2.new(1, -24, 1, p18);
        TextButton.Size = UDim2.fromOffset(64, 64);
        TextButton.BackgroundColor3 = Color3.fromRGB(15, 26, 38);
        TextButton.BackgroundTransparency = 0.2;
        TextButton.TextColor3 = Color3.fromRGB(232, 237, 228);
        TextButton.Font = Enum.Font.GothamBold;
        TextButton.TextSize = 26;
        TextButton.AutoButtonColor = true;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = TextButton;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(235, 201, 137);
        UIStroke.Transparency = 0.4;
        UIStroke.Parent = TextButton;
        TextButton.InputBegan:Connect(function(p20) -- Line: 103
            -- upvalues: u4 (ref), u19 (copy)
            if p20.UserInputType == Enum.UserInputType.Touch or p20.UserInputType == Enum.UserInputType.MouseButton1 then
                u4[u19] = true;
            end;
        end);
        TextButton.InputEnded:Connect(function(p21) -- Line: 108
            -- upvalues: u4 (ref), u19 (copy)
            if p21.UserInputType == Enum.UserInputType.Touch or p21.UserInputType == Enum.UserInputType.MouseButton1 then
                u4[u19] = false;
            end;
        end);
        TextButton.Parent = u6;
    end;

    button("Up", "▲", -230, "up");
    button("Down", "▼", -156, "down");
    u6.Parent = LocalPlayer:WaitForChild("PlayerGui");
end;

local function stop() -- Line: 121
    -- upvalues: u5 (ref), ContextActionService (copy), u4 (copy), u6 (ref)
    local v22 = u5;

    if not v22 then
        return;
    end;

    u5 = nil;
    ContextActionService:UnbindAction("CoHHostFlight");
    v22.stepped:Disconnect();
    v22.render:Disconnect();
    v22.added:Disconnect();

    for i, v in v22.collisions do
        if i.Parent then
            i.CanCollide = v;
        end;
    end;

    v22.velocity:Destroy();
    v22.align:Destroy();
    v22.attachment:Destroy();

    if v22.humanoid.Parent then
        v22.humanoid.PlatformStand = false;
        v22.humanoid:ChangeState(Enum.HumanoidStateType.Freefall);
    end;

    u4.up = false;
    u4.down = false;
    u4.fast = false;

    if u6 then
        u6.Enabled = false;
    end;
end;

local function start() -- Line: 149
    -- upvalues: LocalPlayer (copy), u5 (ref), RunService (copy), localMove (copy), u4 (copy), u1 (copy), u2 (copy), u3 (copy), ContextActionService (copy), onKey (copy), touchButtons (copy), u6 (ref)
    local Character = LocalPlayer.Character;
    local v23;

    if Character then
        v23 = Character:FindFirstChild("HumanoidRootPart");
    else
        v23 = Character;
    end;

    local u24;

    if Character then
        u24 = Character:FindFirstChildOfClass("Humanoid");
    else
        u24 = Character;
    end;

    if u5 or not (v23 and u24) then
        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "HostFlightAttachment";
    Attachment.Parent = v23;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Name = "HostFlightVelocity";
    LinearVelocity.Attachment0 = Attachment;
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Parent = v23;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Name = "HostFlightAlign";
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.Attachment0 = Attachment;
    AlignOrientation.MaxTorque = (1 / 0);
    AlignOrientation.Responsiveness = 40;
    AlignOrientation.CFrame = v23.CFrame.Rotation;
    AlignOrientation.Parent = v23;
    u24.PlatformStand = true;
    local u25 = {};
    local u26 = {};

    local function track(p27) -- Line: 178
        -- upvalues: u25 (copy), u26 (copy)
        if p27:IsA("BasePart") and u25[p27] == nil then
            u25[p27] = p27.CanCollide;
            table.insert(u26, p27);
        end;
    end;

    for _, descendant in Character:GetDescendants() do
        if descendant:IsA("BasePart") and u25[descendant] == nil then
            u25[descendant] = descendant.CanCollide;
            table.insert(u26, descendant);
        end;
    end;

    u5 = {
        humanoid = u24,
        attachment = Attachment,
        velocity = LinearVelocity,
        align = AlignOrientation,
        collisions = u25,
        added = Character.DescendantAdded:Connect(track),
        stepped = RunService.Stepped:Connect(function() -- Line: 195
            -- upvalues: u26 (copy)
            for _, v in u26 do
                v.CanCollide = false;
            end;
        end),
        render = RunService.RenderStepped:Connect(function() -- Line: 200
            -- upvalues: localMove (ref), u4 (ref), u24 (copy), LinearVelocity (copy), AlignOrientation (copy)
            local workspace_CurrentCamera = workspace.CurrentCamera;
            local v28 = localMove();
            local v29 = (u4.up and 1 or 0) - (u4.down and 1 or 0);
            local v30;

            if v28.Magnitude > 0 then
                v30 = workspace_CurrentCamera.CFrame:VectorToWorldSpace(v28);
            else
                v30 = u24.MoveDirection;
            end;

            local v31 = v30 + Vector3.new(0, 1, 0) * v29;

            if v31.Magnitude > 1 then
                v31 = v31.Unit;
            end;

            LinearVelocity.VectorVelocity = v31 * (u4.fast and 80 or 32);
            local v32 = workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1);

            if v32.Magnitude > 0.01 then
                AlignOrientation.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), v32.Unit);
            end;
        end)
    };
    local v33 = {};

    for _, v in { u1, u2, u3 } do
        for _, v2 in v do
            table.insert(v33, v2);
        end;
    end;

    ContextActionService:BindActionAtPriority("CoHHostFlight", onKey, false, Enum.ContextActionPriority.High.Value + 50, table.unpack(v33));
    touchButtons();

    if u6 then
        u6.Enabled = true;
    end;
end;

local function refresh() -- Line: 237
    -- upvalues: LocalPlayer (copy), start (copy), stop (copy)
    if LocalPlayer:GetAttribute("HostFlying") == true then
        start();

        return;
    end;

    stop();
end;

LocalPlayer:GetAttributeChangedSignal("HostFlying"):Connect(refresh);
LocalPlayer.CharacterRemoving:Connect(stop);
LocalPlayer.CharacterAdded:Connect(function() -- Line: 246
    -- upvalues: refresh (copy)
    task.defer(refresh);
end);

if LocalPlayer:GetAttribute("HostFlying") == true then
    start();
else
    stop();
end;