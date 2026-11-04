 
 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = {};
local u5 = {};
local u6 = nil;
local u7 = {};
local u8 = setmetatable({}, {
    __mode = "k"
});
local u9 = setmetatable({}, {
    __mode = "k"
});

local function ensureGui() -- Line: 21
    -- upvalues: u2 (ref), Players (copy), u3 (ref)
    if u2 and u2.Parent then
        return;
    end;

    local LocalPlayer = Players.LocalPlayer;
    local v10;

    if LocalPlayer then
        v10 = LocalPlayer:WaitForChild("PlayerGui");
    else
        v10 = game:GetService("CoreGui");
    end;

    u2 = Instance.new("ScreenGui");
    u2.Name = "SandevistanTrailGui";
    u2.ResetOnSpawn = false;
    u2.IgnoreGuiInset = true;
    u2.DisplayOrder = 1;
    u2.Parent = v10;
    u3 = Instance.new("Camera");
    u3.Parent = u2;
end;

local function getViewport() -- Line: 44
    -- upvalues: u7 (copy), u3 (ref)
    local table_remove_ret = table.remove(u7);

    if not table_remove_ret then
        table_remove_ret = Instance.new("ViewportFrame");
        table_remove_ret.Size = UDim2.new(1, 0, 1, 0);
        table_remove_ret.Position = UDim2.new(0, 0, 0, 0);
        table_remove_ret.BackgroundTransparency = 1;
        table_remove_ret.Ambient = Color3.new(1, 1, 1);
        table_remove_ret.LightColor = Color3.new(1, 1, 1);
    end;

    table_remove_ret.CurrentCamera = u3;
    table_remove_ret.Visible = true;

    return table_remove_ret;
end;

local function releaseViewport(p11) -- Line: 59
    -- upvalues: u7 (copy)
    p11.Visible = false;
    p11.Parent = nil;
    table.insert(u7, p11);
end;

local function getCharacterTemplate(p12) -- Line: 65
    -- upvalues: u8 (copy)
    if u8[p12] then
        return u8[p12];
    end;

    local Archivable = p12.Archivable;
    p12.Archivable = true;
    local Model = Instance.new("Model");
    Model.Name = "SandevistanGhostTemplate";

    for _, child in ipairs(p12:GetChildren()) do
        if child:IsA("Clothing") or (child:IsA("ShirtGraphic") or (child:IsA("BodyColors") or child:IsA("CharacterMesh"))) then
            child:Clone().Parent = Model;
        end;
    end;

    local Humanoid = Instance.new("Humanoid");
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    Humanoid.Parent = Model;
    local Descendants = p12:GetDescendants();
    local v13 = {};

    for i = 1, #Descendants do
        local v14 = Descendants[i];
        local v15;

        if v14:IsA("BasePart") and (v14.Parent.Name ~= "Cam" and v14.Transparency < 1) then
            local v16 = v14:Clone();
            local Children = v16:GetChildren();
            v15 = i;

            for i2 = 1, #Children do
                local v17 = Children[i2];
                local v18;

                if v17:IsA("SpecialMesh") or (v17:IsA("BlockMesh") or (v17:IsA("CylinderMesh") or (v17:IsA("Decal") or (v17:IsA("Texture") or (v17:IsA("WrapTarget") or (v17:IsA("WrapLayer") or v17:IsA("SurfaceAppearance"))))))) then
                    v18 = i2;
                else
                    v17:Destroy();
                    v18 = i2;
                end;
            end;

            v16.Anchored = true;
            v16.CanCollide = false;
            v16.CanQuery = false;
            v16.CanTouch = false;
            v16.Parent = Model;
            table.insert(v13, v14);
        else
            v15 = i;
        end;
    end;

    p12.Archivable = Archivable;

    if #v13 == 0 then
        Model:Destroy();

        return nil;
    end;

    local v19 = {
        model = Model,
        liveParts = v13
    };
    u8[p12] = v19;

    return v19;
end;

