  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local _ = ClientGlobals.PlayerData;
local u1 = {
    HeelFlick = require(script.HeelFlick),
    OffBalance = require(script.OffBalance),
    PerfectionPass = require(script.PerfectionPass),
    CelestialDestruction = require(script.CelestialDestruction),
    PerfectionShot = require(script.PerfectionShot),
    MagicalTurn = require(script.MagicalTurn),
    MagicalTurnSide = require(script.MagicalTurnSide)
};
local u2 = {
    DivineDestruction = require(script.Old.DivineDestruction),
    Surpass = require(script.Old.Surpass),
    ShoulderPush = require(script.Awakening.ShoulderPush)
};
local v3 = {
    meta = {}
};

local function shouldUseDivineDestruction(p4: userdata, p5: userdata) -- Line: 28
    -- upvalues: ReplicatedStorage (copy)
    local HumanoidRootPart = p5:FindFirstChild("HumanoidRootPart");
    local Football = ReplicatedStorage:FindFirstChild("Football");

    if Football then
        Football = Football.Value;
    end;

    local v6;

    if Football then
        v6 = Football:FindFirstChild("OnPlayer");
    else
        v6 = Football;
    end;

    local PenaltyArea = workspace:FindFirstChild("PenaltyArea");

    if not (HumanoidRootPart and (HumanoidRootPart:IsA("BasePart") and (Football and (Football:IsA("BasePart") and (Football.Parent == workspace and (v6 and (not v6.Value and PenaltyArea))))))) then
        return false;
    end;

    local v7 = p4.Team and p4.Team.Name;

    if v7 ~= "Home" and v7 ~= "Away" then
        return false;
    end;

    local v8 = PenaltyArea:FindFirstChild(v7 == "Away" and "Home" or "Away");

    if not (v8 and v8:IsA("BasePart")) then
        return false;
    end;

    if (v8.Position - HumanoidRootPart.Position).Magnitude > 100 then
        return false;
    end;

    local v9 = v8.CFrame:PointToObjectSpace(Football.Position);
    local v10 = v8.Size / 2;
    local v11 = math.max(Football.Size.X, Football.Size.Y, Football.Size.Z) / 2;
    local v12;

    if math.abs(v9.X) <= v10.X + v11 and math.abs(v9.Y) <= v10.Y + v11 then
        v12 = math.abs(v9.Z) <= v10.Z + v11;
    else
        v12 = false;
    end;

    return v12;
end;

function v3.getKit(p13: boolean, p14: boolean) -- Line: 67
    -- upvalues: AbilityUtils (copy), u1 (copy), interface (copy), shouldUseDivineDestruction (copy), Players (copy), u2 (copy)
    local Character, _, _, _ = AbilityUtils.getCharacter();
    local v15 = {};

    if Character.Values.HasBall.Value then
        v15[1] = {
            display = "Divine Pass",
            legacyFn = u1.PerfectionPass
        };
    else
        v15[1] = {
            display = "Off Balance",
            legacyFn = u1.OffBalance
        };
    end;

    if interface.HeelFlick then
        v15[2] = {
            display = "Heel Flick",
            legacyFn = u1.HeelFlick
        };
    else
        local v16 = Character.HumanoidRootPart.CFrame:vectorToObjectSpace(Character.Humanoid.MoveDirection);
        local v17 = math.abs(v16.Z) > 0.45 and "Front" or (math.abs(v16.X) > 0.45 and "Side" or "CD");

        if v17 == "Front" then
            v15[2] = {
                display = "Magical Turn",
                legacyFn = u1.MagicalTurn
            };
        elseif v17 == "Side" then
            v15[2] = {
                display = "Magical Turn",
                fn = u1.MagicalTurnSide
            };
        else
            v15[2] = {
                display = "Celestial Destruction",
                legacyFn = u1.CelestialDestruction
            };
        end;
    end;

    v15[3] = {
        display = "Perfection Shot",
        legacyFn = u1.PerfectionShot
    };

    if p13 then
        if not Character.Values.HasBall.Value then
            if shouldUseDivineDestruction(Players.LocalPlayer, Character) then
                v15[1] = {
                    display = "Divine Destruction",
                    legacyFn = u2.DivineDestruction
                };
            else
                v15[1] = {
                    display = "Shoulder Push",
                    fn = u2.ShoulderPush
                };
            end;
        end;

        v15[3] = {
            display = "You\'ll Never Surpass Me.",
            legacyFn = u2.Surpass
        };
    end;

    for _, v in v15 do
        v.legacyId = v.display;
    end;

    return v15;
end;

return v3;