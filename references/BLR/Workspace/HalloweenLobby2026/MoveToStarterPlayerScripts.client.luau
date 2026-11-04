  

local Daghost = workspace.HalloweenLobby.Daghost;
local v1 = Daghost.AnimationController:LoadAnimation(Daghost.Animation);
v1.Looped = true;
v1:Play();

for _, child in workspace.HalloweenLobby:GetChildren() do
    if child.Name == "battt" then
        local v2 = child.AnimationController:LoadAnimation(child.Animation);
        v2.Looped = true;
        v2:Play();
    end;
end;