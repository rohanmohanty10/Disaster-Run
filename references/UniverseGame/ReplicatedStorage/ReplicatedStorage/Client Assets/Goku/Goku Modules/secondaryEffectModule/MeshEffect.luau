  

 

local Funcs = require(game.ReplicatedStorage["Client Assets"].Goku["Goku Modules"].Funcs);
local _ = CFrame.new;
local _ = Vector3.new;
local new = Instance.new;
local _ = Region3.new;
local _ = Color3.new;
local _ = Vector2.new;
local _ = UDim2.new;
local _ = CFrame.Angles;
local _ = math.rad;
local _ = math.cos;
local _ = math.sin;
local _ = math.tan;
local _ = BrickColor.new;
local fromRGB = Color3.fromRGB;
local _ = Funcs.RNG;
local _ = Funcs.XYZ;
local TweenService = game:GetService("TweenService");
local v1 = {
    gParent = nil
};
local u2 = false;

local function Sequence(p3) -- Line: 17
    return { p3[2], p3[2] };
end;

local function Tween(p4, p5, p6, p7, p8) -- Line: 21
    -- upvalues: TweenService (copy)
    local v9 = TweenService:Create(p4, TweenInfo.new(p7, Enum.EasingStyle[p6], Enum.EasingDirection[p5]), p8);
    v9:Play();

    return v9;
end;

function v1.Mount(p10, p11) -- Line: 32
    -- upvalues: u2 (ref)
    u2 = true;

    return "MeshEffect";
end;

local u12 = {
    Type = "3D",
    Duration = 1,
    Object = ""
};
local v13 = { Vector3.new(0, 0, 0), Vector3.new(0, 0, 0) };
u12.Pos = { v13[2], v13[2] };
u12.objectProperties = {
    Material = "Neon"
};
local v14 = { 0, 0.5 };
u12.Transparency = { v14[2], v14[2] };
local v15 = { Vector3.new(1, 1, 1), Vector3.new(3, 3, 3) };
u12.Size = { v15[2], v15[2] };
local v16 = { fromRGB(255, 255, 255), fromRGB(255, 255, 255) };
u12.Color = { v16[2], v16[2] };
u12.tweenProperties = {
    Direction = "InOut",
    Style = "Quad"
};
u12.Parent = workspace.Effects;

function v1.Render(p17, p18) -- Line: 59
    -- upvalues: u12 (copy), new (copy), TweenService (copy)
    local u19 = {};

    for i, v in next, u12 do
        if p18[i] then
            u19[i] = p18[i];
        else
            u19[i] = v;
        end;
    end;

    local u20;

    if u19.Object == nil then
        u20 = new("Part");
        u20.CanCollide = false;
        u20.Anchored = true;
        u20.CastShadow = false;
        u20.Name = "Effect";
        pcall(function() -- Line: 72
            -- upvalues: u19 (copy), u20 (ref)
            for i, v in next, u19.objectProperties do
                u20[i] = v;
            end;
        end);

        if typeof(u19.Pos[1]) == "Vector3" then
            u20.Position = u19.Pos[1];
        else
            u20.CFrame = u19.Pos[1];
        end;

        u20.Transparency = u19.Transparency[1];
        u20.Size = u19.Size[1];
        u20.Color = u19.Color[1];
        u20.Parent = workspace.Effects;
    else
        u20 = u19.Object:Clone();
        pcall(function() -- Line: 88
            -- upvalues: u19 (copy), u20 (ref)
            for i, v in next, u19.objectProperties do
                u20[i] = v;
            end;
        end);

        if typeof(u19.Pos[1]) == "Vector3" then
            u20.Position = u19.Pos[1];
        else
            u20.CFrame = u19.Pos[1];
        end;

        u20.Transparency = u19.Transparency[1];
        u20.Size = u19.Size[1];
        u20.Color = u19.Color[1];
        u20.Parent = u19.Parent;
    end;

    if typeof(u19.Pos[2]) == "Vector3" then
        local v21 = {
            Size = u19.Size[2],
            Color = u19.Color[2],
            Transparency = u19.Transparency[2],
            Position = u19.Pos[2]
        };
        TweenService:Create(u20, TweenInfo.new(u19.Duration, Enum.EasingStyle[u19.tweenProperties.Style], Enum.EasingDirection[u19.tweenProperties.Direction]), v21):Play();
    else
        local v22 = {
            Size = u19.Size[2],
            Color = u19.Color[2],
            Transparency = u19.Transparency[2],
            CFrame = u19.Pos[2]
        };
        TweenService:Create(u20, TweenInfo.new(u19.Duration, Enum.EasingStyle[u19.tweenProperties.Style], Enum.EasingDirection[u19.tweenProperties.Direction]), v22):Play();
    end;

    game:GetService("Debris"):AddItem(u20, u19.Duration + 0.1);
end;

return v1;