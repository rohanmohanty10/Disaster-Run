 
 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local u1 = require("@game/ReplicatedStorage/Packages/Janitor");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u3 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");
local Debris = workspace:WaitForChild("Debris");
local u4 = {
    Normal = { 0.6333333333333333, 1 },
    Dunk = { 0.26666666666666666, 0.26666666666666666 }
};
local u5 = {
    Normal = { 1.1833333333333333, 1.5333333333333334 },
    Dunk = { 1.2833333333333334, 1.6666666666666667 }
};
local u6 = {
    {
        {
            Frame = 0,
            Offset = CFrame.new(4.26100159, -0.238755703, -0.0337142944)
        },
        {
            Frame = 17,
            Offset = CFrame.new(4.26100159, -0.238755703, -0.0337142944)
        },
        {
            Frame = 31,
            Offset = CFrame.new(-4.21321106, 5.81779194, -0.115142822)
        },
        {
            Frame = 77,
            Offset = CFrame.new(-4.21321106, 5.81779194, -0.115142822)
        }
    },
    {
        {
            Frame = 0,
            Offset = CFrame.new(-8.31072998, -0.0518438816, -0.0209197998)
        },
        {
            Frame = 17,
            Offset = CFrame.new(-8.31072998, -0.0518438816, -0.0209197998)
        },
        {
            Frame = 27,
            Offset = CFrame.new(-7.9914093, 5.35928059, 0.121124268)
        },
        {
            Frame = 31,
            Offset = CFrame.new(-2.53686523, 10.0519629, 1.60593414)
        },
        {
            Frame = 33,
            Offset = CFrame.new(0.326385498, 7.21610737, -1.20352936)
        },
        {
            Frame = 37,
            Offset = CFrame.new(-0.279907227, 2.3367362, -1.88467407)
        },
        {
            Frame = 42,
            Offset = CFrame.new(-2.65776062, 0.821801186, -1.79801178)
        },
        {
            Frame = 45,
            Offset = CFrame.new(-6.7036438, 4.27432537, -1.84482574)
        },
        {
            Frame = 48,
            Offset = CFrame.new(-7.55194092, 9.84234905, -1.84482574)
        },
        {
            Frame = 52,
            Offset = CFrame.new(-4.61425781, 15.930995, -1.84482574)
        },
        {
            Frame = 57,
            Offset = CFrame.new(-3.83647156, 23.177002, -1.84482574)
        },
        {
            Frame = 61,
            Offset = CFrame.new(-3.83647156, 25.9476318, -1.84482574)
        },
        {
            Frame = 68,
            Offset = CFrame.new(-3.83647156, 24.1554604, -1.84482574)
        },
        {
            Frame = 74,
            Offset = CFrame.new(-3.83647156, 22.3632889, -1.84482574)
        },
        {
            Frame = 100,
            Offset = CFrame.new(-3.83647156, 22.3632889, -1.84482574)
        }
    }
};

local function Resolve(p7: table) -- Line: 49
    return (p7.Origin * (p7.Frame.Offset or CFrame.identity)).Position;
end;

