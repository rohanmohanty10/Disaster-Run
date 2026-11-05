  

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local v1 = RunService:IsServer() and game.ServerStorage:WaitForChild("ServerRoot") or nil;
require(script.Types);
local Compatibility = require(script.Compatibility);
local GameData = require(ReplicatedStorage.ReplicatedRoot.Libraries.GameData);
local DirectoryUtil = require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local Promise = require(ReplicatedRoot.Libraries.Classes.Promise);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local u2 = Signal.new();
local u3 = {
    Started = false,
    GameInfo = nil,
    PlaceInfo = nil,
    Flags = nil,
    Script = script,
    Context = RunService:IsRunning() and (RunService:IsServer() and "Server" or (RunService:IsClient() and "Client" or "Unknown") or "Editor") or "Editor",
    Environment = RunService:IsStudio() and "Studio" or "Live",
    ReplicatedRoot = ReplicatedRoot,
    ReplicatedAssets = ReplicatedRoot.Assets,
    ReplicatedLibraries = ReplicatedRoot.Libraries,
    ReplicatedServices = ReplicatedRoot.Services,
    ReplicatedEvents = ReplicatedRoot.Events
};
local v4;

if v1 == nil then
    v4 = false;
else
    v4 = v1;
end;

u3.ServerRoot = v4;
local v5;

if v1 == nil then
    v5 = nil;
else
    v5 = v1.Assets or nil;
end;

u3.ServerAssets = v5;
local v6;

if v1 == nil then
    v6 = nil;
else
    v6 = v1.Libraries or nil;
end;

u3.ServerLibraries = v6;
local v7;

if v1 == nil then
    v7 = nil;
else
    v7 = v1.Services or nil;
end;

u3.ServerServices = v7;
u3.LegacyPath = Compatibility.PathShortcuts;
u3.WorldRoot = {
    Living = workspace:WaitForChild("Living"),
    Effects = workspace:WaitForChild("Effects"),
    Map = workspace:WaitForChild("Map")
};
u3.Directory = {
    Roots = { ReplicatedRoot.Assets }
};
u3.ClientServices = {};

if v1 ~= nil then
    table.insert(u3.Directory.Roots, v1.Assets);
end;

function u3.Get(p8, ...) -- Line: 77
    -- upvalues: DirectoryUtil (copy), u3 (copy)
    return DirectoryUtil.Get(p8, u3.Directory, ...);
end;

function u3.Await(p9, ...) -- Line: 84
    -- upvalues: DirectoryUtil (copy), u3 (copy)
    return DirectoryUtil.Await(p9, u3.Directory, ...);
end;

function u3.Require(p10, ...) -- Line: 91
    -- upvalues: DirectoryUtil (copy), u3 (copy)
    local v11 = DirectoryUtil.Get(p10, {
        IsA = "ModuleScript"
    }, u3.Directory, ...);

    if v11 == nil then
        return nil;
    end;

    return require(v11);
end;

function u3.GetGameInfo(p12) -- Line: 104
    -- upvalues: GameData (copy)
    if p12 == nil then
        p12 = game.GameId;
    end;

    for _, v in pairs(GameData.Games) do
        if typeof(p12) == "string" and v.Name == p12 or typeof(p12) == "number" and v.GameId == p12 then
            return v;
        end;
    end;

    return nil;
end;

function u3.GetPlaceInfo(p13, p14) -- Line: 119
    -- upvalues: u3 (copy)
    if p13 == nil then
        p13 = game.GameId;
    end;

    if p14 == nil then
        p14 = game.PlaceId;
    end;

    local v15 = u3.GetGameInfo(p13);

    if v15 ~= nil then
        for _, v in pairs(v15.Places) do
            if typeof(p14) == "string" and v.Name == p14 or typeof(p14) == "number" and v.PlaceId == p14 then
                return v;
            end;
        end;
    end;

    return nil;
end;

function u3.GetLegacyService(p16) -- Line: 140
    -- upvalues: u3 (copy)
    local Knit = require(u3.LegacyPath.KnitPath.Knit);
    local Middleware = require(u3.LegacyPath.ReplicatedModules.ReplicatedLibrary.Middleware);

    if Knit ~= nil then
        local v17 = string.find(string.lower(p16), "controller");
        local v18;

        if u3.Context == "Client" and v17 then
            v18 = Knit.GetController(p16) or nil;
        else
            v18 = nil;
        end;

        if v18 ~= nil then
            return v18;
        end;

        local v19 = Knit.GetService(p16);

        if v19 ~= nil then
            return v19;
        end;
    end;

    if Middleware then
        Middleware = Middleware.GetMiddleware(p16, 0);
    end;

    return Middleware;
end;

function u3.GetClientService(p20) -- Line: 163
    -- upvalues: u3 (copy)
    return u3.ClientServices[p20];
end;

function u3.Start() -- Line: 170
    -- upvalues: u3 (copy), u2 (copy)
    if not u3.Started then
        u3.Started = true;
        u2:Fire();
    end;
end;

function u3.OnStart() -- Line: 180
    -- upvalues: u3 (copy), Promise (copy), u2 (copy)
    if u3.Started then
        return Promise.resolve();
    end;

    return Promise.fromEvent(u2);
end;

u3.GameInfo = u3.GetGameInfo(game.GameId);
u3.PlaceInfo = u3.GetPlaceInfo(game.GameId, game.PlaceId);
u3.Flags = TableUtil.Reconcile(u3.PlaceInfo.Flags or {}, u3.GameInfo.Flags or {});

for i, v in pairs(Compatibility.Flags) do
    u3.Flags[i] = v;
end;

u3.Flags.IsStudio = u3.Environment == "Studio";
warn(u3.Flags);

return u3;