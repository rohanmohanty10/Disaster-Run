  

 

CFn = CFrame.new;
V3n = Vector3.new;
Ins = Instance.new;
R3n = Region3.new;
C3n = Color3.new;
V2n = Vector2.new;
Udn = UDim2.new;
Ang = CFrame.Angles;
Rad = math.rad;
Cos = math.cos;
Sin = math.sin;
Tan = math.tan;

function Rng(p1, p2, p3)
    return p3 and Random.new():NextNumber(p1, p2) or Random.new():NextInteger(p1, p2);
end;

BCn = BrickColor.new;
RGB = Color3.fromRGB;

function XYZ(p4, p5, p6, p7)
    return p4 == false and CFrame.Angles(p5, p6, p7) or CFrame.Angles(math.rad(p5), math.rad(p6), (math.rad(p7)));
end;

local TweenService = game:GetService("TweenService");
local v8 = {
    gParent = nil
};
local u9 = false;

function propGet(p10)
    return p10[2];
end;

function Sequence(p11)
    return { p11[2], p11[2] };
end;

function hWait(p12)
    if p12 == nil or p12 == 0 then
        game:GetService("RunService").Heartbeat:Wait();

        return;
    end;

    for _ = 1, p12 do
        game:GetService("RunService").Heartbeat:Wait();
    end;
end;

function Tween(p13, p14, p15, p16, p17)
    -- upvalues: TweenService (copy)
    local v18 = TweenService:Create(p13, TweenInfo.new(p16, Enum.EasingStyle[p15], Enum.EasingDirection[p14]), p17);
    v18:Play();

    return v18;
end;

function v8.Mount(p19, p20) -- Line: 53
    -- upvalues: u9 (ref)
    u9 = true;

    return "MeshEffect";
end;

local u21 = {
    Type = "3D",
    Duration = 1,
    Object = "",
    Pos = Sequence({ V3n(0, 0, 0), V3n(0, 0, 0) }),
    objectProperties = {
        Material = "Neon"
    },
    Transparency = Sequence({ 0, 0.5 }),
    Size = Sequence({ V3n(1, 1, 1), V3n(3, 3, 3) }),
    Color = Sequence({ RGB(255, 255, 255), RGB(255, 255, 255) }),
    tweenProperties = {
        Direction = "InOut",
        Style = "Quad"
    },
    Parent = workspace
};

function v8.Render(p22, p23) -- Line: 80
    -- upvalues: u21 (copy)
    local u24 = {};

    for i, v in next, u21 do
        if p23[i] then
            u24[i] = p23[i];
        else
            u24[i] = v;
        end;
    end;

    local u25;

    if u24.Object == nil then
        u25 = Ins("Part");
        u25.CanCollide = false;
        u25.Anchored = true;
        u25.CastShadow = false;
        u25.Name = "Effect";
        pcall(function() -- Line: 93
            -- upvalues: u24 (copy), u25 (ref)
            for i, v in next, u24.objectProperties do
                u25[i] = v;
            end;
        end);

        if typeof(u24.Pos[1]) == "Vector3" then
            u25.Position = u24.Pos[1];
        else
            u25.CFrame = u24.Pos[1];
        end;

        u25.Transparency = u24.Transparency[1];
        u25.Size = u24.Size[1];
        u25.Color = u24.Color[1];
        u25.Parent = u24.Parent;
    else
        u25 = u24.Object:Clone();
        pcall(function() -- Line: 109
            -- upvalues: u24 (copy), u25 (ref)
            for i, v in next, u24.objectProperties do
                u25[i] = v;
            end;
        end);

        if typeof(u24.Pos[1]) == "Vector3" then
            u25.Position = u24.Pos[1];
        else
            u25.CFrame = u24.Pos[1];
        end;

        u25.Transparency = u24.Transparency[1];
        u25.Size = u24.Size[1];
        u25.Color = u24.Color[1];
        u25.Parent = u24.Parent;
    end;

    if typeof(u24.Pos[2]) == "Vector3" then
        Tween(u25, u24.tweenProperties.Direction, u24.tweenProperties.Style, u24.Duration, {
            Size = u24.Size[2],
            Color = u24.Color[2],
            Transparency = u24.Transparency[2],
            Position = u24.Pos[2]
        });
    else
        Tween(u25, u24.tweenProperties.Direction, u24.tweenProperties.Style, u24.Duration, {
            Size = u24.Size[2],
            Color = u24.Color[2],
            Transparency = u24.Transparency[2],
            CFrame = u24.Pos[2]
        });
    end;

    game:GetService("Debris"):AddItem(u25, u24.Duration + 0.1);
end;

return v8;