local function getGhost(p20) -- Line: 131
    -- upvalues: u9 (copy), getCharacterTemplate (copy)
    local v21 = u9[p20] and table.remove(u9[p20]);

    if v21 then
        return v21;
    end;

    local v22 = getCharacterTemplate(p20);

    if not v22 then
        return nil;
    end;

    local v23 = v22.model:Clone();
    local liveParts = v22.liveParts;
    local Children = v23:GetChildren();
    local v24 = {};

    for i = 1, #Children do
        local v25;

        if Children[i]:IsA("BasePart") then
            table.insert(v24, Children[i]);
            v25 = i;
        else
            v25 = i;
        end;
    end;

    local v26 = {};

    for i = 1, #liveParts do
        table.insert(v26, {
            live = liveParts[i],
            ghost = v24[i]
        });
        local _ = i;
    end;

    return {
        model = v23,
        partsMap = v26
    };
end;

local function releaseGhost(p27, p28) -- Line: 165
    -- upvalues: u9 (copy)
    p28.model.Parent = nil;

    if u9[p27] then
        table.insert(u9[p27], p28);

        return;
    end;

    p28.model:Destroy();
end;

local function updateAfterimage(p29, p30) -- Line: 174
    -- upvalues: u9 (copy), u7 (copy)
    if not (p29.viewport and p29.viewport.Parent) then
        return true;
    end;

    local v31 = p30 - p29.spawnTime;
    local v32 = p29.fadeDelay >= v31 and 0 or (p29.fadeDuration <= 0.01 and 1 or (v31 - p29.fadeDelay) / p29.fadeDuration);

    if v32 < 1 then
        local v33 = (p30 * p29.rainbowSpeed + p29.spawnTime) % 1;
        p29.viewport.ImageTransparency = v32;
        p29.viewport.ImageColor3 = Color3.fromHSV(v33, 1, 1);

        return false;
    end;

    local character = p29.character;
    local ghostData = p29.ghostData;
    ghostData.model.Parent = nil;

    if u9[character] then
        table.insert(u9[character], ghostData);
    else
        ghostData.model:Destroy();
    end;

    local viewport = p29.viewport;
    viewport.Visible = false;
    viewport.Parent = nil;
    table.insert(u7, viewport);

    return true;
end;

local function spawnAfterimage(p34, p35, p36, p37) -- Line: 201
    -- upvalues: u4 (copy), u9 (copy), u7 (copy), getGhost (copy), getViewport (copy), u2 (ref)
    local v38;

    if p34 then
        v38 = p34:FindFirstChild("HumanoidRootPart");
    else
        v38 = p34;
    end;

    if not v38 then
        return;
    end;

    if #u4 >= 25 then
        local table_remove_ret = table.remove(u4, 1);
        local character = table_remove_ret.character;
        local ghostData = table_remove_ret.ghostData;
        ghostData.model.Parent = nil;

        if u9[character] then
            table.insert(u9[character], ghostData);
        else
            ghostData.model:Destroy();
        end;

        local viewport = table_remove_ret.viewport;
        viewport.Visible = false;
        viewport.Parent = nil;
        table.insert(u7, viewport);
    end;

    local v39 = getGhost(p34);

    if not v39 then
        return;
    end;

    local partsMap = v39.partsMap;

    for i = 1, #partsMap do
        local v40 = partsMap[i];
        local v41;

        if v40.live.Parent then
            v40.ghost.CFrame = v40.live.CFrame;
            v41 = i;
        else
            v41 = i;
        end;
    end;

    local v42 = getViewport();
    v39.model.Parent = v42;
    v42.Parent = u2;
    local v43 = {
        character = p34,
        ghostData = v39,
        viewport = v42,
        spawnTime = os.clock(),
        fadeDelay = p35,
        fadeDuration = p36,
        rainbowSpeed = p37
    };
    table.insert(u4, v43);
end;

local function updateTrail(p44, p45) -- Line: 237
    -- upvalues: spawnAfterimage (copy)
    if p45 - p44.startTime >= p44.duration then
        return true;
    end;

    if p45 - p44.lastSpawn >= p44.frequency then
        p44.lastSpawn = p45;
        spawnAfterimage(p44.character, p44.fadeDelay, p44.fadeDuration, p44.rainbowSpeed);
    end;

    return false;
