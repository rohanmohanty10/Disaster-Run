 

 

local Resources = game:GetService("ReplicatedStorage"):WaitForChild("Resources");
local u1 = {};
local u2 = nil;
local u3 = nil;

for _, child in script:GetChildren() do
    if child:IsA("ModuleScript") and child.Name ~= "init" then
        if child.Name == "global" then
            u2 = require(child);
        elseif child.Name == "overtime" then
            u3 = require(child);
        else
            u1[child.Name] = require(child);
        end;
    end;
end;

local v4 = {};

local function resolve_theme(p5) -- Line: 53
    -- upvalues: Resources (copy)
    if typeof(p5) ~= "string" then
        return p5;
    end;

    local v6 = Resources;

    for _, v in string.split(p5, "/") do
        v6 = v6:FindFirstChild(v);

        if not v6 then
            warn((`[FlowWhitelist] Missing theme path: {p5}`));

            return p5;
        end;
    end;

    if v6:IsA("Sound") then
        return v6;
    end;

    return p5;
end;

local function merge_override(p7: table, p8: table?) -- Line: 71
    if not p8 then
        return;
    end;

    if p8.theme ~= nil then
        p7.theme = p8.theme;
    end;

    if p8.flowLength ~= nil then
        p7.flowLength = p8.flowLength;
    end;

    if p8.length ~= nil then
        p7.length = p8.length;
    end;

    if p8.randomThemes ~= nil then
        p7.randomThemes = p8.randomThemes;
    end;

    if p8.themePool ~= nil then
        p7.themePool = p8.themePool;
    end;

    if p8.themes ~= nil then
        p7.themes = p8.themes;
    end;
end;

local function user_in_config(p9: table?, p10: number) -- Line: 95
    if not p9 then
        return false;
    end;

    if p9.characters and p9.characters[p10] then
        return true;
    end;

    local v11;

    if p9.users == nil then
        v11 = false;
    else
        v11 = table.find(p9.users, p10) ~= nil;
    end;

    return v11;
end;

local function resolve_keyed_theme(p12: string, p13: number, p14: string) -- Line: 105
    -- upvalues: u1 (copy), u2 (ref), resolve_theme (copy)
    local v15 = {};
    local v16 = u1[p12];

    if v16 then
        table.insert(v15, v16);
    end;

    if u2 then
        table.insert(v15, u2);
    end;

    for _, v in v15 do
        if v then
            local v17;

            if v then
                if v.characters and v.characters[p13] then
                    v17 = true;
                elseif v.users == nil then
                    v17 = false;
                else
                    v17 = table.find(v.users, p13) ~= nil;
                end;
            else
                v17 = false;
            end;

            if v17 then
                local v18 = v.characters and v.characters[p13];
                local v19;

                if v18 and v18.themes then
                    v19 = v18.themes[p14];
                else
                    v19 = nil;
                end;

                if v19 == nil and v.themes then
                    v19 = v.themes[p14];
                end;

                if v19 then
                    return resolve_theme(v19);
                end;
            end;
        end;
    end;

    return nil;
end;

local function pick_override(p20: table?, p21: number, p22: boolean) -- Line: 140
    -- upvalues: merge_override (copy)
    if not p20 then
        return nil;
    end;

    local v23 = p20.characters and p20.characters[p21];
    local v24 = p20.users and table.find(p20.users, p21);

    if not (v23 or v24) then
        return nil;
    end;

    local v25 = {};
    merge_override(v25, p20.default);
    merge_override(v25, v23);

    if p22 then
        local v26 = {};

        if p20.flowOvertime then
            merge_override(v26, p20.flowOvertime);
        end;

        if v25.flowOvertime then
            merge_override(v26, v25.flowOvertime);
        end;

        if v23 and v23.flowOvertime then
            merge_override(v26, v23.flowOvertime);
        end;

        merge_override(v25, v26);
    end;

    if v25.theme == nil and (v25.flowLength == nil and (v25.length == nil and (not v25.randomThemes and v25.themePool == nil))) then
        return nil;
    end;

    return v25;
end;

