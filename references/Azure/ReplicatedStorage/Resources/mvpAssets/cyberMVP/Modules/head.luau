 
 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = {};
local u5 = {};
local u6 = nil;
local u7 = { Vector3.new(1, 0, 0), Vector3.new(-1, 0, 0), Vector3.new(0, 1, 0), Vector3.new(0, -1, 0) };
local u8 = {};
local u9 = setmetatable({}, {
    __mode = "k"
});
local u10 = setmetatable({}, {
    __mode = "k"
});

local function ensureGui() -- Line: 27
    -- upvalues: u2 (ref), Players (copy), u3 (ref)
    if u2 and u2.Parent then
        return;
    end;

    local LocalPlayer = Players.LocalPlayer;
    local v11;

    if LocalPlayer then
        v11 = LocalPlayer:WaitForChild("PlayerGui");
    else
        v11 = game:GetService("CoreGui");
    end;

    u2 = Instance.new("ScreenGui");
    u2.Name = "SandevistanTrailGui";
    u2.ResetOnSpawn = false;
    u2.IgnoreGuiInset = true;
    u2.DisplayOrder = 5;
    u2.Parent = v11;
    u3 = Instance.new("Camera");
    u3.Parent = u2;
end;

local function getViewport() -- Line: 50
    -- upvalues: u8 (copy), u3 (ref)
    local table_remove_ret = table.remove(u8);

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

local function releaseViewport(p12) -- Line: 65
    -- upvalues: u8 (copy)
    p12.Visible = false;
    p12.Parent = nil;
    table.insert(u8, p12);
end;

local function getCharacterTemplate(p13) -- Line: 71
    -- upvalues: u9 (copy)
    if u9[p13] then
        return u9[p13];
    end;

    local Head = p13:FindFirstChild("Head");

    if not Head then
        return nil;
    end;

    local Archivable = p13.Archivable;
    p13.Archivable = true;
    local Model = Instance.new("Model");
    Model.Name = "HeadGhostTemplate";
    local v14 = Head:Clone();

    for _, child in ipairs(v14:GetChildren()) do
        if not (child:IsA("SpecialMesh") or (child:IsA("Decal") or child:IsA("WrapTarget"))) then
            child:Destroy();
        end;
    end;

    v14.Anchored = true;
    v14.CanCollide = false;
    v14.CanQuery = false;
    v14.CanTouch = false;
    v14.Parent = Model;
    local v15 = {};

    for _, child in ipairs(p13:GetChildren()) do
        if child:IsA("Accessory") then
            local Handle = child:FindFirstChild("Handle");

            if Handle then
                local v16 = Handle:FindFirstChildWhichIsA("Attachment");

                if v16 and Head:FindFirstChild(v16.Name) then
                    local v17 = Handle:Clone();

                    for _, child2 in ipairs(v17:GetChildren()) do
                        if not (child2:IsA("SpecialMesh") or (child2:IsA("Decal") or (child2:IsA("Texture") or child2:IsA("WrapLayer")))) then
                            child2:Destroy();
                        end;
                    end;

                    v17.Anchored = true;
                    v17.CanCollide = false;
                    v17.CanQuery = false;
                    v17.CanTouch = false;
                    v17.Parent = Model;
                    table.insert(v15, Head.CFrame:ToObjectSpace(Handle.CFrame));
                end;
            end;
        end;
    end;

    p13.Archivable = Archivable;
    local v18 = {
        model = Model,
        ghostHeadName = v14.Name,
        relCFs = v15
    };
    u9[p13] = v18;

    return v18;
end;

local function getHeadGhost(p19) -- Line: 137
    -- upvalues: u10 (copy), getCharacterTemplate (copy)
    if not u10[p19] then
        u10[p19] = {};
    end;

    local table_remove_ret = table.remove(u10[p19]);

    if table_remove_ret then
        return table_remove_ret;
    end;

    local v20 = getCharacterTemplate(p19);

    if not v20 then
        return nil;
    end;

    local v21 = v20.model:Clone();
    local v22 = v21:FindFirstChild(v20.ghostHeadName);
    local v23 = {};

    for _, child in ipairs(v21:GetChildren()) do
        if child ~= v22 and child:IsA("BasePart") then
            table.insert(v23, child);
        end;
    end;

    return {
        model = v21,
        head = v22,
        handles = v23,
        relCFs = v20.relCFs
    };
end;

local function releaseHeadGhost(p24, p25) -- Line: 164
    -- upvalues: u10 (copy)
    p25.model.Parent = nil;

    if u10[p24] then
        table.insert(u10[p24], p25);

        return;
    end;

    p25.model:Destroy();
end;

