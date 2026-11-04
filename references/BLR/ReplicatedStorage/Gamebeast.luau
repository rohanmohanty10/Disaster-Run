  

local v1 = {};
local RunService = game:GetService("RunService");
require(script.Infra.Types);

local function DescribeValue(p2) -- Line: 53
    if type(p2) == "string" then
        return `"{p2}"`;
    end;

    return `{tostring(p2)} ({typeof(p2)})`;
end;

local function BooleanValidator(p3) -- Line: 60
    if type(p3) == "boolean" then
        return true;
    end;

    local v4;

    if type(p3) == "string" then
        v4 = `"{p3}"`;
    else
        v4 = `{tostring(p3)} ({typeof(p3)})`;
    end;

    return false, `Expected true or false, got {v4}.`;
end;

local function SecondsValidator(u5: number, u6: number?) -- Line: 68
    return function(p7) -- Line: 69
        -- upvalues: u5 (copy), u6 (copy)
        if type(p7) == "number" and p7 == p7 then
            if p7 < u5 then
                return false, `Expected at least {u5} seconds, got {p7}.`;
            end;

            if u6 and u6 < p7 then
                return false, `Expected at most {u6} seconds, got {p7}.`;
            end;

            return true;
        end;

        local v8;

        if type(p7) == "string" then
            v8 = `"{p7}"`;
        else
            v8 = `{tostring(p7)} ({typeof(p7)})`;
        end;

        return false, `Expected a number of seconds, got {v8}.`;
    end;
end;

local u13 = {
    sdkWarningsEnabled = {
        value = true,
        validator = BooleanValidator
    },
    includeWarningStackTrace = {
        value = false,
        validator = BooleanValidator
    },
    sdkDebugEnabled = {
        value = false,
        validator = BooleanValidator
    },
    customUrl = {
        value = nil,

        validator = function(p9) -- Line: 104, Name: validator
            if p9 == nil or type(p9) == "string" then
                return true;
            end;

            local v10;

            if type(p9) == "string" then
                v10 = `"{p9}"`;
            else
                v10 = `{tostring(p9)} ({typeof(p9)})`;
            end;

            return false, `Expected a URL string or nil, got {v10}.`;
        end
    },
    environment = {
        value = nil,

        validator = function(p11) -- Line: 113, Name: validator
            if p11 == nil or (p11 == "production" or p11 == "studio") then
                return true;
            end;

            local v12;

            if type(p11) == "string" then
                v12 = `"{p11}"`;
            else
                v12 = `{tostring(p11)} ({typeof(p11)})`;
            end;

            return false, `Expected "production", "studio" or nil, got {v12}.`;
        end
    }
};
local v14 = {
    value = 10,
    studioValue = 2
};
local u15 = 1;
local u16 = nil;

function v14.validator(p17) -- Line: 69
    -- upvalues: u15 (copy), u16 (copy)
    if type(p17) == "number" and p17 == p17 then
        if p17 < u15 then
            return false, `Expected at least {u15} seconds, got {p17}.`;
        end;

        if u16 and u16 < p17 then
            return false, `Expected at most {u16} seconds, got {p17}.`;
        end;

        return true;
    end;

    local v18;

    if type(p17) == "string" then
        v18 = `"{p17}"`;
    else
        v18 = `{tostring(p17)} ({typeof(p17)})`;
    end;

    return false, `Expected a number of seconds, got {v18}.`;
end;

u13.markerFlushRate = v14;
local v19 = {
    value = 30,
    studioValue = 5
};
local u20 = 5;
local u21 = nil;

function v19.validator(p22) -- Line: 69
    -- upvalues: u20 (copy), u21 (copy)
    if type(p22) == "number" and p22 == p22 then
        if p22 < u20 then
            return false, `Expected at least {u20} seconds, got {p22}.`;
        end;

        if u21 and u21 < p22 then
            return false, `Expected at most {u21} seconds, got {p22}.`;
        end;

        return true;
    end;

    local v23;

    if type(p22) == "string" then
        v23 = `"{p22}"`;
    else
        v23 = `{tostring(p22)} ({typeof(p22)})`;
    end;

    return false, `Expected a number of seconds, got {v23}.`;
end;

u13.statusPollRate = v19;
local v24 = {
    value = 30,
    studioValue = 10
};
local u25 = 10;
local u26 = nil;

