 

 

local AssetService = game:GetService("AssetService");
local u1 = {
    RES_W = 24,
    RES_H = 14,
    TILE_W = 8,
    TILE_H = 5
};

local function addRecipeHighlight(p2) -- Line: 27
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 0.98;
    Highlight.Parent = p2;

    return Highlight;
end;

local function configurePart(p3) -- Line: 35
    p3.Anchored = true;
    p3.CanCollide = false;
    p3.CanQuery = false;
    p3.CanTouch = false;
    p3.CastShadow = false;
    p3.Locked = true;
    p3.Archivable = false;
    p3.Material = Enum.Material.Glass;
    p3.Color = Color3.new(1, 1, 1);
end;

function u1.probeMesh() -- Line: 50
    -- upvalues: AssetService (copy)
    local success, result = pcall(function() -- Line: 51
        -- upvalues: AssetService (ref)
        return AssetService:CreateEditableMesh();
    end);

    if not (success and result) then
        return false;
    end;

    pcall(function() -- Line: 55
        -- upvalues: result (copy)
        result:Destroy();
    end);

    return true;
end;

function u1.buildMesh(u4, u5) -- Line: 65
    -- upvalues: AssetService (copy), u1 (copy)
    local success, result = pcall(function() -- Line: 66
        -- upvalues: AssetService (ref), u4 (copy), u1 (ref), u5 (copy)
        local v6 = AssetService:CreateEditableMesh();

        if not v6 then
            return nil;
        end;

        local v7 = u4 or u1.RES_W;
        local v8 = u5 or u1.RES_H;
        local table_create_ret = table.create(v7 * v8);
        local table_create_ret2 = table.create(v7 * v8);
        local table_create_ret3 = table.create(v7 * v8);

        for i = 0, v8 - 1 do
            local v9 = i;

            for i2 = 0, v7 - 1 do
                local v10 = i2 / (v7 - 1) - 0.5;
                local v11 = v9 / (v8 - 1) - 0.5;
                local v12 = v9 * v7 + i2 + 1;
                table_create_ret[v12] = v6:AddVertex((Vector3.new(v10, v11, (i2 + v9) % 2 == 0 and 0.004 or -0.004)));
                table_create_ret2[v12] = v10;
                table_create_ret3[v12] = v11;
                local _ = i2;
            end;
        end;

        for i = 0, v8 - 2 do
            local v13 = i;

            for i2 = 0, v7 - 2 do
                local v14 = table_create_ret[v13 * v7 + i2 + 1];
                local v15 = table_create_ret[(v13 + 1) * v7 + i2 + 1];
                local v16 = table_create_ret[(v13 + 1) * v7 + i2 + 2];
                v6:AddTriangle(v14, table_create_ret[v13 * v7 + i2 + 2], v16);
                v6:AddTriangle(v14, v16, v15);
                local _ = i2;
            end;
        end;

        local v17 = AssetService:CreateMeshPartAsync(Content.fromObject(v6));
        v17.Name = "__PartIclesDistortion";
        v17.Anchored = true;
        v17.CanCollide = false;
        v17.CanQuery = false;
        v17.CanTouch = false;
        v17.CastShadow = false;
        v17.Locked = true;
        v17.Archivable = false;
        v17.Material = Enum.Material.Glass;
        v17.Color = Color3.new(1, 1, 1);
        v17.Size = v17.MeshSize;
        local Highlight = Instance.new("Highlight");
        Highlight.FillTransparency = 1;
        Highlight.OutlineTransparency = 0.98;
        Highlight.Parent = v17;

        return {
            part = v17,
            em = v6,
            ids = table_create_ret,
            baseX = table_create_ret2,
            baseY = table_create_ret3,
            meshSizeZ = v17.MeshSize.Z,
            highlight = Highlight,
            resW = v7,
            resH = v8
        };
    end);

    if success then
        return result;
    end;

    return nil;
end;

function u1.buildTiles() -- Line: 116
    -- upvalues: u1 (copy)
    local Model = Instance.new("Model");
    Model.Name = "__PartIclesDistortion";
    local TILE_W = u1.TILE_W;
    local TILE_H = u1.TILE_H;
    local v18 = {};
    local v19 = 0;
    local v20 = {};
    local v21 = {};
    local v22 = {};

    for i = 1, TILE_H do
        local v23 = i;

        for i2 = 1, TILE_W do
            local Part = Instance.new("Part");
            Part.Shape = Enum.PartType.Ball;
            Part.Size = Vector3.new(0.8, 0.8, 0.26);
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.CanTouch = false;
            Part.CastShadow = false;
            Part.Locked = true;
            Part.Archivable = false;
            Part.Material = Enum.Material.Glass;
            Part.Color = Color3.new(1, 1, 1);
            Part.Transparency = 1;
            Part.Name = "Lens" .. i2 .. "_" .. v23;
            Part.Parent = Model;
            v19 = v19 + 1;
            v20[v19] = Part;
            local Highlight = Instance.new("Highlight");
            Highlight.FillTransparency = 1;
            Highlight.OutlineTransparency = 0.98;
            Highlight.Parent = Part;
            v21[v19] = Highlight;
            v22[v19] = -(i2 - (TILE_W + 1) / 2) * 0.17453292519943295;
            v18[v19] = (v23 - (TILE_H + 1) / 2) * 0.17453292519943295;
            local _ = i2;
        end;
    end;

    return {
        model = Model,
        tiles = v20,
        highlights = v21,
        yawAng = v22,
        pitchAng = v18,
        count = v19,
        writeCFs = table.create(v19)
    };
end;

return u1;