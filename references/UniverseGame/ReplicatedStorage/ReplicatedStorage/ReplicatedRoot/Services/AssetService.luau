  

 

local u1 = {
    Name = "AssetService"
};
local TableUtil = require(script.Parent.Parent.Libraries.Utility.TableUtil);

function u1.ResolvePath(p2) -- Line: 7
    -- upvalues: u1 (copy)
    local v3 = p2 or {};
    local Path = v3.Path;
    local Root = v3.Root;
    local v4 = v3.Pointer or 1;
    local v5 = v3.ReconcilePath or false;
    local HomeRoot = v3.HomeRoot;

    if typeof(Path) == "string" then
        Path = string.split(Path, "/");
    elseif typeof(Path) == "table" then
        Path = table.clone(Path);
    end;

    if typeof(Path) == "table" then
        if Path[1] == "" and Path[2] ~= "" then
            Root = game;
            v4 = 2;
        elseif Path[1] == "" and Path[2] == "" then
            Root = game:GetService(Path[3]);
            v4 = 4;
        elseif string.sub(Path[1], 1, 1) == "." and not string.match(Path[1], "%w") then
            for _ = 1, #Path[1] do
                if typeof(Root) ~= "Instance" or Root.Parent == nil then
                    break;
                end;

                Root = Root.Parent;
                v4 = v4 + 1;
            end;
        elseif string.sub(Path[1], 1, 1) == "@" then
            local Aliases = v3.Aliases;

            if Aliases then
                local v6 = Path[1];

                if v6 ~= nil and string.sub(v6, 1, 1) == "@" then
                    local v7 = Aliases[string.sub(v6, 2)];

                    if v7 then
                        Root = v7;
                        v4 = 2;
                    end;
                end;
            end;
        elseif Path[1] == "~" and HomeRoot ~= nil then
            if typeof(HomeRoot) == "string" then
                if typeof(HomeRoot) == "string" then
                    table.remove(Path, 1);

                    for i, v in pairs(string.split(HomeRoot, "/")) do
                        table.insert(Path, i, v);
                    end;
                end;
            else
                Root = HomeRoot;
                v4 = 2;
            end;
        end;
    end;

    for i = v4, #Path do
        local v8 = Path[i];
        local v9 = typeof(Root) == "table" and Root[v8] or typeof(Root) == "Instance" and Root:FindFirstChild(v8);

        if not v9 then
            if typeof(Root) == "string" then
                v9 = u1.ResolvePath({
                    Path = Root
                });
            else
                v9 = false;
            end;
        end;

        if not v9 then
            if v5 ~= true or Root == game then
                return nil;
            end;

            if typeof(Root) == "table" then
                Root[v8] = {};
                v9 = {};
            elseif typeof(Root) == "Instance" then
                v9 = Instance.new("Folder");
                v9.Name = v8;
                v9.Parent = Root;
            end;
        end;

        Root = v9;
    end;

    return Root;
end;

function u1.GetAbsolutePath(p10) -- Line: 93
    local v11 = p10:IsA("Instance") and p10:GetFullName();
    local v12 = string.split(v11, ".");
    local v13 = "";

    for _, v in pairs(v12) do
        if v ~= "" then
            v13 = v13 .. "/" .. v;
        end;
    end;

    return v13;
end;

function u1.GetAsset(p14, p15) -- Line: 107
    -- upvalues: u1 (copy), TableUtil (copy)
    local v16 = p15 or {};
    local ClassName = v16.ClassName;

    for _, v in pairs(v16.Paths) do
        if typeof(v) == "string" then
            local v = u1.ResolvePath(TableUtil.Reconcile({
                Path = p14,
                Root = v
            }, v16));
        end;

        local v17;

        if v16.Deep then
            v17 = v:FindFirstChild(p14, true);
        else
            v17 = u1.ResolvePath(TableUtil.Reconcile({
                Path = p14,
                Root = v
            }, v16));
        end;

        if v17 and (ClassName == nil or v17.ClassName == ClassName) then
            return v17;
        end;
    end;

    return nil;
end;

function u1.InferClass(p18) -- Line: 137
    return p18.AnimationId and "Animation" or (p18.SoundId and "Sound" or nil);
end;

function u1.CreateAsset(p19, p20) -- Line: 146
    -- upvalues: TableUtil (copy), u1 (copy)
    local v21 = p20 or {};
    local v22 = v21.CustomData or {};
    local v23 = nil;

    if typeof(p19) == "table" then
        v23 = p19;
    elseif typeof(p19) == "Instance" and p19:IsA("ModuleScript") then
        v23 = require(p19);

        if not v22.Name then
            v22.Name = p19.Name;
        end;
    end;

    if v23 then
        local v24 = TableUtil.Reconcile(v22, v23);
        local u25 = Instance.new(v24.ClassName or u1.InferClass(v24));
        u25.Name = v24.Name or u25.Name;

        for i, v in pairs(v24) do
            if string.sub(i, 1, 1) ~= "_" and (i ~= "ClassName" and typeof(v) ~= "function") then
                local _, _ = pcall(function() -- Line: 172
                    -- upvalues: u25 (copy), i (copy), v (copy)
                    u25[i] = v;
                end);
            end;
        end;

        if v24._Attributes then
            for i, v in pairs(v24._Attributes) do
                u25:SetAttribute(i, v);
            end;
        end;

        if v24._Children then
            for i, v in pairs(v24._Children) do
                if typeof(i) ~= "string" then
                    local i = v.Name or v.ClassName;
                end;

                u1.CreateAsset(v, {
                    Name = i
                }).Parent = u25;
            end;
        end;

        if v24._Created then
            v24:_Created(u25, v21);
        end;

        return u25;
    end;
end;

function u1.RequireAsset(p26, p27) -- Line: 203
    -- upvalues: u1 (copy)
    local v28 = p27 or {};
    v28.ClassName = v28.ClassName or "ModuleScript";
    local v29 = u1.GetAsset(p26, v28);

    if v29 and v29:IsA("ModuleScript") then
        return require(v29);
    end;

    return nil;
end;

local u30 = {};
u30.__index = u30;

function u1.CreateDirectory(p31) -- Line: 219
    -- upvalues: u30 (copy)
    local v32 = p31 or {};
    v32.Paths = v32.Paths or {};

    return setmetatable(v32, u30);
end;

function u30.GetAsset(p33, p34, p35) -- Line: 226
    -- upvalues: TableUtil (copy), u1 (copy)
    local v36 = TableUtil.Reconcile(p35 or {}, p33);

    return u1.GetAsset(p34, v36);
end;

function u30.CreateAsset(p37, p38, p39) -- Line: 232
    -- upvalues: TableUtil (copy), u1 (copy)
    local v40 = TableUtil.Reconcile(p39 or {}, p37);

    if typeof(p38) == "string" then
        p38 = p37:GetAsset(p38, v40);
    end;

    return u1.CreateAsset(p38, v40);
end;

function u30.RequireAsset(p41, p42, p43) -- Line: 243
    -- upvalues: TableUtil (copy)
    local v44 = TableUtil.Reconcile(p43 or {}, p41);
    v44.ClassName = v44.ClassName or "ModuleScript";
    local v45 = p41:GetAsset(p42, v44);

    if v45 and v45:IsA("ModuleScript") then
        return require(v45);
    end;
end;

function u30.BindToExternalDirectory(p46, p47) -- Line: 254
    p46.Paths = p47.Paths;
end;

function u30.AddPath(p48, p49) -- Line: 259
    return table.insert(p48.Directory, p49);
end;

function u30.GetPaths(p50) -- Line: 263
    return p50.Directory;
end;

return u1;