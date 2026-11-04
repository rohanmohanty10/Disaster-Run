 

 

local u1 = {
    Map = "Map6",
    Turn = 0.15707963267948966,
    RoundGrowth = 1.03,
    BobUp = { 2, 3 },
    BobDown = 1,
    BobPeriod = { 3.5, 4.5 },
    Reach = 44,
    Probe = 8
};
local Session = script.Parent:WaitForChild("Session");
local u2 = setmetatable({}, {
    __mode = "k"
});

function u1.rateFor(p3) -- Line: 26
    -- upvalues: u1 (copy)
    local Turn = u1.Turn;
    local RoundGrowth = u1.RoundGrowth;
    local v4 = (tonumber(p3) or 0) - 1;

    return Turn * RoundGrowth ^ math.max(0, v4);
end;

function u1.rate() -- Line: 30
    -- upvalues: Session (copy), u1 (copy)
    local Attribute = Session:GetAttribute("CarouselRate");

    if type(Attribute) == "number" then
        return Attribute;
    end;

    return u1.Turn;
end;

function u1.angle(p5) -- Line: 35
    -- upvalues: Session (copy), u1 (copy)
    local Attribute = Session:GetAttribute("CarouselAt");
    local Attribute2 = Session:GetAttribute("CarouselAngle");

    if type(Attribute) == "number" and type(Attribute2) == "number" then
        return (Attribute2 + u1.rate() * (p5 - Attribute)) % 6.283185307179586;
    end;

    return p5 * u1.Turn % 6.283185307179586;
end;

function u1.model() -- Line: 45
    -- upvalues: u1 (copy)
    local v6 = workspace:FindFirstChild(u1.Map);

    if not v6 then
        return nil;
    end;

    local Model = v6:FindFirstChild("Model");
    local Carousel = v6:FindFirstChild("Carousel");

    if Carousel then
        Model = Carousel;
    elseif Model then
        Model = Model:FindFirstChild("Carousel");
    end;

    return Model;
end;

function u1.ride(p7, p8) -- Line: 56
    -- upvalues: u1 (copy)
    local v9 = u1.axis(p7):PointToObjectSpace(p8);
    local Random_new = Random.new;
    local v10 = (math.atan2(v9.Z, v9.X) + 3.141592653589793) * 1000;
    local v11 = Random_new((math.floor(v10)));
    local v12 = v11:NextNumber(u1.BobUp[1], u1.BobUp[2]);

    return {
        (v12 - u1.BobDown) / 2,
        (v12 + u1.BobDown) / 2,
        6.283185307179586 / v11:NextNumber(u1.BobPeriod[1], u1.BobPeriod[2]),
        v11:NextNumber(0, 6.283185307179586)
    };
end;

function u1.axis(p13) -- Line: 69
    -- upvalues: u2 (copy)
    local v14 = u2[p13];

    if not v14 then
        local BoundingBox = p13:GetBoundingBox();
        v14 = CFrame.new(BoundingBox.Position);
        u2[p13] = v14;
    end;

    return v14;
end;

function u1.turn(p15, p16) -- Line: 80
    -- upvalues: u1 (copy)
    local v17 = u1.axis(p15);

    return v17 * CFrame.Angles(0, p16, 0) * v17:Inverse();
end;

function u1.owns(p18, p19) -- Line: 86
    local v20;

    if p18 == nil or p19 == nil then
        v20 = false;
    else
        v20 = p19:IsDescendantOf(p18);
    end;

    return v20;
end;

local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.RespectCanCollide = true;

function u1.onDeck(p21, p22) -- Line: 94
    -- upvalues: u1 (copy), RaycastParams_new_ret (copy)
    local Position = u1.axis(p21).Position;
    local v23 = p22.X - Position.X;
    local v24 = p22.Z - Position.Z;

    if v23 * v23 + v24 * v24 > u1.Reach * u1.Reach then
        return false;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = { p21 };

    return workspace:Raycast(p22, Vector3.new(0, -u1.Probe, 0), RaycastParams_new_ret) ~= nil;
end;

function u1.carry(p25, p26, p27) -- Line: 106
    -- upvalues: u1 (copy)
    local v28 = u1.model();

    if v28 and (p25 and (p25:IsDescendantOf(v28) and p27 > 0)) then
        return u1.turn(v28, u1.rate() * p27) * p26 - p26;
    end;

    return nil;
end;

return u1;