local function updateAfterimage(p26, p27) -- Line: 173
    -- upvalues: u10 (copy), u8 (copy), u7 (copy)
    if not (p26.viewport and p26.viewport.Parent) then
        return true;
    end;

    local v28 = p27 - p26.spawnTime;
    local v29 = p26.fadeDelay >= v28 and 0 or (p26.fadeDuration <= 0.01 and 1 or (v28 - p26.fadeDelay) / p26.fadeDuration);

    if v29 < 1 then
        local v30 = p26.initialOffset + v28 * p26.driftSpeed;
        local baseCFrame = p26.baseCFrame;

        for i = 1, 4 do
            local v31 = p26.ghosts[i];
            local v32 = baseCFrame * CFrame.new(u7[i] * v30);
            v31.head.CFrame = v32;
            local handles = v31.handles;
            local relCFs = v31.relCFs;
            local _ = i;

            for i2 = 1, #handles do
                handles[i2].CFrame = v32 * relCFs[i2];
                local _ = i2;
            end;
        end;

        local v33 = (p27 * p26.rainbowSpeed + p26.spawnTime) % 1;
        p26.viewport.ImageTransparency = v29;
        p26.viewport.ImageColor3 = Color3.fromHSV(v33, 1, 1);

        return false;
    end;

    local character = p26.character;
    local v34 = p26.ghosts[1];
    v34.model.Parent = nil;

    if u10[character] then
        table.insert(u10[character], v34);
    else
        v34.model:Destroy();
    end;

    local character2 = p26.character;
    local v35 = p26.ghosts[2];
    v35.model.Parent = nil;

    if u10[character2] then
        table.insert(u10[character2], v35);
    else
        v35.model:Destroy();
    end;

    local character3 = p26.character;
    local v36 = p26.ghosts[3];
    v36.model.Parent = nil;

    if u10[character3] then
        table.insert(u10[character3], v36);
    else
        v36.model:Destroy();
    end;

    local character4 = p26.character;
    local v37 = p26.ghosts[4];
    v37.model.Parent = nil;

    if u10[character4] then
        table.insert(u10[character4], v37);
    else
        v37.model:Destroy();
    end;

    local viewport = p26.viewport;
    viewport.Visible = false;
    viewport.Parent = nil;
    table.insert(u8, viewport);

    return true;
end;

local function spawnAfterimage(p38, p39, p40, p41, p42, p43) -- Line: 218
    -- upvalues: u4 (copy), u10 (copy), u8 (copy), getHeadGhost (copy), getViewport (copy), u2 (ref)
    local v44;

    if p38 then
        v44 = p38:FindFirstChild("Head");
    else
        v44 = p38;
    end;

    if not v44 then
        return;
    end;

    if #u4 >= 40 then
        local table_remove_ret = table.remove(u4, 1);
        local character = table_remove_ret.character;
        local v45 = table_remove_ret.ghosts[1];
        v45.model.Parent = nil;

        if u10[character] then
            table.insert(u10[character], v45);
        else
            v45.model:Destroy();
        end;

        local character2 = table_remove_ret.character;
        local v46 = table_remove_ret.ghosts[2];
        v46.model.Parent = nil;

        if u10[character2] then
            table.insert(u10[character2], v46);
        else
            v46.model:Destroy();
        end;

        local character3 = table_remove_ret.character;
        local v47 = table_remove_ret.ghosts[3];
        v47.model.Parent = nil;

        if u10[character3] then
            table.insert(u10[character3], v47);
        else
            v47.model:Destroy();
        end;

        local character4 = table_remove_ret.character;
        local v48 = table_remove_ret.ghosts[4];
        v48.model.Parent = nil;

        if u10[character4] then
            table.insert(u10[character4], v48);
        else
            v48.model:Destroy();
        end;

        local viewport = table_remove_ret.viewport;
        viewport.Visible = false;
        viewport.Parent = nil;
        table.insert(u8, viewport);
    end;

    local v49 = getHeadGhost(p38);
    local v50 = getHeadGhost(p38);
    local v51 = getHeadGhost(p38);
    local v52 = getHeadGhost(p38);

    if not (v49 and (v50 and (v51 and v52))) then
        return;
    end;

    local v53 = getViewport();
    v49.model.Parent = v53;
    v50.model.Parent = v53;
    v51.model.Parent = v53;
    v52.model.Parent = v53;
    v53.Parent = u2;
    local v54 = {
        viewport = v53,
        character = p38,
        ghosts = {
            v49,
            v50,
            v51,
            v52
        },
        baseCFrame = v44.CFrame,
        spawnTime = os.clock(),
        fadeDelay = p39,
        fadeDuration = p40,
        rainbowSpeed = p41,
        driftSpeed = p42,
        initialOffset = p43
    };
    table.insert(u4, v54);
