 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local emoteWiki = require(ReplicatedStorage.emoteWiki);
local replication = require(ReplicatedStorage.client.replication);
local trove = require(ReplicatedStorage.forum.trove);
local CFrame_new_ret = CFrame.new(4.525, 0, 0);

return function(p1: userdata, p2: userdata) -- Line: 9
    -- upvalues: emoteWiki (copy), trove (copy), ReplicatedStorage (copy), CFrame_new_ret (copy), replication (copy)
    local Victory = emoteWiki.Victory;
    local v3 = trove.new();
    v3:AttachToInstance(p1);
    local v4 = ReplicatedStorage.Resources.Rig:Clone();
    v4.Parent = workspace.Effects;
    v4:PivotTo(p1:GetPivot() * CFrame_new_ret);
    v3:Add(v4);

    if Victory.duoAnimation then
        v4.Humanoid:LoadAnimation(Victory.duoAnimation):Play(0);
    end;

    if replication.VictoryEmote then
        replication.VictoryEmote(p1, v4, p2);
    end;
end;