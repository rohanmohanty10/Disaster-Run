 
 

local u1 = {};
u1.__index = u1;
local u2;

if workspace:FindFirstChild("Cache") then
    u2 = nil;
else
    u2 = Instance.new("Folder");
    u2.Name = "Cache";
    u2.Parent = workspace;
end;

local function u5(p3, p4) -- Line: 18
    local Instance_new_ret = Instance.new(p3);

    for i, v in next, p4 do
        if i ~= "Parent" and Instance_new_ret[i] ~= nil then
            Instance_new_ret[i] = v;
        end;
    end;

    Instance_new_ret.Parent = p4.Parent;

    return Instance_new_ret;
end;

function clearTables(p6)
    for i = 1, #p6 do
        if type(p6[i]) == "table" then
            clearTables(p6);
        end;

        p6[i] = nil;
        local _ = i;
    end;
end;

function u1.new(p7, p8, p9) -- Line: 40
    -- upvalues: u1 (copy), u5 (copy), u2 (ref)
    local v10 = setmetatable({}, u1);
    local v11 = u5("Folder", {
        Parent = u2,
        Name = p9 or "CachedFolder"
    });

    if p7:IsA("BasePart") or p7:IsA("MeshPart") then
        if not p7.Anchored then
            p7.Anchored = true;
        end;
    elseif p7:IsA("Model") then
        for _, _ in p7:GetChildren() do
            if (p7:IsA("BasePart") or p7:IsA("MeshPart")) and not p7.Anchored then
                p7.Anchored = true;
            end;
        end;
    end;

    v10.Active = {};
    v10.Inactive = {};
    v10.Cached = {};
    v10.ExtraObjects = {};
    v10.Template = p7;
    v10.CacheArea = v11;

    function v10.AddCache(p12, p13, p14) -- Line: 60
        for i = 1, p13 do
            local v15 = p12.Template:Clone();
            v15.Position = Vector3.new(0, 1000000000, 0);
            v15.Parent = p12.CacheArea;
            table.insert(p12.Cached, v15);
            table.insert(p12.Inactive, v15);
            local v16;

            if p14 then
                table.insert(p12.ExtraObjects, v15);
                v16 = i;
            else
                v16 = i;
            end;
        end;
    end;

    function v10.GetObject(p17) -- Line: 73
        if p17.Inactive[1] then
            local v18 = p17.Inactive[1];
            table.remove(p17.Inactive, table.find(p17.Inactive, v18));
            table.insert(p17.Active, v18);

            return v18;
        end;

        p17:AddCache(1, true);
        local v19 = p17.Inactive[1];
        table.remove(p17.Inactive, table.find(p17.Inactive, v19));
        table.insert(p17.Active, v19);

        return v19;
    end;

    function v10.ReturnObject(p20, p21) -- Line: 90
        if table.find(p20.Cached, p21) then
            table.remove(p20.Active, table.find(p20.Inactive, p21));

            if table.find(p20.ExtraObjects, p21) then
                table.remove(p20.ExtraObjects, table.find(p20.ExtraObjects, p21));
                table.remove(p20.Cached, table.find(p20.Cached, p21));
                p21:Destroy();

                return;
            end;

            table.insert(p20.Inactive, p21);

            if (p21:IsA("BasePart") or p21:IsA("MeshPart")) and not p21.Anchored then
                p21.Anchored = true;
            end;

            p21.Position = Vector3.new(0, 1000000000, 0);
        end;
    end;

    function v10.Delete(p22) -- Line: 108
        p22.CacheArea:Destroy();
        clearTables(p22);
        warn("CACHED DESTROYED");
    end;

    function v10.DeleteExtra(p23) -- Line: 129
        for _, v in ipairs(p23.ExtraCache) do
            if os.clock() - v[2] >= 60 then
                table.find(p23.Active, v);
            end;
        end;
    end;

    v10:AddCache(p8 or 20);
    warn("CACHED CREATED");

    return v10;
end;

return u1;