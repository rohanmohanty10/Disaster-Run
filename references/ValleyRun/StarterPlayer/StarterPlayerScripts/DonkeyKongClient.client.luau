 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local Game = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game");
local DonkeyKongEvent = Game:WaitForChild("DonkeyKongEvent");
local DonkeyKongMotion = require(Game:WaitForChild("DonkeyKongMotion"));
local u1 = nil;

local function clock() -- Line: 8
    -- upvalues: u1 (ref)
    local clock = u1.clock;
    local v2;

    if u1.paused then
        v2 = 0;
    else
        local v3 = workspace:GetServerTimeNow() - u1.serverAt;
        v2 = math.max(0, v3);
    end;

    return clock + v2;
end;

local function clear() -- Line: 11
    -- upvalues: u1 (ref)
    if u1 then
        u1.folder:Destroy();
        u1 = nil;
    end;
end;

local function spawnBarrel(p4) -- Line: 17
    -- upvalues: u1 (ref), DonkeyKongMotion (copy)
    if not u1 or u1.barrels[p4.id] then
        return;
    end;

    local v5 = game.ReplicatedStorage:WaitForChild("Barrel"):Clone();
    v5.Name = "Barrel" .. p4.id;
    local _, v6 = v5:GetBoundingBox();
    v5:ScaleTo(v5:GetScale() * (DonkeyKongMotion.Radius * 2 / math.max(v6.Y, v6.Z)));
    local v7 = v5:FindFirstChildWhichIsA("BasePart", true);

    if not v7 then
        v5:Destroy();

        return;
    end;

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
        elseif descendant:IsA("LuaSourceContainer") then
            descendant:Destroy();
        end;
    end;

    local v8 = v5:GetBoundingBox():ToObjectSpace(v5:GetPivot());
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://9125752846";
    Sound.Volume = 0.35;
    Sound.RollOffMaxDistance = 100;
    Sound.RollOffMinDistance = 5;
    Sound.Looped = true;
    Sound.PlaybackSpeed = 1.2;
    Sound.Parent = v7;
    v5.Parent = u1.folder;
    u1.barrels[p4.id] = {
        data = p4,
        model = v5,
        pivotOffset = v8,
        sound = Sound
    };
end;

local u9 = {};
table.insert(u9, DonkeyKongEvent.OnClientEvent:Connect(function(p10, p11) -- Line: 56
    -- upvalues: u1 (ref), spawnBarrel (copy)
    if p10 == "Clear" then
        if u1 and (u1.id == p11 and u1) then
            u1.folder:Destroy();
            u1 = nil;
        end;

        return;
    end;

    if type(p11) ~= "table" then
        return;
    end;

    if p10 ~= "Begin" then
        if u1 and u1.id == p11.id then
            if p10 == "Spawn" then
                spawnBarrel(p11.barrel);

                return;
            end;

            if p10 == "Clock" then
                u1.clock = p11.clock;
                u1.serverAt = p11.serverAt;
                u1.paused = p11.paused;
            end;
        end;

        return;
    end;

    if u1 then
        u1.folder:Destroy();
        u1 = nil;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "DonkeyKongBarrels";
    Folder.Parent = workspace;
    u1 = {
        lastHit = (-1 / 0),
        id = p11.id,
        origin = p11.origin,
        clock = p11.clock,
        serverAt = p11.serverAt,
        paused = p11.paused,
        folder = Folder,
        barrels = {}
    };

    for _, v in p11.barrels do
        spawnBarrel(v);
    end;
end));
table.insert(u9, RunService.RenderStepped:Connect(function() -- Line: 97
    -- upvalues: u1 (ref), LocalPlayer (copy), DonkeyKongMotion (copy), DonkeyKongEvent (copy)
    if not u1 then
        return;
    end;

    local clock2 = u1.clock;
    local v12;

    if u1.paused then
        v12 = 0;
    else
        local v13 = workspace:GetServerTimeNow() - u1.serverAt;
        v12 = math.max(0, v13);
    end;

    local v14 = clock2 + v12;
    local Character = LocalPlayer.Character;
    local v15;

    if Character then
        v15 = Character:FindFirstChild("HumanoidRootPart");
    else
        v15 = Character;
    end;

    local previous = u1.previous;
    local v16;

    if v15 then
        if LocalPlayer:GetAttribute("InMatch") == true and LocalPlayer:GetAttribute("RunState") == "Active" then
            v16 = not u1.paused;
        else
            v16 = false;
        end;
    else
        v16 = v15;
    end;

    for i, v in u1.barrels do
        local data = v.data;

        if data.expires < v14 then
            v.model:Destroy();
            u1.barrels[i] = nil;
        else
            local v17 = DonkeyKongMotion.position(u1.origin, data, v14);
            local v18 = (v14 - data.born) * data.speed / DonkeyKongMotion.Radius * 1;
            local v19 = CFrame.new(v17) * u1.origin.Rotation * CFrame.Angles(0, 0, v18) * CFrame.Angles(0, 1.5707963267948966, 0);
            v.model:PivotTo(v19 * v.pivotOffset);

            if u1.paused then
                if v.sound.Playing then
                    v.sound:Pause();
                end;
            elseif not v.sound.Playing then
                if v.sound.TimePosition > 0 then
                    v.sound:Resume();
                else
                    v.sound:Play();
                end;
            end;

            if v16 and (previous and (previous.character == Character and (v14 - previous.at > 0 and (v14 - previous.at < 0.12 and ((v15.Position - previous.position).Magnitude < 16 and (v14 - u1.lastHit > 0.18 and DonkeyKongMotion.contact(previous.position, v15.Position, DonkeyKongMotion.position(u1.origin, data, (math.max(data.born, previous.at))), v17, DonkeyKongMotion.HitRadius))))))) then
                u1.lastHit = v14;
                DonkeyKongEvent:FireServer("Hit", {
                    id = u1.id,
                    bot = data.id,
                    at = v14,
                    position = v15.Position
                });
            end;
        end;
    end;

    u1.previous = v16 and {
        at = v14,
        position = v15.Position,
        character = Character
    } or nil;
end));
local AttributeChangedSignal = Game.Session:GetAttributeChangedSignal("AdminMatchMode");
table.insert(u9, AttributeChangedSignal:Connect(function() -- Line: 162
    -- upvalues: Game (copy), DonkeyKongEvent (copy), u1 (ref)
    if Game.Session:GetAttribute("AdminMatchMode") == "DonkeyKong" then
        DonkeyKongEvent:FireServer("Sync");

        return;
    end;

    if u1 then
        u1.folder:Destroy();
        u1 = nil;
    end;
end));
DonkeyKongEvent:FireServer("Sync");
script.Destroying:Connect(function() -- Line: 171
    -- upvalues: u1 (ref), u9 (copy)
    if u1 then
        u1.folder:Destroy();
        u1 = nil;
    end;

    for _, v in u9 do
        v:Disconnect();
    end;
end);