end;

local function ensureLoop() -- Line: 247
    -- upvalues: u6 (ref), RunService (copy), Workspace (copy), u3 (ref), u4 (copy), updateAfterimage (copy), u5 (copy), spawnAfterimage (copy)
    if u6 then
        return;
    end;

    u6 = RunService.RenderStepped:Connect(function() -- Line: 250
        -- upvalues: Workspace (ref), u3 (ref), u4 (ref), updateAfterimage (ref), u5 (ref), spawnAfterimage (ref), u6 (ref)
        local os_clock_ret = os.clock();
        local CurrentCamera = Workspace.CurrentCamera;

        if CurrentCamera and u3 then
            u3.CFrame = CurrentCamera.CFrame;
            u3.FieldOfView = CurrentCamera.FieldOfView;
        end;

        for i = #u4, 1, -1 do
            local v46;

            if updateAfterimage(u4[i], os_clock_ret) then
                table.remove(u4, i);
                v46 = i;
            else
                v46 = i;
            end;
        end;

        for i = #u5, 1, -1 do
            local v47 = u5[i];
            local v48;

            if os_clock_ret - v47.startTime >= v47.duration then
                v48 = true;
            elseif os_clock_ret - v47.lastSpawn >= v47.frequency then
                v47.lastSpawn = os_clock_ret;
                spawnAfterimage(v47.character, v47.fadeDelay, v47.fadeDuration, v47.rainbowSpeed);
                v48 = false;
            else
                v48 = false;
            end;

            local v49;

            if v48 then
                table.remove(u5, i);
                v49 = i;
            else
                v49 = i;
            end;
        end;

        if #u4 == 0 and #u5 == 0 then
            u6:Disconnect();
            u6 = nil;
        end;
    end);
end;

function v1.Trigger(p50, p51, p52, p53, p54, p55) -- Line: 278
    -- upvalues: ensureGui (copy), u5 (copy), u6 (ref), RunService (copy), Workspace (copy), u3 (ref), u4 (copy), updateAfterimage (copy), spawnAfterimage (copy)
    if not p50 then
        return;
    end;

    ensureGui();
    local os_clock_ret = os.clock();
    table.insert(u5, {
        character = p50,
        duration = p51,
        frequency = p52,
        fadeDelay = p53 or 0.15,
        fadeDuration = p54 or 0.45,
        rainbowSpeed = p55 or 0.8,
        startTime = os_clock_ret,
        lastSpawn = os_clock_ret - p52
    });

    if u6 then
        return;
    end;

    u6 = RunService.RenderStepped:Connect(function() -- Line: 250
        -- upvalues: Workspace (ref), u3 (ref), u4 (ref), updateAfterimage (ref), u5 (ref), spawnAfterimage (ref), u6 (ref)
        local os_clock_ret2 = os.clock();
        local CurrentCamera = Workspace.CurrentCamera;

        if CurrentCamera and u3 then
            u3.CFrame = CurrentCamera.CFrame;
            u3.FieldOfView = CurrentCamera.FieldOfView;
        end;

        for i = #u4, 1, -1 do
            local v56;

            if updateAfterimage(u4[i], os_clock_ret2) then
                table.remove(u4, i);
                v56 = i;
            else
                v56 = i;
            end;
        end;

        for i = #u5, 1, -1 do
            local v57 = u5[i];
            local v58;

            if os_clock_ret2 - v57.startTime >= v57.duration then
                v58 = true;
            elseif os_clock_ret2 - v57.lastSpawn >= v57.frequency then
                v57.lastSpawn = os_clock_ret2;
                spawnAfterimage(v57.character, v57.fadeDelay, v57.fadeDuration, v57.rainbowSpeed);
                v58 = false;
            else
                v58 = false;
            end;

            local v59;

            if v58 then
                table.remove(u5, i);
                v59 = i;
            else
                v59 = i;
            end;
        end;

        if #u4 == 0 and #u5 == 0 then
            u6:Disconnect();
            u6 = nil;
        end;
    end);
end;

return v1;