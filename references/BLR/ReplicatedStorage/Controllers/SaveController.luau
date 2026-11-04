  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Signal = require(ReplicatedStorage.Packages.Signal);
require(ReplicatedStorage.Packages.Promise);
local ReplicaService = require(ReplicatedStorage.Shared.ReplicaService);
local _ = Players.LocalPlayer;
local v1 = Knit.CreateController({
    Name = "SaveController",
    DataLoaded = Signal.new()
});

function v1.KnitInit(u2) -- Line: 25
    -- upvalues: ReplicaService (copy), Players (copy)
    ReplicaService.ReplicaOfClassCreated(`{Players.LocalPlayer.UserId}-ClientData`, function(p3) -- Line: 26
        -- upvalues: u2 (copy)
        u2.replica = p3;
        u2.DataLoaded:Fire();
        u2._dataLoaded = true;
    end);
end;

function v1.IsLoaded(p4) -- Line: 35
    return p4._dataLoaded == true;
end;

function v1.GetValueChanged(p5: table, p6: string, p7: any) -- Line: 40
    -- upvalues: RunService (copy), Signal (copy)
    if not p5.replica then
        repeat
            RunService.Heartbeat:Wait();
        until p5.replica;
    end;

    local u8 = Signal.new();
    p5.replica:ListenToChange(string.split(p6, "."), function(p9, p10) -- Line: 49
        -- upvalues: u8 (copy)
        u8:Fire(p9, p10);
    end);

    return u8;
end;

function v1.GetValue(p11: table, p12: string) -- Line: 57
    if p11.replica then
        return p11:_getValueFromPath(p11.replica.Data, p12);
    end;

    warn("Data has not been initialized yet!");
end;

function v1.Observe(p13: table, p14: string, p15: any, p16: any) -- Line: 67
    if p16 and not p13._dataLoaded then
        p13.DataLoaded:Wait();
    end;

    local Value = p13:GetValue(p14);
    task.spawn(p15, Value);

    return p13:GetValueChanged(p14):Connect(p15);
end;

function v1._getValueFromPath(p17: table, p18: table, p19: string) -- Line: 82
    for _, v in string.split(p19, ".") do
        if p18 == nil then
            break;
        end;

        if typeof(p18) ~= "table" then
            warn("Trying to index path, but did not reach a table. Got type:", typeof(p18), "instead");

            return;
        end;

        p18 = p18[v];
    end;

    return p18;
end;

return v1;