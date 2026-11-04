  

local CollectionService = game:GetService("CollectionService");
local u1 = require("./mod/tween");
local u2 = require("./mod/logger");
local u3 = require("./mod/utility");
local u4 = require("./obj/Bezier");
require("./obj/ObjectCache");
local Promise = require(script.Parent.obj.Promise);
local Random_new_ret = Random.new();
local v5 = {};
local u6 = nil;

function v5.init(p7) -- Line: 18
    -- upvalues: u6 (ref)
    u6 = p7;
end;

function v5.deinit() -- Line: 22
    -- upvalues: u6 (ref)
    u6 = nil;
end;

function v5.emit(u8: userdata, u9: userdata, u10: any) -- Line: 26
    -- upvalues: u6 (ref), u3 (copy), CollectionService (copy), u1 (copy), u2 (copy), u4 (copy), Random_new_ret (copy), Promise (copy)
    if not u6 then
        return;
    end;

    local Attribute = u3.getAttribute(u8, "RayDirection", Vector3.new(0, -50, 0));
    local Attribute2 = u3.getAttribute(u8, "RayCollisionGroup", "Default");
    local Attribute3 = u3.getAttribute(u8, "FilterTag", "");
    local Attribute4 = u3.getAttribute(u8, "FilterType", "Exclude");
    local Attribute5 = u3.getAttribute(u8, "IgnoreWater", true);
    local Attribute6 = u3.getAttribute(u8, "IgnoreCanCollide", false);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.CollisionGroup = Attribute2;
    RaycastParams_new_ret.IgnoreWater = Attribute5;
    RaycastParams_new_ret.RespectCanCollide = not Attribute6;
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType[Attribute4];
    RaycastParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged(Attribute3);

    if Attribute4 == "Exclude" then
        RaycastParams_new_ret:AddToFilter({ workspace.Terrain });
    end;

    local Attribute7 = u3.getAttribute(u9, "EmitDelay", 0);
    local Attribute8 = u3.getAttribute(u9, "Rate_Start", 30);
    local Attribute9 = u3.getAttribute(u9, "Rate_End", 30);
    local Attribute10 = u3.getAttribute(u9, "FixedAmount", 0);
    local Attribute11 = u3.getAttribute(u9, "Scale_Start", 1);
    local Attribute12 = u3.getAttribute(u9, "Scale_End", 1);
    local Attribute13 = u3.getAttribute(u9, "Duration", 1);
    local Attribute14 = u3.getAttribute(u9, "Direction", Vector3.new(0, 0, -1));
    local Attribute15 = u3.getAttribute(u9, "Length", 50);
    local RangeAttribute = u3.getRangeAttribute(u9, "Rotation", NumberRange.new(-180, 180));
    local Attribute16 = u3.getAttribute(u9, "PartOffset", Vector3.new(0, 0, 0), true);
    local Attribute17 = u3.getAttribute(u9, "BaseOffset", Attribute16);
    local Attribute18 = u3.getAttribute(u9, "Offset_Start", Attribute16);
    local Attribute19 = u3.getAttribute(u9, "Offset_End", Attribute16);
    local Attribute20 = u3.getAttribute(u9, "Offset_Start_Duration", 0.5);
    local Attribute21 = u3.getAttribute(u9, "Offset_End_Duration", 0.5);
    local RangeAttribute2 = u3.getRangeAttribute(u9, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local Attribute22 = u3.getAttribute(u9, "SizeScaleStart", Vector3.new(0, 0, 0));
    local Attribute23 = u3.getAttribute(u9, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local Attribute24 = u3.getAttribute(u9, "MinSize", Vector3.new(2, 1, 2));
    local Attribute25 = u3.getAttribute(u9, "MaxSize", Vector3.new(3, 2, 3));
    local Attribute26 = u3.getAttribute(u9, "Size_Curve", u3.default_bezier, true);
    local Attribute27 = u3.getAttribute(u9, "Size_Duration", 0.5, true);
    local Attribute28 = u3.getAttribute(u9, "Size_Start_Curve", Attribute26);
    local Attribute29 = u3.getAttribute(u9, "Size_End_Curve", Attribute26);
    local Attribute30 = u3.getAttribute(u9, "Size_Start_Duration", Attribute27);
    local Attribute31 = u3.getAttribute(u9, "Size_End_Duration", Attribute27);
    local Attribute32 = u3.getAttribute(u9, "Transparency_Duration", 0.5);
    local Attribute33 = u3.getAttribute(u9, "Transparency_Start", 0);
    local Attribute34 = u3.getAttribute(u9, "Transparency_End", 0);
    local Attribute35 = u3.getAttribute(u9, "SyncPosition", false);
    local math_max_ret = math.max(Attribute13, 0.001);

    if Attribute10 > 0 then
        Attribute8 = Attribute10 / math_max_ret;
        Attribute9 = Attribute8;
    end;

    local Unit = Attribute14.Unit;
    local u11 = Unit ~= Unit and Vector3.new(-0, -0, -1) or Unit;
    task.wait(Attribute7);
    local u12 = {};
    local WorldCFrame = u8.WorldCFrame;
    local u13 = 0;
    local u14 = 0;
    local u15 = Attribute8;
    local u16 = Attribute11;

    if Attribute11 ~= Attribute12 then
        local fromParams = u1.fromParams;
        local Attribute36 = u3.getAttribute(u9, "Scale_Curve", u3.default_bezier);
        table.insert(u10, fromParams(Attribute36, math_max_ret, function(p17, p18) -- Line: 133
            -- upvalues: u16 (ref), u3 (ref), Attribute11 (copy), Attribute12 (copy)
            u16 = u3.lerp(Attribute11, Attribute12, p17);

            return p18;
        end));
    end;

    if Attribute8 ~= Attribute9 then
        local fromParams = u1.fromParams;
        local Attribute36 = u3.getAttribute(u9, "Rate_Curve", u3.default_bezier);
        table.insert(u10, fromParams(Attribute36, math_max_ret, function(p19, p20) -- Line: 147
            -- upvalues: u15 (ref), u3 (ref), Attribute8 (ref), Attribute9 (ref)
            u15 = u3.lerp(Attribute8, Attribute9, p19);

            return p20;
        end));
    end;

    local Attribute36 = u3.getAttribute(u9, "Path_Curve", u3.linear_bezier);
    local success, result = pcall(function() -- Line: 157
        -- upvalues: u3 (ref), Attribute36 (copy)
        return u3.deserializePath(Attribute36);
    end);

    if not success then
        u2.error((`failed to decode bezier path data with error: {result}`));
    end;

    local u21 = u4.new(result, 0);
    table.insert(u10, u1.fromParams(u3.linear_bezier, math_max_ret, function(p22, p23) -- Line: 169
        -- upvalues: u13 (ref), u15 (ref), math_max_ret (ref), u14 (ref), u21 (copy), Attribute35 (copy), WorldCFrame (ref), u8 (copy), u11 (ref), Attribute15 (copy), Attribute (copy), RaycastParams_new_ret (copy), Random_new_ret (ref), Attribute24 (copy), Attribute25 (copy), u3 (ref), u6 (ref), u9 (copy), u10 (copy), Attribute33 (copy), RangeAttribute (copy), Attribute18 (copy), Attribute17 (copy), u1 (ref), Attribute20 (copy), u16 (ref), Attribute22 (copy), Attribute28 (copy), Attribute30 (copy), u12 (copy), RangeAttribute2 (copy), Attribute23 (copy), Attribute29 (copy), Attribute31 (copy), Attribute19 (copy), Attribute21 (copy), Attribute34 (copy), Attribute32 (copy)
        u13 = u13 + p23;
        local v24 = 1 / u15;
        local v25 = math_max_ret * u15;

        if u13 < v24 or v25 <= u14 then
            return p23;
        end;

        for i = 1, u13 // v24 do
            local v26;

            if v25 <= u14 then
                v26 = i;
            else
                u14 = u14 + 1;
                local v27 = 1 - u21:getEase((math.clamp(u14 / v25, 0, 1))).y;

                if Attribute35 then
                    WorldCFrame = u8.WorldCFrame;
                end;

                local v28 = workspace:Raycast(WorldCFrame.Position + WorldCFrame:VectorToWorldSpace(u11) * Attribute15 * v27, u8.WorldCFrame:VectorToWorldSpace(Attribute), RaycastParams_new_ret);

                if not v28 then
                    u13 = 0;

                    return p23;
                end;

                local v29 = Random_new_ret:NextNumber(Attribute24.X, Attribute25.X);
                local v30 = Random_new_ret:NextNumber(Attribute24.Y, Attribute25.Y);
                local v31 = Random_new_ret:NextNumber(Attribute24.Z, Attribute25.Z);
                local RanomId = u3.getRanomId();
                local u32 = u6:get(RanomId);
                local v33 = u32._getReal();
                u3.copyProperties(u9, v33, u3.COPY_PART_PROPERTIES);
                u3.copyProperties(u9, v33, u3.COPY_EXTENDED_PART_PROPERTIES);

                if #u9:GetChildren() == 0 then
                    v26 = i;
                else
                    local v34 = u9:Clone();
                    v26 = i;

                    for _, child in v34:GetChildren() do
                        child.Parent = v33;
                    end;

                    v34:Destroy();
                end;

                table.insert(u10, function() -- Line: 230
                    -- upvalues: u6 (ref), RanomId (copy)
                    if u6 then
                        u6:free(RanomId);
                    end;
                end);
                u32.Color = v28.Instance.Color;
                u32.Material = v28.Material;
                u32.Transparency = v28.Instance.Transparency;

                if u32.Transparency == 0 then
                    u32.Transparency = Attribute33;
                end;

                u32.Size = Vector3.new(0, 0, 0);
                local v35 = Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max);
                local v36 = -math.cos(v35);
                local v37 = -math.sin(v35);
                local Unit2 = u8.WorldCFrame:VectorToWorldSpace((Vector3.new(v36, 0, v37))):Cross(v28.Normal).Unit;
                local u38 = CFrame.fromMatrix(v28.Position, Unit2, v28.Normal) * CFrame.fromOrientation(-math.atan(v30 / v31), 0, 0);
                u32.CFrame = CFrame.new(Attribute18) * u38;
                local u39 = nil;
                local u40 = nil;
                local u41 = Vector3.new(0, 0, 0);

                if Attribute18 ~= Attribute17 then
                    u40 = u1.fromParams(u3.getAttribute(u9, "Offset_Start_Curve", u3.default_bezier), Attribute20, function(p42, p43) -- Line: 268
                        -- upvalues: u41 (ref), Attribute18 (ref), Attribute17 (ref), u32 (copy), u38 (copy)
                        u41 = Attribute18:Lerp(Attribute17, p42);
                        u32.CFrame = CFrame.new(u41) * u38;

                        return p43;
                    end);
                    table.insert(u10, u40);
                end;

                local u44 = Vector3.new(v29, v30, v31) * u16;

                if u44 * Attribute22 == u44 then
                    u32.Size = u44 * Attribute22;
                else
                    u39 = u1.fromParams(Attribute28, Attribute30, function(p45, p46) -- Line: 281
                        -- upvalues: u32 (copy), u44 (copy), Attribute22 (ref)
                        u32.Size = (u44 * Attribute22):Lerp(u44, p45);

                        return p46;
                    end);
                    table.insert(u10, u39);
                end;

                if shared.vfx and #u32:GetChildren() ~= 0 then
                    local Finished = shared.vfx.emit(v33).Finished;
                    table.insert(u12, Finished);
                end;

                task.delay(Random_new_ret:NextNumber(RangeAttribute2.Min, RangeAttribute2.Max), function() -- Line: 296
                    -- upvalues: u39 (ref), u40 (ref), u32 (copy), u44 (copy), Attribute23 (ref), u10 (ref), u1 (ref), Attribute29 (ref), Attribute31 (ref), u41 (ref), Attribute19 (ref), u3 (ref), u9 (ref), Attribute21 (ref), u38 (copy), Attribute34 (ref), Attribute32 (ref)
                    if u39 then
                        u39:Disconnect();
                    end;

                    if u40 then
                        u40:Disconnect();
                    end;

                    local Size = u32.Size;
                    local Transparency = u32.Transparency;

                    if Size ~= u44 * Attribute23 then
                        table.insert(u10, u1.fromParams(Attribute29, Attribute31, function(p47, p48) -- Line: 311
                            -- upvalues: u32 (ref), Size (copy), u44 (ref), Attribute23 (ref)
                            u32.Size = Size:Lerp(u44 * Attribute23, p47);

                            return p48;
                        end));
                    end;

                    if u41 ~= Attribute19 then
                        local fromParams = u1.fromParams;
                        local Attribute37 = u3.getAttribute(u9, "Offset_End_Curve", u3.default_bezier);
                        table.insert(u10, fromParams(Attribute37, Attribute21, function(p49, p50) -- Line: 324
                            -- upvalues: u32 (ref), u41 (ref), Attribute19 (ref), u38 (ref)
                            u32.CFrame = CFrame.new(u41:Lerp(Attribute19, p49)) * u38;

                            return p50;
                        end));
                    end;

                    if Transparency == Attribute34 then
                        u32.Transparency = Transparency;

                        return;
                    end;

                    local fromParams = u1.fromParams;
                    local Attribute37 = u3.getAttribute(u9, "Transparency_Curve", u3.default_bezier);
                    table.insert(u10, fromParams(Attribute37, Attribute32, function(p51, p52) -- Line: 338
                        -- upvalues: u32 (ref), u3 (ref), Transparency (copy), Attribute34 (ref)
                        u32.Transparency = u3.lerp(Transparency, Attribute34, p51);

                        return p52;
                    end));
                end);
            end;
        end;

        u13 = u13 % v24;

        return p23;
    end, nil, nil, true, u3.RENDER_PRIORITY + u10.depth));
    task.wait(RangeAttribute2.Max + math_max_ret + math.max(Attribute31, Attribute21));
    Promise.all(u12):await();
end;

return v5;