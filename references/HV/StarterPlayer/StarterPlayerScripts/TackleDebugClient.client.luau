 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;

while workspace:GetAttribute("ServerIsPrivate") == nil do
    workspace:GetAttributeChangedSignal("ServerIsPrivate"):Wait();
end;

local u1;

if game.PlaceId == 130574217370467 then
    u1 = workspace:GetAttribute("ServerIsPrivate") == false;
else
    u1 = false;
end;

local function visibleHitboxes() -- Line: 12
    -- upvalues: u1 (copy), LocalPlayer (copy)
    local v2;

    if workspace:GetAttribute("PrivateServerHitboxesEnabled") == true then
        v2 = true;
    else
        v2 = u1;

        if v2 then
            if LocalPlayer:GetAttribute("HitboxDebug") == true then
                v2 = LocalPlayer:GetAttribute("TestUIHidden") == false;
            else
                v2 = false;
            end;
        end;
    end;

    return v2;
end;

if not u1 and workspace:GetAttribute("ServerIsPrivate") == false then
    return;
end;

local Game = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game");
local CombatPrediction = require(Game:WaitForChild("CombatPrediction"));
CombatPrediction.start();
local HitboxDebugEvent = Game:WaitForChild("HitboxDebugEvent");
local Color3_fromRGB_ret = Color3.fromRGB(52, 230, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 142, 49);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 87, 189);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 231, 85);
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "HitboxComparison";
ScreenGui:SetAttribute("TestOnlyUI", true);
local v9;

if u1 then
    if workspace:GetAttribute("PrivateServerHitboxesEnabled") == true then
        v9 = true;
    elseif u1 then
        if LocalPlayer:GetAttribute("HitboxDebug") == true then
            v9 = LocalPlayer:GetAttribute("TestUIHidden") == false;
        else
            v9 = false;
        end;
    else
        v9 = u1;
    end;
else
    v9 = u1;
end;

ScreenGui.Enabled = v9;
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 120;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Legend";
TextLabel.AnchorPoint = Vector2.new(0, 1);
TextLabel.Position = UDim2.fromScale(0.01, 0.84);
TextLabel.Size = UDim2.fromScale(0.34, 0.06);
TextLabel.BackgroundColor3 = Color3.fromRGB(10, 18, 25);
TextLabel.BackgroundTransparency = 0.2;
TextLabel.TextColor3 = Color3.new(1, 1, 1);
TextLabel.TextScaled = true;
TextLabel.TextWrapped = true;
TextLabel.Font = Enum.Font.GothamBold;
TextLabel.Text = "CYAN CLIENT CONTACT · ORANGE VALIDATED HISTORY · WHITE RUNNER AT SWING (SERVER) · GREEN/RED HIT RESULT";
TextLabel.Parent = ScreenGui;

local function part(p10, p11, p12) -- Line: 58
    local Part = Instance.new("Part");
    Part.Name = p10;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = p11;
    Part.Transparency = p12;
    Part.Parent = workspace;

    return Part;
end;

local function clear(p13) -- Line: 72
    if p13 then
        for _, v in p13 do
            if typeof(v) == "Instance" then
                v:Destroy();
            end;
        end;
    end;
end;

local function clearAll() -- Line: 81
    -- upvalues: u8 (copy), clear (copy), u6 (copy), u3 (copy), u4 (copy), u5 (copy)
    for _, v in u8 do
        clear(v);
    end;

    table.clear(u8);

    for i, v in u6 do
        clear(v);
        u6[i] = nil;
    end;

    for i, v in u3 do
        clear(v);
        u3[i] = nil;
    end;

    for i, v in u4 do
        local v14 = v;

        for i2, v2 in v do
            clear(v2);
            v14[i2] = nil;
        end;

        u4[i] = nil;
    end;

    for i, v in u5 do
        clear(v);
        u5[i] = nil;
    end;
end;

local function frame(p15, p16, p17, p18) -- Line: 106
    local v19 = p16 * Vector3.new(1, 0, 1);

    if v19.Magnitude < 0.01 then
        return nil;
    end;

    return CFrame.lookAt(p15, p15 + v19.Unit) * CFrame.new(0, 0, -(p17 + p18) * 0.5);
end;

local function draw(p20, p21, p22) -- Line: 113
    local forwardStart = p21.forwardStart;
    local forwardEnd = p21.forwardEnd;
    local v23 = p21.direction * Vector3.new(1, 0, 1);
    local v24;

    if v23.Magnitude < 0.01 then
        v24 = nil;
    else
        v24 = CFrame.lookAt(p22, p22 + v23.Unit) * CFrame.new(0, 0, -(forwardStart + forwardEnd) * 0.5);
    end;

    if not v24 then
        return;
    end;

    p20.Size = Vector3.new(p21.width, p21.height, p21.forwardEnd - p21.forwardStart);
    p20.CFrame = v24;
