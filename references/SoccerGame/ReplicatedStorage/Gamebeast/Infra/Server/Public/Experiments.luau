  

local v1 = {};
local InternalExperiments = require(script.Parent.Parent.Modules.InternalExperiments);
local ServerGate = require(script.Parent.Parent.Modules.ServerGate);
require(script.Parent.Parent.Parent.Types);
local u2 = {};

local function GetAssignmentsKey(p3: table) -- Line: 39
    local table_create_ret = table.create(#p3);

    for _, v in p3 do
        local v4 = `{v.experimentId}:{v.groupId}:{v.source or ""}`;
        table.insert(table_create_ret, v4);
    end;

    return table.concat(table_create_ret, ",");
end;

local function BuildAssignments(p5: userdata?) -- Line: 47
    -- upvalues: InternalExperiments (copy)
    local v6 = {};

    for _, v in InternalExperiments:GetAssignments(p5) do
        if v.status == "active" and v.groupId then
            local AssignmentMetadata = InternalExperiments:GetAssignmentMetadata(v.experimentId, v.groupId);

            if AssignmentMetadata then
                table.insert(v6, {
                    experimentId = v.experimentId,
                    experimentName = AssignmentMetadata.experimentName,
                    groupId = v.groupId,
                    groupLabel = AssignmentMetadata.groupLabel,
                    unitType = p5 and "user" or "server",
                    source = v.source
                });
            end;
        end;
    end;

    table.sort(v6, function(p7, p8) -- Line: 70
        return p7.experimentId < p8.experimentId;
    end);

    return v6;
end;

local function AssertPlayer(p9: any, p10: string) -- Line: 77
    if typeof(p9) ~= "Instance" or not p9:IsA("Player") then
        error(`Experiments:{p10} expects a Player as its first argument.`, 3);
    end;
end;

local function AssertPropertyTable(p11: any, p12: string) -- Line: 83
    if type(p11) ~= "table" then
        error(`Experiments:{p12} expects a table of properties.`, 3);
    end;
end;

function v1.SetPlayerProperties(p13: table, p14: userdata, p15: table) -- Line: 97
    -- upvalues: InternalExperiments (copy)
    if typeof(p14) ~= "Instance" or not p14:IsA("Player") then
        error("Experiments:SetPlayerProperties expects a Player as its first argument.", 3);
    end;

    if type(p15) ~= "table" then
        error("Experiments:SetPlayerProperties expects a table of properties.", 3);
    end;

    InternalExperiments:SetPlayerProperties(p14, p15);
end;

function v1.SetPlayerProperty(p16: table, p17: userdata, p18: string, p19: any) -- Line: 106
    -- upvalues: InternalExperiments (copy)
    if typeof(p17) ~= "Instance" or not p17:IsA("Player") then
        error("Experiments:SetPlayerProperty expects a Player as its first argument.", 3);
    end;

    InternalExperiments:SetPlayerProperty(p17, p18, p19);
end;

function v1.GetPlayerProperties(p20: table, p21: userdata) -- Line: 111
    -- upvalues: InternalExperiments (copy)
    if typeof(p21) ~= "Instance" or not p21:IsA("Player") then
        error("Experiments:GetPlayerProperties expects a Player as its first argument.", 3);
    end;

    return InternalExperiments:GetPlayerProperties(p21);
end;

function v1.SetServerProperties(p22: table, p23: table) -- Line: 121
    -- upvalues: InternalExperiments (copy)
    if type(p23) ~= "table" then
        error("Experiments:SetServerProperties expects a table of properties.", 3);
    end;

    InternalExperiments:SetServerProperties(p23);
end;

function v1.SetServerProperty(p24: table, p25: string, p26: any) -- Line: 129
    -- upvalues: InternalExperiments (copy)
    InternalExperiments:SetServerProperty(p25, p26);
end;

function v1.GetServerProperties(p27) -- Line: 133
    -- upvalues: InternalExperiments (copy)
    return InternalExperiments:GetServerProperties();
end;

function v1.GetAssignmentsForPlayer(p28: table, p29: userdata) -- Line: 140
    -- upvalues: BuildAssignments (copy)
    return BuildAssignments(p29);
end;

function v1.GetServerAssignments(p30) -- Line: 147
    -- upvalues: BuildAssignments (copy)
    return BuildAssignments(nil);
end;

function v1.OnAssignmentsChangedForPlayer(p31: table, u32: userdata, u33: function) -- Line: 151
    -- upvalues: InternalExperiments (copy), BuildAssignments (copy), u2 (copy)
    local v35 = InternalExperiments.OnPlayerAssignmentsChanged:Connect(function(p34: userdata) -- Line: 152
        -- upvalues: u32 (copy), u33 (copy), BuildAssignments (ref)
        if p34 == u32 then
            u33((BuildAssignments(u32)));
        end;
    end);
    local v36 = u2[u32];

    if not v36 then
        v36 = {};
        u2[u32] = v36;
    end;

    table.insert(v36, v35);

    return v35;
end;

function v1.OnServerAssignmentsChanged(p37: table, u38: function) -- Line: 169
    -- upvalues: InternalExperiments (copy), BuildAssignments (copy)
    return InternalExperiments.OnServerAssignmentsChanged:Connect(function() -- Line: 170
        -- upvalues: u38 (copy), BuildAssignments (ref)
        u38((BuildAssignments(nil)));
    end);
end;

function v1.ObserveAssignmentsForPlayer(p39: table, u40: userdata, u41: function) -- Line: 179
    -- upvalues: GetAssignmentsKey (copy), InternalExperiments (copy), BuildAssignments (copy)
    local u42 = nil;
    local u45 = p39:OnAssignmentsChangedForPlayer(u40, function(p43: table) -- Line: 183, Name: deliver
        -- upvalues: GetAssignmentsKey (ref), u42 (ref), u41 (copy)
        local v44 = GetAssignmentsKey(p43);

        if v44 == u42 then
            return;
        end;

        u42 = v44;
        u41(p43);
    end);
    InternalExperiments:OnAssignmentsResolvedForPlayer(u40, function() -- Line: 194
        -- upvalues: u45 (copy), BuildAssignments (ref), u40 (copy), GetAssignmentsKey (ref), u42 (ref), u41 (copy)
        if u45.Connected then
            local v46 = BuildAssignments(u40);
            local v47 = GetAssignmentsKey(v46);

            if v47 == u42 then
                return;
            end;

            u42 = v47;
            u41(v46);
        end;
    end);

    return u45;
end;

function v1.GetGroupForPlayer(p48: table, p49: userdata) -- Line: 208
    -- upvalues: BuildAssignments (copy)
    local v50 = BuildAssignments(p49)[1] or BuildAssignments(nil)[1];

    return v50 and {
        experimentName = v50.experimentName,
        groupName = v50.groupLabel
    } or nil;
end;

ServerGate:OnPlayerRemoved(function(p51: userdata) -- Line: 222
    -- upvalues: u2 (copy)
    local u52 = u2[p51];
    u2[p51] = nil;
    task.defer(function() -- Line: 228
        -- upvalues: u52 (copy)
        for _, v in u52 or {} do
            v:Disconnect();
        end;
    end);
end);

return v1;