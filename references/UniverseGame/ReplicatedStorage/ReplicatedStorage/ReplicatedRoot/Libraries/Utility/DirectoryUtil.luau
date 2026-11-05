  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local u1 = {};
require(ReplicatedRoot.Libraries.Utility.TableUtil);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
local u2 = { "Path", "IsA", "ReconcilePath", "Time", "Root" };

local function Merge(p3, p4) -- Line: 10
    -- upvalues: u2 (copy)
    for _, v in pairs(u2) do
        if p4[v] then
            p3[v] = p4[v];
        end;
    end;

    local _ = p4.Roots;

    if p4.Roots then
        if not p3.Roots then
            p3.Roots = table.clone(p4.Roots);

            return;
        end;

        for _, v in pairs(p4.Roots) do
            table.insert(p3.Roots, v);
        end;
    end;
end;

function u1.Get(p5, ...) -- Line: 29
    -- upvalues: Merge (copy), u1 (copy)
    local v6 = typeof(p5) == "string" and {
        Path = p5
    } or p5;
    local v7 = not v6 and {} or table.clone(v6);

    if v7.Roots then
        v7.Roots = table.clone(v7.Roots);
    end;

    local v8 = ... and table.pack(...) or nil;

    if v8 then
        for _, v in ipairs(v8) do
            Merge(v7, v);
        end;
    end;

    local Path = v7.Path;

    if typeof(Path) == "string" then
        Path = string.split(Path, "/");
    end;

    local _ = v7.Roots;
    local ReconcilePath = v7.ReconcilePath;
    local IsA = v7.IsA;

    local function Search(p9, p10, p11) -- Line: 55
        -- upvalues: IsA (copy), u1 (ref), ReconcilePath (copy)
        for i = p11 or 1, #p9 do
            local v12 = p9[i];
            local v13 = nil;

            if typeof(p10) == "table" then
                v13 = p10[v12];
            elseif typeof(p10) == "Instance" then
                if IsA == nil or i ~= #p9 then
                    v13 = p10:FindFirstChild(v12);
                else
                    for _, child in pairs(p10:GetChildren()) do
                        if child:IsA(IsA) and child.Name == v12 then
                            v13 = child;
                            break;
                        end;
                    end;
                end;
            elseif typeof(p10) == "string" then
                v13 = u1.Get({
                    Path = p10
                });
            end;

            if v13 == nil then
                if not ReconcilePath or p10 == game then
                    return nil;
                end;

                if typeof(p10) == "table" then
                    v13 = {};
                    p10[v12] = v13;
                elseif typeof(p10) == "Instance" then
                    v13 = Instance.new("Folder");
                    v13.Name = v12;
                    v13.Parent = p10;
                end;
            end;

            p10 = v13;
        end;

        return p10;
    end;

    local v14 = nil;

    if Path[1] == "" and Path[2] ~= "" then
        return Search(Path, game, 2);
    end;

    if Path[1] == "" and Path[2] == "" then
        return Search(Path, game:GetService(Path[3]), 4);
    end;

    local v15 = v7.Roots or {};

    if v7.Root ~= nil then
        table.insert(v15, v7.Root);
    end;

    for _, v in pairs(v15) do
        if typeof(v) == "table" and (v[1] and v[2]) then
            local v16 = true;

            for i = 1, #v - 1 do
                if Path[i] ~= v[i] then
                    v16 = false;
                    break;
                end;
            end;

            if v16 then
                v14 = Search(Path, v[#v], #v);
            end;
        elseif typeof(v) == "function" then
            v14 = v({
                Path = Path,
                Roots = v15
            });
        else
            v14 = Search(Path, v, 1);
        end;

        if v14 ~= nil then
            return v14;
        end;
    end;

    return v14;
end;

function u1.Await(p17, ...) -- Line: 144
    -- upvalues: Merge (copy), u1 (copy)
    local v18 = not p17 and {} or table.clone(p17);

    for _, v in pairs(...) do
        Merge(v18, v);
    end;

    local Time = v18.Time;
    local v19 = os.clock();
    local v20 = u1.Get(v18);

    while not v20 and (Time == nil or os.clock() - v19 < Time) do
        v20 = u1.Get(v18);
        task.wait();
    end;

    return v20;
end;

function u1.GetAbsolutePath(p21) -- Line: 161
    local v22 = p21:IsA("Instance") and p21:GetFullName();
    local v23 = string.split(v22, ".");
    local v24 = "";

    for _, v in pairs(v23) do
        if v ~= "" then
            v24 = v24 .. "/" .. v;
        end;
    end;

    return v24;
end;

function u1.MergeFolders(p25, p26) -- Line: 175
    -- upvalues: u1 (copy)
    for _, child in pairs(p25:GetChildren()) do
        local v27 = p26:FindFirstChild(child.Name);

        if child:IsA("Folder") then
            if v27 == nil then
                child.Parent = p26;
            else
                u1.MergeFolders(child, v27);
            end;
        end;
    end;
end;

return u1;