function v24.validator(p27) -- Line: 69
    -- upvalues: u25 (copy), u26 (copy)
    if type(p27) == "number" and p27 == p27 then
        if p27 < u25 then
            return false, `Expected at least {u25} seconds, got {p27}.`;
        end;

        if u26 and u26 < p27 then
            return false, `Expected at most {u26} seconds, got {p27}.`;
        end;

        return true;
    end;

    local v28;

    if type(p27) == "string" then
        v28 = `"{p27}"`;
    else
        v28 = `{tostring(p27)} ({typeof(p27)})`;
    end;

    return false, `Expected a number of seconds, got {v28}.`;
end;

u13.assignmentRefreshRate = v24;
local v29 = {
    value = 30,
    studioValue = 10
};
local u30 = 10;
local u31 = 45;

function v29.validator(p32) -- Line: 69
    -- upvalues: u30 (copy), u31 (copy)
    if type(p32) == "number" and p32 == p32 then
        if p32 < u30 then
            return false, `Expected at least {u30} seconds, got {p32}.`;
        end;

        if u31 and u31 < p32 then
            return false, `Expected at most {u31} seconds, got {p32}.`;
        end;

        return true;
    end;

    local v33;

    if type(p32) == "string" then
        v33 = `"{p32}"`;
    else
        v33 = `{tostring(p32)} ({typeof(p32)})`;
    end;

    return false, `Expected a number of seconds, got {v33}.`;
end;

u13.serverReportRate = v29;
local u34 = {
    customUrl = true,
    environment = true
};
local u35 = {};
local u36 = {};
local u37 = false;
local u38 = false;
local u39 = false;
local u40 = RunService:IsServer();
local u41 = RunService:IsStudio();

local function GetDefaultValue(p42: table) -- Line: 164
    -- upvalues: u41 (copy)
    if u41 and p42.studioValue ~= nil then
        return p42.studioValue;
    end;

    return p42.value;
end;

local function ValidateSetting(p43: string, p44: any) -- Line: 171
    -- upvalues: u13 (copy)
    local v45 = u13[p43];

    if not v45 then
        error(`"{p43}" is not a Gamebeast SDK setting.`, 3);
    end;

    local v46, v47 = v45.validator(p44);

    if v46 == false then
        error(`The value of the Gamebeast SDK setting "{p43}" is invalid.{v47 and " " .. v47 or ""}`, 3);
    end;
end;

local function RequireModule(p48: table) -- Line: 183
    if p48.Loaded then
        return p48.Module;
    end;

    local Instance = require(p48.Instance);
    p48.Module = Instance;
    p48.Loaded = true;

    return Instance;
end;

local function AddModule(p49: userdata, p50: boolean?) -- Line: 195
    -- upvalues: u36 (copy), u35 (copy)
    if p50 then
        u36[p49.Name] = {
            Name = p49.Name,
            Instance = p49
        };

        return;
    end;

    u35[p49.Name] = {
        Loaded = false,
        Module = nil,
        Name = p49.Name,
        Instance = p49
    };
end;

local function AddModuleFolder(p51: userdata) -- Line: 213
    -- upvalues: AddModule (copy), u38 (ref), u35 (copy), u36 (copy)
    local function search(p52: userdata, p53: boolean?) -- Line: 215
        -- upvalues: AddModule (ref), search (copy)
        for _, child in ipairs(p52:GetChildren()) do
            if child:IsA("ModuleScript") then
                AddModule(child, p53);
            end;

            search(child, p53);
        end;
    end;

    search(p51:WaitForChild("Modules"));
    search(p51:WaitForChild("Public"), true);
    p51.Modules.DescendantAdded:Connect(function(p54: userdata, p55: boolean?) -- Line: 227, Name: moduleAddedLate
        -- upvalues: AddModule (ref), u38 (ref), u35 (ref)
        if p54:IsA("ModuleScript") then
            AddModule(p54, p55);

            if u38 and not p55 then
                local v56 = u35[p54.Name];

                if v56.Loaded then
                    local _ = v56.Module;

                    return;
                end;

                v56.Module = require(v56.Instance);
                v56.Loaded = true;
            end;
        end;
    end);
    p51.Public.DescendantAdded:Connect(function(p57: userdata) -- Line: 237
        -- upvalues: u36 (ref)
        if p57:IsA("ModuleScript") then
            u36[p57.Name] = {
                Name = p57.Name,
                Instance = p57
            };
        end;
    end);
end;

local function FindModule(p58: table, p59: string, p60: number?) -- Line: 242
    local v61 = tick();

    while tick() - v61 < (p60 or 5) do
        if p58[p59] then
            return p58[p59];
        end;

        task.wait();
    end;

    error("Gamebeast service \"" .. p59 .. "\" not found!");
end;

local function GetModule(p62: string) -- Line: 254
    -- upvalues: FindModule (copy), u35 (copy)
    return FindModule(u35, p62);
end;

