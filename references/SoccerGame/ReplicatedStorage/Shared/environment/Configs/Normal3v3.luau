  

local table_clone_ret = table.clone(require(script.Parent.Default));
table_clone_ret.PositionChoices = { "CFL", "CFR", "CM" };
table_clone_ret.LobbyNPCs.ProServers = false;
table_clone_ret.LobbyNPCs.NormalServers = true;
table_clone_ret.LobbyNPCs.Quests3v3 = true;
table_clone_ret.MaxParty = 3;

return table_clone_ret;