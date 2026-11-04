 

 

local script_Parent = script.Parent;
local player = script_Parent.player;
local _ = script_Parent.region_load;
local v1 = workspace:GetAttribute("data_allow") or false;

if workspace:GetAttribute("gamemode") then
    player.Visible = not v1;
end;

workspace:GetAttributeChangedSignal("data_allow"):Connect(function() -- Line: 12
    -- upvalues: player (copy)
    player.Visible = not workspace:GetAttribute("data_allow");
end);

if workspace:GetAttribute("region_loading") then
    player.Visible = not workspace:GetAttribute("region_loading");
end;

workspace:GetAttributeChangedSignal("region_loading"):Connect(function() -- Line: 20
    -- upvalues: player (copy)
    player.Visible = workspace:GetAttribute("region_loading") or false;
end);