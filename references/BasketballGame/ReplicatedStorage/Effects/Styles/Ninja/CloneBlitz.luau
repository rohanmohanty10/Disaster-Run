 
 

local RunService = game:GetService("RunService");
game:GetService("Players");
local u1 = require("@game/ReplicatedStorage/Packages/Janitor");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u3 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");
local Debris = workspace:WaitForChild("Debris");
local u4 = { -30, -22.5, -15, -7.5, 7.5, 15, 22.5, 30 };

local function PickAngles(p5: userdata) -- Line: 18
    -- upvalues: u4 (copy)
    local v6 = p5:NextInteger(1, #u4 - 4 + 1);

    return {
        math.rad(u4[v6 + 1 - 1]),
        math.rad(u4[v6 + 2 - 1]),
        math.rad(u4[v6 + 3 - 1]),
        math.rad(u4[v6 + 4 - 1])
    };
end;

local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IncludeInstances = { workspace.Barriers };
local u7 = require("@self/Steal");
local u8 = require("@self/Fadeaway");

return function(p9: any, p10: table) -- Line: 35
    -- upvalues: u7 (copy), u8 (copy), PickAngles (copy), u1 (copy), u3 (copy), Debris (copy), u2 (copy), RunService (copy), RaycastParams_new_ret (copy)
    if p10.Steal == true then
        return u7(p9, p10);
    end;

    if p10.Fadeaway == true then
        return u8(p9, p10);
    end;

    local TimeSent = p10.TimeSent;
    local v11 = workspace:GetServerTimeNow() - TimeSent;
    local math_max_ret = math.max(1.5 - v11, 0);

    if math_max_ret <= 0.1 then
        return;
    end;

    local v12 = PickAngles((Random.new((math.floor(TimeSent * 1000)))));
    local u13 = u1.new();
    u13:Add(task.delay(math_max_ret, function() -- Line: 54
        -- upvalues: u13 (copy)
        u13:Destroy();
    end));
    local Character = p10.Character;
    local Humanoid = Character.Humanoid;
    Character.Archivable = true;
    local CFrame2 = Character.HumanoidRootPart.CFrame;
    local v14 = u13:Add(Character:Clone());

    for _, v in v14:QueryDescendants("BasePart:not(#HumanoidRootPart)") do
        v:Destroy();
    end;

    v14.PrimaryPart = v14.HumanoidRootPart;
    v14.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    u13:Add(function() -- Line: 75
        -- upvalues: Humanoid (copy)
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
    end, true, "ShowName");
    u3:playSound({
        Sound = "BBZ Ninja Clone Blitz",
        Parent = Character.HumanoidRootPart
    }).TimePosition = v11;
    local u15 = {};
    local u16 = {};
    local u17 = {};
    local u18 = {};

    for i = 1, 4 do
        local v19 = v12[i];
        u15[`{i}`] = CFrame.new(CFrame2.Position) * CFrame.Angles(0, v19, 0) * CFrame.new(-CFrame2.Position);
        u16[`{i}`] = {};
        local u20 = v14:Clone();
        u13:Add(function() -- Line: 92
            -- upvalues: u20 (copy), Debris (ref), u2 (ref), u17 (copy), i (copy), u18 (copy), u15 (copy), u16 (copy), u13 (copy)
            local CFrame3 = u20.HumanoidRootPart.CFrame;
            local v21 = script.CLONME:Clone();
            task.delay(3, v21.Destroy, v21);
            v21.CFrame = CFrame3;
            v21.Parent = Debris;
            u2.emit(v21);
            u17[`{i}`] = nil;
            u18[`{i}`]:Destroy();
            u18[`{i}`] = nil;
            u15[`{i}`] = nil;
            u16[`{i}`] = nil;
            u20:Destroy();

            if next(u17) == nil then
                u13:Remove("ShowName");
            end;
        end, true, (`Clone{i}`));
        u20.Parent = Debris;
        u17[`{i}`] = u20;
        local v22 = u16[`{i}`];
        table.insert(v22, { Character.HumanoidRootPart, u20.HumanoidRootPart });
        local v23 = i;

        for _, v in Character:QueryDescendants("BasePart:not(#HumanoidRootPart)") do
            local v24 = v:Clone();
            v24.Parent = u20;
            v24.Anchored = true;

            for _, v2 in v24:QueryDescendants("BasePart,Motor6D,Weld,WeldConstraint,BallSocketConstraint,RigidConstraint") do
                v2:Destroy();
            end;

            local v25 = u16[`{v23}`];
            table.insert(v25, { v, v24 });
        end;

        if u20:FindFirstChild("Torso") and (u20:FindFirstChild("FrontJersey") and u20:FindFirstChild("BackJersey")) then
            u20.FrontJersey.Adornee = u20.Torso;
            u20.BackJersey.Adornee = u20.Torso;
        end;

        task.spawn(function() -- Line: 136
            -- upvalues: u20 (copy), Debris (ref), u2 (ref)
            local v26 = script.eMIT:Clone();
            task.delay(3, v26.Destroy, v26);
            v26.CFrame = u20.HumanoidRootPart.CFrame * CFrame.new(0, -2.23, 0);
            v26.Parent = Debris;
            u2.emit(v26);
        end);
    end;

    u13:Add(Character.ChildAdded:Connect(function(p27: userdata) -- Line: 146
        -- upvalues: u17 (copy), Character (copy)
        if p27:IsA("BasePart") == false and p27:IsA("Model") == false then
            for _, v in u17 do
                local v28 = p27:Clone();
                v28.Parent = v;

                if v28:IsA("Highlight") and v28.Adornee == Character then
                    v28.Adornee = v;
                end;
            end;
        end;
    end));
    u13:Add(Character.ChildRemoved:Connect(function(p29) -- Line: 159
        -- upvalues: u17 (copy)
        for _, v in u17 do
            local v30 = v:FindFirstChild(p29.Name);

            if v30 ~= nil then
                v30:Destroy();
            end;
        end;
    end));
    local BALL = Character:FindFirstChild("BALL", true);
    local u31 = {};
    local u32 = nil;

    for _, v in u17 do
        local BALL2 = v:FindFirstChild("BALL");

        if BALL and BALL2 then
            u32 = BALL.Trails:FindFirstChildOfClass("Trail");
            local v33 = BALL2.Trails:FindFirstChildOfClass("Trail");

            if u32 and v33 then
                table.insert(u31, v33);
            end;
        end;
    end;

    if next(u31) ~= nil then
        u13:Add(u32:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 184
            -- upvalues: u31 (copy), u32 (ref)
            for _, v in u31 do
                v.Enabled = u32.Enabled;
            end;
        end));
    end;

    local Ring = workspace:FindFirstChild("Ring");

    if Ring then
        for i, v in u17 do
            local HumanoidRootPart = v.HumanoidRootPart;
            local v34 = u13:Add(Ring:Clone());
            u18[i] = v34;
            v34.Parent = Debris;
            v34.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1, HumanoidRootPart.Position.Z) * Ring.CFrame.Rotation;
        end;
    end;

    local u35 = {};
    local u36 = {};
    u13:Add(RunService.RenderStepped:Connect(function() -- Line: 205
        -- upvalues: u35 (copy), u36 (copy), u17 (copy), u15 (copy), RaycastParams_new_ret (ref), u13 (copy), u16 (copy), u18 (copy)
        table.clear(u35);
        table.clear(u36);

        for i, v in u17 do
            local v37 = u15[i];
            local CFrame3 = v.HumanoidRootPart.CFrame;
            local v38 = workspace:Raycast(CFrame3.Position, CFrame3.LookVector * 5, RaycastParams_new_ret);

            if v38 and v38.Instance then
                u13:Remove((`Clone{i}`));
            else
                for _, v2 in u16[i] do
                    table.insert(u35, v2[2]);
                    table.insert(u36, v37 * v2[1].CFrame);
                end;

                local v39 = u18[i];
                table.insert(u35, v39);
                local v40 = CFrame.new(CFrame3.Position.X, 1, CFrame3.Position.Z) * CFrame.fromOrientation(v39.CFrame:ToOrientation());
                table.insert(u36, v40);
            end;
        end;

        workspace:BulkMoveTo(u35, u36, Enum.BulkMoveMode.FireCFrameChanged);
    end));
end;