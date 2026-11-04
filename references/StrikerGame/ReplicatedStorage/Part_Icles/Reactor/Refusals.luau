 

 

local Log = require(script.Parent.Parent.Log);
local v1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});
local u3 = setmetatable({}, {
    __mode = "k"
});
local u4 = {};
local u5 = 0;

local function contentObject(p6) -- Line: 50
    return p6.MeshContent.Object;
end;

local function meshOf(p7) -- Line: 55
    -- upvalues: contentObject (copy)
    if not p7:IsA("MeshPart") then
        return nil;
    end;

    local MeshId = p7.MeshId;

    if MeshId ~= nil and MeshId ~= "" then
        return MeshId;
    end;

    local success, result = pcall(contentObject, p7);

    if success then
        return result;
    end;

    return nil;
end;

function v1.notSolid(p8) -- Line: 70
    return string.find(p8, "manifold", 1, true) ~= nil;
end;

local function tell(p9, p10) -- Line: 75
    -- upvalues: contentObject (copy), u3 (copy), Log (copy)
    local v11;

    if p9:IsA("MeshPart") then
        v11 = p9.MeshId;

        if v11 == nil or v11 == "" then
            local v12;
            v12, v11 = pcall(contentObject, p9);

            if not v12 then
                v11 = nil;
            end;
        end;
    else
        v11 = nil;
    end;

    local v13 = v11 or p9;

    if u3[v13] then
        return;
    end;

    u3[v13] = true;
    local v14 = string.find(p10, "manifold", 1, true) ~= nil and " A mesh must be a closed solid to be cut." or "";
    Log.warn(string.format("[Part-Icles] Reactor: the engine will not cut %s (%s), so it moves whole.%s", p9:GetFullName(), p10, v14));
end;

local function settle(p15, p16) -- Line: 89
    -- upvalues: u2 (copy)
    local v17 = u2[p15];

    if type(v17) == "string" then
        return;
    end;

    u2[p15] = p16;

    if type(v17) == "table" then
        for _, v in ipairs(v17) do
            v();
        end;
    end;
end;

function v1.refused(p18) -- Line: 102
    -- upvalues: contentObject (copy), u2 (copy)
    local v19;

    if p18:IsA("MeshPart") then
        v19 = p18.MeshId;

        if v19 == nil or v19 == "" then
            local v20;
            v20, v19 = pcall(contentObject, p18);

            if not v20 then
                v19 = nil;
            end;
        end;
    else
        v19 = nil;
    end;

    local v21;

    if v19 == nil then
        v21 = false;
    else
        v21 = type(u2[v19]) == "string";
    end;

    return v21;
end;

function v1.cut(p22) -- Line: 107
    -- upvalues: contentObject (copy), u2 (copy)
    local v23;

    if p22:IsA("MeshPart") then
        v23 = p22.MeshId;

        if v23 == nil or v23 == "" then
            local v24;
            v24, v23 = pcall(contentObject, p22);

            if not v24 then
                v23 = nil;
            end;
        end;
    else
        v23 = nil;
    end;

    if v23 then
        local v25 = u2[v23];

        if type(v25) == "string" then
            return;
        end;

        u2[v23] = true;

        if type(v25) == "table" then
            for _, v in ipairs(v25) do
                v();
            end;
        end;
    end;
end;

function v1.refuse(p26, p27) -- Line: 114
    -- upvalues: contentObject (copy), u2 (copy), tell (copy)
    local v28;

    if p26:IsA("MeshPart") then
        v28 = p26.MeshId;

        if v28 == nil or v28 == "" then
            local v29;
            v29, v28 = pcall(contentObject, p26);

            if not v29 then
                v28 = nil;
            end;
        end;
    else
        v28 = nil;
    end;

    if v28 and string.find(p27, "manifold", 1, true) ~= nil then
        local v30 = u2[v28];

        if type(v30) ~= "string" then
            u2[v28] = p27;

            if type(v30) == "table" then
                for _, v in ipairs(v30) do
                    v();
                end;
            end;
        end;
    end;

    tell(p26, p27);
end;

function v1.explain(p31) -- Line: 122
    -- upvalues: contentObject (copy), u2 (copy), tell (copy)
    local v32;

    if p31:IsA("MeshPart") then
        v32 = p31.MeshId;

        if v32 == nil or v32 == "" then
            local v33;
            v33, v32 = pcall(contentObject, p31);

            if not v33 then
                v32 = nil;
            end;
        end;
    else
        v32 = nil;
    end;

    if v32 then
        v32 = u2[v32];
    end;

    if type(v32) == "string" then
        tell(p31, v32);
    end;
end;

local function judgeWaiting(p34) -- Line: 131
    -- upvalues: u4 (copy), contentObject (copy), u2 (copy), u5 (ref)
    while #u4 > 0 do
        local table_remove_ret = table.remove(u4, 1);
        local v35;

        if table_remove_ret:IsA("MeshPart") then
            v35 = table_remove_ret.MeshId;

            if v35 == nil or v35 == "" then
                local v36;
                v36, v35 = pcall(contentObject, table_remove_ret);

                if not v36 then
                    v35 = nil;
                end;
            end;
        else
            v35 = nil;
        end;

        local Instance_fromExisting_ret = Instance.fromExisting(table_remove_ret);
        Instance_fromExisting_ret.Archivable = true;
        Instance_fromExisting_ret.Anchored = true;
        local CFrame = Instance_fromExisting_ret.CFrame;
        local v37 = Instance_fromExisting_ret.Size / 4;
        local v38, v39 = p34(Instance_fromExisting_ret, { CFrame:PointToWorldSpace(v37), CFrame:PointToWorldSpace(-v37) });
        Instance_fromExisting_ret:Destroy();

        for _, v in ipairs(v38 or {}) do
            v.Instance:Destroy();
        end;

        if v35 then
            if v39 and string.find(v39, "manifold", 1, true) ~= nil then
                local v40 = u2[v35];

                if type(v40) ~= "string" then
                    u2[v35] = v39;

                    if type(v40) == "table" then
                        for _, v in ipairs(v40) do
                            v();
                        end;
                    end;
                end;
            else
                local v41 = u2[v35];

                if type(v41) ~= "string" then
                    u2[v35] = true;

                    if type(v41) == "table" then
                        for _, v in ipairs(v41) do
                            v();
                        end;
                    end;
                end;
            end;
        end;
    end;

    u5 = u5 - 1;
end;

function v1.judge(p42, p43, p44) -- Line: 156
    -- upvalues: contentObject (copy), u2 (copy), u4 (copy), u5 (ref), judgeWaiting (copy)
    local v45;

    if p42:IsA("MeshPart") then
        v45 = p42.MeshId;

        if v45 == nil or v45 == "" then
            local v46;
            v46, v45 = pcall(contentObject, p42);

            if not v46 then
                v45 = nil;
            end;
        end;
    else
        v45 = nil;
    end;

    local v47;

    if v45 then
        v47 = u2[v45];
    else
        v47 = nil;
    end;

    if type(v47) == "table" then
        if p44 then
            table.insert(v47, p44);
        end;

        return;
    end;

    if not v45 or v47 ~= nil then
        if p44 then
            p44();
        end;

        return;
    end;

    u2[v45] = { p44 };
    table.insert(u4, p42);

    if u5 < 2 then
        u5 = u5 + 1;
        task.spawn(judgeWaiting, p43);
    end;
end;

return v1;