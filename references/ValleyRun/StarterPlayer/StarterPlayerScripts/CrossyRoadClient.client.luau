 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Game = ChickenOrHero:WaitForChild("Game");
local CrossyRoadEvent = Game:WaitForChild("CrossyRoadEvent");
local CrossyRoadMotion = require(Game:WaitForChild("CrossyRoadMotion"));
local AnimationConfig = require(ChickenOrHero.Animation.AnimationConfig);
local CrossyRoadChaserTemplate = Game:WaitForChild("CrossyRoadChaserTemplate");
local u1 = {
    Color3.fromRGB(237, 205, 174),
    Color3.fromRGB(221, 180, 145),
    Color3.fromRGB(170, 120, 87),
    Color3.fromRGB(116, 79, 59)
};
local u2 = {
    Color3.fromRGB(58, 102, 145),
    Color3.fromRGB(154, 63, 55),
    Color3.fromRGB(76, 117, 89),
    Color3.fromRGB(141, 104, 160)
};
local u3 = { Color3.fromRGB(39, 47, 63), Color3.fromRGB(60, 49, 43), Color3.fromRGB(44, 57, 68) };

local function recolor(p4, p5) -- Line: 24
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    local v6 = u1[(p5 - 1) % #u1 + 1];
    local v7 = u2[math.floor((p5 - 1) / #u1) % #u2 + 1];
    local v8 = u3[(p5 - 1) % #u3 + 1];
    local v9 = p4:FindFirstChildOfClass("BodyColors") or Instance.new("BodyColors");
    v9.HeadColor3 = v6;
    v9.LeftArmColor3 = v6;
    v9.RightArmColor3 = v6;
    v9.TorsoColor3 = v7;
    v9.LeftLegColor3 = v8;
    v9.RightLegColor3 = v8;
    v9.Parent = p4;

    for _, v in { "Head", "Left Arm", "Right Arm", "Torso", "Left Leg", "Right Leg" } do
        local v10 = p4:FindFirstChild(v);

        if v10 and v10:IsA("BasePart") then
            v10.Color = v == "Torso" and v7 and v7 or ((v == "Left Leg" or v == "Right Leg") and v8 and v8 or v6);
        end;
    end;
end;

local u11 = nil;

local function clear() -- Line: 44
    -- upvalues: u11 (ref)
    if not u11 then
        return;
    end;

    for _, v in u11.bots do
        if v.track then
            v.track:Destroy();
        end;
    end;

    u11.folder:Destroy();
    u11 = nil;
end;

local function clock() -- Line: 56
    -- upvalues: u11 (ref)
    local clock = u11.clock;
    local v12;

    if u11.paused then
        v12 = 0;
    else
        local v13 = workspace:GetServerTimeNow() - u11.serverAt;
        v12 = math.max(0, v13);
    end;

    return clock + v12;
end;

local function spawn(p14) -- Line: 59
    -- upvalues: u11 (ref), CrossyRoadChaserTemplate (copy), recolor (copy), CrossyRoadMotion (copy), AnimationConfig (copy)
    if u11.bots[p14.id] then
        return;
    end;

    local v15 = u11.lanes[p14.lane];

    if v15 then
        local clock2 = u11.clock;
        local v16;

        if u11.paused then
            v16 = 0;
        else
            local v17 = workspace:GetServerTimeNow() - u11.serverAt;
            v16 = math.max(0, v17);
        end;

        if clock2 + v16 <= p14.expires then
            local v18 = CrossyRoadChaserTemplate:Clone();
            v18.Name = "Chaser_" .. p14.id;
            local HumanoidRootPart = v18:FindFirstChild("HumanoidRootPart");
            local v19 = v18:FindFirstChildOfClass("Humanoid");

            if not (HumanoidRootPart and v19) then
                v18:Destroy();

                return;
            end;

            for _, descendant in v18:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = descendant == HumanoidRootPart;
                    descendant.CanCollide = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                elseif descendant:IsA("LuaSourceContainer") or (descendant:IsA("Highlight") or descendant:IsA("BillboardGui")) then
                    descendant:Destroy();
                end;
            end;

            recolor(v18, p14.id);
            v19.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            local position = CrossyRoadMotion.position;
            local clock3 = u11.clock;
            local v20;

            if u11.paused then
                v20 = 0;
            else
                local v21 = workspace:GetServerTimeNow() - u11.serverAt;
                v20 = math.max(0, v21);
            end;

            local v22 = position(v15, p14, clock3 + v20, u11.width, u11.lateral);
            v18:PivotTo(CFrame.lookAt(v22, v22 + u11.lateral * v15.direction) * HumanoidRootPart.CFrame:Inverse() * v18:GetPivot());
            v18.Parent = u11.chasers;
            local u23 = v19:FindFirstChildOfClass("Animator") or Instance.new("Animator");
            u23.Parent = v19;
            local Animation = Instance.new("Animation");
            Animation.AnimationId = AnimationConfig.PublishedIds.Walk;
            Animation.Parent = v18;
            local success, result = pcall(function() -- Line: 97
                -- upvalues: u23 (copy), Animation (copy)
                return u23:LoadAnimation(Animation);
            end);
            local math_clamp_ret = math.clamp(v15.speed / AnimationConfig.WalkReferenceSpeed, 1, 5);

            if success then
                result.Looped = true;
                result.Priority = Enum.AnimationPriority.Movement;
                result:Play(0.1, 1, u11.paused and 0 or math_clamp_ret);
            else
                result = nil;
            end;

            u11.bots[p14.id] = {
                data = p14,
                model = v18,
                root = HumanoidRootPart,
                track = result,
                rate = math_clamp_ret
            };
        end;
    end;
end;

local function syncClock(p24) -- Line: 110
    -- upvalues: u11 (ref)
    u11.clock = p24.clock;
    u11.serverAt = p24.serverAt;

    if p24.paused ~= nil then
        u11.paused = p24.paused;
    end;

    for _, v in u11.bots do
        if v.track then
            v.track:AdjustSpeed(u11.paused and 0 or v.rate);
        end;
    end;
end;

local u27 = CrossyRoadEvent.OnClientEvent:Connect(function(p25, p26) -- Line: 122
    -- upvalues: u11 (ref), clear (copy), spawn (copy), syncClock (copy)
    if p25 == "Clear" then
        if u11 and p26 == u11.id then
            clear();
        end;

        return;
    end;

    if type(p26) ~= "table" then
        return;
    end;

    if p25 ~= "Begin" then
        if u11 and p26.id == u11.id then
            if p25 == "Spawn" then
                syncClock(p26);
                spawn(p26.bot);

                return;
            end;

            if p25 == "Clock" then
                syncClock(p26);
            end;
        end;

        return;
    end;

    clear();
    local Folder = Instance.new("Folder");
    Folder.Name = "CrossyRoadLocal";
    Folder.Parent = workspace;
    local Model = Instance.new("Model");
    Model.Name = "Chasers";
    Model.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.Name = "RedHighlight";
    Highlight.Adornee = Model;
    Highlight.FillColor = Color3.fromRGB(255, 40, 40);
    Highlight.OutlineColor = Highlight.FillColor;
    Highlight.FillTransparency = 0.85;
    Highlight.OutlineTransparency = 0.3;
    Highlight.Parent = Model;
    u11 = {
        lastReport = 0,
        id = p26.id,
        lanes = p26.lanes,
        width = p26.width,
        lateral = p26.lateral,
        bots = {},
        folder = Folder,
        chasers = Model,
        clock = p26.clock,
        serverAt = p26.serverAt,
        paused = p26.paused
    };

    for _, v in p26.lanes do
        local Part = Instance.new("Part");
        Part.Name = "Lane" .. v.index;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.Size = Vector3.new(p26.width * 2, 0.04, 0.12);
        Part.CFrame = CFrame.fromMatrix(v.samples[11] + Vector3.new(0, 0.07, 0), p26.lateral, Vector3.new(0, 1, 0), -p26.across);
        Part.Material = Enum.Material.Neon;
        Part.Color = Color3.fromRGB(255, 100, 100);
        Part.Transparency = 0.8;
        Part.Parent = Folder;
    end;

    for _, v in p26.bots do
        spawn(v);
    end;
end);
local u40 = RunService.RenderStepped:Connect(function() -- Line: 188
    -- upvalues: u11 (ref), LocalPlayer (copy), Game (copy), CrossyRoadMotion (copy), CrossyRoadEvent (copy)
    if not u11 then
        return;
    end;

    local clock2 = u11.clock;
    local v28;

    if u11.paused then
        v28 = 0;
    else
        local v29 = workspace:GetServerTimeNow() - u11.serverAt;
        v28 = math.max(0, v29);
    end;

    local v30 = clock2 + v28;
    local Character = LocalPlayer.Character;
    local v31;

    if Character then
        v31 = Character:FindFirstChild("HumanoidRootPart");
    else
        v31 = Character;
    end;

    local v32;

    if Character then
        v32 = Character:FindFirstChildOfClass("Humanoid");
    else
        v32 = Character;
    end;

    local v33 = not u11.paused;

    if v33 then
        if Game.Session:GetAttribute("Phase") == "GroupRun" and (LocalPlayer:GetAttribute("InMatch") == true and (LocalPlayer:GetAttribute("GameRole") == "Runner" and LocalPlayer:GetAttribute("RunState") == "Active")) then
            if v31 then
                if v32 then
                    v32 = v32.Health > 0;
                end;
            else
                v32 = v31;
            end;
        else
            v32 = false;
        end;
    else
        v32 = v33;
    end;

    local previous = u11.previous;
    local v34;

    if v32 then
        if previous then
            if previous.character == Character and (previous.reset == Character:GetAttribute("MovementReset") and (previous.at <= v30 and v30 - previous.at <= 0.12)) then
                v34 = (v31.Position - previous.position).Magnitude <= 16;
            else
                v34 = false;
            end;
        else
            v34 = previous;
        end;
    else
        v34 = v32;
    end;

    for i, v in u11.bots do
        local v35 = u11.lanes[v.data.lane];

        if v.data.expires < v30 then
            if v.track then
                v.track:Destroy();
            end;

            v.model:Destroy();
            u11.bots[i] = nil;
        else
            local v36 = CrossyRoadMotion.position(v35, v.data, v30, u11.width, u11.lateral);
            v.model:PivotTo(CFrame.lookAt(v36, v36 + u11.lateral * v35.direction) * v.root.CFrame:Inverse() * v.model:GetPivot());

            if v32 and v30 - u11.lastReport > 0.18 then
                local v37;

                if v34 then
                    v37 = math.max(previous.at, v.data.born) or v30;
                else
                    v37 = v30;
                end;

                local v38 = CrossyRoadMotion.position(v35, v.data, v37, u11.width, u11.lateral);
                local v39 = v34 and previous.position or v31.Position;

                if CrossyRoadMotion.contact(v39, v31.Position, v38, v36, 2.8) then
                    u11.lastReport = v30;
                    CrossyRoadEvent:FireServer("Hit", {
                        id = u11.id,
                        bot = i,
                        at = v30,
                        span = v30 - v37,
                        before = v39,
                        position = v31.Position
                    });
                end;
            end;
        end;
    end;

    u11.previous = v32 and {
        at = v30,
        position = v31.Position,
        character = Character,
        reset = Character:GetAttribute("MovementReset")
    } or nil;
end);
local u41 = Game.Session:GetAttributeChangedSignal("AdminMatchMode"):Connect(function() -- Line: 254
    -- upvalues: Game (copy), clear (copy), CrossyRoadEvent (copy)
    if Game.Session:GetAttribute("AdminMatchMode") == "CrossyRoad" then
        CrossyRoadEvent:FireServer("Sync");

        return;
    end;

    clear();
end);
script.Destroying:Connect(function() -- Line: 261
    -- upvalues: u27 (copy), u40 (copy), u41 (copy), clear (copy)
    u27:Disconnect();
    u40:Disconnect();
    u41:Disconnect();
    clear();
end);
CrossyRoadEvent:FireServer("Sync");