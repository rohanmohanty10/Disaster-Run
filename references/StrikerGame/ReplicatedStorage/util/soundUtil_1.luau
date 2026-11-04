 
 

local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local Util = require(ReplicatedStorage.util.Util);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local u1 = {};

local function getPlayer(p2) -- Line: 19
    -- upvalues: Players (copy)
    if typeof(p2) == "Instance" then
        return Players:GetPlayerFromCharacter(p2);
    end;
end;

local function attachFromCFrame(p3) -- Line: 24
    -- upvalues: Debris (copy)
    local Attachment = Instance.new("Attachment");
    Attachment.WorldCFrame = p3;
    Attachment.Parent = workspace.Terrain;
    Debris:AddItem(Attachment, 720);

    return Attachment;
end;

local function bindResync(u4: userdata, p5: any) -- Line: 32
    u4.Ended:Once(function() -- Line: 71
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;

local isSettingEnabled = Util.isSettingEnabled;

function u1.play(p6, p7, p8, p9, p10) -- Line: 78
    -- upvalues: ReplicatedStorage (copy), RunService (copy), isSettingEnabled (copy), Players (copy), actionUtil (copy), Debris (copy), u1 (copy), SoundService (copy)
    if p7 ~= nil then
        if type(p7) == "string" then
            p7 = ReplicatedStorage.Resources:FindFirstChild(p7);

            if not p7 then
                return;
            end;
        end;

        local v11 = p9 or {};
        local Character = v11.Character;
        v11.Character = nil;
        local EmoteAudio = v11.EmoteAudio;
        v11.EmoteAudio = nil;
        local v12 = (not RunService:IsClient() or isSettingEnabled(Players.LocalPlayer, "modifiedVoices")) and true or false;
        local v13;

        if typeof(Character) == "Instance" then
            v13 = Players:GetPlayerFromCharacter(Character);
        else
            v13 = nil;
        end;

        if v12 and v13 then
            local v14 = actionUtil.checkStyle(v13);

            if p7:FindFirstChild("Dub") and (v13:HasTag("dubVoicelines") or v14 and isSettingEnabled(v13, (`dub_{v14}`))) then
                p7 = p7.Dub;
            end;
        end;

        local u15;

        if typeof(p7) == "table" then
            local v16 = {};

            for _, v in ipairs(p7) do
                if v then
                    v16[#v16 + 1] = v;
                end;
            end;

            u15 = v16[math.random(#v16)]:Clone();
        else
            u15 = p7:Clone();
        end;

        for i, v in pairs(v11) do
            u15[i] = v;
        end;

        if EmoteAudio then
            u15:SetAttribute("EmoteAudio", true);
        end;

        if typeof(p8) == "CFrame" then
            local Attachment = Instance.new("Attachment");
            Attachment.WorldCFrame = p8;
            Attachment.Parent = workspace.Terrain;
            Debris:AddItem(Attachment, 720);
            u15.Destroying:Once(function() -- Line: 131
                -- upvalues: Attachment (copy)
                pcall(game.Destroy, Attachment);
            end);
            p8 = Attachment;
        elseif p8 == u1 then
            p8 = SoundService;
        elseif p8 == "default" then
            p8 = SoundService;
        end;

        u15.Parent = p8;

        if p10 then
            u15.PlayOnRemove = true;
            u15:Destroy();

            return u15;
        end;

        local v17 = u15:GetAttribute("PlaybackDelay") or 0;

        if v17 > 0 then
            task.delay(v17, u15.Play, u15);
        else
            u15:Play();
        end;

        if RunService:IsServer() then
            if not u15.Looped then
                Debris:AddItem(u15, u15.TimeLength + (v17 + 1));

                return u15;
            end;
        elseif not u15.Looped then
            u15.Ended:Once(function() -- Line: 71
                -- upvalues: u15 (copy)
                u15:Destroy();
            end);
        end;

        return u15;
    end;
end;

function u1.stop(p18: table, p19: any, p20: userdata) -- Line: 170
    if p19:FindFirstChild(p20) then
        p19:FindFirstChild(p20):Destroy();
    end;
end;

return u1;