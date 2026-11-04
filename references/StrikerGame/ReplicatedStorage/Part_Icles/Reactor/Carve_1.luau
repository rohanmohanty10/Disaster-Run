 
 

local GeometryService = game:GetService("GeometryService");
local Sites = require(script.Parent.Sites);
local Dice = require(script.Parent.Dice);
local Ribbon = require(script.Parent.Ribbon);
local v9 = {
    MOST_BITS = 24,

    key = function(p1, p2, p3, p4, p5, p6, p7, p8) -- Line: 74, Name: key
        local ClassName = p1.ClassName;

        if p1:IsA("MeshPart") then
            ClassName = ClassName .. p1.MeshId;
        elseif p1:IsA("Part") then
            ClassName = ClassName .. p1.Shape.Name;
        elseif p1:IsA("PartOperation") and not p1.UsePartColor then
            ClassName = ClassName .. ":baked";
        end;

        local Size = p1.Size;
        local Position = p2.Position;
        local LookVector = p2.LookVector;
        local UpVector = p2.UpVector;

        return string.format("carve|%s|%.3f,%.3f,%.3f|%.2f,%.2f,%.2f|%.3f,%.3f,%.3f|%.3f,%.3f,%.3f|%.2f,%.2f,%.2f|%s|%d|%d|%s|%.2f", ClassName, Size.X, Size.Y, Size.Z, Position.X, Position.Y, Position.Z, LookVector.X, LookVector.Y, LookVector.Z, UpVector.X, UpVector.Y, UpVector.Z, p3.X, p3.Y, p3.Z, p4, p5, p6, tostring(p7 == true), p8 or 0);
    end
};

local function sourceOf(p10, p11) -- Line: 96
    if p10.template then
        return p10.template, p10.baked == true, false;
    end;

    if p10.blockSize then
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.Size = p10.blockSize;
        Part.Color = Color3.new(1, 1, 1);
        Part.CFrame = p11;

        return Part, false, true;
    end;

    local part = p10.part;

    if part:IsA("PartOperation") and not part.UsePartColor then
        return part, true, false;
    end;

    local Instance_fromExisting_ret = Instance.fromExisting(part);
    Instance_fromExisting_ret.Anchored = true;
    Instance_fromExisting_ret.Color = Color3.new(1, 1, 1);
    Instance_fromExisting_ret.Archivable = true;
    Instance_fromExisting_ret.CFrame = p11;

    return Instance_fromExisting_ret, false, true;
end;

local function model(u12, u13, u14, u15) -- Line: 124
    -- upvalues: GeometryService (copy)
    local success, result = pcall(function() -- Line: 125
        -- upvalues: GeometryService (ref), u12 (copy), u13 (copy), u14 (copy), u15 (copy)
        return GeometryService[u12](GeometryService, u13, u14, {
            SplitApart = u15
        });
    end);

    if success and type(result) == "table" then
        return result;
    end;

    if success then
        return nil;
    end;

    return nil, tostring(result);
end;

local function withoutSlivers(p16) -- Line: 138
    local v17 = {};

    for _, v in ipairs(p16) do
        local ExtentsSize = v.ExtentsSize;

        if math.max(ExtentsSize.X, ExtentsSize.Y, ExtentsSize.Z) < 0.35 then
            v:Destroy();
        else
            table.insert(v17, v);
        end;
    end;

    return v17;
end;

local function sitesIn(p18, p19, p20) -- Line: 152
    local ExtentsCFrame = p18.ExtentsCFrame;
    local v21 = p18.ExtentsSize * 0.9;
    local table_create_ret = table.create(p19);

    for i = 1, p19 do
        local v22 = (p20() - 0.5) * v21.X;
        local v23 = (p20() - 0.5) * v21.Y;
        local v24 = (p20() - 0.5) * v21.Z;
        table_create_ret[i] = ExtentsCFrame:PointToWorldSpace((Vector3.new(v22, v23, v24)));
        local _ = i;
    end;

    return table_create_ret;
end;

