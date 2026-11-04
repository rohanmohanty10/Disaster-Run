  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local u1 = { "t1", "t2", "t3", "t4" };

return function(p2) -- Line: 11
    -- upvalues: Players (copy), SpectatorController (copy), u1 (copy), Essentials (copy), CutsceneUtils (copy), ReplicatedStorage (copy), SoundService (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not (SpectatorController.IsSpectating or Players.LocalPlayer:GetAttribute("MVPPreviewActive")) then
        return;
    end;

    local Char = p2.Char;

    if not Char then
        return;
    end;

    local v3 = p2.Teammates or {};
    local u4 = {
        Rekysui = Char
    };
    local v5 = {};

    for i, v in u1 do
        local v6 = v3[i];

        if v6 and (v6.Parent and v6:FindFirstChild("HumanoidRootPart")) then
            u4[v] = v6;
            table.insert(v5, v6);
        end;
    end;

    local v7 = {
        Icon = "",
        Name = Char.Name
    };
    local u8 = require(script.Subtitles)(v7);
    local v9 = Essentials:HideCosmetics(Char);
    local v10 = {};

    for _, v in v5 do
        v10[v] = Essentials:HideCosmetics(v);
    end;

    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local Field = workspace:FindFirstChild("Field");
    local v11;

    if Field and Field:IsA("Model") then
        v11 = Field:GetPivot() or nil;
    else
        v11 = nil;
    end;

    if v11 then
        Field:PivotTo(v11 + Vector3.new(0, -0.6, 0));
    end;

    local WorldCupMVP = ReplicatedStorage.Assets.MoonCutsceneFiles:FindFirstChild("WorldCupMVP");

    if WorldCupMVP then
        WorldCupMVP = WorldCupMVP:FindFirstChild("WorldCupThemedMap1", true);
    end;

    local v12;

    if WorldCupMVP then
        v12 = WorldCupMVP.Parent;
    else
        v12 = WorldCupMVP;
    end;

    if WorldCupMVP then
        WorldCupMVP.Parent = nil;
    end;

    SoundService.SoundGroup.OST.Volume = 0;
    local success, result = pcall(function() -- Line: 75
        -- upvalues: CutsceneUtils (ref), Char (copy), u4 (copy), u8 (copy)
        CutsceneUtils.PlayCutscene(Char, u4, "WorldCupMVP", script.CodeEvents, nil, u8, script.SoundEvents);
    end);

    if WorldCupMVP and v12 then
        WorldCupMVP.Parent = v12;
    end;

    if Field and (v11 and Field.Parent) then
        Field:PivotTo(v11);
    end;

    if not success then
        warn(("WorldCupMVP playback failed: %s"):format((tostring(result))));
    end;

    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    Essentials:UnhideCosmetics(v9);

    for _, v in v10 do
        Essentials:UnhideCosmetics(v);
    end;
end;