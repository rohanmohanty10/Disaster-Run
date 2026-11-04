  

local v1 = {};
local Players = game:GetService("Players");
local GetRemote = require(script.Parent.Parent.Parent.Shared.Modules.GetRemote);
local MetricCollector = require(script.Parent.Parent.Parent.Shared.Modules.MetricCollector);
local u2 = GetRemote("Event", "ExportClientMetrics");

function v1.Init(p3) -- Line: 32
    -- upvalues: MetricCollector (copy), Players (copy), u2 (copy)
    task.spawn(function() -- Line: 34
        -- upvalues: MetricCollector (ref), Players (ref)
        while task.wait(1) do
            MetricCollector:ReportMetric("PhysicsFps", workspace:GetRealPhysicsFPS());
            MetricCollector:ReportMetric("Ping", Players.LocalPlayer:GetNetworkPing());
        end;
    end);
    task.spawn(function() -- Line: 44
        -- upvalues: MetricCollector (ref), u2 (ref)
        while task.wait(10) do
            u2:FireServer((MetricCollector:ReadAndResetAllMetrics()));
        end;
    end);
end;

return v1;