  

local CollectionService = game:GetService("CollectionService");
local u1 = require("./mod/tween");
local u2 = require("./mod/utility");
local Promise = require(script.Parent.obj.Promise);
require("./obj/ObjectCache");
local Random_new_ret = Random.new();
local v3 = {};
local u4 = nil;

function v3.init(p5) -- Line: 15
    -- upvalues: u4 (ref)
    u4 = p5;
end;

function v3.deinit() -- Line: 19
    -- upvalues: u4 (ref)
    u4 = nil;
end;

function v3.emit(p6: userdata, u7: userdata, u8: any) -- Line: 23
    -- upvalues: u4 (ref), u2 (copy), CollectionService (copy), Random_new_ret (copy), u1 (copy), Promise (copy)
    if not u4 then
        return;
    end;

    local Attribute = u2.getAttribute(p6, "RayDirection", Vector3.new(0, -50, 0));
    local Attribute2 = u2.getAttribute(p6, "RayCollisionGroup", "Default");
    local Attribute3 = u2.getAttribute(p6, "FilterTag", "");
    local Attribute4 = u2.getAttribute(p6, "FilterType", "Exclude");
    local Attribute5 = u2.getAttribute(p6, "IgnoreWater", true);
    local Attribute6 = u2.getAttribute(p6, "IgnoreCanCollide", false);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.CollisionGroup = Attribute2;
    RaycastParams_new_ret.IgnoreWater = Attribute5;
    RaycastParams_new_ret.RespectCanCollide = not Attribute6;
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType[Attribute4];
    RaycastParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged(Attribute3);

    if Attribute4 == "Exclude" then
        RaycastParams_new_ret:AddToFilter({ workspace.Terrain });
    end;

    local Attribute7 = u2.getAttribute(u7, "EmitDelay", 0);
    local Attribute8 = u2.getAttribute(u7, "Radius", 5);
    local Attribute9 = u2.getAttribute(u7, "Segments", 7);
    local RangeAttribute = u2.getRangeAttribute(u7, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local Attribute10 = u2.getAttribute(u7, "PartOffset", Vector3.new(0, 0, 0), true);
    local Attribute11 = u2.getAttribute(u7, "BaseOffset", Attribute10);
    local Attribute12 = u2.getAttribute(u7, "Offset_Start", Attribute10);
    local Attribute13 = u2.getAttribute(u7, "Offset_End", Attribute10);
    local Attribute14 = u2.getAttribute(u7, "Offset_Start_Duration", 0.5);
    local Attribute15 = u2.getAttribute(u7, "Offset_End_Duration", 0.5);
    local Attribute16 = u2.getAttribute(u7, "SizeScaleStart", Vector3.new(0, 0, 0));
    local Attribute17 = u2.getAttribute(u7, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local Attribute18 = u2.getAttribute(u7, "MinSize", Vector3.new(2, 1, 2));
    local Attribute19 = u2.getAttribute(u7, "MaxSize", Vector3.new(3, 2, 3));
    local Attribute20 = u2.getAttribute(u7, "Size_Curve", u2.default_bezier, true);
    local Attribute21 = u2.getAttribute(u7, "Size_Duration", 0.5, true);
    local Attribute22 = u2.getAttribute(u7, "Size_Start_Curve", Attribute20);
    local Attribute23 = u2.getAttribute(u7, "Size_End_Curve", Attribute20);
    local Attribute24 = u2.getAttribute(u7, "Size_Start_Duration", Attribute21);
    local Attribute25 = u2.getAttribute(u7, "Size_End_Duration", Attribute21);
    local Attribute26 = u2.getAttribute(u7, "Transparency_Duration", 0.5);
    local Attribute27 = u2.getAttribute(u7, "Transparency_Start", 0);
    local Attribute28 = u2.getAttribute(u7, "Transparency_End", 0);
    task.wait(Attribute7);
    local v9 = {};

    for i = 0, Attribute9 - 1 do
        local v10 = i / Attribute9 * 3.141592653589793 * 2;
        local v11 = Attribute8 * math.cos(v10);
        local v12 = Attribute8 * math.sin(v10);
        local v13 = workspace:Raycast((p6.WorldCFrame * CFrame.new(v11, 0, v12)).Position, p6.WorldCFrame:VectorToWorldSpace(Attribute), RaycastParams_new_ret);
        local v14;

        if v13 then
            local v15 = Random_new_ret:NextNumber(Attribute18.X, Attribute19.X);
            local v16 = Random_new_ret:NextNumber(Attribute18.Y, Attribute19.Y);
            local v17 = Random_new_ret:NextNumber(Attribute18.Z, Attribute19.Z);
            local RanomId = u2.getRanomId();
            local u18 = u4:get(RanomId);
            local v19 = u18._getReal();
            u2.copyProperties(u7, v19, u2.COPY_PART_PROPERTIES);
            u2.copyProperties(u7, v19, u2.COPY_EXTENDED_PART_PROPERTIES);

            if #u7:GetChildren() == 0 then
                v14 = i;
            else
                local v20 = u7:Clone();
                v14 = i;

                for _, child in v20:GetChildren() do
                    child.Parent = v19;
                end;

                v20:Destroy();
            end;

            table.insert(u8, function() -- Line: 128
                -- upvalues: u4 (ref), RanomId (copy)
                if u4 then
                    u4:free(RanomId);
                end;
            end);
            u18.Color = v13.Instance.Color;
            u18.Material = v13.Material;
            u18.Transparency = v13.Instance.Transparency;

            if u18.Transparency == 0 then
                u18.Transparency = Attribute27;
            end;

            u18.Size = Vector3.new(0, 0, 0);
            local v21 = -math.cos(v10);
            local v22 = -math.sin(v10);
            local Unit = p6.WorldCFrame:VectorToWorldSpace((Vector3.new(v21, 0, v22))):Cross(v13.Normal).Unit;
            local u23 = CFrame.fromMatrix(v13.Position, Unit, v13.Normal) * CFrame.fromOrientation(-math.atan(v16 / v17), 0, 0);
            u18.CFrame = CFrame.new(Attribute12) * u23;
            local u24 = nil;
            local u25 = nil;
            local u26 = Vector3.new(0, 0, 0);

            if Attribute12 ~= Attribute11 then
                u25 = u1.fromParams(u2.getAttribute(u7, "Offset_Start_Curve", u2.default_bezier), Attribute14, function(p27, p28) -- Line: 164
                    -- upvalues: u26 (ref), Attribute12 (copy), Attribute11 (copy), u18 (copy), u23 (copy)
                    u26 = Attribute12:Lerp(Attribute11, p27);
                    u18.CFrame = CFrame.new(u26) * u23;

                    return p28;
                end);
                table.insert(u8, u24);
            end;

            local Vector3_new_ret = Vector3.new(v15, v16, v17);

            if Vector3_new_ret * Attribute16 == Vector3_new_ret then
                u18.Size = Vector3_new_ret * Attribute16;
            else
                u24 = u1.fromParams(Attribute22, Attribute24, function(p29, p30) -- Line: 177
                    -- upvalues: u18 (copy), Vector3_new_ret (copy), Attribute16 (copy)
                    u18.Size = (Vector3_new_ret * Attribute16):Lerp(Vector3_new_ret, p29);

                    return p30;
                end);
                table.insert(u8, u24);
            end;

            if shared.vfx and #u18:GetChildren() ~= 0 then
                local Finished = shared.vfx.emit(u18).Finished;
                table.insert(v9, Finished);
            end;

            task.delay(Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max), function() -- Line: 192
                -- upvalues: u24 (ref), u25 (ref), u18 (copy), Vector3_new_ret (copy), Attribute17 (copy), u8 (copy), u1 (ref), Attribute23 (copy), Attribute25 (copy), u26 (ref), Attribute13 (copy), u2 (ref), u7 (copy), Attribute15 (copy), u23 (copy), Attribute28 (copy), Attribute26 (copy)
                if u24 then
                    u24:Disconnect();
                end;

                if u25 then
                    u25:Disconnect();
                end;

                local Size = u18.Size;
                local Transparency = u18.Transparency;

                if Size ~= Vector3_new_ret * Attribute17 then
                    table.insert(u8, u1.fromParams(Attribute23, Attribute25, function(p31, p32) -- Line: 207
                        -- upvalues: u18 (ref), Size (copy), Vector3_new_ret (ref), Attribute17 (ref)
                        u18.Size = Size:Lerp(Vector3_new_ret * Attribute17, p31);

                        return p32;
                    end));
                end;

                if u26 ~= Attribute13 then
                    local fromParams = u1.fromParams;
                    local Attribute29 = u2.getAttribute(u7, "Offset_End_Curve", u2.default_bezier);
                    table.insert(u8, fromParams(Attribute29, Attribute15, function(p33, p34) -- Line: 220
                        -- upvalues: u18 (ref), u26 (ref), Attribute13 (ref), u23 (ref)
                        u18.CFrame = CFrame.new(u26:Lerp(Attribute13, p33)) * u23;

                        return p34;
                    end));
                end;

                if Transparency == Attribute28 then
                    u18.Transparency = Transparency;

                    return;
                end;

                local fromParams = u1.fromParams;
                local Attribute29 = u2.getAttribute(u7, "Transparency_Curve", u2.default_bezier);
                table.insert(u8, fromParams(Attribute29, Attribute26, function(p35, p36) -- Line: 234
                    -- upvalues: u18 (ref), u2 (ref), Transparency (copy), Attribute28 (ref)
                    u18.Transparency = u2.lerp(Transparency, Attribute28, p35);

                    return p36;
                end));
            end);
        else
            v14 = i;
        end;
    end;

    task.wait(RangeAttribute.Max + math.max(Attribute25, Attribute15));
    Promise.all(v9):await();
end;

return v3;