 
 

local Lighting = game:GetService("Lighting");
local v1 = {};
local _LightingPresetStorage = script:FindFirstChild("_LightingPresetStorage");

if not _LightingPresetStorage then
    _LightingPresetStorage = Instance.new("Folder");
    _LightingPresetStorage.Name = "_LightingPresetStorage";
    _LightingPresetStorage.Parent = script;
end;

local u2 = { "Ambient", "Brightness", "ClockTime", "ColorShift_Bottom", "ColorShift_Top", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "ExposureCompensation", "FogColor", "FogEnd", "FogStart", "GeographicLatitude", "GlobalShadows", "OutdoorAmbient", "ShadowSoftness", "TimeOfDay" };

local function clearChildren(p3) -- Line: 35
    for _, child in p3:GetChildren() do
        child:Destroy();
    end;
end;

function v1.Save(p4) -- Line: 41
    -- upvalues: _LightingPresetStorage (ref), u2 (copy), Lighting (copy)
    local v5;

    if type(p4) == "string" then
        v5 = p4 ~= "";
    else
        v5 = false;
    end;

    assert(v5, "Invalid preset name");
    local v6 = _LightingPresetStorage:FindFirstChild(p4);

    if v6 then
        v6:Destroy();
    end;

    local Configuration = Instance.new("Configuration");
    Configuration.Name = p4;
    local Folder = Instance.new("Folder");
    Folder.Name = "Properties";
    Folder.Parent = Configuration;

    for _, v in u2 do
        local success, result = pcall(function() -- Line: 58
            -- upvalues: Lighting (ref), v (copy)
            return Lighting[v];
        end);

        if success then
            pcall(function() -- Line: 63
                -- upvalues: Folder (copy), v (copy), result (copy)
                Folder:SetAttribute(v, result);
            end);
        end;
    end;

    local Folder2 = Instance.new("Folder");
    Folder2.Name = "Objects";
    Folder2.Parent = Configuration;

    for _, child in Lighting:GetChildren() do
        local success, result = pcall(function() -- Line: 74
            -- upvalues: child (copy)
            return child:Clone();
        end);

        if success and result then
            result.Parent = Folder2;
        end;
    end;

    Configuration.Parent = _LightingPresetStorage;

    return Configuration;
end;

function v1.Load(p7) -- Line: 88
    -- upvalues: _LightingPresetStorage (ref), u2 (copy), Lighting (copy)
    local v8 = _LightingPresetStorage:FindFirstChild(p7);
    local v9;

    if v8 then
        v9 = v8:IsA("Configuration");
    else
        v9 = v8;
    end;

    local v10 = "Lighting preset not found: " .. tostring(p7);
    assert(v9, v10);
    local Properties = v8:FindFirstChild("Properties");
    local Objects = v8:FindFirstChild("Objects");
    assert(Properties and Objects, "Preset data is incomplete");

    for _, v in u2 do
        local Attribute = Properties:GetAttribute(v);

        if Attribute ~= nil then
            pcall(function() -- Line: 103
                -- upvalues: Lighting (ref), v (copy), Attribute (copy)
                Lighting[v] = Attribute;
            end);
        end;
    end;

    for _, child in Lighting:GetChildren() do
        child:Destroy();
    end;

    for _, child in Objects:GetChildren() do
        child:Clone().Parent = Lighting;
    end;
end;

function v1.Delete(p11) -- Line: 117
    -- upvalues: _LightingPresetStorage (ref)
    local v12 = _LightingPresetStorage:FindFirstChild(p11);

    if not v12 then
        return false;
    end;

    v12:Destroy();

    return true;
end;

function v1.List() -- Line: 128
    -- upvalues: _LightingPresetStorage (ref)
    local v13 = {};

    for _, child in _LightingPresetStorage:GetChildren() do
        if child:IsA("Configuration") then
            table.insert(v13, child.Name);
        end;
    end;

    table.sort(v13);

    return v13;
end;

return v1;