 
 

local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/tween");
local u2 = require("../mod/utility");
local u3 = require("../pkg/Promise");
require("../obj/ObjectCache");
local Random_new_ret = Random.new();
local v4 = {};
local u5 = nil;

function v4.init(p6) -- Line: 15
    -- upvalues: u5 (ref)
    u5 = p6;
end;

function v4.deinit() -- Line: 19
    -- upvalues: u5 (ref)
    u5 = nil;
end;

function v4.emit(p7: userdata, u8: userdata, u9: any) -- Line: 23
    -- upvalues: u5 (ref), u2 (copy), CollectionService (copy), Random_new_ret (copy), u1 (copy), u3 (copy)
    if not u5 then
        return;
    end;

    local Attribute = u2.getAttribute(p7, "RayDirection", Vector3.new(0, -50, 0));
    local Attribute2 = u2.getAttribute(p7, "RayCollisionGroup", "Default");
    local Attribute3 = u2.getAttribute(p7, "FilterTag", "");
    local Attribute4 = u2.getAttribute(p7, "FilterType", "Exclude");
    local Attribute5 = u2.getAttribute(p7, "IgnoreWater", true);
    local Attribute6 = u2.getAttribute(p7, "IgnoreCanCollide", false);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.CollisionGroup = Attribute2;
    RaycastParams_new_ret.IgnoreWater = Attribute5;
    RaycastParams_new_ret.RespectCanCollide = not Attribute6;
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType[Attribute4];
    RaycastParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged(Attribute3);

    if Attribute4 == "Exclude" then
        RaycastParams_new_ret:AddToFilter({ workspace.Terrain });
    end;

    local Attribute7 = u2.getAttribute(u8, "EmitDelay", 0);
    local Attribute8 = u2.getAttribute(u8, "Radius", 5);
    local Attribute9 = u2.getAttribute(u8, "Segments", 7);
    local RangeAttribute = u2.getRangeAttribute(u8, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local Attribute10 = u2.getAttribute(u8, "PartOffset", Vector3.new(0, 0, 0), true);
    local Attribute11 = u2.getAttribute(u8, "BaseOffset", Attribute10);
    local Attribute12 = u2.getAttribute(u8, "Offset_Start", Attribute10);
    local Attribute13 = u2.getAttribute(u8, "Offset_End", Attribute10);
    local Attribute14 = u2.getAttribute(u8, "Offset_Start_Duration", 0.5);
    local Attribute15 = u2.getAttribute(u8, "Offset_End_Duration", 0.5);
    local Attribute16 = u2.getAttribute(u8, "SizeScaleStart", Vector3.new(0, 0, 0));
    local Attribute17 = u2.getAttribute(u8, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local Attribute18 = u2.getAttribute(u8, "MinSize", Vector3.new(2, 1, 2));
    local Attribute19 = u2.getAttribute(u8, "MaxSize", Vector3.new(3, 2, 3));
    local Attribute20 = u2.getAttribute(u8, "Size_Curve", u2.default_bezier, true);
    local Attribute21 = u2.getAttribute(u8, "Size_Duration", 0.5, true);
    local Attribute22 = u2.getAttribute(u8, "Size_Start_Curve", Attribute20);
    local Attribute23 = u2.getAttribute(u8, "Size_End_Curve", Attribute20);
    local Attribute24 = u2.getAttribute(u8, "Size_Start_Duration", Attribute21);
    local Attribute25 = u2.getAttribute(u8, "Size_End_Duration", Attribute21);
    local Attribute26 = u2.getAttribute(u8, "Transparency_Duration", 0.5);
    local Attribute27 = u2.getAttribute(u8, "Transparency_Start", 0);
    local Attribute28 = u2.getAttribute(u8, "Transparency_End", 0);
    task.wait(Attribute7);
    local v10 = {};

    for i = 0, Attribute9 - 1 do
        local v11 = i / Attribute9 * 3.141592653589793 * 2;
        local v12 = Attribute8 * math.cos(v11);
        local v13 = Attribute8 * math.sin(v11);
        local v14 = workspace:Raycast((p7.WorldCFrame * CFrame.new(v12, 0, v13)).Position, p7.WorldCFrame:VectorToWorldSpace(Attribute), RaycastParams_new_ret);
        local v15;

        if v14 then
            local v16 = Random_new_ret:NextNumber(Attribute18.X, Attribute19.X);
            local v17 = Random_new_ret:NextNumber(Attribute18.Y, Attribute19.Y);
            local v18 = Random_new_ret:NextNumber(Attribute18.Z, Attribute19.Z);
            local RanomId = u2.getRanomId();
            local u19 = u5:get(RanomId);
            local v20 = u19._getReal();
            u2.copyProperties(u8, v20, u2.COPY_PART_PROPERTIES);
            u2.copyProperties(u8, v20, u2.COPY_EXTENDED_PART_PROPERTIES);

            if #u8:GetChildren() == 0 then
                v15 = i;
            else
                local v21 = u8:Clone();
                v15 = i;

                for _, child in v21:GetChildren() do
                    child.Parent = v20;
                end;

                v21:Destroy();
            end;

            table.insert(u9, function() -- Line: 128
                -- upvalues: u5 (ref), RanomId (copy)
                if u5 then
                    u5:free(RanomId);
                end;
            end);
            u19.Color = v14.Instance.Color;
            u19.Material = v14.Material;
            u19.Transparency = v14.Instance.Transparency;

            if u19.Transparency == 0 then
                u19.Transparency = Attribute27;
            end;

            u19.Size = Vector3.new(0, 0, 0);
            local v22 = -math.cos(v11);
            local v23 = -math.sin(v11);
            local Unit = p7.WorldCFrame:VectorToWorldSpace((Vector3.new(v22, 0, v23))):Cross(v14.Normal).Unit;
            local u24 = CFrame.fromMatrix(v14.Position, Unit, v14.Normal) * CFrame.fromOrientation(-math.atan(v17 / v18), 0, 0);
            u19.CFrame = CFrame.new(Attribute12) * u24;
            local u25 = nil;
            local u26 = nil;
            local u27 = Vector3.new(0, 0, 0);

            if Attribute12 ~= Attribute11 then
                u26 = u1.fromParams(u2.getAttribute(u8, "Offset_Start_Curve", u2.default_bezier), Attribute14, function(p28, p29) -- Line: 164
                    -- upvalues: u27 (ref), Attribute12 (copy), Attribute11 (copy), u19 (copy), u24 (copy)
                    u27 = Attribute12:Lerp(Attribute11, p28);
                    u19.CFrame = CFrame.new(u27) * u24;

                    return p29;
                end);
                table.insert(u9, u25);
            end;

            local Vector3_new_ret = Vector3.new(v16, v17, v18);

            if Vector3_new_ret * Attribute16 == Vector3_new_ret then
                u19.Size = Vector3_new_ret * Attribute16;
            else
                u25 = u1.fromParams(Attribute22, Attribute24, function(p30, p31) -- Line: 177
                    -- upvalues: u19 (copy), Vector3_new_ret (copy), Attribute16 (copy)
                    u19.Size = (Vector3_new_ret * Attribute16):Lerp(Vector3_new_ret, p30);

                    return p31;
                end);
                table.insert(u9, u25);
            end;

            if shared.vfx and #u19:GetChildren() ~= 0 then
                local Finished = shared.vfx.emit(u19).Finished;
                table.insert(v10, Finished);
            end;

            task.delay(Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max), function() -- Line: 192
                -- upvalues: u25 (ref), u26 (ref), u19 (copy), Vector3_new_ret (copy), Attribute17 (copy), u9 (copy), u1 (ref), Attribute23 (copy), Attribute25 (copy), u27 (ref), Attribute13 (copy), u2 (ref), u8 (copy), Attribute15 (copy), u24 (copy), Attribute28 (copy), Attribute26 (copy)
                if u25 then
                    u25:Disconnect();
                end;

                if u26 then
                    u26:Disconnect();
                end;

                local Size = u19.Size;
                local Transparency = u19.Transparency;

                if Size ~= Vector3_new_ret * Attribute17 then
                    table.insert(u9, u1.fromParams(Attribute23, Attribute25, function(p32, p33) -- Line: 207
                        -- upvalues: u19 (ref), Size (copy), Vector3_new_ret (ref), Attribute17 (ref)
                        u19.Size = Size:Lerp(Vector3_new_ret * Attribute17, p32);

                        return p33;
                    end));
                end;

                if u27 ~= Attribute13 then
                    local fromParams = u1.fromParams;
                    local Attribute29 = u2.getAttribute(u8, "Offset_End_Curve", u2.default_bezier);
                    table.insert(u9, fromParams(Attribute29, Attribute15, function(p34, p35) -- Line: 220
                        -- upvalues: u19 (ref), u27 (ref), Attribute13 (ref), u24 (ref)
                        u19.CFrame = CFrame.new(u27:Lerp(Attribute13, p34)) * u24;

                        return p35;
                    end));
                end;

                if Transparency == Attribute28 then
                    u19.Transparency = Transparency;

                    return;
                end;

                local fromParams = u1.fromParams;
                local Attribute29 = u2.getAttribute(u8, "Transparency_Curve", u2.default_bezier);
                table.insert(u9, fromParams(Attribute29, Attribute26, function(p36, p37) -- Line: 234
                    -- upvalues: u19 (ref), u2 (ref), Transparency (copy), Attribute28 (ref)
                    u19.Transparency = u2.lerp(Transparency, Attribute28, p36);

                    return p37;
                end));
            end);
        else
            v15 = i;
        end;
    end;

    task.wait(RangeAttribute.Max + math.max(Attribute25, Attribute15));
    u3.all(v10):await();
end;

return v4;