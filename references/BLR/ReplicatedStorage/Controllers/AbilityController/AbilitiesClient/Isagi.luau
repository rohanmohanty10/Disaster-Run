  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local PlayerData = ClientGlobals.PlayerData;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = false;
local u2 = {
    DirectShot = require(script.DirectShot),
    Fadeaway = require(script.Fadeaway)
};
local u3 = {
    FinalShot = require(script.Awakening.FinalShot),
    NelDirectShot = require(script.NEL.DirectShot),
    Omnivision = require(script.NEL.Omnivision),
    MetaBurstPoint = require(script.NEL.MetaBurstPoint),
    VisionStoppage = require(script.NEL.VisionStoppage),
    SideStepDribble = require(script.NEL.SideStepDribble),
    DemonKing = require(script.NEL.Awakening.DemonKing),
    TwoGunVolley = require(script.NEL.Awakening.TwoGunVolley),
    AdaptiveWin = require(script.NEL.Awakening.AdaptiveWin)
};
local v4 = {
    meta = {}
};

local function isPointInVolume(p5: vector, p6, p7: vector) -- Line: 33
    local v8 = p6:PointToObjectSpace(p5);
    local v9;

    if v8.X >= -p7.X / 2 and (v8.X <= p7.X / 2 and (v8.Y >= -p7.Y / 2 and (v8.Y <= p7.Y / 2 and v8.Z >= -p7.Z / 2))) then
        v9 = v8.Z <= p7.Z / 2;
    else
        v9 = false;
    end;

    return v9;
end;

function v4.getKit(p10: boolean, p11: boolean) -- Line: 43
    -- upvalues: AbilityUtils (copy), PlayerData (copy), countStyleMastery (copy), u2 (copy), u3 (copy), interface (copy), LocalPlayer (copy), u1 (ref)
    local Character, _, _, _ = AbilityUtils.getCharacter();
    local v12, v13;

    if p11 and PlayerData.Data then
        v12 = countStyleMastery(PlayerData.Data, "Isagi");
        v13 = PlayerData.Data.DisabledMasteryLevels.Isagi;
    else
        v12 = 0;
        v13 = {};
    end;

    local v14 = {
        {
            display = "Direct Shot",
            legacyFn = u2.DirectShot
        },
        {
            display = "Fadeaway",
            legacyFn = u2.Fadeaway
        }
    };

    if p10 then
        v14[3] = {
            display = "Final Shot",
            fn = u3.FinalShot
        };
    end;

    if v12 >= 1 and not (v13[1] or p10) then
        if Character.Values.HasBall.Value then
            v14[1] = {
                display = "Direct Shot",
                legacyFn = u3.NelDirectShot
            };
        else
            v14[1] = {
                display = "Omnivision",
                legacyFn = u3.Omnivision
            };
        end;
    end;

    if v12 >= 2 and not (v13[2] or p10) then
        if interface.VisionStoppage then
            v14[2] = {
                display = "Vision Stoppage",
                fn = u3.VisionStoppage
            };
        else
            v14[2] = {
                display = "Meta-Burst Point",
                fn = u3.MetaBurstPoint
            };
        end;
    end;

    if v12 >= 3 and not (v13[3] or p10) then
        v14[3] = {
            display = "Side Step Dribble",
            fn = u3.SideStepDribble
        };
    end;

    if v12 >= 4 and (not v13[4] and p10) then
        v14[1] = {
            display = "Demon King",
            legacyFn = u3.DemonKing
        };
        v14[2] = {
            display = "Two Gun Volley",
            fn = u3.TwoGunVolley
        };
        v14[3] = {
            display = "Adaptive Win",
            fn = u3.AdaptiveWin
        };
    end;

    if p11 and (v12 >= 1 and LocalPlayer:GetAttribute("CRRequest") == "NELIsagiXHiori") then
        v14[1] = {
            display = "Direct Shot",
            legacyFn = u3.NelDirectShot
        };
    end;

    if p11 then
        if p10 then
            p10 = LocalPlayer:GetAttribute("CRRequest") == "IsagiBachiraCR";
        end;
    else
        p10 = p11;
    end;

    if p10 then
        v14[1] = {
            display = "I AM... A STRIKER!",
            legacyFn = u2.DirectShot
        };
    end;

    if p11 and p10 ~= u1 then
        u1 = p10;
        print("[IBCR client] slot-1 striker label active:", p10);
    end;

    for _, v in v14 do
        v.legacyId = v.display;
    end;

    return v14;
end;

return v4;