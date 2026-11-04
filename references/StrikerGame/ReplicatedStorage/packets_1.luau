 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("@game/ReplicatedStorage/Network/NetworkSystem");
local v2 = require("@game/ReplicatedStorage/Network/NetworkPacket");
local v3 = require("@game/ReplicatedStorage/Network/SyncSystem");
local limits = v1.limits;
limits.maxBytesPerSecond = 200000;
limits.maxPacketsPerSecond = 1000;
limits.defaultPacketRate = 20;
limits.burstSeconds = 1.5;
v1.start();
v3.start();
local v4 = {};
local v5 = {
    rate = 260,
    burst = 300
};
local v6 = {
    rate = 30,
    burst = 60
};

for _, child in ReplicatedStorage.client.starterPlayer.Mobile.Frame:GetChildren() do
    v4[child.Name] = v2.struct({
        v2.float32,
        v2.float32,
        v2.float32,
        v2.float64,
        v2.ref,
        v2.ref
    });
end;

local v7 = {};

for i, v in {
    bytenet_clientCFrame = {
        channel = "unreliable",
        schema = v2.struct({
            adjustedDirection = v2.vector,
            camCFrame = v2.cframe
        }),
        limit = v5
    },
    bytenet_p2pcli = {
        channel = "unreliable",
        schema = v2.struct({
            playerName = v2.string,
            cframe = v2.cframe
        })
    },
    bytenet_selectRole = {
        channel = "reliable",
        schema = v2.struct({
            index = v2.uint8,
            t = v2.string
        })
    },
    bytenet_use = {
        channel = "reliable",
        schema = v2.ref,
        limit = v5
    },
    bytenet_changeStyle = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_changeMvp = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_changeGoalEffect = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_changeTitle = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_changeCommentator = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_favoriteMvp = {
        channel = "reliable",
        schema = v2.struct({
            index = v2.string,
            value = v2.bool
        })
    },
    bytenet_changeSpecialTitle = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_previewMvp = {
        channel = "reliable",
        schema = v2.struct({
            mvp = v2.string,
            load = v2.bool
        })
    },
    bytenet_fieldSpectate = {
        channel = "reliable",
        schema = v2.bool
    },
    bytenet_changeSpectate = {
        channel = "reliable",
        schema = v2.bool
    },
    bytenet_replication = {
        channel = "reliable",
        schema = v2.struct({
            name = v2.string,
            content = v2.ref
        })
    },
    bytenet_quests = {
        channel = "reliable",
        schema = v2.struct({
            questAction = v2.string,
            questContent = v2.ref
        })
    },
    bytenet_replication2 = {
        channel = "reliable",
        schema = v2.struct({
            name = v2.string,
            action = v2.uint8,
            id = v2.uint16,
            content = v2.ref
        })
    },
    club_request = {
        channel = "reliable",
        schema = v2.struct({
            name = v2.string,
            content = v2.ref
        })
    },
    bytenet_changeEmote = {
        channel = "reliable",
        schema = v2.struct({
            emoteName = v2.string,
            emoteIndex = v2.uint8,
            emotePage = v2.optional(v2.uint8)
        })
    },
    bytenet_useEmote = {
        channel = "reliable",
        schema = v2.struct({
            emoteName = v2.string,
            method = v2.optional(v2.string),
            origin = v2.optional(v2.string)
        })
    },
    bytenet_luckyStyleSpinPurchase = {
        channel = "reliable",
        schema = v2.array(v2.string)
    },
    bytenet_giftCash = {
        channel = "reliable",
        schema = v2.array(v2.string)
    },
    bytenet_SkipDaily = {
        channel = "reliable",
        schema = v2.array(v2.string)
    },
    bytenet_refreshDaily = {
        channel = "reliable",
        schema = v2.array(v2.string)
    },
    bytenet_marketPromptGift = {
        channel = "reliable",
        schema = v2.array(v2.string)
    },
    bytenet_marketPromptBundle = {
        channel = "reliable",
        schema = v2.struct({
            id = v2.string,
            picks = v2.ref
        })
    },
    bytenet_buyRotationOption = {
        channel = "reliable",
        schema = v2.struct({
            index = v2.ref,
            topic = v2.string
        })
    },
    bytenet_marketPromptMasterySkip = {
        channel = "reliable",
        schema = v2.struct({
            id = v2.string,
            style = v2.string
        })
    },
    bytenet_seenBundle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_marketPrompt = {
        channel = "reliable",
        schema = v2.array(v2.string)
    },
    bytenet_gatedPrompt = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_buyPass = {
        channel = "reliable",
        schema = v2.array(v2.string)
    },
    bytenet_checkPass = {
        channel = "reliable",
        schema = v2.array(v2.string)
    },
    bytenet_settingChange = {
        channel = "reliable",
        schema = v2.struct({
            name = v2.string,
            value = v2.ref
        }),
        limit = v6
    },
    bytenet_AdvancedsettingChange = {
        channel = "reliable",
        schema = v2.struct({
            name = v2.string,
            value = v2.ref
        }),
        limit = v6
    },
    bytenet_mobilebuttonPositions = {
        channel = "reliable",
        schema = v2.struct(v4)
    },
    bytenet_useCode = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_isSubscribed = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_getCurrentPassRewards = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_epilepsyScreen = {
        channel = "reliable",
        schema = v2.bool
    },
    bytenet_sendRegion = {
        channel = "reliable",
        schema = v2.struct({
            mode = v2.string,
            region = v2.string
        })
    },
    bytenet_voting = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_pollVote = {
        channel = "reliable",
        schema = v2.struct({
            pollId = v2.string,
            choice = v2.uint8
        })
    },
    bytenet_server_list_refresh = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_custommoveset = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_sendcustomstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_sendcustomimportstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_sendsubmissionimportstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_newimportcustomstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_playcustomimportstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_addcustomimportstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_receivecustomstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_playcustomstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_addcustomstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_killskillbuilder = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_loadingFinished = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_sendsubmissionstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_playsubmissionstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_addsubmissionstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_playserverstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_deleteallserverstyle = {
        channel = "reliable",
        schema = v2.ref
    },
    bytenet_teleportGamemode = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_joinRouletteServer = {
        channel = "reliable",
        schema = v2.struct({
            mode = v2.string,
            id = v2.string
        })
    },
    bytenet_quickjoinRouletteServer = {
        channel = "reliable",
        schema = v2.struct({
            mode = v2.string,
            region = v2.string,
            selected_gamemodes = v2.string
        })
    },
    bytenet_convertCashToStyle = {
        channel = "reliable",
        schema = v2.struct({
            sum = v2.int32,
            type = v2.string
        })
    },
    bytenet_BuyEventPassTier = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_canRanked = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_findBall = {
        channel = "reliable",
        schema = v2.nothing,
        limit = v5
    },
    bytenet_styleSpin = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_goaleffectSpin = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_LuckyStyleSpin = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_mvpSpin = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_emoteSpin = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_titleSpin = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_commentatorSpin = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_freeRewardClaim = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_MoveDirection = {
        channel = "unreliable",
        schema = v2.vector
    },
    bytenet_hitboxCast = {
        channel = "unreliable",
        schema = v2.buffer
    },
    bytenet_hitboxLive = {
        channel = "unreliable",
        schema = v2.buffer
    },
    bytenet_hitboxPing = {
        channel = "unreliable",
        schema = v2.uint8
    },
    bytenet_requestPlaytime = {
        channel = "reliable",
        schema = v2.nothing
    },
    bytenet_readMasteryTiers = {
        channel = "reliable",
        schema = v2.string
    },
    bytenet_playtimeData = {
        channel = "reliable",
        schema = v2.struct({
            playtime = v2.uint32,
            matchtime = v2.uint32,
            mastery = v2.map(v2.string, v2.struct({
                playtime = v2.uint32,
                goals = v2.uint32,
                assists = v2.uint32,
                wins = v2.uint32,
                positions_played = v2.map(v2.string, v2.uint32),
                extras = v2.map(v2.string, v2.uint32),
                daily = v2.optional(v2.array(v2.struct({
                    i = v2.string,
                    v = v2.uint8,
                    f = v2.bool
                }))),
                xp = v2.optional(v2.uint16),
                tier = v2.optional(v2.uint8),
                last_tier = v2.optional(v2.uint8)
            })),
            positions_played = v2.map(v2.string, v2.uint32)
        })
    },
    bytenet_ballControlInput = {
        channel = "unreliable",
        schema = v2.struct({
            wishDir = v2.vector,
            look = v2.vector,
            speedMult = v2.float32,
            flags = v2.uint8
        }),
        limit = v5
    },
    bytenet_mindControlBubble = {
        channel = "reliable",
        schema = v2.struct({
            text = v2.string,
            targetUserId = v2.uint32,
            messageId = v2.string
        })
    },
    bytenet_noWeirdo = {
        channel = "reliable",
        schema = v2.float64
    },
    bytenet_retrievePlayerData = {
        channel = "reliable",
        schema = v2.struct({
            request = v2.string,
            value = v2.ref
        })
    }
} do
    local limit = v.limit;
    local v8;

    if limit then
        v8 = limit.rate;
    else
        v8 = nil;
    end;

    local v9;

    if limit then
        v9 = limit.burst;
    else
        v9 = nil;
    end;

    v7[i] = v2.define(i, v.channel, v.schema, v8, v9);
end;

return v7;