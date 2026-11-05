  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Utility.TableUtil);
local DirectoryUtil = require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
require(ReplicatedRoot.Services.SharedFunctionService);
local AudioService = require(ReplicatedRoot.Services.AudioService);
local u1 = {};

function u1.Animation(p2, p3, p4) -- Line: 13
    -- upvalues: u1 (copy)
    local _ = p4.Name or "UNKNOWN";
    local v5 = p4.Character or p2.Character;
    local Humanoid = p4.Humanoid;

    if Humanoid then
        v5 = Humanoid;
    elseif v5 then
        v5 = v5:FindFirstChildWhichIsA("Humanoid");
    end;

    local Animator = p4.Animator;

    if Animator then
        v5 = Animator;
    elseif v5 then
        v5 = v5:FindFirstChildWhichIsA("Animator");
    end;

    if v5 ~= nil then
        local v6 = v5:LoadAnimation(p3);

        for i, v in pairs(p3:GetAttributes()) do
            v6:SetAttribute(i, v);
        end;

        local v7 = u1.AnimationTrack(p2, v6, p4);
        v7:Add(v6);

        return v7, v6;
    end;
end;

function u1.AnimationTrack(u8, u9, u10) -- Line: 33
    -- upvalues: Trove (copy)
    local _ = u10.Name or "UNKNOWN";
    local v11 = Trove.new();
    local u12 = u10.StartFrame or 0;
    local EndFrame = u10.EndFrame;
    local u13 = u10.TimeOffset or 0;
    local u14 = u10.Transition or (u9:GetAttribute("Transition") or 0.1);
    local u15 = u10.EndTransition or (u9:GetAttribute("EndTransition") or u14);
    local u16 = u10.StopTransition or (u9:GetAttribute("StopTransition") or u15);
    local u17 = u10.Weight or (u9:GetAttribute("Weight") or 1);
    local u18 = u10.Speed or (u9:GetAttribute("Speed") or 1);
    local u19 = u10.Looped or (u9:GetAttribute("Looped") or nil);
    local v20 = u10.Priority or (u9:GetAttribute("Priority") or nil);

    if v20 ~= nil then
        u9.Priority = v20;
    end;

    if u19 ~= nil then
        u9.Looped = u19;
    end;

    u9:SetAttribute("SequenceTrack", true);
    local u21 = false;

    local function UpdateTrackSpeed() -- Line: 60
        -- upvalues: u8 (copy), u9 (copy), u18 (copy)
        if u8:IsPaused() then
            u9:AdjustSpeed(0);
        elseif u9.Speed ~= u18 * u8:GetSpeed() then
            u9:AdjustSpeed(u18 * u8:GetSpeed());
        end;
    end;

    v11:Connect(u8.Updated, function(p22) -- Line: 70
        -- upvalues: u12 (copy), EndFrame (copy), u8 (copy), u9 (copy), u21 (ref), u10 (copy), u14 (copy), UpdateTrackSpeed (copy), u17 (copy), u18 (copy), u13 (copy)
        if u12 <= p22 then
            if EndFrame ~= nil and (EndFrame <= p22 and not u8:IsLooped()) then
                if u9.IsPlaying == true then
                    u21 = false;
                    u9:Stop(u10.EndTransition or u14);
                end;

                return;
            end;

            UpdateTrackSpeed();

            if u21 then
                return;
            end;

            u21 = true;

            if u9.IsPlaying == false and u8:IsPlaying() then
                u9:Play(u10.EndTransition or u14, u17, u18);

                if u10.SyncTimePosition then
                    u9.TimePosition = math.max(p22 - u12, 0) / 60 + u13;
                end;
            end;
        end;
    end);
    v11:Connect(u8.MovedTo, function(p23) -- Line: 98
        -- upvalues: u12 (copy), EndFrame (copy), u9 (copy), u8 (copy), u14 (copy), u17 (copy), u18 (copy), UpdateTrackSpeed (copy), u19 (copy), u13 (copy), u15 (copy)
        if u12 <= p23 and (EndFrame == nil or p23 < EndFrame) then
            local v24 = p23 - u12;

            if u9.IsPlaying == false and u8:IsPlaying() then
                u9:Play(u14, u17, u18);
            end;

            UpdateTrackSpeed();

            if u19 ~= true then
                u9.TimePosition = v24 / 60 + u13;
            end;
        elseif (p23 < u12 or EndFrame ~= nil and EndFrame <= p23) and u9.IsPlaying == true then
            u9:Stop(u15);
        end;
    end);
    v11:Connect(u8.Stopped, function() -- Line: 118
        -- upvalues: u21 (ref), u9 (copy), u16 (copy)
        u21 = false;
        u9:Stop(u16);
    end);
    v11:Connect(u8.Failed, function() -- Line: 123
        -- upvalues: u21 (ref), u9 (copy), u16 (copy)
        u21 = false;
        u9:Stop(u16);
    end);
    v11:Connect(u8.Ended, function() -- Line: 128
        -- upvalues: u21 (ref), u9 (copy), u15 (copy)
        u21 = false;

        if u9.Looped == true then
            u9:Stop(u15);
        end;
    end);
    v11:Add(function() -- Line: 135
        -- upvalues: u9 (copy), u16 (copy)
        if u9 then
            u9:Stop(u16);
        end;
    end);

    return v11, u9;
end;

