  

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local script_CrowdMap1 = script.CrowdMap1;
local script_CrowdMap2 = script.CrowdMap2;
task.spawn(function() -- Line: 7
    -- upvalues: script_CrowdMap1 (copy), script_CrowdMap2 (copy), TweenService (copy)
    local v1 = {
        script_CrowdMap1.Crowd1,
        script_CrowdMap1.Crowd2,
        script_CrowdMap1.Crowd3,
        script_CrowdMap1.Crowd4,
        script_CrowdMap1.Crowd5
    };
    local v2 = {
        script_CrowdMap2.Crowd1,
        script_CrowdMap2.Crowd2,
        script_CrowdMap2.Crowd3,
        script_CrowdMap2.Crowd4,
        script_CrowdMap2.Crowd5,
        script_CrowdMap2.Crowd6,
        script_CrowdMap2.Crowd7
    };

    local function createTween(p3, p4) -- Line: 25
        -- upvalues: TweenService (ref)
        local v5 = p3.Position + Vector3.new(0, 1.5, 0);
        local u6 = TweenService:Create(p3, TweenInfo.new(math.random(45, 70) / 100, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true), {
            Position = v5
        });
        task.delay(p4, function() -- Line: 38
            -- upvalues: u6 (copy)
            u6:Play();
        end);
    end;

    local v7 = 0;

    for _, v in v1 do
        if v:IsA("MeshPart") then
            v7 = v7 + math.random(5, 15) / 10;
            createTween(v, v7);
        end;
    end;

    for _, v in v2 do
        if v:IsA("MeshPart") then
            v7 = v7 + math.random(5, 15) / 10;
            createTween(v, v7);
        end;
    end;
end);
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Maps = workspace:WaitForChild("Maps");
local u8 = {
    Map1 = true,
    Map2 = true,
    None = true
};

local function getActiveMap() -- Line: 73
    -- upvalues: Maps (copy)
    return Maps:FindFirstChildOfClass("Model") or (workspace:FindFirstChild("SoccerMap1") or (workspace:FindFirstChild("SoccerMap2") or workspace:FindFirstChild("SoccerMap3")));
end;

local function getCrowdVariant(p9) -- Line: 85
    -- upvalues: u8 (copy)
    if p9 then
        local Attribute = p9:GetAttribute("CrowdVariant");

        if u8[Attribute] then
            return Attribute;
        end;

        if p9.Name == "SoccerMap1" then
            return "Map1";
        end;

        if p9.Name == "SoccerMap3" then
            return "None";
        end;
    end;

    return "Map2";
end;

local function applyCrowd(p10) -- Line: 104
    -- upvalues: u8 (copy), script_CrowdMap1 (copy), script_CrowdMap2 (copy)
    local v11;

    if p10 then
        local Attribute = p10:GetAttribute("CrowdVariant");
        v11 = not u8[Attribute] and (p10.Name == "SoccerMap1" and "Map1" or (p10.Name == "SoccerMap3" and "None" or "Map2")) or Attribute;
    else
        v11 = "Map2";
    end;

    local v12;

    if v11 == "Map1" then
        v12 = workspace;
    else
        v12 = script;
    end;

    script_CrowdMap1.Parent = v12;
    local v13;

    if v11 == "Map2" then
        v13 = workspace;
    else
        v13 = script;
    end;

    script_CrowdMap2.Parent = v13;
end;

LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 110
    -- upvalues: Maps (copy), u8 (copy), script_CrowdMap1 (copy), script_CrowdMap2 (copy)
    local v14 = Maps:FindFirstChildOfClass("Model") or workspace:FindFirstChild("SoccerMap1") or (workspace:FindFirstChild("SoccerMap2") or workspace:FindFirstChild("SoccerMap3"));
    local v15;

    if v14 then
        local Attribute = v14:GetAttribute("CrowdVariant");
        v15 = not u8[Attribute] and (v14.Name == "SoccerMap1" and "Map1" or (v14.Name == "SoccerMap3" and "None" or "Map2")) or Attribute;
    else
        v15 = "Map2";
    end;

    local v16;

    if v15 == "Map1" then
        v16 = workspace;
    else
        v16 = script;
    end;

    script_CrowdMap1.Parent = v16;
    local v17;

    if v15 == "Map2" then
        v17 = workspace;
    else
        v17 = script;
    end;

    script_CrowdMap2.Parent = v17;
end);
Maps.ChildAdded:Connect(function(p18) -- Line: 114
    -- upvalues: u8 (copy), script_CrowdMap1 (copy), script_CrowdMap2 (copy)
    if p18:IsA("Model") then
        local v19;

        if p18 then
            local Attribute = p18:GetAttribute("CrowdVariant");
            v19 = not u8[Attribute] and (p18.Name == "SoccerMap1" and "Map1" or (p18.Name == "SoccerMap3" and "None" or "Map2")) or Attribute;
        else
            v19 = "Map2";
        end;

        local v20;

        if v19 == "Map1" then
            v20 = workspace;
        else
            v20 = script;
        end;

        script_CrowdMap1.Parent = v20;
        local v21;

        if v19 == "Map2" then
            v21 = workspace;
        else
            v21 = script;
        end;

        script_CrowdMap2.Parent = v21;
    end;
end);
local v22 = Maps:FindFirstChildOfClass("Model") or workspace:FindFirstChild("SoccerMap1") or (workspace:FindFirstChild("SoccerMap2") or workspace:FindFirstChild("SoccerMap3"));
local v23;

if v22 then
    local Attribute = v22:GetAttribute("CrowdVariant");
    v23 = not u8[Attribute] and (v22.Name == "SoccerMap1" and "Map1" or (v22.Name == "SoccerMap3" and "None" or "Map2")) or Attribute;
else
    v23 = "Map2";
end;

local v24;

if v23 == "Map1" then
    v24 = workspace;
else
    v24 = script;
end;

script_CrowdMap1.Parent = v24;
local v25;

if v23 == "Map2" then
    v25 = workspace;
else
    v25 = script;
end;

script_CrowdMap2.Parent = v25;