  

local table_clone_ret = table.clone(require(script.Parent.Default));
table_clone_ret.PositionChoices = { "CFR", "CFL", "LW", "LM", "RW", "RM", "CM", "GK" };
table_clone_ret.LobbyNPCs.ProServers = false;
table_clone_ret.LobbyNPCs.NormalServers = true;

return table_clone_ret;