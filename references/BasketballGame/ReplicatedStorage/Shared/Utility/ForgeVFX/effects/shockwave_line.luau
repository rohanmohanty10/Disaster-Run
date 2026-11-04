 
 

local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/tween");
local u2 = require("../mod/logger");
local u3 = require("../mod/utility");
local u4 = require("../obj/Bezier");
local u5 = require("../pkg/Promise");
require("../obj/ObjectCache");
local Random_new_ret = Random.new();
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

function v6.emit(u9: userdata, u10: userdata, u11: any) -- Line: 25
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
    local WorldCFrame = u9.WorldCFrame;
    local u14 = 0;
    local u15 = 0;
    local u16 = Attribute8;
    local u17 = Attribute11;

    if Attribute11 ~= Attribute12 then
        local fromParams = u1.fromParams;
        local Attribute36 = u3.getAttribute(u10, "Scale_Curve", u3.default_bezier);
        table.insert(u11, fromParams(Attribute36, math_max_ret, function(p18, p19) -- Line: 132
            -- upvalues: u17 (ref), u3 (ref), Attribute11 (copy), Attribute12 (copy)
            u17 = u3.lerp(Attribute11, Attribute12, p18);

            return p19;
        end));
    end;

    if Attribute8 ~= Attribute9 then
        local fromParams = u1.fromParams;
        local Attribute36 = u3.getAttribute(u10, "Rate_Curve", u3.default_bezier);
        table.insert(u11, fromParams(Attribute36, math_max_ret, function(p20, p21) -- Line: 146
            -- upvalues: u16 (ref), u3 (ref), Attribute8 (ref), Attribute9 (ref)
            u16 = u3.lerp(Attribute8, Attribute9, p20);

            return p21;
        end));
    end;

    local Attribute36 = u3.getAttribute(u10, "Path_Curve", u3.linear_bezier);
    local success, result = pcall(function() -- Line: 156
        -- upvalues: u3 (ref), Attribute36 (copy)
        return u3.deserializePath(Attribute36);
    end);

    if not success then
        u2.error((`failed to decode bezier path data with error: {result}`));
    end;

    local u22 = u4.new(result, 0);
    table.insert(u11, u1.fromParams(u3.linear_bezier, math_max_ret, function(p23, p24) -- Line: 168
        -- upvalues: u14 (ref), u16 (ref), math_max_ret (ref), u15 (ref), u22 (copy), Attribute35 (copy), WorldCFrame (ref), u9 (copy), u12 (ref), Attribute15 (copy), Attribute (copy), RaycastParams_new_ret (copy), Random_new_ret (ref), Attribute24 (copy), Attribute25 (copy), u3 (ref), u7 (ref), u10 (copy), u11 (copy), Attribute33 (copy), RangeAttribute (copy), Attribute18 (copy), Attribute17 (copy), u1 (ref), Attribute20 (copy), u17 (ref), Attribute22 (copy), Attribute28 (copy), Attribute30 (copy), u13 (copy), RangeAttribute2 (copy), Attribute23 (copy), Attribute29 (copy), Attribute31 (copy), Attribute19 (copy), Attribute21 (copy), Attribute34 (copy), Attribute32 (copy)
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
                    WorldCFrame = u9.WorldCFrame;
                end;

                local v29 = workspace:Raycast(WorldCFrame.Position + WorldCFrame:VectorToWorldSpace(u12) * Attribute15 * v28, u9.WorldCFrame:VectorToWorldSpace(Attribute), RaycastParams_new_ret);

                if not v29 then
                    u14 = 0;

                    return p24;
                end;

                local v30 = Random_new_ret:NextNumber(Attribute24.X, Attribute25.X);
                local v31 = Random_new_ret:NextNumber(Attribute24.Y, Attribute25.Y);
                local v32 = Random_new_ret:NextNumber(Attribute24.Z, Attribute25.Z);
                local RanomId = u3.getRanomId();
                local u33 = u7:get(RanomId);
                local v34 = u33._getReal();
                u3.copyProperties(u10, v34, u3.COPY_PART_PROPERTIES);
                u3.copyProperties(u10, v34, u3.COPY_EXTENDED_PART_PROPERTIES);

                if #u10:GetChildren() == 0 then
                    v27 = i;
                else
                    local v35 = u10:Clone();
                    v27 = i;

                    for _, child in v35:GetChildren() do
                        child.Parent = v34;
                    end;

                    v35:Destroy();
                end;

                table.insert(u11, function() -- Line: 229
                    -- upvalues: u7 (ref), RanomId (copy)
                    if u7 then
                        u7:free(RanomId);
                    end;
                end);
                u33.Color = v29.Instance.Color;
                u33.Material = v29.Material;
                u33.Transparency = v29.Instance.Transparency;

                if u33.Transparency == 0 then
                    u33.Transparency = Attribute33;
                end;

                u33.Size = Vector3.new(0, 0, 0);
                local v36 = Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max);
                local v37 = -math.cos(v36);
                local v38 = -math.sin(v36);
                local Unit2 = u9.WorldCFrame:VectorToWorldSpace((Vector3.new(v37, 0, v38))):Cross(v29.Normal).Unit;
                local u39 = CFrame.fromMatrix(v29.Position, Unit2, v29.Normal) * CFrame.fromOrientation(-math.atan(v31 / v32), 0, 0);
                u33.CFrame = CFrame.new(Attribute18) * u39;
                local u40 = nil;
                local u41 = nil;
                local u42 = Vector3.new(0, 0, 0);

                if Attribute18 ~= Attribute17 then
                    u41 = u1.fromParams(u3.getAttribute(u10, "Offset_Start_Curve", u3.default_bezier), Attribute20, function(p43, p44) -- Line: 267
                        -- upvalues: u42 (ref), Attribute18 (ref), Attribute17 (ref), u33 (copy), u39 (copy)
                        u42 = Attribute18:Lerp(Attribute17, p43);
                        u33.CFrame = CFrame.new(u42) * u39;

                        return p44;
                    end);
                    table.insert(u11, u41);
                end;

                local u45 = Vector3.new(v30, v31, v32) * u17;

                if u45 * Attribute22 == u45 then
                    u33.Size = u45 * Attribute22;
                else
                    u40 = u1.fromParams(Attribute28, Attribute30, function(p46, p47) -- Line: 280
                        -- upvalues: u33 (copy), u45 (copy), Attribute22 (ref)
                        u33.Size = (u45 * Attribute22):Lerp(u45, p46);

                        return p47;
                    end);
                    table.insert(u11, u40);
                end;

                if shared.vfx and #u33:GetChildren() ~= 0 then
                    local Finished = shared.vfx.emit(v34).Finished;
                    table.insert(u13, Finished);
                end;

                task.delay(Random_new_ret:NextNumber(RangeAttribute2.Min, RangeAttribute2.Max), function() -- Line: 295
                    -- upvalues: u40 (ref), u41 (ref), u33 (copy), u45 (copy), Attribute23 (ref), u11 (ref), u1 (ref), Attribute29 (ref), Attribute31 (ref), u42 (ref), Attribute19 (ref), u3 (ref), u10 (ref), Attribute21 (ref), u39 (copy), Attribute34 (ref), Attribute32 (ref)
                    if u40 then
                        u40:Disconnect();
                    end;

                    if u41 then
                        u41:Disconnect();
                    end;

                    local Size = u33.Size;
                    local Transparency = u33.Transparency;

                    if Size ~= u45 * Attribute23 then
                        table.insert(u11, u1.fromParams(Attribute29, Attribute31, function(p48, p49) -- Line: 310
                            -- upvalues: u33 (ref), Size (copy), u45 (ref), Attribute23 (ref)
                            u33.Size = Size:Lerp(u45 * Attribute23, p48);

                            return p49;
                        end));
                    end;

                    if u42 ~= Attribute19 then
                        local fromParams = u1.fromParams;
                        local Attribute37 = u3.getAttribute(u10, "Offset_End_Curve", u3.default_bezier);
                        table.insert(u11, fromParams(Attribute37, Attribute21, function(p50, p51) -- Line: 323
                            -- upvalues: u33 (ref), u42 (ref), Attribute19 (ref), u39 (ref)
                            u33.CFrame = CFrame.new(u42:Lerp(Attribute19, p50)) * u39;

                            return p51;
                        end));
                    end;

                    if Transparency == Attribute34 then
                        u33.Transparency = Transparency;

                        return;
                    end;

                    local fromParams = u1.fromParams;
                    local Attribute37 = u3.getAttribute(u10, "Transparency_Curve", u3.default_bezier);
                    table.insert(u11, fromParams(Attribute37, Attribute32, function(p52, p53) -- Line: 337
                        -- upvalues: u33 (ref), u3 (ref), Transparency (copy), Attribute34 (ref)
                        u33.Transparency = u3.lerp(Transparency, Attribute34, p52);

                        return p53;
                    end));
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