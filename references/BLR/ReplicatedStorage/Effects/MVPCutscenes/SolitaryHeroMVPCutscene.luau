  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

local function hideField() -- Line: 9
    local v1 = {};
    local Field = workspace:FindFirstChild("Field");

    if not Field then
        return v1;
    end;

    for _, descendant in Field:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            table.insert(v1, {
                Property = "Transparency",
                Instance = descendant,
                Value = descendant.Transparency
            });
            descendant.Transparency = 1;
        elseif descendant:IsA("Highlight") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("Smoke") or (descendant:IsA("Fire") or (descendant:IsA("Sparkles") or (descendant:IsA("Light") or (descendant:IsA("SurfaceGui") or descendant:IsA("BillboardGui"))))))))) then
            table.insert(v1, {
                Property = "Enabled",
                Instance = descendant,
                Value = descendant.Enabled
            });
            descendant.Enabled = false;
        end;
    end;

    return v1;
end;

local function restoreField(p2) -- Line: 47
    for _, v in p2 do
        local Instance = v.Instance;

        if Instance and Instance.Parent then
            pcall(function() -- Line: 51
                -- upvalues: Instance (copy), v (copy)
                Instance[v.Property] = v.Value;
            end);
        end;
    end;
end;

return function(p3) -- Line: 58
    -- upvalues: Players (copy), SpectatorController (copy), Essentials (copy), hideField (copy), CutsceneUtils (copy), SoundService (copy), restoreField (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not (SpectatorController.IsSpectating or Players.LocalPlayer:GetAttribute("MVPPreviewActive")) then
        return;
    end;

    local Char = p3.Char;

    if not Char then
        return;
    end;

    local v4 = {
        Icon = "",
        Name = Char.Name
    };
    require(script.Subtitles)(v4);
    local v5 = Essentials:HideCosmetics(Char);
    local v6 = hideField();
    local v7, v8 = xpcall(function() -- Line: 74
        -- upvalues: CutsceneUtils (ref), SoundService (ref), Char (copy)
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        SoundService.SoundGroup.OST.Volume = 0;
        CutsceneUtils.PlayCutscene({
            MoonFileName = "SolitaryHeroMVPCutscene",
            GoalFrame = 560,
            Character = Char,
            CharsToReplace = {
                Shidou = Char
            },
            CodeEvents = script.CodeEvents,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);
    restoreField(v6);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    Essentials:UnhideCosmetics(v5);

    if not v7 then
        warn("[SolitaryHeroMVPCutscene] playback failed:", v8);
    end;
end;