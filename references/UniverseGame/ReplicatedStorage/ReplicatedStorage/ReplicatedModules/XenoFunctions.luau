  

 

local CollectionService = game:GetService("CollectionService");
local u1 = {};
local random = math.random;

function u1.getRandomItem(p2) -- Line: 5
    -- upvalues: random (copy)
    local v3 = 0;

    for _, v in pairs(p2) do
        v3 = v3 + v;
    end;

    local v4 = random(v3);
    local v5 = 0;

    for i, v in pairs(p2) do
        v5 = v5 + v;

        if v4 <= v5 then
            return i, v;
        end;
    end;
end;

function u1.getLargestValue(p6) -- Line: 19
    local v7 = 0;
    local v8 = nil;

    for i, v in pairs(p6) do
        if v7 <= v then
            v8 = i;
            v7 = v;
        end;
    end;

    return v8, v7;
end;

function u1.createCircle(p9, p10, p11) -- Line: 32
    local v12 = {};

    for i = 1, p10 do
        local v13 = 360 / p10 * i;
        local v14 = math.rad(v13);
        local v15 = math.cos(v14) * p11 + p9.X;
        local v16 = math.rad(v13);
        local v17 = math.sin(v16) * p11 + p9.Z;
        local v18 = Vector3.new(v15, p9.Y, v17);
        table.insert(v12, v18);
    end;

    return v12;
end;

if workspace:FindFirstChild("1v1Mode") then
    UGMAP = workspace.Map;
else
    UGMAP = workspace.Map;
end;

local u19 = {};

for _, child in pairs(UGMAP:GetChildren()) do
    if child:FindFirstChild("Collisions") then
        table.insert(u19, child.Collisions);
    end;
end;

function u1.RayCastOnMap(p20, p21, p22) -- Line: 55
    -- upvalues: u19 (copy)
    local v23 = RaycastParams.new();
    v23.FilterDescendantsInstances = u19;
    v23.FilterType = Enum.RaycastFilterType.Whitelist;
    local v24 = workspace:Raycast(p20, p21, v23);

    if p22 then
        return v24;
    end;

    if v24 then
        return v24.Position;
    end;

    return p20;
end;

function u1.createTween(p25, p26, p27, p28, p29, p30) -- Line: 68
    return TweenInfo.new(p25, Enum.EasingStyle[p26], Enum.EasingDirection[p27], p28, p29, p30);
end;

function u1.spawnVFX(u31, p32, p33, p34) -- Line: 79
    local u35 = game:GetService("TweenService"):Create(u31, p32, p33);
    u35:Play();

    if not p34 or p34 == nil then
        coroutine.resume(coroutine.create(function() -- Line: 83
            -- upvalues: u35 (copy), u31 (copy)
            u35.Completed:Connect(function() -- Line: 84
                -- upvalues: u31 (ref)
                if not (u31 and u31.Parent) then
                    return;
                end;

                if u31.Parent == workspace.Effects then
                    u31:Destroy();

                    return;
                end;

                u31.Parent:Destroy();
            end);
        end));
    end;
end;

function u1.spawnRubble(p36, p37, p38) -- Line: 95
    -- upvalues: u1 (copy), random (copy)
    local v39 = p38 or {};
    local origPos = v39.origPos;
    local v40 = v39.Range or 1;
    local u41 = v39.Duration or 1;
    local u42 = v39.Speed or 0.5;
    local v43 = v39.Size or Vector3.new(1, 1, 1);
    local u44 = v39.newSize or (v39.Size or Vector3.new(1, 1, 1));
    local Part = Instance.new("Part");
    Part.Size = v43;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Position = p37;
    Part.Material = p36.Material;
    Part.Color = p36.Color;
    Part.Parent = workspace.Effects;
    local u45 = Part.Position + (p37 - origPos).Unit * v40 * Vector3.new(1, 0, 1);
    coroutine.resume(coroutine.create(function() -- Line: 114
        -- upvalues: u1 (ref), Part (copy), u42 (copy), u44 (copy), u45 (copy), random (ref), u41 (copy)
        local spawnVFX = u1.spawnVFX;
        local v46 = u1.createTween(u42, "Exponential", "Out", 0, false, 0);
        local v47 = {
            Size = u44,
            Position = u45
        };
        local v48 = random(0, 255);
        local v49 = random(0, 255);
        v47.Orientation = Vector3.new(v48, v49, random(0, 255));
        spawnVFX(Part, v46, v47, true);
        wait(u41);
        u1.spawnVFX(Part, u1.createTween(u42, "Exponential", "In", 0, false, 0), {
            Size = Part.Size / 15
        }, false);
    end));
end;

function u1.lerpPosition(p50, p51, p52) -- Line: 129
    return Vector3.new(p50.X + (p51.X - p50.X) * p52, p50.Y + (p51.Y - p50.Y) * p52, p50.Z + (p51.Z - p50.Z) * p52);
end;

function u1.CheckStunned(p53) -- Line: 136
    -- upvalues: CollectionService (copy)
    if CollectionService:HasTag(p53, "Stunned") or CollectionService:HasTag(p53, "Disabled") then
        return true;
    end;
end;

function u1.FastCastRay(p54, p55, p56) -- Line: 142
    local v57 = RaycastParams.new();
    v57.FilterDescendantsInstances = { workspace.Map };
    v57.FilterType = Enum.RaycastFilterType.Whitelist;
    local v58 = workspace:Raycast(p55, p56, v57);

    if v58 then
        return v58.Position;
    end;

    return p55 + p56;
end;

return u1;