  

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("./mod/tween");
local u2 = require("./mod/utility");
require("./obj/ObjectCache");
local Promise = require(script.Parent.obj.Promise);
local Random_new_ret = Random.new();
local v3 = {};
local u4 = {};
local u5 = nil;
local u6 = nil;

function v3.init(p7) -- Line: 18
    -- upvalues: u6 (ref), u5 (ref), RunService (copy), u4 (copy)
    if u6 then
        return;
    end;

    u5 = p7;

    if RunService:IsStudio() and script:FindFirstAncestorOfClass("Plugin") then
        u6 = RunService.RenderStepped:Connect(function(p8) -- Line: 26
            -- upvalues: u4 (ref)
            if #u4 == 0 then
                return;
            end;

            workspace:StepPhysics(p8, u4);
        end);
    end;
end;

function v3.deinit() -- Line: 36
    -- upvalues: u6 (ref), u5 (ref), u4 (copy)
    if u6 then
        u6:Disconnect();
        u6 = nil;
    end;

    u5 = nil;

    for _, v in u4 do
        v:Destroy();
    end;

    table.clear(u4);
end;

function v3.emit(p9: userdata, p10: userdata, u11: any) -- Line: 51
    -- upvalues: u5 (ref), u2 (copy), CollectionService (copy), Random_new_ret (copy), u4 (copy), u1 (copy), Promise (copy)
    if not u5 then
        return;
    end;

    local Attribute = u2.getAttribute(p10, "InheritanceEnabled", true);
    local Attribute2 = u2.getAttribute(p10, "InheritanceRadius", 5);
    local v12;

    if Attribute then
        local Attribute3 = u2.getAttribute(p10, "InheritanceMaxResults", 5);
        local Attribute4 = u2.getAttribute(p9, "RayCollisionGroup", "Default");
        local Attribute5 = u2.getAttribute(p9, "FilterTag", "");
        local Attribute6 = u2.getAttribute(p9, "FilterType", "Exclude");
        local Attribute7 = u2.getAttribute(p9, "IgnoreCanCollide", false);
        v12 = OverlapParams.new();
        v12.MaxParts = Attribute3;
        v12.CollisionGroup = Attribute4;
        v12.RespectCanCollide = not Attribute7;
        v12.FilterType = Enum.RaycastFilterType[Attribute6];
        v12.FilterDescendantsInstances = CollectionService:GetTagged(Attribute5);

        if Attribute6 == "Exclude" then
            v12:AddToFilter({ workspace.Terrain });
        end;
    else
        v12 = nil;
    end;

    local Attribute3 = u2.getAttribute(p10, "EmitDelay", 0);
    local RangeAttribute = u2.getRangeAttribute(p10, "Amount", NumberRange.new(5, 10), NumberRange.new(0, (1 / 0)));
    local RangeAttribute2 = u2.getRangeAttribute(p10, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local RangeAttribute3 = u2.getRangeAttribute(p10, "Airtime", NumberRange.new(0.5, 0.5), NumberRange.new(0, (1 / 0)));
    local RangeAttribute4 = u2.getRangeAttribute(p10, "LinearMagnitude", NumberRange.new(15, 25));
    local RangeAttribute5 = u2.getRangeAttribute(p10, "AngularMagnitude", NumberRange.new(5, 15));
    local Attribute4 = u2.getAttribute(p10, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local Attribute5 = u2.getAttribute(p10, "MinSize", Vector3.new(2, 1, 2));
    local Attribute6 = u2.getAttribute(p10, "MaxSize", Vector3.new(3, 2, 3));
    local Attribute7 = u2.getAttribute(p10, "MinDirection", Vector3.new(-1, -1, -1));
    local Attribute8 = u2.getAttribute(p10, "MaxDirection", Vector3.new(1, 1, 1));
    local v13 = Random_new_ret:NextInteger(RangeAttribute.Min, RangeAttribute.Max);
    local Attribute9 = u2.getAttribute(p10, "Size_Curve", u2.default_bezier);
    local Attribute10 = u2.getAttribute(p10, "Transparency_Curve", u2.default_bezier);
    local Attribute11 = u2.getAttribute(p10, "Transparency_Duration", 0.5);
    local Attribute12 = u2.getAttribute(p10, "Size_Duration", 0.5);
    local Attribute13 = u2.getAttribute(p10, "Transparency_Start", 0);
    local Attribute14 = u2.getAttribute(p10, "Transparency_End", 1);
    local v14 = {};
    local v15 = {};
    p10.CanCollide = false;

    if v12 then
        for _, v in workspace:GetPartBoundsInRadius(p9.WorldPosition, Attribute2, v12) do
            if v.Transparency ~= 1 then
                table.insert(v14, v);
            end;
        end;
    end;

    task.wait(Attribute3);

    for i = 1, v13 do
        local v16;

        if #v14 == 0 then
            v16 = false;
        else
            v16 = v14[Random_new_ret:NextInteger(1, #v14)];
        end;

        local RanomId = u2.getRanomId();
        local u17 = u5:get(RanomId);
        local u18 = u17._getReal();
        u2.copyProperties(p10, u18, u2.COPY_PART_PROPERTIES);
        u2.copyProperties(p10, u18, u2.COPY_EXTENDED_PART_PROPERTIES);
        local v19;

        if #p10:GetChildren() == 0 then
            v19 = i;
        else
            local v20 = p10:Clone();
            v19 = i;

            for _, child in v20:GetChildren() do
                child.Parent = u18;
            end;

            v20:Destroy();
        end;

        u17.Anchored = false;
        u17.CanCollide = true;
        u17.Transparency = Attribute13;

        if u17.CollisionGroup == "Default" then
            u17.CollisionGroup = "ForgeDebris";
        end;

        u17.CFrame = CFrame.new(p9.WorldPosition);
        local v21 = Random_new_ret:NextNumber(Attribute5.X, Attribute6.X);
        local v22 = Random_new_ret:NextNumber(Attribute5.Y, Attribute6.Y);
        local Vector3_new_ret = Vector3.new(v21, v22, Random_new_ret:NextNumber(Attribute5.Z, Attribute6.Z));
        u17.Size = Vector3_new_ret;

        if v16 then
            u17.Material = v16.Material;
            u17.Color = v16.Color;
            u17.Transparency = v16.Transparency;
        end;

        table.insert(u11, function() -- Line: 176
            -- upvalues: u4 (ref), u18 (copy), u5 (ref), RanomId (copy)
            local table_find_ret = table.find(u4, u18);

            if table_find_ret then
                table.remove(u4, table_find_ret);
            end;

            if u5 then
                u5:free(RanomId);
            end;
        end);
        table.insert(u4, u18);
        u17.AssemblyLinearVelocity = p9.WorldCFrame:VectorToWorldSpace(u17.AssemblyLinearVelocity);
        local v23 = u2.randomUnitVector(Attribute7, Attribute8);
        local v24 = p9.WorldCFrame:VectorToWorldSpace(v23);
        u17:ApplyImpulse(u17.AssemblyMass * u2.getImpulseForce(p9.WorldPosition, p9.WorldPosition + v24.Unit * Random_new_ret:NextNumber(RangeAttribute4.Min, RangeAttribute4.Max), Random_new_ret:NextNumber(RangeAttribute3.Min, RangeAttribute3.Max)));
        u17:ApplyAngularImpulse(u17.AssemblyMass * Random_new_ret:NextUnitVector() * Random_new_ret:NextNumber(RangeAttribute5.Min, RangeAttribute5.Max));

        if shared.vfx and #u17:GetChildren() ~= 0 then
            local Finished = shared.vfx.emit(u17).Finished;
            table.insert(v15, Finished);
        end;

        task.delay(Random_new_ret:NextNumber(RangeAttribute2.Min, RangeAttribute2.Max), function() -- Line: 211
            -- upvalues: u17 (copy), Vector3_new_ret (copy), Attribute4 (copy), u11 (copy), u1 (ref), Attribute9 (copy), Attribute12 (copy), Attribute13 (copy), Attribute14 (copy), Attribute10 (copy), Attribute11 (copy), u2 (ref)
            local Size = u17.Size;

            if Size ~= Vector3_new_ret * Attribute4 then
                table.insert(u11, u1.fromParams(Attribute9, Attribute12, function(p25, p26) -- Line: 217
                    -- upvalues: u17 (ref), Size (copy), Vector3_new_ret (ref), Attribute4 (ref)
                    u17.Size = Size:Lerp(Vector3_new_ret * Attribute4, p25);

                    return p26;
                end));
            end;

            if Attribute13 == Attribute14 then
                u17.Transparency = Attribute13;

                return;
            end;

            table.insert(u11, u1.fromParams(Attribute10, Attribute11, function(p27, p28) -- Line: 227
                -- upvalues: u17 (ref), u2 (ref), Attribute13 (ref), Attribute14 (ref)
                u17.Transparency = u2.lerp(Attribute13, Attribute14, p27);

                return p28;
            end));
        end);
    end;

    task.wait(RangeAttribute2.Max + math.max(Attribute11, Attribute12));
    Promise.all(v15):await();
end;

return v3;