local function ownSites(p25, p26, p27) -- Line: 164
    -- upvalues: Dice (copy), Sites (copy)
    local v28;

    if p25.points then
        v28 = p25.points;
    elseif p25.grid then
        v28 = Dice.centres(p25.part.Size, p25.count);
    else
        v28 = Sites.even(p25.part.Size, p25.count, p27);
    end;

    local table_create_ret = table.create(#v28);

    for i, v in ipairs(v28) do
        table_create_ret[i] = p26:PointToWorldSpace(v);
    end;

    return table_create_ret;
end;

local function sideOf(p29, p30, p31) -- Line: 181
    return (p30:PointToObjectSpace(p29.ExtentsCFrame.Position) - p31.origin):Dot(p31.normal) >= 0 and 1 or -1;
end;

local function cuttersOf(p32, p33) -- Line: 191
    -- upvalues: Ribbon (copy)
    local ribbon = p32.ribbon;
    local v34;

    if ribbon then
        v34 = Ribbon.cutter(ribbon);
    else
        v34 = ribbon;
    end;

    if v34 then
        local v35 = v34:Clone();
        v35.CFrame = p33 * p32.ribbonFrame * v34.CFrame;

        return { v35 };
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.Size = ribbon and ribbon.flat or p32.bladeSize;
    Part.CFrame = p33 * p32.bladeFrame;

    return { Part };
end;

local function destroyAll(p36) -- Line: 207
    for _, v in ipairs(p36) do
        v:Destroy();
    end;
end;

function v9.cut(p37, p38, p39) -- Line: 213
    -- upvalues: Sites (copy), cuttersOf (copy), sourceOf (copy), GeometryService (copy), withoutSlivers (copy), ownSites (copy), sitesIn (copy)
    local v40 = p37.frame or p37.part.CFrame;
    local slash = p37.slash;
    local v41 = Sites.sequence(p37.seed);
    local u42 = cuttersOf(p37, v40);
    local u43, v44, v45 = sourceOf(p37, v40);
    local u46 = "SubtractAsync";
    local u47 = true;
    local success, result = pcall(function() -- Line: 125
        -- upvalues: GeometryService (ref), u46 (copy), u43 (copy), u42 (copy), u47 (copy)
        return GeometryService[u46](GeometryService, u43, u42, {
            SplitApart = u47
        });
    end);
    local v48;

    if success and type(result) == "table" then
        v48 = nil;
    elseif success then
        result = nil;
        v48 = nil;
    else
        v48 = tostring(result);
        result = nil;
    end;

    if not (result or (not v45 or p37.blockSize)) then
        u43:Destroy();
        u43 = p37.part;
        v44 = true;
        v45 = false;
        local u49 = "SubtractAsync";
        local u50 = true;
        local v51;
        v51, result = pcall(function() -- Line: 125
            -- upvalues: GeometryService (ref), u49 (copy), u43 (copy), u42 (copy), u50 (copy)
            return GeometryService[u49](GeometryService, u43, u42, {
                SplitApart = u50
            });
        end);

        if not v51 or type(result) ~= "table" then
            if v51 then
                result = nil;
            else
                tostring(result);
                result = nil;
            end;
        end;

        if result then
            v48 = nil;
        end;
    end;

    if result then
        result = withoutSlivers(result);
    end;

    local v52;

    if result and (#result == 1 and not p37.always) then
        local u53 = "IntersectAsync";
        local u54 = false;
        local v55;
        v55, v52 = pcall(function() -- Line: 125
            -- upvalues: GeometryService (ref), u53 (copy), u43 (copy), u42 (copy), u54 (copy)
            return GeometryService[u53](GeometryService, u43, u42, {
                SplitApart = u54
            });
        end);

        if not v55 or type(v52) ~= "table" then
            if v55 then
                v52 = nil;
            else
                tostring(v52);
                v52 = nil;
            end;
        end;

        if not v52 or #v52 == 0 then
            result[1]:Destroy();
            result = nil;
        end;
    else
        v52 = nil;
    end;

    if not result or #result == 0 then
        for _, v in ipairs(u42) do
            v:Destroy();
        end;

        if v45 then
            u43:Destroy();
        end;

        return false, v48;
    end;

    local v56 = #result == 1 and true or p37.stands == true;
    local v57 = {};

    for _, v in ipairs(result) do
        local v58 = (v40:PointToObjectSpace(v.ExtentsCFrame.Position) - slash.origin):Dot(slash.normal) >= 0 and 1 or -1;
        local v59;

        if p37.mode == "Pieces" and (p37.count >= 2 and not v56) then
            v59 = p38(v, (ownSites(p37, v40, v41)));
        else
            v59 = nil;
        end;

        if v59 and #v59 >= 2 then
            for _, v2 in ipairs(v59) do
                local v60 = p39(v2.Instance, v40, false, nil);
                v60.side = v58;
                v60.baked = v44;
                table.insert(v57, v60);
            end;

            v:Destroy();
        else
            local v61 = p39(v, v40, v56, nil);
            v61.side = v58;
            v61.baked = v44;
            table.insert(v57, v61);
        end;
    end;

    if v52 and p37.mode ~= "Band" then
        for _, v in ipairs(v52) do
            v:Destroy();
        end;
    end;

    if p37.mode == "Band" then
        if not v52 then
            local u62 = "IntersectAsync";
            local u63 = false;
            local v64;
            v64, v52 = pcall(function() -- Line: 125
                -- upvalues: GeometryService (ref), u62 (copy), u43 (copy), u42 (copy), u63 (copy)
                return GeometryService[u62](GeometryService, u43, u42, {
                    SplitApart = u63
                });
            end);

            if not v64 or type(v52) ~= "table" then
                if v64 then
                    v52 = nil;
                else
                    tostring(v52);
                    v52 = nil;
                end;
            end;
        end;

        if v52 then
            v52 = v52[1];
        end;

        if v52 then
            local ExtentsSize = v52.ExtentsSize;
            local math_max_ret = math.max(ExtentsSize.X, ExtentsSize.Y, ExtentsSize.Z);
            local v65 = math_max_ret * (ExtentsSize.X + ExtentsSize.Y + ExtentsSize.Z - math_max_ret - math.min(ExtentsSize.X, ExtentsSize.Y, ExtentsSize.Z)) / 9;
            local math_round_ret = math.round(v65);
            local v66 = p38(v52, (sitesIn(v52, math.clamp(math_round_ret, 3, 24), v41)));

            for _, v in ipairs(v66 or {}) do
                local v67 = p39(v.Instance, v40, false, nil);
                v67.bit = true;
                v67.baked = v44;
                table.insert(v57, v67);
            end;

            v52:Destroy();
        end;
    end;

    for _, v in ipairs(u42) do
        v:Destroy();
    end;

    if v45 then
        u43:Destroy();
    end;

    v57.slash = slash;

    return v57;
end;

return v9;