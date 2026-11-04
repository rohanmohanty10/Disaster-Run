 

 

local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local u1 = {};
local workspace_Terrain = workspace.Terrain;
local u2 = {
    live = "EmittedPartsUsingPart_icle",
    pool = "Part_IclesPooled",
    preview = "MotionPreview"
};
local u3 = {};
local u4 = nil;
local u5 = {};
local u6 = nil;
local u7 = nil;

local function isServerOnly() -- Line: 37
    -- upvalues: RunService (copy)
    local v8 = RunService:IsServer() and not RunService:IsClient();

    return v8;
end;

function u1.root() -- Line: 43
    -- upvalues: RunService (copy), workspace_Terrain (copy)
    local v9 = RunService:IsServer() and not RunService:IsClient();

    if v9 then
        return workspace_Terrain;
    end;

    return workspace.CurrentCamera or workspace_Terrain;
end;

function u1.screenEffectParent(p10) -- Line: 52
    -- upvalues: RunService (copy), Lighting (copy)
    if p10 ~= "Atmosphere" then
        local v11 = RunService:IsServer() and not RunService:IsClient();

        if not v11 then
            return workspace.CurrentCamera or Lighting;
        end;
    end;

    return Lighting;
end;

local function watchCamera() -- Line: 57
    -- upvalues: u4 (ref), u1 (copy)
    if u4 then
        return;
    end;

    u4 = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 59
        -- upvalues: u1 (ref)
        u1.rehome();
    end);
end;

function u1.rehome() -- Line: 66
    -- upvalues: u1 (copy), u3 (copy)
    local u12 = u1.root();

    for i, v in pairs(u3) do
        if v.Parent == nil then
            u3[i] = nil;
        elseif v.Parent ~= u12 then
            pcall(function() -- Line: 72
                -- upvalues: v (copy), u12 (copy)
                v.Parent = u12;
            end);
        end;
    end;
end;

local function ensureFolder(p13) -- Line: 79
    -- upvalues: u3 (copy), u2 (copy), u1 (copy), workspace_Terrain (copy), u4 (ref)
    local v14 = u3[p13];

    if v14 and v14.Parent then
        return v14;
    end;

    local v15 = u2[p13];
    local u16 = u1.root();
    local u17 = u16:FindFirstChild(v15) or workspace_Terrain:FindFirstChild(v15);

    if not u17 then
        u17 = Instance.new("Folder");
        u17.Name = v15;
        u17.Archivable = false;
    end;

    if u17.Parent ~= u16 then
        pcall(function() -- Line: 91
            -- upvalues: u17 (ref), u16 (copy)
            u17.Parent = u16;
        end);
    end;

    u3[p13] = u17;

    if not u4 then
        u4 = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 59
            -- upvalues: u1 (ref)
            u1.rehome();
        end);
    end;

    return u17;
end;

function u1.getFolder() -- Line: 99
    -- upvalues: ensureFolder (copy)
    return ensureFolder("live");
end;

function u1.getPoolFolder() -- Line: 104
    -- upvalues: ensureFolder (copy)
    return ensureFolder("pool");
end;

function u1.getPreviewFolder() -- Line: 109
    -- upvalues: ensureFolder (copy)
    return ensureFolder("preview");
end;

function u1.getCanvasParent() -- Line: 114
    -- upvalues: u4 (ref), u1 (copy)
    if not u4 then
        u4 = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 59
            -- upvalues: u1 (ref)
            u1.rehome();
        end);
    end;

    return u1.root();
end;

function u1.setEditAudioHost(p18) -- Line: 120
    -- upvalues: u7 (ref)
    u7 = p18;
end;

function u1.getEditAudioHost() -- Line: 125
    -- upvalues: u7 (ref)
    if u7 and u7.Parent then
        return u7;
    end;

    return nil;
end;

local function anchorCFrame(p19) -- Line: 133
    if p19:IsA("Attachment") then
        return p19.WorldCFrame;
    end;

    return p19.CFrame;
end;

local function newCarrier(p20, p21, p22, p23) -- Line: 139
    local Part = Instance.new("Part");
    Part.Name = p20;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = p21;
    Part.CFrame = p22;
    Part.Archivable = false;
    Part:SetAttribute("_PartIcleEmit", true);
    Part.Parent = p23;

    return Part;
end;

function u1.acquireCarrier(p24) -- Line: 158
    -- upvalues: u1 (copy), u5 (copy)
    local v25 = p24:IsA("BasePart") and (p24.Size or Vector3.new(1, 1, 1)) or Vector3.new(1, 1, 1);
    local v26;

    if p24:IsA("Attachment") then
        v26 = p24.WorldCFrame;
    else
        v26 = p24.CFrame;
    end;

    local Folder = u1.getFolder();
    local Part = Instance.new("Part");
    Part.Name = "_Carrier";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = v25;
    Part.CFrame = v26;
    Part.Archivable = false;
    Part:SetAttribute("_PartIcleEmit", true);
    Part.Parent = Folder;
    u5[Part] = p24;

    return Part;
end;

function u1.worldCarrier() -- Line: 169
    -- upvalues: u1 (copy), u6 (ref)
    local Folder = u1.getFolder();

    if u6 and u6.Parent == Folder then
        return u6;
    end;

    local CFrame_new_ret = CFrame.new();
    local Part = Instance.new("Part");
    Part.Name = "_WorldCarrier";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame_new_ret;
    Part.Archivable = false;
    Part:SetAttribute("_PartIcleEmit", true);
    Part.Parent = Folder;
    u6 = Part;

    return u6;
end;

function u1.releaseCarrier(u27) -- Line: 178
    -- upvalues: u5 (copy)
    if not u27 then
        return;
    end;

    u5[u27] = nil;
    pcall(function() -- Line: 181
        -- upvalues: u27 (copy)
        u27:Destroy();
    end);
end;

function u1.tick() -- Line: 186
    -- upvalues: u5 (copy)
    if next(u5) == nil then
        return;
    end;

    for i, v in pairs(u5) do
        if i.Parent == nil then
            u5[i] = nil;
        elseif v.Parent ~= nil then
            local v28;

            if v:IsA("Attachment") then
                v28 = v.WorldCFrame;
            else
                v28 = v.CFrame;
            end;

            i.CFrame = v28;
        end;
    end;
end;

function u1.reset() -- Line: 198
    -- upvalues: u4 (ref), u5 (copy), u6 (ref), u3 (copy), u2 (copy), workspace_Terrain (copy)
    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    for i in pairs(u5) do
        pcall(function() -- Line: 204
            -- upvalues: i (copy)
            i:Destroy();
        end);
    end;

    table.clear(u5);
    u6 = nil;

    for i, v in pairs(u3) do
        if v.Parent then
            pcall(function() -- Line: 209
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;

        u3[i] = nil;
    end;

    for _, v in pairs(u2) do
        local u29 = workspace_Terrain:FindFirstChild(v);

        if u29 then
            pcall(function() -- Line: 215
                -- upvalues: u29 (copy)
                u29:Destroy();
            end);
        end;
    end;
end;

return u1;