function u1.SoundData(u25, u26, u27) -- Line: 144
    -- upvalues: Trove (copy), DirectoryUtil (copy), AudioService (copy), u1 (copy)
    local v28 = Trove.new();
    local u29 = nil;
    local u30 = v28:Extend();

    local function RemoveSound() -- Line: 150
        -- upvalues: u30 (copy), u29 (ref)
        u30:Destroy();
        u29 = nil;
    end;

    local u31 = u27.Parent or (u26.Parent or u25.RootPart);
    local u32 = u27.Position or (u26.Position or nil);

    if typeof(u31) == "string" then
        u31 = DirectoryUtil.Get({
            Path = u31,
            Roots = {
                { "@Character", u25.Character },
                { "@Attacker", u25.Character },
                { "@RootPart", u25.RootPart },
                { "@Sequence", u25 }
            }
        });
    end;

    local function CreateSound() -- Line: 169
        -- upvalues: u29 (ref), u30 (copy), AudioService (ref), u26 (copy), u31 (ref), u32 (copy), u1 (ref), u25 (copy), u27 (copy)
        if u29 then
            return;
        end;

        u29 = u30:Construct(AudioService.CreateSound, u26, {
            Parent = u31,
            Position = u32
        });
        u30:Construct(u1.Sound, u25, u29, u27);
        u30:Connect(u29.Ended, function() -- Line: 179
            -- upvalues: u25 (ref), u30 (ref), u29 (ref)
            if not u25:IsPlaying() then
                u30:Destroy();
                u29 = nil;
            end;
        end);
    end;

    v28:Connect(u25.Played, function() -- Line: 186
        -- upvalues: CreateSound (copy)
        CreateSound();
    end);
    v28:Connect(u25.Stopped, function() -- Line: 190
        -- upvalues: u27 (copy), u30 (copy), u29 (ref)
        if u27.Interrupt ~= false then
            u30:Destroy();
            u29 = nil;
        end;
    end);

    return v28;
end;

function u1.Sound(u33, u34, u35) -- Line: 199
    -- upvalues: Trove (copy)
    local _ = u35.Name or "UNKNOWN";
    local v36 = Trove.new();
    local u37 = u35.StartFrame or 0;
    local EndFrame = u35.EndFrame;
    local u38 = u35.TimeOffset or 0;
    local u39 = u35.PlaybackSpeed or (u34:GetAttribute("PlaybackSpeed") or u34.PlaybackSpeed);
    local u40 = u35.PlaybackTimescale or (u34:GetAttribute("PlaybackTimescale") or 1);
    local u41 = v36:Construct(Instance, "PitchShiftSoundEffect");
    u41.Octave = 1;
    u41.Parent = u34;
    local u42 = false;

    local function UpdateSoundSpeed() -- Line: 215
        -- upvalues: u39 (copy), u33 (copy), u34 (copy), u41 (copy), u40 (copy)
        local v43 = u39 * u33:GetSpeed();

        if u34.PlaybackSpeed ~= v43 then
            u34.PlaybackSpeed = v43;
            u41.Octave = u40 / u33:GetSpeed();
        end;
    end;

    v36:Connect(u33.Updated, function(p44) -- Line: 223
        -- upvalues: u37 (copy), EndFrame (copy), u33 (copy), u34 (copy), u42 (ref), u39 (copy), u41 (copy), u40 (copy), u35 (copy), u38 (copy)
        if u37 <= p44 then
            if EndFrame ~= nil and (EndFrame <= p44 and not u33:IsLooped()) then
                if u34.Playing == true then
                    u42 = false;
                    u34:Stop();
                end;

                return;
            end;

            local v45 = u39 * u33:GetSpeed();

            if u34.PlaybackSpeed ~= v45 then
                u34.PlaybackSpeed = v45;
                u41.Octave = u40 / u33:GetSpeed();
            end;

            if u42 then
                return;
            end;

            u42 = true;

            if u34.Playing == false and u33:IsPlaying() then
                u34:Play();

                if u35.SyncTimePosition then
                    u34.TimePosition = math.max(p44 - u37, 0) / 60 + u38;
                end;
            end;
        end;
    end);
    v36:Connect(u33.MovedTo, function(p46) -- Line: 251
        -- upvalues: u37 (copy), EndFrame (copy), u34 (copy), u33 (copy), u39 (copy), u41 (copy), u40 (copy), u38 (copy)
        if u37 <= p46 and (EndFrame == nil or p46 < EndFrame) then
            local v47 = p46 - u37;

            if u34.Playing == false and u33:IsPlaying() then
                u34:Play();
            end;

            local v48 = u39 * u33:GetSpeed();

            if u34.PlaybackSpeed ~= v48 then
                u34.PlaybackSpeed = v48;
                u41.Octave = u40 / u33:GetSpeed();
            end;

            if u34.Looped ~= true then
                u34.TimePosition = v47 / 60 + u38;
            end;
        elseif (p46 < u37 or EndFrame ~= nil and EndFrame <= p46) and u34.Playing == true then
            u34:Stop();
        end;
    end);
    v36:Connect(u33.Stopped, function() -- Line: 271
        -- upvalues: u42 (ref), u35 (copy), u34 (copy)
        u42 = false;

        if u35.Interrupt ~= false then
            u34:Stop();
        end;
    end);
    v36:Connect(u33.Failed, function() -- Line: 278
        -- upvalues: u42 (ref), u34 (copy)
        u42 = false;
        u34:Stop();
    end);
    v36:Connect(u33.Ended, function() -- Line: 283
        -- upvalues: u42 (ref), u34 (copy)
        u42 = false;

        if u34.Looped == true then
            u34:Stop();
        end;
    end);
    v36:Add(function() -- Line: 290
        -- upvalues: u34 (copy)
        if u34 then
            u34:Stop();
        end;
    end);

    if u33:IsPlaying() then
        u34:Play();
    end;

    return v36, u34;
end;

return u1;