local function Sample(p8: table) -- Line: 56
    -- upvalues: u6 (copy), TweenService (copy)
    local Time = p8.Time;
    local v9 = u6[p8.Index];
    local v10 = v9[1];
    local v11 = v9[#v9];

    if Time <= v10.Frame / 60 then
        local v12 = {
            Frame = v10,
            Origin = p8.Origin
        };

        return (v12.Origin * (v12.Frame.Offset or CFrame.identity)).Position;
    end;

    if v11.Frame / 60 <= Time then
        local v13 = {
            Frame = v11,
            Origin = p8.Origin
        };

        return (v13.Origin * (v13.Frame.Offset or CFrame.identity)).Position;
    end;

    for i = 2, #v9 do
        local v14 = v9[i];
        local v15 = v14.Frame / 60;

        if Time <= v15 then
            local v16 = v9[i - 1];
            local v17 = v16.Frame / 60;
            local Value = TweenService:GetValue((Time - v17) / (v15 - v17), v14.Easing or Enum.EasingStyle.Linear, v14.Direction or Enum.EasingDirection.InOut);
            local v18 = {
                Frame = v16,
                Origin = p8.Origin
            };
            local v19 = {
                Frame = v14,
                Origin = p8.Origin
            };

            return (v18.Origin * (v18.Frame.Offset or CFrame.identity)).Position:Lerp((v19.Origin * (v19.Frame.Offset or CFrame.identity)).Position, Value);
        end;

        local _ = i;
    end;

    return v11.Offset;
end;

local u20 = require("@self/Fadeaway");
local u21 = require("@self/NinjaRun");

return function(p22: any, p23: table) -- Line: 83
    -- upvalues: u21 (copy), u20 (copy), Players (copy), u1 (copy), u4 (copy), Debris (copy), u2 (copy), u5 (copy), u3 (copy), RunService (copy), Sample (copy)
    if p23.NinjaRun then
        return u21(p22, p23);
    end;

    if p23.Fadeaway == true then
        return u20(p22, p23);
    end;

    local TimeSent = p23.TimeSent;
    local u24 = workspace:GetServerTimeNow() - TimeSent;
    local math_max_ret = math.max(p23.Dunk == true and 2.033333333333333 or 1.55 - u24, 0);

    if math_max_ret <= 0.1 then
        return;
    end;

    local Character = p23.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);
    local CFrame2 = HumanoidRootPart.CFrame;
    Character.Archivable = true;
    local u25 = u1.new();
    u25:Add(task.delay(math_max_ret, function() -- Line: 112
        -- upvalues: u25 (copy)
        u25:Destroy();
    end));
    local v26 = p23.Dunk and "Dunk" or "Normal";
    local _ = workspace.Hoops[PlayerFromCharacter.Team.Name].Hoop;
    local v27 = u4[v26];
    local u28 = {};

    if v26 == "Normal" then
        u25:Add(task.delay(0.26666666666666666 - u24, function() -- Line: 125
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref)
            local v29 = script.VFXNormal.D1:Clone();
            task.delay(3, v29.Destroy, v29);
            v29.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.00471496582, -2.21766829, -0.500335693, 1, 0, 0, 0, 0.99999994, 0, 0, 0, 0.99999994);
            v29.Parent = Debris;
            u2.emit(v29);
        end));
        u25:Add(task.delay(0.6 - u24, function() -- Line: 133
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref)
            local v30 = script.VFXNormal.THROW:Clone();
            task.delay(3, v30.Destroy, v30);
            v30.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.587387085, 1.91496897, -2.41065979, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v30.Parent = Debris;
            u2.emit(v30);
        end));
        u25:Add(task.delay(0.6166666666666667 - u24, function() -- Line: 141
            -- upvalues: Character (copy), u2 (ref)
            local v31 = script.VFXNormal.BallVFX:Clone();
            task.delay(3, v31.Destroy, v31);
            v31.Parent = Character.PlrBall.Anims.BALL;
            u2.emit(v31);
        end));
        u25:Add(task.delay(0.6333333333333333 - u24, function() -- Line: 148
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref), u24 (copy), u25 (copy)
            local CFrame3 = HumanoidRootPart.CFrame;
            local v32 = script.VFXNormal.CLONME:Clone();
            task.delay(3, v32.Destroy, v32);
            v32.CFrame = CFrame3 * CFrame.new(2.43449402, 11.403347, -0.983913422, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v32.Parent = Debris;
            u2.emit(v32);
            local math_max_ret2 = math.max(0.6333333333333333 - u24, 0);
            u25:Add(task.delay(0.31666666666666665 - math_max_ret2, function() -- Line: 158
                -- upvalues: CFrame3 (copy), Debris (ref), u2 (ref)
                local v33 = script.VFXNormal.T1:Clone();
                task.delay(3, v33.Destroy, v33);
                v33.CFrame = CFrame3 * CFrame.new(2.78956604, 10.8613205, -5.30416489, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                v33.Parent = Debris;
                u2.emit(v33);
            end));
        end));
        u25:Add(task.delay(0.9833333333333333 - u24, function() -- Line: 167
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref), u24 (copy), u25 (copy)
            local CFrame3 = HumanoidRootPart.CFrame;
            local v34 = script.VFXNormal.CLONME2:Clone();
            task.delay(3, v34.Destroy, v34);
            v34.CFrame = CFrame3 * CFrame.new(2.43449402, 13.5371647, -23.9362965, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v34.Parent = Debris;
            u2.emit(v34);
            local math_max_ret2 = math.max(0.9833333333333333 - u24, 0);
            u25:Add(task.delay(0.06666666666666667 - math_max_ret2, function() -- Line: 177
                -- upvalues: CFrame3 (copy), Debris (ref), u2 (ref)
                local v35 = script.VFXNormal.T2:Clone();
                task.delay(3, v35.Destroy, v35);
                v35.CFrame = CFrame3 * CFrame.new(2.78956604, 14.8746262, -20.5547295, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                v35.Parent = Debris;
                u2.emit(v35);
            end));
        end));
        u25:Add(task.delay(1.35 - u24, function() -- Line: 186
            -- upvalues: HumanoidRootPart (copy), Debris (ref), u2 (ref)
            local v36 = script.VFXNormal.CATCH:Clone();
            task.delay(3, v36.Destroy, v36);
            v36.CFrame = HumanoidRootPart.CFrame * CFrame.new(
                -0.302856445,
                1.50002337,
                -1.42874146,
                1,
                0,
                0,
                0,
                0.866025448,
                0.499999911,
                0,
                -0.499999911,
                0.866025448
            );
            v36.Parent = Debris;
            u2.emit(v36);
        end));
    else
        u25:Add(task.delay(0.06666666666666667 - u24, function() -- Line: 194
            -- upvalues: CFrame2 (copy), Debris (ref), u2 (ref)
            local v37 = script.VFXDunk["SIGN "]:Clone();
            task.delay(3, v37.Destroy, v37);
            v37.CFrame = CFrame2 * CFrame.new(-0.101928711, 0.0471024513, -1.07394409, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v37.Parent = Debris;
            u2.emit(v37);
        end));
        u25:Add(task.delay(0.23333333333333334 - u24, function() -- Line: 202
            -- upvalues: CFrame2 (copy), Debris (ref), u2 (ref)
            local v38 = script.VFXDunk.eMIT:Clone();
            task.delay(3, v38.Destroy, v38);
            v38.CFrame = CFrame2 * CFrame.new(-4.56820679, -2.23005533, 0.0146331787, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v38.Parent = Debris;
            u2.emit(v38);
        end));
        u25:Add(task.delay(0.55 - u24, function() -- Line: 210
            -- upvalues: CFrame2 (copy), Debris (ref), u2 (ref)
            local v39 = script.VFXDunk.Throw:Clone();
            task.delay(3, v39.Destroy, v39);
            v39.CFrame = CFrame2 * CFrame.new(-6.79493713, 9.74888325, 0.27532196, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v39.Parent = Debris;
            u2.emit(v39);
        end));
        u25:Add(task.delay(0.7666666666666667 - u24, function() -- Line: 218
            -- upvalues: CFrame2 (copy), Debris (ref), u2 (ref)
            local v40 = script.VFXDunk.Throw2:Clone();
            task.delay(3, v40.Destroy, v40);
            v40.CFrame = CFrame2 * CFrame.new(-6.79493713, 3.89312506, -1.4176178, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v40.Parent = Debris;
            u2.emit(v40);
        end));
        u25:Add(task.delay(1.0666666666666667 - u24, function() -- Line: 226
            -- upvalues: CFrame2 (copy), Debris (ref), u2 (ref)
            local v41 = script.VFXDunk.Throw3:Clone();
            task.delay(3, v41.Destroy, v41);
            v41.CFrame = CFrame2 * CFrame.new(-6.79493713, 9.24888325, 1.48928833, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v41.Parent = Debris;
            u2.emit(v41);
        end));
        u25:Add(task.delay(1.35 - u24, function() -- Line: 234
            -- upvalues: CFrame2 (copy), Debris (ref), u2 (ref)
            local v42 = script.VFXDunk.CLONME:Clone();
            task.delay(3, v42.Destroy, v42);
            v42.CFrame = CFrame2 * CFrame.new(-5.30749512, 4.89312458, 0.0146331787, 1, 0, 0, 0, 1, 0, 0, 0, 1);
            v42.Parent = Debris;
            u2.emit(v42);
        end));
        u25:Add(task.delay(1.5166666666666666 - u24, function() -- Line: 242
            -- upvalues: CFrame2 (copy), Debris (ref), u2 (ref)
            local v43 = script.VFXDunk.Thro4:Clone();
            task.delay(3, v43.Destroy, v43);
            v43.CFrame = CFrame2 * CFrame.new(-3.66383362, 22.839695, -4.06661224, 1, 0, 0, 0, 0, 1, 0, -1, 0);
            v43.Parent = Debris;
            u2.emit(v43);
        end));
        u25:Add(task.delay(1.9166666666666667 - u24, function() -- Line: 250
            -- upvalues: Character (copy), Debris (ref), u2 (ref)
            local v44 = script.VFXDunk.hoop:Clone();
            task.delay(3, v44.Destroy, v44);
            v44.CFrame = Character.Head.CFrame * CFrame.new(
                -0.620376587,
                -0.0350036621,
                -1.02715302,
                0.916358531,
                0.149542511,
                0.371381164,
                0.131741568,
                0.763331532,
                -0.63243109,
                -0.378062248,
                0.62846005,
                0.679784417
            );
            v44.Parent = Debris;
            u2.emit(v44);
        end));
    end;

    u25:Add(function() -- Line: 261
        -- upvalues: Humanoid (copy)
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
    end, true, "ShowName");
    local u45 = 2;

    for i = 1, 2 do
        local u46 = u25:Add(Character:Clone());
        u46.PlrBall:Destroy();
        u46.Humanoid.RequiresNeck = false;
        u46.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        u46.PrimaryPart = u46.HumanoidRootPart;
        u46.PrimaryPart.Anchored = true;
        local u47 = i;

        for _, v in u46:QueryDescendants("Script,LocalScript") do
            v:Destroy();
        end;

        if u46:FindFirstChild("Torso") and (u46:FindFirstChild("FrontJersey") and u46:FindFirstChild("BackJersey")) then
            u46.FrontJersey.Adornee = u46.Torso;
            u46.BackJersey.Adornee = u46.Torso;
        end;

        u46.Parent = workspace.Debris;
        local u48 = u25:Add(u46.Humanoid.Animator:LoadAnimation(script[v26][`Clone{u47}`]));
        u48:Play();
        local u49 = false;
        local u50 = false;

        local function Add() -- Line: 291
            -- upvalues: u28 (copy), u47 (copy), u46 (copy), u48 (copy), Humanoid (copy)
            u28[u47] = {
                Root = u46.HumanoidRootPart,
                Animation = u48
            };
            Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        end;

        u25:Add(task.spawn(function() -- Line: 299
            -- upvalues: u46 (copy), u48 (copy), u49 (ref), u50 (ref), u28 (copy), u47 (copy), Humanoid (copy), HumanoidRootPart (copy), TimeSent (copy)
            u46:PivotTo(CFrame.new(0, 10000, 0));

            repeat
                task.wait();
            until u48.Length > 0 or (u46 == nil or u46.Parent == nil);

            if u46 == nil or u46.Parent == nil then
                return;
            end;

            u49 = true;

            if u50 then
                u28[u47] = {
                    Root = u46.HumanoidRootPart,
                    Animation = u48
                };
                Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                u46:PivotTo(HumanoidRootPart.CFrame);
            end;

            u48.TimePosition = workspace:GetServerTimeNow() - TimeSent;
        end));
        u25:Add(task.delay(v27[u47] - u24, function() -- Line: 311
            -- upvalues: u50 (ref), u49 (ref), u28 (copy), u47 (copy), u46 (copy), u48 (copy), Humanoid (copy), HumanoidRootPart (copy)
            u50 = true;

            if u49 == true then
                u28[u47] = {
                    Root = u46.HumanoidRootPart,
                    Animation = u48
                };
                Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                u46:PivotTo(HumanoidRootPart.CFrame);
            end;
        end));
        u25:Add(task.delay(u5[v26][u47] - u24, function() -- Line: 319
            -- upvalues: u50 (ref), u46 (copy), u45 (ref), u25 (copy)
            u50 = false;
            u46:Destroy();
            u45 = u45 - 1;

            if u45 == 0 then
                u25:Remove("ShowName");
            end;
        end));

        if v26 == "Dunk" then
            if u47 == 1 then
                u25:Add(task.delay(0.4166666666666667 - u24, function() -- Line: 331
                    -- upvalues: u46 (copy), u2 (ref)
                    if u46 == nil or u46.Parent == nil then
                        return;
                    end;

                    local v51 = script.VFXDunk.Spin:Clone();
                    task.delay(3, v51.Destroy, v51);
                    v51.Parent = u46.Torso;
                    u2.emit(v51);
                end));
                u25:Add(task.delay(0.9333333333333333 - u24, function() -- Line: 339
                    -- upvalues: u46 (copy), u2 (ref)
                    if u46 == nil or u46.Parent == nil then
                        return;
                    end;

                    local v52 = script.VFXDunk.Spin:Clone();
                    task.delay(3, v52.Destroy, v52);
                    v52.Parent = u46.Torso;
                    u2.emit(v52);
                end));
            else
                u25:Add(task.delay(1.2833333333333334 - u24, function() -- Line: 347
                    -- upvalues: u46 (copy), u2 (ref)
                    if u46 == nil or u46.Parent == nil then
                        return;
                    end;

                    local v53 = script.VFXDunk.Spin:Clone();
                    task.delay(3, v53.Destroy, v53);
                    v53.Parent = u46.Torso;
                    u2.emit(v53);
                end));
            end;
        end;
    end;

    u3:playSound({
        Sound = `BBZ Ninja Shadow {v26 == "Dunk" and "Launch" or "Relay"}`,
        Parent = HumanoidRootPart
    }).TimePosition = u24;

    if v26 == "Dunk" then
        u25:Add(RunService.PreSimulation:Connect(function() -- Line: 362
            -- upvalues: u28 (copy), Sample (ref), CFrame2 (copy)
            for i, v in u28 do
                local Root = v.Root;
                local v54 = Sample({
                    Index = i,
                    Time = v.Animation.TimePosition,
                    Origin = CFrame2
                });
                Root.CFrame = CFrame.new(v54) * Root.CFrame.Rotation;
            end;
        end));
    end;
end;