function v4.reconcileGithubUsers(p27: string, p28: table, p29: boolean, p30: table) -- Line: 177
    -- upvalues: u2 (ref), u1 (copy)
    local v31;

    if p27 == "global" then
        v31 = u2;
    else
        v31 = u1[p27];
    end;

    if not v31 then
        warn((`[GITHUB OST]: No flow config found for {p27}`));

        return;
    end;

    if not v31.users then
        v31.users = {};
    end;

    local users = v31.users;

    if not p29 then
        for _, v in p28 do
            if not table.find(users, v) then
                table.insert(users, v);
            end;
        end;

        return;
    end;

    for i = #p30, 1, -1 do
        local v32 = p30[i];
        local v33;

        if table.find(p28, v32) then
            v33 = i;
        else
            local table_find_ret = table.find(users, v32);

            if table_find_ret then
                table.remove(users, table_find_ret);
                v33 = i;
            else
                v33 = i;
            end;
        end;
    end;

    for _, v in ipairs(p28) do
        if not table.find(users, v) then
            table.insert(users, v);
        end;
    end;

    table.clear(p30);

    for _, v in ipairs(p28) do
        table.insert(p30, v);
    end;
end;

function v4.has(p34: string, p35: number?, p36: boolean) -- Line: 225
    -- upvalues: pick_override (copy), u1 (copy), u2 (ref)
    if p35 then
        return pick_override(u1[p34], p35, p36) ~= nil and true or pick_override(u2, p35, p36) ~= nil;
    end;

    return false;
end;

function v4.apply(p37: string, p38: number?, p39: table) -- Line: 233
    -- upvalues: pick_override (copy), u1 (copy), u2 (ref), resolve_theme (copy), Resources (copy)
    if not p38 then
        return p39;
    end;

    local v40 = pick_override(u1[p37], p38, p39.isFlowOvertime) or pick_override(u2, p38, p39.isFlowOvertime);

    if not v40 then
        return p39;
    end;

    if v40.themePool and #v40.themePool > 0 then
        local v41 = resolve_theme(v40.themePool[math.random(1, #v40.themePool)]);

        if v41 ~= nil then
            p39.theme = v41;

            if typeof(v41) == "Instance" and v41:IsA("Sound") then
                p39.flowLength = v41.TimeLength or p39.flowLength;
            end;
        end;

        if v40.flowLength ~= nil then
            p39.flowLength = v40.flowLength;
        end;

        if v40.length ~= nil then
            p39.length = v40.length;
        end;

        return p39;
    end;

    if v40.randomThemes then
        local randomosts = Resources:FindFirstChild("randomosts");

        if randomosts then
            local Children = randomosts:GetChildren();

            if #Children > 0 then
                local v42 = Children[math.random(1, #Children)];

                if v42:IsA("Sound") then
                    p39.theme = v42;
                    p39.flowLength = v42.TimeLength or p39.flowLength;
                end;
            end;
        end;

        return p39;
    end;

    if v40.theme ~= nil then
        p39.theme = resolve_theme(v40.theme);
    end;

    if v40.flowLength ~= nil then
        p39.flowLength = v40.flowLength;
    end;

    if v40.length ~= nil then
        p39.length = v40.length;
    end;

    return p39;
end;

function v4.resolveAwkTheme(p43: string, p44: number?, p45: any, p46: string?, p47: boolean?) -- Line: 290
    -- upvalues: resolve_keyed_theme (copy), pick_override (copy), u1 (copy), u2 (ref), resolve_theme (copy)
    if p46 and p44 then
        local v48 = resolve_keyed_theme(p43, p44, p46);

        if v48 then
            return v48;
        end;

        local v49 = pick_override(u1[p43], p44, p47 == true) or pick_override(u2, p44, p47 == true);

        if v49 and v49.theme then
            return resolve_theme(v49.theme);
        end;
    end;

    return p45;
end;

function v4.getHolderOvertimeTheme(p50: number?) -- Line: 312
    -- upvalues: u3 (ref)
    if p50 and (u3 and u3.holderThemes) then
        return u3.holderThemes[p50];
    end;

    return nil;
end;

function v4.resolveCutIn(p51: string, p52: number?) -- Line: 319
    -- upvalues: u3 (ref)
    if p52 and (u3 and u3.holderCutIns) then
        p51 = u3.holderCutIns[p52] or p51;
    elseif u3 and u3.styleCutInAliases then
        p51 = u3.styleCutInAliases[p51] or p51;
    end;

    return p51, p51;
end;

return v4;