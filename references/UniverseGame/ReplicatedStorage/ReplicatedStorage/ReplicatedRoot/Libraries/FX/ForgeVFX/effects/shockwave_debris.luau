  

 

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../pkg/Promise");
require("../obj/ObjectCache");
local u5 = Random.new();
local v6 = {};
local u7 = {};
local u8 = nil;
local u9 = nil;

function v6.init(p10) -- Line: 20
    -- upvalues: u9 (ref), u8 (ref), u3 (copy), RunService (copy), u7 (copy)
    if u9 then
        return;
    end;

    u8 = p10;

    if u3.PLUGIN_CONTEXT then
        u9 = RunService.RenderStepped:Connect(function(p11) -- Line: 28
            -- upvalues: u7 (ref)
            if #u7 == 0 then
                return;
            end;

            workspace:StepPhysics(p11, u7);
        end);
    end;
end;

function v6.deinit() -- Line: 38
    -- upvalues: u9 (ref), u8 (ref), u7 (copy)
    if u9 then
        u9:Disconnect();
        u9 = nil;
    end;

    u8 = nil;

    for _, v in u7 do
        v:Destroy();
    end;

    table.clear(u7);
end;

function v6.emit(p12, p13, u14) -- Line: 53
    -- upvalues: u8 (ref), u1 (copy), CollectionService (copy), u5 (copy), u3 (copy), u7 (copy), u2 (copy), u4 (copy)
    if not u8 then
        return;
    end;

    local v15 = u1.get(p13, "InheritanceEnabled", true);
    local v16 = u1.get(p13, "InheritanceRadius", 5);
    local v17 = u1.get(p12, "RayCollisionGroup", "Default");
    local u18 = u1.get(p12, "FilterTag", "");
    local u19 = u1.get(p12, "FilterType", "Exclude");
    local u20 = u1.get(p12, "IgnoreCanCollide", false);
    local v21;

    if v15 then
        local v22 = u1.get(p13, "InheritanceMaxResults", 5);
        v21 = OverlapParams.new();
        v21.MaxParts = v22;
        v21.CollisionGroup = v17;
        v21.RespectCanCollide = not u20;
        v21.FilterType = Enum.RaycastFilterType[u19];
        v21.FilterDescendantsInstances = CollectionService:GetTagged(u18);

        if u19 == "Exclude" then
            v21:AddToFilter({ workspace.Terrain });
        end;
    else
        v21 = nil;
    end;

    local v23 = u1.get(p13, "EmitDelay", 0);
    local v24 = u1.getRange(p13, "Amount", NumberRange.new(5, 10), NumberRange.new(0, (1 / 0)));
    local v25 = u1.getRange(p13, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local v26 = u1.getRange(p13, "Airtime", NumberRange.new(0.5, 0.5), NumberRange.new(0, (1 / 0)));
    local v27 = u1.getRange(p13, "LinearMagnitude", NumberRange.new(15, 25));
    local v28 = u1.getRange(p13, "AngularMagnitude", NumberRange.new(5, 15));
    local u29 = u1.get(p13, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local v30 = u1.get(p13, "MinSize", Vector3.new(2, 1, 2));
    local v31 = u1.get(p13, "MaxSize", Vector3.new(3, 2, 3));
    local v32 = u1.get(p13, "MinDirection", Vector3.new(-1, -1, -1));
    local v33 = u1.get(p13, "MaxDirection", Vector3.new(1, 1, 1));
    local v34 = u5:NextInteger(v24.Min, v24.Max);
    local u35 = u1.get(p13, "Size_Curve", u3.default_bezier);
    local u36 = u1.get(p13, "Transparency_Curve", u3.default_bezier);
    local u37 = u1.get(p13, "Transparency_Duration", 0.5);
    local u38 = u1.get(p13, "Size_Duration", 0.5);
    local v39 = u1.get(p13, "Transparency_Start", 0);
    local u40 = u1.get(p13, "Transparency_End", 1);
    local v41 = {};
    local u42 = {};
    p13.CanCollide = false;
    local v43 = u3.getTransformedOriginExtents(p12);
    local Position = v43.Position;

    if v21 then
        for _, v in workspace:GetPartBoundsInRadius(Position, v16, v21) do
            if v.Transparency ~= 1 then
                table.insert(v41, v);
            end;
        end;
    end;

    task.wait(v23);

    for _ = 1, v34 do
        local v44;

        if #v41 == 0 then
            v44 = false;
        else
            v44 = v41[u5:NextInteger(1, #v41)];
        end;

        local u45 = u3.getRandomId();
        local u46 = u8:get(u45);
        local u47 = u46._getReal();
        u3.copyProperties(p13, u47, u3.COPY_PART_PROPERTIES);
        u3.copyProperties(p13, u47, u3.COPY_EXTENDED_PART_PROPERTIES);

        if #p13:GetChildren() ~= 0 then
            local v48 = p13:Clone();

            for _, child in v48:GetChildren() do
                child.Parent = u47;
            end;

            v48:Destroy();
        end;

        local u49 = u14.effects.prepareEmitOnFinish(u47, u14);
        local u50 = u14.effects.prepareEmitFolder(u47, "EmitOnImpact", u14);

        if u50 and #u50:GetChildren() > 0 then
            local u51 = nil;
            u51 = u47.Touched:Connect(function(p52) -- Line: 162
                -- upvalues: u20 (copy), u47 (copy), u19 (copy), u18 (copy), u51 (ref), u14 (copy), u50 (copy), u42 (copy)
                if not (u20 or p52:CanCollideWith(u47)) or (p52:IsDescendantOf(workspace.Terrain) or u19 == "Exclude" and p52:HasTag(u18)) then
                    return;
                end;

                u51:Disconnect();
                local Finished = u14.effects.emitFromFolder(u50, u47, u14.depth + 1, u14).Finished;
                table.insert(u42, Finished);
            end);
            table.insert(u14, function() -- Line: 177
                -- upvalues: u51 (ref)
                if u51 then
                    u51:Disconnect();
                    u51 = nil;
                end;
            end);
        end;

        u46.Anchored = false;
        u46.CanCollide = true;

        if u46.CollisionGroup == "Default" then
            u46.CollisionGroup = "ForgeDebris";
        end;

        u46.CFrame = CFrame.new(Position);
        local v53 = u5:NextNumber(v30.X, v31.X);
        local v54 = u5:NextNumber(v30.Y, v31.Y);
        local u55 = Vector3.new(v53, v54, u5:NextNumber(v30.Z, v31.Z));
        u46.Size = u55;

        if v44 then
            u46.Material = v44.Material;
            u46.Color = v44.Color;
            u46.Transparency = v44.Transparency;
        else
            u46.Transparency = v39;
        end;

        table.insert(u14, function() -- Line: 210
            -- upvalues: u7 (ref), u47 (copy), u8 (ref), u45 (copy)
            local v56 = table.find(u7, u47);

            if v56 then
                table.remove(u7, v56);
            end;

            if u8 then
                u8:free(u45);
            end;
        end);
        table.insert(u7, u47);
        u46.AssemblyLinearVelocity = v43:VectorToWorldSpace(u46.AssemblyLinearVelocity);
        local v57 = v43:VectorToWorldSpace((u3.randomUnitVector(v32, v33)));
        u46:ApplyImpulse(u46.AssemblyMass * u3.getImpulseForce(Position, Position + v57.Unit * u5:NextNumber(v27.Min, v27.Max), u5:NextNumber(v26.Min, v26.Max)));
        u46:ApplyAngularImpulse(u46.AssemblyMass * u5:NextUnitVector() * u5:NextNumber(v28.Min, v28.Max));
        local Finished = u14.effects.emitNested(u47, u14.depth + 1, u14).Finished;
        table.insert(u42, Finished);
        task.delay(u5:NextNumber(v25.Min, v25.Max), function() -- Line: 243
            -- upvalues: u46 (copy), u55 (copy), u29 (copy), u14 (copy), u2 (ref), u35 (copy), u38 (copy), u40 (copy), u36 (copy), u37 (copy), u3 (ref), u49 (copy), u47 (copy), u42 (copy)
            local Size = u46.Size;
            local Transparency = u46.Transparency;

            if Size ~= u55 * u29 then
                table.insert(u14, u2.fromParams(u35, u38, function(p58, p59) -- Line: 250
                    -- upvalues: u46 (ref), Size (copy), u55 (ref), u29 (ref)
                    u46.Size = Size:Lerp(u55 * u29, p58);

                    return p59;
                end));
            end;

            if Transparency ~= u40 then
                table.insert(u14, u2.fromParams(u36, u37, function(p60, p61) -- Line: 260
                    -- upvalues: u46 (ref), u3 (ref), Transparency (copy), u40 (ref)
                    u46.Transparency = u3.lerp(Transparency, u40, p60);

                    return p61;
                end));
            end;

            local Finished2 = u14.effects.emitOnFinish(u49, u47, u14.depth + 1, u14).Finished;
            table.insert(u42, Finished2);
        end);
    end;

    task.wait(v25.Max + math.max(u37, u38));
    u4.all(u42):await();
end;

return v6;