local function GetPublicModule(p63: string) -- Line: 258
    -- upvalues: FindModule (copy), u36 (copy)
    return FindModule(u36, p63);
end;

local function StartSDK() -- Line: 262
    -- upvalues: u37 (ref), u40 (copy), AddModuleFolder (copy), AddModule (copy), FindModule (copy), u35 (copy), u13 (copy), u41 (copy), u38 (ref)
    if u37 then
        return;
    end;

    u37 = true;
    AddModuleFolder(u40 and script.Infra.Server or script.Infra.Client);
    AddModuleFolder(script.Infra.Shared);
    AddModule(script.Infra:WaitForChild("MetaData"));
    local v64 = FindModule(u35, "DataCache");
    local v65;

    if v64.Loaded then
        v65 = v64.Module;
    else
        v65 = require(v64.Instance);
        v64.Module = v65;
        v64.Loaded = true;
    end;

    local v66 = {};

    for i, v in u13 do
        local v67;

        if u41 and v.studioValue ~= nil then
            v67 = v.studioValue;
        else
            v67 = v.value;
        end;

        v66[i] = v67;
    end;

    v65:Set("Settings", v66);

    for _, v in u35 do
        if v.Loaded then
            local _ = v.Module;
        else
            v.Module = require(v.Instance);
            v.Loaded = true;
        end;
    end;

    u38 = true;
    local v68 = {};

    for _, v in u35 do
        if type(v.Module) == "table" then
            local v69 = rawget(v.Module, "Init");

            if v69 then
                local v70 = {
                    InitMethod = v69,
                    Module = v.Module,
                    Priority = rawget(v.Module, "Priority") or 0
                };
                table.insert(v68, v70);
            end;
        end;
    end;

    table.sort(v68, function(p71, p72) -- Line: 312
        return p71.Priority < p72.Priority;
    end);

    for _, v in ipairs(v68) do
        task.spawn(v.InitMethod, v.Module);
    end;
end;

function v1.GetService(p73: table, p74: string) -- Line: 331
    -- upvalues: StartSDK (copy), FindModule (copy), u36 (copy)
    StartSDK();
    local string_gsub_ret = string.gsub(p74, "Service", "");
    local v75 = FindModule(u36, string_gsub_ret);

    if v75 then
        return require(v75.Instance);
    end;

    error("Gamebeast service \"" .. string_gsub_ret .. "\" not found!");
end;

function v1.Setup(p76, p77) -- Line: 343
    -- upvalues: u40 (copy), u13 (copy), u41 (copy), ValidateSetting (copy), StartSDK (copy), FindModule (copy), u35 (copy), u39 (ref)
    if u40 == true then
        assert(p77, "Gamebeast SDK requires a setup config on the server.");
        assert(p77.key, "Gamebeast SDK requires a key to be set in the setup config.");
    end;

    if u40 == false then
        p77 = p77 or {};
        assert(p77.key == nil, "Gamebeast SDK key should not be set on the client.");
    end;

    local v78 = p77.sdkSettings or {};

    for i, v in u13 do
        if v78[i] == nil then
            local v79;

            if u41 and v.studioValue ~= nil then
                v79 = v.studioValue;
            else
                v79 = v.value;
            end;

            v78[i] = v79;
        end;

        ValidateSetting(i, v78[i]);
    end;

    StartSDK();
    local v80 = FindModule(u35, "DataCache");
    local v81;

    if v80.Loaded then
        v81 = v80.Module;
    else
        v81 = require(v80.Instance);
        v80.Module = v81;
        v80.Loaded = true;
    end;

    v81:Set("Key", p77.key);
    v81:Set("Settings", v78);
    u39 = true;
end;

function v1.UpdateSettings(p82, p83) -- Line: 377
    -- upvalues: u39 (ref), u34 (copy), ValidateSetting (copy), FindModule (copy), u35 (copy)
    local v84 = type(p83) == "table";
    assert(v84, "Gamebeast:UpdateSettings expects a table of settings.");
    assert(u39, "Gamebeast:UpdateSettings can only be used after Gamebeast:Setup().");

    for i, v in p83 do
        if u34[i] then
            error(`The Gamebeast SDK setting "{i}" can only be set in Gamebeast:Setup().`, 2);
        end;

        ValidateSetting(i, v);
    end;

    local v85 = FindModule(u35, "DataCache");
    local v86;

    if v85.Loaded then
        v86 = v85.Module;
    else
        v86 = require(v85.Instance);
        v85.Module = v86;
        v85.Loaded = true;
    end;

    local v87 = v86:Get("Settings");

    for i, v in p83 do
        v87[i] = v;
    end;
end;

return v1;