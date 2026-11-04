 

 

local u1 = {};
local CFrame_Angles = CFrame.Angles;
local _ = math.rad;
u1.Sounds = table.freeze({
    Song = 1846800656,
    Bell = 1219368778,
    Cannon = 72411732778781,
    Blast = 125205557479599,
    Fuse = 71438605239854,
    Whoosh = 9120773999,
    Thud = 138853260436801,
    Coins = table.freeze({ 9121189379, 97539362955458, 5314631765 })
});
u1.Accent = Color3.fromRGB(66, 157, 255);
u1.Gold = Color3.fromRGB(255, 202, 58);
u1.Ghost = Color3.fromRGB(120, 255, 170);
u1.Intro = table.freeze({
    Duration = 5.4,
    ShipIn = 0.1,
    ShipSet = 1.4,
    Cross = 1.1,
    Flag = 2,
    Salute = 2.5,
    Gap = 0.22,
    Point = 3.3,
    Back = 3.95,
    ShipBack = 30,
    ShipSink = 1
});
u1.Finale = table.freeze({
    Duration = 7.4,
    Fire = 1.55,
    Flight = 1,
    Roll = 0.75,
    Settle = 0.2,
    Rise = 5.15,
    Stand = 0.6,
    Back = 5.85,
    Distance = 32,
    RollDistance = 6,
    Peak = 10,
    Spins = 2,
    RollSpins = 1.25
});

function u1.landAt() -- Line: 56
    -- upvalues: u1 (copy)
    local Finale = u1.Finale;

    return Finale.Fire + Finale.Flight;
end;

function u1.poseAt() -- Line: 60
    -- upvalues: u1 (copy)
    local Finale = u1.Finale;

    return Finale.Fire + Finale.Flight + Finale.Roll + Finale.Settle;
end;

u1.Joints = table.freeze({
    RootJoint = "Root",
    Neck = "Neck",
    ["Right Shoulder"] = "RightArm",
    ["Left Shoulder"] = "LeftArm",
    ["Right Hip"] = "RightLeg",
    ["Left Hip"] = "LeftLeg"
});
u1.Poses = table.freeze({
    Neutral = table.freeze({}),
    Cross = table.freeze({
        RightArm = CFrame_Angles(0, 0.6632251157578453, 0) * CFrame_Angles(2.059488517353309, 0, 0),
        LeftArm = CFrame_Angles(0, -0.6632251157578453, 0) * CFrame_Angles(2.059488517353309, 0, 0),
        Neck = CFrame_Angles(-0.10471975511965978, 0, 0)
    }),
    Point = table.freeze({
        RightArm = CFrame_Angles(1.6755160819145565, 0, 0),
        LeftArm = CFrame_Angles(0, 0, -0.4886921905584123) * CFrame_Angles(0.2617993877991494, 0, 0),
        Neck = CFrame_Angles(0.06981317007977318, 0, 0)
    }),
    Tuck = table.freeze({
        RightLeg = CFrame_Angles(1.8325957145940461, 0, 0),
        LeftLeg = CFrame_Angles(1.8325957145940461, 0, 0),
        RightArm = CFrame_Angles(0, 0.4886921905584123, 0) * CFrame_Angles(1.361356816555577, 0, 0),
        LeftArm = CFrame_Angles(0, -0.4886921905584123, 0) * CFrame_Angles(1.361356816555577, 0, 0),
        Neck = CFrame_Angles(-0.3839724354387525, 0, 0)
    }),
    Hero = table.freeze({
        Root = CFrame.new(0, -1.05, 0) * CFrame_Angles(-0.2792526803190927, 0, 0),
        LeftLeg = CFrame_Angles(1.2915436464758039, 0, 0),
        RightLeg = CFrame_Angles(-1.2566370614359172, 0, 0),
        RightArm = CFrame_Angles(0, 0, 0.2792526803190927) * CFrame_Angles(2.8797932657906435, 0, 0),
        LeftArm = CFrame_Angles(0, 0, -0.8028514559173916) * CFrame_Angles(0.5235987755982988, 0, 0),
        Neck = CFrame_Angles(0.24434609527920614, 0, 0)
    })
});

function u1.blend(p2, p3, p4) -- Line: 113
    -- upvalues: u1 (copy)
    local v5 = {};

    for _, v in u1.Joints do
        v5[v] = (p2[v] or CFrame.identity):Lerp(p3[v] or CFrame.identity, p4);
    end;

    return v5;
end;

function u1.rig(p6) -- Line: 123
    -- upvalues: u1 (copy)
    local v7 = {};
    local v8 = false;

    for _, descendant in p6:GetDescendants() do
        local v9 = descendant:IsA("Motor6D") and u1.Joints[descendant.Name];

        if v9 and not v7[v9] then
            v7[v9] = {
                motor = descendant,
                base = descendant.C0
            };
            v8 = true;
        end;
    end;

    return v8 and v7 and v7 or nil;
end;

function u1.pose(p10, p11, p12) -- Line: 137
    for i, v in p10 do
        local motor = v.motor;

        if motor.Parent then
            local v13 = p11[i] or CFrame.identity;

            if i == "Root" and p12 then
                v13 = p12 * v13;
            end;

            local base = v.base;
            local v14 = CFrame.new(base.Position) * v13 * base.Rotation;

            if motor.C0 ~= v14 then
                motor.C0 = v14;
            end;
        end;
    end;
end;

function u1.release(p15) -- Line: 154
    for _, v in p15 do
        if v.motor.Parent then
            v.motor.C0 = v.base;
        end;
    end;
end;

function u1.smooth(p16) -- Line: 162
    local math_clamp_ret = math.clamp(p16, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

function u1.smoother(p17) -- Line: 166
    local math_clamp_ret = math.clamp(p17, 0, 1);

    return math_clamp_ret * math_clamp_ret * math_clamp_ret * (math_clamp_ret * (math_clamp_ret * 6 - 15) + 10);
end;

function u1.arc(p18, p19, p20, p21) -- Line: 171
    local v22 = math.max(p18.Y, p19.Y) + p20;
    local v23 = p18:Lerp(p19, p21);

    return Vector3.new(v23.X, v23.Y + 4 * (v22 - (p18.Y + p19.Y) / 2) * p21 * (1 - p21), v23.Z);
end;

return table.freeze(u1);