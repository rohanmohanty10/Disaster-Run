 
 

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

local Nowl = require(game:GetService("ReplicatedStorage").wiki.Nowl);

local function user_in_config(p9: table?, p10: number) -- Line: 97
    -- upvalues: Nowl (copy)
    if Nowl.is_enabled() and not Nowl.is_excluded(p10) then
        return false;
    end;

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

local function resolve_keyed_theme(p12: string, p13: number, p14: string) -- Line: 110
    -- upvalues: u1 (copy), u2 (ref), user_in_config (copy), resolve_theme (copy)
    local v15 = {};
    local v16 = u1[p12];

    if v16 then
        table.insert(v15, v16);
    end;

    if u2 then
        table.insert(v15, u2);
    end;

    for _, v in v15 do
        if v and user_in_config(v, p13) then
            local v17 = v.characters and v.characters[p13];
            local v18;

            if v17 and v17.themes then
                v18 = v17.themes[p14];
            else
                v18 = nil;
            end;

            if v18 == nil and v.themes then
                v18 = v.themes[p14];
            end;

            if v18 then
                return resolve_theme(v18);
            end;
        end;
    end;

    return nil;
end;

local function pick_override(p19: table?, p20: number, p21: boolean) -- Line: 145
    -- upvalues: Nowl (copy), merge_override (copy)
    if Nowl.is_enabled() and not Nowl.is_excluded(p20) then
        return nil;
    end;

    if not p19 then
        return nil;
    end;

    local v22 = p19.characters and p19.characters[p20];
    local v23 = p19.users and table.find(p19.users, p20);

    if not (v22 or v23) then
        return nil;
    end;

    local v24 = {};
    merge_override(v24, p19.default);
    merge_override(v24, v22);

    if p21 then
        local v25 = {};

        if p19.flowOvertime then
            merge_override(v25, p19.flowOvertime);
        end;

        if v24.flowOvertime then
            merge_override(v25, v24.flowOvertime);
        end;

        if v22 and v22.flowOvertime then
            merge_override(v25, v22.flowOvertime);
        end;

        merge_override(v24, v25);
    end;

    if v24.theme == nil and (v24.flowLength == nil and (v24.length == nil and (not v24.randomThemes and v24.themePool == nil))) then
        return nil;
    end;

    return v24;
end;

function v4.reconcileGithubUsers(p26: string, p27: table, p28: boolean, p29: table) -- Line: 185
    -- upvalues: u2 (ref), u1 (copy)
    local v30;

    if p26 == "global" then
        v30 = u2;
    else
        v30 = u1[p26];
    end;

    if not v30 then
        warn((`[GITHUB OST]: No flow config found for {p26}`));

        return;
    end;

    if not v30.users then
        v30.users = {};
    end;

    local users = v30.users;

    if not p28 then
        for _, v in p27 do
            if not table.find(users, v) then
                table.insert(users, v);
            end;
        end;

        return;
    end;

    for i = #p29, 1, -1 do
        local v31 = p29[i];
        local v32;

        if table.find(p27, v31) then
            v32 = i;
        else
            local table_find_ret = table.find(users, v31);

            if table_find_ret then
                table.remove(users, table_find_ret);
                v32 = i;
            else
                v32 = i;
            end;
        end;
    end;

    for _, v in ipairs(p27) do
        if not table.find(users, v) then
            table.insert(users, v);
        end;
    end;

    table.clear(p29);

    for _, v in ipairs(p27) do
        table.insert(p29, v);
    end;
end;

function v4.has(p33: string, p34: number?, p35: boolean) -- Line: 233
    -- upvalues: pick_override (copy), u1 (copy), u2 (ref)
    if p34 then
        return pick_override(u1[p33], p34, p35) ~= nil and true or pick_override(u2, p34, p35) ~= nil;
    end;

    return false;
end;

function v4.apply(p36: string, p37: number?, p38: table) -- Line: 241
    -- upvalues: pick_override (copy), u1 (copy), u2 (ref), resolve_theme (copy), Resources (copy)
    if not p37 then
        return p38;
    end;

    local v39 = pick_override(u1[p36], p37, p38.isFlowOvertime) or pick_override(u2, p37, p38.isFlowOvertime);

    if not v39 then
        return p38;
    end;

    if v39.themePool and #v39.themePool > 0 then
        local v40 = resolve_theme(v39.themePool[math.random(1, #v39.themePool)]);

        if v40 ~= nil then
            p38.theme = v40;

            if typeof(v40) == "Instance" and v40:IsA("Sound") then
                p38.flowLength = v40.TimeLength or p38.flowLength;
            end;
        end;

        if v39.flowLength ~= nil then
            p38.flowLength = v39.flowLength;
        end;

        if v39.length ~= nil then
            p38.length = v39.length;
        end;

        return p38;
    end;

    if v39.randomThemes then
        local randomosts = Resources:FindFirstChild("randomosts");

        if randomosts then
            local Children = randomosts:GetChildren();

            if #Children > 0 then
                local v41 = Children[math.random(1, #Children)];

                if v41:IsA("Sound") then
                    p38.theme = v41;
                    p38.flowLength = v41.TimeLength or p38.flowLength;
                end;
            end;
        end;

        return p38;
    end;

    if v39.theme ~= nil then
        p38.theme = resolve_theme(v39.theme);
    end;

    if v39.flowLength ~= nil then
        p38.flowLength = v39.flowLength;
    end;

    if v39.length ~= nil then
        p38.length = v39.length;
    end;

    return p38;
end;

function v4.resolveAwkTheme(p42: string, p43: number?, p44: any, p45: string?, p46: boolean?) -- Line: 298
    -- upvalues: resolve_keyed_theme (copy), pick_override (copy), u1 (copy), u2 (ref), resolve_theme (copy)
    if p45 and p43 then
        local v47 = resolve_keyed_theme(p42, p43, p45);

        if v47 then
            return v47;
        end;

        local v48 = pick_override(u1[p42], p43, p46 == true) or pick_override(u2, p43, p46 == true);

        if v48 and v48.theme then
            return resolve_theme(v48.theme);
        end;
    end;

    return p44;
end;

function v4.getHolderOvertimeTheme(p49: number?) -- Line: 320
    -- upvalues: Nowl (copy), u3 (ref)
    if Nowl.is_enabled() and not Nowl.is_excluded(p49) then
        return nil;
    end;

    if p49 and (u3 and u3.holderThemes) then
        return u3.holderThemes[p49];
    end;

    return nil;
end;

function v4.resolveCutIn(p50: string, p51: number?) -- Line: 330
    -- upvalues: Nowl (copy), u3 (ref)
    if Nowl.is_enabled() or not (p51 and (u3 and u3.holderCutIns)) then
        if u3 and u3.styleCutInAliases then
            p50 = u3.styleCutInAliases[p50] or p50;
        end;
    else
        p50 = u3.holderCutIns[p51] or p50;
    end;

    return p50, p50;
end;

return v4;