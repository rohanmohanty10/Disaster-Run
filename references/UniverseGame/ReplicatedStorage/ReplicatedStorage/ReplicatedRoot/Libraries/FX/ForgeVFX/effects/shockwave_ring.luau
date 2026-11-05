  

 

local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../pkg/Promise");
require("../obj/ObjectCache");
local u5 = Random.new();
local v6 = {};
local u7 = nil;

function v6.init(p8) -- Line: 17
    -- upvalues: u7 (ref)
    u7 = p8;
end;

function v6.deinit() -- Line: 21
    -- upvalues: u7 (ref)
    u7 = nil;
end;

function v6.emit(p9, u10, u11) -- Line: 25
    -- upvalues: u7 (ref), u1 (copy), CollectionService (copy), u3 (copy), u5 (copy), u2 (copy), u4 (copy)
    if not u7 then
        return;
    end;

    local v12 = u1.get(p9, "RayDirection", Vector3.new(0, -50, 0));
    local v13 = u1.get(p9, "RayCollisionGroup", "Default");
    local v14 = u1.get(p9, "FilterTag", "");
    local v15 = u1.get(p9, "FilterType", "Exclude");
    local v16 = u1.get(p9, "IgnoreWater", true);
    local v17 = u1.get(p9, "IgnoreCanCollide", false);
    local v18 = RaycastParams.new();
    v18.CollisionGroup = v13;
    v18.IgnoreWater = v16;
    v18.RespectCanCollide = not v17;
    v18.FilterType = Enum.RaycastFilterType[v15];
    v18.FilterDescendantsInstances = CollectionService:GetTagged(v14);

    if v15 == "Exclude" then
        v18:AddToFilter({ workspace.Terrain });
    end;

    local v19 = u1.get(u10, "EmitDelay", 0);
    local v20 = u1.get(u10, "Radius", 5);
    local v21 = u1.get(u10, "Segments", 7);
    local v22 = u1.getRange(u10, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local v23 = u1.get(u10, "PartOffset", Vector3.new(0, 0, 0), true);
    local u24 = u1.get(u10, "BaseOffset", v23);
    local u25 = u1.get(u10, "Offset_Start", v23);
    local u26 = u1.get(u10, "Offset_End", v23);
    local v27 = u1.get(u10, "Offset_Start_Duration", 0.5);
    local u28 = u1.get(u10, "Offset_End_Duration", 0.5);
    local u29 = u1.get(u10, "SizeScaleStart", Vector3.new(0, 0, 0));
    local u30 = u1.get(u10, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local v31 = u1.get(u10, "MinSize", Vector3.new(2, 1, 2));
    local v32 = u1.get(u10, "MaxSize", Vector3.new(3, 2, 3));
    local v33 = u1.get(u10, "Size_Curve", u3.default_bezier, true);
    local v34 = u1.get(u10, "Size_Duration", 0.5, true);
    local v35 = u1.get(u10, "Size_Start_Curve", v33);
    local u36 = u1.get(u10, "Size_End_Curve", v33);
    local v37 = u1.get(u10, "Size_Start_Duration", v34);
    local u38 = u1.get(u10, "Size_End_Duration", v34);
    local u39 = u1.get(u10, "Transparency_Duration", 0.5);
    local v40 = u1.get(u10, "Transparency_Start", 0);
    local u41 = u1.get(u10, "Transparency_End", 0);
    task.wait(v19);
    local v42 = u3.getTransformedOriginExtents(p9);
    local u43 = {};

    for i = 0, v21 - 1 do
        local v44 = i / v21 * 3.141592653589793 * 2;
        local v45 = v20 * math.cos(v44);
        local v46 = v20 * math.sin(v44);
        local v47 = workspace:Raycast((v42 * CFrame.new(v45, 0, v46)).Position, v42:VectorToWorldSpace(v12), v18);

        if v47 then
            local v48 = u5:NextNumber(v31.X, v32.X);
            local v49 = u5:NextNumber(v31.Y, v32.Y);
            local v50 = u5:NextNumber(v31.Z, v32.Z);
            local u51 = u3.getRandomId();
            local u52 = u7:get(u51);
            local v53 = u52._getReal();
            u3.copyProperties(u10, v53, u3.COPY_PART_PROPERTIES);
            u3.copyProperties(u10, v53, u3.COPY_EXTENDED_PART_PROPERTIES);

            if #u10:GetChildren() ~= 0 then
                local v54 = u10:Clone();

                for _, child in v54:GetChildren() do
                    child.Parent = v53;
                end;

                v54:Destroy();
            end;

            local u55 = u11.effects.prepareEmitOnFinish(u52, u11);
            table.insert(u11, function() -- Line: 130
                -- upvalues: u7 (ref), u51 (copy)
                if u7 then
                    u7:free(u51);
                end;
            end);
            u52.Color = v47.Instance.Color;
            u52.Material = v47.Material;
            u52.Transparency = v47.Instance.Transparency;

            if u52.Transparency == 0 then
                u52.Transparency = v40;
            end;

            u52.Size = Vector3.new(0, 0, 0);
            local v56 = -math.cos(v44);
            local v57 = -math.sin(v44);
            local Unit = v42:VectorToWorldSpace((Vector3.new(v56, 0, v57))):Cross(v47.Normal).Unit;
            local u58 = CFrame.fromMatrix(v47.Position, Unit, v47.Normal) * CFrame.fromOrientation(-math.atan(v49 / v50), 0, 0);
            u52.CFrame = CFrame.new(u25) * u58;
            local u59 = nil;
            local u60 = nil;
            local u61 = Vector3.new(0, 0, 0);

            if u25 ~= u24 then
                u60 = u2.fromParams(u1.get(u10, "Offset_Start_Curve", u3.default_bezier), v27, function(p62, p63) -- Line: 166
                    -- upvalues: u61 (ref), u25 (copy), u24 (copy), u52 (copy), u58 (copy)
                    u61 = u25:Lerp(u24, p62);
                    u52.CFrame = CFrame.new(u61) * u58;

                    return p63;
                end);
                table.insert(u11, u59);
            end;

            local u64 = Vector3.new(v48, v49, v50);

            if u64 * u29 == u64 then
                u52.Size = u64 * u29;
            else
                u59 = u2.fromParams(v35, v37, function(p65, p66) -- Line: 179
                    -- upvalues: u52 (copy), u64 (copy), u29 (copy)
                    u52.Size = (u64 * u29):Lerp(u64, p65);

                    return p66;
                end);
                table.insert(u11, u59);
            end;

            local Finished = u11.effects.emitNested(u52, u11.depth + 1, u11).Finished;
            table.insert(u43, Finished);
            task.delay(u5:NextNumber(v22.Min, v22.Max), function() -- Line: 192
                -- upvalues: u59 (ref), u60 (ref), u52 (copy), u64 (copy), u30 (copy), u11 (copy), u2 (ref), u36 (copy), u38 (copy), u61 (ref), u26 (copy), u1 (ref), u10 (copy), u3 (ref), u28 (copy), u58 (copy), u41 (copy), u39 (copy), u55 (copy), u43 (copy)
                if u59 then
                    u59:Disconnect();
                end;

                if u60 then
                    u60:Disconnect();
                end;

                local Size = u52.Size;
                local Transparency = u52.Transparency;

                if Size ~= u64 * u30 then
                    table.insert(u11, u2.fromParams(u36, u38, function(p67, p68) -- Line: 207
                        -- upvalues: u52 (ref), Size (copy), u64 (ref), u30 (ref)
                        u52.Size = Size:Lerp(u64 * u30, p67);

                        return p68;
                    end));
                end;

                if u61 ~= u26 then
                    local fromParams = u2.fromParams;
                    local v69 = u1.get(u10, "Offset_End_Curve", u3.default_bezier);
                    table.insert(u11, fromParams(v69, u28, function(p70, p71) -- Line: 220
                        -- upvalues: u52 (ref), u61 (ref), u26 (ref), u58 (ref)
                        u52.CFrame = CFrame.new(u61:Lerp(u26, p70)) * u58;

                        return p71;
                    end));
                end;

                if Transparency ~= u41 then
                    local fromParams = u2.fromParams;
                    local v72 = u1.get(u10, "Transparency_Curve", u3.default_bezier);
                    table.insert(u11, fromParams(v72, u39, function(p73, p74) -- Line: 234
                        -- upvalues: u52 (ref), u3 (ref), Transparency (copy), u41 (ref)
                        u52.Transparency = u3.lerp(Transparency, u41, p73);

                        return p74;
                    end));
                end;

                local Finished2 = u11.effects.emitOnFinish(u55, u52, u11.depth + 1, u11).Finished;
                table.insert(u43, Finished2);
            end);
        end;
    end;

    task.wait(v22.Max + math.max(u38, u28));
    u4.all(u43):await();
end;

return v6;