end;

local function clientBox(p25, p26) -- Line: 121
    -- upvalues: u3 (copy), Color3_fromRGB_ret (copy)
    local v27 = u3[p25];

    if not v27 then
        v27 = {};
        local Part = Instance.new("Part");
        Part.Name = "Client" .. p25 .. "Hitbox";
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Material = Enum.Material.Neon;
        Part.Color = Color3_fromRGB_ret;
        Part.Transparency = 0.67;
        Part.Parent = workspace;
        v27.box = Part;
        u3[p25] = v27;
    end;

    local box = v27.box;
    local position = p26.position;
    local forwardStart = p26.forwardStart;
    local forwardEnd = p26.forwardEnd;
    local v28 = p26.direction * Vector3.new(1, 0, 1);
    local v29;

    if v28.Magnitude < 0.01 then
        v29 = nil;
    else
        v29 = CFrame.lookAt(position, position + v28.Unit) * CFrame.new(0, 0, -(forwardStart + forwardEnd) * 0.5);
    end;

    if not v29 then
        return;
    end;

    box.Size = Vector3.new(p26.width, p26.height, p26.forwardEnd - p26.forwardStart);
    box.CFrame = v29;
end;

HitboxDebugEvent.OnClientEvent:Connect(function(p30) -- Line: 130
    -- upvalues: u1 (copy), LocalPlayer (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), u8 (copy), clear (copy), u7 (ref), u4 (copy), Color3_fromRGB_ret3 (copy), u5 (copy), Color3_fromRGB_ret4 (copy)
    if type(p30) == "table" and p30.kind == "RewindContact" then
        local v31;

        if workspace:GetAttribute("PrivateServerHitboxesEnabled") == true then
            v31 = true;
        else
            v31 = u1;

            if v31 then
                if LocalPlayer:GetAttribute("HitboxDebug") == true then
                    v31 = LocalPlayer:GetAttribute("TestUIHidden") == false;
                else
                    v31 = false;
                end;
            end;
        end;

        if not v31 then
            return;
        end;

        local u32 = {
            expires = workspace:GetServerTimeNow() + 1.5
        };

        local function dot(p33, p34, p35) -- Line: 136
            -- upvalues: u32 (copy)
            if typeof(p34) == "Vector3" then
                local Part = Instance.new("Part");
                Part.Name = p33;
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanTouch = false;
                Part.CanQuery = false;
                Part.CastShadow = false;
                Part.Material = Enum.Material.Neon;
                Part.Color = p35;
                Part.Transparency = 0.2;
                Part.Parent = workspace;
                Part.Shape = Enum.PartType.Ball;
                Part.Size = Vector3.new(0.5, 0.5, 0.5);
                Part.Position = p34;
                u32[p33] = Part;

                return Part;
            end;
        end;

        local claimedTarget = p30.claimedTarget;
        local v36 = Color3_fromRGB_ret;
        local v37;

        if typeof(claimedTarget) == "Vector3" then
            v37 = Instance.new("Part");
            v37.Name = "ClaimedContact";
            v37.Anchored = true;
            v37.CanCollide = false;
            v37.CanTouch = false;
            v37.CanQuery = false;
            v37.CastShadow = false;
            v37.Material = Enum.Material.Neon;
            v37.Color = v36;
            v37.Transparency = 0.2;
            v37.Parent = workspace;
            v37.Shape = Enum.PartType.Ball;
            v37.Size = Vector3.new(0.5, 0.5, 0.5);
            v37.Position = claimedTarget;
            u32.ClaimedContact = v37;
        else
            v37 = nil;
        end;

        local rewindTarget = p30.rewindTarget;
        local v38 = Color3_fromRGB_ret2;

        if typeof(rewindTarget) == "Vector3" then
            local Part = Instance.new("Part");
            Part.Name = "ValidatedTarget";
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.CanQuery = false;
            Part.CastShadow = false;
            Part.Material = Enum.Material.Neon;
            Part.Color = v38;
            Part.Transparency = 0.2;
            Part.Parent = workspace;
            Part.Shape = Enum.PartType.Ball;
            Part.Size = Vector3.new(0.5, 0.5, 0.5);
            Part.Position = rewindTarget;
            u32.ValidatedTarget = Part;
        end;

        local serverTarget = p30.serverTarget;
        local Color3_new_ret = Color3.new(1, 1, 1);

        if typeof(serverTarget) == "Vector3" then
            local Part = Instance.new("Part");
            Part.Name = "ServerTarget";
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.CanQuery = false;
            Part.CastShadow = false;
            Part.Material = Enum.Material.Neon;
            Part.Color = Color3_new_ret;
            Part.Transparency = 0.2;
            Part.Parent = workspace;
            Part.Shape = Enum.PartType.Ball;
            Part.Size = Vector3.new(0.5, 0.5, 0.5);
            Part.Position = serverTarget;
            u32.ServerTarget = Part;
        end;

        if type(p30.box) == "table" and typeof(p30.direction) == "Vector3" then
            local v39 = {
                direction = p30.direction,
                width = p30.box.width,
                height = p30.box.height,
                forwardStart = p30.box.near,
                forwardEnd = p30.box.far
            };

            for _, v in {
                { "ClaimedStrike", p30.claimedOrigin, Color3_fromRGB_ret },
                { "ValidatedStrike", p30.rewindOrigin, Color3_fromRGB_ret2 }
            } do
                if typeof(v[2]) == "Vector3" then
                    local v40 = v[1];
                    local v41 = v[3];
                    local Part = Instance.new("Part");
                    Part.Name = v40;
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CanTouch = false;
                    Part.CanQuery = false;
                    Part.CastShadow = false;
                    Part.Material = Enum.Material.Neon;
                    Part.Color = v41;
                    Part.Transparency = 0.88;
                    Part.Parent = workspace;
                    local v42 = v[2];
                    local forwardStart = v39.forwardStart;
                    local forwardEnd = v39.forwardEnd;
                    local v43 = v39.direction * Vector3.new(1, 0, 1);
                    local v44;

                    if v43.Magnitude < 0.01 then
                        v44 = nil;
                    else
                        v44 = CFrame.lookAt(v42, v42 + v43.Unit) * CFrame.new(0, 0, -(forwardStart + forwardEnd) * 0.5);
                    end;

                    if v44 then
                        Part.Size = Vector3.new(v39.width, v39.height, v39.forwardEnd - v39.forwardStart);
                        Part.CFrame = v44;
                    end;

                    u32[v[1]] = Part;
                end;
            end;
        end;

        if v37 and u1 then
            local BillboardGui = Instance.new("BillboardGui");
            BillboardGui.Adornee = v37;
            BillboardGui.Size = UDim2.fromOffset(270, 60);
            BillboardGui.StudsOffset = Vector3.new(0, 3, 0);
            BillboardGui.AlwaysOnTop = true;
            BillboardGui.Parent = v37;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Size = UDim2.fromScale(1, 1);
            TextLabel2.BackgroundTransparency = 0.3;
            TextLabel2.BackgroundColor3 = Color3.fromRGB(10, 18, 25);
            TextLabel2.TextScaled = true;
            TextLabel2.TextWrapped = true;
            TextLabel2.TextColor3 = p30.accepted and Color3.fromRGB(100, 255, 130) or Color3.fromRGB(255, 100, 100);
            TextLabel2.Text = tostring(p30.attackKind) .. (p30.accepted and " HIT · " or " REJECTED · ") .. tostring(p30.reason or "resolved") .. "\n" .. (p30.rewindTarget and string.format("rewind %dms · runner moved %.1f studs · %.2f pose diff", math.floor((p30.rewind or 0) * 1000 + 0.5), p30.escape or 0, (p30.rewindTarget - p30.claimedTarget).Magnitude) or "no matching history");
            TextLabel2.Parent = BillboardGui;
        end;

        table.insert(u8, u32);

        while #u8 > 8 do
            clear(table.remove(u8, 1));
        end;

        return;
    end;

    if type(p30) == "table" and p30.kind == "PlayerPositions" then
        local v45 = {};

        for _, v in p30.snapshots or {} do
            if typeof(v.character) == "Instance" and (typeof(v.cf) == "CFrame" and typeof(v.size) == "Vector3") then
                v45[v.character] = v;
            end;
        end;

        u7 = v45;

        return;
    end;

    local v46;

    if type(p30) == "table" then
        v46 = typeof(p30.character) == "Instance" and p30.character;

        if not v46 then
            if type(p30.attackerId) == "number" then
                v46 = p30.attackerId or nil;
            else
                v46 = nil;
            end;
        end;
    else
        v46 = nil;
    end;

    local v47;

    if workspace:GetAttribute("PrivateServerHitboxesEnabled") == true then
        v47 = true;
    else
        v47 = u1;

        if v47 then
            if LocalPlayer:GetAttribute("HitboxDebug") == true then
                v47 = LocalPlayer:GetAttribute("TestUIHidden") == false;
            else
                v47 = false;
            end;
        end;
    end;

    if not (v47 and (type(p30) == "table" and (v46 and (typeof(p30.position) == "Vector3" and (typeof(p30.direction) == "Vector3" and type(p30.kind) == "string"))))) then
        return;
    end;

    local v48 = u4[v46];

    if not v48 then
        v48 = {};
        u4[v46] = v48;
    end;

    local v49 = v48[p30.kind];

    if not v49 then
        v49 = {};
        local v50 = "Server" .. p30.kind .. "Hitbox";
        local Part = Instance.new("Part");
        Part.Name = v50;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Material = Enum.Material.Neon;
        Part.Color = Color3_fromRGB_ret2;
        Part.Transparency = 0.65;
        Part.Parent = workspace;
        v49.box = Part;
        local v51 = "Server" .. p30.kind .. "Previous";
        local Part2 = Instance.new("Part");
        Part2.Name = v51;
        Part2.Anchored = true;
        Part2.CanCollide = false;
        Part2.CanTouch = false;
        Part2.CanQuery = false;
        Part2.CastShadow = false;
        Part2.Material = Enum.Material.Neon;
        Part2.Color = Color3_fromRGB_ret3;
        Part2.Transparency = 0.87;
        Part2.Parent = workspace;
        v49.before = Part2;
        local v52 = "Server" .. p30.kind .. "Path";
        local Part3 = Instance.new("Part");
        Part3.Name = v52;
        Part3.Anchored = true;
        Part3.CanCollide = false;
        Part3.CanTouch = false;
        Part3.CanQuery = false;
        Part3.CastShadow = false;
        Part3.Material = Enum.Material.Neon;
        Part3.Color = Color3_fromRGB_ret3;
        Part3.Transparency = 0.55;
        Part3.Parent = workspace;
        v49.path = Part3;
        v48[p30.kind] = v49;
    end;

    v49.expires = workspace:GetServerTimeNow() + 0.25;
    local box = v49.box;
    local position = p30.position;
    local forwardStart = p30.forwardStart;
    local forwardEnd = p30.forwardEnd;
    local v53 = p30.direction * Vector3.new(1, 0, 1);
    local v54;

    if v53.Magnitude < 0.01 then
        v54 = nil;
    else
        v54 = CFrame.lookAt(position, position + v53.Unit) * CFrame.new(0, 0, -(forwardStart + forwardEnd) * 0.5);
    end;

    if v54 then
        box.Size = Vector3.new(p30.width, p30.height, p30.forwardEnd - p30.forwardStart);
        box.CFrame = v54;
    end;

    local v55 = typeof(p30.from) == "Vector3" and p30.from or p30.position;
    local before = v49.before;
    local forwardStart2 = p30.forwardStart;
    local forwardEnd2 = p30.forwardEnd;
    local v56 = p30.direction * Vector3.new(1, 0, 1);
    local v57;

    if v56.Magnitude < 0.01 then
        v57 = nil;
    else
        v57 = CFrame.lookAt(v55, v55 + v56.Unit) * CFrame.new(0, 0, -(forwardStart2 + forwardEnd2) * 0.5);
    end;

    if v57 then
        before.Size = Vector3.new(p30.width, p30.height, p30.forwardEnd - p30.forwardStart);
        before.CFrame = v57;
    end;

    local v58 = p30.position - v55;
    v49.before.Transparency = v58.Magnitude > 0.15 and 0.87 or 1;
    v49.path.Transparency = v58.Magnitude > 0.15 and 0.55 or 1;

    if v58.Magnitude > 0.15 then
        v49.path.Size = Vector3.new(0.12, 0.12, v58.Magnitude);
        v49.path.CFrame = CFrame.lookAt((v55 + p30.position) * 0.5, p30.position);
    end;

    for _, v in p30.targets or {} do
        local v59;

        if type(v) == "table" then
            v59 = typeof(v.character) == "Instance" and v.character;

            if not v59 then
                if type(v.targetId) == "number" then
                    v59 = v.targetId or nil;
                else
                    v59 = nil;
                end;
            end;
        else
            v59 = nil;
        end;

        if v59 and typeof(v.position) == "Vector3" then
            local v60 = u5[v59];

            if not v60 then
                v60 = {};
                local Part = Instance.new("Part");
                Part.Name = "ServerRunnerRoot";
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanTouch = false;
                Part.CanQuery = false;
                Part.CastShadow = false;
                Part.Material = Enum.Material.Neon;
                Part.Color = Color3_fromRGB_ret4;
                Part.Transparency = 0.38;
                Part.Parent = workspace;
                v60.box = Part;
                v60.box.Shape = Enum.PartType.Ball;
                v60.box.Size = Vector3.new(1.25, 1.25, 1.25);
                u5[v59] = v60;
            end;

            v60.box.CFrame = CFrame.new(v.position);
            v60.expires = workspace:GetServerTimeNow() + 0.25;
        end;
    end;
end);
RunService.RenderStepped:Connect(function() -- Line: 275
    -- upvalues: u1 (copy), LocalPlayer (copy), ScreenGui (copy), clearAll (copy), Players (copy), u6 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), u7 (ref), clear (copy), u8 (copy), CombatPrediction (copy), clientBox (copy), u3 (copy), u4 (copy), u5 (copy)
    local v61;

    if workspace:GetAttribute("PrivateServerHitboxesEnabled") == true then
        v61 = true;
    else
        v61 = u1;

        if v61 then
            if LocalPlayer:GetAttribute("HitboxDebug") == true then
                v61 = LocalPlayer:GetAttribute("TestUIHidden") == false;
            else
                v61 = false;
            end;
        end;
    end;

    ScreenGui.Enabled = u1 and v61;

    if not v61 then
        clearAll();

        return;
    end;

    local v62 = {};

    for _, v in Players:GetPlayers() do
        local Character = v.Character;
        local v63;

        if Character then
            v63 = Character:FindFirstChild("HumanoidRootPart");
        else
            v63 = Character;
        end;

        local v64;

        if Character then
            v64 = Character:FindFirstChildOfClass("Humanoid");
        else
            v64 = Character;
        end;

        if v63 and (v64 and v64.Health > 0) then
            v62[Character] = true;
            local v65 = u6[Character];

            if not v65 then
                v65 = {};
                local Part = Instance.new("Part");
                Part.Name = "ClientPlayerRoot";
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanTouch = false;
                Part.CanQuery = false;
                Part.CastShadow = false;
                Part.Material = Enum.Material.Neon;
                Part.Color = Color3_fromRGB_ret;
                Part.Transparency = 0.8;
                Part.Parent = workspace;
                v65.client = Part;
                local Part2 = Instance.new("Part");
                Part2.Name = "ServerPlayerRoot";
                Part2.Anchored = true;
                Part2.CanCollide = false;
                Part2.CanTouch = false;
                Part2.CanQuery = false;
                Part2.CastShadow = false;
                Part2.Material = Enum.Material.Neon;
                Part2.Color = Color3_fromRGB_ret2;
                Part2.Transparency = 0.8;
                Part2.Parent = workspace;
                v65.server = Part2;
                u6[Character] = v65;

                for _, v2 in { v65.client, v65.server } do
                    local SelectionBox = Instance.new("SelectionBox");
                    SelectionBox.Adornee = v2;
                    SelectionBox.Color3 = v2.Color;
                    SelectionBox.LineThickness = 0.035;
                    SelectionBox.SurfaceTransparency = 1;
                    SelectionBox.Parent = v2;
                end;
            end;

            v65.client.CFrame = v63.CFrame;
            v65.client.Size = v63.Size;
            local v66 = u7[Character];
            v65.server.Transparency = v66 and 0.8 or 1;
            v65.server.SelectionBox.Visible = v66 ~= nil;

            if v66 then
                v65.server.CFrame = v66.cf;
                v65.server.Size = v66.size;
            end;
        end;
    end;

    for i, v in u6 do
        if not v62[i] then
            clear(v);
            u6[i] = nil;
        end;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    for i = #u8, 1, -1 do
        local v67;

        if u8[i].expires < ServerTimeNow then
            clear(table.remove(u8, i));
            v67 = i;
        else
            v67 = i;
        end;
    end;

    local v68 = {};

    for _, v in CombatPrediction.debugAttacks() or {} do
        v68[v.kind] = true;
        clientBox(v.kind, v);
    end;

    for i, v in u3 do
        if not v68[i] then
            clear(v);
            u3[i] = nil;
        end;
    end;

    for i, v in u4 do
        local v69 = v;
        local v70 = i;

        for i2, v2 in v do
            if v2.expires < ServerTimeNow or typeof(v70) == "Instance" and not v70.Parent then
                clear(v2);
                v69[i2] = nil;
            end;
        end;

        if not next(v69) then
            u4[v70] = nil;
        end;
    end;

    for i, v in u5 do
        if v.expires < ServerTimeNow or typeof(i) == "Instance" and not i.Parent then
            clear(v);
            u5[i] = nil;
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 357
    -- upvalues: clearAll (copy), ScreenGui (copy)
    clearAll();
    ScreenGui:Destroy();
end);