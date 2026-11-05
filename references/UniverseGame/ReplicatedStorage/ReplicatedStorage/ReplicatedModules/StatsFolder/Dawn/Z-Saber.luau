  

 

local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");
local u2 = {
    [50] = {
        EffectName = "Overwrite_Button",
        PoseMusic = "Overwrite_Pose",
        TemporalColors = {
            Primary = Color3.fromRGB(164, 7, 255),
            Secondary = Color3.fromRGB(133, 0, 157)
        },
        TauntData = {
            Text = "ACT: Overwrite!",
            SoundId = "rbxassetid://7074901850",
            Volume = 10,
            Speed = 1.1,
            Options = {}
        },
        ExcludedUsers = { 42753742 }
    }
};

local function BlacklistCheck(p3, p4) -- Line: 39
    if p4 then
        return not (p4.ExcludedUsers and table.find(p4.ExcludedUsers, p3.UserId));
    end;

    return false;
end;

local function GetCustomEffect(p5) -- Line: 47
    -- upvalues: u2 (copy)
    local v6 = p5.Data.Skin:GetAttribute("UnusualHueId");

    if not v6 then
        return nil;
    end;

    local v7 = u2[v6];

    if v7 then
        local v8;

        if v7 then
            v8 = not (v7.ExcludedUsers and table.find(v7.ExcludedUsers, p5.UserId));
        else
            v8 = false;
        end;

        if v8 then
            return v7;
        end;
    end;

    return nil;
end;

local function RunCustomEffect(p9, p10, p11, p12) -- Line: 59
    -- upvalues: u1 (copy)
    if not p11 then
        return;
    end;

    u1.FireAllClients(p11.EffectName, {
        Player = p9,
        Character = p10,
        Mode = p12
    });

    if p12 then
        local TemporalColors = p11.TemporalColors;
        u1.FireClient(p9, "TemporalEffect", TemporalColors.Primary, TemporalColors.Secondary, 0.25);

        if p11.TauntData then
            u1.FireAllClients("Taunt", p10, {
                p11.TauntData.Text,
                p11.TauntData.SoundId,
                p11.TauntData.Options,
                p11.TauntData.Volume,
                p11.TauntData.Speed
            });
        end;
    end;
end;

return {
    Inherit = {
        AbilityName = "Dawn"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseTransition = function(p13) -- Line: 86, Name: PoseTransition
                    -- upvalues: u2 (copy), RunCustomEffect (copy)
                    if p13._Ended then
                        return;
                    end;

                    local Player = p13.Player;
                    local v14 = Player.Data.Skin:GetAttribute("UnusualHueId");
                    local v15;

                    if v14 then
                        v15 = u2[v14];

                        if v15 then
                            local v16;

                            if v15 then
                                v16 = not (v15.ExcludedUsers and table.find(v15.ExcludedUsers, Player.UserId));
                            else
                                v16 = false;
                            end;

                            if not v16 then
                                v15 = nil;
                            end;
                        else
                            v15 = nil;
                        end;
                    else
                        v15 = nil;
                    end;

                    if v15 then
                        RunCustomEffect(p13.Player, p13.Character, v15, true);
                    end;
                end,

                PoseEnd = function(p17) -- Line: 93, Name: PoseEnd
                    -- upvalues: u2 (copy), u1 (copy)
                    p17._Ended = true;
                    local Player = p17.Player;
                    local v18 = Player.Data.Skin:GetAttribute("UnusualHueId");
                    local v19;

                    if v18 then
                        v19 = u2[v18];

                        if v19 then
                            local v20;

                            if v19 then
                                v20 = not (v19.ExcludedUsers and table.find(v19.ExcludedUsers, Player.UserId));
                            else
                                v20 = false;
                            end;

                            if not v20 then
                                v19 = nil;
                            end;
                        else
                            v19 = nil;
                        end;
                    else
                        v19 = nil;
                    end;

                    if v19 then
                        if not v19 then
                            return;
                        end;

                        u1.FireAllClients(v19.EffectName, {
                            Mode = false,
                            Player = p17.Player,
                            Character = p17.Character
                        });
                    end;
                end,

                Transformer = function(p21) -- Line: 100, Name: Transformer
                    -- upvalues: TableUtil (copy), u2 (copy)
                    local v22 = TableUtil.Copy(p21.Stats, true);
                    local Player = p21.Player;
                    local v23 = Player.Data.Skin:GetAttribute("UnusualHueId");
                    local v24;

                    if v23 then
                        v24 = u2[v23];

                        if v24 then
                            local v25;

                            if v24 then
                                v25 = not (v24.ExcludedUsers and table.find(v24.ExcludedUsers, Player.UserId));
                            else
                                v25 = false;
                            end;

                            if not v25 then
                                v24 = nil;
                            end;
                        else
                            v24 = nil;
                        end;
                    else
                        v24 = nil;
                    end;

                    v22.PoseMusic = v24 and v24.PoseMusic or nil;

                    return v22;
                end
            }
        }
    },
    Sounds = {
        Radiance = {
            Looped = true,
            SoundId = 73792049935440,
            PlaybackSpeed = 1,
            Volume = 1.8
        },
        Overwrite_Pose = {
            Looped = true,
            SoundId = 75842745434833,
            Volume = 4
        }
    },
    Metadata = {
        PostRig = function(p26) -- Line: 128, Name: PostRig
            -- upvalues: RunService (copy), u2 (copy)
            local Player = p26.Player;
            local _ = p26.Character;

            if not (RunService:IsServer() and Player) then
                return;
            end;

            local v27 = Player.Data.Skin:GetAttribute("UnusualHueId");
            local v28;

            if v27 then
                v28 = u2[v27];

                if v28 then
                    local v29;

                    if v28 then
                        v29 = not (v28.ExcludedUsers and table.find(v28.ExcludedUsers, Player.UserId));
                    else
                        v29 = false;
                    end;

                    if not v29 then
                        v28 = nil;
                    end;
                else
                    v28 = nil;
                end;
            else
                v28 = nil;
            end;

            if v28 then
            end;
        end
    }
};