 

 

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/tween");
require("../types");
local u2 = require("../mod/utility");
local u3 = require("../pkg/Promise");
require("../obj/ObjectCache");
local Random_new_ret = Random.new();
local v4 = {};
local u5 = {};
local u6 = nil;
local u7 = nil;

function v4.init(p8) -- Line: 19
    -- upvalues: u7 (ref), u6 (ref), u2 (copy), RunService (copy), u5 (copy)
    if u7 then
        return;
    end;

    u6 = p8;

    if u2.PLUGIN_CONTEXT then
        u7 = RunService.RenderStepped:Connect(function(p9) -- Line: 27
            -- upvalues: u5 (ref)
            if #u5 == 0 then
                return;
            end;

            workspace:StepPhysics(p9, u5);
        end);
    end;
end;

function v4.deinit() -- Line: 37
    -- upvalues: u7 (ref), u6 (ref), u5 (copy)
    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;

    u6 = nil;

    for _, v in u5 do
        v:Destroy();
    end;

    table.clear(u5);
end;

function v4.emit(p10: userdata, p11: userdata, u12: any) -- Line: 52
    -- upvalues: u6 (ref), u2 (copy), CollectionService (copy), Random_new_ret (copy), u5 (copy), u1 (copy), u3 (copy)
    if not u6 then
        return;
    end;

    local Attribute = u2.getAttribute(p11, "InheritanceEnabled", true);
    local Attribute2 = u2.getAttribute(p11, "InheritanceRadius", 5);
    local v13;

    if Attribute then
        local Attribute3 = u2.getAttribute(p11, "InheritanceMaxResults", 5);
        local Attribute4 = u2.getAttribute(p10, "RayCollisionGroup", "Default");
        local Attribute5 = u2.getAttribute(p10, "FilterTag", "");
        local Attribute6 = u2.getAttribute(p10, "FilterType", "Exclude");
        local Attribute7 = u2.getAttribute(p10, "IgnoreCanCollide", false);
        v13 = OverlapParams.new();
        v13.MaxParts = Attribute3;
        v13.CollisionGroup = Attribute4;
        v13.RespectCanCollide = not Attribute7;
        v13.FilterType = Enum.RaycastFilterType[Attribute6];
        v13.FilterDescendantsInstances = CollectionService:GetTagged(Attribute5);

        if Attribute6 == "Exclude" then
            v13:AddToFilter({ workspace.Terrain });
        end;
    else
        v13 = nil;
    end;

    local Attribute3 = u2.getAttribute(p11, "EmitDelay", 0);
    local RangeAttribute = u2.getRangeAttribute(p11, "Amount", NumberRange.new(5, 10), NumberRange.new(0, (1 / 0)));
    local RangeAttribute2 = u2.getRangeAttribute(p11, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local RangeAttribute3 = u2.getRangeAttribute(p11, "Airtime", NumberRange.new(0.5, 0.5), NumberRange.new(0, (1 / 0)));
    local RangeAttribute4 = u2.getRangeAttribute(p11, "LinearMagnitude", NumberRange.new(15, 25));
    local RangeAttribute5 = u2.getRangeAttribute(p11, "AngularMagnitude", NumberRange.new(5, 15));
    local Attribute4 = u2.getAttribute(p11, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local Attribute5 = u2.getAttribute(p11, "MinSize", Vector3.new(2, 1, 2));
    local Attribute6 = u2.getAttribute(p11, "MaxSize", Vector3.new(3, 2, 3));
    local Attribute7 = u2.getAttribute(p11, "MinDirection", Vector3.new(-1, -1, -1));
    local Attribute8 = u2.getAttribute(p11, "MaxDirection", Vector3.new(1, 1, 1));
    local v14 = Random_new_ret:NextInteger(RangeAttribute.Min, RangeAttribute.Max);
    local Attribute9 = u2.getAttribute(p11, "Size_Curve", u2.default_bezier);
    local Attribute10 = u2.getAttribute(p11, "Transparency_Curve", u2.default_bezier);
    local Attribute11 = u2.getAttribute(p11, "Transparency_Duration", 0.5);
    local Attribute12 = u2.getAttribute(p11, "Size_Duration", 0.5);
    local Attribute13 = u2.getAttribute(p11, "Transparency_Start", 0);
    local Attribute14 = u2.getAttribute(p11, "Transparency_End", 1);
    local v15 = {};
    local u16 = {};
    p11.CanCollide = false;
    local TransformedOriginExtents = u2.getTransformedOriginExtents(p10);
    local Position = TransformedOriginExtents.Position;

    if v13 then
        for _, v in workspace:GetPartBoundsInRadius(Position, Attribute2, v13) do
            if v.Transparency ~= 1 then
                table.insert(v15, v);
            end;
        end;
    end;

    task.wait(Attribute3);

    for i = 1, v14 do
        local v17;

        if #v15 == 0 then
            v17 = false;
        else
            v17 = v15[Random_new_ret:NextInteger(1, #v15)];
        end;

        local RandomId = u2.getRandomId();
        local u18 = u6:get(RandomId);
        local u19 = u18._getReal();
        u2.copyProperties(p11, u19, u2.COPY_PART_PROPERTIES);
        u2.copyProperties(p11, u19, u2.COPY_EXTENDED_PART_PROPERTIES);
        local v20;

        if #p11:GetChildren() == 0 then
            v20 = i;
        else
            local v21 = p11:Clone();
            v20 = i;

            for _, child in v21:GetChildren() do
                child.Parent = u19;
            end;

            v21:Destroy();
        end;

        local u22 = u12.effects.prepareEmitOnFinish(u19, u12);
        u18.Anchored = false;
        u18.CanCollide = true;

        if u18.CollisionGroup == "Default" then
            u18.CollisionGroup = "ForgeDebris";
        end;

        u18.CFrame = CFrame.new(Position);
        local v23 = Random_new_ret:NextNumber(Attribute5.X, Attribute6.X);
        local v24 = Random_new_ret:NextNumber(Attribute5.Y, Attribute6.Y);
        local Vector3_new_ret = Vector3.new(v23, v24, Random_new_ret:NextNumber(Attribute5.Z, Attribute6.Z));
        u18.Size = Vector3_new_ret;

        if v17 then
            u18.Material = v17.Material;
            u18.Color = v17.Color;
            u18.Transparency = v17.Transparency;
        else
            u18.Transparency = Attribute13;
        end;

        table.insert(u12, function() -- Line: 182
            -- upvalues: u5 (ref), u19 (copy), u6 (ref), RandomId (copy)
            local table_find_ret = table.find(u5, u19);

            if table_find_ret then
                table.remove(u5, table_find_ret);
            end;

            if u6 then
                u6:free(RandomId);
            end;
        end);
        table.insert(u5, u19);
        u18.AssemblyLinearVelocity = TransformedOriginExtents:VectorToWorldSpace(u18.AssemblyLinearVelocity);
        local v25 = TransformedOriginExtents:VectorToWorldSpace((u2.randomUnitVector(Attribute7, Attribute8)));
        u18:ApplyImpulse(u18.AssemblyMass * u2.getImpulseForce(Position, Position + v25.Unit * Random_new_ret:NextNumber(RangeAttribute4.Min, RangeAttribute4.Max), Random_new_ret:NextNumber(RangeAttribute3.Min, RangeAttribute3.Max)));
        u18:ApplyAngularImpulse(u18.AssemblyMass * Random_new_ret:NextUnitVector() * Random_new_ret:NextNumber(RangeAttribute5.Min, RangeAttribute5.Max));
        local Finished = u12.effects.emitNested(u19, u12.depth + 1).Finished;
        table.insert(u16, Finished);
        task.delay(Random_new_ret:NextNumber(RangeAttribute2.Min, RangeAttribute2.Max), function() -- Line: 215
            -- upvalues: u18 (copy), Vector3_new_ret (copy), Attribute4 (copy), u12 (copy), u1 (ref), Attribute9 (copy), Attribute12 (copy), Attribute14 (copy), Attribute10 (copy), Attribute11 (copy), u2 (ref), u22 (copy), u19 (copy), u16 (copy)
            local Size = u18.Size;
            local Transparency = u18.Transparency;

            if Size ~= Vector3_new_ret * Attribute4 then
                table.insert(u12, u1.fromParams(Attribute9, Attribute12, function(p26, p27) -- Line: 222
                    -- upvalues: u18 (ref), Size (copy), Vector3_new_ret (ref), Attribute4 (ref)
                    u18.Size = Size:Lerp(Vector3_new_ret * Attribute4, p26);

                    return p27;
                end));
            end;

            if Transparency ~= Attribute14 then
                table.insert(u12, u1.fromParams(Attribute10, Attribute11, function(p28, p29) -- Line: 232
                    -- upvalues: u18 (ref), u2 (ref), Transparency (copy), Attribute14 (ref)
                    u18.Transparency = u2.lerp(Transparency, Attribute14, p28);

                    return p29;
                end));
            end;

            local Finished2 = u12.effects.emitOnFinish(u22, u19, u12.depth + 1).Finished;
            table.insert(u16, Finished2);
        end);
    end;

    task.wait(RangeAttribute2.Max + math.max(Attribute11, Attribute12));
    u3.all(u16):await();
end;

return v4;