 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Packet = require(ReplicatedStorage.forum.Packet);
local _ = {
    {
        Age = Packet.NumberF16,
        Position = Packet.Vector3F24,
        Velocity = Packet.Vector3F24,
        Rotation = Packet.CFrameF24U8
    }
};

return {
    getDailyQuests = Packet("DailyQuestData"):Response({
        {
            Id = Packet.NumberU8,
            Progress = { Packet.NumberU8 },
            Claimed = Packet.Boolean8
        }
    }),
    getCurrentLimited = Packet("getCurrentLimited"):Response({
        Emote = {
            Name = Packet.String,
            Id = Packet.String
        },
        Mvp = {
            Name = Packet.String,
            Id = Packet.String
        },
        Mvp2 = {
            Name = Packet.String,
            Id = Packet.String
        }
    }),
    getLimitedShopItems = Packet("getLimitedShopItems"):Response({
        numMvps = Packet.NumberU8,
        numEmotes = Packet.NumberU8,
        mvps = {
            {
                Name = Packet.String,
                Id = Packet.String
            }
        },
        emotes = {
            {
                Name = Packet.String,
                Id = Packet.String
            }
        }
    })
};