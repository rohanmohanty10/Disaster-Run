 

 

local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/tween");
require("../types");
local u2 = require("../mod/logger");
local u3 = require("../mod/utility");
local u4 = require("../obj/Bezier");
local u5 = require("../pkg/Promise");
require("../obj/ObjectCache");
local Random_new_ret = Random.new();
local v6 = {};
local u7 = nil;

function v6.init(p8) -- Line: 18
    -- upvalues: u7 (ref)
    u7 = p8;
end;

function v6.deinit() -- Line: 22
    -- upvalues: u7 (ref)
    u7 = nil;
end;

function v6.emit(u9: userdata, u10: userdata, u11: any) -- Line: 26
    -- upvalues: u7 (ref), u3 (copy), CollectionService (copy), u1 (copy), u2 (copy), u4 (copy), Random_new_ret (copy), u5 (copy)
    if not u7 then
        return;
    end;

    local Attribute = u3.getAttribute(u9, "RayDirection", Vector3.new(0, -50, 0));
    local Attribute2 = u3.getAttribute(u9, "RayCollisionGroup", "Default");
    local Attribute3 = u3.getAttribute(u9, "FilterTag", "");
    local Attribute4 = u3.getAttribute(u9, "FilterType", "Exclude");
    local Attribute5 = u3.getAttribute(u9, "IgnoreWater", true);
    local Attribute6 = u3.getAttribute(u9, "IgnoreCanCollide", false);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.CollisionGroup = Attribute2;
    RaycastParams_new_ret.IgnoreWater = Attribute5;
    RaycastParams_new_ret.RespectCanCollide = not Attribute6;
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType[Attribute4];
    RaycastParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged(Attribute3);

    if Attribute4 == "Exclude" then
        RaycastParams_new_ret:AddToFilter({ workspace.Terrain });
    end;

    local Attribute7 = u3.getAttribute(u10, "EmitDelay", 0);
    local Attribute8 = u3.getAttribute(u10, "Rate_Start", 30);
    local Attribute9 = u3.getAttribute(u10, "Rate_End", 30);
    local Attribute10 = u3.getAttribute(u10, "FixedAmount", 0);
    local Attribute11 = u3.getAttribute(u10, "Scale_Start", 1);
    local Attribute12 = u3.getAttribute(u10, "Scale_End", 1);
    local Attribute13 = u3.getAttribute(u10, "Duration", 1);
    local Attribute14 = u3.getAttribute(u10, "Direction", Vector3.new(0, 0, -1));
    local Attribute15 = u3.getAttribute(u10, "Length", 50);
    local RangeAttribute = u3.getRangeAttribute(u10, "Rotation", NumberRange.new(-180, 180));
    local Attribute16 = u3.getAttribute(u10, "PartOffset", Vector3.new(0, 0, 0), true);
    local Attribute17 = u3.getAttribute(u10, "BaseOffset", Attribute16);
    local Attribute18 = u3.getAttribute(u10, "Offset_Start", Attribute16);
    local Attribute19 = u3.getAttribute(u10, "Offset_End", Attribute16);
    local Attribute20 = u3.getAttribute(u10, "Offset_Start_Duration", 0.5);
    local Attribute21 = u3.getAttribute(u10, "Offset_End_Duration", 0.5);
    local RangeAttribute2 = u3.getRangeAttribute(u10, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local Attribute22 = u3.getAttribute(u10, "SizeScaleStart", Vector3.new(0, 0, 0));
    local Attribute23 = u3.getAttribute(u10, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local Attribute24 = u3.getAttribute(u10, "MinSize", Vector3.new(2, 1, 2));
    local Attribute25 = u3.getAttribute(u10, "MaxSize", Vector3.new(3, 2, 3));
    local Attribute26 = u3.getAttribute(u10, "Size_Curve", u3.default_bezier, true);
    local Attribute27 = u3.getAttribute(u10, "Size_Duration", 0.5, true);
    local Attribute28 = u3.getAttribute(u10, "Size_Start_Curve", Attribute26);
    local Attribute29 = u3.getAttribute(u10, "Size_End_Curve", Attribute26);
    local Attribute30 = u3.getAttribute(u10, "Size_Start_Duration", Attribute27);
    local Attribute31 = u3.getAttribute(u10, "Size_End_Duration", Attribute27);
    local Attribute32 = u3.getAttribute(u10, "Transparency_Duration", 0.5);
    local Attribute33 = u3.getAttribute(u10, "Transparency_Start", 0);
    local Attribute34 = u3.getAttribute(u10, "Transparency_End", 0);
    local Attribute35 = u3.getAttribute(u10, "SyncPosition", false);
    local math_max_ret = math.max(Attribute13, 0.001);

    if Attribute10 > 0 then
        Attribute8 = Attribute10 / math_max_ret;
        Attribute9 = Attribute8;
    end;

    local Unit = Attribute14.Unit;
    local u12 = Unit ~= Unit and Vector3.new(-0, -0, -1) or Unit;
    task.wait(Attribute7);
    local u13 = {};
    local TransformedOriginExtents = u3.getTransformedOriginExtents(u9);
    local u14 = 0;
    local u15 = 0;
    local u16 = Attribute8;
    local u17 = Attribute11;

    if Attribute11 ~= Attribute12 then
        local fromParams = u1.fromParams;
        local Attribute36 = u3.getAttribute(u10, "Scale_Curve", u3.default_bezier);
        table.insert(u11, fromParams(Attribute36, math_max_ret, function(p18, p19) -- Line: 133
            -- upvalues: u17 (ref), u3 (ref), Attribute11 (copy), Attribute12 (copy)
            u17 = u3.lerp(Attribute11, Attribute12, p18);

            return p19;
        end));
    end;

    if Attribute8 ~= Attribute9 then
        local fromParams = u1.fromParams;
        local Attribute36 = u3.getAttribute(u10, "Rate_Curve", u3.default_bezier);
        table.insert(u11, fromParams(Attribute36, math_max_ret, function(p20, p21) -- Line: 147
            -- upvalues: u16 (ref), u3 (ref), Attribute8 (ref), Attribute9 (ref)
            u16 = u3.lerp(Attribute8, Attribute9, p20);

            return p21;
        end));
    end;

    local Attribute36 = u3.getAttribute(u10, "Path_Curve", u3.linear_bezier);
    local success, result = pcall(function() -- Line: 157
        -- upvalues: u3 (ref), Attribute36 (copy)
        return u3.deserializePath(Attribute36);
    end);

    if not success then
        u2.error((`failed to decode bezier path data with error: {result}`));
    end;

    local u22 = u4.new(result, 0);
    table.insert(u11, u1.fromParams(u3.linear_bezier, math_max_ret, function(p23, p24) -- Line: 169
        -- upvalues: u14 (ref), u16 (ref), math_max_ret (ref), u15 (ref), u22 (copy), Attribute35 (copy), TransformedOriginExtents (ref), u3 (ref), u9 (copy), u12 (ref), Attribute15 (copy), Attribute (copy), RaycastParams_new_ret (copy), Random_new_ret (ref), Attribute24 (copy), Attribute25 (copy), u7 (ref), u10 (copy), u11 (copy), Attribute33 (copy), RangeAttribute (copy), Attribute18 (copy), Attribute17 (copy), u1 (ref), Attribute20 (copy), u17 (ref), Attribute22 (copy), Attribute28 (copy), Attribute30 (copy), u13 (copy), RangeAttribute2 (copy), Attribute23 (copy), Attribute29 (copy), Attribute31 (copy), Attribute19 (copy), Attribute21 (copy), Attribute34 (copy), Attribute32 (copy)
        u14 = u14 + p24;
        local v25 = 1 / u16;
        local v26 = math_max_ret * u16;

        if u14 < v25 or v26 <= u15 then
            return p24;
        end;

        for i = 1, u14 // v25 do
            local v27;

            if v26 <= u15 then
                v27 = i;
            else
                u15 = u15 + 1;
                local v28 = 1 - u22:getEase((math.clamp(u15 / v26, 0, 1))).y;

                if Attribute35 then
                    TransformedOriginExtents = u3.getTransformedOriginExtents(u9);
                end;

                local TransformedOriginExtents2 = u3.getTransformedOriginExtents(u9);
                local v29 = workspace:Raycast(TransformedOriginExtents.Position + TransformedOriginExtents:VectorToWorldSpace(u12) * Attribute15 * v28, TransformedOriginExtents2:VectorToWorldSpace(Attribute), RaycastParams_new_ret);

                if not v29 then
                    u14 = 0;

                    return p24;
                end;

                local v30 = Random_new_ret:NextNumber(Attribute24.X, Attribute25.X);
                local v31 = Random_new_ret:NextNumber(Attribute24.Y, Attribute25.Y);
                local v32 = Random_new_ret:NextNumber(Attribute24.Z, Attribute25.Z);
                local RandomId = u3.getRandomId();
                local u33 = u7:get(RandomId);
                local u34 = u33._getReal();
                u3.copyProperties(u10, u34, u3.COPY_PART_PROPERTIES);
                u3.copyProperties(u10, u34, u3.COPY_EXTENDED_PART_PROPERTIES);

                if #u10:GetChildren() == 0 then
                    v27 = i;
                else
                    local v35 = u10:Clone();
                    v27 = i;

                    for _, child in v35:GetChildren() do
                        child.Parent = u34;
                    end;

                    v35:Destroy();
                end;

                local u36 = u11.effects.prepareEmitOnFinish(u34, u11);
                table.insert(u11, function() -- Line: 233
                    -- upvalues: u7 (ref), RandomId (copy)
                    if u7 then
                        u7:free(RandomId);
                    end;
                end);
                u33.Color = v29.Instance.Color;
                u33.Material = v29.Material;
                u33.Transparency = v29.Instance.Transparency;

                if u33.Transparency == 0 then
                    u33.Transparency = Attribute33;
                end;

                u33.Size = Vector3.new(0, 0, 0);
                local v37 = Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max);
                local v38 = -math.cos(v37);
                local v39 = -math.sin(v37);
                local Unit2 = TransformedOriginExtents2:VectorToWorldSpace((Vector3.new(v38, 0, v39))):Cross(v29.Normal).Unit;
                local u40 = CFrame.fromMatrix(v29.Position, Unit2, v29.Normal) * CFrame.fromOrientation(-math.atan(v31 / v32), 0, 0);
                u33.CFrame = CFrame.new(Attribute18) * u40;
                local u41 = nil;
                local u42 = nil;
                local u43 = Vector3.new(0, 0, 0);

                if Attribute18 ~= Attribute17 then
                    u42 = u1.fromParams(u3.getAttribute(u10, "Offset_Start_Curve", u3.default_bezier), Attribute20, function(p44, p45) -- Line: 271
                        -- upvalues: u43 (ref), Attribute18 (ref), Attribute17 (ref), u33 (copy), u40 (copy)
                        u43 = Attribute18:Lerp(Attribute17, p44);
                        u33.CFrame = CFrame.new(u43) * u40;

                        return p45;
                    end);
                    table.insert(u11, u42);
                end;

                local u46 = Vector3.new(v30, v31, v32) * u17;

                if u46 * Attribute22 == u46 then
                    u33.Size = u46 * Attribute22;
                else
                    u41 = u1.fromParams(Attribute28, Attribute30, function(p47, p48) -- Line: 284
                        -- upvalues: u33 (copy), u46 (copy), Attribute22 (ref)
                        u33.Size = (u46 * Attribute22):Lerp(u46, p47);

                        return p48;
                    end);
                    table.insert(u11, u41);
                end;

                local Finished = u11.effects.emitNested(u34, u11.depth + 1).Finished;
                table.insert(u13, Finished);
                task.delay(Random_new_ret:NextNumber(RangeAttribute2.Min, RangeAttribute2.Max), function() -- Line: 297
                    -- upvalues: u41 (ref), u42 (ref), u33 (copy), u46 (copy), Attribute23 (ref), u11 (ref), u1 (ref), Attribute29 (ref), Attribute31 (ref), u43 (ref), Attribute19 (ref), u3 (ref), u10 (ref), Attribute21 (ref), u40 (copy), Attribute34 (ref), Attribute32 (ref), u36 (copy), u34 (copy), u13 (ref)
                    if u41 then
                        u41:Disconnect();
                    end;

                    if u42 then
                        u42:Disconnect();
                    end;

                    local Size = u33.Size;
                    local Transparency = u33.Transparency;

                    if Size ~= u46 * Attribute23 then
                        table.insert(u11, u1.fromParams(Attribute29, Attribute31, function(p49, p50) -- Line: 312
                            -- upvalues: u33 (ref), Size (copy), u46 (ref), Attribute23 (ref)
                            u33.Size = Size:Lerp(u46 * Attribute23, p49);

                            return p50;
                        end));
                    end;

                    if u43 ~= Attribute19 then
                        local fromParams = u1.fromParams;
                        local Attribute37 = u3.getAttribute(u10, "Offset_End_Curve", u3.default_bezier);
                        table.insert(u11, fromParams(Attribute37, Attribute21, function(p51, p52) -- Line: 325
                            -- upvalues: u33 (ref), u43 (ref), Attribute19 (ref), u40 (ref)
                            u33.CFrame = CFrame.new(u43:Lerp(Attribute19, p51)) * u40;

                            return p52;
                        end));
                    end;

                    if Transparency ~= Attribute34 then
                        local fromParams = u1.fromParams;
                        local Attribute37 = u3.getAttribute(u10, "Transparency_Curve", u3.default_bezier);
                        table.insert(u11, fromParams(Attribute37, Attribute32, function(p53, p54) -- Line: 339
                            -- upvalues: u33 (ref), u3 (ref), Transparency (copy), Attribute34 (ref)
                            u33.Transparency = u3.lerp(Transparency, Attribute34, p53);

                            return p54;
                        end));
                    end;

                    local Finished2 = u11.effects.emitOnFinish(u36, u34, u11.depth + 1).Finished;
                    table.insert(u13, Finished2);
                end);
            end;
        end;

        u14 = u14 % v25;

        return p24;
    end, nil, nil, true, u3.RENDER_PRIORITY + u11.depth));
    task.wait(RangeAttribute2.Max + math_max_ret + math.max(Attribute31, Attribute21));
    u5.all(u13):await();
end;

return v6;