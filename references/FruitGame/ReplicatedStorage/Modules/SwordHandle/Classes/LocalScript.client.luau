 

local v1 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
for v2, v3 in pairs(v1) do
    warn(v2)
    if v3.swingSFX then
        for v4 = 1, #v3.swingSFX do
            local v5 = v3.swingSFX[v4]
            local v6 = Instance.new("Sound")
            v6.Name = v5
            v6.SoundId = v5
            v6.Parent = game.ReplicatedStorage.Modules.SwordHandle.SwordInfo
        end
    end
    if v3.hitSounds then
        for v7 = 1, #v3.hitSounds do
            local v8 = v3.hitSounds[v7]
            local v9 = Instance.new("Sound")
            v9.Name = v8
            v9.SoundId = v8
            v9.Parent = game.ReplicatedStorage.Modules.SwordHandle.SwordInfo
        end
    end
end