 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Packages.Signal);
local GameAnalytics = require(ReplicatedStorage.Packages.GameAnalytics);
local ABTestExperiments = require(ReplicatedStorage.Modules.ABTestExperiments);
require(ReplicatedStorage.Modules.ABTestExperiments.ABTestTypes);
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local v1 = Knit.CreateController({
    Name = "ABTestController",
    _loaded = false,
    _loadedSignal = Signal.new(),
    _remoteConfigs = {}
});

function v1._runExperiments(p2) -- Line: 39
    -- upvalues: ABTestExperiments (copy), LocalPlayer (copy)
    if not p2._remoteConfigs then
        return;
    end;

    for _, v in ABTestExperiments do
        if not v.Disabled then
            local v3 = p2._remoteConfigs[v.RemoteConfig] or v.DefaultState;
            local v4 = v.States[v3];

            if v4 and v4.Client then
                task.defer(v4.Client, LocalPlayer, v3);
            end;
        end;
    end;
end;

function v1.IsLoaded(p5) -- Line: 60
    return p5._loaded;
end;

function v1.OnLoad(p6, p7) -- Line: 65
    return p6._loadedSignal:Connect(p7);
end;

function v1.GetRemoteConfig(p8, p9) -- Line: 70
    return p8._remoteConfigs[p9], p8:IsLoaded();
end;

function v1.KnitStart(u10) -- Line: 74
    -- upvalues: GameAnalytics (copy), ReplicatedStorage (copy), HttpService (copy)
    GameAnalytics:initClient();
    ReplicatedStorage:WaitForChild("GameAnalyticsRemoteConfigs").OnClientEvent:Connect(function(p11: table?) -- Line: 78
        -- upvalues: HttpService (ref), u10 (copy)
        if typeof(p11) ~= "table" then
            return;
        end;

        local v12 = {};

        for i, v in p11 do
            local success, result = pcall(HttpService.JSONDecode, HttpService, v);

            if success then
                if result == nil then
                    result = v;
                end;
            else
                result = v;
            end;

            v12[i] = result;
        end;

        u10._remoteConfigs = v12;

        if not u10._loaded then
            u10._loaded = true;
            u10._loadedSignal:Fire(v12);
            u10:_runExperiments();
        end;
    end);
end;

return v1;