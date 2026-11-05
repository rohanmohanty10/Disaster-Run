  

 

local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/logger");
local u4 = require("../mod/utility");
local u5 = require("../obj/Bezier");
local u6 = require("../pkg/Promise");
require("../obj/ObjectCache");
local u7 = Random.new();
local v8 = {};
local u9 = nil;

function v8.init(p10) -- Line: 19
    -- upvalues: u9 (ref)
    u9 = p10;
end;

function v8.deinit() -- Line: 23
    -- upvalues: u9 (ref)
    u9 = nil;
end;

function v8.emit(u11, u12, u13) -- Line: 27
    -- upvalues: u9 (ref), u1 (copy), CollectionService (copy), u4 (copy), u2 (copy), u3 (copy), u5 (copy), u7 (copy), u6 (copy)
    if not u9 then
        return;
    end;

    local u14 = u1.get(u11, "RayDirection", Vector3.new(0, -50, 0));
    local v15 = u1.get(u11, "RayCollisionGroup", "Default");
    local v16 = u1.get(u11, "FilterTag", "");
    local v17 = u1.get(u11, "FilterType", "Exclude");
    local v18 = u1.get(u11, "IgnoreWater", true);
    local v19 = u1.get(u11, "IgnoreCanCollide", false);
    local u20 = RaycastParams.new();
    u20.CollisionGroup = v15;
    u20.IgnoreWater = v18;
    u20.RespectCanCollide = not v19;
    u20.FilterType = Enum.RaycastFilterType[v17];
    u20.FilterDescendantsInstances = CollectionService:GetTagged(v16);

    if v17 == "Exclude" then
        u20:AddToFilter({ workspace.Terrain });
    end;

    local v21 = u1.get(u12, "EmitDelay", 0);
    local u22 = u1.get(u12, "Rate_Start", 30);
    local u23 = u1.get(u12, "Rate_End", 30);
    local v24 = u1.get(u12, "FixedAmount", 0);
    local u25 = u1.get(u12, "Scale_Start", 1);
    local u26 = u1.get(u12, "Scale_End", 1);
    local v27 = u1.get(u12, "Duration", 1);
    local v28 = u1.get(u12, "Direction", Vector3.new(0, 0, -1));
    local u29 = u1.get(u12, "Length", 50);
    local u30 = u1.getRange(u12, "Rotation", NumberRange.new(-180, 180));
    local v31 = u1.get(u12, "PartOffset", Vector3.new(0, 0, 0), true);
    local u32 = u1.get(u12, "BaseOffset", v31);
    local u33 = u1.get(u12, "Offset_Start", v31);
    local u34 = u1.get(u12, "Offset_End", v31);
    local u35 = u1.get(u12, "Offset_Start_Duration", 0.5);
    local u36 = u1.get(u12, "Offset_End_Duration", 0.5);
    local u37 = u1.getRange(u12, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local u38 = u1.get(u12, "SizeScaleStart", Vector3.new(0, 0, 0));
    local u39 = u1.get(u12, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local u40 = u1.get(u12, "MinSize", Vector3.new(2, 1, 2));
    local u41 = u1.get(u12, "MaxSize", Vector3.new(3, 2, 3));
    local v42 = u1.get(u12, "Size_Curve", u4.default_bezier, true);
    local v43 = u1.get(u12, "Size_Duration", 0.5, true);
    local u44 = u1.get(u12, "Size_Start_Curve", v42);
    local u45 = u1.get(u12, "Size_End_Curve", v42);
    local u46 = u1.get(u12, "Size_Start_Duration", v43);
    local u47 = u1.get(u12, "Size_End_Duration", v43);
    local u48 = u1.get(u12, "Transparency_Duration", 0.5);
    local u49 = u1.get(u12, "Transparency_Start", 0);
    local u50 = u1.get(u12, "Transparency_End", 0);
    local u51 = u1.get(u12, "SyncPosition", false);
    local u52 = math.max(v27, 0.001);

    if v24 > 0 then
        u22 = v24 / u52;
        u23 = u22;
    end;

    local Unit = v28.Unit;
    local u53 = Unit ~= Unit and Vector3.new(-0, -0, -1) or Unit;
    task.wait(v21);
    local u54 = {};
    local u55 = u4.getTransformedOriginExtents(u11);
    local u56 = 0;
    local u57 = 0;
    local u58 = u22;
    local u59 = u25;

    if u25 ~= u26 then
        local fromParams = u2.fromParams;
        local v60 = u1.get(u12, "Scale_Curve", u4.default_bezier);
        table.insert(u13, fromParams(v60, u52, function(p61, p62) -- Line: 131
            -- upvalues: u59 (ref), u4 (ref), u25 (copy), u26 (copy)
            u59 = u4.lerp(u25, u26, p61);

            return p62;
        end));
    end;

    if u22 ~= u23 then
        local fromParams = u2.fromParams;
        local v63 = u1.get(u12, "Rate_Curve", u4.default_bezier);
        table.insert(u13, fromParams(v63, u52, function(p64, p65) -- Line: 141
            -- upvalues: u58 (ref), u4 (ref), u22 (ref), u23 (ref)
            u58 = u4.lerp(u22, u23, p64);

            return p65;
        end));
    end;

    local u66 = u1.get(u12, "Path_Curve", u4.linear_bezier);
    local success, result = pcall(function() -- Line: 150
        -- upvalues: u4 (ref), u66 (copy)
        return u4.deserializePath(u66);
    end);

    if not success then
        u3.error((`failed to decode bezier path data with error: {result}`));
    end;

    local u67 = u5.new(result, 0);
    table.insert(u13, u2.fromParams(u4.linear_bezier, u52, function(p68, p69) -- Line: 162
        -- upvalues: u56 (ref), u58 (ref), u52 (ref), u57 (ref), u67 (copy), u51 (copy), u55 (ref), u4 (ref), u11 (copy), u53 (ref), u29 (copy), u14 (copy), u20 (copy), u7 (ref), u40 (copy), u41 (copy), u9 (ref), u12 (copy), u13 (copy), u49 (copy), u30 (copy), u33 (copy), u32 (copy), u2 (ref), u1 (ref), u35 (copy), u59 (ref), u38 (copy), u44 (copy), u46 (copy), u54 (copy), u37 (copy), u39 (copy), u45 (copy), u47 (copy), u34 (copy), u36 (copy), u50 (copy), u48 (copy)
        u56 = u56 + p69;
        local v70 = 1 / u58;
        local v71 = u52 * u58;

        if u56 < v70 or v71 <= u57 then
            return p69;
        end;

        for _ = 1, u56 // v70 do
            if v71 > u57 then
                u57 = u57 + 1;
                local v72 = 1 - u67:getEase((math.clamp(u57 / v71, 0, 1))).y;

                if u51 then
                    u55 = u4.getTransformedOriginExtents(u11);
                end;

                local v73 = u4.getTransformedOriginExtents(u11);
                local v74 = workspace:Raycast(u55.Position + u55:VectorToWorldSpace(u53) * u29 * v72, v73:VectorToWorldSpace(u14), u20);

                if not v74 then
                    u56 = 0;

                    return p69;
                end;

                local v75 = u7:NextNumber(u40.X, u41.X);
                local v76 = u7:NextNumber(u40.Y, u41.Y);
                local v77 = u7:NextNumber(u40.Z, u41.Z);
                local u78 = u4.getRandomId();
                local u79 = u9:get(u78);
                local u80 = u79._getReal();
                u4.copyProperties(u12, u80, u4.COPY_PART_PROPERTIES);
                u4.copyProperties(u12, u80, u4.COPY_EXTENDED_PART_PROPERTIES);

                if #u12:GetChildren() ~= 0 then
                    local v81 = u12:Clone();

                    for _, child in v81:GetChildren() do
                        child.Parent = u80;
                    end;

                    v81:Destroy();
                end;

                local u82 = u13.effects.prepareEmitOnFinish(u80, u13);
                table.insert(u13, function() -- Line: 226
                    -- upvalues: u9 (ref), u78 (copy)
                    if u9 then
                        u9:free(u78);
                    end;
                end);
                u79.Color = v74.Instance.Color;
                u79.Material = v74.Material;
                u79.Transparency = v74.Instance.Transparency;

                if u79.Transparency == 0 then
                    u79.Transparency = u49;
                end;

                u79.Size = Vector3.new(0, 0, 0);
                local v83 = u7:NextNumber(u30.Min, u30.Max);
                local v84 = -math.cos(v83);
                local v85 = -math.sin(v83);
                local Unit2 = v73:VectorToWorldSpace((Vector3.new(v84, 0, v85))):Cross(v74.Normal).Unit;
                local u86 = CFrame.fromMatrix(v74.Position, Unit2, v74.Normal) * CFrame.fromOrientation(-math.atan(v76 / v77), 0, 0);
                u79.CFrame = CFrame.new(u33) * u86;
                local u87 = nil;
                local u88 = nil;
                local u89 = Vector3.new(0, 0, 0);

                if u33 ~= u32 then
                    u88 = u2.fromParams(u1.get(u12, "Offset_Start_Curve", u4.default_bezier), u35, function(p90, p91) -- Line: 264
                        -- upvalues: u89 (ref), u33 (ref), u32 (ref), u79 (copy), u86 (copy)
                        u89 = u33:Lerp(u32, p90);
                        u79.CFrame = CFrame.new(u89) * u86;

                        return p91;
                    end);
                    table.insert(u13, u88);
                end;

                local u92 = Vector3.new(v75, v76, v77) * u59;

                if u92 * u38 == u92 then
                    u79.Size = u92 * u38;
                else
                    u87 = u2.fromParams(u44, u46, function(p93, p94) -- Line: 277
                        -- upvalues: u79 (copy), u92 (copy), u38 (ref)
                        u79.Size = (u92 * u38):Lerp(u92, p93);

                        return p94;
                    end);
                    table.insert(u13, u87);
                end;

                local Finished = u13.effects.emitNested(u80, u13.depth + 1, u13).Finished;
                table.insert(u54, Finished);
                task.delay(u7:NextNumber(u37.Min, u37.Max), function() -- Line: 290
                    -- upvalues: u87 (ref), u88 (ref), u79 (copy), u92 (copy), u39 (ref), u13 (ref), u2 (ref), u45 (ref), u47 (ref), u89 (ref), u34 (ref), u1 (ref), u12 (ref), u4 (ref), u36 (ref), u86 (copy), u50 (ref), u48 (ref), u82 (copy), u80 (copy), u54 (ref)
                    if u87 then
                        u87:Disconnect();
                    end;

                    if u88 then
                        u88:Disconnect();
                    end;

                    local Size = u79.Size;
                    local Transparency = u79.Transparency;

                    if Size ~= u92 * u39 then
                        table.insert(u13, u2.fromParams(u45, u47, function(p95, p96) -- Line: 305
                            -- upvalues: u79 (ref), Size (copy), u92 (ref), u39 (ref)
                            u79.Size = Size:Lerp(u92 * u39, p95);

                            return p96;
                        end));
                    end;

                    if u89 ~= u34 then
                        local fromParams = u2.fromParams;
                        local v97 = u1.get(u12, "Offset_End_Curve", u4.default_bezier);
                        table.insert(u13, fromParams(v97, u36, function(p98, p99) -- Line: 318
                            -- upvalues: u79 (ref), u89 (ref), u34 (ref), u86 (ref)
                            u79.CFrame = CFrame.new(u89:Lerp(u34, p98)) * u86;

                            return p99;
                        end));
                    end;

                    if Transparency ~= u50 then
                        local fromParams = u2.fromParams;
                        local v100 = u1.get(u12, "Transparency_Curve", u4.default_bezier);
                        table.insert(u13, fromParams(v100, u48, function(p101, p102) -- Line: 332
                            -- upvalues: u79 (ref), u4 (ref), Transparency (copy), u50 (ref)
                            u79.Transparency = u4.lerp(Transparency, u50, p101);

                            return p102;
                        end));
                    end;

                    local Finished2 = u13.effects.emitOnFinish(u82, u80, u13.depth + 1, u13).Finished;
                    table.insert(u54, Finished2);
                end);
            end;
        end;

        u56 = u56 % v70;

        return p69;
    end, nil, nil, true, u4.RENDER_PRIORITY + u13.depth));
    task.wait(u37.Max + u52 + math.max(u47, u36));
    u6.all(u54):await();
end;

return v8;