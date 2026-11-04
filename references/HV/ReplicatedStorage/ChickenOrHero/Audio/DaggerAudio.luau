 

 

local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local Parent = script.Parent.Parent;
local ParticipantDirectory = require(Parent.Presentation.ParticipantDirectory);
local SkinCatalog = require(Parent.Weapons.SkinCatalog);
local DaggerConfig = require(Parent.Weapons.DaggerConfig);
local FantasyKnifeAudio = require(script.Parent.FantasyKnifeAudio);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 11
    -- upvalues: FantasyKnifeAudio (copy), u1 (copy)
    FantasyKnifeAudio.install(p2);

    return setmetatable({
        previewAt = 0,
        playback = p2,
        cfg = p3,
        records = {},
        remoteTimes = {}
    }, u1);
end;

local function key(p4, p5) -- Line: 16
    -- upvalues: SkinCatalog (copy)
    local v6 = SkinCatalog.get(p4);

    if v6 then
        v6 = (p5 == "Hit" or p5 == "DiveHit") and v6.HitSoundProfile or v6.SoundProfile;
    end;

    if v6 then
        v6 = "Knife_" .. v6 .. "_" .. p5;
    end;

    return v6;
end;

function u1.play(p7, p8, p9) -- Line: 21
    -- upvalues: Players (copy), SkinCatalog (copy), FantasyKnifeAudio (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v10;

    if LocalPlayer == nil then
        v10 = false;
    else
        v10 = p8 == LocalPlayer.Character;
    end;

    local HumanoidRootPart = p8:FindFirstChild("HumanoidRootPart");
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not HumanoidRootPart then
        return;
    end;

    if not (v10 or workspace_CurrentCamera and (HumanoidRootPart.Position - workspace_CurrentCamera.CFrame.Position).Magnitude <= p7.cfg.RemoteActionDistance) then
        return;
    end;

    local Attribute = p8:GetAttribute("DaggerSkin");
    local v11 = SkinCatalog.get(Attribute);

    if v11 then
        v11 = (p9 == "Hit" or p9 == "DiveHit") and v11.HitSoundProfile or v11.SoundProfile;
    end;

    if v11 then
        v11 = "Knife_" .. v11 .. "_" .. p9;
    end;

    if not v11 then
        return;
    end;

    if not v10 then
        local os_clock_ret = os.clock();

        while p7.remoteTimes[1] and os_clock_ret - p7.remoteTimes[1] > 0.12 do
            table.remove(p7.remoteTimes, 1);
        end;

        if #p7.remoteTimes >= 4 then
            return;
        end;

        table.insert(p7.remoteTimes, os_clock_ret);
    end;

    local v12;

    if v10 or not HumanoidRootPart then
        v12 = nil;
    else
        v12 = HumanoidRootPart;
    end;

    p7.playback:one(v11, v12, v10 and 1 or 0.85);

    if v10 or not HumanoidRootPart then
        HumanoidRootPart = nil;
    end;

    FantasyKnifeAudio.layer(p7.playback, v11, HumanoidRootPart, v10 and 1 or 0.85);
end;

function u1.update(p13) -- Line: 52
    -- upvalues: ParticipantDirectory (copy), Players (copy), DaggerConfig (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v14 = {};

    for _, v in ParticipantDirectory.list() do
        local Character = v.Character;

        if Character and (Character.Parent and Character:GetAttribute("DaggerEquipped")) then
            v14[Character] = true;
            local Attribute = Character:GetAttribute("DaggerDrawStartedAt");
            local LocalPlayer = Players.LocalPlayer;

            if LocalPlayer then
                if Character == Players.LocalPlayer.Character then
                    LocalPlayer = Character:GetAttribute("LocalMeleeActive") == true;
                else
                    LocalPlayer = false;
                end;
            end;

            local v15 = LocalPlayer and Character:GetAttribute("LocalMeleeStartedAt") or Character:GetAttribute("ReachStartedAt");
            local Attribute2 = Character:GetAttribute("TackleStartedAt");
            local Attribute3 = Character:GetAttribute("DaggerState");
            local v16 = LocalPlayer and Character:GetAttribute("LocalMeleePhase") or Character:GetAttribute("ReachPhase");
            local Attribute4 = v:GetAttribute("StudioKnifeActionAt");
            local Attribute5 = v:GetAttribute("StudioKnifeAction");
            local v17 = p13.records[Character];

            if v17 then
                if ((game:GetService("RunService"):IsStudio() or (game.PlaceId == 130574217370467 or v:GetAttribute("ContentTeam") == true)) and v:GetAttribute("StudioKnifePreview") or v:GetAttribute("InMatch") ~= true and (tonumber(v:GetAttribute("LobbyKnifeOutUntil")) or 0) > workspace:GetServerTimeNow()) and (Attribute4 and Attribute4 ~= v17.previewAt) then
                    if Attribute5 == "Stab" then
                        p13:play(Character, "Swing");

                        if LocalPlayer then
                            v17.lastLocalSwingAt = ServerTimeNow;
                        end;
                    elseif Attribute5 == "Dive" then
                        p13:play(Character, "Dive");
                    end;
                end;

                v17.previewAt = Attribute4;

                if Attribute and (Attribute ~= v17.draw and ServerTimeNow - Attribute < 0.5) then
                    p13:play(Character, "Equip");
                end;

                v17.draw = Attribute;

                if Attribute3 == "Stowed" and (v17.state == "Held" or v17.state == "Drawing") then
                    p13:play(Character, "Sheath");
                end;

                v17.state = Attribute3;

                if Attribute2 and (Attribute2 ~= v17.dive and (ServerTimeNow - Attribute2 < 0.4 and ServerTimeNow - (v17.lastDiveAt or (-1 / 0)) > 0.4)) then
                    p13:play(Character, "Dive");
                    v17.lastDiveAt = ServerTimeNow;
                end;

                v17.dive = Attribute2;

                if v15 and (v15 ~= v17.stab and v15 + DaggerConfig.StabDelay <= ServerTimeNow) then
                    if ServerTimeNow - v15 < DaggerConfig.StabDelay + 0.35 and (not Character:GetAttribute("TackleActive") and ServerTimeNow - (v17.lastSwingAt or (-1 / 0)) > 0.4) then
                        p13:play(Character, "Swing");
                        v17.lastSwingAt = ServerTimeNow;
                    end;

                    v17.stab = v15;
                end;

                if not v15 then
                    v17.stab = nil;
                end;

                local v18 = v16 == "Tracking" and true or v16 == "Windup";
                local v19 = v17.phase == "Tracking" and true or v17.phase == "Windup";

                if v18 and not v19 then
                    v17.prepareStab = v15;
                    v17.prepareDive = Attribute2;

                    if ServerTimeNow - v17.windupAt > 0.9 and not Character:GetAttribute("TackleActive") then
                        p13:play(Character, "Windup");
                        v17.windupAt = ServerTimeNow;
                    end;
                elseif v19 and not (v18 or (Attribute3 ~= "Held" or (v15 ~= v17.prepareStab or (Attribute2 ~= v17.prepareDive or (Character:GetAttribute("TackleActive") or ServerTimeNow - (v17.cancelAt or 0) <= 0.9))))) then
                    p13:play(Character, "Cancel");
                    v17.cancelAt = ServerTimeNow;
                end;

                v17.phase = v16;
            else
                p13.records[Character] = {
                    previewAt = Attribute4,
                    draw = Attribute,
                    stab = v15,
                    dive = Attribute2,
                    state = Attribute3,
                    phase = v16,
                    windupAt = ServerTimeNow
                };

                if Attribute3 == "Drawing" and (type(Attribute) == "number" and ServerTimeNow - Attribute < 0.3) then
                    p13:play(Character, "Equip");
                end;
            end;
        end;
    end;

    for i in p13.records do
        if not v14[i] then
            p13.records[i] = nil;
        end;
    end;
end;

function u1.hit(p20, p21) -- Line: 165
    -- upvalues: SkinCatalog (copy), Players (copy), FantasyKnifeAudio (copy), Debris (copy)
    if type(p21) ~= "table" or typeof(p21.position) ~= "Vector3" then
        return;
    end;

    local v22;

    if p21.dive == true then
        v22 = SkinCatalog.get(p21.skin);

        if v22 then
            v22 = v22.HitSoundProfile or v22.SoundProfile;
        end;

        if v22 then
            v22 = "Knife_" .. v22 .. "_DiveHit";
        end;
    else
        v22 = false;
    end;

    if not (v22 and p20.playback:template(v22)) then
        v22 = SkinCatalog.get(p21.skin);

        if v22 then
            v22 = v22.HitSoundProfile or v22.SoundProfile;
        end;

        if v22 then
            v22 = "Knife_" .. v22 .. "_Hit";
        end;
    end;

    if not v22 then
        return;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer and p21.catcher == LocalPlayer.UserId then
        p20.playback:one(v22, nil, 1);
        FantasyKnifeAudio.layer(p20.playback, v22, nil, 1);

        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera or (p21.position - workspace_CurrentCamera.CFrame.Position).Magnitude > p20.cfg.RemoteActionDistance then
        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "KnifeImpactAudio";
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = p21.position;
    p20.playback:one(v22, Attachment, 0.9);
    FantasyKnifeAudio.layer(p20.playback, v22, Attachment, 0.9);
    Debris:AddItem(Attachment, 4);
end;

function u1.preview(u23, p24, p25) -- Line: 196
    -- upvalues: Players (copy), SkinCatalog (copy), FantasyKnifeAudio (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer:GetAttribute("ArmoryOpen") ~= true and (LocalPlayer:GetAttribute("BalloonOfferOpen") ~= true and LocalPlayer:GetAttribute("BundleOfferOpen") ~= true) or os.clock() - u23.previewAt < 0.18 then
        return;
    end;

    if not table.find(SkinCatalog.SoundEvents, p25) then
        return;
    end;

    local u26 = SkinCatalog.get(p24);

    if u26 then
        u26 = (p25 == "Hit" or p25 == "DiveHit") and u26.HitSoundProfile or u26.SoundProfile;
    end;

    if u26 then
        u26 = "Knife_" .. u26 .. "_" .. p25;
    end;

    local u27;

    if u26 then
        u27 = u23.playback:template(u26);
    else
        u27 = u26;
    end;

    if not u27 then
        return;
    end;

    u23.previewAt = os.clock();
    u23.previewSerial = (u23.previewSerial or 0) + 1;
    local previewSerial = u23.previewSerial;
    task.spawn(function() -- Line: 220
        -- upvalues: previewSerial (copy), u23 (copy), LocalPlayer (copy), u26 (copy), u27 (copy), FantasyKnifeAudio (ref)
        if previewSerial ~= u23.previewSerial or not u23.playback.alive then
            return;
        end;

        if LocalPlayer:GetAttribute("ArmoryOpen") ~= true and (LocalPlayer:GetAttribute("BalloonOfferOpen") ~= true and LocalPlayer:GetAttribute("BundleOfferOpen") ~= true) then
            return;
        end;

        if u23.previewVoice then
            u23.playback:remove(u23.previewVoice);
        end;

        u23.previewVoice = u23.playback:create(u26, u27, nil, 1.15, 1, false);
        u23.playback:trace(u26, u23.previewVoice ~= nil);
        FantasyKnifeAudio.layer(u23.playback, u26, nil, 1.15);
    end);
end;

function u1.destroy(p28) -- Line: 240
    table.clear(p28.records);
end;

return u1;