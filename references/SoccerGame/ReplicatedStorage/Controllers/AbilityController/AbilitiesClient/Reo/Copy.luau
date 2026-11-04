  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local PlrStyles = require(ReplicatedStorage.Shared.PlrStyles);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local environment = require(ReplicatedStorage.Shared.environment);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

local function Copy(p1) -- Line: 18
    -- upvalues: AbilityUtils (copy), interface (copy), Players (copy), RunService (copy), Popup (copy), LocalPlayer (copy), PlrStyles (copy), StatesController (copy), SoundManager (copy)
    if not AbilityUtils.rules.slotReady(interface.CopySlot or 1) then
        return;
    end;

    local v2;

    if p1 then
        v2 = workspace;
    else
        v2 = AbilityUtils.rules.anyTarget(600);
    end;

    if not v2 then
        return;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(v2);
    local v3 = RunService:IsStudio() and workspace.PassRig:GetAttribute("Style") or "Nagi";

    if PlayerFromCharacter then
        v3 = PlayerFromCharacter.PlayerStats.Style.Value;
    end;

    local v4 = p1 or v3;

    if v4 == "Reo" then
        Popup.Popup(LocalPlayer, "Can\'t copy another Reo!");

        return;
    end;

    local Rarity = PlrStyles[v4].Rarity;

    if not (Rarity ~= "Master" and Rarity ~= "Limited" or StatesController:IsAwakened()) then
        Popup.Popup(LocalPlayer, "That styles weapons are too advanced!");

        return;
    end;

    print("copy Style");
    SoundManager.SpawnSound("ReoChameleon", 0.6, workspace, 150);
    interface:FireServerAbility("Chameleon", {
        VFX = "Copying",
        Target = PlayerFromCharacter
    });
    local u5 = time();
    interface._copy_tag = u5;
    interface.CopyingStyle = v4;
    interface.CopyingPlayer = PlayerFromCharacter;
    task.delay(10, function() -- Line: 56
        -- upvalues: interface (ref), u5 (copy)
        if interface._copy_tag == u5 then
            interface._copy_tag = nil;
            interface.CopyingStyle = nil;
            interface.CopyingPlayer = nil;
        end;
    end);
end;

if environment.env == "Dev" then
    LocalPlayer.Chatted:Connect(function(p6) -- Line: 66
        -- upvalues: PlrStyles (copy), Copy (copy)
        print("msg", p6);

        if PlrStyles[p6] then
            Copy(p6);
        end;
    end);
end;

return Copy;