end;

local function updateTrail(p55, p56) -- Line: 259
    -- upvalues: spawnAfterimage (copy)
    if p56 - p55.startTime >= p55.duration then
        return true;
    end;

    if p56 - p55.lastSpawn >= p55.frequency then
        p55.lastSpawn = p56;
        spawnAfterimage(p55.character, p55.fadeDelay, p55.fadeDuration, p55.rainbowSpeed, p55.driftSpeed, p55.initialOffset);
    end;

    return false;
end;

local function ensureLoop() -- Line: 269
    -- upvalues: u6 (ref), RunService (copy), Workspace (copy), u3 (ref), u4 (copy), updateAfterimage (copy), u5 (copy), spawnAfterimage (copy)
    if u6 then
        return;
    end;

    u6 = RunService.RenderStepped:Connect(function() -- Line: 272
        -- upvalues: Workspace (ref), u3 (ref), u4 (ref), updateAfterimage (ref), u5 (ref), spawnAfterimage (ref), u6 (ref)
        local os_clock_ret = os.clock();
        local CurrentCamera = Workspace.CurrentCamera;

        if CurrentCamera and u3 then
            u3.CFrame = CurrentCamera.CFrame;
            u3.FieldOfView = CurrentCamera.FieldOfView;
        end;

        for i = #u4, 1, -1 do
            local v57;

            if updateAfterimage(u4[i], os_clock_ret) then
                table.remove(u4, i);
                v57 = i;
            else
                v57 = i;
            end;
        end;

        for i = #u5, 1, -1 do
            local v58 = u5[i];
            local v59;

            if os_clock_ret - v58.startTime >= v58.duration then
                v59 = true;
            elseif os_clock_ret - v58.lastSpawn >= v58.frequency then
                v58.lastSpawn = os_clock_ret;
                spawnAfterimage(v58.character, v58.fadeDelay, v58.fadeDuration, v58.rainbowSpeed, v58.driftSpeed, v58.initialOffset);
                v59 = false;
            else
                v59 = false;
            end;

            local v60;

            if v59 then
                table.remove(u5, i);
                v60 = i;
            else
                v60 = i;
            end;
        end;

        if #u4 == 0 and #u5 == 0 then
            u6:Disconnect();
            u6 = nil;
        end;
    end);
end;

function v1.Trigger(p61, p62, p63, p64, p65, p66, p67, p68) -- Line: 301
    -- upvalues: ensureGui (copy), u5 (copy), u6 (ref), RunService (copy), Workspace (copy), u3 (ref), u4 (copy), updateAfterimage (copy), spawnAfterimage (copy)
    if not p61 then
        return;
    end;

    ensureGui();
    local os_clock_ret = os.clock();
    table.insert(u5, {
        character = p61,
        duration = p62,
        frequency = p63,
        fadeDelay = p64 or 0.45,
        fadeDuration = p65 or 0.1,
        rainbowSpeed = p66 or 2,
        driftSpeed = p67 or 4.5,
        initialOffset = p68 or 0.6,
        startTime = os_clock_ret,
        lastSpawn = os_clock_ret - p63
    });

    if u6 then
        return;
    end;

    u6 = RunService.RenderStepped:Connect(function() -- Line: 272
        -- upvalues: Workspace (ref), u3 (ref), u4 (ref), updateAfterimage (ref), u5 (ref), spawnAfterimage (ref), u6 (ref)
        local os_clock_ret2 = os.clock();
        local CurrentCamera = Workspace.CurrentCamera;

        if CurrentCamera and u3 then
            u3.CFrame = CurrentCamera.CFrame;
            u3.FieldOfView = CurrentCamera.FieldOfView;
        end;

        for i = #u4, 1, -1 do
            local v69;

            if updateAfterimage(u4[i], os_clock_ret2) then
                table.remove(u4, i);
                v69 = i;
            else
                v69 = i;
            end;
        end;

        for i = #u5, 1, -1 do
            local v70 = u5[i];
            local v71;

            if os_clock_ret2 - v70.startTime >= v70.duration then
                v71 = true;
            elseif os_clock_ret2 - v70.lastSpawn >= v70.frequency then
                v70.lastSpawn = os_clock_ret2;
                spawnAfterimage(v70.character, v70.fadeDelay, v70.fadeDuration, v70.rainbowSpeed, v70.driftSpeed, v70.initialOffset);
                v71 = false;
            else
                v71 = false;
            end;

            local v72;

            if v71 then
                table.remove(u5, i);
                v72 = i;
            else
                v72 = i;
            end;
        end;

        if #u4 == 0 and #u5 == 0 then
            u6:Disconnect();
            u6 = nil;
        end;
    end);
end;

return v1;