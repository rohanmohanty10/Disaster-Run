  

local v1 = {};
local GBRequests = require(script.Parent.Parent.GBRequests);
local Utilities = require(script.Parent.Parent.Utilities);
require(script.Parent.Parent.Changesets);
local u2 = {};
local u3 = {};
local u4 = {};

local function fetchActiveChangesets(p5: string) -- Line: 88
    -- upvalues: GBRequests (copy), u3 (copy), Utilities (copy), u2 (copy)
    local v6, v7, v8 = GBRequests:GBRequestAsync("v2/experiments/active", {
        ["unit-type"] = p5,
        hash = u3[p5]
    });

    if v8 == 304 then
        return true;
    end;

    if not (v6 and v7) then
        Utilities.GBWarn("Failed to fetch active experiments for unit type:", p5);

        return false;
    end;

    u3[p5] = v7.hash;

    for _, v in v7.experiments do
        local v9 = u2[v.id];
        local v10 = v9 and v9.changesetByGroupId or {};
        local v11 = v;
        local v12 = {};

        for _, v2 in v.groups do
            if not v10[v2.id] and v2.changeset then
                v10[v2.id] = v2.changeset;
            end;

            table.insert(v12, {
                id = v2.id,
                label = v2.label,
                weight = v2.weight,
                ordinal = v2.ordinal
            });
        end;

        u2[v11.id] = {
            meta = {
                id = v11.id,
                name = v11.name,
                unitType = v11.unitType,
                assignmentMode = v11.assignmentMode,
                baseConfigurationId = v11.baseConfigurationId,
                autoAssignment = v11.autoAssignment,
                permanentEnrollment = v11.permanentEnrollment,
                requiredProperties = v11.requiredProperties,
                startsAt = v11.startsAt,
                endsAt = v11.endsAt,
                groups = v12
            },
            changesetByGroupId = v10
        };
    end;

    return true;
end;

function v1.Get(p13: table, p14: number) -- Line: 146
    -- upvalues: u2 (copy)
    return u2[p14];
end;

function v1.GetUnitTypeCount(p15: table, p16: string) -- Line: 150
    -- upvalues: u2 (copy)
    local v17 = 0;

    for _, v in u2 do
        if v.meta.unitType == p16 then
            v17 = v17 + 1;
        end;
    end;

    return v17;
end;

function v1.GetRequiredPropertyUnion(p18: table, p19: string) -- Line: 164
    -- upvalues: u4 (ref), u2 (copy)
    local v20 = {};

    for _, v in u4 do
        v20[v] = true;
    end;

    for _, v in u2 do
        if v.meta.unitType == p19 then
            for _, v2 in v.meta.requiredProperties do
                v20[v2] = true;
            end;
        end;
    end;

    local v21 = {};

    for i in v20 do
        table.insert(v21, i);
    end;

    return v21;
end;

function v1.GetMetadata(p22: table, p23: number, p24: number) -- Line: 187
    -- upvalues: u2 (copy)
    local v25 = u2[p23];

    if not v25 then
        return nil;
    end;

    for _, v in v25.meta.groups do
        if v.id == p24 then
            return {
                experimentName = v25.meta.name,
                groupLabel = v.label
            };
        end;
    end;

    return nil;
end;

local function filterToCatalogued(p26: table) -- Line: 209
    -- upvalues: u2 (copy)
    local v27 = {};

    for _, v in p26 do
        if u2[v] then
            table.insert(v27, v);
        end;
    end;

    return v27;
end;

function v1.Update(p28: table, p29: table, p30: table?) -- Line: 226
    -- upvalues: u4 (ref), u2 (copy), Utilities (copy), u3 (copy), fetchActiveChangesets (copy)
    if p30 then
        u4 = p30;
    end;

    local v31 = {};
    local v32 = {};
    local v33 = {
        complete = true,
        newUserExperimentIds = {},
        newServerExperimentIds = {},
        removedExperimentIds = {}
    };

    for _, v in { "user", "server" } do
        local v34 = v;

        for _, v2 in p29[v] do
            v31[v2.id] = true;
            local v35 = u2[v2.id];

            if v35 then
                v35.meta = v2;

                for _, v3 in v2.groups do
                    if not v35.changesetByGroupId[v3.id] then
                        v32[v34] = true;
                    end;
                end;
            else
                v32[v34] = true;

                if v34 == "user" then
                    table.insert(v33.newUserExperimentIds, v2.id);
                else
                    table.insert(v33.newServerExperimentIds, v2.id);
                end;
            end;
        end;
    end;

    for i, v in u2 do
        if not v31[i] then
            Utilities.GBLog("Experiment stopped:", i);
            u3[v.meta.unitType] = nil;
            u2[i] = nil;
            table.insert(v33.removedExperimentIds, i);
        end;
    end;

    for i in v32 do
        fetchActiveChangesets(i);
    end;

    local v36 = {};

    for _, v in v33.newUserExperimentIds do
        if u2[v] then
            table.insert(v36, v);
        end;
    end;

    v33.newUserExperimentIds = v36;
    local v37 = {};

    for _, v in v33.newServerExperimentIds do
        if u2[v] then
            table.insert(v37, v);
        end;
    end;

    v33.newServerExperimentIds = v37;

    for _, v in { "user", "server" } do
        local v38 = v;

        for _, v2 in p29[v] do
            local v39 = u2[v2.id];
            local v40 = v39 == nil;

            if v39 then
                for _, v3 in v2.groups do
                    if not v39.changesetByGroupId[v3.id] then
                        v40 = true;
                    end;
                end;
            end;

            if v40 then
                v33.complete = false;
                u3[v38] = nil;
            end;
        end;
    end;

    return v33;
end;

return v1;