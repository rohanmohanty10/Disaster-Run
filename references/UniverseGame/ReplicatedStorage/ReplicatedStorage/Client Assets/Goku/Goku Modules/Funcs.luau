  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local new = CFrame.new;
local Angles = CFrame.Angles;
local _ = math.rad;
local _ = math.random;
local fromRGB = Color3.fromRGB;
local Output = game.ReplicatedStorage.Remotes.Output;

local function Raycast(p1, p2, p3, p4) -- Line: 10
    return workspace:FindPartOnRay(Ray.new(p1, p2.unit * p3), p4);
end;

local function CreateTween(p5, p6, p7, p8, p9) -- Line: 14
    -- upvalues: TweenService (copy)
    local v10 = typeof(p7) == "EnumItem" and p7 and p7 or Enum.EasingStyle[p7];
    local v11 = typeof(p8) == "EnumItem" and p8 and p8 or Enum.EasingStyle[p8];

    return TweenService:Create(p5, TweenInfo.new(p6, v10, v11), p9);
end;

return {
    Raycast = Raycast,
    CreateTween = CreateTween,
    Thread = task.spawn,
    Wait = task.wait,

    Tween = function(p12, p13, p14, p15, p16) -- Line: 26
        -- upvalues: RunService (copy), CreateTween (copy), Output (copy)
        if not p12 then
            warn(p13, p14, p15, p16);
        end;

        if RunService:IsClient() and p12 then
            return CreateTween(p12, p13, p14, p15, p16):Play();
        end;

        if not (p12 and p12:IsDescendantOf(workspace.Effects)) then
            return CreateTween(p12, p13, p14, p15, p16):Play();
        end;

        Output:FireAllClients("FX", "Goku Tween", p12, p13, p14, p15, p16);
    end,

    GetFloor = function(p17, p18) -- Line: 40
        -- upvalues: Raycast (copy), new (copy)
        return Raycast(p18.Position, new(p18.Position, p18.Position + Vector3.new(0, -1, 0)).LookVector, 4, p17);
    end,

    RNG = function(p19, p20, p21) -- Line: 43
        return p21 and Random.new():NextNumber(p19, p20) or Random.new():NextInteger(p19, p20);
    end,

    XYZ = function(p22, p23, p24, p25) -- Line: 46
        -- upvalues: Angles (copy)
        return p22 == false and Angles(p23, p24, p25) or Angles(p22(p23), p22(p24), p22(p25));
    end,

    Sequence = function(p26) -- Line: 49
        return {
            [0] = p26[1],
            [1] = p26[2]
        };
    end,

    DivideColor = function(p27, p28) -- Line: 52
        -- upvalues: fromRGB (copy)
        return fromRGB(p27.R * 255 / p28, p27.G * 255 / p28, p27.B * 255 / p28);
    end,

    Glue = function(p29, p30) -- Line: 55
        -- upvalues: new (copy)
        local Weld = Instance.new("Weld");
        Weld.Part0 = p29;
        Weld.Part1 = p30;
        Weld.C0 = new();
        Weld.C1 = p30.CFrame:Inverse() * p29.CFrame;
        Weld.Parent = p29;

        return Weld;
    end,

    CreateSound = function(u31, u32, u33, u34, u35, u36) -- Line: 64
        local u37 = nil;
        task.spawn(function() -- Line: 66
            -- upvalues: u37 (ref), u32 (copy), u33 (copy), u34 (copy), u35 (copy), u31 (copy), u36 (copy)
            u37 = Instance.new("Sound");
            u37.SoundId = "rbxassetid://" .. u32;
            u37.Volume = u33;
            u37.PlaybackSpeed = u34;
            u37.TimePosition = u35;
            u37.Parent = u31;
            u37:Play();
            game:GetService("Debris"):AddItem(u37, u36);
        end);

        return u37;
    end
};