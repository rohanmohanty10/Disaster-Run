 

 

local Session = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("Session");
local u1 = {
    volume = 0.7,
    maxDistance = 500,
    minDistance = 40,
    every = { 25, 60 },
    ring = { 140, 320 }
};
local u2 = {
    volume = 0.6,
    maxDistance = 70,
    minDistance = 6,
    every = { 3, 8 },
    near = { 15, 50 }
};
local Random_new_ret = Random.new();
local u3 = 0;

local function play(p4, p5, p6) -- Line: 23
    -- upvalues: u3 (ref), Random_new_ret (copy)
    if u3 >= 6 then
        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "Map5Ambience";
    Attachment.WorldPosition = p5;
    Attachment.Parent = workspace.Terrain;
    local Sound = Instance.new("Sound");
    Sound.SoundId = p4;
    Sound.Volume = p6.volume;
    Sound.PlaybackSpeed = Random_new_ret:NextNumber(0.94, 1.06);
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
    Sound.RollOffMinDistance = p6.minDistance;
    Sound.RollOffMaxDistance = p6.maxDistance;
    Sound.Parent = Attachment;
    u3 = u3 + 1;
    local u7 = false;

    local function finish() -- Line: 41
        -- upvalues: u7 (ref), u3 (ref), Attachment (copy)
        if not u7 then
            u7 = true;
            u3 = u3 - 1;
            Attachment:Destroy();
        end;
    end;

    Sound.Ended:Once(finish);
    task.delay(12, finish);
    Sound:Play();
end;

local function field() -- Line: 54
    local Map5 = workspace:FindFirstChild("Map5");
    local v8 = Map5 and Map5:FindFirstChild("Field") and Map5.Field:FindFirstChild("Grass");

    if v8 and v8:IsA("BasePart") then
        return v8.Position, v8.Size / 2, v8.Position.Y + v8.Size.Y / 2;
    end;

    return nil;
end;

local function listener() -- Line: 63
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
    end;

    return workspace_CurrentCamera;
end;

local function active() -- Line: 100
    -- upvalues: Session (copy)
    return Session:GetAttribute("ActiveMapId") == "Map5";
end;

local function loop(p9, p10, p11) -- Line: 104
    -- upvalues: Random_new_ret (copy), Session (copy), play (copy)
    while true do
        while true do
            task.wait(Random_new_ret:NextNumber(p9.every[1], p9.every[2]));

            if Session:GetAttribute("ActiveMapId") == "Map5" then
                break;
            end;

            Session:GetAttributeChangedSignal("ActiveMapId"):Wait();
        end;

        local v12 = p11();

        if v12 then
            play(p10[Random_new_ret:NextInteger(1, #p10)], v12, p9);
        end;
    end;
end;

task.spawn(loop, u1, { "rbxassetid://120531810756290" }, function() -- Line: 69, Name: howlSpot
    -- upvalues: field (copy), Random_new_ret (copy), u1 (copy)
    local v13, _, v14 = field();

    if not v13 then
        return nil;
    end;

    local v15 = Random_new_ret:NextNumber(0, 6.283185307179586);
    local v16 = Random_new_ret:NextNumber(u1.ring[1], u1.ring[2]);
    local v17 = v13.X + math.cos(v15) * v16;
    local v18 = v13.Z + math.sin(v15) * v16;

    return Vector3.new(v17, v14 + 6, v18);
end);
task.spawn(loop, u2, { "rbxassetid://74504271833399", "rbxassetid://87005040224768", "rbxassetid://75557634593763", "rbxassetid://74863486383666", "rbxassetid://135728369090359", "rbxassetid://103395512635319" }, function() -- Line: 80, Name: rustleSpot
    -- upvalues: field (copy), Random_new_ret (copy), u2 (copy)
    local v19, v20, v21 = field();
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
    end;

    if not (v19 and workspace_CurrentCamera) then
        return nil;
    end;

    local v22;

    if math.abs(workspace_CurrentCamera.X - v19.X) <= v20.X + 20 then
        v22 = math.abs(workspace_CurrentCamera.Z - v19.Z) <= v20.Z + 20;
    else
        v22 = false;
    end;

    local v23, v24;

    if v22 then
        local v25 = Random_new_ret:NextNumber(0, 6.283185307179586);
        local v26 = Random_new_ret:NextNumber(u2.near[1], u2.near[2]);
        v23 = workspace_CurrentCamera.X + math.cos(v25) * v26;
        v24 = workspace_CurrentCamera.Z + math.sin(v25) * v26;
    else
        v23 = v19.X + Random_new_ret:NextNumber(-v20.X, v20.X);
        v24 = v19.Z + Random_new_ret:NextNumber(-v20.Z, v20.Z);
    end;

    local math_clamp_ret = math.clamp(v23, v19.X - v20.X, v19.X + v20.X);
    local math_clamp_ret2 = math.clamp(v24, v19.Z - v20.Z, v19.Z + v20.Z);

    return Vector3.new(math_clamp_ret, v21 + 1, math_clamp_ret2);
end);